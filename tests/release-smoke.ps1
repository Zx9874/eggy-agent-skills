[CmdletBinding()]
param(
    [string]$PackageRoot
)

$ErrorActionPreference = 'Stop'
if (-not $PackageRoot) { $PackageRoot = Join-Path $PSScriptRoot '..' }
$package = (Resolve-Path -LiteralPath $PackageRoot).Path
. (Join-Path $package 'scripts\EggyAgent.Common.ps1')
$catalog = Get-EggyCatalog -PackageRoot $package
$currentVersion = Get-EggyPackageVersion -PackageRoot $package
$testRoot = Join-Path ([System.IO.Path]::GetTempPath()) ('eggy-agent-smoke-' + [Guid]::NewGuid().ToString('N'))
$utf8 = New-Object System.Text.UTF8Encoding($false)
$script:assertions = 0
$script:succeeded = $false

function Write-TestFile {
    param([Parameter(Mandatory = $true)][string]$Path, [Parameter(Mandatory = $true)][AllowEmptyString()][string]$Content)
    $parent = Split-Path -Parent $Path
    if ($parent) { [System.IO.Directory]::CreateDirectory($parent) | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content.Replace("`r`n", "`n"), $utf8)
}

function Read-TestJson {
    param([Parameter(Mandatory = $true)][string]$Path)
    return Get-Content -LiteralPath $Path -Raw -Encoding UTF8 | ConvertFrom-Json
}

function Write-TestJson {
    param([Parameter(Mandatory = $true)][string]$Path, [Parameter(Mandatory = $true)][object]$Value)
    Write-TestFile -Path $Path -Content (($Value | ConvertTo-Json -Depth 30) + "`n")
}

function Assert-Test {
    param([Parameter(Mandatory = $true)][bool]$Condition, [Parameter(Mandatory = $true)][string]$Message)
    if (-not $Condition) { throw "断言失败：$Message" }
    $script:assertions++
}

function Assert-TestText {
    param([string]$Text, [string]$Pattern, [string]$Message)
    Assert-Test -Condition ($Text -match $Pattern) -Message $Message
}

function Invoke-TestScript {
    param(
        [Parameter(Mandatory = $true)][string]$ScriptPath,
        [string[]]$Arguments = @(),
        [switch]$ExpectFailure,
        [string]$ExpectedPattern
    )
    $oldPreference = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        $output = @(& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1)
        $exitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $oldPreference
    }
    $text = ($output | ForEach-Object { $_.ToString() }) -join "`n"
    if ($ExpectFailure) {
        Assert-Test -Condition ($exitCode -ne 0) -Message "预期失败但脚本成功：$ScriptPath`n$text"
    } else {
        Assert-Test -Condition ($exitCode -eq 0) -Message "脚本执行失败：$ScriptPath`n$text"
    }
    if ($ExpectedPattern) { Assert-TestText -Text $text -Pattern $ExpectedPattern -Message "输出未包含预期内容：$ExpectedPattern`n$text" }
    return $text
}

function New-TestWorkspace {
    param([Parameter(Mandatory = $true)][string]$Name)
    $path = Join-Path $testRoot $Name
    [System.IO.Directory]::CreateDirectory($path) | Out-Null
    return $path
}

function Get-TestTreeSignature {
    param([Parameter(Mandatory = $true)][string]$Path)

    # 连同空目录和文件内容核对，防止拒绝安装前已经创建技能、备份或 Git。
    return (@(Get-ChildItem -LiteralPath $Path -Recurse -Force | Sort-Object FullName | ForEach-Object {
        $hash = if ($_.PSIsContainer) { 'directory' } else { Get-EggySha256 -Path $_.FullName }
        "$(Get-EggyRelativePath -Root $Path -Path $_.FullName)|$hash"
    }) -join "`n")
}

