# BodyType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → BodyType

[BodyType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/BodyType.html) 枚举定义物理刚体的运动行为：None 不参与物理模拟，Static 为固定碰撞体，Kinematic 由脚本驱动位置，Dynamic 完全由物理引擎模拟。

## 适用场景

在创建 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 或 [PhysicsUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PhysicsUnit.html) 等物理对象时，通过 [BodyType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/BodyType.html) 指定其物理行为，例如将地面设为 Static，将可推动的箱子设为 Dynamic，或将脚本移动的平台设为 Kinematic。

## 使用要点

通过 Enums.BodyType.Dynamic 等形式引用枚举成员，并在 World:CreateUnit 的配置表中设置 [BodyType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/BodyType.html) 字段。例如：World:CreateUnit("WorldUnit", { BodyType = Enums.BodyType.Static, Position = Vector3.New(0,0,0) })。

## 注意事项

[BodyType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/BodyType.html) 指定物理刚体的运动行为：None=无物理（仅渲染）；Static=静态（永不移动，用于地面/墙）；Kinematic=运动学（由脚本控制位置，不受力但可碰撞）；Dynamic=动态（受物理引擎驱动，可被力推动）。World:CreateUnit 配置表中 [BodyType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/BodyType.html) 字段使用具体枚举成员，例如 Enums.BodyType.Dynamic。地面/障碍物用 Static，可推动物体用 Dynamic，脚本动画平台用 Kinematic。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `None` | 无物理刚体行为，常用于仅渲染或不参与物理模拟的对象。 |
| `1` | `Static` | 静态刚体，适合作为地面、墙体等固定碰撞物。 |
| `2` | `Kinematic` | 运动学刚体，由脚本或运动器驱动位置，可参与碰撞但不由力推动。 |
| `4` | `Dynamic` | 动态刚体，由物理引擎模拟，可受重力、碰撞和外力影响。 |
