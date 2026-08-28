# AdvertisementService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[AdvertisementService]**（2 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[AdvertisementService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/AdvertisementService.html) 是服务端广告请求服务，提供带成功/失败事件与回调数据的广告播放，以及与商业化商品奖励关联的激励视频播放。

## 适用场景

需要按广告结果触发项目事件，或在激励视频完成后发放后台已配置商品时，通过该服务向指定玩家发起请求。

## 使用要点

通过 game:GetService("AdvertisementService") 获取服务。PlayAdvertisementWithEvent 需要项目中已约定的成功/失败事件名与回调数据；ShowRewardedVideoAd 的 goodsId 必须来自商业化后台配置。

## 注意事项

广告接口需在服务端调用；客户端调用会直接返回，不会触发广告请求。接口依赖正式广告环境与平台能力，编辑器、本地调试或未接入广告配置时可能无回调、无 UI 表现或直接静默失败。ShowRewardedVideoAd 的 goodsId 是商业化后台配置的商品 ID，不是 official:// 资源 URI。示例只能说明调用方式，不能作为本地可见效果验收；接入时需以正式包和广告后台配置为准。

## 代码示例

### 服务端播放广告并传递回调数据

```lua
-- @runtime server
local advertisementService = game:GetService("AdvertisementService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]

if player ~= nil then
    advertisementService:PlayAdvertisementWithEvent(
        player,
        "AdSuccess",
        "AdFail",
        "reward_video_1",
        { reward = 100 },
        { reason = "user_skip" }
    )
end
```

### 服务端播放广告并发放商品奖励

```lua
-- @runtime server
local advertisementService = game:GetService("AdvertisementService")

local function showConfiguredRewardedAd(player, goodsId)
    if player == nil or goodsId == nil or goodsId == "" then return end
    advertisementService:ShowRewardedVideoAd(
        player,
        goodsId,
        "RewardAdSuccess",
        "RewardAdFail",
        "goods_reward_ad"
    )
end

-- 调用方应传入商业化后台配置的真实 goodsId
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (2)

### PlayAdvertisementWithEvent

签名：`PlayAdvertisementWithEvent(player: Player, successEvent: String, failEvent: String, adTag: String, successData: Table, failData: Table) -> void`

播放激励视频广告。调用后为指定玩家播放激励视频广告，并根据广告播放结果触发对应的事件。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |
| `successEvent` | `String` | 成功事件 |
| `failEvent` | `String` | 失败事件 |
| `adTag` | `String` | 广告标签 |
| `successData` | `Table` | 成功数据 |
| `failData` | `Table` | 失败数据 |

**返回值** `void`

> 示例代码

> 服务端播放广告并监听结果事件

```lua
-- @runtime server
local advertisementService = game:GetService("AdvertisementService")
local players = game:GetService("Players")
local player = players:GetPlayers()[1]

if player ~= nil then
    advertisementService:PlayAdvertisementWithEvent(
        player,
        "AdSuccess",
        "AdFail",
        "reward_video_1",
        { reward = 100 },
        { reason = "user_skip" }
    )
end
```

### ShowRewardedVideoAd

签名：`ShowRewardedVideoAd(player: Player, goodsId: String, successEvent: String, failEvent: String, adTag: String) -> void`

播放激励视频广告，并在广告播放成功后发放指定商品奖励。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家对象 |
| `goodsId` | `String` | 商业化后台配置的商品 ID，不是 official://、map:// 等资源 URI |
| `successEvent` | `String` | 成功事件 |
| `failEvent` | `String` | 失败事件 |
| `adTag` | `String` | 广告标签 |

**返回值** `void`

> 示例代码

> 服务端播放广告并发放商品奖励

```lua
-- @runtime server
local advertisementService = game:GetService("AdvertisementService")

local function showConfiguredRewardedAd(player, goodsId)
    if player == nil or goodsId == nil or goodsId == "" then return end
    advertisementService:ShowRewardedVideoAd(
        player,
        goodsId,
        "RewardAdSuccess",
        "RewardAdFail",
        "goods_reward_ad"
    )
end

-- 调用方应传入商业化后台配置的真实 goodsId
```
