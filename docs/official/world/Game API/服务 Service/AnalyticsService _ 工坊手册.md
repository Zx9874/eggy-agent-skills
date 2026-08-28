# AnalyticsService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `server` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[AnalyticsService]**（10 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[AnalyticsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/AnalyticsService.html) 负责收集并上报游戏运行过程中的各类数据埋点，涵盖自定义事件、经济流水、引导漏斗、进度推进与玩家分群查询等能力。开发者可在服务端通过统一入口记录玩家行为，为数据分析和运营决策提供依据。

## 适用场景

在需要统计玩家行为或验证功能效果的服务端逻辑中，比如玩家完成新手步骤、购买商品或推进关卡时，调用对应的事件上报函数将数据写入分析系统。

## 使用要点

先通过 game:GetService("AnalyticsService") 获取服务单例；随后根据事件类型调用 LogCustomEvent、LogProgressionEvent 等方法，并传入当前空间内的玩家对象和符合规范的 customData 表。进度类事件可配合 LogProgressionStartEvent、LogProgressionCompleteEvent、LogProgressionFailEvent 标记完整流程。

## 注意事项

[AnalyticsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/AnalyticsService.html) 的非 progression 自定义数据 customData 只允许 CustomField01、CustomField02、CustomField03 三个 key；progression 系列事件的 customData 可使用业务自定义 key。所有埋点调用都应在服务端传入当前 Space 内的 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)。

## 代码示例

### 上报关卡进度并异步查询玩家分段

```lua
-- @runtime server
local analyticsService = game:GetService("AnalyticsService")
local players = game:GetService("Players")
local taskService = game:GetService("Task")
local player = players:GetPlayers()[1]
if player == nil then return end

analyticsService:LogProgressionStartEvent(player, "MainCampaign", 3, "第三章：迷雾森林", nil)
analyticsService:LogProgressionCompleteEvent(player, "MainCampaign", 3, "第三章：迷雾森林", nil)
taskService:Spawn(function()
    local segments = analyticsService:GetPlayerSegmentsAsync(player)
    if segments == nil then return end
    print("玩家付费状态:", segments.ActivePayerStatus)
    print("首次游玩时段:", segments.WhenUserFirstPlayed)
end)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (10)

### LogCustomEvent

签名：`LogCustomEvent(player: Player, eventName: String, value: Float, customData: Table) -> void`

记录玩家的自定义事件，包含事件名称、事件数值以及附加的自定义数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象（事件归属，必须在当前 Space 内） |
| `eventName` | `String` | 事件名称（非空，≤50 字符，仅允许 [a-zA-Z0-9\_]） |
| `value` | `Float` | 事件值，用于 sum/avg 聚合（number，缺省 1） |
| `customData` | `Table` | 自定义数据（key 仅限 CustomField01/02/03；value 支持 str/int/float/bool，str≤256 且不含逗号、引号、换行符） |

**返回值** `void`

> 示例代码

> 记录带规范自定义字段的事件

```lua
-- @runtime server
local analyticsService = game:GetService("AnalyticsService")
local players = game:GetService("Players")
local allPlayers = players:GetPlayers()
local player = allPlayers[1]

if player ~= nil then
    analyticsService:LogCustomEvent(player, "LevelUp", 10, {
        CustomField01 = "hard",
        CustomField02 = "chapter_1",
    })
end
```

### LogEconomyEvent

签名：`LogEconomyEvent(player: Player, flowType: String, currencyType: String, amount: Float, endingBalance: Float, transactionType: String, itemSku: String, customData: Table) -> void`

记录玩家的经济事件，包含货币流向、货币类型、变动数量、变动后余额、交易类型、物品标识以及附加数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象（事件归属，必须在当前 Space 内） |
| `flowType` | `String` | 流向类型（仅 Source / Sink） |
| `currencyType` | `String` | 货币类型（非空，≤50 字符，仅允许 [a-zA-Z0-9\_]） |
| `amount` | `Float` | 变化数量（必须 >0） |
| `endingBalance` | `Float` | 结束余额（必须 >=0） |
| `transactionType` | `String` | 交易类型（非空，≤50 字符，仅 [a-zA-Z0-9\_]；推荐使用 IAP/Shop/Gameplay/ContextualPurchase/TimedReward/Onboarding） |
| `itemSku` | `String` | 物品SKU（可选，≤50 字符） |
| `customData` | `Table` | 自定义数据（key 仅限 CustomField01/02/03；value 支持 str/int/float/bool，str≤256 且不含逗号、引号、换行符） |

**返回值** `void`

> 示例代码

> 记录内购货币收入

```lua
-- @runtime server
local analyticsService = game:GetService('AnalyticsService')
local Players = game:GetService('Players')
local player = Players:GetPlayers()[1]
if player == nil then return end

