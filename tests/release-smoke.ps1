[CmdletBinding()]
param([string]$PackageRoot)

$ErrorActionPreference = 'Stop'
if (-not $PackageRoot) { $PackageRoot = Join-Path $PSScriptRoot '..' }
$package = (Resolve-Path -LiteralPath $PackageRoot).Path
$currentVersion = (Get-Content -LiteralPath (Join-Path $package 'VERSION') -Raw -Encoding UTF8).Trim()
$testRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("蛋仔 Agent 发布测试-" + [Guid]::NewGuid().ToString('N'))
$utf8 = New-Object System.Text.UTF8Encoding($false)
$utf8Bom = New-Object System.Text.UTF8Encoding($true)
$script:assertions = 0
$script:succeeded = $false

function Write-TestFile {
    param([string]$Path, [string]$Content, [switch]$Bom)
    [System.IO.Directory]::CreateDirectory((Split-Path -Parent $Path)) | Out-Null
    [System.IO.File]::WriteAllText($Path, $Content.Replace("`r`n", "`n"), $(if ($Bom) { $utf8Bom } else { $utf8 }))
}

function Read-TestJson {
    param([string]$Path)
    return Get-Content -LiteralPath $Path -Raw -Encoding UTF8 | ConvertFrom-Json
}

function Write-TestJson {
    param([string]$Path, [object]$Value)
    Write-TestFile -Path $Path -Content (($Value | ConvertTo-Json -Depth 12) + "`n")
}

function Assert-Test {
    param([bool]$Condition, [string]$Message)
    if (-not $Condition) { throw "断言失败：$Message" }
    $script:assertions++
}

function Assert-TestText {
    param([string]$Text, [string]$Pattern, [string]$Message)
    Assert-Test -Condition ($Text -match $Pattern) -Message $Message
}

function Invoke-TestScript {
    param(
        [string]$ScriptPath,
        [string[]]$Arguments = @(),
        [switch]$ExpectFailure,
        [string]$ExpectedPattern
    )
    $previousPreference = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        $output = @(& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1)
        $exitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $previousPreference
    }
    $text = ($output | ForEach-Object { $_.ToString() }) -join "`n"
    if ($ExpectFailure) {
        Assert-Test -Condition ($exitCode -ne 0) -Message "预期失败但脚本成功：$ScriptPath"
    } else {
        Assert-Test -Condition ($exitCode -eq 0) -Message "脚本执行失败：$ScriptPath`n$text"
    }
    if ($ExpectedPattern) {
        Assert-TestText -Text $text -Pattern $ExpectedPattern -Message "输出未包含预期内容：$ExpectedPattern`n$text"
    }
    return $text
}

function New-TestWorkspace {
    param([string]$Name)
    $workspace = Join-Path $testRoot $Name
    [System.IO.Directory]::CreateDirectory($workspace) | Out-Null
    return $workspace
}

function New-TestMap {
    param(
        [string]$Workspace,
        [string]$Name,
        [ValidateSet('Origin', 'World', 'Ambiguous', 'Conflict')][string]$Edition,
        [switch]$ExistingContent
    )
    $project = Join-Path $Workspace "LuaSource_$Name"
    [System.IO.Directory]::CreateDirectory($project) | Out-Null
    Write-TestFile -Path (Join-Path $project 'EggyAPI.lua') -Content "GameAPI = {}`n"
    if ($Edition -eq 'Origin') {
        Write-TestFile -Path (Join-Path $project 'eggy.json') -Content '{"isSEMap":false}'
        Write-TestFile -Path (Join-Path $project '.codemaker\config.json') -Content '{"is_se_mode":false}'
        Write-TestFile -Path (Join-Path $project 'main.lua') -Content "-- 官方空白入口`n"
    } elseif ($Edition -eq 'World') {
        Write-TestFile -Path (Join-Path $project 'eggy.json') -Content '{"isSEMap":true}'
        Write-TestFile -Path (Join-Path $project '.codemaker\config.json') -Content '{"is_se_mode":true}'
        foreach ($side in @('client', 'server', 'common')) { [System.IO.Directory]::CreateDirectory((Join-Path $project $side)) | Out-Null }
        Write-TestFile -Path (Join-Path $project 'client\main.lua') -Content "-- 官方客户端入口`n"
        Write-TestFile -Path (Join-Path $project 'server\main.lua') -Content "-- 官方服务端入口`n"
        Write-TestFile -Path (Join-Path $project 'server\_trigger\official.lua') -Content "-- 官方蛋码触发文件`n"
    } elseif ($Edition -eq 'Conflict') {
        Write-TestFile -Path (Join-Path $project 'eggy.json') -Content '{"isSEMap":true}'
        Write-TestFile -Path (Join-Path $project '.codemaker\config.json') -Content '{"is_se_mode":false}'
    }
    if ($ExistingContent) {
        Write-TestFile -Path (Join-Path $Workspace 'AGENTS.md') -Content "总工作区用户规则保留标记`n"
        Write-TestFile -Path (Join-Path $project 'AGENTS.md') -Content "地图用户规则保留标记`n"
        Write-TestFile -Path (Join-Path $project 'docs\需求文档.md') -Content "用户现有玩法需求保留标记`n"
    }
    return [pscustomobject]@{ Workspace = $Workspace; Project = $project; Edition = $Edition }
}

