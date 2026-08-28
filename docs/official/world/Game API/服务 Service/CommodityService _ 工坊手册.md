# CommodityService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[CommodityService]**（17 函数 / 5 事件）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

商业化服务，提供玩家商品与权益查询、商品面板交互、免费商品请求、消耗操作以及相关状态事件。

## 适用场景

适合服务端校验玩家商品、粉丝团或会员权益，以及客户端展示商品详情、购买面板并监听商业化状态变化。

## 使用要点

先通过 game:GetService("CommodityService") 获取服务。商品、权益与数量等可信查询应在服务端执行；面板展示和交互请求按方法运行端约束调用，商品 ID 必须来自项目实际配置。

## 注意事项

[CommodityService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/CommodityService.html) 同时包含客户端 UI/请求方法与服务端查询方法。HasCommodity/GetCommodityCount/IsAuthorFans/GetFanClubLevel/IsFansRightsActive/IsVip/IsVipRightsActive/GetGoods/GetGoodsInfo 等查询在客户端会返回默认值或无法获得真实业务数据，应在服务端脚本中调用；ShowGoodsDetailPanel/ShowGoodsPurchasePanel/SetGoodsPanelVisible/SetGoodsVisible/RequestFreeGoods/ConsumeCommodity 可按具体交互从客户端或服务端触发。

## 代码示例

### 监听道具消耗事件

```lua
-- @runtime client
-- 获取 CommodityService 服务实例
local commodityService = game:GetService("CommodityService")
-- 订阅本地道具消耗事件，回调参数依次为道具Id、消耗数量、消耗玩家
commodityService.CommodityConsumed:Once(function(commodityId, consumeNum, consumePlayer)
    print("消耗道具:", commodityId, "数量:", consumeNum, "玩家:", consumePlayer:GetName())
end)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (5)

### CommodityConsumed

签名：`CommodityConsumed(commodityId: Int, consumeNum: Int, consumePlayer: Player)` 触发：`local`

玩家消耗指定道具时触发的事件，回调参数包含被消耗的道具ID、消耗数量以及执行消耗操作的玩家。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `commodityId` | `Int` | 道具Id |
| `consumeNum` | `Int` | 数量 |
| `consumePlayer` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |

> 示例代码

> 监听一次道具消耗事件

```lua
-- @runtime client
local commodityService = game:GetService("CommodityService")
commodityService.CommodityConsumed:Once(function(commodityId, consumeNum, consumePlayer)
    print("道具消耗:", commodityId, "数量:", consumeNum)
    if consumePlayer ~= nil then
        print("消耗玩家:", consumePlayer:GetName())
    end
end)
```

### CommodityObtain

签名：`CommodityObtain(commodityId: Int, consumeNum: Int, consumePlayer: Player, isBringInto: Bool)` 触发：`local`

玩家获得指定道具时触发的事件，回调参数包含获得的道具ID、获得数量、获得道具的玩家以及是否为带入来源的标记。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `commodityId` | `Int` | 道具Id |
| `consumeNum` | `Int` | 数量 |
| `consumePlayer` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `isBringInto` | `Bool` | 是否为跨局携带道具 |

> 示例代码

> 监听商品获得事件

```lua
-- @runtime client
local commodityService = game:GetService("CommodityService") -- 获取商品服务
commodityService.CommodityObtain:Once(function(commodityId, consumeNum, consumePlayer, isBringInto)
    -- 打印获得商品的信息
    print(commodityId, consumeNum, consumePlayer, isBringInto)
end)
```

### GoodsPurchaseCompleted

签名：`GoodsPurchaseCompleted(goodsId: String, goodsNum: Int, player: Player)` 触发：`local`

玩家完成商品购买时触发的事件，回调参数包含购买的商品ID、购买数量以及购买玩家。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `goodsId` | `String` | 商品Id |
| `goodsNum` | `Int` | 数量 |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |

> 示例代码

> 监听商品购买完成事件

```lua
-- @runtime client
local commodityService = game:GetService("CommodityService")

