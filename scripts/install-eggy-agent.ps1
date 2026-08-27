[CmdletBinding()]
param(
    [string]$WorkspaceRoot = (Get-Location).Path,

    [string]$ProjectPath,

    [ValidateSet('Single', 'Multiplayer')]
    [string]$PlayerMode,

    [ValidateSet('Auto', 'Codex', 'OpenCode', 'ZCode')]
    [string]$Agent = 'Auto',

    [ValidateSet('Project', 'Global')]
    [string]$Scope = 'Project',

    [ValidateSet('Auto', 'common', 'map-origin', 'map-world', 'tooling', 'full')]
    [string]$Profile = 'Auto',

    [switch]$IncludeOptional,
    [switch]$NoRules
)

$ErrorActionPreference = 'Stop'
$packageRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

function Get-ProjectDocumentPath {
    param(
        [Parameter(Mandatory = $true)][string]$Project,
        [Parameter(Mandatory = $true)][string]$Name
    )

    $rootCandidate = Join-Path $Project $Name
    $docsCandidate = Join-Path (Join-Path $Project 'docs') $Name
    if (Test-Path -LiteralPath $rootCandidate -PathType Leaf) { return $rootCandidate }
    if (Test-Path -LiteralPath $docsCandidate -PathType Leaf) { return $docsCandidate }
    return $null
}

function New-ProjectDocuments {
    param(
        [Parameter(Mandatory = $true)][string]$Project,
        [Parameter(Mandatory = $true)][string]$Edition,
        [Parameter(Mandatory = $true)][string]$Mode
    )

    $created = @()
    $definitions = @(
        @('需求文档.md', '需求文档模板.md'),
        @('开发计划.md', '开发计划模板.md'),
        @('资产清单.md', '资产清单模板.md'),
        @('开发日志.md', '开发日志模板.md')
    )
    foreach ($definition in $definitions) {
        if (Get-ProjectDocumentPath -Project $Project -Name $definition[0]) { continue }
        $destination = Join-Path (Join-Path $Project 'docs') $definition[0]
        $template = Join-Path (Join-Path $packageRoot 'templates') $definition[1]
        $content = (Get-Content -LiteralPath $template -Raw -Encoding UTF8).
            Replace('{{PROJECT_NAME}}', (Split-Path $Project -Leaf)).
            Replace('{{PLAYER_MODE}}', $(if ($Mode -eq 'Multiplayer') { '多人地图' } else { '单人地图' })).
            Replace('{{EDITION}}', (Get-EggyEditionLabel -Edition $Edition))
        Write-EggyUtf8File -Path $destination -Content $content
        $created += $destination
    }

    $readmePath = Join-Path $Project 'README.md'
    if (-not (Test-Path -LiteralPath $readmePath -PathType Leaf)) {
        $template = Join-Path (Join-Path $packageRoot 'templates') '项目README模板.md'
        $content = (Get-Content -LiteralPath $template -Raw -Encoding UTF8).
            Replace('{{PROJECT_NAME}}', (Split-Path $Project -Leaf)).
            Replace('{{PLAYER_MODE}}', $(if ($Mode -eq 'Multiplayer') { '多人地图' } else { '单人地图' })).
            Replace('{{EDITION}}', (Get-EggyEditionLabel -Edition $Edition))
        Write-EggyUtf8File -Path $readmePath -Content $content
        $created += $readmePath
    }
    return @($created)
}

function Assert-SkillCompatibility {
    param(
        [Parameter(Mandatory = $true)][object]$Catalog,
        [Parameter(Mandatory = $true)][string[]]$SkillNames,
        [Parameter(Mandatory = $true)][string]$Agent,
        [string]$Domain,
        [string]$Edition
    )

    foreach ($name in @($SkillNames | Sort-Object -Unique)) {
        $record = Get-EggySkillRecord -Catalog $Catalog -Name $name
        if (@($record.hosts) -notcontains $Agent) {
            throw "技能不支持当前宿主 $Agent：$name"
        }
        if ($Domain -and @($record.domains) -notcontains $Domain) {
            throw "技能不属于当前任务域 $Domain：$name"
        }
        if ($Edition -and [string]$record.editions -and @($record.editions) -notcontains $Edition) {
            throw "技能不支持当前编辑器版本 $Edition：$name"
        }
    }
}

