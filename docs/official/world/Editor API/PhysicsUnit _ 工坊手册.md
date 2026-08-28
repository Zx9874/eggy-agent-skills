# PhysicsUnit

纯物理组件。需先通过 PrefabService:CreatePrefab("PhysicsUnit") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

> 继承自 `SpaceUnit`；需先通过 `PrefabService:CreatePrefab("PhysicsUnit")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `ModelBindParent` | `Bool` | - | 启用后，当父节点为 WorldUnit、RenderUnit、TriggerUnit、PhysicsUnit 等支持父子带动的场景单位时，当前单位将整体跟随父节点运动，保持与父节点的相对位置和旋转。运行时可通过脚本设置 .ModelBindParent = true/false 动态切换该行为。 |
| `PhysicsMeshId` | `String` | - | 物理资源ID |
| `BodyType` | `Int` | - | 物体的物理运动类型：静态(Static)不可修改，运动学(Kinematic)仅通过脚本逻辑驱动，动态(Dynamic)参与完整物理模拟 |
| `PhysicsActive` | `Bool` | - | 是否启用物理模拟，关闭后物体不参与碰撞和物理计算 |
| `CollisionGroup` | `String` | - | 物体所属的碰撞组名称，用于按碰撞组规则过滤碰撞关系 |
| `CanCollide` | `Bool` | - | 是否参与物理碰撞，关闭后物体将穿透其他物体 |
| `CanTouch` | `Bool` | - | 其他物体碰到此物体时，是否触发此物体的碰撞事件 |
| `CanTrigger` | `Bool` | - | 此物体碰到其他物体时，是否触发对方的碰撞事件 |
| `Mass` | `Float` | - | 物体的质量，仅对动态(Dynamic)物体生效 |
| `Massless` | `Bool` | - | 启用后此物体的质量不计入父级装配体的总质量 |
| `CustomPhysicalProperties` | `PhysicalProperties` | - | 自定义物理材质参数（摩擦力、弹性、密度等），为空时使用默认值 |
| `CenterOfMass` | `Vector3` | - | 物体在局部空间中的质心偏移位置 |
| `GravityEnabled` | `Bool` | - | 是否受重力影响，仅对动态(Dynamic)物体生效 |
| `UseIndividualGravity` | `Bool` | - | 启用后使用自定义的重力方向和大小替代全局重力 |
| `IndividualGravityValue` | `Vector3` | - | 自定义重力的方向和大小，默认为 (0, -9.8, 0) |
| `LinearDamping` | `Float` | - | 线速度的阻尼系数，值越大减速越快，仅对动态(Dynamic)物体生效 |
| `AngularDamping` | `Float` | - | 角速度的阻尼系数，值越大旋转减速越快，仅对动态(Dynamic)物体生效 |
| `Climbable` | `Bool` | - | 玩家角色是否可以攀爬此物体，仅对静态(Static)物体生效 |
| `CanQuery` | `Bool` | - | 是否参与空间射线检测（Raycast、Spherecast 等），关闭后射线将穿透此物体 |
