# CameraShakeCurve

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → CameraShakeCurve

相机震动曲线枚举定义了相机震动时使用的波形类型，用于控制震动的节奏和强度变化模式。它提供正弦波和噪声两种曲线，分别产生平滑周期震动和随机不规则震动效果。

## 适用场景

在调用 CameraService:ShakeCamera 方法时，通过传入 [CameraShakeCurve](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeCurve.html) 枚举值来指定震动曲线，以实现不同的屏幕震动表现。

## 使用要点

Meta 约定 CameraService:ShakeCamera 的 shakeCurve 参数使用 Enums.CameraShakeCurve.SINE 或 Enums.CameraShakeCurve.NOISE；当前运行包缺少配套枚举导出，暂不要调用。

## 注意事项

当前公开 Meta 已声明 [CameraShakeCurve](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeCurve.html)，但运行包尚未正确导出 [CameraShakeType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeType.html)，导致完整的 ShakeCamera 调用链不可用。等待运行时修复，禁止用数字或字符串绕过命名枚举契约。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `9998` | `SINE` | 正弦 |
| `9999` | `NOISE` | 随机噪声 |
