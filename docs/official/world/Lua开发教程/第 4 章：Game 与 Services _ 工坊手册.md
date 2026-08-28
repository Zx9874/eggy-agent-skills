# 第 4 章：Game 与 Services

通过 game:GetService 获取公开服务，并按运行端和返回值安全使用。

## 你会学到什么

* `game` 为什么是运行时入口。
* 如何用 `game:GetService("服务名")` 获取服务。
* Realm（可用端）和推荐运行端为什么不是一回事。
* 如何查服务 API，避免凭名字猜方法。
* 如何把 Service 获取写成可维护的入口代码。

## game 是全局入口

`game` 是引擎默认注入的全局对象，不需要创建，也不需要 `require`。获取服务统一使用：

```lua
local World = game:GetService("World")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
```

Service 是全局单例和功能接口，不能 `.New()`，也不能 `CreateUnit("World")`。`CreateUnit` 用来创建 Unit，不用来创建 Service。

## Realm 与推荐运行端

公开 API 页面会标出每个 Service 的 Realm（可用端）：

* `common`：client 和 server 都能获取这个 Service。
* `server`：只能在 server 使用。
* `client`：只能在 client 使用。

但 Realm 只说明“这个类型在哪端可用”，不等于“业务上应该在哪端调用”。例如 `SocialService` 的类型 Realm 是 common，但 `GetPartyAsync` 的公开说明明确标注仅服务端使用；`CameraService` 是 common，但屏幕坐标转换通常服务于客户端画面。遇到这种情况，要继续阅读具体成员的说明，不能只看类型级 Realm。

## 常用服务速查

| 服务 | Realm | 新手推荐用法 |
| --- | --- | --- |
| `World` | common | server 创建/销毁场景 Unit；双端可读服务器时间 |
| `Players` | common | server 管理玩家和反查角色；client 读取 `LocalPlayer` |
| `RunService` | common | 双端判断环境、监听 Heartbeat |
| `Task` | common | 双端启动协程、延迟、等待 |
| `TimerService` | common | 需要固定次数计时器时使用 |
| `UserInputService` | client | client 读取键盘、鼠标、触屏输入 |
| `CameraService` | common | client 做屏幕坐标转换和取射线 |
| `PhysicsService` | common | server 权威物理查询更常见；Raycast 要传方向向量 |
| `SoundService` | common | client 播本地反馈，server 播所有人都应感知的世界声音 |
| `DataStoreService` | server | server-only，所有 Async 调用都要 `pcall` |
| `AnalyticsService` | server | server 记录玩家行为和经济/进度事件 |
| `MessageService` | server | 跨服消息按 Meta 契约用 `PublishAsync` / `SubscribeAsync` |
| `TeleportService` | server | 传送调用放 server，Async 接口进协程并 `pcall` |
| `TextChatService` | common | 管理文本频道和发送消息；具体调用端按成员说明和业务权威边界决定 |
| `SocialService` | common | 当前公开成员用于队伍查询；`GetPartyAsync` 按说明放在 server |
| `CommodityService` | common | 查询商品/权益或打开商品界面；消耗和奖励结果由 server 校验 |

这张表不是完整 API，只是学习路线图。具体函数、属性、事件和 Realm 以当前公开 API 页面为准；页面没有公开的成员，一律当作当前不可用。

## 最小示例：获取服务并判断运行端

运行端：server

```lua
local World = game:GetService("World")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

if not World or not Players or not RunService then
    print("[SE Lua Guide] ERROR: 必需服务获取失败")
    return
end

print("[SE Lua Guide] World:", World)
print("[SE Lua Guide] Players:", Players)
print("[SE Lua Guide] IsServer:", RunService:IsServer())
print("[SE Lua Guide] ServerTime:", World:GetServerTime())
```

运行端：client

```lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local World = game:GetService("World")

if not Players or not RunService or not World then
    print("[SE Lua Guide] ERROR: 必需服务获取失败")
    return
end

print("[SE Lua Guide] IsClient:", RunService:IsClient())
print("[SE Lua Guide] LocalPlayer:", Players.LocalPlayer)
print("[SE Lua Guide] SyncedTime:", World:GetServerTime())
```

## 遍历玩家：server 和 client 的差别

