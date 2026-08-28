# GradientSky

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BaseSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html)（1 属性）
    - **[GradientSky]**（5 属性）

### 继承成员

2 个来源 / 5 属性 / 25 函数 / 6 事件

* 来自 [BaseSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html)（1 属性）
  + 属性：[`AffectedByFog`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html#properties)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

渐变天空用于在场景中创建双色渐变背景，通过起始颜色和结束颜色定义天空色调，并支持调整渐变方向、过渡位置和柔和度。它继承自基础天空类型，可受雾效影响，适合营造不同的环境氛围。

## 适用场景

在需要自定义天空外观的场景中，通过创建 [GradientSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/GradientSky.html) 实例并设置其颜色和方向属性，快速实现水平或垂直渐变天空效果，常用于渲染测试或环境美术调整。

## 使用要点

通过 World:CreateUnit("GradientSky", values) 创建实例，设置 StartColor、EndColor、Direction、Center 与 Softness，再将 Parent 设为 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html)。

## 注意事项

实例必须挂载到 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 下才会显示；Direction 使用 Enums.GradientSkyDirection，AffectedByFog 控制是否受雾效影响。

## 代码示例

### 创建并配置双色渐变天空

```lua
-- @runtime client
local World = game:GetService("World")
local LightingService = game:GetService("LightingService")
local sky = World:CreateUnit("GradientSky", {
    StartColor = Color.New(255, 120, 170, 255),
    EndColor = Color.New(100, 190, 255, 255),
    Direction = Enums.GradientSkyDirection.Y,
    Center = 0.5,
    Softness = 0.35,
})
sky.Parent = LightingService
```

## 属性 (5)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `StartColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 171, 209, 255)` | 渐变天空的起始颜色，与 EndColor 共同定义天空的渐变效果。 |
| `EndColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(127, 215, 255, 255)` | 渐变天空的结束颜色，与 StartColor 共同定义天空的渐变效果。 |
| `Direction` | [GradientSkyDirection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/GradientSkyDirection.html) | `Enums.GradientSkyDirection.X` | 指定渐变方向，可选值为 Enums.GradientSkyDirection.X 或 Enums.GradientSkyDirection.Y。 |
| `Center` | `Float` | `0.5` | 控制渐变过渡中心的位置，取值范围通常为 0 到 1。 |
| `Softness` | `Float` | `1.0` | 控制渐变过渡的柔和程度，取值范围通常为 0 到 1。 |

## 关联类型

* [BaseSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
* [GradientSkyDirection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/GradientSkyDirection.html)
