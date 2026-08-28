# ColorGradingEffect

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)（1 属性）
    - **[ColorGradingEffect]**（15 属性）

### 继承成员

2 个来源 / 5 属性 / 25 函数 / 6 事件

* 来自 [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)（1 属性）
  + 属性：[`Enabled`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html#properties)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

色彩分级效果是一种后处理特效，用于调整场景的整体色彩风格。它支持预设滤镜、基础调色（色相、明度、饱和度、对比度）以及分区域染色（阴影、中间调、高光），可快速改变画面氛围。

## 适用场景

在需要统一场景视觉风格时使用，例如为恐怖地图添加冷色调滤镜，或为梦幻主题增强饱和度与暖色染色。

## 使用要点

通过 game:CreateUnit("ColorGradingEffect", { Enabled = true }) 创建实例，将 Parent 设置为 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html)，再读写 Filter、Hue、Saturation 等属性。

## 注意事项

实例必须挂载到 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 下才能参与后处理；Filter 使用 Enums.ColorGradingFilter 命名成员。

## 代码示例

### 创建色彩分级并设置滤镜

```lua
-- @runtime client
local Lighting = game:GetService('LightingService')
local grading = game:CreateUnit('ColorGradingEffect', {
    Enabled = true,
    Filter = Enums.ColorGradingFilter.RedNegative,
    FilterStrength = 0.5,
    Saturation = 0.8,
    Contrast = 1.2,
})
grading.Parent = Lighting

grading.Enabled = true
print('色彩分级已启用:', grading.Filter)
```

## 属性 (15)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Filter` | [ColorGradingFilter](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ColorGradingFilter.html) | `Enums.ColorGradingFilter.None` | 选择预设的 LUT 滤镜效果。 |
| `FilterStrength` | `Float` | `1.0` | 控制滤镜效果的强度。 |
| `Hue` | `Float` | `0.0` | 调整画面的色相偏移。 |
| `Brightness` | `Float` | `1.0` | 调整画面的整体明度。 |
| `Saturation` | `Float` | `1.0` | 调整画面的饱和度。 |
| `Contrast` | `Float` | `1.0` | 调整画面的对比度。 |
| `ToningStrength` | `Float` | `0.0` | 控制整体染色效果的强度。 |
| `ShadowsColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(0, 0, 0, 255)` | 阴影区域的颜色调整，用于为画面暗部叠加指定色调。 |
| `ShadowsStrength` | `Float` | `1.0` | 控制阴影区域染色的强度。 |
| `MidtonesColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(0, 0, 0, 255)` | 中间调区域的颜色调整，用于为画面中间亮度部分叠加指定色调。 |
| `MidtonesStrength` | `Float` | `1.0` | 控制中间调区域染色的强度。 |
| `HighlightsColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(0, 0, 0, 255)` | 高光区域的颜色调整，用于为画面亮部叠加指定色调。 |
| `HighlightsStrength` | `Float` | `1.0` | 控制高光区域染色的强度。 |
| `Temperature` | `Float` | `0.0` | 调整画面的色温。 |
| `Tint` | `Float` | `0.0` | 调整画面的色调偏移。 |

## 关联类型

* [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
* [ColorGradingFilter](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ColorGradingFilter.html)
