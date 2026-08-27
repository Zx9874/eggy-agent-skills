[CmdletBinding()]
param(
    [string]$PackageRoot
)

$ErrorActionPreference = 'Stop'
if (-not $PackageRoot) { $PackageRoot = Join-Path $PSScriptRoot '..' }
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

$root = Resolve-EggyDirectory -Path $PackageRoot -Label '候选包目录'
$errors = @()
$manifest = $null
try {
    $manifest = Assert-EggyPackageManifest -PackageRoot $root
} catch {
    $errors += $_.Exception.Message
}

function Add-ReleaseError {
    param([string]$Message)
    if ($Message) { $script:errors += $Message }
}

function Test-RequiredFile {
    param([string]$RelativePath)
    $path = Join-Path $root ($RelativePath.Replace('/', '\'))
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        Add-ReleaseError "缺少公开包必要文件：$RelativePath"
    }
}

foreach ($required in @(
    'README.md', 'START-HERE.md', 'INSTALL-给agent的安装任务书.md',
    'UPDATE-给agent的升级任务书.md', 'CONTRIBUTING.md', 'LICENSE', 'VERSION',
    'release-manifest.json', 'skill-catalog.json', 'tests/release-smoke.ps1'
)) {
    Test-RequiredFile -RelativePath $required
}

$catalog = $null
try { $catalog = Get-EggyCatalog -PackageRoot $root } catch { Add-ReleaseError $_.Exception.Message }

if ($catalog) {
    $catalogNames = @($catalog.skills | ForEach-Object { [string]$_.name } | Sort-Object -Unique)
    $folderNames = @(Get-ChildItem -LiteralPath (Join-Path $root 'skills') -Directory -ErrorAction SilentlyContinue |
        ForEach-Object { [string]$_.Name } | Sort-Object -Unique)
    foreach ($name in $catalogNames) {
        if ($folderNames -notcontains $name) { Add-ReleaseError "技能目录缺失：$name" }
        $skillPath = Join-Path (Join-Path $root 'skills') "$name\SKILL.md"
        if (-not (Test-Path -LiteralPath $skillPath -PathType Leaf)) {
            Add-ReleaseError "技能缺少 SKILL.md：$name"
            continue
        }
        $content = Get-Content -LiteralPath $skillPath -Raw -Encoding UTF8
        if ($content -notmatch '(?s)^---\s*\r?\nname:\s*([a-z0-9-]+)\s*\r?\ndescription:\s*(.+?)\r?\n---') {
            Add-ReleaseError "技能头部格式不正确：$name"
        } elseif ($Matches[1] -ne $name) {
            Add-ReleaseError "技能名称与目录不一致：$name"
        }
        if (($content -split "`r?`n").Count -gt 500) {
            Add-ReleaseError "技能正文超过 500 行：$name"
        }
    }
    foreach ($extra in @($folderNames | Where-Object { $catalogNames -notcontains $_ })) {
        Add-ReleaseError "skills 目录包含未登记技能：$extra"
    }

    foreach ($profileProperty in @($catalog.profiles.PSObject.Properties)) {
        $profile = $profileProperty.Name
        $skills = @(Get-EggyProfileSkillNames -Catalog $catalog -Profile $profile)
        $domain = if ($profile -like '*tooling*') { 'tooling' } elseif ($profile -eq 'common' -or $profile -eq 'full') { '' } else { 'map' }
        $edition = if ($profile -like '*world*') { 'World' } elseif ($profile -like '*origin*') { 'Origin' } else { '' }
        foreach ($name in $skills) {
            $record = Get-EggySkillRecord -Catalog $catalog -Name $name
            if ($domain -and @($record.domains) -notcontains $domain) {
                Add-ReleaseError "档案 $profile 包含不属于 $domain 任务域的技能：$name"
            }
            if ($edition -and @($record.editions) -notcontains $edition) {
                Add-ReleaseError "档案 $profile 包含不支持 $edition 的技能：$name"
            }
        }
    }
}

if ($manifest) {
    $duplicateSources = @($manifest.files | Group-Object path | Where-Object { $_.Count -gt 1 })
    if ($duplicateSources.Count -gt 0) { Add-ReleaseError '发布清单存在重复来源文件。' }
    $duplicateTargets = @($manifest.files | Where-Object { $_.installTarget } | Group-Object installTarget | Where-Object { $_.Count -gt 1 })
    if ($duplicateTargets.Count -gt 0) { Add-ReleaseError '发布清单存在重复安装目标模板。' }
    if ([string]$manifest.package -ne 'eggy-agent-skills') { Add-ReleaseError '发布清单 package（包名）不正确。' }
    if (@($manifest.profiles).Count -lt 1) { Add-ReleaseError '发布清单没有档案列表。' }
}

$requiredReminderFiles = @(
    'README.md', 'START-HERE.md', 'INSTALL-给agent的安装任务书.md',
    'templates/根规则受管块.md', 'templates/项目规则受管块.md'
)
foreach ($relative in $requiredReminderFiles) {
    $path = Join-Path $root ($relative.Replace('/', '\'))
    if (Test-Path -LiteralPath $path -PathType Leaf) {
        $content = Get-Content -LiteralPath $path -Raw -Encoding UTF8
        if ($content -notmatch '总工作区') { Add-ReleaseError "缺少总工作区提醒：$relative" }
    }
}

if (Test-Path -LiteralPath (Join-Path $root 'docs') -PathType Container) {
    Add-ReleaseError '公开技能包禁止包含官方手册或私人知识库目录：docs'
}

$textExtensions = @('.md', '.ps1', '.json', '.yml', '.yaml', '.js', '.lua', '.txt')
$trackedText = @(Get-ChildItem -LiteralPath $root -Recurse -File |
    Where-Object { $_.FullName -notmatch '\\.git\\|\\dist\\|\\.release-temp-' -and $textExtensions -contains $_.Extension.ToLowerInvariant() })

# 只匹配像真实本机路径的片段；代码中的正则表达式本身不应被当成泄露。
$absolutePathPattern = '(?i)(?<![A-Za-z0-9])(?:[A-Z]:[\\/](?:Users|Documents and Settings|蛋仔地图|Github)[\\/][^\r\n`"<>]+)'
$secretPattern = '(?:ark-[A-Za-z0-9-]{20,}|sk-[A-Za-z0-9_-]{20,}|ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,})'
foreach ($file in $trackedText) {
    $content = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    if ($content -match $absolutePathPattern) { Add-ReleaseError "发现本机绝对路径：$($file.FullName)" }
    if ($content -match $secretPattern) { Add-ReleaseError "发现疑似真实凭据：$($file.FullName)" }
    if ($content -match '(?i)gitee\.com') { Add-ReleaseError "公开入口仍包含 Gitee 地址：$($file.FullName)" }
    if ($content -match '(?i)Authorization:\s*Bearer\s+(?!\$\{|%|<)[A-Za-z0-9._-]{16,}') {
        Add-ReleaseError "发现未脱敏 Bearer 凭据：$($file.FullName)"
    }
}

# 检查 Markdown 相对链接；模板占位符和外部链接不参与本地存在性检查。
foreach ($file in @($trackedText | Where-Object { $_.Extension.ToLowerInvariant() -eq '.md' })) {
    $content = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    foreach ($match in [regex]::Matches($content, '\[[^\]]+\]\(([^)]+)\)')) {
        $target = $match.Groups[1].Value.Trim().Trim('<', '>')
        if ([string]::IsNullOrWhiteSpace($target) -or $target -match '^(?:https?://|mailto:|#|\{\{)') { continue }
        $target = ($target -split '[?#]', 2)[0]
        try { $target = [Uri]::UnescapeDataString($target) } catch { Add-ReleaseError "链接编码无法解析：$($file.FullName) -> $target"; continue }
        $resolved = Join-Path $file.DirectoryName ($target.Replace('/', '\'))
        if (-not (Test-Path -LiteralPath $resolved)) {
            Add-ReleaseError "相对链接目标不存在：$($file.FullName) -> $target"
        }
    }
}

# 所有 PowerShell 文件都必须能被 Windows PowerShell 5.1 解析。
foreach ($file in @($trackedText | Where-Object { $_.Extension.ToLowerInvariant() -eq '.ps1' })) {
    $tokens = $null
    $parseErrors = $null
    [System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref]$tokens, [ref]$parseErrors) | Out-Null
    if ($parseErrors.Count -gt 0) { Add-ReleaseError "PowerShell 语法错误：$($file.FullName)" }
}

if ($errors.Count -gt 0) {
    $errors | Sort-Object -Unique | ForEach-Object { Write-Error $_ }
    throw "候选包验证失败，共发现 $(@($errors | Sort-Object -Unique).Count) 项问题。"
}

$skillCount = if ($catalog) { @($catalog.skills).Count } else { 0 }
$fileCount = if ($manifest) { @($manifest.files).Count } else { 0 }
Write-Output "候选包验证通过：版本 $($manifest.version)，技能 $skillCount 项，发布清单文件 $fileCount 项。"