analyticsService:LogEconomyEvent(
    player,
    'Source',
    'Coins',
    1000,
    5000,
    'IAP',
    '1000CoinBundle',
    { CustomField01 = 'shop' }
)
```

### LogOnboardingFunnelStepEvent

签名：`LogOnboardingFunnelStepEvent(player: Player, step: Int, stepName: String, customData: Table) -> void`

记录玩家在新手引导漏斗中的步骤事件，包含步骤序号、步骤名称以及附加数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象（事件归属，必须在当前 Space 内） |
| `step` | `Int` | 步骤编号（整数 1-100） |
| `stepName` | `String` | 步骤名称（可选，≤50 字符） |
| `customData` | `Table` | 自定义数据（key 仅限 CustomField01/02/03；value 支持 str/int/float/bool，str≤256 且不含逗号、引号、换行符） |

**返回值** `void`

> 示例代码

> 记录新手引导第一步

```lua
-- @runtime server
local analyticsService = game:GetService("AnalyticsService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]
if not player then return end
local customData = {
    CustomField01 = "引导步骤",
}
analyticsService:LogOnboardingFunnelStepEvent(player, 1, "点击开始", customData)
print("已上报新手引导漏斗：第1步 点击开始")
```

### LogFunnelStepEvent

签名：`LogFunnelStepEvent(player: Player, funnelName: String, funnelSessionId: String, step: Int, stepName: String, customData: Table) -> void`

记录玩家在指定漏斗中的步骤事件，包含漏斗名称、会话标识、步骤序号、步骤名称以及附加数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象（事件归属，必须在当前 Space 内） |
| `funnelName` | `String` | 漏斗名称（非空，≤50 字符，仅允许 [a-zA-Z0-9\_]） |
| `funnelSessionId` | `String` | 漏斗会话ID（可选，≤50 字符） |
| `step` | `Int` | 步骤编号（整数 1-100） |
| `stepName` | `String` | 步骤名称（可选，≤50 字符） |
| `customData` | `Table` | 自定义数据（key 仅限 CustomField01/02/03；value 支持 str/int/float/bool，str≤256 且不含逗号、引号、换行符） |

**返回值** `void`

> 示例代码

> 记录注册漏斗第一步

```lua
-- @runtime server
local analyticsService = game:GetService("AnalyticsService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]
if not player then return end
local customData = {
    CustomField01 = "新手引导漏斗",
}
analyticsService:LogFunnelStepEvent(player, "注册转化", "funnel_20240101_001", 1, "进入游戏", customData)
print("已上报漏斗步骤：注册转化 第1步")
```

### LogProgressionEvent

签名：`LogProgressionEvent(player: Player, progressionPathName: String, status: String, level: Any, levelName: String, customData: Table) -> void`

记录玩家的通用进度事件，包含进度路径、状态、关卡、关卡名称以及附加数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象（事件归属，必须在当前 Space 内） |
| `progressionPathName` | `String` | 进度路径名称（非空，≤50 字符，仅允许 [a-zA-Z0-9\_]） |
| `status` | `String` | 状态（仅 Start / Complete / Fail） |
| `level` | `Any` | 关卡（number 或 string；string ≤50 字符） |
| `levelName` | `String` | 关卡名称（可选，≤50 字符） |
| `customData` | `Table` | 自定义数据（progression 事件允许任意 key；value 支持 str/int/float/bool，str≤256 且不含 , " \r \n） |

**返回值** `void`

> 示例代码

> 记录进度开始状态

```lua
-- @runtime server
local analyticsService = game:GetService("AnalyticsService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]
if not player then return end
local customData = {
    CustomField01 = "通用进度",
}
analyticsService:LogProgressionEvent(player, "主线关卡", "Start", 1, "第一章 第一关", customData)
print("已上报进度事件：主线关卡 Start 第1关")
```

### LogProgressionStartEvent

签名：`LogProgressionStartEvent(player: Player, progressionPathName: String, level: Any, levelName: String, customData: Table) -> void`

记录玩家的进度开始事件，包含进度路径、关卡、关卡名称以及附加数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象（事件归属，必须在当前 Space 内） |
| `progressionPathName` | `String` | 进度路径名称（非空，≤50 字符，仅允许 [a-zA-Z0-9\_]） |
| `level` | `Any` | 关卡（number 或 string；string ≤50 字符） |
| `levelName` | `String` | 关卡名称（可选，≤50 字符） |
| `customData` | `Table` | 自定义数据（progression 事件允许任意 key；value 支持 str/int/float/bool，str≤256 且不含 , " \r \n） |

**返回值** `void`

> 示例代码

> 记录主线关卡开始

```lua
-- @runtime server
local analyticsService = game:GetService("AnalyticsService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]
if not player then return end
local customData = {
    CustomField01 = "主线关卡",
}
analyticsService:LogProgressionStartEvent(player, "主线关卡", 1, "第一章 第一关", customData)
print("已上报进度开始：主线关卡 第1关")
```

### LogProgressionCompleteEvent

签名：`LogProgressionCompleteEvent(player: Player, progressionPathName: String, level: Any, levelName: String, customData: Table) -> void`

记录玩家的进度完成事件，包含进度路径、关卡、关卡名称以及附加数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象（事件归属，必须在当前 Space 内） |
| `progressionPathName` | `String` | 进度路径名称（非空，≤50 字符，仅允许 [a-zA-Z0-9\_]） |
| `level` | `Any` | 关卡（number 或 string；string ≤50 字符） |
| `levelName` | `String` | 关卡名称（可选，≤50 字符） |
| `customData` | `Table` | 自定义数据（progression 事件允许任意 key；value 支持 str/int/float/bool，str≤256 且不含 , " \r \n） |

**返回值** `void`

> 示例代码

> 记录主线关卡完成

```lua
-- @runtime server
local analyticsService = game:GetService("AnalyticsService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]
if not player then return end
local customData = {
    CustomField01 = "通关",
}
analyticsService:LogProgressionCompleteEvent(player, "主线关卡", 1, "第一章 第一关", customData)
print("已上报进度完成：主线关卡 第1关")
```

### LogProgressionFailEvent

签名：`LogProgressionFailEvent(player: Player, progressionPathName: String, level: Any, levelName: String, customData: Table) -> void`

记录玩家的进度失败事件，包含进度路径、关卡、关卡名称以及附加数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象（事件归属，必须在当前 Space 内） |
| `progressionPathName` | `String` | 进度路径名称（非空，≤50 字符，仅允许 [a-zA-Z0-9\_]） |
| `level` | `Any` | 关卡（number 或 string；string ≤50 字符） |
| `levelName` | `String` | 关卡名称（可选，≤50 字符） |
| `customData` | `Table` | 自定义数据（progression 事件允许任意 key；value 支持 str/int/float/bool，str≤256 且不含 , " \r \n） |

**返回值** `void`

> 示例代码

> 记录主线关卡失败

```lua
-- @runtime server
local analyticsService = game:GetService("AnalyticsService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]
if not player then return end
local customData = {
    CustomField01 = "失败原因",
}
analyticsService:LogProgressionFailEvent(player, "主线关卡", 1, "第一章 第一关", customData)
print("已上报进度失败：主线关卡 第1关")
```

### GetPlayerSegmentsAsync

签名：`GetPlayerSegmentsAsync(player: Player) -> Table (分段数据：HasData(bool)；ActivePayerStatus(Top15Percent/Intermediate35Percent/Casual50Percent/Never/Lapsed/Unknown)；WhenUserFirstPlayed(Days0To30/Days31To90/Days91To180/Days181To365/Days366Plus/Unknown)；PlayerPlatformSpenderStatus(Active/OtherPayer/Unknown))`

在协程中异步查询指定玩家的分段数据，返回包含玩家付费状态、首次游玩时间等信息的表。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象（必须在当前 Space 内） |

**返回值** `Table` (分段数据：HasData(bool)；[ActivePayerStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ActivePayerStatus.html)(Top15Percent/Intermediate35Percent/Casual50Percent/Never/Lapsed/Unknown)；[WhenUserFirstPlayed](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/WhenUserFirstPlayed.html)(Days0To30/Days31To90/Days91To180/Days181To365/Days366Plus/Unknown)；[PlayerPlatformSpenderStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PlayerPlatformSpenderStatus.html)(Active/OtherPayer/Unknown))

> 示例代码

> 在任务协程中查询玩家分段

```lua
-- @runtime server
local analyticsService = game:GetService('AnalyticsService')
local Players = game:GetService('Players')
local Task = game:GetService('Task')
local player = Players:GetPlayers()[1]
if player == nil then return end

Task:Spawn(function()
    local segments = analyticsService:GetPlayerSegmentsAsync(player)
    if segments == nil then return end
    print('是否有分段数据:', segments.HasData)
    print('付费分层:', segments.ActivePayerStatus)
end)
```

### LogTrackDataChange

签名：`LogTrackDataChange(player: Player, eventName: String, changeNum: Float, attrKeys: Table) -> void`

记录玩家的自定义蛋码埋点，包含事件名称、数据变化数值以及附带玩家属性键列表。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象（事件归属，必须在当前 Space 内） |
| `eventName` | `String` | 事件名称（非空，1-12 字符，直接作为蛋码 data\_name 上报） |
| `changeNum` | `Float` | 数据变化量 |
| `attrKeys` | `Table` | 可选附带的玩家属性 key 列表（string[]）；通过 player.Character:GetAttribute(key) 读取，读不到的 key 自动忽略 |

**返回值** `void`

> 示例代码

> 上报击杀数变化

```lua
-- @runtime server
local analyticsService = game:GetService("AnalyticsService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]
if not player then return end
local attrKeys = { "Level", "VipLevel" }
analyticsService:LogTrackDataChange(player, "KillCount", 1, attrKeys)
print("已上报自定义蛋码埋点 KillCount，变化量 1")
```
