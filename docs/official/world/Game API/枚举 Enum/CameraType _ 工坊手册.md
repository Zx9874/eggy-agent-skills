# CameraType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → CameraType

[CameraType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraType.html) 枚举定义 [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) 的镜头行为类型，包括固定、附着、注视、追踪、跟随、自定义、脚本控制与环绕模式。

## 适用场景

通过 game:GetService("World").CurrentCamera 获取当前相机后，根据镜头需求设置 [CameraType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraType.html) 属性。

## 使用要点

先获取 World.CurrentCamera 并判空，再把 camera.CameraType 设置为 Enums.CameraType.Fixed、Follow、Scriptable 等命名成员。

## 注意事项

[CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) 不能通过 game:CreateUnit 或 World:CreateUnit 创建。[CameraType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraType.html) 与 [CameraMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraMode.html) 是不同枚举，赋值时应以目标属性的 Meta 类型为准。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Fixed` | 固定位置相机 |
| `1` | `Attach` | 绑定到目标 |
| `2` | `Watch` | 注视目标 |
| `3` | `Track` | 追踪目标 |
| `4` | `Follow` | 跟随目标 |
| `5` | `Custom` | 自定义模式 |
| `6` | `Scriptable` | 脚本控制 |
| `7` | `Orbital` | 环绕模式 |
