[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,

    [switch]$Staged
)

$ErrorActionPreference = 'Stop'

# 所有 Git 调用都限定在当前工程，并用单次参数处理仓库所有权检查；
# 这样不会为了代理运行而改动用户电脑的全局 Git 配置。
function Invoke-ProjectGit {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    $gitArguments = @(
        '-c', "safe.directory=$script:SafeDirectory",
        '-c', 'core.quotepath=false',
        '-C', $script:ResolvedProject
    ) + $Arguments
    # 2026-07-27 修复：git 输出为 UTF-8，而中文 Windows 控制台默认按 GBK(936) 解码，
    # 含中文的仓库路径会变乱码，导致下方"工程目录 == 仓库根目录"比对永远不相等、
    # 脚本在中文路径工程下必然误报"仓库边界错误"。此处临时切换控制台输出编码为
    # UTF-8 并在调用后恢复，不改动系统或全局 Git 配置。
    # 同日加固：状态保存与恢复全部放入 try/finally 保护路径——编码读取失败（无控制台宿主）
    # 时 ErrorActionPreference 仍能恢复；恢复编码本身失败时吞掉该次要异常，不掩盖原始错误。
    $previousErrorAction = $ErrorActionPreference
    $previousConsoleEncoding = $null
    try {
        $ErrorActionPreference = 'Continue'
        try { $previousConsoleEncoding = [Console]::OutputEncoding } catch {}
        if ($null -ne $previousConsoleEncoding) {
            try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch { $previousConsoleEncoding = $null }
        }
        $output = @(& git @gitArguments 2>&1)
        $exitCode = $LASTEXITCODE
    } finally {
        if ($null -ne $previousConsoleEncoding) {
            try { [Console]::OutputEncoding = $previousConsoleEncoding } catch {}
        }
        $ErrorActionPreference = $previousErrorAction
    }

    return [PSCustomObject]@{
        ExitCode = $exitCode
        Output   = @($output | ForEach-Object { $_.ToString() })
    }
}

function Assert-GitSuccess {
    param(
        [Parameter(Mandatory = $true)]
        [PSCustomObject]$Result,

        [Parameter(Mandatory = $true)]
        [string]$Action
    )

    if ($Result.ExitCode -ne 0) {
        $detail = ($Result.Output -join [Environment]::NewLine)
        throw "$Action 失败。$detail"
    }
}

