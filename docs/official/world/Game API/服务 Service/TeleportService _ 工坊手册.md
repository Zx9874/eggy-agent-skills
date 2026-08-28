# TeleportService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `server` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[TeleportService]**（5 函数 / 1 事件）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[TeleportService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TeleportService.html) 负责处理玩家的跨地图传送流程，提供普通传送、预约服务器、匹配内传送与更换服务器等能力。它同时暴露了传送初始化失败事件，便于在传送未能启动时获取错误信息与相关上下文。

## 适用场景

当服务端需要将玩家转移到另一张地图、提前预约独立服务器、在比赛中将玩家匹配到指定服务器，或把玩家迁往匹配系统分配的服务器时，都可以通过该服务完成。

## 使用要点

先通过 game:GetService("TeleportService") 获取服务实例。传送时调用 TeleportAsync 并传入目标地图 ID 与玩家列表；需要独立服务器时可先调用 ReserveServerAsync 获取结果，再配合传送；匹配内传送使用 ApplyIngameMatchAsync，换服则调用 ChangeServerAsync。所有异步调用都应在协程中执行并使用 pcall 保护，传送选项可通过 CreateTeleportOptions 创建。

## 注意事项

[TeleportService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TeleportService.html) 仅服务端可用。TeleportAsync/ReserveServerAsync/ApplyIngameMatchAsync/ChangeServerAsync 都是异步方法，必须在协程（Task:Spawn 或 coroutine.wrap）中调用，失败时抛 error 需 pcall 保护。mapId 是调用方从项目配置传入的真实原始地图/关卡 ID，不是资源 URI；示例必须把 mapId 作为函数参数接收，不得在代码块内定义字符串常量充当 mapId；禁止写成 official://、map://、custom://、eggyasset:// 或 net://，也不要虚构占位 ID。公开 Meta 声明 TeleportOptions.New()，但当前运行时对象缺少数据方法；可运行代码应通过 CreateTeleportOptions() 创建传送选项。ReservedServerAccessCode 属于敏感凭据，不得输出到日志或客户端可见数据。

## 代码示例

### 在协程中传送当前在线玩家

```lua
-- @runtime server
local TeleportService = game:GetService('TeleportService')
local Players = game:GetService('Players')
local Task = game:GetService('Task')
local function teleportOnlinePlayers(mapId)
    if mapId == nil or mapId == '' then return end
    local players = Players:GetPlayers()
    if #players == 0 then return end
    Task:Spawn(function()
        local ok, result = pcall(function()
            return TeleportService:TeleportAsync(mapId, players, TeleportService:CreateTeleportOptions())
        end)
        if not ok then print('传送失败:', result) end
    end)
end
-- 调用方把项目配置中的真实地图 ID 传给 teleportOnlinePlayers
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (1)

### TeleportInitFailed

签名：`TeleportInitFailed(player: Player, teleportResult: TeleportErrcode, errorMessage: String, mapId: String, teleportOptions: Table)` 触发：`local`

传送初始化失败事件，由服务端触发。当传送初始化过程失败时，该事件会被触发，向监听者提供发起传送的玩家、失败对应的错误码、错误信息、目标地图 ID 以及本次传送使用的选项数据。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 传送的玩家 |
| `teleportResult` | [TeleportErrcode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TeleportErrcode.html) | 传送结果错误码 |
| `errorMessage` | `String` | 错误描述 |
| `mapId` | `String` | 目标地图编号 |
| `teleportOptions` | `Table` | 传送选项 (含 ShouldReserveServer/ServerInstanceId 等字段) |

> 示例代码

> 监听下一次传送初始化失败

```lua
-- @runtime server
local TeleportService = game:GetService('TeleportService')
TeleportService.TeleportInitFailed:Once(function(player, teleportResult, errorMessage, mapId, teleportOptions)
    print('传送失败玩家:', player:GetName())
    print('错误码:', tostring(teleportResult), '错误信息:', errorMessage)
    print('目标地图 ID:', mapId)
end)
```

## 函数 (5)

### TeleportAsync

签名：`TeleportAsync(mapId: String, players: Array, teleportOptions?: TeleportOptions) -> TeleportAsyncResult | nil (传送结果 (仅传入 teleportOptions 时返回; 未传时返回 nil))`

将指定玩家列表从当前地图迁移到目标地图。不传 teleportOptions 时采用 fire-and-forget 方式且不返回结果；传入 teleportOptions 时返回 [TeleportAsyncResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportAsyncResult.html)。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `mapId` | `String` | 目标地图编号（支持传入关卡ID） |
| `players` | `Array` | 待传送的玩家列表 |
| `teleportOptions?` | [TeleportOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportOptions.html) | 传送选项, 可通过 TeleportService:CreateTeleportOptions() 创建 (可选) |

**返回值** [TeleportAsyncResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportAsyncResult.html) | nil (传送结果 (仅传入 teleportOptions 时返回; 未传时返回 nil))

> 示例代码

> 协程中传送玩家到目标地图

```lua
-- @runtime server
local TeleportService = game:GetService('TeleportService')
local Task = game:GetService('Task')
local Players = game:GetService('Players')
local function teleportToMap(mapId)
  if mapId == nil or mapId == '' then return end
