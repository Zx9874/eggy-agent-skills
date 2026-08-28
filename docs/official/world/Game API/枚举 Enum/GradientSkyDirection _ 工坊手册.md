# GradientSkyDirection

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → GradientSkyDirection

渐变天空渐变轴向枚举，用于控制 [GradientSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/GradientSky.html) 组件中颜色渐变的方向。它提供 X 轴和 Y 轴两个选项，分别对应水平渐变和垂直渐变，从而改变天空背景的视觉效果。

## 适用场景

在需要动态调整天空渐变方向时使用，例如在天空渲染测试中通过设置 Direction 属性来切换水平或垂直渐变。

## 使用要点

通过 Enums.GradientSkyDirection.X 或 Enums.GradientSkyDirection.Y 引用枚举值，然后将其赋值给 [GradientSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/GradientSky.html) 实例的 Direction 属性。例如：grad.Direction = Enums.GradientSkyDirection.Y。

## 注意事项

该枚举仅用于 [GradientSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/GradientSky.html) 组件的 Direction 属性，不能用于其他天空类型。枚举值区分大小写，必须使用 Enums 前缀。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `X` | X 轴 |
| `1` | `Y` | Y 轴 |
