[CmdletBinding()]
param(
    [string]$PackageRoot
)

$ErrorActionPreference = 'Stop'
if (-not $PackageRoot) {
    $PackageRoot = Join-Path $PSScriptRoot '..'
}
$root = (Resolve-Path -LiteralPath $PackageRoot).Path
$versionPath = Join-Path $root 'VERSION'
if (-not (Test-Path -LiteralPath $versionPath -PathType Leaf)) {
    throw '缺少 VERSION（版本号文件）。'
}
$version = (Get-Content -LiteralPath $versionPath -Raw -Encoding UTF8).Trim()
if ($version -notmatch '^\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?$') {
    throw "版本号格式不正确：$version"
}

$entries = @()
$skillRoot = Join-Path $root 'skills'
foreach ($file in Get-ChildItem -LiteralPath $skillRoot -Recurse -File | Where-Object { $_.Name -ne 'README.md' }) {
    $relative = $file.FullName.Substring($root.Length + 1).Replace('\', '/')
    $target = '.agents/skills/' + $file.FullName.Substring($skillRoot.Length + 1).Replace('\', '/')
    $entries += [pscustomobject]@{
        path = $relative
        target = $target
        sha256 = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
    }
}

foreach ($file in Get-ChildItem -LiteralPath (Join-Path $root 'scripts') -File -Filter '*.ps1') {
    $relative = $file.FullName.Substring($root.Length + 1).Replace('\', '/')
    $entries += [pscustomobject]@{
        path = $relative
        target = '.eggy-agent/scripts/' + $file.Name
        sha256 = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
    }
}

foreach ($file in Get-ChildItem -LiteralPath (Join-Path $root 'templates') -File) {
    $relative = $file.FullName.Substring($root.Length + 1).Replace('\', '/')
    $entries += [pscustomobject]@{
        path = $relative
        target = '.eggy-agent/templates/' + $file.Name
        sha256 = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
    }
}

$manifest = [pscustomobject]@{
    schemaVersion = 1
    version = $version
    channel = 'release-candidate'
    edition = 'dual'
    compatibleAgents = @('OpenCode', 'Codex')
    files = @($entries | Sort-Object target)
}

$encoding = New-Object System.Text.UTF8Encoding($false)
$json = $manifest | ConvertTo-Json -Depth 8
$json = $json.Replace("`r`n", "`n")
[System.IO.File]::WriteAllText((Join-Path $root 'release-manifest.json'), $json + "`n", $encoding)
Write-Output "发布清单已生成：版本 $version，受管文件 $($entries.Count) 项。"
