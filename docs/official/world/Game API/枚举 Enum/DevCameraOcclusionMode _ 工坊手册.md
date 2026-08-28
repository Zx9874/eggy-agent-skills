# DevCameraOcclusionMode

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → DevCameraOcclusionMode

[DevCameraOcclusionMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DevCameraOcclusionMode.html) 枚举定义了相机在遇到遮挡物时的处理策略。它提供了三种模式：Zoom 表示拉近相机距离以避免遮挡，Invisicam 表示使遮挡物透明化，EggyHybrid 表示混合使用前两种策略。开发者可通过 [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) 的 [DevCameraOcclusionMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DevCameraOcclusionMode.html) 属性来切换这些模式。

## 适用场景

在需要精细控制相机遮挡行为的场景中，例如第三人称动作游戏或模型展示界面，通过设置 [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) 的 [DevCameraOcclusionMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DevCameraOcclusionMode.html) 属性来选择合适的遮挡处理方式，以优化玩家视野。

## 使用要点

通过 game:GetService("World").CurrentCamera 获取当前 [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html)，判空后把 [DevCameraOcclusionMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DevCameraOcclusionMode.html) 设置为 Enums.DevCameraOcclusionMode.Zoom、Invisicam 或 EggyHybrid。

## 注意事项

[CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) 由 World.CurrentCamera 提供，不能通过 game:CreateUnit 或 World:CreateUnit 创建。枚举成员必须使用 Enums.DevCameraOcclusionMode 命名空间。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Zoom` | 被遮挡时拉近相机，保持清晰视野 |
| `1` | `Invisicam` | 遮挡时使目标半透明（简化版） |
| `2` | `EggyHybrid` | 推镜头 + 目标半透明（蛋仔独有，同时支持两种效果） |
