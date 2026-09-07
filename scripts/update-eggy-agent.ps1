[CmdletBinding()]
param(
    [string]$WorkspaceRoot = (Get-Location).Path,

    [string]$PackageRoot,

    [ValidateSet('Auto', 'Codex', 'OpenCode', 'ZCode')]
    [string]$Agent = 'Auto',

    [ValidateSet('Project', 'Global')]
    [string]$Scope = 'Project'
)

$ErrorActionPreference = 'Stop'
if (-not $PackageRoot) { $PackageRoot = Join-Path $PSScriptRoot '..' }
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

function Resolve-StateAgent {
    param(
        [Parameter(Mandatory = $true)][string]$Workspace,
        [Parameter(Mandatory = $true)][string]$RequestedAgent,
        [Parameter(Mandatory = $true)][string]$RequestedScope
    )

    if ($RequestedAgent -ne 'Auto') { return $RequestedAgent }
    if ($RequestedScope -eq 'Project') {
        $defaultState = Join-Path $Workspace '.eggy-agent\install-state.json'
        if (Test-Path -LiteralPath $defaultState -PathType Leaf) {
            $raw = Read-EggyJson -Path $defaultState
            $value = [string](Get-EggyPropertyValue -Object $raw -Name 'agent' -Default 'Codex')
            if (@('Codex', 'OpenCode', 'ZCode') -contains $value) { return $value }
        }
        $zcodeState = Join-Path $Workspace '.eggy-agent\install-state-zcode.json'
        if (Test-Path -LiteralPath $zcodeState -PathType Leaf) { return 'ZCode' }
        return 'Codex'
    }
    $globalRoot = Join-Path ([Environment]::GetFolderPath('UserProfile')) '.eggy-agent'
    $states = @(Get-ChildItem -LiteralPath $globalRoot -Filter 'install-state-global-*.json' -File -ErrorAction SilentlyContinue)
    if ($states.Count -eq 1) {
        $raw = Read-EggyJson -Path $states[0].FullName
        return [string](Get-EggyPropertyValue -Object $raw -Name 'agent' -Default 'Codex')
    }
    if ($states.Count -gt 1) { throw '发现多个全局技能安装状态，请明确指定 Agent（宿主）。' }
    return 'Codex'
}

function Assert-StateProjects {
    param(
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][object]$Descriptor
    )

    if ($Descriptor.Scope -eq 'Global' -and @($State.projects).Count -gt 0) {
        throw '全局技能状态不应登记地图工程。'
    }
    foreach ($project in @($State.projects)) {
        $path = Resolve-EggyDirectory -Path ([string]$project.path) -Label '已登记地图工程'
        if (-not (Test-EggyPathInside -Root $Descriptor.WorkspaceRoot -Candidate $path)) {
            throw "已登记地图位于总工作区之外：$path"
        }
        if ($path.Equals($Descriptor.WorkspaceRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw '共享技能不能安装到地图工程；已登记地图与总工作区重合，请先核对错误安装并迁移。尚未写入任何文件。'
        }
        $actualEdition = Get-EggyProjectEdition -ProjectPath $path
        if ([string]$project.edition -ne $actualEdition) {
            throw "地图版本与安装记录不一致，拒绝自动改写：$path"
        }
    }
}

function Assert-StateRules {
    param(
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][object]$Descriptor
    )

    if (-not [bool]$State.rulesEnabled) { return }
    $rootPath = Join-Path $Descriptor.WorkspaceRoot 'AGENTS.md'
    $rootBlock = Get-EggyManagedBlock -Path $rootPath
    if (-not $rootBlock -or (Get-EggyTextSha256 -Text $rootBlock) -ne [string]$State.rootRuleBlockSha256) {
        throw '总工作区受管规则块被改过、缺失或损坏，升级已停止。'
    }
    foreach ($project in @($State.projects)) {
        $path = Join-Path ([string]$project.path) 'AGENTS.md'
        $block = Get-EggyManagedBlock -Path $path
        if (-not $block -or (Get-EggyTextSha256 -Text $block) -ne [string]$project.projectRuleBlockSha256) {
            throw "地图受管规则块被改过、缺失或损坏，升级已停止：$path"
        }
    }
}

