# 第 22 章：Capstone 综合项目

把双端协议、场景对象、回合、得分、HUD 和生命周期整合成完整项目。

## 你会学到什么

这一章把前面的 Unit、事件、双端通信、UI、data 配置、Manager、日志和 QA 串成一个完整项目。读完后，你应该能把一个“能玩的小玩法”拆成稳定的工程结构，而不是把所有代码堆进 `main.lua`。

## 项目推进通用流程

```text
需求拆解
→ 确定服务端权威状态
→ 设计 client / server / common / data 分层
→ 写最小可玩闭环
→ 加 UI 与表现反馈
→ 加存储、排行或多人能力
→ 写期望日志、testspec 和回归清单
→ 用 playtest 验证并修正
```

无论做哪类项目，都先回答 5 个问题：

| 问题 | 推荐答案 |
| --- | --- |
| 谁维护权威状态？ | server |
| client 能做什么？ | 输入请求、UI 显示、本地表现 |
| 跨端事件在哪里定义？ | `common/remote_events.lua` |
| 资源和参数放哪里？ | `data/*.lua` |
| 复杂逻辑放哪里？ | server/client Manager |

## 三个项目的梯度

| 项目 | 覆盖能力 | 参考 Demo |
| --- | --- | --- |
| 球体碰撞方块完整版 | Unit、碰撞、Timer、RemoteEvent、EUI、data、Manager | `WorldUnit示例/`、`UI Demo/` |
| 投篮/钓鱼小游戏 | 输入、物理、服务端判定、DataStore、排行榜 | `投篮小游戏/`、`钓鱼UI游戏/`、`DataStoreTest/` |
| 多人 1V1 竞技场 | 玩家、阵营、技能、动画、胜利规则、回归测试 | `1V1竞技场/`、`技能Demo/`、`胜利规则/` |

第一轮建议先做项目 A。它能检验前 1-21 章中工程分层、场景、通信、UI、物理、表现、生命周期和 QA 的主线是否真正贯通。

## 建议先跑最小闭环

