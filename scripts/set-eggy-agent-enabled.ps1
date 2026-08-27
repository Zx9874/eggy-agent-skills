[CmdletBinding()]
param(
    [string]$WorkspaceRoot = (Get-Location).Path,

    [Parameter(Mandatory = $true)]
    [ValidateSet('Enabled', 'Disabled')]
    [string]$Mode,

    [ValidateSet('Auto', 'Codex', 'OpenCode', 'ZCode')]
    [string]$Agent = 'Auto',

    [ValidateSet('Project', 'Global')]
    [string]$Scope = 'Project',

    [switch]$IncludeRules
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

if ($Scope -eq 'Global' -and $IncludeRules) {
    throw '全局技能启停不管理工作区或地图规则；请去掉 IncludeRules，仅切换全局技能。'
}

function Get-InstalledCatalog {
    param([Parameter(Mandatory = $true)][string]$Workspace)
    $candidates = @(
        (Join-Path $PSScriptRoot '..\skill-catalog.json'),
        (Join-Path $Workspace '.eggy-agent\skill-catalog.json')
    )
    foreach ($candidate in $candidates) {
        if (Test-Path -LiteralPath $candidate -PathType Leaf) {
            $root = Split-Path -Parent (Split-Path -Parent $candidate)
            if (Test-Path -LiteralPath (Join-Path $root 'skill-catalog.json') -PathType Leaf) {
                return Get-EggyCatalog -PackageRoot $root
            }
            $raw = Read-EggyJson -Path $candidate
            return $raw
        }
    }
    throw '找不到已安装的技能目录清单。'
}

function Resolve-StateAgent {
    param(
        [Parameter(Mandatory = $true)][string]$Workspace,
        [Parameter(Mandatory = $true)][string]$RequestedAgent,
        [Parameter(Mandatory = $true)][string]$RequestedScope
    )
    if ($RequestedAgent -ne 'Auto') { return $RequestedAgent }
    if ($RequestedScope -eq 'Project') {
        $default = Join-Path $Workspace '.eggy-agent\install-state.json'
        if (Test-Path -LiteralPath $default -PathType Leaf) {
            $raw = Read-EggyJson -Path $default
            return [string](Get-EggyPropertyValue -Object $raw -Name 'agent' -Default 'Codex')
        }
        if (Test-Path -LiteralPath (Join-Path $Workspace '.eggy-agent\install-state-zcode.json') -PathType Leaf) { return 'ZCode' }
        return 'Codex'
    }
    $globalRoot = Join-Path ([Environment]::GetFolderPath('UserProfile')) '.eggy-agent'
    $states = @(Get-ChildItem -LiteralPath $globalRoot -Filter 'install-state-global-*.json' -File -ErrorAction SilentlyContinue)
    if ($states.Count -eq 1) {
        return [string](Get-EggyPropertyValue -Object (Read-EggyJson -Path $states[0].FullName) -Name 'agent' -Default 'Codex')
    }
    if ($states.Count -gt 1) { throw '发现多个全局技能状态，请明确指定 Agent（宿主）。' }
    return 'Codex'
}

function Get-ActualSkillFilePath {
    param(
        [Parameter(Mandatory = $true)][object]$Descriptor,
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][object]$Record,
        [Parameter(Mandatory = $true)][ValidateSet('Enabled', 'Disabled')][string]$Location
    )
    $prefix = ([string]$State.skillRootRelative).TrimEnd('/') + '/'
    $target = [string]$Record.target
    if (-not $target.StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "技能记录目标不在技能目录内：$target"
    }
    $relative = $target.Substring($prefix.Length)
    $root = if ($Location -eq 'Enabled') { $Descriptor.SkillRoot } else { $Descriptor.DisabledRoot }
    return Join-Path $root ($relative.Replace('/', '\'))
}

function Assert-RulesBeforeToggle {
    param(
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][object]$Descriptor,
        [Parameter(Mandatory = $true)][string]$Mode
    )
    $rootPath = Join-Path $Descriptor.WorkspaceRoot 'AGENTS.md'
    $rootBlock = Get-EggyManagedBlock -Path $rootPath
    if ($Mode -eq 'Disabled') {
        if (-not $rootBlock -or (Get-EggyTextSha256 -Text $rootBlock) -ne [string]$State.rootRuleBlockSha256) {
            throw '总工作区受管规则块缺失、被修改或损坏，尚未停用任何内容。'
        }
        foreach ($project in @($State.projects)) {
            $path = Join-Path ([string]$project.path) 'AGENTS.md'
            $block = Get-EggyManagedBlock -Path $path
            if (-not $block -or (Get-EggyTextSha256 -Text $block) -ne [string]$project.projectRuleBlockSha256) {
                throw "地图受管规则块缺失、被修改或损坏，尚未停用任何内容：$path"
            }
        }
    } else {
        if ($rootBlock) { throw '停用期间总工作区出现了受管规则块，拒绝覆盖。' }
        foreach ($project in @($State.projects)) {
            $path = Join-Path ([string]$project.path) 'AGENTS.md'
            if (Get-EggyManagedBlock -Path $path) { throw "停用期间地图出现了受管规则块，拒绝覆盖：$path" }
        }
    }
}

$workspace = Resolve-EggyDirectory -Path $WorkspaceRoot -Label '总工作区目录'
$resolvedAgent = Resolve-StateAgent -Workspace $workspace -RequestedAgent $Agent -RequestedScope $Scope
$catalog = Get-InstalledCatalog -Workspace $workspace
$descriptor = Get-EggyInstallDescriptor -WorkspaceRoot $workspace -Agent $resolvedAgent -Scope $Scope -Catalog $catalog
$stateInfo = Read-EggyInstallState -Descriptor $descriptor
$state = $stateInfo.State
Assert-EggyStateContext -State $state -Descriptor $descriptor

$skillNames = @(Get-EggyManagedSkillNamesFromState -State $state)
if ($skillNames.Count -eq 0) { throw '安装状态中没有可启停的技能。' }
$targetEnabled = $Mode -eq 'Enabled'
if ([bool]$state.enabled -eq $targetEnabled -and -not $IncludeRules) {
    Write-Output "启停结果：当前已经是 $Mode 状态，无需重复操作。"
    Write-Output '当前会话已经读到的内容无法卸载；请新建会话后比较。'
    exit 0
}

$sourceLocation = if ([bool]$state.enabled) { 'Enabled' } else { 'Disabled' }
$destinationLocation = if ($targetEnabled) { 'Enabled' } else { 'Disabled' }
foreach ($skillName in $skillNames) {
    Assert-EggySkillDirectoryClean -Descriptor $descriptor -State $state -SkillName $skillName -Location $sourceLocation
    $sourceDirectory = if ($sourceLocation -eq 'Enabled') { Join-Path $descriptor.SkillRoot $skillName } else { Join-Path $descriptor.DisabledRoot $skillName }
    $destinationDirectory = if ($destinationLocation -eq 'Enabled') { Join-Path $descriptor.SkillRoot $skillName } else { Join-Path $descriptor.DisabledRoot $skillName }
    if (Test-Path -LiteralPath $destinationDirectory -PathType Leaf) {
        throw "启停目标已被文件占用，尚未修改任何内容：$destinationDirectory"
    }
    if ((Test-Path -LiteralPath $destinationDirectory -PathType Container) -and
        @(Get-ChildItem -LiteralPath $destinationDirectory -Force).Count -gt 0) {
        throw "启停目标不是空目录，尚未修改任何内容：$destinationDirectory"
    }
}
if ($IncludeRules) { Assert-RulesBeforeToggle -State $state -Descriptor $descriptor -Mode $Mode }

$backupPaths = @($stateInfo.Path, (Join-Path $descriptor.WorkspaceRoot 'AGENTS.md'))
foreach ($project in @($state.projects)) { $backupPaths += Join-Path ([string]$project.path) 'AGENTS.md' }
foreach ($entry in @($state.managedFiles | Where-Object { $_.kind -eq 'skill' })) {
    $backupPaths += Get-ActualSkillFilePath -Descriptor $descriptor -State $state -Record $entry -Location Enabled
    $backupPaths += Get-ActualSkillFilePath -Descriptor $descriptor -State $state -Record $entry -Location Disabled
}
$backupRoot = New-EggyBackup -WorkspaceRoot $descriptor.BaseRoot -Path $backupPaths -Reason $Mode.ToLowerInvariant()

try {
    [System.IO.Directory]::CreateDirectory($descriptor.SkillRoot) | Out-Null
    [System.IO.Directory]::CreateDirectory($descriptor.DisabledRoot) | Out-Null
    if ([bool]$state.enabled -ne $targetEnabled) {
        # 先复制到目标位置，再清理旧位置；失败时备份可以恢复两侧文件。
        foreach ($skillName in $skillNames) {
            foreach ($entry in @(Get-EggyStateSkillRecords -State $state -SkillName $skillName)) {
                $source = Get-ActualSkillFilePath -Descriptor $descriptor -State $state -Record $entry -Location $sourceLocation
                $destination = Get-ActualSkillFilePath -Descriptor $descriptor -State $state -Record $entry -Location $destinationLocation
                Copy-EggyFileAtomic -Source $source -Destination $destination
            }
        }
        foreach ($skillName in $skillNames) {
            $sourceDirectory = if ($sourceLocation -eq 'Enabled') { Join-Path $descriptor.SkillRoot $skillName } else { Join-Path $descriptor.DisabledRoot $skillName }
            if (Test-Path -LiteralPath $sourceDirectory -PathType Container) {
                Remove-Item -LiteralPath $sourceDirectory -Recurse -Force
            }
        }
    }

    if ($IncludeRules -and $Mode -eq 'Disabled') {
        Remove-EggyManagedBlock -Path (Join-Path $descriptor.WorkspaceRoot 'AGENTS.md')
        foreach ($project in @($state.projects)) { Remove-EggyManagedBlock -Path (Join-Path ([string]$project.path) 'AGENTS.md') }
        $state.rulesEnabled = $false
        $state.rootRuleBlockSha256 = ''
    } elseif ($IncludeRules -and $Mode -eq 'Enabled') {
        $templateRoot = Join-Path $descriptor.StateRoot 'templates'
        $rootBody = Get-EggyRuleBody -TemplatePath (Join-Path $templateRoot '根规则受管块.md') -WorkspaceRoot $descriptor.WorkspaceRoot
        $rootBlock = Set-EggyManagedBlock -Path (Join-Path $descriptor.WorkspaceRoot 'AGENTS.md') -Body $rootBody
        $state.rootRuleBlockSha256 = Get-EggyTextSha256 -Text $rootBlock
        foreach ($project in @($state.projects)) {
            $body = Get-EggyRuleBody -TemplatePath (Join-Path $templateRoot '项目规则受管块.md') `
                -WorkspaceRoot $descriptor.WorkspaceRoot -ProjectPath ([string]$project.path) `
                -PlayerMode ([string]$project.playerMode) -Edition ([string]$project.edition)
            $block = Set-EggyManagedBlock -Path (Join-Path ([string]$project.path) 'AGENTS.md') -Body $body
            $project.projectRuleBlockSha256 = Get-EggyTextSha256 -Text $block
        }
        $state.rulesEnabled = $true
    }
    $state.schemaVersion = 4
    $state.enabled = $targetEnabled
    $state.updatedAt = (Get-Date).ToString('o')
    $state.latestBackup = $backupRoot
    Write-EggyJson -Path $stateInfo.Path -Value $state
} catch {
    Restore-EggyBackupInternal -WorkspaceRoot $descriptor.BaseRoot -BackupRoot $backupRoot
    throw
}

Write-Output "启停结果：已将 $(@($skillNames).Count) 项技能切换为 $Mode。"
if ($IncludeRules) { Write-Output "受管规则区块也已切换为 $Mode。" }
Write-Output "备份位置：$backupRoot"
Write-Output '当前会话已经读到的内容无法卸载；请关闭当前会话并新建会话。'