function Invoke-Install {
    param([object]$Map, [string]$SourcePackage = $package, [switch]$ExpectFailure, [string]$ExpectedPattern)
    return Invoke-TestScript -ScriptPath (Join-Path $SourcePackage 'scripts\install-eggy-agent.ps1') -Arguments @(
        '-WorkspaceRoot', $Map.Workspace, '-ProjectPath', $Map.Project, '-PlayerMode', 'Multiplayer'
    ) -ExpectFailure:$ExpectFailure -ExpectedPattern $ExpectedPattern
}

function Copy-TestPackage {
    param([string]$Name)
    $destination = Join-Path $testRoot $Name
    [System.IO.Directory]::CreateDirectory($destination) | Out-Null
    Get-ChildItem -LiteralPath $package -Force | Where-Object { $_.Name -notin @('.git', 'dist') } | ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination $destination -Recurse -Force
    }
    return $destination
}

function Set-TestPackageVersion {
    param([string]$PackagePath, [string]$Version, [switch]$ChangeRequirementTemplate)
    Write-TestFile -Path (Join-Path $PackagePath 'VERSION') -Content ($Version + "`n")
    if ($ChangeRequirementTemplate) {
        $templatePath = Join-Path $PackagePath 'templates\需求文档模板.md'
        Write-TestFile -Path $templatePath -Content ((Get-Content -LiteralPath $templatePath -Raw -Encoding UTF8) + "`n<!-- 模板变化测试 -->`n")
    }
    Invoke-TestScript -ScriptPath (Join-Path $PackagePath 'scripts\generate-release-manifest.ps1') -Arguments @('-PackageRoot', $PackagePath) | Out-Null
}