function Assert-NoLegacySkillDuplicates {
    param(
        [Parameter(Mandatory = $true)][object]$Descriptor,
        [Parameter(Mandatory = $true)][object]$State
    )

    $roots = @()
    if ($Descriptor.Scope -eq 'Project') {
        $roots += Join-Path $Descriptor.WorkspaceRoot '.opencode\skills'
        $roots += Join-Path $Descriptor.WorkspaceRoot '.codex\skills'
        if ($Descriptor.StateKey -eq 'zcode') { $roots += Join-Path $Descriptor.WorkspaceRoot '.agents\skills' }
    }
    foreach ($root in $roots) {
        foreach ($name in @(Get-EggyManagedSkillNamesFromState -State $State)) {
            $candidate = Join-Path $root $name
            if (Test-Path -LiteralPath $candidate -PathType Container) {
                throw "发现旧位置中的同名技能：$candidate。为避免代理加载两个版本，安装已停止；请先人工备份并处理。"
            }
        }
    }
}

function Assert-StateContext {
    param(
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][object]$Descriptor
    )

    if ([string]$State.scope -ne $Descriptor.Scope) {
        throw "安装状态范围与本次操作不一致：$($State.scope) / $($Descriptor.Scope)"
    }
    if ([string]$State.skillRootRelative -ne [string]$Descriptor.SkillRootRelative) {
        throw "安装状态宿主目录与本次操作不一致：$($State.skillRootRelative) / $($Descriptor.SkillRootRelative)"
    }
    if ([string]$State.installBaseRoot -and
        -not (ConvertTo-EggyFullPath -Path ([string]$State.installBaseRoot)).Equals(
            (ConvertTo-EggyFullPath -Path $Descriptor.BaseRoot),
            [System.StringComparison]::OrdinalIgnoreCase
        )) {
        throw '安装状态的安装根目录与当前宿主不一致。'
    }
}

function Assert-RegisteredStateRules {
    param(
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][string]$Workspace,
        [Parameter(Mandatory = $true)][object[]]$Projects
    )

    if (-not [bool]$State.rulesEnabled) { return }
    $rootPath = Join-Path $Workspace 'AGENTS.md'
    $rootBlock = Get-EggyManagedBlock -Path $rootPath
    if (-not $rootBlock -or (Get-EggyTextSha256 -Text $rootBlock) -ne [string]$State.rootRuleBlockSha256) {
        throw '总工作区受管规则块被改过、缺失或损坏，安装已停止。'
    }
    foreach ($project in $Projects) {
        $path = Join-Path ([string]$project.path) 'AGENTS.md'
        $block = Get-EggyManagedBlock -Path $path
        if (-not $block -or (Get-EggyTextSha256 -Text $block) -ne [string]$project.projectRuleBlockSha256) {
            throw "地图受管规则块被改过、缺失或损坏，安装已停止：$path"
        }
    }
}

function Merge-ManagedRecords {
    param(
        [object[]]$OldRecords = @(),
        [object[]]$NewRecords = @()
    )

    $map = @{}
    foreach ($entry in @($OldRecords + $NewRecords)) {
        $target = [string]$entry.target
        if (-not $target) { continue }
        $map[$target] = [pscustomobject]@{
            sourcePath = [string]$entry.sourcePath
            target = $target
            sha256 = [string]$entry.sha256
            kind = [string]$(if ($entry.kind) { $entry.kind } else { 'legacy' })
            skill = [string]$(if ($entry.skill) { $entry.skill } else { '' })
        }
    }
    return @($map.Values | Sort-Object target)
}

function Get-PathForRecord {
    param(
        [Parameter(Mandatory = $true)][object]$Descriptor,
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][object]$Record
    )
    return Get-EggyInstalledTargetPath -Descriptor $Descriptor -State $State -Target ([string]$Record.target)
}

$script:ResolvedWorkspace = Resolve-EggyDirectory -Path $WorkspaceRoot -Label '总工作区目录'
$script:ResolvedAgent = Resolve-EggyAgentName -Agent $Agent
$script:Catalog = Get-EggyCatalog -PackageRoot $packageRoot