function Get-RecordDestination {
    param(
        [Parameter(Mandatory = $true)][object]$Descriptor,
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][object]$Record
    )
    return Get-EggyInstalledTargetPath -Descriptor $Descriptor -State $State -Target ([string]$Record.target)
}

function New-UpgradeReport {
    param(
        [Parameter(Mandatory = $true)][object]$OldState,
        [Parameter(Mandatory = $true)][object[]]$NewRecords,
        [Parameter(Mandatory = $true)][string]$Workspace
    )

    $oldMap = @{}
    foreach ($entry in @($OldState.managedFiles)) { $oldMap[[string]$entry.target] = [string]$entry.sha256 }
    $lines = @(
        '# 项目文档模板升级对比报告',
        '',
        "生成时间：$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')",
        "旧版本：$($OldState.version)",
        '',
        '> 项目长期文档属于用户。本次升级不会覆盖、创建或删除已有玩法文档。',
        '',
        '| 模板 | 旧指纹状态 | 新指纹状态 | 处理 |',
        '|---|---|---|---|'
    )
    foreach ($name in @('需求文档模板.md', '开发计划模板.md', '资产清单模板.md', '项目README模板.md', '开发日志模板.md')) {
        $target = '.eggy-agent/templates/' + $name
        $new = @($NewRecords | Where-Object { [string]$_.target -eq $target } | Select-Object -First 1)
        $oldStatus = if ($oldMap.ContainsKey($target)) { '已登记' } else { '旧包未登记' }
        $newStatus = if ($new.Count -eq 1) { '已登记' } else { '新包缺失' }
        $changed = if ($new.Count -eq 1 -and $oldMap.ContainsKey($target) -and $oldMap[$target] -eq [string]$new[0].sha256) { '未变化' } else { '有变化' }
        $lines += "| $name | $oldStatus | $newStatus | $changed；现有文档需人工比较 |"
    }
    foreach ($project in @($OldState.projects)) {
        $lines += @('', "## $([System.IO.Path]::GetFileName([string]$project.path))", '', '只更新受管规则区块，不改项目长期文档。')
    }
    return (($lines -join [Environment]::NewLine) + [Environment]::NewLine)
}

$script:Workspace = Resolve-EggyDirectory -Path $WorkspaceRoot -Label '总工作区目录'
if ($Scope -eq 'Project') {
    Assert-EggyWorkspaceOutsideMap -WorkspaceRoot $script:Workspace
}
$script:Package = Resolve-EggyDirectory -Path $PackageRoot -Label '新版公开包目录'
$script:ResolvedAgent = Resolve-StateAgent -Workspace $script:Workspace -RequestedAgent $Agent -RequestedScope $Scope
$script:Catalog = Get-EggyCatalog -PackageRoot $script:Package
$manifest = Assert-EggyPackageManifest -PackageRoot $script:Package
$script:Descriptor = Get-EggyInstallDescriptor -WorkspaceRoot $script:Workspace -Agent $script:ResolvedAgent -Scope $Scope -Catalog $script:Catalog
$stateInfo = Read-EggyInstallState -Descriptor $script:Descriptor
$state = $stateInfo.State
Assert-EggyStateContext -State $state -Descriptor $script:Descriptor
Assert-StateProjects -State $state -Descriptor $script:Descriptor
Assert-StateRules -State $state -Descriptor $script:Descriptor

$oldConflicts = @(Test-EggyInstalledFiles -Descriptor $script:Descriptor -State $state)
if ($oldConflicts.Count -gt 0) {
    Write-Output '升级结果：未修改任何文件。以下受管文件被改过、缺失或损坏：'
    $oldConflicts | ForEach-Object { Write-Output "  $_" }
    throw '请先审查这些差异，再决定保留本地修改还是恢复公开版。'
}

