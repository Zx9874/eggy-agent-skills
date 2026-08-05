[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [string]$WorkspaceRoot,

    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,

    [Parameter(Mandatory = $true)]
    [ValidateSet('Single', 'Multiplayer')]
    [string]$PlayerMode
)

$ErrorActionPreference = 'Stop'
$packageRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

function Invoke-MapGit {
    param([Parameter(Mandatory = $true)][string[]]$Arguments)

    $safePath = $script:ProjectRoot.Replace('\', '/')
    & git -c "safe.directory=$safePath" -c 'core.quotepath=false' -C $script:ProjectRoot @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "版本记录命令执行失败：git $($Arguments -join ' ')"
    }
}

function Test-MapGit {
    param([Parameter(Mandatory = $true)][string[]]$Arguments)

    $previousPreference = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        & git -C $script:ProjectRoot @Arguments *> $null
        return $LASTEXITCODE -eq 0
    } finally {
        $ErrorActionPreference = $previousPreference
    }
}

function Initialize-MapRepository {
    param(
        [Parameter(Mandatory = $true)][string]$GitIgnoreTemplate,
        [Parameter(Mandatory = $true)][string]$GitAttributesTemplate
    )

    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        throw '没有找到 Git（版本记录工具），请先安装后再运行本技能包安装器。'
    }

    # 每张地图必须有自己的恢复历史；总工作区只共享技能，不能成为多张地图的共同仓库。
    $hasRepository = Test-MapGit -Arguments @('rev-parse', '--show-toplevel')
    if ($hasRepository) {
        $reported = (& git -c "safe.directory=$($script:ProjectRoot.Replace('\', '/'))" -C $script:ProjectRoot rev-parse --show-toplevel).Trim()
        if (-not ([System.IO.Path]::GetFullPath($reported).TrimEnd('\', '/')).Equals(
            $script:ProjectRoot,
            [System.StringComparison]::OrdinalIgnoreCase
        )) {
            throw "地图工程不是独立仓库，当前版本记录根目录是：$reported"
        }
        if (-not (Test-MapGit -Arguments @('rev-parse', '--verify', 'HEAD'))) {
            throw '地图工程已有版本记录目录但没有首个提交。请先让代理审查当前文件并建立基线。'
        }
        return
    }

    $gitIgnorePath = Join-Path $script:ProjectRoot '.gitignore'
    $gitAttributesPath = Join-Path $script:ProjectRoot '.gitattributes'
    if (-not (Test-Path -LiteralPath $gitIgnorePath)) {
        Copy-EggyFileAtomic -Source $GitIgnoreTemplate -Destination $gitIgnorePath
    }
    if (-not (Test-Path -LiteralPath $gitAttributesPath)) {
        Copy-EggyFileAtomic -Source $GitAttributesTemplate -Destination $gitAttributesPath
    }

    if (-not (Test-MapGit -Arguments @('init', '--initial-branch=main'))) {
        & git -C $script:ProjectRoot init *> $null
        if ($LASTEXITCODE -ne 0) {
            throw '无法为地图建立本地版本记录。'
        }
        & git -C $script:ProjectRoot branch -M main *> $null
    }

    try {
        Invoke-MapGit -Arguments @('add', '--all')
        & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $packageRoot 'scripts\git-batch-audit.ps1') -ProjectPath $script:ProjectRoot -Staged
        if ($LASTEXITCODE -ne 0) {
            throw '首个基线审查未通过。'
        }
        Invoke-MapGit -Arguments @(
            '-c', 'user.name=Eggy Agent Local',
            '-c', 'user.email=eggy-agent@localhost.invalid',
            'commit', '-m', '建立当前地图本地基线（功能状态待试玩确认）'
        )
    } catch {
        & git -C $script:ProjectRoot rm --cached -r --ignore-unmatch . *> $null
        throw
    }
}

function New-ProjectDocument {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$TemplateName
    )

    # 项目长期文档属于用户；根目录或 docs 中任一同名文件存在时都不覆盖、不复制第二份。
    $rootCandidate = Join-Path $script:ProjectRoot $Name
    $docsCandidate = Join-Path (Join-Path $script:ProjectRoot 'docs') $Name
    if ((Test-Path -LiteralPath $rootCandidate) -or (Test-Path -LiteralPath $docsCandidate)) {
        return $null
    }

    $template = Join-Path $packageRoot "templates\$TemplateName"
    $content = (Get-Content -LiteralPath $template -Raw -Encoding UTF8).
        Replace('{{PROJECT_NAME}}', (Split-Path $script:ProjectRoot -Leaf)).
        Replace('{{PLAYER_MODE}}', $(if ($PlayerMode -eq 'Multiplayer') { '多人地图' } else { '单人地图' })).
        Replace('{{EDITION}}', (Get-EggyEditionLabel -Edition $script:ProjectEdition))
    Write-EggyUtf8File -Path $docsCandidate -Content $content
    return $docsCandidate
}