-- 监听商品购买完成事件（由玩家在购买面板完成支付后触发）
commodityService.GoodsPurchaseCompleted:Once(function(goodsId, goodsNum, player)
    print("商品购买完成：" .. tostring(goodsId) .. "，数量：" .. tostring(goodsNum))
    if player ~= nil then
        print("购买玩家：" .. player:GetName())
    end
end)

-- 连接成功后不会立即执行回调；实际购买由玩家在商品面板中完成
```

### FanClubStatusChanged

签名：`FanClubStatusChanged(player: Player, oldLevel: Int, newLevel: Int)` 触发：`local`

玩家对当前地图创作者的粉丝团等级发生变化时触发的事件，回调参数包含发生变化的玩家、旧等级和新等级。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `oldLevel` | `Int` | 变更前等级（0=未加入） |
| `newLevel` | `Int` | 变更后等级（0=已退出） |

> 示例代码

> 监听一次粉丝团等级变化

```lua
-- @runtime client
local commodityService = game:GetService("CommodityService")
commodityService.FanClubStatusChanged:Once(function(player, oldLevel, newLevel)
    local playerName = player ~= nil and player:GetName() or "未知玩家"
    print(string.format("粉丝团等级变化：%s 从 %d 级变为 %d 级", playerName, oldLevel, newLevel))
end)
```

### VipStatusChanged

签名：`VipStatusChanged(player: Player, isVip: Bool)` 触发：`local`

玩家的乐园会员状态发生变化时触发的事件，回调参数包含发生变化的玩家以及是否为乐园会员的标记。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `isVip` | `Bool` | 变更后的会员状态 |

> 示例代码

> 监听玩家VIP状态变化事件

```lua
-- @runtime client
local commodityService = game:GetService("CommodityService")

local function onVipStatusChanged(player, isVip)
    print("玩家VIP状态变化，新状态：", isVip)
end

commodityService.VipStatusChanged:Once(onVipStatusChanged)