$selectedSkills = @(Get-EggyStateDesiredSkills -State $state -Catalog $script:Catalog)
foreach ($name in $selectedSkills) {
    $record = Get-EggySkillRecord -Catalog $script:Catalog -Name $name
    if (@($record.hosts) -notcontains $script:ResolvedAgent) { throw "新版技能不支持当前宿主：$name" }
}
$newRecords = @(Get-EggyManagedRecords -PackageRoot $script:Package -Catalog $script:Catalog -SkillName $selectedSkills -Descriptor $script:Descriptor)
$oldByTarget = @{}
foreach ($entry in @($state.managedFiles)) { $oldByTarget[[string]$entry.target] = $entry }
$newByTarget = @{}
foreach ($entry in $newRecords) { $newByTarget[[string]$entry.target] = $entry }

$preflightConflicts = @()
foreach ($entry in $newRecords) {
    $destination = Get-RecordDestination -Descriptor $script:Descriptor -State $state -Record $entry
    if (Test-Path -LiteralPath $destination -PathType Container) {
        $preflightConflicts += "目标是目录：$destination"
        continue
    }
    if ((Test-Path -LiteralPath $destination -PathType Leaf) -and -not $oldByTarget.ContainsKey([string]$entry.target)) {
        if ((Get-EggySha256 -Path $destination) -ne ([string]$entry.sha256).ToLowerInvariant()) {
            $preflightConflicts += "新包目标已有未登记文件：$destination"
        }
    }
}
foreach ($entry in @($state.managedFiles)) {
    if (-not $newByTarget.ContainsKey([string]$entry.target)) {
        $destination = Get-RecordDestination -Descriptor $script:Descriptor -State $state -Record $entry
        if (Test-Path -LiteralPath $destination -PathType Container) {
            $preflightConflicts += "待移除目标是目录：$destination"
        }
    }
}
if ($preflightConflicts.Count -gt 0) {
    $preflightConflicts | Sort-Object -Unique | ForEach-Object { Write-Output "升级冲突：$_" }
    throw '升级尚未修改任何文件。'
}

$sameFiles = $true
if (@($state.managedFiles).Count -ne $newRecords.Count) { $sameFiles = $false }
foreach ($entry in $newRecords) {
    if (-not $oldByTarget.ContainsKey([string]$entry.target) -or
        [string]$oldByTarget[[string]$entry.target].sha256 -ne [string]$entry.sha256) {
        $sameFiles = $false
        break
    }
}
if ($sameFiles -and [int]$state.schemaVersion -eq 4 -and [string]$state.version -eq [string]$manifest.version) {
    Write-Output "升级结果：当前已经是版本 $($manifest.version)，受管文件完整，无需更新。"
    exit 0
}

$backupPaths = @($stateInfo.Path, (Join-Path $script:Descriptor.StateRoot 'template-upgrade-report.md'))
if ([bool]$state.rulesEnabled) {
    $backupPaths += Join-Path $script:Descriptor.WorkspaceRoot 'AGENTS.md'
    foreach ($project in @($state.projects)) { $backupPaths += Join-Path ([string]$project.path) 'AGENTS.md' }
}

# 版本升级只备份会被替换或删除的文件；未变化的技能不随整包升级重复复制。
foreach ($entry in $newRecords) {
    $destination = Get-RecordDestination -Descriptor $script:Descriptor -State $state -Record $entry
    $needsWrite = -not (Test-Path -LiteralPath $destination -PathType Leaf)
    if (-not $needsWrite) {
        $needsWrite = (Get-EggySha256 -Path $destination) -ne ([string]$entry.sha256).ToLowerInvariant()
    }
    if ($needsWrite) { $backupPaths += $destination }
}
foreach ($entry in @($state.managedFiles | Where-Object { -not $newByTarget.ContainsKey([string]$_.target) })) {
    $destination = Get-RecordDestination -Descriptor $script:Descriptor -State $state -Record $entry
    if (Test-Path -LiteralPath $destination -PathType Leaf) { $backupPaths += $destination }
}
$backupRoot = New-EggyBackup -WorkspaceRoot $script:Descriptor.BaseRoot -Path $backupPaths -Reason 'update'

