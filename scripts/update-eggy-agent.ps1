[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [string]$WorkspaceRoot
)

$ErrorActionPreference = 'Stop'
$packageRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

$workspace = Resolve-EggyDirectory -Path $WorkspaceRoot -Label '总工作区目录'
$statePath = Join-Path $workspace '.eggy-agent\install-state.json'
$rawState = Read-EggyJson -Path $statePath
$oldSchemaVersion = if ($rawState.PSObject.Properties.Name -contains 'schemaVersion') { [int]$rawState.schemaVersion } else { 1 }
$state = ConvertTo-EggyStateV2 -State $rawState
$manifest = Assert-EggyPackageManifest -PackageRoot $packageRoot
$rootRulesPath = Join-Path $workspace 'AGENTS.md'
$templateReportPath = Join-Path $workspace '.eggy-agent\template-upgrade-report.md'
$installedManifestPath = Join-Path $workspace '.eggy-agent\release-manifest.json'
$skillTargetPrefix = '.agents/skills/'

# 升级以登记清单为边界；任何地图移出总工作区、版本变化或规则冲突都整体停止。
foreach ($project in @($state.projects)) {
    $project.path = Resolve-EggyDirectory -Path ([string]$project.path) -Label '已登记地图工程'
    if (-not (Test-EggyPathInside -Root $workspace -Candidate ([string]$project.path))) {
        throw "已登记地图位于总工作区之外：$($project.path)"
    }
    $actualEdition = Get-EggyProjectEdition -ProjectPath ([string]$project.path)
    if ([string]$project.edition -ne $actualEdition) {
        throw "地图版本与安装记录不一致，拒绝自动改写：$($project.path)"
    }
}

$conflicts = @(Test-EggyInstalledFiles -WorkspaceRoot $workspace -State $state)
if ([bool]$state.rulesEnabled) {
    $rootBlock = Get-EggyManagedBlock -Path $rootRulesPath
    if (-not $rootBlock -or (Get-EggyTextSha256 -Text $rootBlock) -ne [string]$state.rootRuleBlockSha256) {
        $conflicts += 'AGENTS.md 中的总工作区受管规则块'
    }
    foreach ($project in @($state.projects)) {
        $projectRulesPath = Join-Path ([string]$project.path) 'AGENTS.md'
        $projectBlock = Get-EggyManagedBlock -Path $projectRulesPath
        if (-not $projectBlock -or (Get-EggyTextSha256 -Text $projectBlock) -ne [string]$project.projectRuleBlockSha256) {
            $conflicts += "地图 AGENTS.md 中的受管规则块：$($project.path)"
        }
    }
}

if ($conflicts.Count -gt 0) {
    Write-Output '升级结果：未修改任何文件。以下受管内容被改过、缺失或损坏：'
    $conflicts | Sort-Object -Unique | ForEach-Object { Write-Output "  $_" }
    throw '请先让代理审查这些差异，再决定保留用户修改还是恢复公开版。'
}

if ([string]$state.version -eq [string]$manifest.version -and $oldSchemaVersion -eq 2) {
    Write-Output "升级结果：当前已经是版本 $($manifest.version)，文件完整，无需更新。"
    exit 0
}

$destinations = Get-EggyManagedDestinationRecords -Manifest $manifest -WorkspaceRoot $workspace
if (-not [bool]$state.enabled) {
    foreach ($entry in $destinations) {
        if ([string]$entry.target -like "$skillTargetPrefix*") {
            $entry.destinationPath = Get-EggyInstalledTargetPath -WorkspaceRoot $workspace -State $state -Target ([string]$entry.target)
        }
    }
}

$newTargets = @($destinations.target) + @('.eggy-agent/release-manifest.json')
$obsoleteFiles = @($state.managedFiles | Where-Object { $newTargets -notcontains [string]$_.target } | ForEach-Object {
    Get-EggyInstalledTargetPath -WorkspaceRoot $workspace -State $state -Target ([string]$_.target)
})
$oldPaths = @($state.managedFiles | ForEach-Object {
    Get-EggyInstalledTargetPath -WorkspaceRoot $workspace -State $state -Target ([string]$_.target)
})
$projectRulePaths = @($state.projects | ForEach-Object { Join-Path ([string]$_.path) 'AGENTS.md' })
$backupPaths = @($oldPaths + $destinations.destinationPath + @(
    $statePath, $rootRulesPath, $templateReportPath, $installedManifestPath
) + $projectRulePaths | Sort-Object -Unique)
$backupRoot = New-EggyBackup -WorkspaceRoot $workspace -Path $backupPaths -Reason 'update'