if ($Scope -eq 'Global' -and $ProjectPath) {
    throw '全局安装不接受 ProjectPath（地图工程路径）；请只安装公共工具技能。'
}
if ($Scope -eq 'Project' -and $ProjectPath) {
    $script:ProjectRoot = Resolve-EggyDirectory -Path $ProjectPath -Label '地图工程目录'
    if (-not (Test-EggyPathInside -Root $script:ResolvedWorkspace -Candidate $script:ProjectRoot)) {
        throw '地图工程必须位于总工作区目录内。'
    }
    if (-not $PlayerMode) {
        throw '安装地图技能前必须说明地图是 Single（单人）还是 Multiplayer（多人）。'
    }
    $script:ProjectEdition = Get-EggyProjectEdition -ProjectPath $script:ProjectRoot
    $script:Domain = 'map'
} else {
    $script:ProjectRoot = $null
    $script:ProjectEdition = $null
    $script:Domain = 'tooling'
    if ($PlayerMode) { throw '辅助工具安装不需要 PlayerMode（单人或多人设置）。' }
}

$script:Descriptor = Get-EggyInstallDescriptor -WorkspaceRoot $script:ResolvedWorkspace -Agent $script:ResolvedAgent -Scope $Scope -Catalog $script:Catalog
$selectedProfile = Get-EggyProfileForProject -RequestedProfile $Profile -ProjectPath $script:ProjectRoot -Edition $script:ProjectEdition
if ($script:ProjectRoot -and $selectedProfile -eq 'tooling') {
    throw '地图工程不能使用 tooling（辅助工具）档案。'
}
if (-not $script:ProjectRoot -and $selectedProfile -like 'map-*') {
    throw '辅助工具安装不能使用地图档案。'
}

$requestedSkills = @(Get-EggyProfileSkillNames -Catalog $script:Catalog -Profile $selectedProfile)
$requestedProfiles = @($selectedProfile)
if ($IncludeOptional) {
    $optionalProfile = Get-EggyOptionalProfileName -Domain $script:Domain -Edition $(if ($script:ProjectEdition) { $script:ProjectEdition } else { 'Origin' })
    $requestedSkills += @(Get-EggyProfileSkillNames -Catalog $script:Catalog -Profile $optionalProfile)
    $requestedProfiles += $optionalProfile
}
Assert-SkillCompatibility -Catalog $script:Catalog -SkillNames $requestedSkills -Agent $script:ResolvedAgent -Domain $script:Domain -Edition $script:ProjectEdition

$stateInfo = $null
if (Test-Path -LiteralPath $script:Descriptor.StatePath -PathType Leaf) {
    $stateInfo = Read-EggyInstallState -Descriptor $script:Descriptor
    $state = $stateInfo.State
    Assert-StateContext -State $state -Descriptor $script:Descriptor
    Assert-NoLegacySkillDuplicates -Descriptor $script:Descriptor -State $state
    $registeredProjects = @($state.projects)
    foreach ($project in $registeredProjects) {
        if ($Scope -eq 'Project' -and -not (Test-EggyPathInside -Root $script:ResolvedWorkspace -Candidate ([string]$project.path))) {
            throw "已登记地图位于总工作区之外：$($project.path)"
        }
        if (-not (Test-Path -LiteralPath ([string]$project.path) -PathType Container)) {
            throw "已登记地图不存在：$($project.path)"
        }
        $actualEdition = Get-EggyProjectEdition -ProjectPath ([string]$project.path)
        if ([string]$project.edition -and [string]$project.edition -ne $actualEdition) {
            throw "地图版本与安装记录不一致，拒绝自动改写：$($project.path)"
        }
    }
    Assert-RegisteredStateRules -State $state -Workspace $script:ResolvedWorkspace -Projects $registeredProjects
    $oldFileConflicts = @(Test-EggyInstalledFiles -Descriptor $script:Descriptor -State $state)
    if ($oldFileConflicts.Count -gt 0) {
        throw "已安装受管文件被改过、缺失或损坏：$(($oldFileConflicts | Sort-Object -Unique) -join '、')"
    }
    if ([string]$state.version -ne (Get-EggyPackageVersion -PackageRoot $packageRoot)) {
        throw '总工作区已经安装过其他版本，请先使用新版升级脚本完成升级。'
    }
} else {
    $state = $null
    $registeredProjects = @()
    if ($Scope -eq 'Project') {
        foreach ($root in @(
            (Join-Path $script:ResolvedWorkspace '.agents\skills'),
            (Join-Path $script:ResolvedWorkspace '.opencode\skills'),
            (Join-Path $script:ResolvedWorkspace '.codex\skills'),
            (Join-Path $script:ResolvedWorkspace '.zcode\skills')
        )) {
            foreach ($name in @($requestedSkills | Sort-Object -Unique)) {
                if (Test-Path -LiteralPath (Join-Path $root $name) -PathType Container) {
                    throw "发现未登记的同名旧技能：$(Join-Path $root $name)。请先人工备份并处理，安装器不会静默覆盖。"
                }
            }
        }
    }
}

