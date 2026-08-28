# CameraProjection

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → CameraProjection

相机投影方式枚举定义了摄像机将三维场景投射到二维屏幕时采用的投影模型。透视投影模拟人眼近大远小的视觉效果，正交投影则保持物体尺寸不随距离变化，常用于二维界面或等距视角。

## 适用场景

通过 game:GetService("World").CurrentCamera 获取当前相机后，设置 ProjectionType 在透视投影与正交投影之间切换。

## 使用要点

设置 CameraUnit.ProjectionType 时使用 Enums.CameraProjection.PERSPECTIVE 或 Enums.CameraProjection.ORTHOGRAPHIC，例如 cameraUnit.ProjectionType = Enums.CameraProjection.PERSPECTIVE。

## 注意事项

[CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) 是 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html) 自带实例，不能通过 game:CreateUnit 或 World:CreateUnit 创建；应先获取 World.CurrentCamera 并判空，再修改 ProjectionType。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `PERSPECTIVE` | 透视投影, 适用于3D场景 |
| `1` | `ORTHOGRAPHIC` | 正交投影, 适用于2D场景 |
