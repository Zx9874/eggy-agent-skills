# DevTouchMovementMode

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → DevTouchMovementMode

[DevTouchMovementMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DevTouchMovementMode.html) 是移动端触摸移动模式枚举，用于配置玩家在触屏设备上的虚拟摇杆行为。通过 Enums.DevTouchMovementMode 引用其成员，可设置固定摇杆、动态摇杆或跟随用户偏好等模式。

## 适用场景

在需要自定义移动端操控体验时，通过 UserInputService:SetTouchMovementMode 传入该枚举值，以切换摇杆的响应方式。

## 使用要点

调用 UserInputService:SetTouchMovementMode(Enums.DevTouchMovementMode.DynamicThumbstick) 可将摇杆设为动态模式。若需在运行时检查设备是否支持触摸输入，使用 UserInputService:TouchEnabled()（注意 TouchEnabled 是无参方法，必须用冒号语法调用，不能用点语法当作属性读取）。

## 注意事项

该枚举仅影响移动端触摸操控，对键鼠或手柄输入无效。UserChoice 模式会遵循玩家在系统设置中的偏好，其余模式强制覆盖。注意：UserInputService:TouchEnabled() 是方法调用（带括号），不要写成属性 UserInputService.TouchEnabled。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `UserChoice` | 玩家选择 |
| `1` | `Thumbstick` | 随指摇杆 |
| `2` | `FixedThumbstick` | 固定摇杆 |
| `3` | `DynamicThumbstick` | 动态摇杆 |
| `4` | `Scriptable` | 隐藏摇杆，脚本接管移动 |
