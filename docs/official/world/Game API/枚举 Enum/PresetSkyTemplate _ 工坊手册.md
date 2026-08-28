# PresetSkyTemplate

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → PresetSkyTemplate

[PresetSkyTemplate](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PresetSkyTemplate.html) 枚举定义 PresetSky.Template 可使用的固定天空模板。

## 适用场景

在创建 [PresetSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PresetSky.html) 并挂到 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 后，将 PresetSky.Template 设置为该枚举成员以切换固定天空预设。

## 使用要点

通过 game:CreateUnit("PresetSky", {}) 创建 [PresetSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PresetSky.html) 实例，再设置 presetSky.Template = Enums.PresetSkyTemplate.DreamGalaxy 等枚举成员。

## 注意事项

[PresetSkyTemplate](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PresetSkyTemplate.html) 对应 PresetSky.Template；Sky.Template 使用 Enums.SkyTemplate。枚举值必须通过 Enums.PresetSkyTemplate 命名空间访问，禁止使用数字代替。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `19` | `DreamGalaxy` | 幽梦星河 |
| `20` | `MorningStarRhythm` | 启明律动 |
| `23` | `FairyMusicLand` | 仙灵音境 |
| `36` | `SweetDreamPlanet` | 美梦星球 |
| `37` | `NightmarePlanet` | 噩梦星球 |
| `56` | `AuroraBorealis` | 北极之光 |
| `74` | `DeepSeaCoralReef` | 深海珊瑚礁 |
| `81` | `CosmicSphere` | 圆宇宙星体 |
| `100` | `Museum` | 博物馆 |
| `142` | `MistGlow` | 烟光凝 |
