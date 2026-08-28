# JoinData

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[JoinData](https://u5-creator.s3.game.163.com/manual/se/game_api/data/JoinData.html) 封装了玩家进入当前地图时的传送上下文信息，包括来源地图编号、一同传送的其他玩家列表以及传送时携带的自定义数据。通过 Player:GetJoinData 获取该实例后，可读取这些字段来了解玩家是如何到达当前地图的。

## 适用场景

在需要根据玩家来源地图或传送附带数据执行差异化逻辑时使用，例如在传送完成后读取 TeleportData 来恢复玩家状态，或根据 SourceMapId 判断是否来自特定地图。

## 使用要点

通过 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 实例调用 GetJoinData 方法获取 [JoinData](https://u5-creator.s3.game.163.com/manual/se/game_api/data/JoinData.html) 对象，然后直接访问其 SourceMapId、Members 和 TeleportData 属性。例如 local joinData = player:GetJoinData() 后，使用 joinData.SourceMapId 获取来源地图编号。

## 注意事项

[JoinData](https://u5-creator.s3.game.163.com/manual/se/game_api/data/JoinData.html) 不可直接构造，必须通过 Player:GetJoinData 获取。TeleportData 的类型为 Any，其具体结构由传送发起方在 [TeleportOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportOptions.html) 中设置，读取前应先检查。Members 的 Meta 类型是 Array<String>，其中每一项是同批传送玩家的标识字符串，不是 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 实例；具体标识格式由传送系统提供。

## 代码示例

### 读取玩家的传送加入数据

```lua
-- @runtime server
local Players = game:GetService('Players')
Players.PlayerAdded:Connect(function(player)
    local joinData = player:GetJoinData()
    if joinData == nil then return end
    print('来源地图:', joinData.SourceMapId)
    for _, memberId in ipairs(joinData.Members or {}) do
        print('同批传送玩家标识:', memberId)
    end
    print('传送附带数据:', joinData.TeleportData)
end)
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `SourceMapId` | `String` | `-` | 来源地图编号。 |
| `Members` | `Array<String>` | `-` | 与该玩家一起被传送过来的其他玩家列表。 |
| `TeleportData` | `Any` | `-` | 传送附带数据。 |
