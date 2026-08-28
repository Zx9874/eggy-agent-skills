# UserInputState

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → UserInputState

[UserInputState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputState.html) 枚举描述用户输入事件的生命周期阶段，包括开始、变化、结束、取消和未知状态。它用于在输入处理流程中标识当前输入动作所处的具体阶段，帮助开发者精确响应不同类型的输入变化。

## 适用场景

在 [UserInputService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/UserInputService.html) 的 InputBegan、InputChanged、InputEnded 等事件回调中，通过 [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 的 [UserInputState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputState.html) 属性判断输入阶段，从而执行对应的逻辑。

## 使用要点

通过 [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 实例的 [UserInputState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputState.html) 属性获取枚举值，然后与 Enums.UserInputState.Begin、Enums.UserInputState.Change 等成员比较，以区分输入开始、持续变化或结束等状态。

## 注意事项

该枚举值由引擎自动设置，开发者无需手动构造。在输入事件回调中，[InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 的 [UserInputState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputState.html) 字段已包含当前阶段信息，直接读取即可。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Begin` | 输入开始 |
| `1` | `Change` | 输入变化 |
| `2` | `End` | 输入结束 |
| `3` | `Cancel` | 输入取消 |
| `4` | `None` | 输入无状态 |
