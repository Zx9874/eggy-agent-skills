# AxisType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → AxisType

[AxisType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AxisType.html) 枚举表示 RIGHT、UP 与 FORWARD 三个标准轴向。

## 适用场景

仅当某个公开 API 的参数或属性明确声明为 [AxisType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AxisType.html) 时，用它选择标准轴向。当前公开 Surface 尚未暴露使用该类型的成员。

## 使用要点

通过 Enums.AxisType.RIGHT、UP 或 FORWARD 引用成员；不要把 [AxisType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AxisType.html) 赋给声明为 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 或其他类型的方向属性。

## 注意事项

当前公开 Meta 提供了该枚举定义，但没有公开参数或属性直接消费它。[FileMesh](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/FileMesh.html) 不公开 [AxisType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AxisType.html) 朝向属性，Attachment.Axis 也不能仅凭名称推断为该枚举。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `RIGHT` | 右 |
| `1` | `UP` | 上 |
| `2` | `FORWARD` | 前 |