$currentVersion = Get-EggyPackageVersion -PackageRoot $packageRoot
$newSkills = @($requestedSkills)
if ($state) { $newSkills += @(Get-EggyManagedSkillNamesFromState -State $state) }
$newSkills = @($newSkills | Sort-Object -Unique)
Assert-SkillCompatibility -Catalog $script:Catalog -SkillNames $newSkills -Agent $script:ResolvedAgent -Domain $(if ($script:ProjectRoot) { $null } else { 'tooling' }) -Edition $null
$desiredRecords = @(Get-EggyManagedRecords -PackageRoot $packageRoot -Catalog $script:Catalog -SkillName $newSkills -Descriptor $script:Descriptor)
$pathState = if ($state) { $state } else {
    [pscustomobject]@{
        enabled = $true
        skillRootRelative = $script:Descriptor.SkillRootRelative
        disabledRootRelative = $script:Descriptor.DisabledRootRelative
    }
}

if ($state -and -not $stateInfo.WasMigrated -and [string]$state.version -eq $currentVersion) {
    $oldByTargetForNoOp = @{}
    foreach ($entry in @($state.managedFiles)) { $oldByTargetForNoOp[[string]$entry.target] = [string]$entry.sha256 }
    $sameManagedFiles = @($state.managedFiles).Count -eq $desiredRecords.Count
    if ($sameManagedFiles) {
        foreach ($entry in $desiredRecords) {
            if (-not $oldByTargetForNoOp.ContainsKey([string]$entry.target) -or
                $oldByTargetForNoOp[[string]$entry.target] -ne [string]$entry.sha256) {
                $sameManagedFiles = $false
                break
            }
        }
    }
    $registeredCurrent = $false
    if ($script:ProjectRoot) {
        $registeredCurrent = @(Get-EggyStateProject -State $state -ProjectPath $script:ProjectRoot).Count -eq 1
    } else {
        $registeredCurrent = @($state.projects).Count -eq 0
    }
    if ($sameManagedFiles -and $registeredCurrent) {
        Write-Output "安装结果：版本 $currentVersion、档案和受管文件均已存在，无需重复安装。"
        Write-Output "技能目录：$($script:Descriptor.SkillRoot)"
        exit 0
    }
}

if ($state) {
    $oldByTarget = @{}
    foreach ($entry in @($state.managedFiles)) { $oldByTarget[[string]$entry.target] = $entry }
    foreach ($entry in $desiredRecords) {
        $destination = Get-PathForRecord -Descriptor $script:Descriptor -State $pathState -Record $entry
        if (Test-Path -LiteralPath $destination -PathType Container) {
            throw "安装目标是目录，尚未修改任何内容：$destination"
        }
        if ((Test-Path -LiteralPath $destination -PathType Leaf) -and -not $oldByTarget.ContainsKey([string]$entry.target)) {
            if ((Get-EggySha256 -Path $destination) -ne ([string]$entry.sha256).ToLowerInvariant()) {
                throw "安装目标已有未登记文件，尚未修改任何内容：$destination"
            }
        }
        if ($oldByTarget.ContainsKey([string]$entry.target) -and
            (Get-EggySha256 -Path $destination) -ne ([string]$oldByTarget[[string]$entry.target].sha256).ToLowerInvariant()) {
            throw "已安装目标在写入前发生变化：$destination"
        }
    }
}

if ($script:ProjectRoot) {
    [void](Initialize-EggyMapRepository -ProjectRoot $script:ProjectRoot -PackageRoot $packageRoot)
}

