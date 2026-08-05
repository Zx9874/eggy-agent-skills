[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,

    [Parameter(Mandatory = $true)]
    [string[]]$ChangedFile
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'EggyAgent.Common.ps1')

if (-not (Test-Path -LiteralPath $ProjectPath -PathType Container)) {
    throw "Project path does not exist: $ProjectPath"
}

$project = (Resolve-Path -LiteralPath $ProjectPath).Path.TrimEnd('\')
$edition = Get-EggyProjectEdition -ProjectPath $project
$projectPrefix = $project + '\'
$normalizedFiles = @()

foreach ($rawValue in $ChangedFile) {
    foreach ($rawFile in ($rawValue -split ',')) {
        $candidate = $rawFile.Trim()
        if (-not $candidate) {
            continue
        }

        $combined = if ([System.IO.Path]::IsPathRooted($candidate)) {
            $candidate
        } else {
            Join-Path $project $candidate
        }

        if (-not (Test-Path -LiteralPath $combined -PathType Leaf)) {
            throw "Changed file does not exist: $combined"
        }

        $resolved = (Resolve-Path -LiteralPath $combined).Path
        if (-not $resolved.StartsWith($projectPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Changed file is outside the project: $resolved"
        }

        if ([System.IO.Path]::GetExtension($resolved) -ne '.lua') {
            throw "Changed file is not a Lua file: $resolved"
        }

        if ($normalizedFiles -notcontains $resolved) {
            $normalizedFiles += $resolved
        }
    }
}

if ($normalizedFiles.Count -eq 0) {
    throw 'ChangedFile does not contain a usable Lua file.'
}

# 原点版同时存在命名等级和数字等级；数字等级只按已经记录的项目约定清点，未知等级不猜。
# 世界版按当前官方定义清点 LogService 的 Output、Info、Warn、Error 和 Log；通用 Log 必须使用
# Enums.MessageType 的明确枚举值才能自动分类。通过其他变量别名调用服务时，脚本可能无法识别，仍须人工反查。
# 2026-07-27 修复：旧版把所有 LuaAPI.log 一律归为 LEGACY_LOG 并强制人工复审，
# 而本工作区项目日志几乎全部使用 LuaAPI.log 数字等级（官方定义 LuaAPI.log(_content, _log_level)，
# EggyAPI.lua 第5534行；等级数值语义官方手册未记载）。项目实际约定：3=正常调试、2=警告、1=错误；
# 等级4在项目中出现过但语义未经查证。分类规则：
#   3 与 GlobalAPI.debug 同级 -> 通过；1/2 与 GlobalAPI.error/warning 同级 -> 需人工复审其异常依据；
#   等级4、动态等级、未写等级 -> 语义未查证，进入人工复审，不做猜测放行。
# 同日二次修复（对抗验证发现三处漏洞）：
#   1. 行首 Lua 注释「--」内的日志调用归为 COMMENTED 死代码，单独统计，不再混入放行/复审口径；
#   2. 同一行含多个日志调用时归为 MULTI_CALL 交人工复审（Select-String 每行只返回一个匹配，逐个解析不可靠）；
#   3. 等级提取正则限定在 LuaAPI.log 自身括号范围内（允许一层嵌套调用），不再误读行尾无关调用的「, 数字)」。
$pattern = '(GlobalAPI\.(debug|warning|error)|LuaAPI\.log|LogService:(Output|Info|Warn|Error|Log))\s*\('
$counts = @{
    DEBUG = 0
    WARNING = 0
    ERROR = 0
    LUA_L1 = 0
    LUA_L2 = 0
    LUA_L3 = 0
    LUA_L4 = 0
    LUA_OTHER = 0
    LUA_UNPARSED = 0
    MULTI_CALL = 0
    COMMENTED = 0
    TEST_MARKED = 0
    WORLD_OUTPUT = 0
    WORLD_INFO = 0
    WORLD_WARN = 0
    WORLD_ERROR = 0
    WORLD_LOG_OUTPUT = 0
    WORLD_LOG_INFO = 0
    WORLD_LOG_WARNING = 0
    WORLD_LOG_ERROR = 0
    WORLD_LOG_UNPARSED = 0
}

Write-Output 'LOG_AUDIT_VERSION=3'
Write-Output "PROJECT=$project"
Write-Output "EDITION=$($edition.ToUpperInvariant())"
Write-Output "FILES=$($normalizedFiles.Count)"

foreach ($file in $normalizedFiles) {
    Write-Output "BEGIN_FILE=$file"
    $matches = @(Select-String -LiteralPath $file -Pattern $pattern -Encoding UTF8)

    if ($matches.Count -eq 0) {
        Write-Output 'LOG_CALL|NO_HIT'
        Write-Output "END_FILE=$file"
        continue
    }

    foreach ($match in $matches) {
        $trimmedLine = $match.Line.TrimStart()
        $callCount = ([regex]::Matches($match.Line, $pattern)).Count
        $level = if ($trimmedLine.StartsWith('--')) {
            # 行首为 Lua 注释：注释掉的日志是死代码，单独统计供清理，不参与等级审查
            'COMMENTED'
        } elseif ($callCount -gt 1) {
            # 同一行多个日志调用（含 GlobalAPI 与 LuaAPI 混写）：整行交人工复审，避免漏检
            'MULTI_CALL'
        } elseif ($match.Line -match 'GlobalAPI\.warning\s*\(') {
            'WARNING'
        } elseif ($match.Line -match 'GlobalAPI\.error\s*\(') {
            'ERROR'
        } elseif ($match.Line -match 'GlobalAPI\.debug\s*\(') {
            'DEBUG'
        } elseif ($match.Line -match 'LogService:Output\s*\(') {
            'WORLD_OUTPUT'
        } elseif ($match.Line -match 'LogService:Info\s*\(') {
            'WORLD_INFO'
        } elseif ($match.Line -match 'LogService:Warn\s*\(') {
            'WORLD_WARN'
        } elseif ($match.Line -match 'LogService:Error\s*\(') {
            'WORLD_ERROR'
        } elseif ($match.Line -match 'LogService:Log\s*\(\s*Enums\.MessageType\.(MessageOutput|MessageInfo|MessageWarning|MessageError)\s*,') {
            switch ($Matches[1]) {
                'MessageOutput' { 'WORLD_LOG_OUTPUT' }
                'MessageInfo' { 'WORLD_LOG_INFO' }
                'MessageWarning' { 'WORLD_LOG_WARNING' }
                'MessageError' { 'WORLD_LOG_ERROR' }
            }
        } elseif ($match.Line -match 'LogService:Log\s*\(') {
            'WORLD_LOG_UNPARSED'
        } elseif ($match.Line -match 'LuaAPI\.log\s*\((?:[^()]|\([^()]*\))*,\s*([0-9]+)\s*\)') {
            # 等级提取限定在 LuaAPI.log 自身括号范围内：参数允许出现一层嵌套调用（如 tostring(x)）；
            # 行尾其他调用的「, 数字)」不会被误读；嵌套超过一层或动态等级不匹配 -> 落入 LUA_UNPARSED 复审
            switch ($Matches[1]) {
                '1' { 'LUA_L1' }
                '2' { 'LUA_L2' }
                '3' { 'LUA_L3' }
                '4' { 'LUA_L4' }
                default { 'LUA_OTHER' }
            }
        } else {
            # LuaAPI.log 但等级不是字面数字（变量传参）、未写等级参数或参数嵌套过深
            'LUA_UNPARSED'
        }

        $counts[$level]++
        $testMark = ''
        if ($match.Line -match '【测试专用】') {
            $counts.TEST_MARKED++
            $testMark = '|TEST_MARKED'
        }
        $line = ($match.Line -replace '\s+', ' ').Trim()
        if ($line.Length -gt 300) {
            $line = $line.Substring(0, 300) + '...'
        }

        Write-Output ("LOG_CALL|{0}|{1}:{2}|{3}{4}" -f $level, $match.Path, $match.LineNumber, $line, $testMark)
    }
    Write-Output "END_FILE=$file"
}

Write-Output ("SUMMARY|DEBUG={0}|WARNING={1}|ERROR={2}|LUA_L1={3}|LUA_L2={4}|LUA_L3={5}|LUA_L4={6}|LUA_OTHER={7}|LUA_UNPARSED={8}|MULTI_CALL={9}|COMMENTED={10}|TEST_MARKED={11}|WORLD_OUTPUT={12}|WORLD_INFO={13}|WORLD_WARN={14}|WORLD_ERROR={15}|WORLD_LOG_OUTPUT={16}|WORLD_LOG_INFO={17}|WORLD_LOG_WARNING={18}|WORLD_LOG_ERROR={19}|WORLD_LOG_UNPARSED={20}" -f `
    $counts.DEBUG, $counts.WARNING, $counts.ERROR, $counts.LUA_L1, $counts.LUA_L2, $counts.LUA_L3, $counts.LUA_L4, $counts.LUA_OTHER, $counts.LUA_UNPARSED, $counts.MULTI_CALL, $counts.COMMENTED, $counts.TEST_MARKED, `
    $counts.WORLD_OUTPUT, $counts.WORLD_INFO, $counts.WORLD_WARN, $counts.WORLD_ERROR, $counts.WORLD_LOG_OUTPUT, $counts.WORLD_LOG_INFO, $counts.WORLD_LOG_WARNING, $counts.WORLD_LOG_ERROR, $counts.WORLD_LOG_UNPARSED)

$needsReview = $counts.WARNING + $counts.ERROR + $counts.LUA_L1 + $counts.LUA_L2 + $counts.LUA_L4 + $counts.LUA_OTHER + $counts.LUA_UNPARSED + $counts.MULTI_CALL + `
    $counts.WORLD_WARN + $counts.WORLD_ERROR + $counts.WORLD_LOG_WARNING + $counts.WORLD_LOG_ERROR + $counts.WORLD_LOG_UNPARSED
if ($needsReview -gt 0) {
    Write-Output 'LOG_AUDIT_RESULT=MANUAL_LEVEL_REVIEW_REQUIRED'
    Write-Output "REVIEW_SCOPE=需人工复审 $needsReview 处：警告/错误级须有真实异常依据；原点版未知数字等级、世界版动态日志枚举与同行多调用不得猜测。普通输出或信息级共 $($counts.DEBUG + $counts.LUA_L3 + $counts.WORLD_OUTPUT + $counts.WORLD_INFO + $counts.WORLD_LOG_OUTPUT + $counts.WORLD_LOG_INFO) 处已放行；另有注释死代码 $($counts.COMMENTED) 处。"
} else {
    Write-Output 'LOG_AUDIT_RESULT=INVENTORY_READY'
}
Write-Output 'NEXT_STEP=Compare every listed call with the task log plan and inspect its trigger frequency before completion.'
