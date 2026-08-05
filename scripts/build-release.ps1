[CmdletBinding()]
param(
    [string]$PackageRoot,
    [string]$OutputDirectory
)

$ErrorActionPreference = 'Stop'
if (-not $PackageRoot) {
    $PackageRoot = Join-Path $PSScriptRoot '..'
}
$root = (Resolve-Path -LiteralPath $PackageRoot).Path
if (-not $OutputDirectory) {
    $OutputDirectory = Join-Path $root 'dist'
}

& powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $root 'scripts\generate-release-manifest.ps1') -PackageRoot $root
if ($LASTEXITCODE -ne 0) {
    throw '无法生成发布清单。'
}

& powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $root 'scripts\validate-release.ps1') -PackageRoot $root
if ($LASTEXITCODE -ne 0) {
    throw '候选包验证没有通过，禁止生成发布包。'
}

$manifest = Get-Content -LiteralPath (Join-Path $root 'release-manifest.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$version = [string]$manifest.version
$stage = Join-Path $env:TEMP "eggy-agent-release-$version"
if (Test-Path -LiteralPath $stage) {
    Remove-Item -LiteralPath $stage -Recurse -Force
}
[System.IO.Directory]::CreateDirectory($stage) | Out-Null

$include = @(
    '.github', 'scripts', 'skills', 'templates', 'tests',
    '.gitattributes', '.gitignore', 'CONTRIBUTING.md', 'INSTALL-给agent的安装任务书.md',
    'LICENSE', 'README.md', 'START-HERE.md', 'UPDATE-给agent的升级任务书.md', 'VERSION', 'release-manifest.json'
)
foreach ($name in $include) {
    $source = Join-Path $root $name
    if (Test-Path -LiteralPath $source) {
        Copy-Item -LiteralPath $source -Destination $stage -Recurse -Force
    }
}

[System.IO.Directory]::CreateDirectory($OutputDirectory) | Out-Null
$zipPath = Join-Path $OutputDirectory "eggy-agent-skills-$version.zip"
if (Test-Path -LiteralPath $zipPath) {
    Remove-Item -LiteralPath $zipPath -Force
}
Compress-Archive -Path (Join-Path $stage '*') -DestinationPath $zipPath -CompressionLevel Optimal
$hash = (Get-FileHash -LiteralPath $zipPath -Algorithm SHA256).Hash.ToLowerInvariant()
[System.IO.File]::WriteAllText("$zipPath.sha256", "$hash  $(Split-Path $zipPath -Leaf)`r`n", (New-Object System.Text.UTF8Encoding($false)))
Remove-Item -LiteralPath $stage -Recurse -Force

Write-Output "发布包：$zipPath"
Write-Output "SHA256=$hash"
