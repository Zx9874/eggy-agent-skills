[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$UpstreamRoot,
    [string]$PackageRoot = '',
    [switch]$Check
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

if (-not $PackageRoot) { $PackageRoot = Join-Path $PSScriptRoot '..' }
$upstream = Resolve-EggyDirectory -Path $UpstreamRoot -Label 'Ponytail 上游目录'
$package = Resolve-EggyDirectory -Path $PackageRoot -Label '技能包目录'
$sourceSkillRoot = Join-Path $upstream 'skills'
$snapshotRoot = Join-Path $package 'skills\eggy-ponytail\references\upstream'
$recordPath = Join-Path $snapshotRoot '..\upstream-source.json'

$snapshots = @(
    [pscustomobject]@{ Name = 'ponytail'; Source = 'ponytail\SKILL.md'; Snapshot = 'ponytail-SKILL.md' },
    [pscustomobject]@{ Name = 'ponytail-audit'; Source = 'ponytail-audit\SKILL.md'; Snapshot = 'ponytail-audit-SKILL.md' },
    [pscustomobject]@{ Name = 'ponytail-review'; Source = 'ponytail-review\SKILL.md'; Snapshot = 'ponytail-review-SKILL.md' },
    [pscustomobject]@{ Name = 'ponytail-debt'; Source = 'ponytail-debt\SKILL.md'; Snapshot = 'ponytail-debt-SKILL.md' },
    [pscustomobject]@{ Name = 'ponytail-gain'; Source = 'ponytail-gain\SKILL.md'; Snapshot = 'ponytail-gain-SKILL.md' },
    [pscustomobject]@{ Name = 'ponytail-help'; Source = 'ponytail-help\SKILL.md'; Snapshot = 'ponytail-help-SKILL.md' }
)

$licenseSource = Join-Path $upstream 'LICENSE'
$licenseDestination = Join-Path $package 'skills\eggy-ponytail\LICENSE'
$dirty = Invoke-EggyGit -ProjectRoot $upstream -Arguments @('status', '--porcelain')
if ($dirty.ExitCode -ne 0) { throw "无法检查 Ponytail 上游工作区：$($dirty.Output -join ' ')" }
if (@($dirty.Output | Where-Object { $_.Trim() }).Count -gt 0) {
    throw 'Ponytail 上游工作区有未提交改动；请先提交或清理，再同步公开快照。'
}
$git = Invoke-EggyGit -ProjectRoot $upstream -Arguments @('rev-parse', 'HEAD')
if ($git.ExitCode -ne 0) { throw "无法读取 Ponytail 上游提交：$($git.Output -join ' ')" }
$commit = ($git.Output | Select-Object -Last 1).Trim()
if (-not $commit) { throw 'Ponytail 上游没有可用的 Git 提交。' }

$record = Read-EggyJson -Path $recordPath
$recordByName = @{}
foreach ($entry in @($record.files)) { $recordByName[[string]$entry.name] = $entry }
$mismatches = @()
$updatedFiles = @()

foreach ($snapshot in $snapshots) {
    $source = Join-Path $sourceSkillRoot $snapshot.Source
    $destination = Join-Path $snapshotRoot $snapshot.Snapshot
    if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
        throw "Ponytail 上游技能缺失：$source"
    }
    $sourceHash = Get-EggySha256 -Path $source
    $destinationHash = Get-EggySha256 -Path $destination
    $recordHash = if ($recordByName.ContainsKey($snapshot.Name)) { [string]$recordByName[$snapshot.Name].sha256 } else { '' }
    if ($sourceHash -ne $destinationHash -or $sourceHash -ne $recordHash) {
        $mismatches += $snapshot.Name
    }
    $updatedFiles += [pscustomobject]@{
        name = $snapshot.Name
        snapshot = 'references/upstream/' + $snapshot.Snapshot
        sha256 = $sourceHash
    }
}

if (-not (Test-Path -LiteralPath $licenseSource -PathType Leaf)) {
    throw "Ponytail 上游许可证缺失：$licenseSource"
}
$licenseHash = Get-EggySha256 -Path $licenseSource
if ($licenseHash -ne (Get-EggySha256 -Path $licenseDestination) -or
    [string]$record.licenseSha256 -ne $licenseHash) {
    $mismatches += 'LICENSE'
}
if ([string]$record.sourceCommit -ne $commit) { $mismatches += 'sourceCommit' }

if ($Check) {
    if ($mismatches.Count -gt 0) {
        throw "Ponytail 上游快照未同步：$($mismatches -join ', ')"
    }
    Write-Output "Ponytail 上游快照已同步：$commit"
    exit 0
}

foreach ($snapshot in $snapshots) {
    $source = Join-Path $sourceSkillRoot $snapshot.Source
    $destination = Join-Path $snapshotRoot $snapshot.Snapshot
    Copy-EggyFileAtomic -Source $source -Destination $destination
}
Copy-EggyFileAtomic -Source $licenseSource -Destination $licenseDestination

$nextRecord = [pscustomobject]@{
    schemaVersion = 1
    sourceUrl = [string]$(if ($record.sourceUrl) { $record.sourceUrl } else { 'https://github.com/DietrichGebert/ponytail' })
    sourceCommit = $commit
    files = $updatedFiles
    licenseSha256 = $licenseHash
}
Write-EggyJson -Path $recordPath -Value $nextRecord
Write-Output "Ponytail 上游快照已更新：$commit，文件 $($snapshots.Count) 项及许可证 1 项。"