function Assert-RegisteredRules {
    param([Parameter(Mandatory = $true)][object]$State)

    if (-not [bool]$State.rulesEnabled) {
        return
    }
    $rootBlock = Get-EggyManagedBlock -Path (Join-Path $script:Workspace 'AGENTS.md')
    if (-not $rootBlock -or (Get-EggyTextSha256 -Text $rootBlock) -ne [string]$State.rootRuleBlockSha256) {
        throw '工作区受管规则块被改过、缺失或损坏。请先升级或恢复，再登记新地图。'
    }
    foreach ($project in @($State.projects)) {
        $projectBlock = Get-EggyManagedBlock -Path (Join-Path ([string]$project.path) 'AGENTS.md')
        if (-not $projectBlock -or (Get-EggyTextSha256 -Text $projectBlock) -ne [string]$project.projectRuleBlockSha256) {
            throw "已登记地图的受管规则块被改过、缺失或损坏：$($project.path)"
        }
    }
}

$script:Workspace = Resolve-EggyDirectory -Path $WorkspaceRoot -Label '总工作区目录'
$script:ProjectRoot = Resolve-EggyDirectory -Path $ProjectPath -Label '地图工程目录'
if (-not (Test-EggyPathInside -Root $script:Workspace -Candidate $script:ProjectRoot)) {
    throw '地图工程必须位于总工作区目录内。'
}

$manifest = Assert-EggyPackageManifest -PackageRoot $packageRoot
$script:ProjectEdition = Get-EggyProjectEdition -ProjectPath $script:ProjectRoot
$statePath = Join-Path $script:Workspace '.eggy-agent\install-state.json'
$rootRulesPath = Join-Path $script:Workspace 'AGENTS.md'
$projectRulesPath = Join-Path $script:ProjectRoot 'AGENTS.md'
$installedManifestPath = Join-Path $script:Workspace '.eggy-agent\release-manifest.json'
$destinations = Get-EggyManagedDestinationRecords -Manifest $manifest -WorkspaceRoot $script:Workspace

$legacySkills = @(Get-ChildItem -LiteralPath (Join-Path $script:Workspace '.opencode\skills') -Directory -Filter 'eggy-*' -ErrorAction SilentlyContinue)
if ($legacySkills.Count -gt 0) {
    throw '检测到旧位置中的同名技能。为避免代理加载两个版本，安装已停止；请先备份并处理 .opencode\skills 下的 eggy-* 技能。'
}

$existingState = $null
$existingProject = @()
if (Test-Path -LiteralPath $statePath -PathType Leaf) {
    $existingState = ConvertTo-EggyStateV2 -State (Read-EggyJson -Path $statePath)
    if ([string]$existingState.version -ne [string]$manifest.version) {
        throw '总工作区已经安装过其他版本。请先用新版升级脚本完成整体升级，再登记地图。'
    }
    $fileConflicts = Test-EggyInstalledFiles -WorkspaceRoot $script:Workspace -State $existingState
    if ($fileConflicts.Count -gt 0) {
        throw "已安装受管文件被改过、缺失或损坏：$(($fileConflicts | Sort-Object -Unique) -join '、')"
    }
    Assert-RegisteredRules -State $existingState
    $existingProject = @(Get-EggyStateProject -State $existingState -ProjectPath $script:ProjectRoot)
    if ($existingProject.Count -gt 1) {
        throw '安装状态中同一张地图出现多次，拒绝继续追加。请先恢复或审查安装状态。'
    }
    if ($existingProject.Count -eq 1) {
        if ([string]$existingProject[0].edition -ne $script:ProjectEdition -or
            [string]$existingProject[0].playerMode -ne $PlayerMode) {
            throw '这张地图已经登记，但版本或单人/多人设置与本次输入不一致。请先核对，不要自动改写。'
        }
        Write-Output "安装结果：版本 $($manifest.version) 已完整安装，这张地图也已登记，无需重复安装。"
        Write-Output '重要：请用代理打开总工作区，而不是只打开地图子目录；新建会话后公共技能才会稳定生效。'
        exit 0
    }
}

Initialize-MapRepository `
    -GitIgnoreTemplate (Join-Path $packageRoot 'templates\地图.gitignore模板') `
    -GitAttributesTemplate (Join-Path $packageRoot 'templates\地图.gitattributes模板')

# 首次安装备份全部受管目标；追加地图时只备份状态和该地图规则，避免重复复制公共技能。
$backupPaths = if ($existingState) {
    @($statePath, $rootRulesPath, $projectRulesPath)
} else {
    @($destinations.destinationPath) + @($installedManifestPath, $statePath, $rootRulesPath, $projectRulesPath)
}
$backupRoot = New-EggyBackup -WorkspaceRoot $script:Workspace -Path $backupPaths -Reason $(if ($existingState) { 'register-map' } else { 'install' })
$createdDocuments = @()