Task:Spawn(function()
    local options = TeleportService:CreateTeleportOptions()
    local players = Players:GetPlayers()
    if #players == 0 then
        print('当前没有玩家在线，无法传送')
        return
    end
    local ok, result = pcall(function()
        return TeleportService:TeleportAsync(mapId, players, options)
    end)
    if not ok then print('传送失败:', result) end
end)
end
-- 调用方把项目配置中的真实地图 ID 传给 teleportToMap
```

### ReserveServerAsync

签名：`ReserveServerAsync(mapId: String) -> ReserveServerResult | nil (保留服务器结果 (编辑器环境返回 nil))`

获取指定地图的预留服务器战场实例访问码，返回 [ReserveServerResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ReserveServerResult.html) 对象。获取到的访问码可继续用于后续将玩家送入该预留实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `mapId` | `String` | 目标地图编号（支持传入关卡ID） |

**返回值** [ReserveServerResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ReserveServerResult.html) | nil (保留服务器结果 (编辑器环境返回 nil))

> 示例代码

> 协程中预留服务器并安全传递访问码

```lua
-- @runtime server
local TeleportService = game:GetService('TeleportService')
local Task = game:GetService('Task')
local function reserveMapServer(mapId)
  if mapId == nil or mapId == '' then return end
Task:Spawn(function()
    local ok, result = pcall(function()
        return TeleportService:ReserveServerAsync(mapId)
    end)
    if not ok then
        print('预留服务器失败:', result)
    elseif result ~= nil then
        local options = TeleportService:CreateTeleportOptions()
        options.ReservedServerAccessCode = result.ReservedServerAccessCode
        print('预留服务器传送选项已配置')  -- 不输出访问码
    end
end)
end
-- 调用方把项目配置中的真实地图 ID 传给 reserveMapServer
```

### ApplyIngameMatchAsync

签名：`ApplyIngameMatchAsync(mapId: String, players: Array) -> String | nil (匹配结果中的 accessCode (编辑器环境返回 nil))`

发起局内匹配请求，匹配完成后返回可用于传送的 ReservedServerAccessCode。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `mapId` | `String` | 目标地图编号（支持传入关卡ID） |
| `players` | `Array` | 参与匹配的玩家列表（至少 1 个） |

**返回值** `String | nil` (匹配结果中的 accessCode (编辑器环境返回 nil))

> 示例代码

> 协程中发起局内匹配

```lua
-- @runtime server
local TeleportService = game:GetService('TeleportService')
local Players = game:GetService('Players')
local Task = game:GetService('Task')
local function startMatch(mapId)
  if mapId == nil or mapId == '' then return end
Task:Spawn(function()
    local players = Players:GetPlayers()
    if #players == 0 then
        print('当前没有玩家在线，无法发起匹配')
        return
    end
    local ok, result = pcall(function()
        return TeleportService:ApplyIngameMatchAsync(mapId, { players[1] })
    end)
    if ok and result ~= nil and result ~= '' then
        local options = TeleportService:CreateTeleportOptions()
        options.ReservedServerAccessCode = result
        print('匹配传送选项已配置')  -- 不输出访问码
    elseif not ok then
        print('局内匹配失败:', result)
    else
        print("敏感凭据未写入日志")
    end
end)
end
-- 调用方把项目配置中的真实地图 ID 传给 startMatch
```

### ChangeServerAsync

签名：`ChangeServerAsync(player: Player) -> Bool (迁移结果 (编辑器环境返回 false))`

将单个玩家迁移到由匹配系统分配的另一服务器战斗实例。迁移成功时返回 true，失败时返回 false；在编辑器环境下调用会返回 false。组队中的玩家无法被迁移。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 要迁移的玩家 |

**返回值** `Bool` (迁移结果 (编辑器环境返回 false))

> 示例代码

> 协程中迁移单个玩家

```lua
-- @runtime server
local TeleportService = game:GetService('TeleportService')
local Players = game:GetService('Players')
local Task = game:GetService('Task')
Task:Spawn(function()
    local player = Players:GetPlayers()[1]
    if player == nil then return end
    local ok, result = pcall(function()
        return TeleportService:ChangeServerAsync(player)
    end)
    print(ok and '迁移请求完成' or '迁移失败:', result)
end)
```

### CreateTeleportOptions

签名：`CreateTeleportOptions() -> TeleportOptions (传送选项对象)`

创建一个新的传送选项实例。

**返回值** [TeleportOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportOptions.html) (传送选项对象)

> 示例代码

> 创建传送选项并附加公开数据

```lua
-- @runtime server
local TeleportService = game:GetService('TeleportService')
local options = TeleportService:CreateTeleportOptions()
options:SetTeleportData({ from = 'lobby' })
print('传送附带数据:', options:GetTeleportData())
```
