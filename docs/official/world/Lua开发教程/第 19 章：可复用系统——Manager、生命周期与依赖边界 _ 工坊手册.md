# 第 19 章：可复用系统——Manager、生命周期与依赖边界

用 Init、Start、Destroy 和依赖注入组织可重载的客户端与服务端 Manager。

## 你会学到什么

* 如何用项目内 Manager 复用稳定的玩法逻辑。
* `main.lua` 如何保持简洁，只负责组装系统。
* server / client / common 三层 Manager 的职责边界。
* 如何设计 `Init`、`Start`、`Reset`、`Destroy` 生命周期。
* 如何避免循环依赖、顶层副作用和状态泄漏。

## 项目内可复用系统

本章讲“项目内可复用系统”：把 `main.lua` 里越来越长的逻辑拆成几个清楚的 Manager，让同一项目中的玩法模块更容易维护和组合。

从编辑器经验看，很多作者会先把触发器、计分、倒计时、UI 更新都串在一条可视化逻辑链里。Lua 项目变大后，Manager 的作用就是把这条长链拆成几个可命名、可测试、可替换的系统：分数归 ScoreManager，回合归 RoundManager，界面归 UIManager。

| 情况 | 推荐做法 |
| --- | --- |
| 只在当前地图使用 | 项目内 Manager |
| 多个地图使用相似玩法 | 先沉淀职责清晰的 Manager 和普通模块 |

先把当前项目的职责拆清楚，再提炼稳定的模块边界。

## main.lua 应该做什么

`main.lua` 是入口，不是垃圾桶。它最理想的职责是：

1. require 模块。
2. 调用 `Init()` 注入依赖。
3. 调用 `Start()` 启动系统。
4. 在必要时调用 `Reset()` / `Destroy()`。

示例：

```lua
local World = game:GetService("World")
local ScoreManager = require("server.score_manager")
local RoundManager = require("server.round_manager")
if not World then return end

local scoreReady = ScoreManager:Init({
    World = World,
})
local roundReady = RoundManager:Init({
    World = World,
    ScoreManager = ScoreManager,
})

if not scoreReady or not roundReady or not RoundManager:Start() then
    print("[SE Lua Guide][WARN] 服务端系统初始化失败。")
    return
end

game:BindToClose(function()
    RoundManager:Destroy()
    ScoreManager:Destroy()
end)

print("[SE Lua Guide] 服务端系统已启动")
```

复杂逻辑应该放到 Manager 内部，而不是继续堆进 `main.lua`。

## 三层职责

| 层 | 放什么 | 不放什么 |
| --- | --- | --- |
| `server/` | 权威状态、分数、回合、奖励、DataStore、传送、商品 | 本地 UI 细节、输入监听 |
| `client/` | UI、输入、相机、本地音效、表现反馈 | 得分、扣血、奖励发放 |
| `common/` | 常量、资源 URI、RemoteEvent 定义、纯函数工具 | 访问 `LocalPlayer`、写 DataStore、创建 UI |

`common` 的最好状态是“没有副作用”：被 server 和 client require 时都安全。

## 从长 main.lua 演进到 Manager

Manager 不是为了显得高级，而是为了解决 `main.lua` 变长以后没人敢改的问题。建议按三步演进：

| 阶段 | 代码状态 | 下一步 |
| --- | --- | --- |
| 能跑 | 所有逻辑先在 `server/main.lua` 跑通 | 保留期望日志，确认链路正确 |
| 能分层 | 把分数、回合、UI、输入按职责切成函数 | 观察哪些函数共享同一组状态 |
| 能复用 | 把同一组状态和函数搬进 Manager | 给 Manager 补 `Init` / `Start` / `Reset` / `Destroy` |

不要在玩法还没跑通时就先设计一套复杂框架。好的 Manager 应该从真实代码中长出来：先有一个清楚的玩法链路，再把稳定的职责边界命名出来。

## Manager 生命周期

推荐每个 Manager 提供一组稳定入口：

| 方法 | 什么时候调用 | 做什么 |
| --- | --- | --- |
| `Init(deps)` | 启动早期 | 保存依赖、初始化表、获取 RemoteEvent |
| `Start()` | 所有 Manager Init 后 | 绑定事件、启动 Timer、开始玩法 |
| `Reset()` | 新一局开始 | 清空本局状态 |
| `Destroy()` | 地图结束或模块卸载 | 断开事件、停止 Timer、释放引用 |

不是每个 Manager 都需要四个方法，但大型系统最好保持一致，便于排查生命周期问题。

## 示例：server ScoreManager

运行端：server  
 文件：`server/score_manager.lua`