try {
    foreach ($entry in $newRecords) {
        $source = Join-Path $script:Package ([string]$entry.sourcePath).Replace('/', '\')
        $destination = Get-RecordDestination -Descriptor $script:Descriptor -State $state -Record $entry
        if ((Get-EggySha256 -Path $destination) -ne ([string]$entry.sha256).ToLowerInvariant()) {
            Copy-EggyFileAtomic -Source $source -Destination $destination
        }
    }
    foreach ($entry in @($state.managedFiles | Where-Object { -not $newByTarget.ContainsKey([string]$_.target) })) {
        $destination = Get-RecordDestination -Descriptor $script:Descriptor -State $state -Record $entry
        if (Test-Path -LiteralPath $destination -PathType Leaf) { Remove-Item -LiteralPath $destination -Force }
    }

    $rootHash = [string]$state.rootRuleBlockSha256
    $updatedProjects = @()
    if ([bool]$state.rulesEnabled) {
        $rootBody = Get-EggyRuleBody -TemplatePath (Join-Path $script:Package 'templates\根规则受管块.md') -WorkspaceRoot $script:Workspace
        $rootBlock = Set-EggyManagedBlock -Path (Join-Path $script:Workspace 'AGENTS.md') -Body $rootBody
        $rootHash = Get-EggyTextSha256 -Text $rootBlock
    }
    foreach ($project in @($state.projects)) {
        $projectHash = [string]$project.projectRuleBlockSha256
        if ([bool]$state.rulesEnabled) {
            $projectBody = Get-EggyRuleBody -TemplatePath (Join-Path $script:Package 'templates\项目规则受管块.md') `
                -WorkspaceRoot $script:Workspace -ProjectPath ([string]$project.path) `
                -PlayerMode ([string]$project.playerMode) -Edition ([string]$project.edition)
            $projectBlock = Set-EggyManagedBlock -Path (Join-Path ([string]$project.path) 'AGENTS.md') -Body $projectBody
            $projectHash = Get-EggyTextSha256 -Text $projectBlock
        }
        $updatedProjects += [pscustomobject]@{
            path = [string]$project.path
            edition = [string]$project.edition
            playerMode = [string]$project.playerMode
            profile = [string]$project.profile
            projectRuleBlockSha256 = $projectHash
            userOwnedDocuments = @($project.userOwnedDocuments)
        }
    }

    $reportPath = Join-Path $script:Descriptor.StateRoot 'template-upgrade-report.md'
    Write-EggyUtf8File -Path $reportPath -Content (New-UpgradeReport -OldState $state -NewRecords $newRecords -Workspace $script:Workspace)
    $newState = [pscustomobject]@{
        schemaVersion = 4
        package = 'eggy-agent-skills'
        version = [string]$manifest.version
        installedAt = [string]$state.installedAt
        updatedAt = (Get-Date).ToString('o')
        workspaceRoot = $script:Workspace
        installBaseRoot = $script:Descriptor.BaseRoot
        agent = [string]$state.agent
        agents = @($state.agents)
        scope = [string]$state.scope
        stateKey = [string]$script:Descriptor.StateKey
        profile = [string]$state.profile
        profiles = @($state.profiles)
        enabled = [bool]$state.enabled
        rulesEnabled = [bool]$state.rulesEnabled
        skillRootRelative = [string]$script:Descriptor.SkillRootRelative
        disabledRootRelative = [string]$script:Descriptor.DisabledRootRelative
        selectedSkills = @($selectedSkills)
        managedFiles = @($newRecords)
        rootRuleBlockSha256 = $rootHash
        projects = @($updatedProjects)
        sourceCommit = Get-EggySourceCommit -PackageRoot $script:Package
        latestBackup = $backupRoot
        templateUpgradeReport = Get-EggyRelativePath -Root $script:Descriptor.BaseRoot -Path $reportPath
    }
    Write-EggyJson -Path $stateInfo.Path -Value $newState
} catch {
    Restore-EggyBackupInternal -WorkspaceRoot $script:Descriptor.BaseRoot -BackupRoot $backupRoot
    throw
}

Write-Output "升级结果：已升级到版本 $($manifest.version)，受管技能 $(@($newState.selectedSkills).Count) 项，登记地图 $(@($newState.projects).Count) 张。"
Write-Output "备份位置：$backupRoot"
if ([bool]$newState.enabled) {
    Write-Output '请用代理打开总工作区并新建会话，让代理读取新版技能。'
} else {
    Write-Output '升级后仍保持停用；需要使用时先启用，再新建会话。'
}
