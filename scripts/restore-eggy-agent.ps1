[CmdletBinding()]
param(
    [string]$WorkspaceRoot = (Get-Location).Path,
    [string]$BackupPath,

    [ValidateSet('Project', 'Global')]
    [string]$Scope = 'Project'
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

$workspace = Resolve-EggyDirectory -Path $WorkspaceRoot -Label '总工作区目录'
$baseRoot = if ($Scope -eq 'Global') {
    ConvertTo-EggyFullPath -Path ([Environment]::GetFolderPath('UserProfile'))
} else {
    $workspace
}
$backupBase = Join-Path $baseRoot '.eggy-agent\backups'

if ($BackupPath) {
    $backup = Resolve-EggyDirectory -Path $BackupPath -Label '备份目录'
} else {
    $latest = Get-ChildItem -LiteralPath $backupBase -Directory -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if (-not $latest) { throw '没有找到可恢复的安装、升级或启停备份。' }
    $backup = $latest.FullName
}

if (-not (Test-EggyPathInside -Root $backupBase -Candidate $backup)) {
    throw '只能恢复当前安装根目录下工具生成的备份。'
}

Restore-EggyBackupInternal -WorkspaceRoot $baseRoot -BackupRoot $backup
Write-Output "恢复结果：已恢复备份 $backup"
Write-Output '恢复只回到该备份记录的文件状态；地图玩法文档不会被额外删除。'
Write-Output '请用代理打开对应工作区并新建会话，避免继续使用恢复前已经加载的技能或规则。'