```lua
local ScoreManager = {}

local scores = {}
local lastAddTime = {}

local ADD_COOLDOWN = 0.5

function ScoreManager:Init(deps)
    self:Destroy()
    if not deps or not deps.World then
        return false
    end

    self.World = deps.World
    scores = {}
    lastAddTime = {}
    self.initialized = true
    return true
end

function ScoreManager:AddPoint(player)
    if not self.initialized or not player or not player:IsA("Player") then
        return 0
    end

    local now = self.World:GetServerTime()
    local last = lastAddTime[player.UserId]

    if last and now - last < ADD_COOLDOWN then
        return self:GetScore(player)
    end

    lastAddTime[player.UserId] = now
    scores[player.UserId] = self:GetScore(player) + 1

    return scores[player.UserId]
end

function ScoreManager:GetScore(player)
    if not player or not player:IsA("Player") then
        return 0
    end
    return scores[player.UserId] or 0
end

function ScoreManager:Destroy()
    scores = {}
    lastAddTime = {}
    self.World = nil
    self.initialized = false
end

function ScoreManager:Reset()
    scores = {}
    lastAddTime = {}
end

return ScoreManager
```

这里有几个故意保守的设计：

* 分数只在 server 维护。
* 防抖也在 server 做。
* ScoreManager 不负责推送 UI；HUD 快照由协议层读取分数后统一组装。
* 模块顶层只定义表和函数，不绑定事件、不读玩家、不创建对象。

## 示例：server RoundManager

运行端：server  
 文件：`server/round_manager.lua`

```lua
local RoundManager = {}

local ROUND_DURATION = 60

function RoundManager:Init(deps)
    self:Destroy()
    if not deps or not deps.World or not deps.ScoreManager then
        return false
    end

    self.World = deps.World
    self.ScoreManager = deps.ScoreManager
    self.running = false
    self.roundEndTime = 0
    self.initialized = true
    return true
end

function RoundManager:Start()
    if not self.initialized or self.running then
        return false
    end

    self.running = true
    self.roundEndTime = self.World:GetServerTime() + ROUND_DURATION
    print("[SE Lua Guide] 回合开始")
    return true
end

function RoundManager:IsRunning()
    return self.running
end

function RoundManager:GetRemainingTime()
    if not self.running then
        return 0
    end

    local remaining = self.roundEndTime - self.World:GetServerTime()
    return math.max(0, math.floor(remaining))
end

function RoundManager:Destroy()
    self.running = false
    self.roundEndTime = 0
    self.World = nil
    self.ScoreManager = nil
    self.initialized = false
end

function RoundManager:Finish()
    if not self.running then
        return
    end

    self.running = false
    print("[SE Lua Guide] 回合结束")
end

function RoundManager:Reset()
    self.running = false
    self.roundEndTime = 0
    if self.ScoreManager then
        self.ScoreManager:Reset()
    end
end

return RoundManager
```

`RoundManager` 不直接操作 UI，也不保存玩家输入；它只负责“回合是否进行中”和“还剩多久”。这就是职责边界。

## client Manager 怎么写

客户端 Manager 通常负责输入和表现。例如 `UIManager` 可以统一接收服务端事件，然后更新 HUD：

```lua
local UIManager = {}

function UIManager:Init(deps)
    self:Destroy()
    if not deps or not deps.HudSnapshot then
        return false
    end

    self.hudSnapshotRE = deps.HudSnapshot
    self.connections = {}
    self.initialized = true
    return true
end

function UIManager:Start()
    if not self.initialized or self.started then
        return false
    end
    self.started = true

    local connection = self.hudSnapshotRE.OnClientEvent:Connect(function(snapshot)
        if type(snapshot) ~= "table"
            or type(snapshot.score) ~= "number"
            or type(snapshot.phase) ~= "string"
            or type(snapshot.endTime) ~= "number"
            or type(snapshot.serverTime) ~= "number" then
            print("[SE Lua Guide][WARN] 忽略非法 HUD 快照。")
            return
        end

        print("[SE Lua Guide] 更新 HUD:", snapshot.score, snapshot.phase)
        -- 实际 UI 更新见第 9 章。
    end)
    table.insert(self.connections, connection)
    return true
end

function UIManager:Destroy()
    for _, connection in ipairs(self.connections or {}) do
        connection:Disconnect()
    end
    self.connections = {}
    self.hudSnapshotRE = nil
    self.initialized = false
    self.started = false
end

return UIManager
```

客户端入口负责注入第 8 章定义的统一事件，而不是让 UIManager 自己重新创建或猜事件名。

运行端：client 文件：`client/main.lua`

```lua
local RemoteEvents = require("common.remote_events")
local UIManager = require("client.ui_manager")

local ready = UIManager:Init({
    HudSnapshot = RemoteEvents.HudSnapshot,
})

if not ready or not UIManager:Start() then
    print("[SE Lua Guide][WARN] UIManager 启动失败。")
    return
end
```

这样 UIManager 只消费快照，协议定义仍由 `common/remote_events.lua` 单一维护。脚本重载或 UI 模块退出时调用 `UIManager:Destroy()`；再次 Init 也会先清理上一轮连接。

