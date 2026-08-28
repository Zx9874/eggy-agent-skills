# TeleportOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[TeleportOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportOptions.html) 用于配置玩家跨服务器传送时的行为参数，可指定是否预留新服务器、目标实例标识以及携带的自定义数据。通过设置 ReservedServerAccessCode、ServerInstanceId 和 ShouldReserveServer 等属性，能够精确控制传送目标与方式，并利用 SetTeleportData 传递可序列化的上下文信息。

## 适用场景

在调用 TeleportService:TeleportAsync 前，创建 [TeleportOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportOptions.html) 实例来设定传送策略，例如将玩家传送到预留的服务器实例并携带当前游戏状态数据。

## 使用要点

通过 TeleportOptions.New() 或 TeleportService:CreateTeleportOptions() 创建实例，然后设置 ReservedServerAccessCode、ShouldReserveServer 等属性，调用 SetTeleportData 附加自定义数据，最后将实例传入 TeleportService:TeleportAsync。

## 注意事项

公开 Meta 声明 TeleportOptions.New()，但 2026-08-11 当前编辑器运行时中，该构造器返回的对象缺少 GetTeleportData/SetTeleportData；可运行代码应通过 TeleportService:CreateTeleportOptions() 创建。ReservedServerAccessCode 属于敏感凭据，不得输出到日志、持久化到公开数据或发送给无权限客户端。ReservedServerAccessCode/ServerInstanceId/ShouldReserveServer 可直接读写；SetTeleportData 参数必须可序列化（基本值、数组或字符串键表），不得包含 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)、函数、[Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html) 或循环引用。

## 代码示例

### 创建传送选项并附加非敏感业务数据

```lua
-- @runtime server
local TeleportService = game:GetService('TeleportService')
local options = TeleportService:CreateTeleportOptions()
options.ShouldReserveServer = true
options:SetTeleportData({ source = 'lobby' })
print('是否预留新服务器:', options.ShouldReserveServer)
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `ReservedServerAccessCode` | `String` | `""` | 预留服务器战场实例的访问码，通过 TeleportService:ReserveServerAsync 或 TeleportService:ApplyIngameMatchAsync 获取。 |
| `ServerInstanceId` | `String` | `""` | 目标服务器战场实例的 ID，用于传送到指定运行中的实例（如好友所在的服务器）。 |
| `ShouldReserveServer` | `Bool` | `true` | 是否在传送时创建一个新的服务器战场实例。 |

## 函数 (3)

### New

签名：`New() -> TeleportOptions`

创建一个新的 [TeleportOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportOptions.html) 实例，用于配置传送参数。

**返回值** [TeleportOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportOptions.html)

> 示例代码

> 通过 TeleportService 创建传送选项

```lua
-- @runtime server
local options = game:GetService("TeleportService"):CreateTeleportOptions()
options.ShouldReserveServer = true
options:SetTeleportData({ source = 'lobby' })
print('是否预留新服务器:', options.ShouldReserveServer)
```

### GetTeleportData

签名：`GetTeleportData() -> Any (传送附带数据, 未设置时返回 nil)`

获取当前 [TeleportOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportOptions.html) 实例中已设置的传送附带数据。

**返回值** `Any` (传送附带数据, 未设置时返回 nil)

> 示例代码

> 读取传送附带数据

```lua
-- @runtime server
local options = game:GetService("TeleportService"):CreateTeleportOptions()
options:SetTeleportData({ source = 'lobby' })
local data = options:GetTeleportData()
print('来源:', data and data.source)
```

### SetTeleportData

签名：`SetTeleportData(teleportData: Any) -> void`

设置传送时附带的任意数据，可在目标服务器通过 Player:GetJoinData() 获取。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `teleportData` | `Any` | 可序列化的基础值、数组或字符串键表；不得包含 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)、函数、[Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html)、循环引用等运行时对象。 |

**返回值** `void`

> 示例代码

> 设置可序列化的传送附带数据

```lua
-- @runtime server
local options = game:GetService("TeleportService"):CreateTeleportOptions()
options:SetTeleportData({ source = 'lobby', playerLevel = 5 })
local data = options:GetTeleportData()
print('来源:', data and data.source)
```
