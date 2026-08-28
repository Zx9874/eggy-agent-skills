# ActuatorRelativeTo

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → ActuatorRelativeTo

[ActuatorRelativeTo](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ActuatorRelativeTo.html) 枚举定义执行器参考坐标系的三种语义：Attachment0、Attachment1 与 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)。

## 适用场景

仅当某个公开 API 的参数或属性明确声明为 [ActuatorRelativeTo](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ActuatorRelativeTo.html) 时，用它选择执行器数值所参照的坐标系。当前公开 Surface 尚未暴露使用该类型的成员。

## 使用要点

通过 Enums.ActuatorRelativeTo.Attachment0、Attachment1 或 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html) 引用成员；不要把它赋给未声明该类型的约束属性。

## 注意事项

当前公开 Meta 提供了该枚举定义，但没有公开参数或属性直接消费它。[HingeConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HingeConstraint.html)、[PrismaticConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PrismaticConstraint.html) 的 [ActuatorType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ActuatorType.html) 使用 Enums.ActuatorType，不等同于 [ActuatorRelativeTo](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ActuatorRelativeTo.html)。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Attachment0` | 以约束的 Attachment0 坐标系作为执行器参考基准。 |
| `1` | `Attachment1` | 以约束的 Attachment1 坐标系作为执行器参考基准。 |
| `2` | `World` | 以世界坐标系作为执行器参考基准。 |