客户端 Manager 可以播放本地音效、更新 EUI、做相机反馈，但不要直接改分数、发奖励或写 DataStore。

## 依赖注入，而不是互相 require

当 Manager 之间需要协作时，优先在 `main.lua` 里组装依赖：

例如 server 入口先取得 World，依次调用 `ScoreManager:Init({ World = World })`，再调用 `RoundManager:Init({ World = World, ScoreManager = ScoreManager })`。client 入口同样把 `RemoteEvents.HudSnapshot` 注入 UIManager。

这样比在 `round_manager.lua` 内部直接 `require("server.score_manager")` 更容易看清依赖关系，也更不容易出现循环 require。

推荐方向：

```text
main.lua
  ├── require ScoreManager
  ├── require RoundManager
  └── 把 ScoreManager 注入 RoundManager
```

避免方向：

```text
ScoreManager require RoundManager
RoundManager require ScoreManager
```

## 事件连接要能清理

如果 Manager 会绑定很多事件，建议保存连接并在 `Destroy()` 中断开：

```lua
local SomeManager = {}

function SomeManager:Init()
    self:Destroy()
    self.connections = {}
    return true
end

function SomeManager:Track(connection)
    if not connection then
        return nil
    end
    table.insert(self.connections, connection)
    return connection
end

function SomeManager:Destroy()
    for _, connection in ipairs(self.connections or {}) do
        connection:Disconnect()
    end
    self.connections = {}
end

return SomeManager
```

第一版小游戏不一定需要完整 `Destroy()`，但一旦出现重复进入、重新开局、热重载、临时 UI，多数“触发两次”的问题都和连接没有清理有关。

## 推荐项目结构

```text
common/
  config.lua             -- 常量、资源 URI、玩法配置
  remote_events.lua      -- RemoteEvent 统一定义
server/
  main.lua               -- 入口，只组装 Manager
  score_manager.lua      -- 分数
  round_manager.lua      -- 回合
  reward_manager.lua     -- 奖励
client/
  main.lua               -- 入口，只组装 Manager
  ui_manager.lua         -- HUD 与 EUI
  input_manager.lua      -- 输入
  feedback_manager.lua   -- 音效、特效、相机反馈
data/
  items.lua              -- 静态配置
  UINodes.lua            -- 可选：导出数据后生成的 UI 节点参考表，脚本仍按稳定 Name 查找
```

文件名建议使用小写下划线，模块名在代码中使用清晰的 PascalCase 表示表对象，例如 `score_manager.lua` 返回 `ScoreManager`。

## 常见错误

### 错误：模块顶层做副作用

不要在 require 时就绑定事件、创建 UI、读取玩家。把这些动作放到 `Init()` 或 `Start()`。

### 错误：client Manager 改权威状态

client 可以提交“尝试完成某动作”的意图，但不能上报一个应被直接采信的分数。server Manager 根据自己的权威玩法事实判断是否增加分数。

### 错误：Manager 互相 require

互相 require 会让初始化顺序变得不可控。用 `main.lua` 注入依赖更清楚。

### 错误：Reset 只清一半

新一局开始时，分数、防抖表、倒计时、连接、临时对象都要检查。只清分数不清防抖，会出现“新一局刚开始不能得分”的问题。

## 练习任务

1. 把第 8/22 章的计分逻辑抽成 `server/score_manager.lua`。
2. 设计 `server/round_manager.lua`，提供 `Start()`、`GetRemainingTime()`、`Finish()`。
3. 写一个 `client/ui_manager.lua`，只负责接收第 8 章的 `HudSnapshot` table 并更新 HUD。
4. 画出你的 Manager 依赖图，确认没有循环依赖。

## 本章验收标准

* [ ] 我能说明不同 Manager 的职责边界。
* [ ] 我知道 `main.lua` 应只做入口组装。
* [ ] 我能按 server/client/common 拆分职责。
* [ ] 我能设计 `Init`、`Start`、`Reset`、`Destroy` 生命周期。
* [ ] 我知道如何避免循环 require 和顶层副作用。

## 本章产物

* 一份 `server/score_manager.lua` / `server/round_manager.lua` / `client/ui_manager.lua` 的拆分草图或代码。
* 一张 Manager 依赖图，标出哪些依赖由 `main.lua` 注入。
* 一份生命周期检查表，确认每个 Manager 的 `Init` / `Start` / `Reset` / `Destroy` 是否有明确职责。

这章是 Capstone 前最重要的工程化台阶：第 22 章的回合、计分和 HUD 都应按本章方式拆分，而不是继续堆在单个 `main.lua`。

## 本章 API 对照

* [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)
* [RemoteEvent](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RemoteEvent.html)
* [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)
* [Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html)
* [Task](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Task.html)
* [TimerService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TimerService.html)

## 下一章预告

项目内系统拆清楚以后，下一章将介绍按需接入的平台服务：聊天、跨服消息、传送、社交、商业化和埋点。
