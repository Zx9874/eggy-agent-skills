# QuadGradientSky

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BaseSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html)（1 属性）
    - **[QuadGradientSky]**（12 属性）

### 继承成员

2 个来源 / 5 属性 / 25 函数 / 6 事件

* 来自 [BaseSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html)（1 属性）
  + 属性：[`AffectedByFog`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html#properties)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

四色渐变天空是一种通过天顶、偏上、偏下、天底四层颜色和高度定义天空渐变效果的组件。它允许调整各层颜色、高度位置以及层间过渡柔度，并支持整体旋转。常用于营造丰富的天空氛围，替代单一颜色或简单渐变。

## 适用场景

在需要自定义天空渐变效果的场景中，通过创建 [QuadGradientSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/QuadGradientSky.html) 实例并设置其四层颜色与高度，可以快速实现从头顶到地平线的多色过渡。例如在测试环境中动态修改颜色和柔度来验证渲染效果。

## 使用要点

使用 game:CreateUnit("QuadGradientSky", {}) 创建实例，并将其 Parent 设置为 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html)。然后依次设置 ZenithColor、UpperColor、LowerColor、NadirColor 等颜色属性，以及 ZenithHeight、UpperHeight、LowerHeight、NadirHeight 等高度属性，最后可调整 UpperToZenithSoftness、LowerToUpperSoftness、NadirToLowerSoftness 控制过渡柔度。

## 注意事项

实例必须通过 game:CreateUnit 或 World:CreateUnit 创建，不能使用 New 方法。高度值通常在 0 到 1 之间，0 代表天顶，1 代表天底。颜色属性接受 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)，可使用 Color.New(...) 或等价的 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)(...) 构造。

## 代码示例

### 创建并配置四色渐变天空

```lua
-- @runtime client
local Lighting = game:GetService("LightingService")
local sky = game:CreateUnit("QuadGradientSky", {
    ZenithColor = Color.New(24, 64, 180, 255),
    UpperColor = Color.New(80, 140, 255, 255),
    LowerColor = Color.New(255, 170, 120, 255),
    NadirColor = Color.New(32, 38, 60, 255),
    ZenithHeight = 0.2,
    UpperHeight = 0.4,
    LowerHeight = 0.7,
    NadirHeight = 1.0,
})
sky.Parent = Lighting
```

## 属性 (12)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `ZenithColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(0, 55, 255, 255)` | 设置四色渐变天空天顶区域的颜色。 |
| `UpperColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(30, 97, 255, 255)` | 设置四色渐变天空偏上区域的颜色。 |
| `LowerColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 184, 162, 255)` | 设置四色渐变天空偏下区域的颜色。 |
| `NadirColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(243, 255, 245, 255)` | 设置四色渐变天空天底区域的颜色。 |
| `ZenithHeight` | `Float` | `0.0` | 天空渐变中天顶层的高度位置，通常为 0.0 表示天顶。 |
| `UpperHeight` | `Float` | `0.33` | 天空渐变中偏上层的高度位置，取值范围通常在天顶(0)到天底(1)之间。 |
| `LowerHeight` | `Float` | `0.66` | 天空渐变中偏下层的高度位置，取值范围通常在天顶(0)到天底(1)之间。 |
| `NadirHeight` | `Float` | `1.0` | 天空渐变中天底层的高度位置，通常为 1.0 表示天底。 |
| `Orientation` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0.0, 0.0, 0.0]` | 设置四色渐变天空的旋转角度。 |
| `UpperToZenithSoftness` | `Float` | `0.5` | 控制偏上层与天顶层之间颜色过渡的柔和程度。 |
| `LowerToUpperSoftness` | `Float` | `0.5` | 控制偏下层与偏上层之间颜色过渡的柔和程度。 |
| `NadirToLowerSoftness` | `Float` | `0.5` | 控制天底层与偏下层之间颜色过渡的柔和程度。 |

## 关联类型

* [BaseSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