如果你想直接按完整目录安装，可以先[下载 Capstone Lua 工程](https://u5-creator.s3.game.163.com/manual/downloads/se-ugc-lua-capstone.zip)。ZIP 只包含本章六个 Lua 文件；场景对象、EUI 节点和资源仍需按下文手动准备。

Capstone 章节代码较长，阅读时不要一上来就追求“完整系统一次成功”。更稳的做法是分三步落地：

1. 先放好 `球体`、`方块` 和两个 HUD 文本节点，只跑 `RoundManager:Init()` 和 `Start()`，看到“新一局开始”日志。
2. 再接碰撞计分和 `HudSnapshot`，确认服务端加分、客户端 HUD 更新。
3. 最后补随机刷新、命中特效、倒计时重开、中途加入同步和 QA 证据。

下面的文件示例按最终结构给出。复制时按小标题放到对应目录；如果只做第一步，可以先保留暂时用不到的函数，但验收时必须至少跑通“启动 → 碰撞 → 加分 → HUD 更新”这一条链路。

## 项目 A：球体碰撞方块完整版

目标：玩家推动“球体”碰撞“方块”得分，服务端维护 60 秒倒计时和分数，客户端只显示 HUD。方块被命中后随机刷新位置，球体回到起点。

### 场景准备

1. 在编辑器里放置球体，命名为 `球体`，物理类型设为受力物体（`Dynamic`）。
2. 放置方块，命名为 `方块`，和球体保持距离，不要一开始就重叠。
3. 放置并配置一个 `EffectUnit`，命名为 `HitEffect`，设置好特效资源并将初始状态设为不可见。
4. UI 编辑器中创建两个文本节点，稳定命名为 `label_time`、`label_point`，保存 UI。
5. 将本章参考代码放入对应目录：`common/`、`data/`、`server/`、`client/`。

### 推荐目录

```text
common/
  remote_events.lua
data/
  capstone_config.lua
server/
  round_manager.lua
  main.lua
client/
  hud.lua
  main.lua
```

`main.lua` 只负责组装。真正的回合、计分、UI 更新放进模块，后续加排行榜、音效、关卡配置时才不会失控。

### data/capstone\_config.lua

```lua
-- @runtime server
return {
    RoundSeconds = 60,
    HitCooldown = 1,
    SnapshotRequestCooldown = 0.5,
    RestartDelay = 5,
    CubeRandomZRange = 5,
    HitEffectName = "HitEffect",
    HitEffectDuration = 1,
}
```

`HitEffectName` 让表现选择仍然由配置驱动，但配置值对应当前公开契约能兑现的场景对象名。若玩法需要多套命中特效，可以在编辑器中预配置多个稳定命名的 `EffectUnit`，让关卡配置选择名称；不要把资源 URI 填进未公开的资源选择字段。这样仍能做到数据驱动换肤，同时让资源配置、预览和失败排查留在编辑器可见层。

### common/remote\_events.lua

```lua
-- @runtime server
return {
    RequestHudSnapshot = RemoteEvent.New("RequestHudSnapshot"),
    HudSnapshot = RemoteEvent.New("HudSnapshot"),
}
```

`RemoteEvent.New(...)` 是完整写法。这个 common 模块会分别被 server 和 client 入口加载；代码块用 server 标注展示权威通道的定义，客户端加载同一文件时不改变协议。每次 RemoteEvent 只传一个可选 `Any`，所以请求和快照都装进单个 table。

### server/round\_manager.lua

```lua
-- @runtime server

local RoundManager = {}
local World
local Players
local RunService
local Task
local RequestHudSnapshot
local HudSnapshot
local ball
local cube
local ballStartCF
local cubeStartPos
local roundSeconds = 0
local hitCooldown = 0
local snapshotRequestCooldown = 0
local restartDelay = 0
local cubeRandomZRange = 0
local hitEffectName = ""
local hitEffectDuration = 0
local scores = {}
local lastSnapshotRequest = {}
local connections = {}
local roundActive = false
local roundEndTime = 0
local lastHitTime = 0
local generation = 0
local effectGeneration = 0
local initialized = false

local function resetBall()
    ball.CFrame = ballStartCF
    ball.LinearVelocity = Vector3(0, 0, 0)
    ball.AngularVelocity = Vector3(0, 0, 0)
end

local function syncPlayer(player)
    if player == nil or not player:IsA("Player") then return end

    HudSnapshot:FireClient(player, {
        phase = roundActive and "running" or "waiting",
        endTime = roundActive and roundEndTime or 0,
        serverTime = World:GetServerTime(),
        score = scores[player.UserId] or 0,
    })
end

local function syncAllPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        syncPlayer(player)
    end
end

local function playHitEffect()
    local effect = World:FindFirstChild(hitEffectName, true)
    if effect == nil or not effect:IsA("EffectUnit") then return end

    effectGeneration = effectGeneration + 1
    local currentEffectGeneration = effectGeneration
    effect:SetVisible(false)
    effect:SetPosition(ball.Position)
    effect:SetVisible(true)

    Task:Delay(hitEffectDuration, function()
        if initialized and effectGeneration == currentEffectGeneration then
            effect:SetVisible(false)
        end
    end)
end

local function addScoreForLastOwner()
    local uid = ball:GetAttribute("LastOwnerUID")
    if type(uid) ~= "string" or uid == "" then
        print("[SE Lua Guide][WARN] 球体命中方块，但没有记录最后触碰玩家")
        return false
    end

    local player = Players:GetPlayerByUserId(uid)
    if player == nil then
        print("[SE Lua Guide][WARN] 找不到最后触碰玩家")
        return false
    end

    scores[uid] = (scores[uid] or 0) + 1
    ball:SetAttribute("LastOwnerUID", "")
    syncPlayer(player)
    print("[SE Lua Guide][Score] player=", player:GetName(), "score=", scores[uid])
    return true
end

local function moveCube()
    local offsetZ = math.random(-cubeRandomZRange, cubeRandomZRange)
    cube.Position = Vector3(cubeStartPos.x, cubeStartPos.y, cubeStartPos.z + offsetZ)
end

local function onBallTouched(otherUnit)
    if otherUnit == nil or not otherUnit:IsA("EggyUnit") then return end

    local player = Players:GetPlayerFromCharacter(otherUnit)
    if player ~= nil then
        ball:SetAttribute("LastOwnerUID", player.UserId)
    end
end

local function onCubeTouched(otherUnit)
    if otherUnit ~= ball or not roundActive then return end

    local now = World:GetServerTime()
    if now - lastHitTime < hitCooldown then return end
    if not addScoreForLastOwner() then return end
    lastHitTime = now

    playHitEffect()
    resetBall()
    moveCube()
end

local function onSnapshotRequested(player, payload)
    if player == nil or not player:IsA("Player") then return end
    if type(payload) ~= "table" or payload["kind"] ~= "ready" or payload["version"] ~= 1 then
        return
    end

    local now = World:GetServerTime()
    local last = lastSnapshotRequest[player.UserId] or -math.huge
    if now - last < snapshotRequestCooldown then return end
    lastSnapshotRequest[player.UserId] = now
    syncPlayer(player)
end

local function startRound()
    if not initialized or roundActive then return false end

    generation = generation + 1
    scores = {}
    roundActive = true
    lastHitTime = -hitCooldown
    roundEndTime = World:GetServerTime() + roundSeconds
    resetBall()
    cube.Position = cubeStartPos

    print("[SE Lua Guide][Round] started duration=", roundSeconds)
    syncAllPlayers()
    return true
end

local function updateRound()
    if not roundActive or World:GetServerTime() < roundEndTime then return end

    roundActive = false
    generation = generation + 1
    local restartGeneration = generation
    syncAllPlayers()
    print("[SE Lua Guide][Round] completed")

    Task:Delay(restartDelay, function()
        if initialized and generation == restartGeneration then
            startRound()
        end
    end)
end

local function destroyInternal()
    initialized = false
    roundActive = false
    generation = generation + 1
    effectGeneration = effectGeneration + 1
    for _, connection in ipairs(connections) do
        connection:Disconnect()
    end
    connections = {}
    scores = {}
    lastSnapshotRequest = {}

    if World ~= nil then
        local effect = World:FindFirstChild(hitEffectName, true)
        if effect ~= nil and effect:IsA("EffectUnit") then
            effect:SetVisible(false)
        end
    end
end

function RoundManager.Init(config, remoteEvents, deps)
    destroyInternal()
    if type(config) ~= "table" or type(remoteEvents) ~= "table" or type(deps) ~= "table" then
        return false
    end

    World = deps["World"]
    Players = deps["Players"]
    RunService = deps["RunService"]
    Task = deps["Task"]
    RequestHudSnapshot = remoteEvents["RequestHudSnapshot"]
    HudSnapshot = remoteEvents["HudSnapshot"]
    if World == nil or Players == nil or RunService == nil or Task == nil then return false end
    if RequestHudSnapshot == nil or HudSnapshot == nil then return false end

    roundSeconds = config["RoundSeconds"]
    hitCooldown = config["HitCooldown"]
    snapshotRequestCooldown = config["SnapshotRequestCooldown"]
    restartDelay = config["RestartDelay"]
    cubeRandomZRange = config["CubeRandomZRange"]
    hitEffectName = config["HitEffectName"]
    hitEffectDuration = config["HitEffectDuration"]
    if type(roundSeconds) ~= "number" or roundSeconds <= 0 then return false end
    if type(hitCooldown) ~= "number" or hitCooldown < 0 then return false end
    if type(snapshotRequestCooldown) ~= "number" or snapshotRequestCooldown < 0 then return false end
    if type(restartDelay) ~= "number" or restartDelay < 0 then return false end
    if type(cubeRandomZRange) ~= "number" or cubeRandomZRange < 0 then return false end
    if type(hitEffectName) ~= "string" or hitEffectName == "" then return false end
    if type(hitEffectDuration) ~= "number" or hitEffectDuration < 0 then return false end

    ball = World:FindFirstChild("球体")
    cube = World:FindFirstChild("方块")

    if ball == nil or not ball:IsA("WorldUnit") then
        print("[SE Lua Guide][WARN] 「球体」缺失或不是 WorldUnit")
        return false
    end
    if cube == nil or not cube:IsA("WorldUnit") then
        print("[SE Lua Guide][WARN] 「方块」缺失或不是 WorldUnit")
        return false
    end
    local effect = World:FindFirstChild(hitEffectName, true)
    if effect == nil or not effect:IsA("EffectUnit") then
        print("[SE Lua Guide][WARN] 「" .. hitEffectName .. "」缺失或不是 EffectUnit")
        return false
    end
    effect:SetVisible(false)

    ballStartCF = ball.CFrame
    cubeStartPos = cube.Position

    table.insert(connections, ball.OnCollisionEnter:Connect(onBallTouched))
    table.insert(connections, cube.OnCollisionEnter:Connect(onCubeTouched))
    table.insert(connections, RunService.Heartbeat:Connect(updateRound))
    table.insert(connections, RequestHudSnapshot.OnServerEvent:Connect(onSnapshotRequested))
    table.insert(connections, Players.PlayerRemoving:Connect(function(player)
        if player == nil then return end
        lastSnapshotRequest[player.UserId] = nil
    end))

    initialized = true
    return true
end

function RoundManager.Start()
    return startRound()
end

function RoundManager.Destroy()
    destroyInternal()
end

return RoundManager
```

### server/main.lua

```lua
-- @runtime server
local Config = require("data.capstone_config")
local RemoteEvents = require("common.remote_events")
local RoundManager = require("server.round_manager")

local World = game:GetService("World")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Task = game:GetService("Task")
if World == nil or Players == nil or RunService == nil or Task == nil then
    return
end

local initialized = RoundManager.Init(Config, RemoteEvents, {
    World = World,
    Players = Players,
    RunService = RunService,
    Task = Task,
})
if not initialized or not RoundManager.Start() then
    print("[SE Lua Guide][ERROR] Capstone 初始化失败")
    return
end

game:BindToClose(function()
    RoundManager.Destroy()
end)

return {
    Destroy = function() RoundManager.Destroy() end,
}
```

### client/hud.lua

```lua
-- @runtime client

local Hud = {}

local labelTime
local labelPoint
local roundActive = false
local roundEndTime = 0
local nextUpdateTime = 0
local missingNodeLogged = {}
local heartbeatConnection = nil
local Players = nil
local World = nil
local RunService = nil

local function GetNode(name, expectedType)
    local player = Players.LocalPlayer
    if not player or not player.PlayerGui then
        print("[SE Lua Guide][WARN] PlayerGui 尚未就绪，无法获取 UI 节点:", name)
        return nil
    end

    local euiManager = player.PlayerGui.EuiManager
    if not euiManager then
        print("[SE Lua Guide][WARN] EuiManager 尚未就绪，无法获取 UI 节点:", name)
        return nil
    end

    local rootNode = euiManager:GetRootNode()
    if not rootNode then
        print("[SE Lua Guide][WARN] EUI 根节点不存在:", name)
        return nil
    end

    -- 按稳定 Name 递归查找节点
    local node = rootNode:FindFirstChild(name, true)
    if node ~= nil and not node:IsA(expectedType) then
        node = nil
    end
    if node == nil and not missingNodeLogged[name] then
        missingNodeLogged[name] = true
        print("[SE Lua Guide][WARN] EUI 节点缺失或类型错误:", name, expectedType)
    end
    return node
end

function Hud:Init(deps)
    self:Destroy()
    if type(deps) ~= "table" or deps.Players == nil or deps.World == nil or deps.RunService == nil then
        return false
    end

    Players = deps.Players
    World = deps.World
    RunService = deps.RunService
    labelTime = GetNode("label_time", "EUITextLabel")
    labelPoint = GetNode("label_point", "EUITextLabel")

    if labelTime == nil or labelPoint == nil then
        return false
    end

    if labelTime then
        labelTime.Text = "等待开始"
    end
    if labelPoint then
        labelPoint.Text = "当前得分：0"
    end

    heartbeatConnection = RunService.Heartbeat:Connect(function()
        self:UpdateTime()
    end)
    return true
end

function Hud:ApplySnapshot(snapshot)
    if type(snapshot) ~= "table" then return false end
    if snapshot.phase ~= "running" and snapshot.phase ~= "waiting" then return false end
    if type(snapshot.endTime) ~= "number" or type(snapshot.serverTime) ~= "number" then return false end
    if type(snapshot.score) ~= "number" then return false end

    roundActive = snapshot.phase == "running"
    roundEndTime = snapshot.endTime

    if not roundActive and labelTime then
        labelTime.Text = "等待开始"
    end
    if labelPoint then
        labelPoint.Text = "当前得分：" .. tostring(snapshot.score)
    end
    self:UpdateTime()
    return true
end

function Hud:UpdateTime()
    if not roundActive or not labelTime then
        return
    end

    local now = World:GetServerTime()
    if now < nextUpdateTime then
        return
    end
    nextUpdateTime = now + 1
    labelTime.Text = "倒计时：" .. math.max(0, math.floor(roundEndTime - now))
end

function Hud:Destroy()
    if heartbeatConnection ~= nil then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
    labelTime = nil
    labelPoint = nil
    roundActive = false
    roundEndTime = 0
    nextUpdateTime = 0
    Players = nil
    World = nil
    RunService = nil
end

return Hud
```

### client/main.lua

```lua
-- @runtime client
local RemoteEvents = require("common.remote_events")
local Hud = require("client.hud")

local Players = game:GetService("Players")
local World = game:GetService("World")
local RunService = game:GetService("RunService")
local Task = game:GetService("Task")
if Players == nil or World == nil or RunService == nil or Task == nil then return end

local connections = {}
local stopped = false

table.insert(connections, RemoteEvents.HudSnapshot.OnClientEvent:Connect(function(snapshot)
    if not Hud:ApplySnapshot(snapshot) then
        print("[SE Lua Guide][WARN] 忽略格式错误的 HudSnapshot")
    end
end))

-- 先订阅，再等待 UI 就绪，最后请求当前快照。
Task:Spawn(function()
    for _ = 1, 20 do
        if stopped then return end
        if Hud:Init({ Players = Players, World = World, RunService = RunService }) then
            RemoteEvents.RequestHudSnapshot:FireServer({
                kind = "ready",
                version = 1,
            })
            return
        end
        Task:Wait(0.25)
    end
    print("[SE Lua Guide][ERROR] HUD 节点在 5 秒内未就绪")
end)

return {
    Destroy = function()
        stopped = true
        for _, connection in ipairs(connections) do
            connection:Disconnect()
        end
        connections = {}
        Hud:Destroy()
    end,
}
```

## 这份代码整合了哪些章节

| 功能 | 来源章节 |
| --- | --- |
| 目录结构、`require` | 第 1 章 |
| 查找球体和方块 | 第 2、5 章 |
| 服务端 Heartbeat 倒计时 | 第 3、6 章 |
| 碰撞事件、防抖、特效、重置 | 第 6、12、16 章 |
| `Players:GetPlayerFromCharacter` | 第 7、13 章 |
| `common/remote_events.lua` | 第 8 章 |
| `PlayerGui.EuiManager` + `FindFirstChild` 查 UI 节点 | 第 9 章 |
| `data` 配置表 | 第 10 章 |
| Manager 生命周期与 `Destroy()` | 第 19 章 |
| 测试、日志、回归 | 第 21 章 |

这份代码还覆盖了三个复杂项目里很容易漏掉的边界。第一，client 必须先订阅 `HudSnapshot`，等 UI 就绪后再发送只读 `ready` 请求；server 校验 schema 和频率，再通过 `SyncPlayer(player)` 返回当前回合与个人分数，中途加入不会依赖一次可能错过的广播。第二，HUD 节点同时检查稳定 Name 和 `EUITextLabel` 类型，并进行有上限的就绪重试；UI 失败只影响表现，不会停止 server 权威回合。第三，Manager 的连接、延时重开和特效延时隐藏都有明确销毁/代次保护，重载不会叠加旧回调。真实项目可以继续把音效、UI 动画等反馈拆到 client Manager，但分数、倒计时、结算和重开仍然留在 server。

## 本章产物

* 一套可复制的完整项目目录：`common`、`data`、`server`、`client`。
* 一个服务端 `RoundManager`：负责回合、碰撞计分、重置、中途加入同步。
* 一个客户端 `Hud`：负责读取 EUI 节点、显示倒计时和分数、容忍节点缺失。
* 一份真实编辑器运行记录：启动、碰撞得分、倒计时结束、重开。
* 一份截图记录：HUD 文本清晰、分数/倒计时可见。
* 一条失败复盘：中途加入、UI 节点缺失、碰撞不计分三选一。

## 验收要点

* 分数、倒计时、是否结束都由 server 维护。
* client 不直接改分，只显示服务端下发的数据。
* 碰撞有防抖，不会一次命中连续加分。
* 预配置 `EffectUnit` 播放后由 `Task:Delay` 主动隐藏，旧定时器不会关闭新一轮播放。
* 中途加入玩家先订阅再请求，只收到一个经过 schema 校验的 HUD 快照 table。
* UI 节点缺失时 client 打印 WARN，server 回合仍能继续运行。
* `Vector3(...)` 使用全局构造器，不加 `math.` 前缀。
* 坐标分量按 Meta 公开契约使用小写 `x/y/z`；不要依赖运行时可能存在的 `X/Y/Z` 兼容别名。
* UI 节点通过稳定 `Name` 用 `EuiManager:GetRootNode():FindFirstChild(name, true)` 获取。

## 项目 B：投篮/钓鱼小游戏

目标：通过输入、物理或 UI 操作触发判定，服务端校验得分，并保存最高分到排行榜。

推荐拆解：

1. client 只发送“我做了操作”的请求，例如蓄力释放、点击按钮、甩杆。
2. server 根据位置、状态、冷却和命中区域判断是否得分。
3. 用 `UpdateAsync` 保存最高分，避免并发覆盖。
4. 用 OrderedDataStore 读取排行榜，client 只展示结果。
5. 将判定、存储、排行榜拆成 Manager，不和 UI 代码混在一起。

验收要点：

* 客户端不能直接告诉服务端“我得了 10 分”。
* DataStore 访问必须 `pcall`，失败时有默认值或重试策略。
* 排行榜数据来自服务端。

## 项目 C：多人 1V1 竞技场

目标：两名玩家分阵营对战，含技能、动画、胜利规则和日志回归。

推荐拆解：

1. server 维护自己的队伍分组、血量和胜利条件；出生点使用编辑器预先配置并能通过公开 `World` API 取得的场景对象。当前公开 `Camps` / `Camp` API 不提供 `AssignCamp` 或 `GetCampSpawnPoint`，不要把历史接口写进新项目。
2. client 发送技能释放请求，server 校验冷却、距离、目标合法性。
3. client 播放本地输入反馈；角色动画是否需要让其他玩家看见，必须按具体宿主类型和目标运行包单独验证，不能假定自动同步。
4. server 只广播关键结果，例如受击、死亡、胜利。
5. 用 testspec 和日志回归验证“开始、命中、死亡、结算、重开”链路。

验收要点：

* 胜负由 server 判定。
* 技能命中不能只相信 client。
* 复杂逻辑拆成 `RoundManager`、`SkillManager`、`ScoreManager` 或 `TeamManager`。

## 最小测试计划

### 启动检查

* 启动 playtest 后，日志出现 `[SE Lua Guide][Round] started`。
* 没有 `球体` / `方块` 时，日志给出明确 WARN，而不是 nil 报错。
* UI 初始显示“等待开始”和“当前得分：0”。

### 核心链路

* 玩家推动球体撞到方块后，只加 1 分。
* 1 秒内重复碰撞不会连续加分。
* 方块随机移动，球体回到起点。
* 60 秒后服务端打印 `[SE Lua Guide][Round] completed`，客户端收到 `phase="waiting"` 的快照并停止倒计时。

### 回归场景

* 玩家中途加入，不应该破坏当前回合。
* UI 节点缺失时只打印 WARN，不阻塞服务端玩法。
* 连续玩两局，碰撞事件不会重复触发两次。

## 常见错误

### 错误：把分数和倒计时放在客户端

客户端自己计分、自己倒计时，会导致作弊和多人不同步。Capstone 项目里所有权威状态都应在 server。

### 错误：把整套玩法堆进 server/main.lua

项目刚开始能跑，但一加排行榜、复活、关卡、音效，就很难维护。`main.lua` 应该只组装 Manager。

### 错误：把 `otherUnit` 当成 Player

碰撞或触发事件拿到的通常是角色 Unit，不是 Player。需要用 `Players:GetPlayerFromCharacter(otherUnit)` 反查。

当前该函数参数必须是 `EggyUnit`。正确顺序是先判断 `otherUnit:IsA("EggyUnit")`，再反查 Player；不能把任意碰撞 Unit 直接传入。

### 错误：把 `Quaternion(...)` 当欧拉角，或给 Vector 加 `math.`

当前教程规范是全局构造器：`Vector3(...)`、`Color(...)`、`Quaternion(...)`。需要欧拉角旋转时用 `Quaternion.FromEulerAngles(...)`。

## 练习任务

1. 按本章目录创建项目 A，并跑通一局。
2. 按第 21 章流程写一份 `evidence/editor-runs/` 运行记录，覆盖启动、碰撞得分、倒计时结束和重开。
3. 给项目 A 增加最高分保存，使用第 11 章的 `UpdateAsync` 模式，并记录一次成功保存或失败 fallback 日志。
4. 把项目 A 的表现反馈拆成 client 本地增强：命中者额外播放 UI 动画或已验证的命中音效，并保存一份截图验收记录。
5. 从项目 B/C 中选一个，先写需求拆解、目录结构、期望日志和测试计划，再写代码。

## 本章验收标准

* [ ] 我能按通用流程推进一个完整项目。
* [ ] 我能实现服务端计分、倒计时和结算。
* [ ] 我知道客户端只请求和显示。
* [ ] 我能用 Manager 模式组织复杂逻辑。
* [ ] 我能写出启动检查、核心链路和回归场景。
* [ ] 我能为 Capstone 留下运行记录、截图记录和至少一条失败复盘。

## 本章 API 对照

* [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)
* [Players](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Players.html)
* [RunService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/RunService.html)
* [Task](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Task.html)
* [RemoteEvent](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RemoteEvent.html)
* [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)
* [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html)
* [EffectUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EffectUnit.html)
* [EUITextLabel](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUITextLabel.html)
* [Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html)

## 下一章预告

这是本系列的最后一章。下一步不是继续读更多 API，而是选一个真实小项目，按本章流程写出需求拆解、目录结构、期望日志和回归清单。遇到具体能力缺口时，再回到对应章节补读：通信看第 8 章，UI 看第 9 章，存储看第 11 章，物理看第 12 章，资产看第 17–19 章，QA 看第 21 章。
