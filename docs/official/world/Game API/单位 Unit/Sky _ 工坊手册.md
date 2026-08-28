# Sky

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BaseSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html)（1 属性）
    - **[Sky]**（6 属性）

### 继承成员

2 个来源 / 5 属性 / 25 函数 / 6 事件

* 来自 [BaseSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html)（1 属性）
  + 属性：[`AffectedByFog`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html#properties)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[Sky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Sky.html) 是可定制的天空单元，通过切换 [SkyTemplate](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/SkyTemplate.html) 枚举模板快速改变场景氛围，并支持调整旋转、垂直偏移和扰动效果。与 [PresetSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PresetSky.html) 相比，[Sky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Sky.html) 提供更丰富的模板和更全面的参数控制，是新项目推荐使用的天空类型。

## 适用场景

在需要动态改变场景天空时，通过 game:CreateUnit("Sky", {}) 创建 [Sky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Sky.html) 实例并挂载到 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 下，然后设置 Template 属性切换预设模板，或调整 Orientation、YOffset 等参数微调视觉效果。

## 使用要点

使用 game:CreateUnit("Sky", {}) 创建 [Sky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Sky.html) 实例，将其 Parent 设为 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html)。通过设置 Template 属性为 Enums.SkyTemplate 中的枚举值来切换天空模板，并可修改 Orientation、YOffset、DistortionEnabled 等属性实时调整天空外观。

## 注意事项

[Sky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Sky.html) 是完整的可定制天空单元，支持通过 [SkyTemplate](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/SkyTemplate.html) 枚举切换模板并自由调整 Orientation/YOffset/Distortion 等参数。与 [PresetSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PresetSky.html) 相比，[Sky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Sky.html) 功能更全面、模板更丰富，新项目建议优先使用 [Sky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Sky.html)。[Sky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Sky.html) 实例必须挂载到 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 下才能生效，调用 Destroy 或移除 Parent 会立即恢复默认天空。

## 代码示例

### 创建并配置普通天空

```lua
-- @runtime client
local Lighting = game:GetService("LightingService")
local sky = game:CreateUnit("Sky", {
    Template = Enums.SkyTemplate.Day,
    Orientation = Vector3.New(0, 45, 0),
    AffectedByFog = true,
})
sky.Parent = Lighting
```

## 属性 (6)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Template` | [SkyTemplate](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/SkyTemplate.html) | `Enums.SkyTemplate.Night` | 天空使用的预设模板。 |
| `Orientation` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | 天空盒的旋转角度，以欧拉角（度）表示。 |
| `YOffset` | `Float` | `0.0` | 天空在垂直方向上的偏移量。 |
| `DistortionEnabled` | `Bool` | `false` | 是否启用天空扰动效果。 |
| `DistortionStrength` | `Float` | `0.0` | 天空扰动效果的强度。 |
| `DistortionFrequency` | `Float` | `0.0` | 天空扰动效果的频率。 |

## 关联类型

* [BaseSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html)
* [SkyTemplate](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/SkyTemplate.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
