# UserInputType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → UserInputType

[UserInputType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputType.html) 枚举定义了用户输入设备的类型，用于区分鼠标、键盘、触屏、手柄等不同输入来源。在输入事件中，通过该枚举可以判断当前操作由哪种设备触发，从而针对不同设备实现差异化的交互逻辑。

## 适用场景

在 [UserInputService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/UserInputService.html) 的 InputBegan、InputChanged 等事件中，通过 [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 的 [UserInputType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputType.html) 属性判断输入来源，例如检测是否为触屏操作以调整 UI 布局。

## 使用要点

通过 [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 的 [UserInputType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputType.html) 属性获取枚举值，然后与 Enums.UserInputType 中的成员（如 Enums.UserInputType.Touch）进行比较。例如在 InputBegan 事件回调中，使用 if inputObject.UserInputType == Enums.UserInputType.Touch then ... end 来响应触屏输入。

## 注意事项

该枚举值由引擎自动设置，开发者无需手动构造。不同平台下可用的输入类型可能不同，例如移动端通常只有 Touch 和 Keyboard，而 PC 端支持 MouseButton 和 Keyboard 等。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `None` | 未知输入 |
| `1` | `MouseButton1` | 鼠标按钮1（左键） |
| `2` | `MouseButton2` | 鼠标按钮2（右键） |
| `3` | `MouseButton3` | 鼠标按钮3（中键） |
| `4` | `MouseWheel` | 鼠标滚轮输入；滚动方向需结合事件提供的 InputObject.Position 或 Delta 判断。 |
| `5` | `MouseMovement` | 鼠标移动 |
| `6` | `Keyboard` | 键盘按键 |
| `7` | `Touch` | 触摸 |
| `8` | `Accelerometer` | 加速度计 |
| `9` | `Gyroscope` | 陀螺仪 |
| `10` | `Gamepad1` | 游戏手柄1 |
| `11` | `Gamepad2` | 游戏手柄2 |
| `12` | `Gamepad3` | 游戏手柄3 |
| `13` | `Gamepad4` | 游戏手柄4 |
| `14` | `TextInput` | 文本输入 |
| `15` | `InputMethod` | 输入法 |
