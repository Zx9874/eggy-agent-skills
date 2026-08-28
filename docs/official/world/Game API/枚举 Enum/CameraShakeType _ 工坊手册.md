# CameraShakeType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → CameraShakeType

相机震动类型枚举定义了相机震动时可用的不同运动模式，用于控制震动效果的表现形式。它提供了前后移动、上下移动和旋转三种震动方式，供开发者在调用相机震动接口时选择。

## 适用场景

在需要为游戏内事件（如爆炸、撞击）添加相机震动反馈时，通过 CameraService:ShakeCamera 方法传入该枚举值来指定震动类型。

## 使用要点

Meta 约定 CameraService:ShakeCamera 的 shakeType 参数使用 Enums.CameraShakeType.FRONT\_AND\_BACK、UP\_AND\_DOWN 或 ROTATE；当前运行包缺少该枚举导出，暂不要调用。

## 注意事项

当前公开 Meta 已声明 [CameraShakeType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeType.html)，但运行包访问 Enums.CameraShakeType 会报 module not found。等待运行时导出与 Meta 对齐，禁止用数字或字符串绕过枚举契约。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `1` | `FRONT_AND_BACK` | 前后 |
| `2` | `UP_AND_DOWN` | 上下 |
| `4` | `ROTATE` | 旋转 |
