[CmdletBinding()]
param(
    [string]$PackageRoot
)

$ErrorActionPreference = 'Stop'
if (-not $PackageRoot) {
    $PackageRoot = Join-Path $PSScriptRoot '..'
}
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

$root = Resolve-EggyDirectory -Path $PackageRoot -Label '候选包目录'
$manifest = Assert-EggyPackageManifest -PackageRoot $root
$errors = @()
$requiredFiles = @(
    'README.md', 'START-HERE.md', 'INSTALL-给agent的安装任务书.md',
    'UPDATE-给agent的升级任务书.md', 'CONTRIBUTING.md', 'LICENSE',
    'VERSION', 'release-manifest.json',
    '.github/ISSUE_TEMPLATE/bug.yml', '.github/ISSUE_TEMPLATE/knowledge.yml',
    'tests/release-smoke.ps1'
)
foreach ($requiredFile in $requiredFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $root ($requiredFile -replace '/', '\')) -PathType Leaf)) {
        $errors += "缺少公开版必要文件：$requiredFile"
    }
}

$version = (Get-Content -LiteralPath (Join-Path $root 'VERSION') -Raw -Encoding UTF8).Trim()
if ($version -ne [string]$manifest.version) {
    $errors += "VERSION（版本号文件）与发布清单版本不一致：$version / $($manifest.version)"
}
if ([string]$manifest.edition -ne 'dual') {
    $errors += '公开版发布清单必须声明 dual（原点版与世界版双版本）。'
}

$workspaceReminderFiles = @(
    'README.md', 'START-HERE.md', 'INSTALL-给agent的安装任务书.md',
    'templates/根规则受管块.md', 'templates/项目规则受管块.md'
)
foreach ($relative in $workspaceReminderFiles) {
    $path = Join-Path $root ($relative.Replace('/', '\'))
    if ((Get-Content -LiteralPath $path -Raw -Encoding UTF8) -notmatch '总工作区') {
        $errors += "缺少总工作区提醒：$relative"
    }
}

$forbiddenPublicPaths = @('docs')
foreach ($relative in $forbiddenPublicPaths) {
    if (Test-Path -LiteralPath (Join-Path $root $relative)) {
        $errors += "公开技能包禁止包含教程目录：$relative"
    }
}
$agents = @($manifest.compatibleAgents)
if ($agents -notcontains 'OpenCode' -or $agents -notcontains 'Codex') {
    $errors += '发布清单必须同时声明 OpenCode（开放代码代理）与 Codex（代码代理）兼容。'
}
$duplicateTargets = @($manifest.files | Group-Object target | Where-Object { $_.Count -gt 1 })
if ($duplicateTargets.Count -gt 0) {
    $errors += '发布清单存在重复安装目标。'
}

$skillFolders = @(Get-ChildItem -LiteralPath (Join-Path $root 'skills') -Directory)
if ($skillFolders.Count -ne 11) {
    $errors += "技能数量应为 11，实际为 $($skillFolders.Count)。"
}

foreach ($folder in $skillFolders) {
    $skillPath = Join-Path $folder.FullName 'SKILL.md'
    if (-not (Test-Path -LiteralPath $skillPath -PathType Leaf)) {
        $errors += "技能缺少 SKILL.md：$($folder.Name)"
        continue
    }
    $content = Get-Content -LiteralPath $skillPath -Raw -Encoding UTF8
    if ($content -notmatch '(?s)^---\s*\r?\nname:\s*([a-z0-9]+(?:-[a-z0-9]+)*)\s*\r?\ndescription:\s*.+?\r?\n---') {
        $errors += "技能头部格式不正确：$($folder.Name)"
    } elseif ($Matches[1] -ne $folder.Name) {
        $errors += "技能名称与目录不一致：$($folder.Name)"
    }
    if (($content -split "`r?`n").Count -gt 500) {
        $errors += "技能正文超过 500 行：$($folder.Name)"
    }
}

$trackedText = Get-ChildItem -LiteralPath $root -Recurse -File |
    Where-Object { $_.FullName -notmatch '\\.git\\|\\dist\\|\\KIMI[^\\]*\.md$' -and $_.Extension -in @('.md', '.ps1', '.json', '.yml') }
$absolutePathPattern = '(?i)(?:[A-Z]:\\(?:Users|蛋仔地图|Github)\\)'
$secretPattern = '(?:ark-[A-Za-z0-9-]{20,}|sk-[A-Za-z0-9_-]{20,}|ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,})'
$staleMarkers = @(
    ('状态：' + '骨架'), ('KIMI' + '任务包'), ('待' + '通用化'),
    ('许可：' + '待定'), ('群号：' + '待填')
)
$stalePattern = ($staleMarkers | ForEach-Object { [regex]::Escape($_) }) -join '|'
foreach ($file in $trackedText) {
    $content = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    if ($content -match $absolutePathPattern) {
        $errors += "发现本机绝对路径：$($file.FullName)"
    }
    if ($content -match $secretPattern) {
        $errors += "发现疑似真实凭据：$($file.FullName)"
    }
    if ($content -match '(?i)--port\s+19836|\.codemaker\\editor-cli\.exe') {
        $errors += "发现废弃命令行路径或固定端口：$($file.FullName)"
    }
    if ($content -match $stalePattern) {
        $errors += "发现公开版遗留草稿标记：$($file.FullName)"
    }
}

# 检查 Markdown（标记文本）相对链接，避免入口链接发布后指向不存在的文件。
foreach ($file in $trackedText | Where-Object { $_.Extension -eq '.md' }) {
    $content = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    foreach ($match in [regex]::Matches($content, '\[[^\]]+\]\(([^)]+)\)')) {
        $target = $match.Groups[1].Value.Trim().Trim('<', '>')
        if ($target -match '^(?:https?://|mailto:|#)' -or [string]::IsNullOrWhiteSpace($target)) {
            continue
        }
        $target = ($target -split '[?#]', 2)[0]
        $target = [Uri]::UnescapeDataString($target).Replace('/', '\')
        $resolvedTarget = Join-Path $file.DirectoryName $target
        if (-not (Test-Path -LiteralPath $resolvedTarget)) {
            $errors += "相对链接目标不存在：$($file.FullName) -> $target"
        }
    }
}

if ($errors.Count -gt 0) {
    $errors | Sort-Object -Unique | ForEach-Object { Write-Error $_ }
    throw "候选包验证失败，共发现 $($errors.Count) 项问题。"
}

Write-Output "候选包验证通过：版本 $($manifest.version)，技能 11 项，发布清单文件 $(@($manifest.files).Count) 项。"
