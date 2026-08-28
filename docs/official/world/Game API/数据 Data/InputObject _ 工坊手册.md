# InputObject

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 封装了用户输入事件的详细信息，包括按键代码、输入类型、状态、位置和变化量。它由 [UserInputService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/UserInputService.html) 的输入事件自动生成，用于在回调中判断具体输入行为。

## 适用场景

在 [UserInputService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/UserInputService.html) 的 InputBegan、InputChanged、InputEnded 等事件回调中，通过参数获取 [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 实例，读取 KeyCode、UserInputType 等属性来响应键盘、鼠标或触摸操作。

## 使用要点

通过 [UserInputService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/UserInputService.html) 的输入事件回调参数获取 [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 实例，例如 UserInputService.InputBegan:Connect(function(input, gameProcessed) ... end)。然后读取 input.KeyCode 判断按键，或检查 input.UserInputState 了解输入阶段。

## 注意事项

[InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 不可由脚本手动构造，只能从输入事件的回调参数中获取。事件处理完毕后不应长期持有引用；Processed 是只读状态，用于判断输入是否已经被 UI 或其他系统消费。

## 代码示例

### 在输入事件中读取 InputObject

```lua
-- @runtime client
local userInputService = game:GetService("UserInputService")

userInputService.InputBegan:Once(function(inputObject, gameProcessedEvent)
    if gameProcessedEvent then
        return
    end

    if inputObject.UserInputType == Enums.UserInputType.Keyboard and inputObject.KeyCode == Enums.KeyCode.F1 then
        print("按下 F1")
    end
end)
```

## 属性 (6)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `KeyCode` | [KeyCode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/KeyCode.html) | `-` | 表示触发输入事件的键盘按键代码，用于识别具体按下的键。 |
| `UserInputType` | [UserInputType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputType.html) | `-` | 表示触发输入事件的设备类型，如键盘、鼠标、触摸屏等。 |
| `UserInputState` | [UserInputState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputState.html) | `-` | 表示输入事件的当前状态，如开始、持续、结束等。 |
| `Position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 表示输入事件发生时的屏幕位置或世界位置，具体含义取决于输入类型。 |
| `Delta` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 表示输入事件中位置或状态的变化量，通常用于鼠标移动、触摸滑动或摇杆偏移等连续输入。 |
| `Processed` | `Bool` | `-` | 指示该输入事件是否已被其他 UI 元素或系统处理，可用于决定是否继续处理该输入。 |

## 关联类型

* [KeyCode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/KeyCode.html)
* [UserInputState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputState.html)
* [UserInputType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputType.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
