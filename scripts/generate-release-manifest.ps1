[CmdletBinding()]
param(
    [string]$PackageRoot
)

$ErrorActionPreference = 'Stop'
if (-not $PackageRoot) { $PackageRoot = Join-Path $PSScriptRoot '..' }
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

$root = Resolve-EggyDirectory -Path $PackageRoot -Label '公开包目录'
$version = Get-EggyPackageVersion -PackageRoot $root
$catalog = Get-EggyCatalog -PackageRoot $root
$entries = @(Get-EggyPublishSourceFiles -PackageRoot $root)

$manifest = [ordered]@{
    schemaVersion = 2
    package = [string]$(if ($catalog.package) { $catalog.package } else { 'eggy-agent-skills' })
    version = $version
    channel = 'release-candidate'
    compatibleAgents = @('OpenCode', 'Codex', 'ZCode')
    catalog = [ordered]@{
        path = 'skill-catalog.json'
        sha256 = Get-EggySha256 -Path (Join-Path $root 'skill-catalog.json')
    }
    hosts = [ordered]@{
        Codex = $catalog.hosts.Codex
        OpenCode = $catalog.hosts.OpenCode
        ZCode = $catalog.hosts.ZCode
    }
    profiles = @($catalog.profiles.PSObject.Properties | ForEach-Object { $_.Name } | Sort-Object)
    skillCount = @($catalog.skills).Count
    files = $entries
    sourceCommit = Get-EggySourceCommit -PackageRoot $root
}

Write-EggyJson -Path (Join-Path $root 'release-manifest.json') -Value ([pscustomobject]$manifest)
Write-Output "发布清单已生成：版本 $version，技能 $($manifest.skillCount) 项，受管来源文件 $($entries.Count) 项。"
