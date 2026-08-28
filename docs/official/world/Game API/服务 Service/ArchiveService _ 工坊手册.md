# ArchiveService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `server` |

存档与成就服务，负责服务端的玩家自定义存档读写以及成就系统的进度管理。它支持按 ID 或名称存取自定义存档，也支持查询成就的目标、自动获得标志、单次性等配置，并能读取或累加成就进度、判断成就是否完成。服务还提供成就完成与奖励获得两个事件，供服务端逻辑响应对应的时刻。

## 适用场景

在服务端脚本中管理玩家的自定义进度和成就，例如保存关卡解锁状态、按配置推进成就计数，并在成就达成或发放奖励时触发后续逻辑。

## 使用要点

先通过 game:GetService("ArchiveService") 获取服务实例。按名称或 ID 使用 SetCustomArchive / SetCustomArchiveByName 写入存档，用 GetCustomArchive / GetCustomArchiveByName 读取。对成就进度可调用 AddAchievementProgress 累加、SetAchievementProgress 覆盖，再用 IsAchievementCompleted 判断是否完成。同时可在服务端监听 AchievementComplete 和 AchievementRewardGain 事件处理达成与发奖逻辑。

## 注意事项

[ArchiveService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/ArchiveService.html) 是服务端存档与成就服务，需在服务端脚本中获取并调用。eventId 必须是已配置的成就 ID，运行时会校验，调用时建议用 pcall 保护。AchievementComplete 和 AchievementRewardGain 的事件标记为 local，表示当前服务实例上的本地信号作用域，不表示客户端事件；监听示例应放在服务端。

## 代码示例

### 监听成就完成事件并查询完成状态

```lua
-- @runtime server
-- 获取存档服务，用于监听成就完成事件
local archiveService = game:GetService("ArchiveService")

-- 监听成就完成事件，回调中打印玩家与成就ID，并查询该成就当前是否已完成
archiveService.AchievementComplete:Once(function(player, eventId)
    local playerName = player:GetName()
    local completed = archiveService:IsAchievementCompleted(player, eventId)
    print(string.format("玩家 %s 完成了成就 %d（已完成=%s）", playerName, eventId, tostring(completed)))
end)
```

## 事件 (2)

### AchievementComplete

签名：`AchievementComplete(player: Player, eventId: Int)` 触发：`local`

当玩家某项成就完成时触发的事件。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `eventId` | `Int` | 成就id |

> 示例代码

> 监听成就完成事件

```lua
-- @runtime server
local archiveService = game:GetService("ArchiveService")
archiveService.AchievementComplete:Once(function(player, eventId)
    print("成就完成事件触发", eventId)
end)
```

### AchievementRewardGain

签名：`AchievementRewardGain(player: Player, eventId: Int)` 触发：`local`

当玩家领取某项成就奖励时触发的事件。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `eventId` | `Int` | 成就id |

> 示例代码

> 监听成就奖励领取事件

```lua
-- @runtime server
local archiveService = game:GetService("ArchiveService")
archiveService.AchievementRewardGain:Once(function(player, eventId)
    print("成就奖励领取事件触发", eventId)
end)
```

## 函数 (14)

### GetCustomArchiveIdByName

签名：`GetCustomArchiveIdByName(name: String) -> Int (自定义存档id)`

通过名称获取自定义存档的 ID。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 自定义存档名称 |

**返回值** `Int` (自定义存档id)

> 示例代码

> 通过名称获取自定义存档ID

```lua
-- @runtime server
-- 获取 ArchiveService 服务实例
local archiveService = game:GetService("ArchiveService")

local archiveName = "自定义进度1"  -- 存档名称

-- 通过名称获取自定义存档ID
local archiveId = archiveService:GetCustomArchiveIdByName(archiveName)
if archiveId then
    print("存档名称 '" .. archiveName .. "' 对应的ID: " .. tostring(archiveId))
else
    print("未找到名称为 '" .. archiveName .. "' 的存档")
end
```

### GetCustomArchiveIdByAchievementId

签名：`GetCustomArchiveIdByAchievementId(eventId: Int) -> Int (自定义存档id)`

通过成就 ID 获取关联的自定义存档 ID。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventId` | `Int` | 成就id |

**返回值** `Int` (自定义存档id)

> 示例代码

> 通过成就ID获取关联的自定义存档ID

```lua
-- @runtime server
-- 获取 ArchiveService 服务实例
local archiveService = game:GetService("ArchiveService")

