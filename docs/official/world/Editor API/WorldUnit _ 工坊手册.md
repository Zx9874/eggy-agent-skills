# WorldUnit

物理组件。可通过 World:CreateUnit("WorldUnit", {...}) 创建，字段属性可直接读写。

## 概览

WorldUnit是一种3D空间的物理组件，同时带有碰撞与渲染表现

> 继承自 `SpaceUnit`；可通过 `World:CreateUnit("WorldUnit", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `RenderMeshId` | `String` | - | 模型资源ID |
| `ModelBindParent` | `Bool` | - | 启用后，当父节点为 WorldUnit、RenderUnit、TriggerUnit、PhysicsUnit 等支持父子带动的场景单位时，当前单位将整体跟随父节点运动，保持与父节点的相对位置和旋转。运行时可通过脚本设置 .ModelBindParent = true/false 动态切换该行为。 |
| `TransparentRenderBias` | `Int` | - | 控制半透明物体的渲染层级偏置，值越小越先渲染。仅影响半透明物体，不透明物体不受此偏置影响。取值范围 [-15, 16]，超出会被截断到边界。注意：仅当遮挡规则(OcclusionType)为 组件半透明/镜头前推/玩家虚影 时生效；为 不处理 时本偏置不生效 |
| `PhysicsMeshId` | `String` | - | 物理网格资源ID。缺省时，若初始创建时传入了 RenderMeshId，则默认使用该 RenderMeshId 作为物理资源；后续修改 .RenderMeshId 不会影响 PhysicsMeshId |
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
| `Liftable` | `Bool` | - | 玩家角色是否可以抓举此物体，仅对动态(Dynamic)物体生效 |
| `UseCustomThrownAngle` | `Bool` | - | 启用后使用自定义的投掷角度替代默认投掷角度 |
| `CustomThrownAngle` | `Float` | - | 自定义的投掷角度，正值向上抛，负值向下抛 |
| `UseCustomThrownForce` | `Bool` | - | 启用后使用自定义的投掷力替代默认投掷力 |
| `CustomThrownForce` | `Float` | - | 自定义的投掷力度 |
| `CanQuery` | `Bool` | - | 是否参与空间射线检测（Raycast、Spherecast 等），关闭后射线将穿透此物体 |