server 侧能看到所有玩家，适合维护在线列表、管理你自己的队伍数据、读取编辑器预配置的阵营成员，以及广播回合状态。当前公开 `Camps` / `Camp` 能查询阵营和监听成员变化，但不能主动分配阵营；完整边界和兼容写法见[第 7 章](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/chapters/07-players-input-character.html)：

```lua
local Players = game:GetService("Players")

if not Players then
    print("[SE Lua Guide] ERROR: Players 服务获取失败")
    return
end

local allPlayers = Players:GetPlayers()
print("[SE Lua Guide] 当前在线人数:", #allPlayers)

for _, player in ipairs(allPlayers) do
    print("[SE Lua Guide] 玩家:", player:GetName())
end

Players.PlayerAdded:Connect(function(player)
    print("[SE Lua Guide] 玩家加入:", player:GetName())
end)

Players.PlayerRemoving:Connect(function(player)
    print("[SE Lua Guide] 玩家离开:", player:GetName())
end)
```

client 侧通常只关心本地玩家：

```lua
local Players = game:GetService("Players")

if not Players then
    print("[SE Lua Guide] ERROR: Players 服务获取失败")
    return
end

local localPlayer = Players.LocalPlayer
if localPlayer then
    print("[SE Lua Guide] 本地玩家:", localPlayer:GetName())
end
```

## API 查阅顺序

写 Service 代码时，不要只看方法名猜。推荐顺序：

1. 先打开本站当前版本的公开 API 页面，确认类型、成员名、参数、返回值和 Realm。
2. 再用编辑器的 API 搜索或补全交叉确认，并在正确运行端做最小验证。
3. 官方 Demo 和本教程只用于学习组织方式；旧代码与当前 API 页面冲突时，不要照抄。
4. 如果一个能力没有出现在当前公开 API 中，就把它视为尚未开放，不用内部名字或历史写法绕过限制。

典型例子：旧清单里可能写 `MessageService.Publish` / `Subscribe`，但当前公开 API 只提供 `PublishAsync` / `SubscribeAsync`。这时必须使用当前名称，并按异步失败可能性做好保护。

## 常见错误

### 错误：Realm 是 common，就在两端随便做权威逻辑

`World`、`Players`、`PhysicsService` 都可能是 common，但计分、奖励、存储、胜负判定仍应放 server。client 可以请求和显示，不能成为权威。

### 错误：在 client 调 DataStoreService

`DataStoreService` 是 server-only。排行榜、背包、金币、最高分都必须通过 server 读写，然后用 RemoteEvent 同步给 client 显示。

### 错误：凭服务名猜 API

不要把 `MessageService` 写成 `Publish`，也不要把 `TeleportService` 当成同步接口。带 `Async` 的方法应放进允许等待的任务中，并用 `pcall` 捕获失败。

### 错误：每个模块都到处 GetService

小示例可以直接写；项目变大后，Manager 可以在 `main.lua` 里注入依赖，或者在模块顶部集中获取。不要在每个函数里重复获取同一个 Service。

## 练习任务

1. 在 server 打印 `World`、`Players`、`RunService`，并输出当前在线人数。
2. 在 client 打印 `Players.LocalPlayer` 和 `RunService:IsClient()`。
3. 查公开 API 页面，确认 `DataStoreService`、`UserInputService`、`MessageService` 的 Realm。
4. 找出一个“Realm 是 common，但推荐在 server 做权威逻辑”的服务，并解释原因。

## 本章验收标准

* [ ] 我知道 `game:GetService("服务名")` 的用法。
* [ ] 我知道 Realm 只表示可用端，不等于业务推荐端。
* [ ] 我能区分 `Players:GetPlayers()` 和 `Players.LocalPlayer` 的典型使用场景。
* [ ] 我知道 Service 方法要查当前公开 API，不凭名字猜。
* [ ] 我知道 Async 服务调用需要协程和 `pcall`。

## 本章产物

本章产物是服务获取和端归属判断。第 22 章服务端会拿 `World`、`Players`、`RunService`、`Task`，客户端会拿 `Players`、`World`、`RunService`，每个 Service 都有明确运行端。

## 本章 API 对照

* [Game](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Game.html)
* [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)
* [Players](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Players.html)
* [RunService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/RunService.html)
* [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)

## 下一章预告

你掌握了服务获取和端归属。下一章我们将深入 Unit：编辑器里的对象在 Lua 中如何查找、创建、挂载和销毁。
