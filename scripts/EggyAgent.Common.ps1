$ErrorActionPreference = 'Stop'

# 安装器只维护受管区块，用户在区块外写的规则和文档永远不由安装器覆盖。
$script:EggyAgentBlockStart = '<!-- EGGY-AGENT:BEGIN -->'
$script:EggyAgentBlockEnd = '<!-- EGGY-AGENT:END -->'
$script:EggyStateSchemaVersion = 4

function Test-EggyProperty {
    param(
        [AllowNull()][object]$Object,
        [Parameter(Mandatory = $true)][string]$Name
    )

    return $null -ne $Object -and $null -ne $Object.PSObject.Properties[$Name]
}

function Get-EggyPropertyValue {
    param(
        [AllowNull()][object]$Object,
        [Parameter(Mandatory = $true)][string]$Name,
        [AllowNull()][object]$Default = $null
    )

    if (Test-EggyProperty -Object $Object -Name $Name) {
        return $Object.PSObject.Properties[$Name].Value
    }
    return $Default
}

function ConvertTo-EggyFullPath {
    param([Parameter(Mandatory = $true)][string]$Path)

    $full = [System.IO.Path]::GetFullPath($Path)
    if ($full.Length -gt 3) { $full = $full.TrimEnd('\', '/') }
    return $full
}

function Resolve-EggyDirectory {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Label
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        throw "$Label 不存在：$Path"
    }
    return (ConvertTo-EggyFullPath -Path ((Resolve-Path -LiteralPath $Path).Path))
}

function Test-EggyPathInside {
    param(
        [Parameter(Mandatory = $true)][string]$Root,
        [Parameter(Mandatory = $true)][string]$Candidate
    )

    $rootPath = ConvertTo-EggyFullPath -Path $Root
    $candidatePath = ConvertTo-EggyFullPath -Path $Candidate
    if ($candidatePath.Equals($rootPath, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $true
    }
    $prefix = if ($rootPath.EndsWith('\') -or $rootPath.EndsWith('/')) { $rootPath } else { $rootPath + '\' }
    return $candidatePath.StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase)
}

function Test-EggyRelativePathSafe {
    param([Parameter(Mandatory = $true)][string]$Path)

    $normalized = $Path.Replace('\', '/')
    if ([string]::IsNullOrWhiteSpace($normalized)) { return $false }
    if ([System.IO.Path]::IsPathRooted($normalized)) { return $false }
    if ($normalized -match '(^|/)\.\.?(/|$)') { return $false }
    return $true
}

function Get-EggyRelativePath {
    param(
        [Parameter(Mandatory = $true)][string]$Root,
        [Parameter(Mandatory = $true)][string]$Path
    )

    $rootPath = ConvertTo-EggyFullPath -Path $Root
    $fullPath = ConvertTo-EggyFullPath -Path $Path
    if (-not (Test-EggyPathInside -Root $rootPath -Candidate $fullPath)) {
        throw "路径位于工作区之外，拒绝处理：$fullPath"
    }
    if ($fullPath.Equals($rootPath, [System.StringComparison]::OrdinalIgnoreCase)) {
        return '.'
    }
    return $fullPath.Substring($rootPath.Length + 1).Replace('\', '/')
}

function ConvertTo-EggySlashPath {
    param([Parameter(Mandatory = $true)][string]$Path)
    return $Path.Replace('\', '/')
}

function Write-EggyUtf8File {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][AllowEmptyString()][string]$Content
    )

    $parent = Split-Path -Parent $Path
    if ($parent) { [System.IO.Directory]::CreateDirectory($parent) | Out-Null }
    $encoding = New-Object System.Text.UTF8Encoding($false)
    $temporary = "$Path.eggy-agent-$([Guid]::NewGuid().ToString('N')).tmp"
    try {
        [System.IO.File]::WriteAllText($temporary, $Content, $encoding)
        Move-Item -LiteralPath $temporary -Destination $Path -Force
    } finally {
        if (Test-Path -LiteralPath $temporary -PathType Leaf) {
            Remove-Item -LiteralPath $temporary -Force -ErrorAction SilentlyContinue
        }
    }
}

function Copy-EggyFileAtomic {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Destination
    )

    if (-not (Test-Path -LiteralPath $Source -PathType Leaf)) {
        throw "安装包文件不存在：$Source"
    }
    $parent = Split-Path -Parent $Destination
    if ($parent) { [System.IO.Directory]::CreateDirectory($parent) | Out-Null }
    $temporary = "$Destination.eggy-agent-$([Guid]::NewGuid().ToString('N')).tmp"
    try {
        Copy-Item -LiteralPath $Source -Destination $temporary -Force
        Move-Item -LiteralPath $temporary -Destination $Destination -Force
    } finally {
        if (Test-Path -LiteralPath $temporary -PathType Leaf) {
            Remove-Item -LiteralPath $temporary -Force -ErrorAction SilentlyContinue
        }
    }
}

function Get-EggySha256 {
    param([Parameter(Mandatory = $true)][string]$Path)
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { return $null }
    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
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

function Read-EggyJson {
    param([Parameter(Mandatory = $true)][string]$Path)
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "数据文件不存在：$Path"
    }
    try {
        return Get-Content -LiteralPath $Path -Raw -Encoding UTF8 | ConvertFrom-Json
    } catch {
        throw "JSON 文件无法读取：$Path。$($_.Exception.Message)"
    }
}

function Write-EggyJson {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][object]$Value
    )
    $content = $Value | ConvertTo-Json -Depth 30
    Write-EggyUtf8File -Path $Path -Content ($content + [Environment]::NewLine)
}

function Get-EggyPackageVersion {
    param([Parameter(Mandatory = $true)][string]$PackageRoot)
    $path = Join-Path $PackageRoot 'VERSION'
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw '缺少 VERSION（版本号文件）。'
    }
    $version = (Get-Content -LiteralPath $path -Raw -Encoding UTF8).Trim()
    if ($version -notmatch '^\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?$') {
        throw "版本号格式不正确：$version"
    }
    return $version
}

function Get-EggyCatalog {
    param([Parameter(Mandatory = $true)][string]$PackageRoot)

    $catalog = Read-EggyJson -Path (Join-Path $PackageRoot 'skill-catalog.json')
    if ([int](Get-EggyPropertyValue -Object $catalog -Name 'schemaVersion' -Default 0) -ne 1) {
        throw '技能目录格式不受支持。'
    }
    if (-not (Test-EggyProperty -Object $catalog -Name 'profiles') -or
        -not (Test-EggyProperty -Object $catalog -Name 'hosts') -or
        -not (Test-EggyProperty -Object $catalog -Name 'skills')) {
        throw '技能目录缺少 profiles、hosts 或 skills。'
    }

    $names = @($catalog.skills | ForEach-Object { [string]$_.name })
    if ($names.Count -eq 0 -or ($names | Sort-Object -Unique).Count -ne $names.Count) {
        throw '技能目录没有技能，或包含重复名称。'
    }
    foreach ($record in @($catalog.skills)) {
        $name = [string]$record.name
        if ($name -notmatch '^eggy-[a-z0-9-]+$' -and $name -ne 'lingxi-doc-to-markdown') {
            throw "技能名称格式不正确：$name"
        }
        if (-not (Test-EggyRelativePathSafe -Path ([string]$record.path)) -or
            -not (Test-EggyProperty -Object $record -Name 'domains') -or
            @($record.domains).Count -eq 0 -or
            -not (Test-EggyProperty -Object $record -Name 'editions') -or
            -not (Test-EggyProperty -Object $record -Name 'tier') -or
            -not (Test-EggyProperty -Object $record -Name 'hosts') -or
            @($record.hosts).Count -eq 0) {
            throw "技能目录条目不完整：$name"
        }
        if ([string]$record.path -notmatch '^skills/[^/]+$') {
            throw "技能来源路径必须指向 skills 下的一级目录：$name"
        }
        foreach ($hostName in @($record.hosts)) {
            if (@('Codex', 'OpenCode', 'ZCode') -notcontains [string]$hostName) {
                throw "技能包含未知宿主：$name -> $hostName"
            }
        }
        if (@('core', 'optional') -notcontains [string]$record.tier) {
            throw "技能级别只能是 core 或 optional：$name"
        }
    }
    foreach ($profileProperty in @($catalog.profiles.PSObject.Properties)) {
        $profileNames = Get-EggyProfileSkillNames -Catalog $catalog -Profile $profileProperty.Name
        if ($profileNames.Count -eq 0) { throw "技能档案不能为空：$($profileProperty.Name)" }
    }
    foreach ($hostName in @('Codex', 'OpenCode', 'ZCode')) {
        [void](Get-EggyCatalogHost -Catalog $catalog -Agent $hostName)
    }
    return $catalog
}