local eventId = 1001  -- 成就ID

-- 通过成就ID获取关联的自定义存档ID
local archiveId = archiveService:GetCustomArchiveIdByAchievementId(eventId)
if archiveId then
    print("成就 " .. tostring(eventId) .. " 关联的自定义存档ID: " .. tostring(archiveId))
else
    print("成就 " .. tostring(eventId) .. " 没有关联的自定义存档")
end
```

### GetAchievementTargetCount

签名：`GetAchievementTargetCount(eventId: Int) -> Int (目标次数)`

获取指定成就的目标完成次数。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventId` | `Int` | 成就id |

**返回值** `Int` (目标次数)

> 示例代码

> 获取成就目标次数

```lua
-- @runtime server
-- 获取 ArchiveService 服务实例
local archiveService = game:GetService("ArchiveService")

local eventId = 1001  -- 成就ID

-- 获取该成就的目标次数
local targetCount = archiveService:GetAchievementTargetCount(eventId)
print("成就 " .. tostring(eventId) .. " 的目标次数: " .. tostring(targetCount))
```

### GetAchievementAutoGain

签名：`GetAchievementAutoGain(eventId: Int) -> Bool (自动领取)`

查询指定成就的奖励是否设置为自动领取。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventId` | `Int` | 成就id |

**返回值** `Bool` (自动领取)

> 示例代码

> 查询成就奖励是否自动领取

```lua
-- @runtime server
-- 获取 ArchiveService 服务实例
local archiveService = game:GetService("ArchiveService")

local eventId = 1001  -- 成就ID

-- 查询该成就的奖励是否自动领取
local autoGain = archiveService:GetAchievementAutoGain(eventId)
if autoGain then
    print("成就 " .. tostring(eventId) .. " 的奖励将自动领取")
else
    print("成就 " .. tostring(eventId) .. " 的奖励需要手动领取")
end
```

### GetAchievementIsSingle

签名：`GetAchievementIsSingle(eventId: Int) -> Bool (单局成就)`

查询指定成就是否为单局成就。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventId` | `Int` | 成就id |

**返回值** `Bool` (单局成就)

> 示例代码

> 查询成就是否为单局成就

```lua
-- @runtime server
-- 获取 ArchiveService 服务实例
local archiveService = game:GetService("ArchiveService")

local eventId = 1001  -- 成就ID

-- 查询该成就是否为单局成就
local isSingle = archiveService:GetAchievementIsSingle(eventId)
if isSingle then
    print("成就 " .. tostring(eventId) .. " 是单局成就")
else
    print("成就 " .. tostring(eventId) .. " 不是单局成就")
end
```

### GetAchievementRewards

签名：`GetAchievementRewards(eventId: Int) -> Map (奖励数据)`

获取指定成就的奖励数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventId` | `Int` | 成就id |

**返回值** `Map` (奖励数据)

> 示例代码

> 获取成就奖励数据

```lua
-- @runtime server
-- 获取 ArchiveService 服务实例
local archiveService = game:GetService("ArchiveService")

local eventId = 1001  -- 成就ID

-- 获取该成就的奖励数据
local rewards = archiveService:GetAchievementRewards(eventId)
if rewards then
    print("成就 " .. tostring(eventId) .. " 的奖励数据已获取")
    -- 奖励数据是一个 Map，可根据实际结构进一步处理
else
    print("未找到成就 " .. tostring(eventId) .. " 的奖励数据")
