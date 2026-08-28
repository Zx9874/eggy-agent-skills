# StoryService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* `Service`
  + **[StoryService]**（3 函数 / 3 事件）

剧情对话播放服务，负责驱动地图中配置的剧情对话播放流程。提供开始、结束、跳过三个控制接口，可针对任意玩家发起剧情生命周期操作；同时暴露开始、结束、跳过三个事件，供地图逻辑订阅玩家剧情的实时状态变化。

## 适用场景

在地图玩法中，需要按条件触发或中断玩家剧情对话时使用。例如进入关键区域时调用开始剧情，玩家手动跳过或剧情结束时调用结束或跳过接口。

## 使用要点

先通过 game:GetService("StoryService") 获取服务实例，再对指定玩家调用 StartStory 启动剧情；需要提前终止时调用 EndStory，需要跳过当前剧情时调用 SkipStory。若需感知剧情生命周期，可分别订阅 OnStoryStart、OnStoryEnd、OnStorySkip 三个事件。

## 注意事项

StartStory、EndStory、SkipStory 可在服务端为任意玩家调用；客户端调用时只能传入 Players.LocalPlayer。OnStoryStart、OnStoryEnd、OnStorySkip 三个事件仅在服务端触发。storyID 必须对应地图剧情配表中已存在的剧情 ID。

## 代码示例

### 服务端监听剧情开始事件

```lua
-- @runtime server
local storyService = game:GetService('StoryService')
storyService.OnStoryStart:Once(function(player, storyID)
    print('剧情开始:', player, storyID)
end)
```

## 事件 (3)

### OnStoryStart

签名：`OnStoryStart(player: Player, storyID: String)` 触发：`local`

剧情开始事件，当某个玩家的剧情开始播放时在服务端触发。事件会提供触发该事件的玩家对象以及对应的剧情 ID。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 开始播放剧情的玩家。 |
| `storyID` | `String` | 本次开始的剧情 ID，对应地图剧情配表中的剧情条目。 |

> 示例代码

> 服务端监听剧情开始

```lua
-- @runtime server
local storyService = game:GetService('StoryService')
storyService.OnStoryStart:Once(function(player, storyID)
    print('剧情开始:', player, storyID)
end)
```

### OnStoryEnd

签名：`OnStoryEnd(player: Player, storyID: String)` 触发：`local`

剧情结束事件，当某个玩家的剧情播放结束时在服务端触发。事件会提供触发该事件的玩家对象以及对应的剧情 ID。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 结束剧情的玩家。 |
| `storyID` | `String` | 本次结束的剧情 ID。 |

> 示例代码

> 服务端监听剧情结束

```lua
-- @runtime server
local storyService = game:GetService('StoryService')
storyService.OnStoryEnd:Once(function(player, storyID)
    print('剧情结束:', player, storyID)
end)
```

### OnStorySkip

签名：`OnStorySkip(player: Player, storyID: String)` 触发：`local`

剧情跳过事件，当某个玩家的剧情被跳过时在服务端触发。事件会提供触发该事件的玩家对象以及对应的剧情 ID。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 跳过剧情的玩家。 |
| `storyID` | `String` | 本次跳过的剧情 ID。 |

> 示例代码

> 服务端监听剧情跳过

```lua
-- @runtime server
local storyService = game:GetService('StoryService')
storyService.OnStorySkip:Once(function(player, storyID)
    print('剧情跳过:', player, storyID)
end)
```

## 函数 (3)

### StartStory

签名：`StartStory(player: Player, storyID: String) -> void`

开始播放指定玩家的剧情。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 要开始播放剧情的玩家。服务端可指定任意玩家；客户端只能传入本地玩家。 |
| `storyID` | `String` | 要开始播放的剧情 ID，对应地图剧情配表中的剧情条目。 |

**返回值** `void`

> 示例代码

> 客户端为本地玩家开始剧情

```lua
-- @runtime client
local storyService = game:GetService('StoryService')
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local function startConfiguredStory(storyID)
    if storyID == nil or storyID == '' then return end
    storyService:StartStory(localPlayer, storyID)
end
-- 调用方把地图剧情配表中真实存在的 ID 传给 startConfiguredStory
```

### EndStory

签名：`EndStory(player: Player, storyID: String) -> void`

停止指定玩家的剧情播放。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 要停止剧情的玩家。服务端可指定任意玩家；客户端只能传入本地玩家。 |
| `storyID` | `String` | 要停止的剧情 ID。 |

**返回值** `void`

> 示例代码

> 客户端结束本地玩家剧情

```lua
-- @runtime client
local storyService = game:GetService('StoryService')
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local function endConfiguredStory(storyID)
    if storyID == nil or storyID == '' then return end
    storyService:EndStory(localPlayer, storyID)
end
-- 调用方把正在播放的真实剧情 ID 传给 endConfiguredStory
```

### SkipStory

签名：`SkipStory(player: Player, storyID: String) -> void`

跳过指定玩家的剧情。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 要跳过剧情的玩家。服务端可指定任意玩家；客户端只能传入本地玩家。 |
| `storyID` | `String` | 要跳过的剧情 ID。 |

**返回值** `void`

> 示例代码

> 客户端跳过本地玩家剧情

```lua
-- @runtime client
local storyService = game:GetService('StoryService')
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local function skipConfiguredStory(storyID)
    if storyID == nil or storyID == '' then return end
    storyService:SkipStory(localPlayer, storyID)
end
-- 调用方把正在播放的真实剧情 ID 传给 skipConfiguredStory
```
