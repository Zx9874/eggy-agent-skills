# SkyTemplate

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → SkyTemplate

天空模板枚举定义了引擎内置的天空视觉效果预设，每个成员代表一种完整的天空外观方案。通过将枚举值赋给 [Sky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Sky.html) 对象的 Template 属性，可以快速切换场景的天空氛围，无需手动调整多个参数。

## 适用场景

在需要动态改变场景天空外观时使用，例如根据游戏时间或剧情切换白天、夜晚、黄昏等不同天空效果。

## 使用要点

通过 game:CreateUnit("Sky", {}) 创建 [Sky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Sky.html) 实例，将 Parent 设置为 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html)，再把 Template 赋值为 Enums.SkyTemplate 的命名成员。

## 注意事项

[SkyTemplate](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/SkyTemplate.html) 仅用于 Sky.Template；PresetSky.Template 使用 Enums.PresetSkyTemplate，两者不要混用。[Sky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Sky.html) 实例需挂载到 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html)，枚举成员必须通过 Enums.SkyTemplate 命名空间引用。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `1` | `Night` | 夜晚 |
| `2` | `Dusk` | 黄昏 |
| `4` | `Day` | 白天 |
| `6` | `AmusementPark` | 游乐园 |
| `7` | `Circus` | 马戏团 |
| `8` | `SeaIsland` | 海岛 |
| `11` | `MagpieBridge` | 鹊桥相会 |
| `12` | `SunMoonStars` | 日月星辰 |
| `13` | `SportsFieldDay` | 运动场-白天 |
| `14` | `MoonAboveClouds` | 云上圆月 |
| `15` | `SportsFieldNight` | 运动场-夜晚 |
| `16` | `CandyValley` | 糖果河谷 |
| `17` | `SpookyCastle` | 惊悚古堡 |
| `18` | `CakeRoundTable` | 蛋糕圆桌 |
| `21` | `ColorfulSpace` | 幻彩空间 |
| `24` | `DragonEggIsland` | 龙蛋岛 |
| `25` | `LavaRealm` | 熔岩领域 |
| `27` | `ChineseGarden` | 园林 |
| `28` | `Moon` | 月球上空 |
| `29` | `Earth` | 地球上空 |
| `30` | `OuterSpace` | 太空 |
| `33` | `Desert` | 沙漠 |
| `38` | `SichuanTrendDay` | 蜀中国潮-白天 |
| `39` | `SichuanTrendDusk` | 蜀中国潮-黄昏 |
| `40` | `SichuanTrendNight` | 蜀中国潮-晚上 |
| `41` | `ZeroGravityParty1` | 失重派对-一 |
| `42` | `ZeroGravityParty2` | 失重派对-二 |
| `43` | `ZeroGravityParty3` | 失重派对-三 |
| `45` | `MorningForest` | 清晨森林 |
| `50` | `PhantomForest` | 魅影森林 |
| `51` | `ChineseStyleCloudSea` | 国风云海 |
| `52` | `ChineseStyleMountainRiver` | 国风山川 |
| `53` | `FlowerField` | 花丛 |
| `54` | `HorrorFog` | 恐怖迷雾 |
| `55` | `PinkSnowfield` | 粉色雪原 |
| `57` | `Forest` | 森林 |
| `58` | `Underwater` | 海底 |
| `59` | `City` | 都市 |
| `62` | `CozyCottageDay` | 温馨小屋-白天 |
| `63` | `CozyCottageNight` | 温馨小屋-晚上 |
| `66` | `WindingRainbowRoad` | 蜿蜒彩道 |
| `67` | `SharkIsland` | 鲨鱼海岛 |
| `69` | `Clear` | 晴朗天空 |
| `75` | `ClearNight` | 清朗夜空 |
| `76` | `Dusk2` | 黄昏天空 |
| `78` | `TwilightForest` | 暮夜森林 |
| `85` | `Desert2` | 沙漠 |
| `95` | `Classroom` | 教室 |
| `102` | `FloatingMist` | 浮岚卷岫 |