function New-TestMap {
    param(
        [Parameter(Mandatory = $true)][string]$Workspace,
        [Parameter(Mandatory = $true)][string]$Name,
        [ValidateSet('Origin', 'World', 'Conflict', 'Ambiguous')][string]$Edition
    )
    $project = Join-Path $Workspace ('LuaSource_' + $Name)
    [System.IO.Directory]::CreateDirectory($project) | Out-Null
    if ($Edition -eq 'Origin') {
        Write-TestFile -Path (Join-Path $project 'eggy.json') -Content '{"isSEMap":false}'
        Write-TestFile -Path (Join-Path $project 'EggyAPI.lua') -Content "GameAPI = {}`n"
        Write-TestFile -Path (Join-Path $project 'main.lua') -Content "-- official entry`n"
    } elseif ($Edition -eq 'World') {
        Write-TestFile -Path (Join-Path $project 'eggy.json') -Content '{"isSEMap":true}'
        foreach ($side in @('client', 'server', 'common')) { [System.IO.Directory]::CreateDirectory((Join-Path $project $side)) | Out-Null }
        Write-TestFile -Path (Join-Path $project 'client\main.lua') -Content "-- official client entry`n"
        Write-TestFile -Path (Join-Path $project 'server\main.lua') -Content "-- official server entry`n"
    } elseif ($Edition -eq 'Conflict') {
        Write-TestFile -Path (Join-Path $project 'eggy.json') -Content '{"isSEMap":true}'
        Write-TestFile -Path (Join-Path $project '.codemaker\config.json') -Content '{"is_se_mode":false}'
    }
    return [pscustomobject]@{ Workspace = $Workspace; Project = $project }
}

function Invoke-MapInstall {
    param(
        [Parameter(Mandatory = $true)][object]$Map,
        [string]$SourcePackage = $package,
        [ValidateSet('Codex', 'OpenCode', 'ZCode')][string]$Agent = 'Codex',
        [switch]$ExpectFailure,
        [string]$ExpectedPattern
    )
    return Invoke-TestScript -ScriptPath (Join-Path $SourcePackage 'scripts\install-eggy-agent.ps1') -Arguments @(
        '-WorkspaceRoot', $Map.Workspace,
        '-ProjectPath', $Map.Project,
        '-PlayerMode', 'Multiplayer',
        '-Agent', $Agent,
        '-Scope', 'Project',
        '-Profile', 'Auto'
    ) -ExpectFailure:$ExpectFailure -ExpectedPattern $ExpectedPattern
}

function Copy-TestPackage {
    param([Parameter(Mandatory = $true)][string]$Name)
    $destination = Join-Path $testRoot $Name
    [System.IO.Directory]::CreateDirectory($destination) | Out-Null
    Get-ChildItem -LiteralPath $package -Force |
        Where-Object { $_.Name -notin @('.git', 'dist', '.release-temp-bdfcd48047d54369ae137d75f1cd35e5') } |
        ForEach-Object { Copy-Item -LiteralPath $_.FullName -Destination $destination -Recurse -Force }
    return $destination
}

function Set-TestPackageVersion {
    param([Parameter(Mandatory = $true)][string]$PackagePath, [Parameter(Mandatory = $true)][string]$Version)
    Write-TestFile -Path (Join-Path $PackagePath 'VERSION') -Content ($Version + "`n")
    Invoke-TestScript -ScriptPath (Join-Path $PackagePath 'scripts\generate-release-manifest.ps1') -Arguments @('-PackageRoot', $PackagePath) | Out-Null
}

