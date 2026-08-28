# ReserveServerResult

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[ReserveServerResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ReserveServerResult.html) 承载预留服务器操作的结果数据，用于向服务端返回可进入目标服务器的访问码。通过读取 ReservedServerAccessCode 属性，可将成功预留的访问码应用到后续传送流程的选项配置中，是完成预占服务器到实际传送之间衔接的桥梁。

## 适用场景

当需要先调用预留接口为玩家占好独立服务器实例、再稍后统一发起传送时，将从返回结果中取得的访问码填入传送选项，即可让玩家随后进入该预留服务器。

## 使用要点

该结果不可直接构造，需在服务端通过 TeleportService:ReserveServerAsync 获取返回实例；随后读取 ReservedServerAccessCode 属性，将其写入 TeleportService:CreateTeleportOptions 创建的选项对象的 ReservedServerAccessCode 字段，再通过 TeleportService:TeleportAsync 完成实际传送。

## 注意事项

该类型不可直接构造，只能通过 TeleportService:ReserveServerAsync 获取。ReservedServerAccessCode 是可进入预留服务器的敏感凭据，不要打印、持久化到公开数据或发送给无权限客户端；应直接写入 [TeleportOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportOptions.html) 后用于服务端传送流程。

## 代码示例

### 预留服务器后安全配置传送选项

```lua
-- @runtime server
local TeleportService = game:GetService('TeleportService')
local Task = game:GetService('Task')

local function configureReservedServer(mapId)
    if mapId == nil or mapId == '' then return end
    Task:Spawn(function()
        local ok, result = pcall(function()
            return TeleportService:ReserveServerAsync(mapId)
        end)
        if ok and result ~= nil then
            local options = TeleportService:CreateTeleportOptions()
            options.ReservedServerAccessCode = result.ReservedServerAccessCode
            print('预留服务器传送选项已配置')  -- 不输出访问码
        end
    end)
end
-- 调用方把项目配置中的真实地图 ID 传给 configureReservedServer
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `ReservedServerAccessCode` | `String` | `""` | 预留服务器战场实例的访问码，用于后续将玩家传送到该已预留的服务器实例。该属性为字符串类型，可在实际传送时填入 [TeleportOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportOptions.html) 的 ReservedServerAccessCode 字段。 |
