# HumanUnit

人形生物。通过 World:CreateUnit("HumanUnit", {...}) 创建，字段属性可直接读写。

## 概览

人形生物：具备空间位置、姿态、模型、物理与动画能力的人形角色，可配置碰撞、重力、质量等物理属性。

> 继承自 `SpaceUnit`；可通过 `World:CreateUnit("HumanUnit", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `RenderMeshId` | `String` | - | 单位使用的骨骼网格资源路径，支持 official:// 协议引用官方资源。 |
| `EnableAnimator` | `Bool` | - | 单位创建时是否自动挂载 Animator。 |
| `EnableAnimScript` | `Bool` | - | 单位创建时是否自动挂载动画蓝图脚本。 |
| `PhysicsActive` | `Bool` | - | 是否启用物理模拟，关闭后单位不受重力、碰撞等物理影响。 |
| `CollisionGroup` | `String` | - | 单位所属的碰撞预设组名称，决定默认的碰撞过滤规则。 |
| `CanCollide` | `Bool` | - | 是否启用碰撞检测，关闭后该单位将穿过其他物理对象。 |
| `Mass` | `Float` | - | 单位质量，影响碰撞反馈和受力效果，仅 Dynamic 类型有效。取值范围 [0.01, 2147483640]。 |
| `Massless` | `Bool` | - | 是否将质量视为零，启用后碰撞不会产生反作用力。 |
| `CenterOfMass` | `Vector3` | - | 相对于模型原点的质心偏移，影响旋转和受力行为。取值范围 [-50.0, 50.0]。 |
| `GravityEnabled` | `Bool` | - | 是否受全局重力影响，关闭后单位将漂浮。 |
| `UseIndividualGravity` | `Bool` | - | 是否覆盖全局重力，启用后将使用 IndividualGravityValue 指定的重力方向与大小。 |
| `IndividualGravityValue` | `Vector3` | - | 自定义重力加速度向量。 |
