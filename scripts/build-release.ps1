[CmdletBinding()]
param(
    [string]$PackageRoot,
    [string]$OutputDirectory
)

$ErrorActionPreference = 'Stop'
if (-not $PackageRoot) { $PackageRoot = Join-Path $PSScriptRoot '..' }
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

$root = Resolve-EggyDirectory -Path $PackageRoot -Label '公开包目录'
if (-not $OutputDirectory) { $OutputDirectory = Join-Path $root 'dist' }
$output = ConvertTo-EggyFullPath -Path $OutputDirectory
[System.IO.Directory]::CreateDirectory($output) | Out-Null

$generator = Join-Path $root 'scripts\generate-release-manifest.ps1'
$validator = Join-Path $root 'scripts\validate-release.ps1'
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $generator -PackageRoot $root
if ($LASTEXITCODE -ne 0) { throw '发布清单生成失败。' }
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $validator -PackageRoot $root
if ($LASTEXITCODE -ne 0) { throw '候选包验证失败，停止构建。' }

$manifest = Assert-EggyPackageManifest -PackageRoot $root
$version = [string]$manifest.version
$stage = Join-Path ([System.IO.Path]::GetTempPath()) "eggy-agent-release-$version-$([Guid]::NewGuid().ToString('N'))"
[System.IO.Directory]::CreateDirectory($stage) | Out-Null
try {
    foreach ($entry in @(Get-EggyPublishSourceFiles -PackageRoot $root)) {
        $source = Join-Path $root ([string]$entry.path).Replace('/', '\')
        $destination = Join-Path $stage ([string]$entry.path).Replace('/', '\')
        [System.IO.Directory]::CreateDirectory((Split-Path -Parent $destination)) | Out-Null
        Copy-Item -LiteralPath $source -Destination $destination -Force
    }
    Copy-EggyFileAtomic -Source (Join-Path $root 'release-manifest.json') -Destination (Join-Path $stage 'release-manifest.json')
    $zipPath = Join-Path $output "eggy-agent-skills-$version.zip"
    if (Test-Path -LiteralPath $zipPath -PathType Leaf) { Remove-Item -LiteralPath $zipPath -Force }
    Compress-Archive -Path (Join-Path $stage '*') -DestinationPath $zipPath -CompressionLevel Optimal
    $hash = (Get-FileHash -LiteralPath $zipPath -Algorithm SHA256).Hash.ToLowerInvariant()
    Write-Output "发布包已生成：$zipPath"
    Write-Output "SHA256：$hash"
} finally {
    if (Test-Path -LiteralPath $stage -PathType Container) { Remove-Item -LiteralPath $stage -Recurse -Force }
}