try {
    if (-not $existingState) {
        foreach ($entry in $destinations) {
            $source = Join-Path $packageRoot ($entry.sourcePath.Replace('/', '\'))
            Copy-EggyFileAtomic -Source $source -Destination $entry.destinationPath
        }
        Copy-EggyFileAtomic -Source (Join-Path $packageRoot 'release-manifest.json') -Destination $installedManifestPath
    }

    $rootBlock = $null
    $projectBlock = $null
    $rulesEnabled = if ($existingState) { [bool]$existingState.rulesEnabled } else { $true }
    if ($rulesEnabled) {
        if (-not $existingState) {
            $rootBody = Get-EggyRuleBody -TemplatePath (Join-Path $packageRoot 'templates\根规则受管块.md') `
                -WorkspaceRoot $script:Workspace
            $rootBlock = Set-EggyManagedBlock -Path $rootRulesPath -Body $rootBody
        }
        $projectBody = Get-EggyRuleBody -TemplatePath (Join-Path $packageRoot 'templates\项目规则受管块.md') `
            -WorkspaceRoot $script:Workspace -ProjectPath $script:ProjectRoot -PlayerMode $PlayerMode -Edition $script:ProjectEdition
        $projectBlock = Set-EggyManagedBlock -Path $projectRulesPath -Body $projectBody
    }

    foreach ($definition in @(
        @('需求文档.md', '需求文档模板.md'),
        @('开发计划.md', '开发计划模板.md'),
        @('资产清单.md', '资产清单模板.md'),
        @('开发日志.md', '开发日志模板.md')
    )) {
        $created = New-ProjectDocument -Name $definition[0] -TemplateName $definition[1]
        if ($created) { $createdDocuments += $created }
    }
    $readmePath = Join-Path $script:ProjectRoot 'README.md'
    if (-not (Test-Path -LiteralPath $readmePath)) {
        $readme = (Get-Content -LiteralPath (Join-Path $packageRoot 'templates\项目README模板.md') -Raw -Encoding UTF8).
            Replace('{{PROJECT_NAME}}', (Split-Path $script:ProjectRoot -Leaf)).
            Replace('{{PLAYER_MODE}}', $(if ($PlayerMode -eq 'Multiplayer') { '多人地图' } else { '单人地图' })).
            Replace('{{EDITION}}', (Get-EggyEditionLabel -Edition $script:ProjectEdition))
        Write-EggyUtf8File -Path $readmePath -Content $readme
        $createdDocuments += $readmePath
    }

    $projectRecord = [pscustomobject]@{
        path = $script:ProjectRoot
        edition = $script:ProjectEdition
        playerMode = $PlayerMode
        projectRuleBlockSha256 = $(if ($projectBlock) { Get-EggyTextSha256 -Text $projectBlock } else { '' })
        userOwnedDocuments = @($createdDocuments | ForEach-Object { Get-EggyRelativePath -Root $script:Workspace -Path $_ })
    }

    if ($existingState) {
        $projects = @($existingState.projects) + @($projectRecord)
        $managedFiles = @($existingState.managedFiles)
        $rootHash = [string]$existingState.rootRuleBlockSha256
        $installedAt = [string]$existingState.installedAt
        $enabled = [bool]$existingState.enabled
    } else {
        $projects = @($projectRecord)
        $managedFiles = @($destinations | ForEach-Object {
            [pscustomobject]@{ target = $_.target; sha256 = Get-EggySha256 -Path $_.destinationPath }
        }) + @([pscustomobject]@{
            target = '.eggy-agent/release-manifest.json'
            sha256 = Get-EggySha256 -Path $installedManifestPath
        })
        $rootHash = Get-EggyTextSha256 -Text $rootBlock
        $installedAt = (Get-Date).ToString('o')
        $enabled = $true
    }

    $newState = [pscustomobject]@{
        schemaVersion = 2
        version = [string]$manifest.version
        installedAt = $installedAt
        updatedAt = (Get-Date).ToString('o')
        workspaceRoot = $script:Workspace
        enabled = $enabled
        rulesEnabled = $rulesEnabled
        managedFiles = $managedFiles
        rootRuleBlockSha256 = $rootHash
        projects = $projects
        latestBackup = $backupRoot
    }
    Write-EggyJson -Path $statePath -Value $newState
} catch {
    Restore-EggyBackupInternal -WorkspaceRoot $script:Workspace -BackupRoot $backupRoot
    foreach ($createdDocument in $createdDocuments) {
        if ((Test-EggyPathInside -Root $script:ProjectRoot -Candidate $createdDocument) -and
            (Test-Path -LiteralPath $createdDocument -PathType Leaf)) {
            Remove-Item -LiteralPath $createdDocument -Force
        }
    }
    throw
}

$editionLabel = Get-EggyEditionLabel -Edition $script:ProjectEdition
if ($existingState) {
    Write-Output "安装结果：已把${editionLabel}地图登记到版本 $($manifest.version) 的总工作区。"
} else {
    Write-Output "安装结果：成功安装版本 $($manifest.version)，并登记${editionLabel}地图。"
}
Write-Output "技能位置：$(Join-Path $script:Workspace '.agents\skills')"
Write-Output "恢复命令：powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$(Join-Path $script:Workspace '.eggy-agent\scripts\restore-eggy-agent.ps1')`" -WorkspaceRoot `"$script:Workspace`" -BackupPath `"$backupRoot`""
Write-Output '重要：请用代理打开总工作区，而不是只打开地图子目录；然后新建会话。'
