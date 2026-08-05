[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$WorkspaceRoot,

    [string]$BackupPath
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

$workspace = Resolve-EggyDirectory -Path $WorkspaceRoot -Label '总工作区目录'
$backupBase = Join-Path $workspace '.eggy-agent\backups'
if ($BackupPath) {
    $backup = Resolve-EggyDirectory -Path $BackupPath -Label '备份目录'
} else {
    $latest = Get-ChildItem -LiteralPath $backupBase -Directory -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if (-not $latest) {
        throw '没有找到可恢复的安装或升级备份。'
    }
    $backup = $latest.FullName
}

if (-not (Test-EggyPathInside -Root $backupBase -Candidate $backup)) {
    throw '只能恢复本工具包自己生成的备份。'
}

Restore-EggyBackupInternal -WorkspaceRoot $workspace -BackupRoot $backup
Write-Output "恢复结果：已恢复备份 $backup"
Write-Output '重要：请用代理打开总工作区并新建会话，避免继续使用恢复前已经加载的规则或技能。'