function Get-EggySkillRecord {
    param(
        [Parameter(Mandatory = $true)][object]$Catalog,
        [Parameter(Mandatory = $true)][string]$Name
    )
    $record = @($Catalog.skills | Where-Object { [string]$_.name -eq $Name })
    if ($record.Count -ne 1) { throw "技能目录中不存在或重复技能：$Name" }
    return $record[0]
}

function Get-EggyProfileSkillNames {
    param(
        [Parameter(Mandatory = $true)][object]$Catalog,
        [Parameter(Mandatory = $true)][string]$Profile
    )

    $property = @($Catalog.profiles.PSObject.Properties | Where-Object { $_.Name -eq $Profile })
    if ($property.Count -ne 1) { throw "技能档案不存在：$Profile" }
    $value = $property[0].Value
    if (Test-EggyProperty -Object $value -Name 'skills') { $value = $value.skills }
    $names = @($value | ForEach-Object { [string]$_ } | Where-Object { $_ })
    foreach ($name in $names) { [void](Get-EggySkillRecord -Catalog $Catalog -Name $name) }
    return @($names | Sort-Object -Unique)
}

function Get-EggyEditionLabel {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('Origin', 'World')]
        [string]$Edition
    )
    return $(if ($Edition -eq 'World') { '世界版' } else { '原点版' })
}

function Get-EggyOptionalProfileName {
    param(
        [Parameter(Mandatory = $true)][string]$Domain,
        [ValidateSet('Origin', 'World')][string]$Edition = 'Origin'
    )
    if ($Domain -eq 'tooling') { return 'tooling-optional' }
    return $(if ($Edition -eq 'World') { 'map-world-optional' } else { 'map-origin-optional' })
}

function Get-EggyProfileForProject {
    param(
        [Parameter(Mandatory = $true)][string]$RequestedProfile,
        [AllowNull()][string]$ProjectPath,
        [AllowNull()][string]$Edition
    )

    $requested = $RequestedProfile.ToLowerInvariant().Replace('_', '-')
    switch ($requested) {
        'auto' {
            if ($ProjectPath) {
                if (-not $Edition) { throw '自动选择地图档案时缺少工程版本。' }
                return $(if ($Edition -eq 'World') { 'map-world' } else { 'map-origin' })
            }
            return 'tooling'
        }
        'common' { return 'common' }
        'maporigin' { return 'map-origin' }
        'map-origin' { return 'map-origin' }
        'mapworld' { return 'map-world' }
        'map-world' { return 'map-world' }
        'map-origin-optional' { return 'map-origin-optional' }
        'map-world-optional' { return 'map-world-optional' }
        'tooling' { return 'tooling' }
        'tooling-optional' { return 'tooling-optional' }
        'full' { return 'full' }
        default { throw "不支持的安装档案：$RequestedProfile" }
    }
}

function Resolve-EggyAgentName {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('Auto', 'Codex', 'OpenCode', 'ZCode')]
        [string]$Agent
    )

    if ($Agent -ne 'Auto') { return $Agent }
    if ($env:ZCODE_HOME -or $env:ZCODE_PLUGIN_ROOT -or $env:ZCODE_SESSION_ID) { return 'ZCode' }
    if ($env:OPENCODE -or $env:OPENCODE_VERSION) { return 'OpenCode' }
    return 'Codex'
}

function Get-EggyCatalogHost {
    param(
        [Parameter(Mandatory = $true)][object]$Catalog,
        [Parameter(Mandatory = $true)][string]$Agent
    )
    $record = @($Catalog.hosts.PSObject.Properties | Where-Object { $_.Name -eq $Agent })
    if ($record.Count -ne 1) { throw "技能目录没有宿主配置：$Agent" }
    if (-not $record[0].Value.projectSkillRoot -or -not $record[0].Value.globalSkillRoot) {
        throw "宿主目录配置不完整：$Agent"
    }
    return $record[0].Value
}