function Normalize-PathForComparison {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $fullPath = [System.IO.Path]::GetFullPath($Path)
    return $fullPath.TrimEnd([char]'\', [char]'/')
}

if (-not (Test-Path -LiteralPath $ProjectPath -PathType Container)) {
    throw "工程目录不存在：$ProjectPath"
}

$script:ResolvedProject = (Resolve-Path -LiteralPath $ProjectPath).Path
$script:SafeDirectory = $script:ResolvedProject.Replace('\', '/')

$rootResult = Invoke-ProjectGit -Arguments @('rev-parse', '--show-toplevel')
Assert-GitSuccess -Result $rootResult -Action '读取仓库根目录'

$reportedRoot = ($rootResult.Output | Select-Object -Last 1).Trim()
$expectedRoot = Normalize-PathForComparison -Path $script:ResolvedProject
$actualRoot = Normalize-PathForComparison -Path $reportedRoot
if (-not [string]::Equals($expectedRoot, $actualRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "仓库边界错误：当前工程是 $expectedRoot，但 Git 根目录是 $actualRoot。禁止跨地图提交。"
}

$branchResult = Invoke-ProjectGit -Arguments @('symbolic-ref', '--quiet', '--short', 'HEAD')
$branch = if ($branchResult.ExitCode -eq 0) {
    ($branchResult.Output | Select-Object -Last 1).Trim()
} else {
    '<分离状态或尚无分支>'
}

$headResult = Invoke-ProjectGit -Arguments @('rev-parse', '--verify', 'HEAD')
$hasHead = $headResult.ExitCode -eq 0
$head = if ($hasHead) {
    ($headResult.Output | Select-Object -Last 1).Trim()
} else {
    '<尚无提交>'
}

$statusResult = Invoke-ProjectGit -Arguments @('status', '--short', '--branch', '--untracked-files=all')
Assert-GitSuccess -Result $statusResult -Action '读取工作区状态'

Write-Output "仓库根目录：$actualRoot"
Write-Output "当前分支：$branch"
Write-Output "当前提交：$head"
Write-Output '工作区状态：'
$worktreeStatus = @($statusResult.Output | Where-Object { -not $_.StartsWith('## ') })
if ($worktreeStatus.Count -eq 0) {
    Write-Output '  <干净>'
} else {
    $worktreeStatus | ForEach-Object { Write-Output "  $_" }
}

if (-not $Staged) {
    exit 0
}

$stagedResult = Invoke-ProjectGit -Arguments @('diff', '--cached', '--name-only', '--diff-filter=ACMR', '--')
Assert-GitSuccess -Result $stagedResult -Action '读取暂存文件'
$stagedFiles = @($stagedResult.Output | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
if ($stagedFiles.Count -eq 0) {
    throw '暂存区没有可提交文件。'
}

# 这些路径由编辑器、运行时或代理工具自动维护，提交后既容易产生噪声，
# 也可能把日志、机器配置或官方生成内容误当成项目源码。
$forbiddenPathPattern = '^(\.codemaker/|\.vscode/|\.omo/|\.opencode/|\.agents/|\.codegraph/|\.workbuddy/|\.claude/|data/|EggyAPI\.lua$|EggyEditorAPI\.lua$|DebugTools\.lua$|eggy\.json$|UserDefault\.json$|log\.txt$|profile(_zh)?\.html$|\.env($|\.)|.*\.(pem|pfx|p12|key)$|id_(rsa|ed25519)$)'
$forbiddenFiles = @($stagedFiles | Where-Object { $_ -match $forbiddenPathPattern })
if ($forbiddenFiles.Count -gt 0) {
    $listed = $forbiddenFiles -join ', '
    throw "暂存区含禁止提交的官方生成、运行时、代理临时或凭据文件：$listed"
}

$diffResult = Invoke-ProjectGit -Arguments @('diff', '--cached', '--no-ext-diff', '--unified=0', '--')
Assert-GitSuccess -Result $diffResult -Action '读取暂存差异'

# 只检查新增行，并且从不把命中的凭据正文打印到终端，避免审查工具造成二次泄露。
$secretPatterns = @(
    'ark-[A-Za-z0-9-]{20,}',
    'sk-[A-Za-z0-9_-]{20,}',
    'ghp_[A-Za-z0-9]{20,}',
    'github_pat_[A-Za-z0-9_]{20,}',
    '(?i)Authorization:\s*Bearer\s+(?!\$\{|%|<)[A-Za-z0-9._-]{16,}',
    '(?i)(api[_-]?key|token|secret|password)\s*[:=]\s*[A-Za-z0-9._-]{16,}'
)

$currentFile = '<未知文件>'
$secretHitFiles = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
foreach ($line in $diffResult.Output) {
    if ($line.StartsWith('+++ b/')) {
        $currentFile = $line.Substring(6)
        continue
    }

    if (-not $line.StartsWith('+') -or $line.StartsWith('+++')) {
        continue
    }

    $addedContent = $line.Substring(1)
    foreach ($pattern in $secretPatterns) {
        if ($addedContent -match $pattern) {
            [void]$secretHitFiles.Add($currentFile)
            break
        }
    }
}

if ($secretHitFiles.Count -gt 0) {
    $listed = (@($secretHitFiles) | Sort-Object) -join ', '
    throw "暂存差异疑似含真实凭据：$listed。工具已隐藏命中内容，请先脱敏后再提交。"
}

$whitespaceResult = Invoke-ProjectGit -Arguments @('diff', '--cached', '--check', '--')
$existingWhitespaceWarning = $false
if ($whitespaceResult.ExitCode -ne 0) {
    $detail = ($whitespaceResult.Output -join [Environment]::NewLine)
    if ($hasHead) {
        throw "暂存差异存在空白错误。$detail"
    }

    $existingWhitespaceWarning = $true
    Write-Warning '首个当前状态基线包含既有空白问题；为避免批量改写业务代码，本次只报告而不自动修复。后续批次不得新增空白错误。'
}

if ($existingWhitespaceWarning) {
    Write-Output '暂存审查通过：未发现禁止路径或常见真实凭据模式；既有空白问题已单独报告并原样保留。'
} else {
    Write-Output '暂存审查通过：未发现禁止路径、常见真实凭据模式或空白错误。'
}
Write-Output '暂存文件：'
$stagedFiles | ForEach-Object { Write-Output "  $_" }