try {
    [System.IO.Directory]::CreateDirectory($testRoot) | Out-Null
    $mapSkillCount = @(Get-EggyProfileSkillNames -Catalog $catalog -Profile 'map-origin').Count
    $worldSkillCount = @(Get-EggyProfileSkillNames -Catalog $catalog -Profile 'map-world').Count
    $combinedSkillCount = @((@(Get-EggyProfileSkillNames -Catalog $catalog -Profile 'map-origin') + @(Get-EggyProfileSkillNames -Catalog $catalog -Profile 'map-world')) | Sort-Object -Unique).Count
    $optionalOriginCount = @(Get-EggyProfileSkillNames -Catalog $catalog -Profile 'map-origin-optional').Count
    $toolingSkillCount = @(Get-EggyProfileSkillNames -Catalog $catalog -Profile 'tooling').Count

    # 地图同步目录不能承载共享安装；各种错误入口均须在任何写入前拒绝。
    $boundaryWorkspace = New-TestWorkspace -Name '00 安装目录边界'
    $installer = Join-Path $package 'scripts\install-eggy-agent.ps1'
    foreach ($hostName in @('Codex', 'OpenCode', 'ZCode')) {
        $edition = if ($hostName -eq 'Codex') { 'Origin' } else { 'World' }
        $boundaryMap = New-TestMap -Workspace $boundaryWorkspace -Name $hostName -Edition $edition
        $before = Get-TestTreeSignature -Path $boundaryMap.Project
        Invoke-MapInstall -Map ([pscustomobject]@{Workspace=$boundaryMap.Project; Project=$boundaryMap.Project}) `
            -Agent $hostName -ExpectFailure -ExpectedPattern '共享技能不能安装到地图工程' | Out-Null
        Assert-Test -Condition ((Get-TestTreeSignature -Path $boundaryMap.Project) -eq $before) -Message "$hostName 错误安装改动了地图"
    }
    $nestedWorkspace = Join-Path $boundaryMap.Project '工具 子目录'
    [System.IO.Directory]::CreateDirectory($nestedWorkspace) | Out-Null
    $before = Get-TestTreeSignature -Path $boundaryMap.Project
    Invoke-TestScript -ScriptPath $installer -Arguments @(
        '-WorkspaceRoot', $nestedWorkspace, '-Agent', 'ZCode', '-Profile', 'tooling'
    ) -ExpectFailure -ExpectedPattern '共享技能不能安装到地图工程' | Out-Null
    Invoke-TestScript -ScriptPath (Join-Path $package 'scripts\update-eggy-agent.ps1') -Arguments @(
        '-WorkspaceRoot', $nestedWorkspace, '-PackageRoot', $package
    ) -ExpectFailure -ExpectedPattern '共享技能不能安装到地图工程' | Out-Null
    Push-Location -LiteralPath $boundaryMap.Project
    try {
        Invoke-TestScript -ScriptPath $installer -Arguments @('-Agent', 'Codex', '-Profile', 'tooling') `
            -ExpectFailure -ExpectedPattern '显式指定 WorkspaceRoot' | Out-Null
    } finally {
        Pop-Location
    }
    Assert-Test -Condition ((Get-TestTreeSignature -Path $boundaryMap.Project) -eq $before) -Message '子目录、升级或默认当前目录入口写入了地图'

    # 非标准名称仍按工程标记识别，不可换成工具档案绕过地图边界。
    $renamedMap = New-TestWorkspace -Name '00 非标准名称工程'
    Write-TestFile -Path (Join-Path $renamedMap 'eggy.json') -Content '{"isSEMap":true}'
    $before = Get-TestTreeSignature -Path $renamedMap
    Invoke-TestScript -ScriptPath $installer -Arguments @(
        '-WorkspaceRoot', $renamedMap, '-Agent', 'OpenCode', '-Profile', 'tooling'
    ) -ExpectFailure -ExpectedPattern '共享技能不能安装到地图工程' | Out-Null
    Assert-Test -Condition ((Get-TestTreeSignature -Path $renamedMap) -eq $before) -Message '改名工程被错误写入'

    # 原点版首次安装、用户文件保留、项目独立 Git 和动态技能数量。
    $workspace = New-TestWorkspace -Name '01 中文 工作区'
    $origin = New-TestMap -Workspace $workspace -Name '原点 空白图' -Edition Origin
    Write-TestFile -Path (Join-Path $workspace 'AGENTS.md') -Content "工作区用户内容`n"
    Write-TestFile -Path (Join-Path $origin.Project 'AGENTS.md') -Content "地图用户内容`n"
    Write-TestFile -Path (Join-Path $origin.Project 'docs\需求文档.md') -Content "用户玩法内容`n"
    Invoke-MapInstall -Map $origin -ExpectedPattern "当前受管技能 $mapSkillCount 项" | Out-Null
    $statePath = Join-Path $workspace '.eggy-agent\install-state.json'
    $state = Read-TestJson -Path $statePath
    Assert-Test -Condition ([int]$state.schemaVersion -eq 4) -Message '首次安装应写入第四版状态格式'
    Assert-Test -Condition (@($state.projects).Count -eq 1 -and [string]$state.projects[0].edition -eq 'Origin') -Message '原点版登记信息不正确'
    Assert-Test -Condition (@(Get-ChildItem (Join-Path $workspace '.agents\skills') -Directory).Count -eq $mapSkillCount) -Message '原点版技能数量应来自档案'
    Assert-TestText -Text (Get-Content -Raw -Encoding UTF8 (Join-Path $workspace 'AGENTS.md')) -Pattern '工作区用户内容' -Message '工作区用户内容被覆盖'
    Assert-TestText -Text (Get-Content -Raw -Encoding UTF8 (Join-Path $origin.Project 'AGENTS.md')) -Pattern '地图用户内容' -Message '地图用户内容被覆盖'
    Assert-TestText -Text (Get-Content -Raw -Encoding UTF8 (Join-Path $origin.Project 'docs\需求文档.md')) -Pattern '用户玩法内容' -Message '玩法需求被覆盖'
    Assert-Test -Condition (Test-Path (Join-Path $origin.Project 'docs\开发计划.md')) -Message '缺失开发计划未创建'
    $installedRules = Get-Content -Raw -Encoding UTF8 (Join-Path $workspace 'AGENTS.md')
    Assert-TestText -Text $installedRules -Pattern '以下各节仅用于地图开发' -Message '地图规则缺少任务域边界'
    Assert-TestText -Text $installedRules -Pattern '不询问地图，不创建地图文档' -Message '共享工作区缺少辅助工具路线'
    $installedPlan = Get-Content -Raw -Encoding UTF8 (Join-Path $origin.Project 'docs\开发计划.md')
    Assert-TestText -Text $installedPlan -Pattern '## 活跃任务' -Message '开发计划未使用任务索引'
    Assert-Test -Condition ($installedPlan -notmatch '规则执行回执|接口查证记录|开发与测试记录') -Message '开发计划仍要求重复过程记录'
    Assert-Test -Condition ((& git -C $origin.Project rev-parse --show-toplevel).Trim().EndsWith((Split-Path $origin.Project -Leaf))) -Message '地图没有独立 Git 仓库'

    # 同一工作区追加世界版，不复制第二套技能，并保留版本隔离。
    $world = New-TestMap -Workspace $workspace -Name '世界 空白图' -Edition World
    Invoke-MapInstall -Map $world -ExpectedPattern "当前受管技能 $combinedSkillCount 项" | Out-Null
    $state = Read-TestJson -Path $statePath
    Assert-Test -Condition (@($state.projects).Count -eq 2) -Message '同一工作区应登记两张地图'
    Assert-Test -Condition (@(Get-ChildItem (Join-Path $workspace '.agents\skills') -Directory).Count -eq $combinedSkillCount) -Message '追加地图不应复制技能目录'
    foreach ($map in @($origin, $world)) {
        foreach ($relative in @('.agents', '.zcode', '.eggy-agent')) {
            Assert-Test -Condition (-not (Test-Path -LiteralPath (Join-Path $map.Project $relative))) -Message "共享安装产物不应进入地图：$relative"
        }
    }
    Assert-TestText -Text (Get-Content -Raw -Encoding UTF8 (Join-Path $world.Project 'AGENTS.md')) -Pattern '世界版' -Message '世界版规则未写入'
    Assert-TestText -Text (Get-Content -Raw -Encoding UTF8 (Join-Path $world.Project 'AGENTS.md')) -Pattern '服务端权威状态' -Message '世界版运行侧规则缺失'

    # 用安装后的脚本验证示例路径与参数；只测试文本分类，不执行假地图的 Lua。
    $logAudit = Join-Path $workspace '.eggy-agent\scripts\log-audit.ps1'
    $logFile = Join-Path $origin.Project 'LogCheck.lua'
    foreach ($level in 1..4) {
        Write-TestFile -Path $logFile -Content "LuaAPI.log('check', $level)"
        $result = Invoke-TestScript -ScriptPath $logAudit -Arguments @('-ProjectPath', $origin.Project, '-ChangedFile', 'LogCheck.lua')
        Assert-TestText -Text $result -Pattern "LOG_CALL\|LUA_L$level\|" -Message '数字等级未按字面值清点'
        Assert-TestText -Text $result -Pattern 'LOG_AUDIT_RESULT=MANUAL_LEVEL_REVIEW_REQUIRED' -Message "数字等级 $level 被无证据放行"
    }
    Write-TestFile -Path $logFile -Content "GlobalAPI.debug('check')"
    Write-TestFile -Path (Join-Path $origin.Project 'LogCheckTwo.lua') -Content "-- LuaAPI.log('disabled', 3)"
    $result = Invoke-TestScript -ScriptPath $logAudit -Arguments @('-ProjectPath', $origin.Project, '-ChangedFile', 'LogCheck.lua,LogCheckTwo.lua')
    Assert-TestText -Text $result -Pattern 'FILES=2' -Message '文档的逗号分隔文件参数不可用'
    Assert-TestText -Text $result -Pattern 'LOG_AUDIT_RESULT=INVENTORY_READY' -Message '正常命名日志或行首注释被当成数字调用'
    Write-TestFile -Path (Join-Path $world.Project 'client\LogCheck.lua') -Content "LogService:Warn('check')"
    $result = Invoke-TestScript -ScriptPath $logAudit -Arguments @('-ProjectPath', $world.Project, '-ChangedFile', 'client\LogCheck.lua')
    Assert-TestText -Text $result -Pattern 'LOG_CALL\|WORLD_WARN\|' -Message '世界版日志未分类'
    Assert-TestText -Text $result -Pattern 'LOG_AUDIT_RESULT=MANUAL_LEVEL_REVIEW_REQUIRED' -Message '世界版警告未要求核对'
    $backupDirectory = Join-Path $workspace '.eggy-agent\backups'
    $backupCountBeforeRepeatInstall = @(Get-ChildItem -LiteralPath $backupDirectory -Directory -ErrorAction SilentlyContinue).Count
    Invoke-MapInstall -Map $world -ExpectedPattern '无需重复安装' | Out-Null
    $backupCountAfterRepeatInstall = @(Get-ChildItem -LiteralPath $backupDirectory -Directory -ErrorAction SilentlyContinue).Count
    Assert-Test -Condition ($backupCountAfterRepeatInstall -eq $backupCountBeforeRepeatInstall) -Message '无变化的重复安装不应创建新备份'

    # 可选档案只在明确要求时加入。
    Invoke-TestScript -ScriptPath (Join-Path $package 'scripts\install-eggy-agent.ps1') -Arguments @(
        '-WorkspaceRoot', $workspace, '-ProjectPath', $origin.Project, '-PlayerMode', 'Multiplayer',
        '-Agent', 'Codex', '-Scope', 'Project', '-Profile', 'Auto', '-IncludeOptional'
    ) -ExpectedPattern "当前受管技能 $($mapSkillCount + $optionalOriginCount) 项" | Out-Null

    # 停用/启用只移动受管技能，规则切换必须显式要求。
    $toggle = Join-Path $workspace '.eggy-agent\scripts\set-eggy-agent-enabled.ps1'
    Invoke-TestScript -ScriptPath $toggle -Arguments @('-WorkspaceRoot', $workspace, '-Mode', 'Disabled', '-IncludeRules') -ExpectedPattern '切换为 Disabled' | Out-Null
    Assert-Test -Condition (@(Get-ChildItem (Join-Path $workspace '.agents\skills') -Directory -ErrorAction SilentlyContinue).Count -eq 0) -Message '停用后技能仍在发现目录'
    $disabledCount = @(Get-ChildItem (Join-Path $workspace '.eggy-agent\disabled-skills\agents') -Directory -ErrorAction SilentlyContinue).Count
    Assert-Test -Condition ($disabledCount -eq ($mapSkillCount + $optionalOriginCount)) -Message '停用技能数量不正确'
    Assert-Test -Condition ((Get-Content -Raw -Encoding UTF8 (Join-Path $workspace 'AGENTS.md')) -notmatch 'EGGY-AGENT:BEGIN') -Message '规则未停用'
    $backupCountBeforeRepeatDisable = @(Get-ChildItem -LiteralPath $backupDirectory -Directory -ErrorAction SilentlyContinue).Count
    Invoke-TestScript -ScriptPath $toggle -Arguments @('-WorkspaceRoot', $workspace, '-Mode', 'Disabled', '-IncludeRules') -ExpectedPattern '没有创建新备份' | Out-Null
    $backupCountAfterRepeatDisable = @(Get-ChildItem -LiteralPath $backupDirectory -Directory -ErrorAction SilentlyContinue).Count
    Assert-Test -Condition ($backupCountAfterRepeatDisable -eq $backupCountBeforeRepeatDisable) -Message '无变化的重复停用不应创建新备份'
    Invoke-TestScript -ScriptPath $toggle -Arguments @('-WorkspaceRoot', $workspace, '-Mode', 'Enabled', '-IncludeRules') | Out-Null
    Assert-Test -Condition (@(Get-ChildItem (Join-Path $workspace '.agents\skills') -Directory).Count -eq ($mapSkillCount + $optionalOriginCount)) -Message '启用后技能未恢复'
    $backupCountBeforeRepeatEnable = @(Get-ChildItem -LiteralPath $backupDirectory -Directory -ErrorAction SilentlyContinue).Count
    Invoke-TestScript -ScriptPath $toggle -Arguments @('-WorkspaceRoot', $workspace, '-Mode', 'Enabled', '-IncludeRules') -ExpectedPattern '没有创建新备份' | Out-Null
    $backupCountAfterRepeatEnable = @(Get-ChildItem -LiteralPath $backupDirectory -Directory -ErrorAction SilentlyContinue).Count
    Assert-Test -Condition ($backupCountAfterRepeatEnable -eq $backupCountBeforeRepeatEnable) -Message '无变化的重复启用不应创建新备份'

    # ZCode 使用独立发现目录，且不污染 .agents/skills。
    $zWorkspace = New-TestWorkspace -Name '02 ZCode 工具'
    $zMap = New-TestMap -Workspace $zWorkspace -Name '世界图' -Edition World
    Invoke-MapInstall -Map $zMap -Agent ZCode -ExpectedPattern 'ZCode' | Out-Null
    Assert-Test -Condition (Test-Path (Join-Path $zWorkspace '.zcode\skills')) -Message 'ZCode 目标目录缺失'
    Assert-Test -Condition (-not (Test-Path (Join-Path $zWorkspace '.agents\skills'))) -Message 'ZCode 不应创建 .agents/skills'

    # 辅助工具档案不创建地图规则和地图文档。
    $toolWorkspace = New-TestWorkspace -Name '03 辅助工具'
    Invoke-TestScript -ScriptPath (Join-Path $package 'scripts\install-eggy-agent.ps1') -Arguments @(
        '-WorkspaceRoot', $toolWorkspace, '-Agent', 'OpenCode', '-Scope', 'Project', '-Profile', 'tooling'
    ) -ExpectedPattern "当前受管技能 $toolingSkillCount 项" | Out-Null
    Assert-Test -Condition (Test-Path (Join-Path $toolWorkspace '.agents\skills\eggy-ponytail')) -Message '工具档案缺少公共极简技能'
    Assert-Test -Condition (-not (Test-Path (Join-Path $toolWorkspace 'AGENTS.md'))) -Message '工具安装不应写地图规则'
    Assert-Test -Condition (-not (Test-Path (Join-Path $toolWorkspace 'docs'))) -Message '工具安装不应创建地图文档'
    Invoke-TestScript -ScriptPath (Join-Path $package 'scripts\set-eggy-agent-enabled.ps1') -Arguments @(
        '-WorkspaceRoot', $toolWorkspace, '-Scope', 'Global', '-Mode', 'Disabled', '-IncludeRules'
    ) -ExpectFailure -ExpectedPattern '全局技能启停不管理' | Out-Null

    # 用户改动受管技能后，升级在写入前整体停止。
    $nextPackage = Copy-TestPackage -Name '04 升级包'
    Set-TestPackageVersion -PackagePath $nextPackage -Version '0.1.0-rc.6'
    $nextSkill = Join-Path $nextPackage 'skills\eggy-lua-coding\SKILL.md'
    Write-TestFile -Path $nextSkill -Content ((Get-Content -Raw -Encoding UTF8 $nextSkill) + "`n升级测试只修改此技能`n")
    Set-TestPackageVersion -PackagePath $nextPackage -Version '0.1.0-rc.6'
    $changedSkill = Join-Path $workspace '.agents\skills\eggy-lua-coding\SKILL.md'
    Write-TestFile -Path $changedSkill -Content ((Get-Content -Raw -Encoding UTF8 $changedSkill) + "`n用户本地修改`n")
    $beforeVersion = [string](Read-TestJson -Path $statePath).version
    Invoke-TestScript -ScriptPath (Join-Path $nextPackage 'scripts\update-eggy-agent.ps1') -Arguments @('-WorkspaceRoot', $workspace, '-PackageRoot', $nextPackage) -ExpectFailure -ExpectedPattern '受管文件' | Out-Null
    Assert-Test -Condition ([string](Read-TestJson -Path $statePath).version -eq $beforeVersion) -Message '升级冲突不应改变状态'
    Copy-Item -LiteralPath (Join-Path $package 'skills\eggy-lua-coding\SKILL.md') -Destination $changedSkill -Force
    Invoke-TestScript -ScriptPath (Join-Path $nextPackage 'scripts\update-eggy-agent.ps1') -Arguments @('-WorkspaceRoot', $workspace, '-PackageRoot', $nextPackage) -ExpectedPattern '0.1.0-rc.6' | Out-Null
    $updatedState = Read-TestJson -Path $statePath
    Assert-Test -Condition ([string]$updatedState.version -eq '0.1.0-rc.6') -Message '升级版本没有写入'
    Assert-Test -Condition (Test-Path (Join-Path $workspace '.eggy-agent\template-upgrade-report.md')) -Message '升级报告没有生成'
    $upgradeBackup = Read-TestJson -Path (Join-Path ([string]$updatedState.latestBackup) 'backup.json')
    $upgradeBackupPaths = @($upgradeBackup.files | ForEach-Object { [string]$_.path })
    Assert-Test -Condition ($upgradeBackupPaths -contains '.agents/skills/eggy-lua-coding/SKILL.md') -Message '升级备份缺少实际变化的技能文件'
    Assert-Test -Condition ($upgradeBackupPaths -notcontains '.agents/skills/eggy-qa/SKILL.md') -Message '升级备份复制了未变化的技能文件'

    # 旧版单地图状态可以迁移到第四版。
    $legacyWorkspace = New-TestWorkspace -Name '05 旧状态'
    $legacyMap = New-TestMap -Workspace $legacyWorkspace -Name '旧状态图' -Edition Origin
    Invoke-MapInstall -Map $legacyMap | Out-Null
    $legacyPath = Join-Path $legacyWorkspace '.eggy-agent\install-state.json'
    $v4 = Read-TestJson -Path $legacyPath
    $legacy = [pscustomobject]@{
        schemaVersion = 1
        version = [string]$v4.version
        installedAt = [string]$v4.installedAt
        workspaceRoot = $legacyWorkspace
        projectPath = $legacyMap.Project
        playerMode = 'Multiplayer'
        enabled = [bool]$v4.enabled
        rulesEnabled = [bool]$v4.rulesEnabled
        managedFiles = @($v4.managedFiles)
        rootRuleBlockSha256 = [string]$v4.rootRuleBlockSha256
        projectRuleBlockSha256 = [string]$v4.projects[0].projectRuleBlockSha256
        userOwnedDocuments = @($v4.projects[0].userOwnedDocuments)
        latestBackup = [string]$v4.latestBackup
    }
    Write-TestJson -Path $legacyPath -Value $legacy
    Invoke-TestScript -ScriptPath (Join-Path $nextPackage 'scripts\update-eggy-agent.ps1') -Arguments @('-WorkspaceRoot', $legacyWorkspace, '-PackageRoot', $nextPackage) | Out-Null
    Assert-Test -Condition ([int](Read-TestJson -Path $legacyPath).schemaVersion -eq 4) -Message '旧状态没有迁移到第四版'

    # 版本冲突、模糊版本和旧技能重复必须在写入前停止。
    $conflictWorkspace = New-TestWorkspace -Name '06 版本冲突'
    $conflictMap = New-TestMap -Workspace $conflictWorkspace -Name '冲突图' -Edition Conflict
    Invoke-MapInstall -Map $conflictMap -ExpectFailure -ExpectedPattern '相互冲突' | Out-Null
    Assert-Test -Condition (-not (Test-Path (Join-Path $conflictMap.Project '.git'))) -Message '版本冲突不应初始化 Git'
    $legacyWorkspace2 = New-TestWorkspace -Name '07 旧技能重复'
    $legacyMap2 = New-TestMap -Workspace $legacyWorkspace2 -Name '重复图' -Edition Origin
    Write-TestFile -Path (Join-Path $legacyWorkspace2 '.opencode\skills\eggy-qa\SKILL.md') -Content '旧技能'
    Invoke-MapInstall -Map $legacyMap2 -ExpectFailure -ExpectedPattern '同名旧技能' | Out-Null
    Assert-Test -Condition (-not (Test-Path (Join-Path $legacyMap2.Project '.git'))) -Message '旧技能冲突不应初始化 Git'

    # 初次安装恢复只移除工具包文件，保留用户文档。
    $restoreWorkspace = New-TestWorkspace -Name '08 初次恢复'
    $restoreMap = New-TestMap -Workspace $restoreWorkspace -Name '恢复图' -Edition Origin
    Invoke-MapInstall -Map $restoreMap | Out-Null
    $restoreStatePath = Join-Path $restoreWorkspace '.eggy-agent\install-state.json'
    $restoreState = Read-TestJson -Path $restoreStatePath
    Invoke-TestScript -ScriptPath (Join-Path $restoreWorkspace '.eggy-agent\scripts\restore-eggy-agent.ps1') -Arguments @('-WorkspaceRoot', $restoreWorkspace, '-BackupPath', ([string]$restoreState.latestBackup)) | Out-Null
    Assert-Test -Condition (-not (Test-Path $restoreStatePath)) -Message '初次恢复没有移除状态'
    Assert-Test -Condition (-not (Test-Path (Join-Path $restoreWorkspace '.agents\skills'))) -Message '初次恢复没有移除技能'
    Assert-Test -Condition (-not (Test-Path (Join-Path $restoreWorkspace '.agents'))) -Message '初次恢复没有清理空的宿主目录'
    Assert-Test -Condition (Test-Path (Join-Path $restoreMap.Project 'docs\开发计划.md')) -Message '恢复错误删除项目文档'

    # 恢复不能删除安装前已经存在的空技能根目录。
    $preserveWorkspace = New-TestWorkspace -Name '09 保留原有空目录'
    $preserveMap = New-TestMap -Workspace $preserveWorkspace -Name '保留图' -Edition Origin
    [System.IO.Directory]::CreateDirectory((Join-Path $preserveWorkspace '.agents\skills')) | Out-Null
    Invoke-MapInstall -Map $preserveMap | Out-Null
    $preserveStatePath = Join-Path $preserveWorkspace '.eggy-agent\install-state.json'
    $preserveState = Read-TestJson -Path $preserveStatePath
    Invoke-TestScript -ScriptPath (Join-Path $preserveWorkspace '.eggy-agent\scripts\restore-eggy-agent.ps1') -Arguments @('-WorkspaceRoot', $preserveWorkspace, '-BackupPath', ([string]$preserveState.latestBackup)) | Out-Null
    Assert-Test -Condition (Test-Path (Join-Path $preserveWorkspace '.agents\skills')) -Message '初次恢复删除了安装前已有的空技能根目录'
    Assert-Test -Condition (@(Get-ChildItem (Join-Path $preserveWorkspace '.agents\skills') -Force -ErrorAction SilentlyContinue).Count -eq 0) -Message '恢复后原有空技能根目录不为空'

    # 指纹有效也不能放行不存在的引用，防止文档能读、命令不能执行。
    $badDocsPackage = Copy-TestPackage -Name '10 文档引用检查'
    $badReadme = Join-Path $badDocsPackage 'README.md'
    $originalReadme = Get-Content -Raw -Encoding UTF8 $badReadme
    Write-TestFile -Path $badReadme -Content ($originalReadme + '`<总工作区>/.eggy-agent/scripts/missing-audit.ps1`')
    Set-TestPackageVersion -PackagePath $badDocsPackage -Version $currentVersion
    Invoke-TestScript -ScriptPath (Join-Path $badDocsPackage 'scripts\validate-release.ps1') -Arguments @('-PackageRoot', $badDocsPackage) `
        -ExpectFailure -ExpectedPattern '引用了未发布的安装脚本' | Out-Null
    Write-TestFile -Path $badReadme -Content ($originalReadme + '`../missing-reference.md`')
    Set-TestPackageVersion -PackagePath $badDocsPackage -Version $currentVersion
    Invoke-TestScript -ScriptPath (Join-Path $badDocsPackage 'scripts\validate-release.ps1') -Arguments @('-PackageRoot', $badDocsPackage) `
        -ExpectFailure -ExpectedPattern '相对链接目标不存在' | Out-Null

    Write-Output 'RELEASE_SMOKE_RESULT=PASS'
    Write-Output "ASSERTIONS=$script:assertions"
    $script:succeeded = $true
} finally {
    if ($script:succeeded) {
        $tempBase = ConvertTo-EggyFullPath -Path ([System.IO.Path]::GetTempPath())
        $resolved = ConvertTo-EggyFullPath -Path $testRoot
        if (-not (Test-EggyPathInside -Root $tempBase -Candidate $resolved)) {
            throw "拒绝清理系统临时目录之外的路径：$resolved"
        }
        if (Test-Path -LiteralPath $resolved) { Remove-Item -LiteralPath $resolved -Recurse -Force }
    } else {
        Write-Output "失败现场保留在：$testRoot"
    }
}