try {
    [System.IO.Directory]::CreateDirectory($testRoot) | Out-Null

    # 同一总工作区先登记原点版，再登记世界版；技能始终只有一份。
    $mainWorkspace = New-TestWorkspace -Name '01 双版本 多地图'
    $origin = New-TestMap -Workspace $mainWorkspace -Name '原点 空白图' -Edition Origin -ExistingContent
    Invoke-Install -Map $origin -ExpectedPattern "成功安装版本 $([regex]::Escape($currentVersion))" | Out-Null
    $statePath = Join-Path $mainWorkspace '.eggy-agent\install-state.json'
    $state = Read-TestJson -Path $statePath
    Assert-Test -Condition ([int]$state.schemaVersion -eq 2) -Message '首次安装必须写入多地图状态格式'
    Assert-Test -Condition (@($state.projects).Count -eq 1) -Message '首次安装应登记一张地图'
    Assert-Test -Condition ([string]$state.projects[0].edition -eq 'Origin') -Message '原点版识别结果不正确'
    Assert-Test -Condition ((Get-ChildItem -LiteralPath (Join-Path $mainWorkspace '.agents\skills') -Directory).Count -eq 11) -Message '首次安装后应发现十一项技能'
    Assert-TestText -Text (Get-Content -LiteralPath (Join-Path $mainWorkspace 'AGENTS.md') -Raw -Encoding UTF8) -Pattern '总工作区用户规则保留标记' -Message '总工作区用户规则必须保留'
    Assert-TestText -Text (Get-Content -LiteralPath (Join-Path $origin.Project 'AGENTS.md') -Raw -Encoding UTF8) -Pattern '地图用户规则保留标记' -Message '地图用户规则必须保留'
    Assert-TestText -Text (Get-Content -LiteralPath (Join-Path $origin.Project 'docs\需求文档.md') -Raw -Encoding UTF8) -Pattern '用户现有玩法需求保留标记' -Message '已有玩法需求不得覆盖'
    foreach ($name in @('开发计划.md', '资产清单.md', '开发日志.md')) {
        Assert-Test -Condition (Test-Path -LiteralPath (Join-Path $origin.Project "docs\$name") -PathType Leaf) -Message "缺失项目文档应创建：$name"
    }
    Assert-Test -Condition (Test-Path -LiteralPath (Join-Path $origin.Project 'README.md') -PathType Leaf) -Message '缺失项目说明应创建'
    Assert-TestText -Text (Get-Content -LiteralPath (Join-Path $origin.Project 'AGENTS.md') -Raw -Encoding UTF8) -Pattern '原点版' -Message '原点版项目规则应写明版本'
    Assert-TestText -Text (Get-Content -LiteralPath (Join-Path $origin.Project 'AGENTS.md') -Raw -Encoding UTF8) -Pattern '打开总工作区' -Message '项目规则应提醒打开总工作区'
    $originGitRoot = [System.IO.Path]::GetFullPath((& git -C $origin.Project rev-parse --show-toplevel).Trim()).TrimEnd('\', '/')
    Assert-Test -Condition $originGitRoot.Equals([System.IO.Path]::GetFullPath($origin.Project).TrimEnd('\', '/'), [System.StringComparison]::OrdinalIgnoreCase) -Message '原点地图必须是独立仓库'

    $world = New-TestMap -Workspace $mainWorkspace -Name '世界 空白图' -Edition World
    Invoke-Install -Map $world -ExpectedPattern '登记到版本' | Out-Null
    $state = Read-TestJson -Path $statePath
    $registrationBackup = [string]$state.latestBackup
    Assert-Test -Condition (@($state.projects).Count -eq 2) -Message '同一总工作区应登记两张地图'
    Assert-Test -Condition (@($state.projects | Where-Object edition -eq 'World').Count -eq 1) -Message '世界版登记信息缺失'
    Assert-Test -Condition ((Get-ChildItem -LiteralPath (Join-Path $mainWorkspace '.agents\skills') -Directory).Count -eq 11) -Message '第二张地图不能复制第二套技能'
    Assert-TestText -Text (Get-Content -LiteralPath (Join-Path $world.Project 'AGENTS.md') -Raw -Encoding UTF8) -Pattern '世界版' -Message '世界版项目规则应写明版本'
    Assert-TestText -Text (Get-Content -LiteralPath (Join-Path $world.Project 'AGENTS.md') -Raw -Encoding UTF8) -Pattern '服务端权威状态' -Message '世界版项目规则应划分运行侧职责'
    $worldGitRoot = [System.IO.Path]::GetFullPath((& git -C $world.Project rev-parse --show-toplevel).Trim()).TrimEnd('\', '/')
    Assert-Test -Condition $worldGitRoot.Equals([System.IO.Path]::GetFullPath($world.Project).TrimEnd('\', '/'), [System.StringComparison]::OrdinalIgnoreCase) -Message '世界地图必须是独立仓库'
    Assert-Test -Condition (-not (& git -C $world.Project ls-files 'server/_trigger/*')) -Message '世界版官方触发目录不得纳入地图版本仓库'
    Invoke-Install -Map $world -ExpectedPattern '无需重复安装' | Out-Null

    # 追加地图的恢复只撤销本次登记，用户项目文档保留；随后可重新登记。
    $restorePath = Join-Path $mainWorkspace '.eggy-agent\scripts\restore-eggy-agent.ps1'
    Invoke-TestScript -ScriptPath $restorePath -Arguments @('-WorkspaceRoot', $mainWorkspace, '-BackupPath', $registrationBackup) | Out-Null
    Assert-Test -Condition (@((Read-TestJson -Path $statePath).projects).Count -eq 1) -Message '登记恢复应回到一张地图'
    $worldRulesAfterRestore = Join-Path $world.Project 'AGENTS.md'
    Assert-Test -Condition ((-not (Test-Path -LiteralPath $worldRulesAfterRestore -PathType Leaf)) -or
        ((Get-Content -LiteralPath $worldRulesAfterRestore -Raw -Encoding UTF8) -notmatch 'EGGY-AGENT:BEGIN')) -Message '登记恢复应移除世界地图受管规则'
    Assert-Test -Condition (Test-Path -LiteralPath (Join-Path $world.Project 'docs\开发计划.md') -PathType Leaf) -Message '恢复不能删除用户可能已填写的长期文档'
    Invoke-Install -Map $world | Out-Null

    # 启停覆盖总工作区与全部登记地图，且可以恢复。
    $togglePath = Join-Path $mainWorkspace '.eggy-agent\scripts\set-eggy-agent-enabled.ps1'
    Invoke-TestScript -ScriptPath $togglePath -Arguments @('-WorkspaceRoot', $mainWorkspace, '-Mode', 'Disabled', '-IncludeRules') -ExpectedPattern '2 张地图' | Out-Null
    Assert-Test -Condition (@(Get-ChildItem -LiteralPath (Join-Path $mainWorkspace '.agents\skills') -Directory -ErrorAction SilentlyContinue).Count -eq 0) -Message '停用后发现目录不能保留公开技能'
    Assert-Test -Condition (@(Get-ChildItem -LiteralPath (Join-Path $mainWorkspace '.eggy-agent\disabled-skills') -Directory).Count -eq 11) -Message '停用后十一项技能应进入停用目录'
    foreach ($rulesPath in @((Join-Path $mainWorkspace 'AGENTS.md'), (Join-Path $origin.Project 'AGENTS.md'), (Join-Path $world.Project 'AGENTS.md'))) {
        $hasManagedBlock = (Test-Path -LiteralPath $rulesPath -PathType Leaf) -and
            ((Get-Content -LiteralPath $rulesPath -Raw -Encoding UTF8) -match 'EGGY-AGENT:BEGIN')
        Assert-Test -Condition (-not $hasManagedBlock) -Message "规则停用失败：$rulesPath"
    }
    Invoke-TestScript -ScriptPath $togglePath -Arguments @('-WorkspaceRoot', $mainWorkspace, '-Mode', 'Enabled') | Out-Null
    $enabledState = Read-TestJson -Path $statePath
    $enableBackup = [string]$enabledState.latestBackup
    Assert-Test -Condition (@(Get-ChildItem -LiteralPath (Join-Path $mainWorkspace '.agents\skills') -Directory).Count -eq 11) -Message '重新启用后应恢复十一项技能'
    foreach ($rulesPath in @((Join-Path $mainWorkspace 'AGENTS.md'), (Join-Path $origin.Project 'AGENTS.md'), (Join-Path $world.Project 'AGENTS.md'))) {
        Assert-TestText -Text (Get-Content -LiteralPath $rulesPath -Raw -Encoding UTF8) -Pattern 'EGGY-AGENT:BEGIN' -Message "规则启用失败：$rulesPath"
    }
    Invoke-TestScript -ScriptPath $restorePath -Arguments @('-WorkspaceRoot', $mainWorkspace, '-BackupPath', $enableBackup) | Out-Null
    Assert-Test -Condition (@(Get-ChildItem -LiteralPath (Join-Path $mainWorkspace '.eggy-agent\disabled-skills') -Directory).Count -eq 11) -Message '启用恢复应回到停用状态'
    Invoke-TestScript -ScriptPath $togglePath -Arguments @('-WorkspaceRoot', $mainWorkspace, '-Mode', 'Enabled') | Out-Null

    # 目标冲突必须在移动第一项技能前发现。
    $conflictSkill = Join-Path $mainWorkspace '.eggy-agent\disabled-skills\eggy-qa'
    [System.IO.Directory]::CreateDirectory($conflictSkill) | Out-Null
    Copy-Item -LiteralPath (Join-Path $mainWorkspace '.agents\skills\eggy-qa\SKILL.md') -Destination (Join-Path $conflictSkill 'SKILL.md')
    Invoke-TestScript -ScriptPath $togglePath -Arguments @('-WorkspaceRoot', $mainWorkspace, '-Mode', 'Disabled') -ExpectFailure -ExpectedPattern '尚未修改任何内容' | Out-Null
    Assert-Test -Condition (@(Get-ChildItem -LiteralPath (Join-Path $mainWorkspace '.agents\skills') -Directory).Count -eq 11) -Message '启停冲突不能造成部分移动'
    Remove-Item -LiteralPath $conflictSkill -Recurse -Force

    # 新版升级在停用状态下更新共享技能，并完整保留两张地图登记和用户文档。
    $nextPackage = Copy-TestPackage -Name '候选升级包 rc3'
    Set-TestPackageVersion -PackagePath $nextPackage -Version '0.1.0-rc.3' -ChangeRequirementTemplate
    Invoke-TestScript -ScriptPath $togglePath -Arguments @('-WorkspaceRoot', $mainWorkspace, '-Mode', 'Disabled') | Out-Null
    Invoke-TestScript -ScriptPath (Join-Path $nextPackage 'scripts\update-eggy-agent.ps1') -Arguments @('-WorkspaceRoot', $mainWorkspace) -ExpectedPattern '登记地图 2 张' | Out-Null
    $upgradedState = Read-TestJson -Path $statePath
    $upgradeBackup = [string]$upgradedState.latestBackup
    Assert-Test -Condition ([string]$upgradedState.version -eq '0.1.0-rc.3') -Message '升级状态版本不正确'
    Assert-Test -Condition (-not [bool]$upgradedState.enabled) -Message '停用状态升级后必须继续停用'
    Assert-Test -Condition (@($upgradedState.projects).Count -eq 2) -Message '升级必须保留全部地图登记'
    Assert-Test -Condition (@(Get-ChildItem -LiteralPath (Join-Path $mainWorkspace '.eggy-agent\disabled-skills') -Directory).Count -eq 11) -Message '停用状态升级应更新停用区技能'
    $reportText = Get-Content -LiteralPath (Join-Path $mainWorkspace '.eggy-agent\template-upgrade-report.md') -Raw -Encoding UTF8
    Assert-TestText -Text $reportText -Pattern 'LuaSource_原点 空白图' -Message '升级报告应包含原点地图'
    Assert-TestText -Text $reportText -Pattern 'LuaSource_世界 空白图' -Message '升级报告应包含世界地图'
    Assert-TestText -Text $reportText -Pattern '有变化' -Message '模板变化应写入报告'
    Assert-TestText -Text (Get-Content -LiteralPath (Join-Path $origin.Project 'docs\需求文档.md') -Raw -Encoding UTF8) -Pattern '用户现有玩法需求保留标记' -Message '升级不得覆盖用户玩法需求'
    Invoke-TestScript -ScriptPath $restorePath -Arguments @('-WorkspaceRoot', $mainWorkspace, '-BackupPath', $upgradeBackup) | Out-Null
    Assert-Test -Condition ([string](Read-TestJson -Path $statePath).version -eq $currentVersion) -Message '升级恢复应回到候选版当前版本'
    Invoke-TestScript -ScriptPath $togglePath -Arguments @('-WorkspaceRoot', $mainWorkspace, '-Mode', 'Enabled') | Out-Null

    # 用户改过一个技能后，升级整体停止，其他受管文件不变。
    $changedSkill = Join-Path $mainWorkspace '.agents\skills\eggy-lua-coding\SKILL.md'
    Write-TestFile -Path $changedSkill -Content ((Get-Content -LiteralPath $changedSkill -Raw -Encoding UTF8) + "`n用户本地修改`n")
    $templateBefore = (Get-FileHash -LiteralPath (Join-Path $mainWorkspace '.eggy-agent\templates\需求文档模板.md') -Algorithm SHA256).Hash
    Invoke-TestScript -ScriptPath (Join-Path $nextPackage 'scripts\update-eggy-agent.ps1') -Arguments @('-WorkspaceRoot', $mainWorkspace) -ExpectFailure -ExpectedPattern '未修改任何文件' | Out-Null
    Assert-Test -Condition ([string](Read-TestJson -Path $statePath).version -eq $currentVersion) -Message '冲突升级不能改变版本'
    Assert-Test -Condition ((Get-FileHash -LiteralPath (Join-Path $mainWorkspace '.eggy-agent\templates\需求文档模板.md') -Algorithm SHA256).Hash -eq $templateBefore) -Message '冲突升级不能修改其他文件'
    Copy-Item -LiteralPath (Join-Path $package 'skills\eggy-lua-coding\SKILL.md') -Destination $changedSkill -Force

    # 旧单地图状态可由新版升级器迁移为多地图状态。
    $legacyStateWorkspace = New-TestWorkspace -Name '02 旧状态迁移'
    $legacyStateMap = New-TestMap -Workspace $legacyStateWorkspace -Name '旧状态图' -Edition Origin
    Invoke-Install -Map $legacyStateMap | Out-Null
    $legacyStatePath = Join-Path $legacyStateWorkspace '.eggy-agent\install-state.json'
    $v2 = Read-TestJson -Path $legacyStatePath
    $v1 = [pscustomobject]@{
        schemaVersion = 1; version = [string]$v2.version; installedAt = [string]$v2.installedAt
        workspaceRoot = $legacyStateWorkspace; projectPath = $legacyStateMap.Project; playerMode = 'Multiplayer'
        enabled = [bool]$v2.enabled; rulesEnabled = [bool]$v2.rulesEnabled; managedFiles = @($v2.managedFiles)
        rootRuleBlockSha256 = [string]$v2.rootRuleBlockSha256
        projectRuleBlockSha256 = [string]$v2.projects[0].projectRuleBlockSha256
        userOwnedDocuments = @($v2.projects[0].userOwnedDocuments); latestBackup = [string]$v2.latestBackup
    }
    Write-TestJson -Path $legacyStatePath -Value $v1
    Invoke-TestScript -ScriptPath (Join-Path $nextPackage 'scripts\update-eggy-agent.ps1') -Arguments @('-WorkspaceRoot', $legacyStateWorkspace) | Out-Null
    $migrated = Read-TestJson -Path $legacyStatePath
    Assert-Test -Condition ([int]$migrated.schemaVersion -eq 2 -and @($migrated.projects).Count -eq 1) -Message '旧状态迁移失败'
    Assert-Test -Condition ([string]$migrated.projects[0].edition -eq 'Origin') -Message '旧状态迁移应补充版本'

    # 不安全输入必须在地图版本仓库初始化前停止。
    $legacyWorkspace = New-TestWorkspace -Name '03 旧技能重复'
    $legacyMap = New-TestMap -Workspace $legacyWorkspace -Name '旧技能图' -Edition Origin
    Write-TestFile -Path (Join-Path $legacyWorkspace '.opencode\skills\eggy-old\SKILL.md') -Content "旧技能`n"
    Invoke-Install -Map $legacyMap -ExpectFailure -ExpectedPattern '检测到旧位置中的同名技能' | Out-Null
    Assert-Test -Condition (-not (Test-Path -LiteralPath (Join-Path $legacyMap.Project '.git'))) -Message '旧技能冲突不能初始化版本仓库'

    $conflictWorkspace = New-TestWorkspace -Name '04 版本标记冲突'
    $conflictMap = New-TestMap -Workspace $conflictWorkspace -Name '冲突图' -Edition Conflict
    Invoke-Install -Map $conflictMap -ExpectFailure -ExpectedPattern '版本标记相互冲突' | Out-Null
    Assert-Test -Condition (-not (Test-Path -LiteralPath (Join-Path $conflictMap.Project '.git'))) -Message '版本冲突应在版本仓库初始化前停止'

    $ambiguousWorkspace = New-TestWorkspace -Name '05 无法识别版本'
    $ambiguousMap = New-TestMap -Workspace $ambiguousWorkspace -Name '不明图' -Edition Ambiguous
    Invoke-Install -Map $ambiguousMap -ExpectFailure -ExpectedPattern '无法从工程标记' | Out-Null
    Assert-Test -Condition (-not (Test-Path -LiteralPath (Join-Path $ambiguousMap.Project '.git'))) -Message '无法识别版本时不能初始化版本仓库'

    $unsafePackage = Copy-TestPackage -Name '损坏清单 越界目标'
    $unsafeManifestPath = Join-Path $unsafePackage 'release-manifest.json'
    $unsafeManifest = Read-TestJson -Path $unsafeManifestPath
    $unsafeManifest.files[0].target = 'README.md'
    Write-TestJson -Path $unsafeManifestPath -Value $unsafeManifest
    $unsafeWorkspace = New-TestWorkspace -Name '06 越界清单'
    $unsafeMap = New-TestMap -Workspace $unsafeWorkspace -Name '越界图' -Edition Origin
    Invoke-Install -Map $unsafeMap -SourcePackage $unsafePackage -ExpectFailure -ExpectedPattern '超出公开工具受管区' | Out-Null

    $hashPackage = Copy-TestPackage -Name '损坏清单 文件指纹'
    Write-TestFile -Path (Join-Path $hashPackage 'skills\eggy-qa\SKILL.md') -Content "被篡改`n"
    $hashWorkspace = New-TestWorkspace -Name '07 指纹损坏'
    $hashMap = New-TestMap -Workspace $hashWorkspace -Name '指纹图' -Edition World
    Invoke-Install -Map $hashMap -SourcePackage $hashPackage -ExpectFailure -ExpectedPattern '文件指纹不一致' | Out-Null

    $markerWorkspace = New-TestWorkspace -Name '08 受管标记损坏'
    $markerMap = New-TestMap -Workspace $markerWorkspace -Name '标记图' -Edition Origin
    Write-TestFile -Path (Join-Path $markerWorkspace 'AGENTS.md') -Content "用户规则`n<!-- EGGY-AGENT:BEGIN -->`n"
    Invoke-Install -Map $markerMap -ExpectFailure -ExpectedPattern '受管标记不完整' | Out-Null
    Assert-Test -Condition (@(Get-ChildItem -LiteralPath (Join-Path $markerWorkspace '.agents\skills') -Recurse -File -ErrorAction SilentlyContinue).Count -eq 0) -Message '标记损坏失败后应恢复已复制技能'

    # 注入状态写入前中断，验证工具与新建长期文档都能恢复。
    $interruptPackage = Copy-TestPackage -Name '安装中断注入包'
    $interruptScript = Join-Path $interruptPackage 'scripts\install-eggy-agent.ps1'
    $interruptText = Get-Content -LiteralPath $interruptScript -Raw -Encoding UTF8
    $needle = '    Write-EggyJson -Path $statePath -Value $newState'
    Assert-Test -Condition $interruptText.Contains($needle) -Message '没有找到安装中断注入位置'
    $interruptText = $interruptText.Replace($needle, "    throw '测试注入：写状态前中断'`n$needle")
    Write-TestFile -Path $interruptScript -Content $interruptText -Bom
    Invoke-TestScript -ScriptPath (Join-Path $interruptPackage 'scripts\generate-release-manifest.ps1') -Arguments @('-PackageRoot', $interruptPackage) | Out-Null
    $interruptWorkspace = New-TestWorkspace -Name '09 安装中断'
    $interruptMap = New-TestMap -Workspace $interruptWorkspace -Name '中断图' -Edition World
    Invoke-Install -Map $interruptMap -SourcePackage $interruptPackage -ExpectFailure -ExpectedPattern '测试注入' | Out-Null
    foreach ($relative in @('docs\需求文档.md', 'docs\开发计划.md', 'docs\资产清单.md', 'docs\开发日志.md', 'README.md')) {
        Assert-Test -Condition (-not (Test-Path -LiteralPath (Join-Path $interruptMap.Project $relative))) -Message "安装中断后不应残留新建文档：$relative"
    }
    Assert-Test -Condition (@(Get-ChildItem -LiteralPath (Join-Path $interruptWorkspace '.agents\skills') -Recurse -File -ErrorAction SilentlyContinue).Count -eq 0) -Message '安装中断后不应残留技能文件'

    # 四个审查脚本在隔离假工程中验证，不接触真实地图。
    $auditProject = Join-Path $testRoot '10 四个审查脚本\LuaSource_审查测试'
    $docsRoot = Join-Path $testRoot '10 四个审查脚本\官方手册'
    $examplesRoot = Join-Path $testRoot '10 四个审查脚本\官方示例'
    Write-TestFile -Path (Join-Path $auditProject 'eggy.json') -Content '{"isSEMap":false}'
    Write-TestFile -Path (Join-Path $auditProject 'EggyAPI.lua') -Content "function GameAPI.test_api(player, text) end`n"
    Write-TestFile -Path (Join-Path $docsRoot 'manual.md') -Content "test_api 的参数说明`n"
    Write-TestFile -Path (Join-Path $examplesRoot 'demo.lua') -Content "GameAPI.test_api(player, 'hello')`n"
    Write-TestFile -Path (Join-Path $auditProject 'export.lua') -Content "---@export`n---@param value integer`n---@return integer`nfunction EggyExport(value)`n    return value`nend`n"
    Write-TestFile -Path (Join-Path $auditProject 'logs.lua') -Content "GlobalAPI.debug('正常')`nGlobalAPI.warning('需要复审') -- 【测试专用】`n"
    Invoke-TestScript -ScriptPath (Join-Path $package 'scripts\api-preflight.ps1') -Arguments @('-ProjectPath', $auditProject, '-ApiName', 'GameAPI.test_api', '-DocsRoot', $docsRoot, '-ExamplesRoot', $examplesRoot) -ExpectedPattern 'API_PREFLIGHT_RESULT=SEARCH_HITS_FOUND' | Out-Null
    Invoke-TestScript -ScriptPath (Join-Path $package 'scripts\export-contract-audit.ps1') -Arguments @('-ProjectPath', $auditProject, '-Target', 'export.lua', '-FailOnExport') -ExpectFailure -ExpectedPattern 'EXPORT_CONTRACT_AUDIT_RESULT=EXTERNAL_CONTRACTS_FOUND' | Out-Null
    Invoke-TestScript -ScriptPath (Join-Path $package 'scripts\log-audit.ps1') -Arguments @('-ProjectPath', $auditProject, '-ChangedFile', 'logs.lua') -ExpectedPattern 'LOG_AUDIT_RESULT=MANUAL_LEVEL_REVIEW_REQUIRED' | Out-Null
    Invoke-TestScript -ScriptPath (Join-Path $package 'scripts\git-batch-audit.ps1') -Arguments @('-ProjectPath', $origin.Project) -ExpectedPattern '仓库根目录' | Out-Null

    $worldAudit = New-TestMap -Workspace (New-TestWorkspace -Name '10 世界版日志审查') -Name '日志图' -Edition World
    Write-TestFile -Path (Join-Path $worldAudit.Project 'server\logs.lua') -Content "LogService:Info('正常信息', {})`nLogService:Warn('需要复审', {}) -- 【测试专用】`n"
    Invoke-TestScript -ScriptPath (Join-Path $package 'scripts\log-audit.ps1') -Arguments @('-ProjectPath', $worldAudit.Project, '-ChangedFile', 'server\logs.lua') -ExpectedPattern 'WORLD_INFO=1' | Out-Null

    # 首次安装的恢复在没有后续操作时移除公共工具和规则，但保留用户文档。
    $restoreWorkspace = New-TestWorkspace -Name '11 首次安装恢复'
    $restoreMap = New-TestMap -Workspace $restoreWorkspace -Name '恢复图' -Edition Origin -ExistingContent
    Invoke-Install -Map $restoreMap | Out-Null
    $restoreStatePath = Join-Path $restoreWorkspace '.eggy-agent\install-state.json'
    $restoreState = Read-TestJson -Path $restoreStatePath
    Invoke-TestScript -ScriptPath (Join-Path $restoreWorkspace '.eggy-agent\scripts\restore-eggy-agent.ps1') -Arguments @('-WorkspaceRoot', $restoreWorkspace, '-BackupPath', ([string]$restoreState.latestBackup)) | Out-Null
    Assert-Test -Condition (-not (Test-Path -LiteralPath $restoreStatePath)) -Message '首次安装恢复后不应保留安装状态'
    Assert-Test -Condition (@(Get-ChildItem -LiteralPath (Join-Path $restoreWorkspace '.agents\skills') -Recurse -File -ErrorAction SilentlyContinue).Count -eq 0) -Message '首次安装恢复后不应保留技能文件'
    Assert-TestText -Text (Get-Content -LiteralPath (Join-Path $restoreWorkspace 'AGENTS.md') -Raw -Encoding UTF8) -Pattern '总工作区用户规则保留标记' -Message '首次安装恢复必须保留用户规则'
    Assert-Test -Condition (Test-Path -LiteralPath (Join-Path $restoreMap.Project 'docs\开发计划.md') -PathType Leaf) -Message '恢复不能删除可能已填写的项目文档'

    $script:succeeded = $true
    Write-Output 'RELEASE_SMOKE_RESULT=PASS'
    Write-Output "ASSERTIONS=$script:assertions"
} finally {
    if ($script:succeeded) {
        $tempRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath()).TrimEnd('\')
        $resolvedTestRoot = [System.IO.Path]::GetFullPath($testRoot).TrimEnd('\')
        if (-not $resolvedTestRoot.StartsWith($tempRoot + '\', [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "拒绝清理系统临时目录之外的路径：$resolvedTestRoot"
        }
        if (Test-Path -LiteralPath $resolvedTestRoot) { Remove-Item -LiteralPath $resolvedTestRoot -Recurse -Force }
    } else {
        Write-Output "失败现场保留在：$testRoot"
    }
}