$backupPaths = @($script:Descriptor.StatePath)
if ($stateInfo -and $stateInfo.Path -ne $script:Descriptor.StatePath) { $backupPaths += $stateInfo.Path }
$backupPaths += Join-Path $script:Descriptor.BaseRoot 'AGENTS.md'
if ($script:ProjectRoot) { $backupPaths += Join-Path $script:ProjectRoot 'AGENTS.md' }
foreach ($entry in $desiredRecords) { $backupPaths += Get-PathForRecord -Descriptor $script:Descriptor -State $pathState -Record $entry }
$backupRoot = New-EggyBackup -WorkspaceRoot $script:Descriptor.BaseRoot -Path $backupPaths -Reason $(if ($state) { 'register' } else { 'install' })
$createdDocuments = @()

try {
    foreach ($entry in $desiredRecords) {
        $source = Join-Path $packageRoot ([string]$entry.sourcePath).Replace('/', '\')
        $destination = Get-PathForRecord -Descriptor $script:Descriptor -State $pathState -Record $entry
        $currentHash = Get-EggySha256 -Path $destination
        if ($currentHash -ne ([string]$entry.sha256).ToLowerInvariant()) {
            Copy-EggyFileAtomic -Source $source -Destination $destination
        }
    }

    $rulesEnabled = if ($state) { [bool]$state.rulesEnabled } else { $false }
    $rootRuleHash = if ($state) { [string]$state.rootRuleBlockSha256 } else { '' }
    if ($script:ProjectRoot -and -not $state -and -not $NoRules) {
        $rootBody = Get-EggyRuleBody -TemplatePath (Join-Path $packageRoot 'templates\根规则受管块.md') -WorkspaceRoot $script:ResolvedWorkspace
        $rootBlock = Set-EggyManagedBlock -Path (Join-Path $script:ResolvedWorkspace 'AGENTS.md') -Body $rootBody
        $rootRuleHash = Get-EggyTextSha256 -Text $rootBlock
        $rulesEnabled = $true
    }

    $newProjectRecord = $null
    if ($script:ProjectRoot) {
        $existingProject = if ($state) { @(Get-EggyStateProject -State $state -ProjectPath $script:ProjectRoot) } else { @() }
        if ($existingProject.Count -gt 1) { throw '安装状态中同一张地图出现多次，拒绝继续追加。' }
        if ($existingProject.Count -eq 1) {
            if ([string]$existingProject[0].edition -ne $script:ProjectEdition -or
                [string]$existingProject[0].playerMode -ne $PlayerMode) {
                throw '这张地图已经登记，但版本或单人/多人设置与本次输入不一致。'
            }
            $newProjectRecord = $existingProject[0]
        } else {
            $projectRuleHash = ''
            if ($rulesEnabled) {
                $projectBody = Get-EggyRuleBody -TemplatePath (Join-Path $packageRoot 'templates\项目规则受管块.md') `
                    -WorkspaceRoot $script:ResolvedWorkspace -ProjectPath $script:ProjectRoot `
                    -PlayerMode $PlayerMode -Edition $script:ProjectEdition
                $projectBlock = Set-EggyManagedBlock -Path (Join-Path $script:ProjectRoot 'AGENTS.md') -Body $projectBody
                $projectRuleHash = Get-EggyTextSha256 -Text $projectBlock
            }
            $createdDocuments = @(New-ProjectDocuments -Project $script:ProjectRoot -Edition $script:ProjectEdition -Mode $PlayerMode)
            $newProjectRecord = [pscustomobject]@{
                path = $script:ProjectRoot
                edition = $script:ProjectEdition
                playerMode = $PlayerMode
                profile = $(if ($selectedProfile -like '*optional') { $(if ($script:ProjectEdition -eq 'World') { 'map-world' } else { 'map-origin' }) } else { $selectedProfile })
                projectRuleBlockSha256 = $projectRuleHash
                userOwnedDocuments = @($createdDocuments | ForEach-Object { Get-EggyRelativePath -Root $script:ResolvedWorkspace -Path $_ })
            }
        }
    }

    $allProjects = @()
    if ($state) { $allProjects += @($state.projects) }
    if ($newProjectRecord) {
        $existingIndex = -1
        for ($index = 0; $index -lt $allProjects.Count; $index++) {
            if ((ConvertTo-EggyFullPath -Path ([string]$allProjects[$index].path)).Equals($script:ProjectRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
                $existingIndex = $index
                break
            }
        }
        if ($existingIndex -ge 0) { $allProjects[$existingIndex] = $newProjectRecord } else { $allProjects += $newProjectRecord }
    }

    $profiles = @()
    if ($state) { $profiles += @($state.profiles) }
    $profiles += $requestedProfiles
    $profiles = @($profiles | ForEach-Object { [string]$_ } | Where-Object { $_ } | Sort-Object -Unique)
    $agents = @()
    if ($state) { $agents += @($state.agents) }
    $agents += $script:ResolvedAgent
    $agents = @($agents | ForEach-Object { [string]$_ } | Where-Object { $_ } | Sort-Object -Unique)
    $oldRecordsForMerge = @()
    if ($state) { $oldRecordsForMerge = @($state.managedFiles) }
    $mergedRecords = @(Merge-ManagedRecords -OldRecords $oldRecordsForMerge -NewRecords $desiredRecords)

    $newState = [pscustomobject]@{
        schemaVersion = 4
        package = 'eggy-agent-skills'
        version = $currentVersion
        installedAt = $(if ($state -and $state.installedAt) { [string]$state.installedAt } else { (Get-Date).ToString('o') })
        updatedAt = (Get-Date).ToString('o')
        workspaceRoot = $script:ResolvedWorkspace
        installBaseRoot = $script:Descriptor.BaseRoot
        agent = $(if ($state -and $state.agent) { [string]$state.agent } else { $script:ResolvedAgent })
        agents = $agents
        scope = $Scope
        stateKey = $script:Descriptor.StateKey
        profile = $(if ($state -and $state.profile) { [string]$state.profile } else { $selectedProfile })
        profiles = $profiles
        enabled = $(if ($state) { [bool]$state.enabled } else { $true })
        rulesEnabled = $rulesEnabled
        skillRootRelative = $script:Descriptor.SkillRootRelative
        disabledRootRelative = $script:Descriptor.DisabledRootRelative
        selectedSkills = @($mergedRecords | Where-Object { $_.kind -eq 'skill' } | ForEach-Object { [string]$_.skill } | Where-Object { $_ } | Sort-Object -Unique)
        managedFiles = $mergedRecords
        rootRuleBlockSha256 = $rootRuleHash
        projects = @($allProjects)
        sourceCommit = Get-EggySourceCommit -PackageRoot $packageRoot
        latestBackup = $backupRoot
        templateUpgradeReport = $(if ($state) { [string]$state.templateUpgradeReport } else { '' })
    }
    Write-EggyJson -Path $script:Descriptor.StatePath -Value $newState
} catch {
    Restore-EggyBackupInternal -WorkspaceRoot $script:Descriptor.BaseRoot -BackupRoot $backupRoot
    foreach ($document in $createdDocuments) {
        if (Test-Path -LiteralPath $document -PathType Leaf) { Remove-Item -LiteralPath $document -Force }
    }
    throw
}

$editionText = if ($script:ProjectEdition) { Get-EggyEditionLabel -Edition $script:ProjectEdition } else { '辅助工具' }
$skillCount = @($newState.selectedSkills).Count
if ($state) {
    Write-Output "安装结果：已把 $editionText 档案登记到 $($script:ResolvedAgent)，当前受管技能 $skillCount 项。"
} else {
    Write-Output "安装结果：已安装 $editionText 档案到 $($script:ResolvedAgent)，当前受管技能 $skillCount 项。"
}
Write-Output "技能目录：$($script:Descriptor.SkillRoot)"
Write-Output "安装状态：$($script:Descriptor.StatePath)"
Write-Output "备份位置：$backupRoot"
if ($script:ProjectRoot) {
    Write-Output "地图版本：$editionText；游玩模式：$(if ($PlayerMode -eq 'Multiplayer') { '多人' } else { '单人' })"
    Write-Output '地图已使用独立 Git（版本记录）仓库；初始基线不代表玩法已经通过试玩。'
}
Write-Output '请用代理打开总工作区并新建会话；已经加载旧技能的会话不会自动卸载旧内容。'