try {
    foreach ($entry in $destinations) {
        $source = Join-Path $packageRoot ($entry.sourcePath.Replace('/', '\'))
        Copy-EggyFileAtomic -Source $source -Destination $entry.destinationPath
    }
    Copy-EggyFileAtomic -Source (Join-Path $packageRoot 'release-manifest.json') -Destination $installedManifestPath
    foreach ($obsoleteFile in $obsoleteFiles) {
        if (Test-Path -LiteralPath $obsoleteFile -PathType Leaf) {
            Remove-Item -LiteralPath $obsoleteFile -Force
        }
    }

    # 用户项目文档永不覆盖；报告按地图分组，只告诉代理模板变化和人工比较入口。
    $reportLines = @(
        '# 项目文档模板升级对比报告', '',
        "生成时间：$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')", "旧版本：$($state.version)", "新版本：$($manifest.version)", '',
        '> 项目长期文档属于用户。本次升级没有覆盖、创建或删除这些文件。'
    )
    foreach ($project in @($state.projects)) {
        $reportLines += @('', "## $([System.IO.Path]::GetFileName([string]$project.path))", '', '| 项目文档 | 当前文件 | 模板变化 | 处理结果 |', '|---|---|---|---|')
        foreach ($definition in @(
            @('需求文档.md', '需求文档模板.md'), @('开发计划.md', '开发计划模板.md'),
            @('资产清单.md', '资产清单模板.md'), @('README.md', '项目README模板.md'),
            @('开发日志.md', '开发日志模板.md')
        )) {
            $rootCandidate = Join-Path ([string]$project.path) $definition[0]
            $docsCandidate = Join-Path (Join-Path ([string]$project.path) 'docs') $definition[0]
            $documentPath = if (Test-Path -LiteralPath $rootCandidate -PathType Leaf) {
                $rootCandidate
            } elseif (Test-Path -LiteralPath $docsCandidate -PathType Leaf) {
                $docsCandidate
            } else {
                $null
            }
            $templateTarget = '.eggy-agent/templates/' + $definition[1]
            $oldTemplate = @($state.managedFiles | Where-Object { [string]$_.target -eq $templateTarget } | Select-Object -First 1)
            $newTemplate = @($manifest.files | Where-Object { [string]$_.target -eq $templateTarget } | Select-Object -First 1)
            $changed = if ($oldTemplate.Count -eq 1 -and $newTemplate.Count -eq 1 -and
                [string]$oldTemplate[0].sha256 -eq [string]$newTemplate[0].sha256) { '未变化' } else { '有变化' }
            $displayPath = if ($documentPath) { Get-EggyRelativePath -Root $workspace -Path $documentPath } else { '未找到' }
            $result = if ($documentPath) { '保留原文件，需要时人工比较' } else { '不自动新建' }
            $reportLines += "| $($definition[0]) | $displayPath | $changed | $result |"
        }
    }
    Write-EggyUtf8File -Path $templateReportPath -Content (($reportLines -join [Environment]::NewLine) + [Environment]::NewLine)

    $rootHash = [string]$state.rootRuleBlockSha256
    $updatedProjects = @()
    if ([bool]$state.rulesEnabled) {
        $rootBody = Get-EggyRuleBody -TemplatePath (Join-Path $packageRoot 'templates\根规则受管块.md') -WorkspaceRoot $workspace
        $newRootBlock = Set-EggyManagedBlock -Path $rootRulesPath -Body $rootBody
        $rootHash = Get-EggyTextSha256 -Text $newRootBlock
    }
    foreach ($project in @($state.projects)) {
        $projectHash = [string]$project.projectRuleBlockSha256
        if ([bool]$state.rulesEnabled) {
            $projectBody = Get-EggyRuleBody -TemplatePath (Join-Path $packageRoot 'templates\项目规则受管块.md') `
                -WorkspaceRoot $workspace -ProjectPath ([string]$project.path) `
                -PlayerMode ([string]$project.playerMode) -Edition ([string]$project.edition)
            $newProjectBlock = Set-EggyManagedBlock -Path (Join-Path ([string]$project.path) 'AGENTS.md') -Body $projectBody
            $projectHash = Get-EggyTextSha256 -Text $newProjectBlock
        }
        $updatedProjects += [pscustomobject]@{
            path = [string]$project.path
            edition = [string]$project.edition
            playerMode = [string]$project.playerMode
            projectRuleBlockSha256 = $projectHash
            userOwnedDocuments = @($project.userOwnedDocuments)
        }
    }

    $managedFiles = @($destinations | ForEach-Object {
        [pscustomobject]@{ target = $_.target; sha256 = Get-EggySha256 -Path $_.destinationPath }
    }) + @([pscustomobject]@{
        target = '.eggy-agent/release-manifest.json'
        sha256 = Get-EggySha256 -Path $installedManifestPath
    })
    $newState = [pscustomobject]@{
        schemaVersion = 2
        version = [string]$manifest.version
        installedAt = [string]$state.installedAt
        updatedAt = (Get-Date).ToString('o')
        workspaceRoot = $workspace
        enabled = [bool]$state.enabled
        rulesEnabled = [bool]$state.rulesEnabled
        managedFiles = $managedFiles
        rootRuleBlockSha256 = $rootHash
        projects = $updatedProjects
        latestBackup = $backupRoot
        templateUpgradeReport = Get-EggyRelativePath -Root $workspace -Path $templateReportPath
    }
    Write-EggyJson -Path $statePath -Value $newState
} catch {
    Restore-EggyBackupInternal -WorkspaceRoot $workspace -BackupRoot $backupRoot
    throw
}

Write-Output "升级结果：已升级到版本 $($manifest.version)，登记地图 $(@($state.projects).Count) 张。"
Write-Output "恢复命令：powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$(Join-Path $workspace '.eggy-agent\scripts\restore-eggy-agent.ps1')`" -WorkspaceRoot `"$workspace`" -BackupPath `"$backupRoot`""
if ([bool]$state.enabled) {
    Write-Output '重要：请用代理打开总工作区并新建会话，让代理加载新版公共技能。'
} else {
    Write-Output '技能升级后仍保持停用；需要使用时先重新启用，再用代理打开总工作区并新建会话。'
}