function Get-EggyInstallDescriptor {
    param(
        [Parameter(Mandatory = $true)][string]$WorkspaceRoot,
        [Parameter(Mandatory = $true)][ValidateSet('Codex', 'OpenCode', 'ZCode')][string]$Agent,
        [Parameter(Mandatory = $true)][ValidateSet('Project', 'Global')][string]$Scope,
        [Parameter(Mandatory = $true)][object]$Catalog
    )

    $workspace = Resolve-EggyDirectory -Path $WorkspaceRoot -Label '总工作区目录'
    $hostRecord = Get-EggyCatalogHost -Catalog $Catalog -Agent $Agent
    $userProfileRoot = ConvertTo-EggyFullPath -Path ([Environment]::GetFolderPath('UserProfile'))
    $baseRoot = if ($Scope -eq 'Global') { $userProfileRoot } else { $workspace }
    $skillRelative = [string]$(if ($Scope -eq 'Global') { $hostRecord.globalSkillRoot } else { $hostRecord.projectSkillRoot })
    $skillRelative = $skillRelative.TrimEnd('/')
    $stateKey = if ($skillRelative -eq '.zcode/skills') { 'zcode' } else { 'agents' }
    $stateName = if ($Scope -eq 'Global') {
        "install-state-global-$stateKey.json"
    } elseif ($stateKey -eq 'zcode') {
        'install-state-zcode.json'
    } else {
        'install-state.json'
    }
    $disabledRelative = ".eggy-agent/disabled-skills/$stateKey"

    return [pscustomobject]@{
        Agent = $Agent
        Scope = $Scope
        WorkspaceRoot = $workspace
        BaseRoot = $baseRoot
        SkillRoot = Join-Path $baseRoot ($skillRelative.Replace('/', '\'))
        SkillRootRelative = $skillRelative
        StateRoot = Join-Path $baseRoot '.eggy-agent'
        StatePath = Join-Path (Join-Path $baseRoot '.eggy-agent') $stateName
        StateKey = $stateKey
        DisabledRoot = Join-Path $baseRoot ($disabledRelative.Replace('/', '\'))
        DisabledRootRelative = $disabledRelative
        BackupRoot = Join-Path $baseRoot '.eggy-agent\backups'
    }
}

function Get-EggyStatePathCandidates {
    param([Parameter(Mandatory = $true)][object]$Descriptor)

    $paths = @($Descriptor.StatePath)
    if ($Descriptor.Scope -eq 'Project' -and $Descriptor.StateKey -eq 'agents') {
        $paths += Join-Path $Descriptor.StateRoot 'install-state.json'
    }
    return @($paths | Select-Object -Unique)
}

function Read-EggyInstallState {
    param([Parameter(Mandatory = $true)][object]$Descriptor)

    foreach ($path in Get-EggyStatePathCandidates -Descriptor $Descriptor) {
        if (Test-Path -LiteralPath $path -PathType Leaf) {
            $raw = Read-EggyJson -Path $path
            return [pscustomobject]@{
                Path = $path
                Raw = $raw
                State = ConvertTo-EggyStateV4 -State $raw
                WasMigrated = ([int](Get-EggyPropertyValue -Object $raw -Name 'schemaVersion' -Default 1) -ne $script:EggyStateSchemaVersion)
            }
        }
    }
    throw "没有找到安装状态：$($Descriptor.StatePath)"
}

function Assert-EggyStateContext {
    param(
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][object]$Descriptor
    )

    if ([string]$State.scope -ne [string]$Descriptor.Scope) {
        throw "安装状态范围与本次操作不一致：$($State.scope) / $($Descriptor.Scope)"
    }
    if ([string]$State.skillRootRelative -ne [string]$Descriptor.SkillRootRelative) {
        throw "安装状态宿主目录与本次操作不一致：$($State.skillRootRelative) / $($Descriptor.SkillRootRelative)"
    }
    if ([string]$State.installBaseRoot -and
        -not (ConvertTo-EggyFullPath -Path ([string]$State.installBaseRoot)).Equals(
            (ConvertTo-EggyFullPath -Path $Descriptor.BaseRoot),
            [System.StringComparison]::OrdinalIgnoreCase
        )) {
        throw '安装状态的安装根目录与当前宿主不一致。'
    }
}

function Get-EggyManagedRecords {
    param(
        [Parameter(Mandatory = $true)][string]$PackageRoot,
        [Parameter(Mandatory = $true)][object]$Catalog,
        [Parameter(Mandatory = $true)][string[]]$SkillName,
        [Parameter(Mandatory = $true)][object]$Descriptor
    )

    $records = @()
    $seenTargets = @{}
    foreach ($name in @($SkillName | Sort-Object -Unique)) {
        $record = Get-EggySkillRecord -Catalog $Catalog -Name $name
        if (@($record.hosts) -notcontains $Descriptor.Agent) {
            throw "技能不支持当前宿主 $($Descriptor.Agent)：$name"
        }
        $skillRoot = Join-Path $PackageRoot ([string]$record.path)
        if (-not (Test-Path -LiteralPath $skillRoot -PathType Container)) {
            throw "技能目录不存在：$skillRoot"
        }
        foreach ($file in @(Get-ChildItem -LiteralPath $skillRoot -Recurse -File)) {
            $sourcePath = Get-EggyRelativePath -Root $PackageRoot -Path $file.FullName
            $inside = $file.FullName.Substring($skillRoot.Length + 1).Replace('\', '/')
            $target = $Descriptor.SkillRootRelative.TrimEnd('/') + '/' + $name + '/' + $inside
            if ($seenTargets.ContainsKey($target)) { throw "安装目标重复：$target" }
            $seenTargets[$target] = $true
            $records += [pscustomobject]@{
                sourcePath = $sourcePath
                target = $target
                sha256 = Get-EggySha256 -Path $file.FullName
                kind = 'skill'
                skill = $name
            }
        }
    }

    foreach ($folderName in @('scripts', 'templates')) {
        $folder = Join-Path $PackageRoot $folderName
        if (-not (Test-Path -LiteralPath $folder -PathType Container)) { continue }
        foreach ($file in @(Get-ChildItem -LiteralPath $folder -Recurse -File)) {
            $sourcePath = Get-EggyRelativePath -Root $PackageRoot -Path $file.FullName
            $inside = $file.FullName.Substring($folder.Length + 1).Replace('\', '/')
            $target = '.eggy-agent/' + $folderName + '/' + $inside
            if ($seenTargets.ContainsKey($target)) { throw "安装目标重复：$target" }
            $seenTargets[$target] = $true
            $records += [pscustomobject]@{
                sourcePath = $sourcePath
                target = $target
                sha256 = Get-EggySha256 -Path $file.FullName
                kind = 'support'
                skill = ''
            }
        }
    }

    foreach ($name in @('skill-catalog.json', 'release-manifest.json')) {
        $source = Join-Path $PackageRoot $name
        if (-not (Test-Path -LiteralPath $source -PathType Leaf)) { continue }
        $target = '.eggy-agent/' + $name
        if ($seenTargets.ContainsKey($target)) { throw "安装目标重复：$target" }
        $seenTargets[$target] = $true
        $records += [pscustomobject]@{
            sourcePath = $name
            target = $target
            sha256 = Get-EggySha256 -Path $source
            kind = 'support'
            skill = ''
        }
    }
    if ($records.Count -eq 0) { throw '没有生成任何受管安装文件。' }
    return @($records | Sort-Object target)
}

function Get-EggyTargetPath {
    param(
        [Parameter(Mandatory = $true)][object]$Descriptor,
        [Parameter(Mandatory = $true)][string]$RelativePath
    )
    $relative = ConvertTo-EggySlashPath -Path $RelativePath
    if (-not (Test-EggyRelativePathSafe -Path $relative)) {
        throw "目标相对路径不安全：$RelativePath"
    }
    $path = Join-Path $Descriptor.BaseRoot ($relative.Replace('/', '\'))
    if (-not (Test-EggyPathInside -Root $Descriptor.BaseRoot -Candidate $path)) {
        throw "目标路径位于安装根之外：$path"
    }
    return $path
}

function Get-EggyInstalledTargetPath {
    param(
        [Parameter(Mandatory = $true)][object]$Descriptor,
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][string]$Target
    )

    $targetText = ConvertTo-EggySlashPath -Path $Target
    $skillRoot = ([string]$(if ($State.skillRootRelative) { $State.skillRootRelative } else { $Descriptor.SkillRootRelative })).TrimEnd('/')
    $disabledRoot = ([string]$(if ($State.disabledRootRelative) { $State.disabledRootRelative } else { $Descriptor.DisabledRootRelative })).TrimEnd('/')
    $enabled = if (Test-EggyProperty -Object $State -Name 'enabled') { [bool]$State.enabled } else { $true }
    if (-not $enabled -and $targetText.StartsWith($skillRoot + '/', [System.StringComparison]::OrdinalIgnoreCase)) {
        $rest = $targetText.Substring($skillRoot.Length + 1)
        return Get-EggyTargetPath -Descriptor $Descriptor -RelativePath ($disabledRoot + '/' + $rest)
    }
    return Get-EggyTargetPath -Descriptor $Descriptor -RelativePath $targetText
}

function Test-EggyInstalledFiles {
    param(
        [Parameter(Mandatory = $true)][object]$Descriptor,
        [Parameter(Mandatory = $true)][object]$State
    )

    $conflicts = @()
    foreach ($entry in @($State.managedFiles)) {
        $destination = Get-EggyInstalledTargetPath -Descriptor $Descriptor -State $State -Target ([string]$entry.target)
        $expected = [string]$entry.sha256
        if (-not $expected -or (Get-EggySha256 -Path $destination) -ne $expected.ToLowerInvariant()) {
            $conflicts += [string]$entry.target
        }
    }
    return @($conflicts | Sort-Object -Unique)
}

function Get-EggyManagedSkillNamesFromState {
    param([Parameter(Mandatory = $true)][object]$State)

    if ((Test-EggyProperty -Object $State -Name 'selectedSkills') -and @($State.selectedSkills).Count -gt 0) {
        return @($State.selectedSkills | ForEach-Object { [string]$_ } | Where-Object { $_ } | Sort-Object -Unique)
    }
    $prefix = ([string]$State.skillRootRelative).TrimEnd('/') + '/'
    return @(
        @($State.managedFiles) |
            Where-Object { ([string]$_.target).StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase) } |
            ForEach-Object { ([string]$_.target).Substring($prefix.Length).Split('/')[0] } |
            Where-Object { $_ } |
            Sort-Object -Unique
    )
}

function Get-EggyStateSkillRecords {
    param(
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][string]$SkillName
    )
    $prefix = ([string]$State.skillRootRelative).TrimEnd('/') + '/' + $SkillName + '/'
    return @($State.managedFiles | Where-Object {
        ([string]$_.target).StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase)
    })
}

function Assert-EggySkillDirectoryClean {
    param(
        [Parameter(Mandatory = $true)][object]$Descriptor,
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][string]$SkillName,
        [Parameter(Mandatory = $true)][ValidateSet('Enabled', 'Disabled')][string]$Location
    )

    $root = if ($Location -eq 'Enabled') { $Descriptor.SkillRoot } else { $Descriptor.DisabledRoot }
    $directory = Join-Path $root $SkillName
    if (-not (Test-Path -LiteralPath $directory -PathType Container)) {
        throw "技能目录缺失，尚未修改任何内容：$directory"
    }
    $prefix = ([string]$State.skillRootRelative).TrimEnd('/') + '/' + $SkillName + '/'
    $known = @{}
    foreach ($entry in @(Get-EggyStateSkillRecords -State $State -SkillName $SkillName)) {
        $relative = ([string]$entry.target).Substring($prefix.Length)
        $known[$relative] = $true
        $file = Join-Path $directory ($relative.Replace('/', '\'))
        if ((Get-EggySha256 -Path $file) -ne ([string]$entry.sha256).ToLowerInvariant()) {
            throw "技能文件已被修改、缺失或损坏，尚未修改任何内容：$file"
        }
    }
    foreach ($file in @(Get-ChildItem -LiteralPath $directory -Recurse -File)) {
        $relative = $file.FullName.Substring($directory.Length + 1).Replace('\', '/')
        if (-not $known.ContainsKey($relative)) {
            throw "技能目录含未登记文件，尚未修改任何内容：$file"
        }
    }
}

function Get-EggyManagedBlock {
    param([Parameter(Mandatory = $true)][string]$Path)
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { return $null }
    $content = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
    $start = $content.IndexOf($script:EggyAgentBlockStart, [System.StringComparison]::Ordinal)
    $finish = $content.IndexOf($script:EggyAgentBlockEnd, [System.StringComparison]::Ordinal)
    if (($start -ge 0) -xor ($finish -ge 0)) { throw "规则文件的受管标记不完整：$Path" }
    if ($start -lt 0) { return $null }
    if ($finish -lt $start) { throw "规则文件的受管标记顺序错误：$Path" }
    return $content.Substring($start, $finish + $script:EggyAgentBlockEnd.Length - $start)
}

function Set-EggyManagedBlock {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Body
    )
    $block = $script:EggyAgentBlockStart + [Environment]::NewLine + $Body.Trim() + [Environment]::NewLine + $script:EggyAgentBlockEnd
    $existing = if (Test-Path -LiteralPath $Path -PathType Leaf) { Get-Content -LiteralPath $Path -Raw -Encoding UTF8 } else { '' }
    $oldBlock = Get-EggyManagedBlock -Path $Path
    if ($null -ne $oldBlock) {
        $updated = $existing.Replace($oldBlock, $block)
    } elseif ([string]::IsNullOrWhiteSpace($existing)) {
        $updated = $block + [Environment]::NewLine
    } else {
        $updated = $existing.TrimEnd() + [Environment]::NewLine + [Environment]::NewLine + $block + [Environment]::NewLine
    }
    Write-EggyUtf8File -Path $Path -Content $updated
    return $block
}

function Remove-EggyManagedBlock {
    param([Parameter(Mandatory = $true)][string]$Path)
    $block = Get-EggyManagedBlock -Path $Path
    if ($null -eq $block) { return }
    $content = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
    $updated = $content.Replace($block, '').Trim()
    if ($updated) {
        Write-EggyUtf8File -Path $Path -Content ($updated + [Environment]::NewLine)
    } else {
        Remove-Item -LiteralPath $Path -Force
    }
}

function New-EggyBackup {
    param(
        [Parameter(Mandatory = $true)][string]$WorkspaceRoot,
        [Parameter(Mandatory = $true)][string[]]$Path,
        [Parameter(Mandatory = $true)][string]$Reason
    )

    $root = Resolve-EggyDirectory -Path $WorkspaceRoot -Label '备份根目录'
    $safeReason = ($Reason -replace '[^0-9A-Za-z_-]', '-')
    if ([string]::IsNullOrWhiteSpace($safeReason)) { $safeReason = 'operation' }
    $prepared = @()
    $directoryStates = @{}
    foreach ($candidate in @($Path | Where-Object { $_ } | Sort-Object -Unique)) {
        $fullPath = ConvertTo-EggyFullPath -Path $candidate
        if (-not (Test-EggyPathInside -Root $root -Candidate $fullPath)) {
            throw "备份路径位于根目录之外：$fullPath"
        }
        $relative = Get-EggyRelativePath -Root $root -Path $fullPath
        if (Test-Path -LiteralPath $fullPath -PathType Container) {
            throw "备份接口只接受文件，不能直接传目录：$fullPath"
        }
        $exists = Test-Path -LiteralPath $fullPath -PathType Leaf
        $prepared += [pscustomobject]@{ FullPath = $fullPath; Relative = $relative; Exists = [bool]$exists }

        # 记录备份前的目录形态，恢复时只清理本次新建的空目录，不删除用户原有空目录。
        $current = Split-Path -Parent $fullPath
        while ($current -and (Test-EggyPathInside -Root $root -Candidate $current) -and
            -not $current.Equals($root, [System.StringComparison]::OrdinalIgnoreCase)) {
            $directoryRelative = Get-EggyRelativePath -Root $root -Path $current
            if (-not $directoryStates.ContainsKey($directoryRelative)) {
                $directoryStates[$directoryRelative] = [bool](Test-Path -LiteralPath $current -PathType Container)
            }
            $current = Split-Path -Parent $current
        }
    }
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss-fff'
    $backupRoot = Join-Path $root ".eggy-agent\backups\$stamp-$safeReason-$([Guid]::NewGuid().ToString('N').Substring(0, 8))"
    [System.IO.Directory]::CreateDirectory((Join-Path $backupRoot 'files')) | Out-Null
    $records = @()
    foreach ($item in $prepared) {
        if ($item.Exists) {
            $backupFile = Join-Path (Join-Path $backupRoot 'files') ($item.Relative.Replace('/', '\'))
            [System.IO.Directory]::CreateDirectory((Split-Path -Parent $backupFile)) | Out-Null
            Copy-Item -LiteralPath $item.FullPath -Destination $backupFile -Force
        }
        $records += [pscustomobject]@{ path = $item.Relative; existed = [bool]$item.Exists }
    }
    $directories = @($directoryStates.GetEnumerator() | ForEach-Object {
        [pscustomobject]@{ path = [string]$_.Key; existed = [bool]$_.Value }
    } | Sort-Object path)
    Write-EggyJson -Path (Join-Path $backupRoot 'backup.json') -Value ([pscustomobject]@{
        schemaVersion = 2
        createdAt = (Get-Date).ToString('o')
        reason = $safeReason
        workspaceRoot = $root
        files = $records
        directories = $directories
    })
    return $backupRoot
}

function Restore-EggyBackupInternal {
    param(
        [Parameter(Mandatory = $true)][string]$WorkspaceRoot,
        [Parameter(Mandatory = $true)][string]$BackupRoot
    )

    $root = Resolve-EggyDirectory -Path $WorkspaceRoot -Label '恢复根目录'
    $backup = Resolve-EggyDirectory -Path $BackupRoot -Label '备份目录'
    $backupBase = Join-Path $root '.eggy-agent\backups'
    if (-not (Test-EggyPathInside -Root $backupBase -Candidate $backup)) {
        throw '只能恢复当前根目录下工具生成的备份。'
    }
    $manifest = Read-EggyJson -Path (Join-Path $backup 'backup.json')
    $preservedDirectories = @{}
    if ((Test-EggyProperty -Object $manifest -Name 'directories') -and $null -ne $manifest.directories) {
        foreach ($entry in @($manifest.directories)) {
            $relative = ConvertTo-EggySlashPath -Path ([string]$entry.path)
            if (-not (Test-EggyRelativePathSafe -Path $relative)) {
                throw "备份记录包含不安全目录路径：$relative"
            }
            if ([bool]$entry.existed) { $preservedDirectories[$relative] = $true }
        }
    }
    $candidateDirectories = @()
    foreach ($entry in @($manifest.files)) {
        $relative = ConvertTo-EggySlashPath -Path ([string]$entry.path)
        if (-not (Test-EggyRelativePathSafe -Path $relative)) {
            throw "备份记录包含不安全路径：$relative"
        }
        $destination = Join-Path $root ($relative.Replace('/', '\'))
        if (-not (Test-EggyPathInside -Root $root -Candidate $destination)) {
            throw "备份记录包含根目录外路径：$destination"
        }
        if ([bool]$entry.existed) {
            $source = Join-Path (Join-Path $backup 'files') ($relative.Replace('/', '\'))
            if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
                throw "备份文件缺失：$source"
            }
            Copy-EggyFileAtomic -Source $source -Destination $destination
        } elseif (Test-Path -LiteralPath $destination -PathType Leaf) {
            Remove-Item -LiteralPath $destination -Force
        }
        $candidateDirectories += Split-Path -Parent $destination
    }
    # 保留重复候选路径，避免 PowerShell 按排序键去重时漏掉同级目录；重复处理无害，
    # 并且能确保所有子目录清理后，空的技能根目录和上级目录也会被继续清理。
    foreach ($directory in @($candidateDirectories | Sort-Object Length -Descending)) {
        $current = $directory
        while ($current -and (Test-EggyPathInside -Root $root -Candidate $current) -and
            -not $current.Equals($root, [System.StringComparison]::OrdinalIgnoreCase) -and
            (Test-Path -LiteralPath $current -PathType Container)) {
            $relativeCurrent = Get-EggyRelativePath -Root $root -Path $current
            if ($preservedDirectories.ContainsKey($relativeCurrent)) { break }
            if (@(Get-ChildItem -LiteralPath $current -Force).Count -ne 0) { break }
            Remove-Item -LiteralPath $current -Force
            $current = Split-Path -Parent $current
        }
    }
}

function Get-EggyRuleBody {
    param(
        [Parameter(Mandatory = $true)][string]$TemplatePath,
        [Parameter(Mandatory = $true)][string]$WorkspaceRoot,
        [string]$ProjectPath = '',
        [ValidateSet('Single', 'Multiplayer')][string]$PlayerMode = 'Single',
        [ValidateSet('Origin', 'World')][string]$Edition = 'Origin'
    )

    $modeText = if ($PlayerMode -eq 'Multiplayer') { '多人地图' } else { '单人地图' }
    $editionText = Get-EggyEditionLabel -Edition $Edition
    $editionRules = if ($Edition -eq 'World') {
@'
- 世界版先区分服务端权威状态、客户端表现和公共协议；不能把不同运行侧的状态混在一起。
- `server/main.lua`、`client/main.lua` 只做必要装配；功能代码放对应侧模块，`common/` 只放双方都能安全使用的内容。
- 世界版的大功能优先查当前官方教程和官方模板校正路线；模板不是接口签名的证明，参数仍须单独查证。
- 世界版服务器沙盒显示为 512 MB；避免无必要的全场扫描、无界缓存和重复常驻任务。存档状态变更时按官方警告设计保存时机。
'@
    } else {
@'
- 原点版按当前工程的帧同步、物理和沙箱边界开发；涉及玩家状态时先明确数据归属和显示对象。
- 根目录 `main.lua` 只做必要装配；功能代码放自建模块，不能把世界版的持续世界或服务端分层假设套进来。
'@
    }
    return (Get-Content -LiteralPath $TemplatePath -Raw -Encoding UTF8).
        Replace('{{WORKSPACE_ROOT}}', $WorkspaceRoot).
        Replace('{{PROJECT_PATH}}', $ProjectPath).
        Replace('{{PLAYER_MODE}}', $modeText).
        Replace('{{EDITION}}', $editionText).
        Replace('{{EDITION_RULES}}', $editionRules.Trim())
}

function ConvertTo-EggyEditionValue {
    param(
        [Parameter(Mandatory = $true)][object]$Value,
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Key
    )

    if ($Value -is [bool]) { return $(if ([bool]$Value) { 'World' } else { 'Origin' }) }
    $text = ([string]$Value).Trim().ToLowerInvariant()
    if ($Key -match 'is.*(se|world)' -and $text -match '^(0|1|true|false)$') {
        return $(if ($text -in @('1', 'true')) { 'World' } else { 'Origin' })
    }
    if ($text -in @('world', 'world版', 'se', 'state-sync', 'state_sync')) { return 'World' }
    if ($text -in @('origin', 'origin版', '原点', 'fs', 'frame-sync', 'frame_sync')) { return 'Origin' }
    throw "工程版本标记无法理解：$Source -> $Key=$Value"
}

function Get-EggyProjectEdition {
    param([Parameter(Mandatory = $true)][string]$ProjectPath)

    $project = Resolve-EggyDirectory -Path $ProjectPath -Label '地图工程目录'
    $definitions = @(
        [pscustomobject]@{ File = 'eggy.json'; Key = 'isSEMap' },
        [pscustomobject]@{ File = 'eggy.json'; Key = 'isWorld' },
        [pscustomobject]@{ File = 'eggy.json'; Key = 'edition' },
        [pscustomobject]@{ File = '.codemaker\config.json'; Key = 'is_se_mode' },
        [pscustomobject]@{ File = '.codemaker\config.json'; Key = 'isWorld' },
        [pscustomobject]@{ File = '.codemaker\config.json'; Key = 'edition' }
    )
    $loaded = @{}
    $flags = @()
    foreach ($definition in $definitions) {
        $path = Join-Path $project $definition.File
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { continue }
        if (-not $loaded.ContainsKey($path)) { $loaded[$path] = Read-EggyJson -Path $path }
        $json = $loaded[$path]
        if (Test-EggyProperty -Object $json -Name $definition.Key) {
            $flags += [pscustomobject]@{
                source = "$($definition.File):$($definition.Key)"
                value = ConvertTo-EggyEditionValue -Value $json.($definition.Key) -Source $path -Key $definition.Key
            }
        }
    }
    if ($flags.Count -gt 1 -and @($flags.value | Sort-Object -Unique).Count -gt 1) {
        $details = ($flags | ForEach-Object { "$($_.source)=$($_.value)" }) -join '；'
        throw "工程版本标记相互冲突，拒绝猜测：$details"
    }
    if ($flags.Count -gt 0) { return [string]$flags[0].value }

    $hasWorldStructure = (Test-Path -LiteralPath (Join-Path $project 'client') -PathType Container) -and
        (Test-Path -LiteralPath (Join-Path $project 'server') -PathType Container) -and
        (Test-Path -LiteralPath (Join-Path $project 'common') -PathType Container) -and
        ((Test-Path -LiteralPath (Join-Path $project 'server\main.lua') -PathType Leaf) -or
         (Test-Path -LiteralPath (Join-Path $project 'client\main.lua') -PathType Leaf))
    $hasOriginStructure = (Test-Path -LiteralPath (Join-Path $project 'main.lua') -PathType Leaf) -and
        ((Test-Path -LiteralPath (Join-Path $project 'EggyAPI.lua') -PathType Leaf) -or
         (Test-Path -LiteralPath (Join-Path $project 'Data') -PathType Container) -or
         (Test-Path -LiteralPath (Join-Path $project 'data') -PathType Container))
    if ($hasWorldStructure -and $hasOriginStructure) {
        throw '工程目录同时符合原点版和世界版结构，拒绝猜测。'
    }
    if ($hasWorldStructure) { return 'World' }
    if ($hasOriginStructure) { return 'Origin' }
    throw '无法从工程标记或目录结构确认原点版/世界版，安装已停止。'
}

function ConvertTo-EggyStateV4 {
    param([Parameter(Mandatory = $true)][object]$State)

    $schemaVersion = [int](Get-EggyPropertyValue -Object $State -Name 'schemaVersion' -Default 1)
    if ($schemaVersion -notin @(1, 2, 3, 4)) {
        throw "不支持的安装状态格式：$schemaVersion"
    }
    $projectPathValue = [string](Get-EggyPropertyValue -Object $State -Name 'projectPath' -Default '')
    $workspace = [string](Get-EggyPropertyValue -Object $State -Name 'workspaceRoot' -Default '')
    if (-not $workspace -and $projectPathValue) { $workspace = Split-Path -Parent $projectPathValue }
    if (-not $workspace) { $workspace = [Environment]::GetFolderPath('UserProfile') }
    $workspace = ConvertTo-EggyFullPath -Path $workspace

    $scope = [string](Get-EggyPropertyValue -Object $State -Name 'scope' -Default 'Project')
    if (@('Project', 'Global') -notcontains $scope) { throw "安装状态范围不正确：$scope" }
    $agent = [string](Get-EggyPropertyValue -Object $State -Name 'agent' -Default 'Codex')
    if (@('Codex', 'OpenCode', 'ZCode') -notcontains $agent) { throw "安装状态宿主不正确：$agent" }
    $defaultSkillRoot = if ($agent -eq 'ZCode') { '.zcode/skills' } else { '.agents/skills' }
    $defaultDisabledRoot = if ($agent -eq 'ZCode') { '.eggy-agent/disabled-skills/zcode' } else { '.eggy-agent/disabled-skills/agents' }
    $skillRootRelative = [string](Get-EggyPropertyValue -Object $State -Name 'skillRootRelative' -Default $defaultSkillRoot)
    $disabledRootRelative = [string](Get-EggyPropertyValue -Object $State -Name 'disabledRootRelative' -Default $defaultDisabledRoot)
    if (-not (Test-EggyRelativePathSafe -Path $skillRootRelative) -or -not (Test-EggyRelativePathSafe -Path $disabledRootRelative)) {
        throw '安装状态包含不安全的技能目录路径。'
    }

    $rawProjects = @()
    if ((Test-EggyProperty -Object $State -Name 'projects') -and $null -ne $State.projects) {
        $rawProjects = @($State.projects)
    } elseif ($projectPathValue) {
        $rawProjects = @([pscustomobject]@{
            path = $projectPathValue
            edition = ''
            playerMode = [string](Get-EggyPropertyValue -Object $State -Name 'playerMode' -Default 'Single')
            profile = ''
            projectRuleBlockSha256 = [string](Get-EggyPropertyValue -Object $State -Name 'projectRuleBlockSha256' -Default '')
            userOwnedDocuments = @(Get-EggyPropertyValue -Object $State -Name 'userOwnedDocuments' -Default @())
        })
    }
    $projects = @()
    foreach ($rawProject in $rawProjects) {
        $path = [string](Get-EggyPropertyValue -Object $rawProject -Name 'path' -Default '')
        if (-not $path) { continue }
        if (-not [System.IO.Path]::IsPathRooted($path)) { $path = Join-Path $workspace $path }
        $path = ConvertTo-EggyFullPath -Path $path
        $edition = [string](Get-EggyPropertyValue -Object $rawProject -Name 'edition' -Default '')
        if ($edition -notin @('', 'Origin', 'World')) { throw "安装状态地图版本不正确：$path -> $edition" }
        if (-not $edition -and (Test-Path -LiteralPath $path -PathType Container)) {
            $edition = Get-EggyProjectEdition -ProjectPath $path
        }
        $playerMode = [string](Get-EggyPropertyValue -Object $rawProject -Name 'playerMode' -Default 'Single')
        if (@('Single', 'Multiplayer') -notcontains $playerMode) {
            throw "安装状态地图人数标记不正确：$path -> $playerMode"
        }
        $profile = [string](Get-EggyPropertyValue -Object $rawProject -Name 'profile' -Default '')
        if (-not $profile -and $edition) { $profile = $(if ($edition -eq 'World') { 'map-world' } else { 'map-origin' }) }
        $projects += [pscustomobject]@{
            path = $path
            edition = $edition
            playerMode = $playerMode
            profile = $profile
            projectRuleBlockSha256 = [string](Get-EggyPropertyValue -Object $rawProject -Name 'projectRuleBlockSha256' -Default '')
            userOwnedDocuments = @((Get-EggyPropertyValue -Object $rawProject -Name 'userOwnedDocuments' -Default @()))
        }
    }

    $managed = @()
    foreach ($entry in @((Get-EggyPropertyValue -Object $State -Name 'managedFiles' -Default @()))) {
        $target = ConvertTo-EggySlashPath -Path ([string](Get-EggyPropertyValue -Object $entry -Name 'target' -Default ''))
        if (-not $target -or -not (Test-EggyRelativePathSafe -Path $target)) { throw "安装状态包含不安全目标：$target" }
        $managed += [pscustomobject]@{
            sourcePath = [string](Get-EggyPropertyValue -Object $entry -Name 'sourcePath' -Default '')
            target = $target
            sha256 = [string](Get-EggyPropertyValue -Object $entry -Name 'sha256' -Default '')
            kind = [string](Get-EggyPropertyValue -Object $entry -Name 'kind' -Default 'legacy')
            skill = [string](Get-EggyPropertyValue -Object $entry -Name 'skill' -Default '')
        }
    }
    $selected = @((Get-EggyPropertyValue -Object $State -Name 'selectedSkills' -Default @()) |
        ForEach-Object { [string]$_ } | Where-Object { $_ } | Sort-Object -Unique)
    if ($selected.Count -eq 0) {
        $prefix = $skillRootRelative.TrimEnd('/') + '/'
        $selected = @($managed | Where-Object { $_.target.StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase) } |
            ForEach-Object { $_.target.Substring($prefix.Length).Split('/')[0] } | Where-Object { $_ } | Sort-Object -Unique)
    }
    $agentListDefault = @((Get-EggyPropertyValue -Object $State -Name 'agent' -Default 'Codex'))
    $agents = @((Get-EggyPropertyValue -Object $State -Name 'agents' -Default $agentListDefault) |
        ForEach-Object { [string]$_ } | Where-Object { $_ } | Sort-Object -Unique)
    if ($agents.Count -eq 0) { $agents = @($agent) }

    return [pscustomobject]@{
        schemaVersion = $script:EggyStateSchemaVersion
        package = [string](Get-EggyPropertyValue -Object $State -Name 'package' -Default 'eggy-agent-skills')
        version = [string](Get-EggyPropertyValue -Object $State -Name 'version' -Default '')
        installedAt = [string](Get-EggyPropertyValue -Object $State -Name 'installedAt' -Default '')
        updatedAt = [string](Get-EggyPropertyValue -Object $State -Name 'updatedAt' -Default (Get-Date).ToString('o'))
        workspaceRoot = $workspace
        installBaseRoot = [string](Get-EggyPropertyValue -Object $State -Name 'installBaseRoot' -Default $workspace)
        agent = $agent
        agents = $agents
        scope = $scope
        stateKey = [string](Get-EggyPropertyValue -Object $State -Name 'stateKey' -Default $(if ($agent -eq 'ZCode') { 'zcode' } else { 'agents' }))
        profile = [string](Get-EggyPropertyValue -Object $State -Name 'profile' -Default '')
        profiles = @((Get-EggyPropertyValue -Object $State -Name 'profiles' -Default @()))
        enabled = [bool](Get-EggyPropertyValue -Object $State -Name 'enabled' -Default $true)
        rulesEnabled = [bool](Get-EggyPropertyValue -Object $State -Name 'rulesEnabled' -Default ($projects.Count -gt 0))
        skillRootRelative = $skillRootRelative.TrimEnd('/')
        disabledRootRelative = $disabledRootRelative.TrimEnd('/')
        selectedSkills = $selected
        managedFiles = @($managed | Sort-Object target)
        rootRuleBlockSha256 = [string](Get-EggyPropertyValue -Object $State -Name 'rootRuleBlockSha256' -Default '')
        projects = @($projects)
        sourceCommit = [string](Get-EggyPropertyValue -Object $State -Name 'sourceCommit' -Default '')
        latestBackup = [string](Get-EggyPropertyValue -Object $State -Name 'latestBackup' -Default '')
        templateUpgradeReport = [string](Get-EggyPropertyValue -Object $State -Name 'templateUpgradeReport' -Default '')
        migratedFrom = $schemaVersion
    }
}

# 兼容旧版脚本或用户本地仍保留的调用名称；新代码统一使用 V4。
function ConvertTo-EggyStateV3 { param([Parameter(Mandatory = $true)][object]$State) return ConvertTo-EggyStateV4 -State $State }
function ConvertTo-EggyStateV2 { param([Parameter(Mandatory = $true)][object]$State) return ConvertTo-EggyStateV4 -State $State }

function Get-EggyStateProject {
    param(
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][string]$ProjectPath
    )
    $wanted = ConvertTo-EggyFullPath -Path $ProjectPath
    return @($State.projects | Where-Object {
        (ConvertTo-EggyFullPath -Path ([string]$_.path)).Equals($wanted, [System.StringComparison]::OrdinalIgnoreCase)
    })
}

function Get-EggyStateDesiredSkills {
    param(
        [Parameter(Mandatory = $true)][object]$State,
        [Parameter(Mandatory = $true)][object]$Catalog
    )

    $names = @()
    $names += @(Get-EggyManagedSkillNamesFromState -State $State)
    foreach ($project in @($State.projects)) {
        $profile = [string]$project.profile
        if (-not $profile -and [string]$project.edition) {
            $profile = $(if ([string]$project.edition -eq 'World') { 'map-world' } else { 'map-origin' })
        }
        if ($profile) {
            $names += @(Get-EggyProfileSkillNames -Catalog $Catalog -Profile $profile)
        }
    }
    if ($names.Count -eq 0 -and $State.profile) {
        $names += @(Get-EggyProfileSkillNames -Catalog $Catalog -Profile ([string]$State.profile))
    }
    if ($names.Count -eq 0) { throw '安装状态没有可恢复的技能档案。' }
    foreach ($name in @($names | Sort-Object -Unique)) { [void](Get-EggySkillRecord -Catalog $Catalog -Name $name) }
    return @($names | Sort-Object -Unique)
}

function Get-EggySourceCommit {
    param([Parameter(Mandatory = $true)][string]$PackageRoot)
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) { return '' }
    try {
        $safe = (Resolve-Path -LiteralPath $PackageRoot).Path.Replace('\', '/')
        $output = & git -c "safe.directory=$safe" -C $PackageRoot rev-parse HEAD 2>$null
        if ($LASTEXITCODE -eq 0) { return ($output | Select-Object -Last 1).Trim() }
    } catch {}
    return ''
}

function Invoke-EggyGit {
    param(
        [Parameter(Mandatory = $true)][string]$ProjectRoot,
        [Parameter(Mandatory = $true)][string[]]$Arguments
    )

    $safe = (ConvertTo-EggyFullPath -Path $ProjectRoot).Replace('\', '/')
    $oldPreference = $ErrorActionPreference
    try {
        # Git 会把“当前目录还不是仓库”等探测结果写到 stderr；这里读取退出码，
        # 不能让 PowerShell 把这类可预期结果误升级成 terminating error。
        $ErrorActionPreference = 'Continue'
        $output = @(& git -c "safe.directory=$safe" -c 'core.quotepath=false' -C $ProjectRoot @Arguments 2>&1)
        $exitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $oldPreference
    }
    return [pscustomobject]@{ ExitCode = $exitCode; Output = @($output | ForEach-Object { $_.ToString() }) }
}

function Get-EggyPublishSourceFiles {
    param([Parameter(Mandatory = $true)][string]$PackageRoot)

    $root = Resolve-EggyDirectory -Path $PackageRoot -Label '公开包目录'
    $files = @()
    foreach ($folderName in @('skills', 'scripts', 'templates', 'profiles', 'tests', '.github')) {
        $folder = Join-Path $root $folderName
        if (Test-Path -LiteralPath $folder -PathType Container) {
            $files += @(Get-ChildItem -LiteralPath $folder -Recurse -File)
        }
    }
    foreach ($name in @('README.md', 'START-HERE.md', 'INSTALL-给agent的安装任务书.md', 'UPDATE-给agent的升级任务书.md', 'CONTRIBUTING.md', 'LICENSE', 'VERSION', '.gitignore', '.gitattributes', 'skill-catalog.json')) {
        $path = Join-Path $root $name
        if (Test-Path -LiteralPath $path -PathType Leaf) { $files += Get-Item -LiteralPath $path }
    }
    $seen = @{}
    $result = @()
    foreach ($file in @($files | Sort-Object FullName)) {
        $relative = Get-EggyRelativePath -Root $root -Path $file.FullName
        if ($seen.ContainsKey($relative)) { continue }
        $seen[$relative] = $true
        $category = 'documentation'
        $skill = ''
        $installTarget = ''
        if ($relative.StartsWith('skills/', [System.StringComparison]::OrdinalIgnoreCase)) {
            $parts = $relative.Split('/')
            if ($parts.Count -ge 3 -and $parts[1] -ne 'README.md') {
                $category = 'skill'
                $skill = $parts[1]
                $inside = $relative.Substring(('skills/' + $skill + '/').Length)
                $installTarget = '{SKILL_ROOT}/' + $skill + '/' + $inside
            }
        } elseif ($relative.StartsWith('scripts/', [System.StringComparison]::OrdinalIgnoreCase) -or
            $relative.StartsWith('templates/', [System.StringComparison]::OrdinalIgnoreCase)) {
            $category = 'support'
            $installTarget = '.eggy-agent/' + $relative
        }
        $result += [pscustomobject]@{
            path = $relative
            category = $category
            skill = $skill
            installTarget = $installTarget
            sha256 = Get-EggySha256 -Path $file.FullName
        }
    }
    return @($result | Sort-Object path)
}

function Assert-EggyPackageManifest {
    param([Parameter(Mandatory = $true)][string]$PackageRoot)

    $root = Resolve-EggyDirectory -Path $PackageRoot -Label '候选包目录'
    $manifest = Read-EggyJson -Path (Join-Path $root 'release-manifest.json')
    if ([int](Get-EggyPropertyValue -Object $manifest -Name 'schemaVersion' -Default 0) -ne 2 -or
        -not $manifest.version -or -not $manifest.files -or -not $manifest.catalog) {
        throw '发布清单缺少版本、目录或文件列表。'
    }
    $version = Get-EggyPackageVersion -PackageRoot $root
    if ($version -ne [string]$manifest.version) { throw "VERSION 与发布清单版本不一致：$version / $($manifest.version)" }
    $catalog = Get-EggyCatalog -PackageRoot $root
    if ([string]$manifest.catalog.path -ne 'skill-catalog.json') { throw '发布清单的技能目录路径不正确。' }
    if ((Get-EggySha256 -Path (Join-Path $root 'skill-catalog.json')) -ne [string]$manifest.catalog.sha256) {
        throw '技能目录文件指纹不一致。'
    }

    $expected = @(Get-EggyPublishSourceFiles -PackageRoot $root)
    $actual = @($manifest.files)
    $expectedMap = @{}
    foreach ($entry in $expected) { $expectedMap[[string]$entry.path] = $entry }
    $actualMap = @{}
    foreach ($entry in $actual) {
        $relative = ConvertTo-EggySlashPath -Path ([string]$entry.path)
        if (-not (Test-EggyRelativePathSafe -Path $relative)) { throw "发布清单包含不安全路径：$relative" }
        if ($actualMap.ContainsKey($relative)) { throw "发布清单包含重复来源：$relative" }
        $actualMap[$relative] = $entry
        if (-not $expectedMap.ContainsKey($relative)) { throw "发布清单包含未允许或未登记来源：$relative" }
        $expectedEntry = $expectedMap[$relative]
        if ([string]$entry.category -ne [string]$expectedEntry.category -or
            [string]$entry.skill -ne [string]$expectedEntry.skill -or
            [string]$entry.installTarget -ne [string]$expectedEntry.installTarget) {
            throw "发布清单安装元数据不一致：$relative"
        }
        $source = Join-Path $root ($relative.Replace('/', '\'))
        if ((Get-EggySha256 -Path $source) -ne ([string]$entry.sha256).ToLowerInvariant()) {
            throw "安装包文件指纹不一致：$relative"
        }
    }
    foreach ($relative in @($expectedMap.Keys)) {
        if (-not $actualMap.ContainsKey($relative)) { throw "发布清单缺少来源文件：$relative" }
    }
    $agents = @($manifest.compatibleAgents)
    foreach ($agent in @('OpenCode', 'Codex', 'ZCode')) {
        if ($agents -notcontains $agent) { throw "发布清单缺少宿主：$agent" }
    }
    return $manifest
}

function Initialize-EggyMapRepository {
    param(
        [Parameter(Mandatory = $true)][string]$ProjectRoot,
        [Parameter(Mandatory = $true)][string]$PackageRoot
    )

    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        throw '没有找到 Git（版本记录工具），无法建立地图本地基线。'
    }
    $project = Resolve-EggyDirectory -Path $ProjectRoot -Label '地图工程目录'
    $probeResult = Invoke-EggyGit -ProjectRoot $project -Arguments @('rev-parse', '--show-toplevel')
    $hasRepo = $probeResult.ExitCode -eq 0
    if ($hasRepo) {
        $reported = ConvertTo-EggyFullPath -Path (($probeResult.Output | Select-Object -Last 1).Trim())
        if (-not $reported.Equals($project, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "地图工程不是独立仓库，当前版本记录根目录是：$reported"
        }
        $headResult = Invoke-EggyGit -ProjectRoot $project -Arguments @('rev-parse', '--verify', 'HEAD')
        if ($headResult.ExitCode -ne 0) { throw '地图工程已有版本记录目录但没有首个提交，请先建立基线。' }
        return $false
    }

    foreach ($template in @(
        @('templates\地图.gitignore模板', '.gitignore'),
        @('templates\地图.gitattributes模板', '.gitattributes')
    )) {
        $destination = Join-Path $project $template[1]
        if (-not (Test-Path -LiteralPath $destination -PathType Leaf)) {
            Copy-EggyFileAtomic -Source (Join-Path $PackageRoot $template[0]) -Destination $destination
        }
    }
    $initResult = Invoke-EggyGit -ProjectRoot $project -Arguments @('init', '--initial-branch=main')
    if ($initResult.ExitCode -ne 0) {
        $initResult = Invoke-EggyGit -ProjectRoot $project -Arguments @('init')
        if ($initResult.ExitCode -ne 0) { throw '无法为地图建立本地版本记录。' }
        $branchResult = Invoke-EggyGit -ProjectRoot $project -Arguments @('branch', '-M', 'main')
        if ($branchResult.ExitCode -ne 0) { throw '无法设置地图本地基线分支。' }
    }
    try {
        $addResult = Invoke-EggyGit -ProjectRoot $project -Arguments @('add', '--all')
        if ($addResult.ExitCode -ne 0) { throw '无法把地图当前状态加入版本基线。' }
        $audit = Join-Path $PackageRoot 'scripts\git-batch-audit.ps1'
        & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $audit -ProjectPath $project -Staged
        if ($LASTEXITCODE -ne 0) { throw '地图当前状态未通过基线审查。' }
        $commitResult = Invoke-EggyGit -ProjectRoot $project -Arguments @('-c', 'user.name=Eggy Agent Local', '-c', 'user.email=eggy-agent@localhost.invalid', 'commit', '-m', '建立当前地图本地基线（功能状态待试玩确认）')
        if ($commitResult.ExitCode -ne 0) { throw '无法提交地图本地基线。' }
    } catch {
        [void](Invoke-EggyGit -ProjectRoot $project -Arguments @('reset'))
        throw
    }
    return $true
}
