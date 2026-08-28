# Camp

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

阵营是用于组织玩家分组的数据类型，代表游戏中的一个阵营实例。通过它可以在服务端获取当前属于该阵营的全部玩家，并监听玩家加入或离开阵营的动态变化，适合实现按阵营划分的团队玩法、人数统计或阵营归属判断。

## 适用场景

适用于需要按阵营管理玩家的场景，例如队伍对抗玩法中统计各阵营人数、判断玩家归属，或在玩家加入、离开阵营时触发相应的逻辑。

## 使用要点

通过 ipairs(Camps:GetCamps()) 遍历当前全部阵营；拿到 [Camp](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Camp.html) 后用 generic for 遍历 camp:GetPlayers() 返回的迭代函数，并可监听 PlayerAdded/PlayerRemoved。

## 注意事项

[Camp](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Camp.html) 来自 Camps:GetCamps() 返回的 [Camp](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Camp.html) 数组，不直接构造；该数组应使用 ipairs 遍历。Camp:GetPlayers() 返回迭代函数，应使用 generic for 遍历。[Camp](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Camp.html) 当前公开成员只有 GetPlayers、PlayerAdded 和 PlayerRemoved；不要调用未进入 Meta 的 Camps:GetCamp 或 Camp:GetCampId，也不要访问未声明的 camp.Id、camp.CampId 或 camp.Players。

## 代码示例

### 通过 Camps 服务读取阵营玩家

```lua
-- @runtime client
local Camps = game:GetService("Camps")

for _, camp in ipairs(Camps:GetCamps()) do
    for _, player in camp:GetPlayers() do
        print("阵营玩家:", player.Name)
    end
    break
end
```

## 事件 (2)

### PlayerAdded

签名：`PlayerAdded(player: Player)` 触发：`local`

当有玩家加入该阵营时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |

> 示例代码

> 监听玩家加入阵营

```lua
-- @runtime client
local Camps = game:GetService("Camps")
for _, camp in ipairs(Camps:GetCamps()) do
    camp.PlayerAdded:Connect(function(player)
        print("玩家加入阵营:", player.Name)
    end)
    break
end
```

### PlayerRemoved

签名：`PlayerRemoved(player: Player)` 触发：`local`

当有玩家离开该阵营时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |

> 示例代码

> 监听玩家离开阵营

```lua
-- @runtime client
local Camps = game:GetService("Camps")
for _, camp in ipairs(Camps:GetCamps()) do
    camp.PlayerRemoved:Connect(function(player)
        print("玩家离开阵营:", player.Name)
    end)
    break
end
```

## 函数 (1)

### GetPlayers

签名：`GetPlayers() -> Array&lt;Player&gt; (阵营玩家列表)`

获取当前阵营的玩家列表。

**返回值** Array<[Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)> (阵营玩家列表)

> 示例代码

> 读取 Camp 的玩家列表

```lua
-- @runtime client
local Camps = game:GetService("Camps")
for _, camp in ipairs(Camps:GetCamps()) do
    local playerCount = 0
    for _ in camp:GetPlayers() do playerCount = playerCount + 1 end
    print("阵营玩家数:", playerCount)
    break
end
```
