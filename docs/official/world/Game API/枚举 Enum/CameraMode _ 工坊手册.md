# CameraMode

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → CameraMode

[CameraMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraMode.html) 枚举定义了相机单元的行为模式，用于控制相机如何跟随或观察场景中的目标。通过设置 [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) 的 Mode 属性为不同枚举值，可以切换相机的跟踪方式，例如绑定到角色、自由脚本控制或固定视角。

## 适用场景

在需要动态切换相机行为的场景中，例如从第三人称跟随切换到固定视角或脚本控制模式，通过将 CameraUnit.Mode 设置为对应的 [CameraMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraMode.html) 枚举值来实现。

## 使用要点

通过 game:GetService("World").CurrentCamera 获取当前 [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html)，判空后把 Mode 设置为 Enums.CameraMode 的命名成员。

## 注意事项

[CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) 由 World.CurrentCamera 提供，当前运行时不能通过 game:CreateUnit 或 World:CreateUnit 创建。枚举成员必须使用 Enums.CameraMode 命名空间，禁止用数字代替。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `NONE` | 不做任何处理, 常用于定点相机 |
| `1` | `EGGY` | 蛋仔跟随模式 |
| `2` | `SCRIPTABLE` | 脚本自定义更新行为 |
| `3` | `FOLLOW` | 与目标保持一定关系跟随目标, 常用于玩家相机 |
| `4` | `BIND` | 绑定在目标上, 常用于模型相机 |
| `5` | `SCREEN_ZONE` | 参考屏幕关系跟随目标, 常用于横板游戏 |
| `6` | `ORBIT` | 环绕跟随, 常用于静态展示 |