print("已监听VipStatusChanged事件，等待触发...")
```

## 函数 (17)

### HasCommodity

签名：`HasCommodity(player: Player, commodityId: Int) -> Bool (是否拥有道具)`

判断指定玩家是否拥有指定道具。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |
| `commodityId` | `Int` | 道具Id |

**返回值** `Bool` (是否拥有道具)

> 示例代码

> 在服务端检查玩家是否拥有道具

```lua
-- @runtime server
local commodityService = game:GetService("CommodityService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]

if player ~= nil then
    local hasCommodity = commodityService:HasCommodity(player, 10001)
    print("玩家是否拥有道具:", hasCommodity)
end
```

### GetCommodityCount

签名：`GetCommodityCount(player: Player, commodityId: Int) -> Int (拥有道具数量)`

获取指定玩家拥有指定道具的数量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |
| `commodityId` | `Int` | 道具Id |

**返回值** `Int` (拥有道具数量)

> 示例代码

> 在服务端查询玩家道具数量

```lua
-- @runtime server
local commodityService = game:GetService("CommodityService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]

if player ~= nil then
    local count = commodityService:GetCommodityCount(player, 10001)
    print("玩家拥有道具数量:", count)
end
```

### ConsumeCommodity

签名：`ConsumeCommodity(player: Player, commodityId: Int, num: Int) -> void`

消耗指定玩家指定数量的道具。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |
| `commodityId` | `Int` | 道具Id |
| `num` | `Int` | 消耗数量 |

**返回值** `void`

> 示例代码

> 消耗玩家指定数量道具

```lua
-- @runtime client
local commodityService = game:GetService('CommodityService')
local players = game:GetService('Players')
local player = players.LocalPlayer
if player ~= nil then
    commodityService:ConsumeCommodity(player, 1001, 1)
    print('已请求消耗道具 1001 一个')
end
```

### SetGoodsPanelVisible

签名：`SetGoodsPanelVisible(player: Player, visible: Bool) -> void`

设置指定玩家付费道具商店的可见性。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |
| `visible` | `Bool` | 可见性 |

**返回值** `void`

> 示例代码

> 设置付费道具商店可见性

```lua
-- @runtime client
local commodityService = game:GetService('CommodityService')
local players = game:GetService('Players')
local player = players.LocalPlayer
if player ~= nil then
    commodityService:SetGoodsPanelVisible(player, true)
    print('已请求打开付费道具商店')
end
```

### ShowGoodsDetailPanel

签名：`ShowGoodsDetailPanel(player: Player, rawGoodsId: String) -> void`

为指定玩家显示指定商品的详情界面。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |
| `rawGoodsId` | `String` | 商品Id |

**返回值** `void`

> 示例代码

> 用项目配置的商品 ID 打开详情

```lua
-- @runtime client
local commodityService = game:GetService("CommodityService")

local function showGoodsDetail(player, rawGoodsId)
    if player == nil or rawGoodsId == nil or rawGoodsId == "" then return end
    commodityService:ShowGoodsDetailPanel(player, rawGoodsId)
end

-- 调用方应把商业化后台配置的真实 rawGoodsId 传给 showGoodsDetail
```

### ShowGoodsPurchasePanel

签名：`ShowGoodsPurchasePanel(player: Player, rawGoodsId: String, showTime: Float) -> void`

为指定玩家显示指定商品的购买界面。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |
| `rawGoodsId` | `String` | 商品Id |
| `showTime` | `Float` | 展示时间 |

**返回值** `void`

> 示例代码

> 用项目配置的商品 ID 打开购买面板

```lua
-- @runtime client
local commodityService = game:GetService("CommodityService")

local function showGoodsPurchase(player, rawGoodsId, displaySeconds)
    if player == nil or rawGoodsId == nil or rawGoodsId == "" then return end
    commodityService:ShowGoodsPurchasePanel(player, rawGoodsId, displaySeconds)
end

-- 调用方应传入商业化后台配置的真实 rawGoodsId 与展示时长
```

### SetGoodsVisible

签名：`SetGoodsVisible(player: Player, rawGoodsId: String, visible: Bool) -> void`

设置指定玩家某个付费商品的可见性。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |
| `rawGoodsId` | `String` | 商品Id |
| `visible` | `Bool` | 可见性 |

**返回值** `void`

> 示例代码

> 按项目配置切换商品可见性

```lua
-- @runtime client
local commodityService = game:GetService("CommodityService")

local function setConfiguredGoodsVisible(player, rawGoodsId, visible)
    if player == nil or rawGoodsId == nil or rawGoodsId == "" then return end
    commodityService:SetGoodsVisible(player, rawGoodsId, visible)
end

-- 调用方应把商业化后台配置的真实 rawGoodsId 传入该函数
```

### RequestFreeGoods

签名：`RequestFreeGoods(player: Player, rawGoodsId: String) -> void`

为指定玩家获取指定的免费商品。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |
| `rawGoodsId` | `String` | 商品Id |

**返回值** `void`

> 示例代码

> 请求项目中已配置的免费商品

```lua
-- @runtime client
local commodityService = game:GetService("CommodityService")

local function requestConfiguredFreeGoods(player, rawGoodsId)
    if player == nil or rawGoodsId == nil or rawGoodsId == "" then return end
    commodityService:RequestFreeGoods(player, rawGoodsId)
end

-- 仅传入商业化后台中已配置为免费商品的真实 rawGoodsId
```

### IsAuthorFans

签名：`IsAuthorFans(player: Player) -> Bool (是否为粉丝)`

查询指定玩家是否为当前地图作者的粉丝。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |

**返回值** `Bool` (是否为粉丝)

> 示例代码

> 在服务端检查作者粉丝状态

```lua
-- @runtime server
local commodityService = game:GetService("CommodityService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]

if player ~= nil then
    local isFans = commodityService:IsAuthorFans(player)
    print("玩家是否为作者粉丝:", isFans)
end
```

### GetFanClubLevel

签名：`GetFanClubLevel(player: Player) -> Int (粉丝团等级（0=未加入，1/2/3=各级粉丝团）)`

获取指定玩家对当前地图创作者的粉丝团等级。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |

**返回值** `Int` (粉丝团等级（0=未加入，1/2/3=各级粉丝团）)

> 示例代码

> 在服务端获取粉丝团等级

```lua
-- @runtime server
local commodityService = game:GetService("CommodityService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]

if player ~= nil then
    local level = commodityService:GetFanClubLevel(player)
    print("玩家粉丝团等级:", level)
end
```

### IsFansRightsActive

签名：`IsFansRightsActive() -> Bool (是否开启)`

查询当前地图是否开启了粉丝团权益功能。

**返回值** `Bool` (是否开启)

> 示例代码

> 在服务端检查粉丝团权益开关

```lua
-- @runtime server
local commodityService = game:GetService("CommodityService")
local isActive = commodityService:IsFansRightsActive()
print("粉丝团权益是否开启:", isActive)
```

### IsVip

签名：`IsVip(player: Player) -> Bool (是否为乐园会员)`

查询指定玩家是否为乐园会员。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |

**返回值** `Bool` (是否为乐园会员)

> 示例代码

> 在服务端检查乐园会员状态

```lua
-- @runtime server
local commodityService = game:GetService("CommodityService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]

if player ~= nil then
    local isVip = commodityService:IsVip(player)
    print("玩家是否为乐园会员:", isVip)
end
```

### IsVipRightsActive

签名：`IsVipRightsActive() -> Bool (是否开启)`

查询当前地图是否开启了乐园会员权益功能。

**返回值** `Bool` (是否开启)

> 示例代码

> 在服务端检查乐园会员权益开关

```lua
-- @runtime server
local commodityService = game:GetService("CommodityService")
local isActive = commodityService:IsVipRightsActive()
print("乐园会员权益是否开启:", isActive)
```

### PromptFanClubPurchase

签名：`PromptFanClubPurchase(player: Player) -> void`

提示指定玩家加入或升级粉丝团。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |

**返回值** `void`

> 示例代码

> 在服务端提示玩家加入粉丝团

```lua
-- @runtime server
local commodityService = game:GetService("CommodityService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]

if player ~= nil and commodityService:IsFansRightsActive() then
    commodityService:PromptFanClubPurchase(player)
    print("已向玩家弹出粉丝团购买界面")
end
```

### PromptVipPurchase

签名：`PromptVipPurchase(player: Player) -> void`

提示指定玩家开通乐园会员。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |

**返回值** `void`

> 示例代码

> 在服务端提示玩家开通乐园会员

```lua
-- @runtime server
local commodityService = game:GetService("CommodityService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]

if player ~= nil and commodityService:IsVipRightsActive() then
    commodityService:PromptVipPurchase(player)
    print("已向玩家弹出乐园会员购买界面")
end
```

### GetGoods

签名：`GetGoods() -> Array<Any> (商品信息列表)`

获取当前地图所有商品信息的列表。

**返回值** `Array<Any>` (商品信息列表)

> 示例代码

> 在服务端获取商品列表

```lua
-- @runtime server
local commodityService = game:GetService("CommodityService")
local goodsList = commodityService:GetGoods()

for index, goodsInfo in ipairs(goodsList) do
    print("商品", index, tostring(goodsInfo))
end
```

### GetGoodsInfo

签名：`GetGoodsInfo(goodsId: String) -> Map (商品信息，不存在时返回nil)`

获取指定商品的详细信息。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `goodsId` | `String` | 商品Id |

**返回值** `Map` (商品信息，不存在时返回nil)

> 示例代码

> 在服务端获取指定商品信息

```lua
-- @runtime server
local commodityService = game:GetService("CommodityService")
local goodsId = "10001"
local goodsInfo = commodityService:GetGoodsInfo(goodsId)

if goodsInfo ~= nil then
    print("商品信息:", tostring(goodsInfo))
else
    print("未找到该商品")
end
```
