# TeleportAsyncResult

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

传送异步结果是在调用传送服务后返回的数据载体，用于封装预留服务器战场实例的访问码等信息。它由传送流程自动生成，本身不可被开发者主动构造，仅作为只读结果供上层逻辑读取关键字段。

## 适用场景

适用于需要将玩家传送到指定服务器，并希望在传送发起后获取预留服务器访问码的场景，例如发起跨服对战或活动房间传送时读取该访问码用于后续分发。

## 使用要点

通过 TeleportService:TeleportAsync 获取结果；业务只判断结果是否存在或把访问码直接用于受控的服务端后续传送流程，不打印、不展示、不写入公开存储。

## 注意事项

[TeleportAsyncResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportAsyncResult.html) 由 TeleportService:TeleportAsync 返回，不可直接构造。ReservedServerAccessCode 若存在，应按敏感凭据处理，不要写入日志或客户端可见数据。

## 代码示例

### 传送后只记录非敏感结果状态

```lua
-- @runtime server
local TeleportService = game:GetService('TeleportService')
local Players = game:GetService('Players')
local Task = game:GetService('Task')

local function teleportAndCheckResult(mapId)
    if mapId == nil or mapId == '' then return end
    Task:Spawn(function()
        local players = Players:GetPlayers()
        if #players == 0 then
            print('当前没有玩家在线，无法传送')
            return
        end
        local options = TeleportService:CreateTeleportOptions()
        options.ShouldReserveServer = true
        local ok, result = pcall(function()
            return TeleportService:TeleportAsync(mapId, players, options)
        end)
        if ok and result ~= nil then
            local hasReservedServer = result.ReservedServerAccessCode ~= nil and result.ReservedServerAccessCode ~= ''
            print('传送请求完成，是否使用预留服务器:', hasReservedServer)
        end
    end)
end
-- 调用方把项目配置中的真实地图 ID 传给 teleportAndCheckResult
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `ReservedServerAccessCode` | `String` | `""` | 预留服务器战场实例访问码。该只读结果由 TeleportService:TeleportAsync 返回；若存在，应仅在受控的服务端传送流程中读取和传递，不要重新赋值、打印或暴露给客户端。 |
