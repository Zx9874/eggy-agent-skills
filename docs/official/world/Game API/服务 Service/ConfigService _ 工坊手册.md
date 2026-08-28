# ConfigService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `server` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[ConfigService]**（4 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

服务端配置服务，用于读取地图配置快照、按玩家读取配置，并在试玩模式下设置或清理临时测试值。

## 适用场景

适合服务端加载活动、数值或玩家分层配置，并在后台配置版本更新时刷新已有快照。

## 使用要点

仅在服务端通过 game:GetService("ConfigService") 获取服务；调用 GetConfigAsync 或 GetConfigForPlayerAsync 后在回调中处理 [ConfigSnapshot](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ConfigSnapshot.html)，并根据 UpdateAvailable 或 Outdated 决定是否 Refresh。

## 注意事项

[ConfigService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/ConfigService.html) 仅在服务端可用。GetConfigAsync 与 GetConfigForPlayerAsync 返回 [ConfigSnapshot](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ConfigSnapshot.html)；快照不会在后台版本更新后静默替换数据，应监听 UpdateAvailable 或检查 Outdated，并按需调用 Refresh。SetTestingValue 与 ClearTestingValue 只在试玩模式生效，不会修改已发布配置。

## 代码示例

### 拉取配置快照并验证测试覆盖

```lua
-- @runtime server
local Task = game:GetService("Task")
local ConfigService = game:GetService("ConfigService")
local Players = game:GetService("Players")

Task:Spawn(function()
    -- 1. 异步拉取最新已发布配置快照，失败时 pcall 兜底
    local ok, snapshot = pcall(function()
        return ConfigService:GetConfigAsync()
    end)
    if not ok or not snapshot then
        print("拉取全局配置失败")
        return
    end
    print("当前 int_value =", tostring(snapshot:GetValue("int_value")))

    -- 2. 对在线玩家获取分桶后的实验配置
    local player = Players:GetPlayers()[1]
    if player then
        local ok2, playerSnap = pcall(function()
            return ConfigService:GetConfigForPlayerAsync(player)
        end)
        if ok2 and playerSnap then
            print("玩家", player:GetName(), "的 bool_value =", tostring(playerSnap:GetValue("bool_value")))
        end
    end

    -- 3. 试玩模式下覆盖测试值并立即读回，验证覆盖生效
    ConfigService:SetTestingValue("int_value", 42)
    print("测试覆盖后 int_value =", tostring(snapshot:GetValue("int_value")))

    -- 4. 清除覆盖，恢复已发布值
    ConfigService:ClearTestingValue("int_value")
    print("清除覆盖后 int_value =", tostring(snapshot:GetValue("int_value")))
end)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (4)

### GetConfigAsync

签名：`GetConfigAsync() -> ConfigSnapshot (配置快照)`

异步获取最新已发布的配置快照。该函数不需要任何参数，调用后返回一个 [ConfigSnapshot](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ConfigSnapshot.html) 对象，其中包含当前已发布配置的数据内容。

**返回值** [ConfigSnapshot](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ConfigSnapshot.html) (配置快照)

> 示例代码

> 获取基础配置快照并为玩家获取分桶配置

```lua
-- @runtime server
local ConfigService = game:GetService("ConfigService")
local Players = game:GetService("Players")
local Task = game:GetService("Task")

-- 在 Task:Spawn 中调用异步获取，避免阻塞主流程
Task:Spawn(function()
    local baseSnapshot = ConfigService:GetConfigAsync()
    if baseSnapshot ~= nil then
        print("基础配置快照获取成功:", baseSnapshot)
    else
        print("基础配置快照获取失败")
    end
end)

-- 玩家加入时，获取该玩家视角的配置快照（叠加分桶覆盖）
Players.PlayerAdded:Once(function(player)
    Task:Spawn(function()
        local playerSnapshot = ConfigService:GetConfigForPlayerAsync(player)
        if playerSnapshot ~= nil then
            print("玩家配置快照获取成功:", playerSnapshot)
        else
            print("玩家配置快照获取失败")
        end
    end)
end)
```

### GetConfigForPlayerAsync

签名：`GetConfigForPlayerAsync(player: Player) -> ConfigSnapshot (配置快照（携带玩家分桶信息）)`

异步获取面向特定玩家的配置快照。需要传入一个 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 对象作为参数，返回的 [ConfigSnapshot](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ConfigSnapshot.html) 中携带该玩家的分桶信息，可用于按玩家维度下发差异化配置。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |

**返回值** [ConfigSnapshot](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ConfigSnapshot.html) (配置快照（携带玩家分桶信息）)

> 示例代码

> 在玩家加入时为玩家获取配置快照

```lua
-- @runtime server
local ConfigService = game:GetService("ConfigService")
local Players = game:GetService("Players")
local Task = game:GetService("Task")

-- 玩家加入时触发，player 由事件回调提供
Players.PlayerAdded:Once(function(player)
    Task:Spawn(function()
        local playerSnapshot = ConfigService:GetConfigForPlayerAsync(player)
        if playerSnapshot ~= nil then
            print("玩家配置快照获取成功:", playerSnapshot)
        else
            print("玩家配置快照获取失败")
        end
    end)
end)

-- 同时获取基础配置快照作为对照（无玩家分桶覆盖）
Task:Spawn(function()
    local baseSnapshot = ConfigService:GetConfigAsync()
    if baseSnapshot ~= nil then
        print("基础配置快照获取成功:", baseSnapshot)
    end
end)
```

### SetTestingValue

签名：`SetTestingValue(key: String, value: Any) -> void`

在试玩模式下临时覆盖指定 key 的配置值，用于本地测试不同配置效果。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 配置键名 |
| `value` | `Any` | 覆盖值 |

**返回值** `void`

> 示例代码

> 设置测试覆盖值

```lua
-- @runtime server
-- 获取 ConfigService 服务实例
local configService = game:GetService("ConfigService")

-- 在试玩模式下临时覆盖一个 key 的值
configService:SetTestingValue("my_key", "test_value")

-- 获取配置快照，验证覆盖是否生效
local snapshot = configService:GetConfigAsync()
local value = snapshot:GetValue("my_key")
print("设置测试值后，my_key 的值为:", value)

-- 清除测试覆盖，恢复原始值
configService:ClearTestingValue("my_key")
```

### ClearTestingValue

签名：`ClearTestingValue(key: String) -> void`

清除指定 key 在试玩模式下临时覆盖的值，恢复为已发布配置的原始值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 配置键名 |

**返回值** `void`

> 示例代码

> 清除测试覆盖值

```lua
-- @runtime server
-- 获取 ConfigService 服务实例
local configService = game:GetService("ConfigService")

-- 先设置一个测试值，模拟试玩模式下的临时覆盖
configService:SetTestingValue("my_key", "test_value")

-- 清除该 key 的测试覆盖，恢复为原始配置值
configService:ClearTestingValue("my_key")

-- 验证清除后，通过快照读取该 key 的值（应为原始配置值）
local snapshot = configService:GetConfigAsync()
local value = snapshot:GetValue("my_key")
print("清除测试值后，my_key 的值为:", value)
```
