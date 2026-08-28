# TriggerCallbackInfo

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[TriggerCallbackInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TriggerCallbackInfo.html) 是 [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html) 本地触发事件传入的只读回调数据，公开提供 OtherUnit，用于标识进入或离开触发区域的另一方单位。该类型不可直接构造。

## 适用场景

监听 [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html) 的 OnLocalTriggerEnter、OnLocalTriggerExit 时，从 info.OtherUnit 读取触发交互的另一方，并据此执行本地表现或判定逻辑。

## 使用要点

在 OnLocalTriggerEnter/OnLocalTriggerExit 的回调中接收 info 并读取 info.OtherUnit。若后续逻辑需要名称等信息，应在对象仍可安全访问时缓存；退出事件可能因另一方提前销毁而补发。

## 注意事项

该类型只能由 [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html) 的本地触发事件提供，不能主动创建。公开契约未声明 OtherUnit 可空；不要自行扩写可空语义。OnLocalTriggerExit 在另一方提前销毁时也可能补发，因此回调中不要假定对方对象仍可执行依赖存活状态的操作。

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `OtherUnit` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | `-` | 表示与触发器发生交互的其他单位，即触发本次回调事件的单位对象。 |