end
```

### GetCustomArchive

签名：`GetCustomArchive(player: Player, key: Int) -> Any (存档内容)`

获取指定玩家指定 key 对应的自定义存档内容。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `key` | `Int` | 存档id |

**返回值** `Any` (存档内容)

> 示例代码

> 按键读取自定义存档

```lua
-- @runtime server
local archiveService = game:GetService("ArchiveService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]
if player then
    -- 1001 为地图存档规则里配置的自定义存档 ID
    local archiveValue = archiveService:GetCustomArchive(player, 1001)
    print(tostring(archiveValue))
else
    print("当前无在线玩家，待玩家加入后执行存档读取")
end
```

### SetCustomArchive

签名：`SetCustomArchive(player: Player, key: Int, value: Any) -> void`

设置指定玩家指定 key 对应的自定义存档内容。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `key` | `Int` | 存档id |
| `value` | `Any` | 存档内容 |

**返回值** `void`

> 示例代码

> 按键写入并回读自定义存档

```lua
-- @runtime server
local archiveService = game:GetService("ArchiveService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]
if player then
    -- 键值必须与地图存档规则中的配置对应
    archiveService:SetCustomArchive(player, 1001, 50)
    local savedValue = archiveService:GetCustomArchive(player, 1001)
    print(tostring(savedValue))
else
    print("当前无在线玩家，待玩家加入后执行存档写入")
end
```

### GetCustomArchiveByName

签名：`GetCustomArchiveByName(player: Player, name: String) -> Any (存档内容)`

根据名称获取指定玩家的自定义存档内容。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `name` | `String` | 存档名称 |

**返回值** `Any` (存档内容)

> 示例代码

> 按名称读取自定义存档

```lua
-- @runtime server
local archiveService = game:GetService("ArchiveService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]
if player then
    -- 存档名称需与地图存档规则中配置的名称一致
    local archiveValue = archiveService:GetCustomArchiveByName(player, "自定义进度1")
    print(tostring(archiveValue))
else
    print("当前无在线玩家，待玩家加入后执行存档读取")
end
```

### SetCustomArchiveByName

签名：`SetCustomArchiveByName(player: Player, name: String, value: Any) -> void`

通过名称设置指定玩家的自定义存档内容。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `name` | `String` | 存档名称 |
| `value` | `Any` | 存档内容 |

**返回值** `void`

> 示例代码

> 按名称写入并回读自定义存档

```lua
-- @runtime server
local archiveService = game:GetService("ArchiveService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]
if player then
    archiveService:SetCustomArchiveByName(player, "自定义进度1", "已通关")
    local savedValue = archiveService:GetCustomArchiveByName(player, "自定义进度1")
    print(tostring(savedValue))
else
    print("当前无在线玩家，待玩家加入后执行存档写入")
end
```

### GetAchievementProgress

签名：`GetAchievementProgress(player: Player, eventId: Int) -> Int (进度)`

获取指定玩家指定成就的当前进度值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `eventId` | `Int` | 成就id |

**返回值** `Int` (进度)

> 示例代码

> 封装成就进度查询

```lua
-- @runtime server
local archiveService = game:GetService("ArchiveService")
local function getProgress(player, configuredEventId)
    local ok, progress = pcall(function()
        return archiveService:GetAchievementProgress(player, configuredEventId)
    end)
    return ok and progress or nil
end
-- 在业务流程中传入真实 Player 和已配置的成就 ID：getProgress(player, configuredEventId)
```

### SetAchievementProgress

签名：`SetAchievementProgress(player: Player, eventId: Int, count: Int) -> void`

设置指定玩家指定成就的进度值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `eventId` | `Int` | 成就id |
| `count` | `Int` | 成就进度 |

**返回值** `void`

> 示例代码

> 封装成就进度设置

```lua
-- @runtime server
local archiveService = game:GetService("ArchiveService")
local function setProgress(player, configuredEventId, count)
    local ok, err = pcall(function()
        archiveService:SetAchievementProgress(player, configuredEventId, count)
    end)
    return ok, err
end
-- 在业务流程中传入真实 Player、已配置的成就 ID 和进度值。
```

### AddAchievementProgress

签名：`AddAchievementProgress(player: Player, eventId: Int, addCount: Int) -> void`

为指定玩家的指定成就增加进度值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `eventId` | `Int` | 成就id |
| `addCount` | `Int` | 增加的成就进度 |

**返回值** `void`

> 示例代码

> 封装成就进度累加

```lua
-- @runtime server
local archiveService = game:GetService("ArchiveService")
local function addProgress(player, configuredEventId, addCount)
    local ok, err = pcall(function()
        archiveService:AddAchievementProgress(player, configuredEventId, addCount)
    end)
    return ok, err
end
-- 在业务流程中传入真实 Player、已配置的成就 ID 和增量。
```

### IsAchievementCompleted

签名：`IsAchievementCompleted(player: Player, eventId: Int) -> Bool (是否完成)`

判断指定玩家的指定成就是否已完成。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `eventId` | `Int` | 成就id |

**返回值** `Bool` (是否完成)

> 示例代码

> 封装成就完成状态查询

```lua
-- @runtime server
local archiveService = game:GetService("ArchiveService")
local function isCompleted(player, configuredEventId)
    local ok, completed = pcall(function()
        return archiveService:IsAchievementCompleted(player, configuredEventId)
    end)
    return ok and completed or false
end
-- 在业务流程中传入真实 Player 和已配置的成就 ID。
```
