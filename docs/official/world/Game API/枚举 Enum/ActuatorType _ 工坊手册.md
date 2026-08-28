# ActuatorType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → ActuatorType

[ActuatorType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ActuatorType.html) 枚举定义了物理约束的驱动方式，用于指定马达或伺服机构的行为模式。它包含三种成员：None 表示无驱动，Motor 表示以恒定速度驱动，Servo 表示以目标位置驱动。

## 适用场景

在创建 [HingeConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HingeConstraint.html) 或 [PrismaticConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PrismaticConstraint.html) 等约束时，通过设置 [ActuatorType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ActuatorType.html) 属性来决定约束的驱动类型，例如让铰链像马达一样旋转或像伺服一样定位。

## 使用要点

通过 Enums.ActuatorType.Motor 或 Enums.ActuatorType.Servo 引用枚举值，然后赋值给约束的 [ActuatorType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ActuatorType.html) 属性。例如：constraint.ActuatorType = Enums.ActuatorType.Motor。

## 注意事项

该枚举不能直接实例化，只能通过 Enums.ActuatorType 访问其成员。使用前需确认目标约束是否支持所选的驱动类型。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `None` | 无驱动，自由运动 |
| `1` | `Motor` | 恒速旋转模式 |
| `2` | `Servo` | 目标角度跟踪模式 |
