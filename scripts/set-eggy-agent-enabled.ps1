[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$WorkspaceRoot,

    [Parameter(Mandatory = $true)]
    [ValidateSet('Enabled', 'Disabled')]
    [string]$Mode,

    [switch]$IncludeRules
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

$workspace = Resolve-EggyDirectory -Path $WorkspaceRoot -Label '总工作区目录'
$statePath = Join-Path $workspace '.eggy-agent\install-state.json'
$state = ConvertTo-EggyStateV2 -State (Read-EggyJson -Path $statePath)
$activeRoot = Join-Path $workspace '.agents\skills'
$disabledRoot = Join-Path $workspace '.eggy-agent\disabled-skills'
$rootRulesPath = Join-Path $workspace 'AGENTS.md'
$projectRulesPaths = @($state.projects | ForEach-Object { Join-Path ([string]$_.path) 'AGENTS.md' })
$skillPrefix = '.agents/skills/'
$skillEntries = @($state.managedFiles | Where-Object { ([string]$_.target).StartsWith($skillPrefix) })
$skillNames = @($skillEntries | ForEach-Object {
    (([string]$_.target).Substring($skillPrefix.Length) -split '/')[0]
} | Sort-Object -Unique)

if ($skillNames.Count -eq 0) {
    throw '安装状态中没有可启停的蛋仔技能。'
}
$targetEnabled = $Mode -eq 'Enabled'
$moveSkills = [bool]$state.enabled -ne $targetEnabled
$rulesWillChange = if ($Mode -eq 'Disabled') {
    $IncludeRules -and [bool]$state.rulesEnabled
} else {
    -not [bool]$state.rulesEnabled
}
if (-not $moveSkills -and -not $rulesWillChange) {
    Write-Output "启停结果：当前已经是 $Mode 状态，无需重复操作。"
    Write-Output '当前会话已经读到的内容无法卸载。请关闭当前会话并新建会话后再进行对比。'
    exit 0
}

# 先验证所有技能来源、目标和指纹，保证十一项技能只能整体移动。
if ($moveSkills) {
    foreach ($entry in $skillEntries) {
        $relative = ([string]$entry.target).Substring($skillPrefix.Length).Replace('/', '\')
        $activeFile = Join-Path $activeRoot $relative
        $disabledFile = Join-Path $disabledRoot $relative
        $sourceFile = if ($Mode -eq 'Disabled') { $activeFile } else { $disabledFile }
        $destinationFile = if ($Mode -eq 'Disabled') { $disabledFile } else { $activeFile }
        if (-not (Test-Path -LiteralPath $sourceFile -PathType Leaf)) {
            throw "启停来源文件缺失，尚未修改任何内容：$sourceFile"
        }
        if (Test-Path -LiteralPath $destinationFile -PathType Leaf) {
            throw "启停目标已经存在，尚未修改任何内容：$destinationFile"
        }
        if ((Get-EggySha256 -Path $sourceFile) -ne ([string]$entry.sha256).ToLowerInvariant()) {
            throw "技能文件已被修改，尚未移动；请先让代理审查差异：$sourceFile"
        }
    }
    foreach ($skillName in $skillNames) {
        $destinationDirectory = if ($Mode -eq 'Disabled') { Join-Path $disabledRoot $skillName } else { Join-Path $activeRoot $skillName }
        if ((Test-Path -LiteralPath $destinationDirectory -PathType Container) -and
            @(Get-ChildItem -LiteralPath $destinationDirectory -Force).Count -gt 0) {
            throw "启停目标目录不是空目录，尚未修改任何内容：$destinationDirectory"
        }
    }
}

# 规则启停覆盖总工作区和全部登记地图，任一规则冲突时一个都不改。
if ($rulesWillChange) {
    $rootBlock = Get-EggyManagedBlock -Path $rootRulesPath
    $projectBlocks = @()
    foreach ($project in @($state.projects)) {
        $path = Join-Path ([string]$project.path) 'AGENTS.md'
        $projectBlocks += [pscustomobject]@{ project = $project; path = $path; block = Get-EggyManagedBlock -Path $path }
    }
    if ($Mode -eq 'Disabled') {
        if (-not $rootBlock -or @($projectBlocks | Where-Object { -not $_.block }).Count -gt 0) {
            throw '一个或多个受管规则块缺失或损坏，尚未停用任何内容。'
        }
        if ((Get-EggyTextSha256 -Text $rootBlock) -ne [string]$state.rootRuleBlockSha256) {
            throw '总工作区受管规则块已被修改，尚未停用任何内容。'
        }
        foreach ($record in $projectBlocks) {
            if ((Get-EggyTextSha256 -Text ([string]$record.block)) -ne [string]$record.project.projectRuleBlockSha256) {
                throw "地图受管规则块已被修改，尚未停用任何内容：$($record.path)"
            }
        }
    } elseif ($rootBlock -or @($projectBlocks | Where-Object { $_.block }).Count -gt 0) {
        throw '停用期间出现了新的受管规则块，拒绝覆盖。'
    }
}

$backupPaths = @($statePath, $rootRulesPath) + $projectRulesPaths
if ($moveSkills) {
    foreach ($entry in $skillEntries) {
        $relative = ([string]$entry.target).Substring($skillPrefix.Length).Replace('/', '\')
        $backupPaths += Join-Path $activeRoot $relative
        $backupPaths += Join-Path $disabledRoot $relative
    }
}
$backupRoot = New-EggyBackup -WorkspaceRoot $workspace -Path $backupPaths -Reason $Mode.ToLowerInvariant()

try {
    [System.IO.Directory]::CreateDirectory($activeRoot) | Out-Null
    [System.IO.Directory]::CreateDirectory($disabledRoot) | Out-Null
    if ($moveSkills) {
        foreach ($skillName in $skillNames) {
            $sourceDirectory = if ($Mode -eq 'Disabled') { Join-Path $activeRoot $skillName } else { Join-Path $disabledRoot $skillName }
            $destinationDirectory = if ($Mode -eq 'Disabled') { Join-Path $disabledRoot $skillName } else { Join-Path $activeRoot $skillName }
            if (Test-Path -LiteralPath $destinationDirectory -PathType Container) {
                Remove-Item -LiteralPath $destinationDirectory
            }
            Move-Item -LiteralPath $sourceDirectory -Destination $destinationDirectory
        }
    }
    $state.enabled = $targetEnabled

    if ($Mode -eq 'Disabled' -and $IncludeRules) {
        Remove-EggyManagedBlock -Path $rootRulesPath
        foreach ($path in $projectRulesPaths) {
            Remove-EggyManagedBlock -Path $path
        }
        $state.rulesEnabled = $false
    } elseif ($Mode -eq 'Enabled' -and $rulesWillChange) {
        $templateRoot = Join-Path $workspace '.eggy-agent\templates'
        $rootBody = Get-EggyRuleBody -TemplatePath (Join-Path $templateRoot '根规则受管块.md') -WorkspaceRoot $workspace
        $newRootBlock = Set-EggyManagedBlock -Path $rootRulesPath -Body $rootBody
        $state.rootRuleBlockSha256 = Get-EggyTextSha256 -Text $newRootBlock
        foreach ($project in @($state.projects)) {
            $projectBody = Get-EggyRuleBody -TemplatePath (Join-Path $templateRoot '项目规则受管块.md') `
                -WorkspaceRoot $workspace -ProjectPath ([string]$project.path) `
                -PlayerMode ([string]$project.playerMode) -Edition ([string]$project.edition)
            $newProjectBlock = Set-EggyManagedBlock -Path (Join-Path ([string]$project.path) 'AGENTS.md') -Body $projectBody
            $project.projectRuleBlockSha256 = Get-EggyTextSha256 -Text $newProjectBlock
        }
        $state.rulesEnabled = $true
    }
    $state.schemaVersion = 2
    $state.latestBackup = $backupRoot
    if ($state.PSObject.Properties.Name -contains 'updatedAt') {
        $state.updatedAt = (Get-Date).ToString('o')
    } else {
        $state | Add-Member -MemberType NoteProperty -Name updatedAt -Value (Get-Date).ToString('o')
    }
    Write-EggyJson -Path $statePath -Value $state
} catch {
    Restore-EggyBackupInternal -WorkspaceRoot $workspace -BackupRoot $backupRoot
    throw
}

if ($Mode -eq 'Disabled') {
    Write-Output '停用结果：公共技能已移出代理发现目录。'
    if ($IncludeRules) { Write-Output "总工作区和 $(@($state.projects).Count) 张地图的受管规则块也已停用。" }
} else {
    Write-Output '启用结果：公共技能已恢复到代理发现目录。'
}
Write-Output "恢复命令：powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$(Join-Path $workspace '.eggy-agent\scripts\restore-eggy-agent.ps1')`" -WorkspaceRoot `"$workspace`" -BackupPath `"$backupRoot`""
Write-Output '当前会话已经读到的内容无法卸载。请用代理打开总工作区，并新建会话后再进行对比。'
