# ConstraintType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → ConstraintType

[ConstraintType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ConstraintType.html) 枚举列出 Spring、Hinge、BallAndSocket、Fixed、Slider、D6、Weld 与 Rod 等约束类别。

## 适用场景

仅当某个公开参数、属性或返回值明确声明为 [ConstraintType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ConstraintType.html) 时，用命名枚举成员进行配置或分支。

## 使用要点

通过 Enums.ConstraintType.Spring、Hinge 等引用成员。当前各约束的 GetConstraintType 在 Meta 中返回 Int，未类型化为 [ConstraintType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ConstraintType.html)。

## 注意事项

不要仅凭成员数值推断 GetConstraintType 的 Int 返回值与该枚举一一对应，也不要把数字转换后宣称得到 [ConstraintType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ConstraintType.html)；等待公开 Meta 建立明确的类型关联。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `1` | `Spring` | 弹簧约束，用于表现带弹性的连接。 |
| `2` | `Hinge` | 铰链约束，用于绕单一轴旋转的连接。 |
| `3` | `BallAndSocket` | 球窝约束，用于允许多方向旋转的连接。 |
| `4` | `Fixed` | 固定约束，用于保持两个对象的相对姿态不变。 |
| `5` | `Slider` | 滑块约束，用于沿单一轴向平移。 |
| `6` | `D6` | 六自由度约束，用于更细粒度地限制平移和旋转自由度。 |
| `7` | `Weld` | 焊接约束，用于将多个对象刚性连接为整体。 |
| `8` | `Rod` | 杆约束，用于保持两个连接点之间的距离。 |
