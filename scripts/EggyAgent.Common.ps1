$ErrorActionPreference = 'Stop'

$script:EggyAgentBlockStart = '<!-- EGGY-AGENT:BEGIN -->'
$script:EggyAgentBlockEnd = '<!-- EGGY-AGENT:END -->'

function Resolve-EggyDirectory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Label
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        throw "$Label 不存在：$Path"
    }

    return (Resolve-Path -LiteralPath $Path).Path.TrimEnd('\', '/')
}

function Test-EggyPathInside {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Root,

        [Parameter(Mandatory = $true)]
        [string]$Candidate
    )

    $rootPath = [System.IO.Path]::GetFullPath($Root).TrimEnd('\', '/')
    $candidatePath = [System.IO.Path]::GetFullPath($Candidate).TrimEnd('\', '/')
    if ($candidatePath.Equals($rootPath, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $true
    }

    return $candidatePath.StartsWith(
        $rootPath + [System.IO.Path]::DirectorySeparatorChar,
        [System.StringComparison]::OrdinalIgnoreCase
    )
}

function Get-EggyRelativePath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Root,

        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $rootPath = [System.IO.Path]::GetFullPath($Root).TrimEnd('\', '/')
    $fullPath = [System.IO.Path]::GetFullPath($Path)
    if (-not (Test-EggyPathInside -Root $rootPath -Candidate $fullPath)) {
        throw "路径位于工作区之外，拒绝处理：$fullPath"
    }

    if ($fullPath.Equals($rootPath, [System.StringComparison]::OrdinalIgnoreCase)) {
        return '.'
    }

    return $fullPath.Substring($rootPath.Length + 1).Replace('\', '/')
}

function Write-EggyUtf8File {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$Content
    )

    $parent = Split-Path -Parent $Path
    if ($parent) {
        [System.IO.Directory]::CreateDirectory($parent) | Out-Null
    }

    $encoding = New-Object System.Text.UTF8Encoding($false)
    $temporary = "$Path.eggy-agent.tmp"
    [System.IO.File]::WriteAllText($temporary, $Content, $encoding)
    Move-Item -LiteralPath $temporary -Destination $Path -Force
}

function Copy-EggyFileAtomic {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,

        [Parameter(Mandatory = $true)]
        [string]$Destination
    )

    if (-not (Test-Path -LiteralPath $Source -PathType Leaf)) {
        throw "安装包文件不存在：$Source"
    }

    $parent = Split-Path -Parent $Destination
    [System.IO.Directory]::CreateDirectory($parent) | Out-Null
    $temporary = "$Destination.eggy-agent.tmp"
    Copy-Item -LiteralPath $Source -Destination $temporary -Force
    Move-Item -LiteralPath $temporary -Destination $Destination -Force
}

function Get-EggySha256 {
    param([Parameter(Mandatory = $true)][string]$Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return $null
    }

    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Read-EggyJson {
    param([Parameter(Mandatory = $true)][string]$Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "数据文件不存在：$Path"
    }

    return Get-Content -LiteralPath $Path -Raw -Encoding UTF8 | ConvertFrom-Json
}

function Write-EggyJson {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [object]$Value
    )

    $content = $Value | ConvertTo-Json -Depth 12
    Write-EggyUtf8File -Path $Path -Content ($content + [Environment]::NewLine)
}

function Assert-EggyPackageManifest {
    param([Parameter(Mandatory = $true)][string]$PackageRoot)

    $manifestPath = Join-Path $PackageRoot 'release-manifest.json'
    $manifest = Read-EggyJson -Path $manifestPath
    if (-not $manifest.version -or -not $manifest.files) {
        throw '发布清单缺少版本号或受管文件列表。'
    }
    if ([int]$manifest.schemaVersion -ne 1 -or [string]$manifest.edition -ne 'dual') {
        throw '发布清单格式或地图版本不受支持。'
    }

    $seenSources = @{}
    $seenTargets = @{}
    foreach ($entry in @($manifest.files)) {
        $relative = ([string]$entry.path).Replace('\', '/')
        $target = ([string]$entry.target).Replace('\', '/')
        if (-not $relative -or -not $target) {
            throw '发布清单包含缺少来源或目标路径的条目。'
        }
        if ([System.IO.Path]::IsPathRooted($relative) -or $relative -match '(^|/)(?:\.|\.\.)(/|$)') {
            throw "发布清单包含不安全来源路径：$relative"
        }
        if ([System.IO.Path]::IsPathRooted($target) -or $target -match '(^|/)(?:\.|\.\.)(/|$)') {
            throw "发布清单包含不安全目标路径：$target"
        }
        if ($relative -notmatch '^(?:skills/eggy-[a-z0-9-]+/|scripts/|templates/)' -or
            $target -notmatch '^(?:\.agents/skills/eggy-[a-z0-9-]+/|\.eggy-agent/(?:scripts|templates)/)') {
            throw "发布清单包含超出公开工具受管区的路径：$relative -> $target"
        }
        if ($seenSources.ContainsKey($relative) -or $seenTargets.ContainsKey($target)) {
            throw "发布清单包含重复来源或目标：$relative -> $target"
        }
        $seenSources[$relative] = $true
        $seenTargets[$target] = $true

        $source = Join-Path $PackageRoot ($relative.Replace('/', '\'))
        $actual = Get-EggySha256 -Path $source
        if (-not $actual -or $actual -ne ([string]$entry.sha256).ToLowerInvariant()) {
            throw "安装包文件指纹不一致：$relative"
        }
    }

    return $manifest
}

function Get-EggyManagedBlock {
    param([Parameter(Mandatory = $true)][string]$Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return $null
    }

    $content = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
    $start = $content.IndexOf($script:EggyAgentBlockStart, [System.StringComparison]::Ordinal)
    $finish = $content.IndexOf($script:EggyAgentBlockEnd, [System.StringComparison]::Ordinal)
    if (($start -ge 0) -xor ($finish -ge 0)) {
        throw "规则文件的受管标记不完整：$Path"
    }
    if ($start -lt 0) {
        return $null
    }
    if ($finish -lt $start) {
        throw "规则文件的受管标记顺序错误：$Path"
    }

    return $content.Substring($start, $finish + $script:EggyAgentBlockEnd.Length - $start)
}

function Set-EggyManagedBlock {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Body
    )

    $block = $script:EggyAgentBlockStart + [Environment]::NewLine +
        $Body.Trim() + [Environment]::NewLine + $script:EggyAgentBlockEnd
    $existing = if (Test-Path -LiteralPath $Path -PathType Leaf) {
        Get-Content -LiteralPath $Path -Raw -Encoding UTF8
    } else {
        ''
    }

    $oldBlock = Get-EggyManagedBlock -Path $Path
    if ($null -ne $oldBlock) {
        $updated = $existing.Replace($oldBlock, $block)
    } elseif ([string]::IsNullOrWhiteSpace($existing)) {
        $updated = $block + [Environment]::NewLine
    } else {
        $updated = $existing.TrimEnd() + [Environment]::NewLine + [Environment]::NewLine +
            $block + [Environment]::NewLine
    }

    Write-EggyUtf8File -Path $Path -Content $updated
    return $block
}

function Remove-EggyManagedBlock {
    param([Parameter(Mandatory = $true)][string]$Path)

    $block = Get-EggyManagedBlock -Path $Path
    if ($null -eq $block) {
        return
    }

    $content = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
    $updated = $content.Replace($block, '').Trim()
    if ($updated) {
        Write-EggyUtf8File -Path $Path -Content ($updated + [Environment]::NewLine)
    } else {
        Remove-Item -LiteralPath $Path -Force
    }
}

function Get-EggyTextSha256 {
    param([Parameter(Mandatory = $true)][string]$Text)

    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text)
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        return (($sha.ComputeHash($bytes) | ForEach-Object { $_.ToString('x2') }) -join '')
    } finally {
        $sha.Dispose()
    }
}

function New-EggyBackup {
    param(
        [Parameter(Mandatory = $true)]
        [string]$WorkspaceRoot,

        [Parameter(Mandatory = $true)]
        [string[]]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Reason
    )

    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss-fff'
    $backupRoot = Join-Path $WorkspaceRoot ".eggy-agent\backups\$stamp-$Reason"
    [System.IO.Directory]::CreateDirectory((Join-Path $backupRoot 'files')) | Out-Null
    $records = @()
    foreach ($candidate in @($Path | Sort-Object -Unique)) {
        $fullPath = [System.IO.Path]::GetFullPath($candidate)
        $relative = Get-EggyRelativePath -Root $WorkspaceRoot -Path $fullPath
        if (Test-Path -LiteralPath $fullPath -PathType Container) {
            throw "备份接口只接受文件，不能直接传目录：$fullPath"
        }

        $exists = Test-Path -LiteralPath $fullPath -PathType Leaf
        if ($exists) {
            $backupFile = Join-Path (Join-Path $backupRoot 'files') ($relative.Replace('/', '\'))
            $parent = Split-Path -Parent $backupFile
            [System.IO.Directory]::CreateDirectory($parent) | Out-Null
            Copy-Item -LiteralPath $fullPath -Destination $backupFile -Force
        }

        $records += [pscustomobject]@{
            path = $relative
            existed = [bool]$exists
        }
    }

    Write-EggyJson -Path (Join-Path $backupRoot 'backup.json') -Value ([pscustomobject]@{
        createdAt = (Get-Date).ToString('o')
        reason = $Reason
        workspaceRoot = $WorkspaceRoot
        files = $records
    })
    return $backupRoot
}

function Restore-EggyBackupInternal {
    param(
        [Parameter(Mandatory = $true)]
        [string]$WorkspaceRoot,

        [Parameter(Mandatory = $true)]
        [string]$BackupRoot
    )

    $manifest = Read-EggyJson -Path (Join-Path $BackupRoot 'backup.json')
    foreach ($entry in @($manifest.files)) {
        $destination = Join-Path $WorkspaceRoot (([string]$entry.path).Replace('/', '\'))
        if (-not (Test-EggyPathInside -Root $WorkspaceRoot -Candidate $destination)) {
            throw "备份记录包含工作区外路径：$destination"
        }

        if ([bool]$entry.existed) {
            $source = Join-Path (Join-Path $BackupRoot 'files') (([string]$entry.path).Replace('/', '\'))
            Copy-EggyFileAtomic -Source $source -Destination $destination
        } elseif (Test-Path -LiteralPath $destination -PathType Leaf) {
            Remove-Item -LiteralPath $destination -Force
        }
    }
}

function Get-EggyRuleBody {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TemplatePath,

        [Parameter(Mandatory = $true)]
        [string]$WorkspaceRoot,

        [string]$ProjectPath = '',

        [ValidateSet('Single', 'Multiplayer')]
        [string]$PlayerMode = 'Single',

        [ValidateSet('Origin', 'World')]
        [string]$Edition = 'Origin'
    )

    $modeText = if ($PlayerMode -eq 'Multiplayer') { '多人地图' } else { '单人地图' }
    $editionText = Get-EggyEditionLabel -Edition $Edition
    $editionRules = if ($Edition -eq 'World') {
        @'
- 世界版是服务端权威状态、客户端本地表现、公共目录共享协议的结构。服务端、客户端和公共代码的职责必须先划清，禁止跨侧持有或修改不属于本侧的状态。
- `server/main.lua`、`client/main.lua` 只做必要装配与初始化，功能代码放对应侧的自建模块；`common` 只放双方都能安全使用的事件、常量和纯逻辑。
- `server/_trigger`、`data`、接口定义、工程配置、`.codemaker` 和 `.vscode` 属于官方生成内容，保持只读。
- 调用写法必须逐项以当前工程声明为准：实例或服务方法常见冒号，静态构造常见点号，禁止把世界版简化成全部同一种写法。
'@
    } else {
        @'
- 原点版按当前工程的帧同步与沙箱规则开发。涉及玩家状态时仍要按单人或多人明确数据归属和显示对象。
- 根目录 `main.lua` 只做必要装配与初始化，功能代码放自建模块；`Data`、接口定义、工程配置、`.codemaker` 和 `.vscode` 属于官方生成内容，保持只读。
- 调用写法必须逐项以当前工程声明为准，禁止凭其他地图或世界版代码猜测点号、冒号和参数关系。
'@
    }
    return (Get-Content -LiteralPath $TemplatePath -Raw -Encoding UTF8).
        Replace('{{WORKSPACE_ROOT}}', $WorkspaceRoot).
        Replace('{{PROJECT_PATH}}', $ProjectPath).
        Replace('{{PLAYER_MODE}}', $modeText).
        Replace('{{EDITION}}', $editionText).
        Replace('{{EDITION_RULES}}', $editionRules.Trim())
}

function ConvertTo-EggyBoolean {
    param(
        [Parameter(Mandatory = $true)]
        [object]$Value,

        [Parameter(Mandatory = $true)]
        [string]$Source
    )

    if ($Value -is [bool]) {
        return [bool]$Value
    }
    if ([string]$Value -match '^(?i:true|false)$') {
        return [System.Convert]::ToBoolean([string]$Value)
    }
    throw "工程版本标记不是布尔值：$Source"
}

function Get-EggyProjectEdition {
    param([Parameter(Mandatory = $true)][string]$ProjectPath)

    $project = Resolve-EggyDirectory -Path $ProjectPath -Label '地图工程目录'
    $flags = @()
    foreach ($definition in @(
        @('eggy.json', 'isSEMap'),
        @('.codemaker\config.json', 'is_se_mode')
    )) {
        $path = Join-Path $project $definition[0]
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
            continue
        }
        $json = Read-EggyJson -Path $path
        if ($json.PSObject.Properties.Name -contains $definition[1]) {
            $flags += [pscustomobject]@{
                source = "$($definition[0]):$($definition[1])"
                value = ConvertTo-EggyBoolean -Value $json.($definition[1]) -Source $path
            }
        }
    }

    if ($flags.Count -gt 1 -and @($flags.value | Sort-Object -Unique).Count -gt 1) {
        $details = ($flags | ForEach-Object { "$($_.source)=$($_.value)" }) -join '；'
        throw "工程版本标记相互冲突，拒绝猜测：$details"
    }
    if ($flags.Count -gt 0) {
        return $(if ([bool]$flags[0].value) { 'World' } else { 'Origin' })
    }

    $hasWorldStructure = (Test-Path -LiteralPath (Join-Path $project 'client') -PathType Container) -and
        (Test-Path -LiteralPath (Join-Path $project 'server') -PathType Container) -and
        (Test-Path -LiteralPath (Join-Path $project 'common') -PathType Container)
    if ($hasWorldStructure) {
        return 'World'
    }

    if ((Test-Path -LiteralPath (Join-Path $project 'main.lua') -PathType Leaf) -and
        (Test-Path -LiteralPath (Join-Path $project 'EggyAPI.lua') -PathType Leaf)) {
        return 'Origin'
    }

    throw '无法从工程标记或目录结构确认原点版/世界版，安装已停止。'
}

function Get-EggyEditionLabel {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('Origin', 'World')]
        [string]$Edition
    )

    return $(if ($Edition -eq 'World') { '世界版' } else { '原点版' })
}

function ConvertTo-EggyStateV2 {
    param([Parameter(Mandatory = $true)][object]$State)

    $schemaVersion = if ($State.PSObject.Properties.Name -contains 'schemaVersion') {
        [int]$State.schemaVersion
    } else {
        1
    }
    if ($schemaVersion -eq 2) {
        if (-not ($State.PSObject.Properties.Name -contains 'projects')) {
            throw '安装状态缺少地图登记清单。'
        }
        return $State
    }
    if ($schemaVersion -ne 1 -or -not [string]$State.projectPath) {
        throw "不支持的安装状态格式：$schemaVersion"
    }

    $edition = Get-EggyProjectEdition -ProjectPath ([string]$State.projectPath)
    $project = [pscustomobject]@{
        path = [string]$State.projectPath
        edition = $edition
        playerMode = [string]$State.playerMode
        projectRuleBlockSha256 = [string]$State.projectRuleBlockSha256
        userOwnedDocuments = @($State.userOwnedDocuments)
    }
    return [pscustomobject]@{
        schemaVersion = 2
        version = [string]$State.version
        installedAt = [string]$State.installedAt
        workspaceRoot = [string]$State.workspaceRoot
        enabled = [bool]$State.enabled
        rulesEnabled = [bool]$State.rulesEnabled
        managedFiles = @($State.managedFiles)
        rootRuleBlockSha256 = [string]$State.rootRuleBlockSha256
        projects = @($project)
        latestBackup = [string]$State.latestBackup
    }
}

function Get-EggyStateProject {
    param(
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][string]$ProjectPath
    )

    $wanted = [System.IO.Path]::GetFullPath($ProjectPath).TrimEnd('\', '/')
    return @($State.projects | Where-Object {
        [System.IO.Path]::GetFullPath([string]$_.path).TrimEnd('\', '/').Equals(
            $wanted,
            [System.StringComparison]::OrdinalIgnoreCase
        )
    })
}

function Get-EggyManagedDestinationRecords {
    param(
        [Parameter(Mandatory = $true)]
        [object]$Manifest,

        [Parameter(Mandatory = $true)]
        [string]$WorkspaceRoot
    )

    return @($Manifest.files | ForEach-Object {
        $destination = Join-Path $WorkspaceRoot (([string]$_.target).Replace('/', '\'))
        if (-not (Test-EggyPathInside -Root $WorkspaceRoot -Candidate $destination)) {
            throw "发布清单目标位于工作区之外：$destination"
        }
        [pscustomobject]@{
            sourcePath = [string]$_.path
            destinationPath = $destination
            target = [string]$_.target
            sha256 = [string]$_.sha256
        }
    })
}

function Get-EggyInstalledTargetPath {
    param(
        [Parameter(Mandatory = $true)][string]$WorkspaceRoot,
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][string]$Target
    )

    $skillPrefix = '.agents/skills/'
    if (-not [bool]$State.enabled -and $Target.StartsWith($skillPrefix)) {
        $relative = $Target.Substring($skillPrefix.Length).Replace('/', '\')
        return Join-Path (Join-Path $WorkspaceRoot '.eggy-agent\disabled-skills') $relative
    }
    return Join-Path $WorkspaceRoot ($Target.Replace('/', '\'))
}

function Test-EggyInstalledFiles {
    param(
        [Parameter(Mandatory = $true)][string]$WorkspaceRoot,
        [Parameter(Mandatory = $true)][object]$State
    )

    $conflicts = @()
    foreach ($entry in @($State.managedFiles)) {
        $destination = Get-EggyInstalledTargetPath -WorkspaceRoot $WorkspaceRoot -State $State -Target ([string]$entry.target)
        if ((Get-EggySha256 -Path $destination) -ne ([string]$entry.sha256).ToLowerInvariant()) {
            $conflicts += [string]$entry.target
        }
    }
    return @($conflicts)
}
