# WorldUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
    - [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html)（23 属性 / 9 函数）
      * **[WorldUnit]**（29 属性 / 15 函数 / 6 事件）
        + [AnimatedUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimatedUnit.html)（3 函数）
        + [SpawnLocationUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpawnLocationUnit.html)（8 属性）

### 继承成员

3 个来源 / 30 属性 / 43 函数 / 6 事件

* 来自 [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html)（23 属性 / 9 函数）
  + 属性：[`CFrame`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`PivotOffset`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`Position`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`Rotation`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`Scale`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`Size`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`ModelAlpha`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`ModelVisible`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`CastShadow`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`ModelColor1`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`ModelColor2`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`ModelColor3`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`ModelColor4`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`SkinId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`UseCustomAppearance`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`CustomAppearanceId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`OcclusionType`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`AssemblyRootPriority`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`AssemblyLinearVelocity`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`AssemblyAngularVelocity`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`AssemblyMass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`AssemblyCenterOfMass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)、[`IsStaticOptimization`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#properties)
  + 函数：[`IsNetworkOwnerSide`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#functions)、[`GetNetworkOwner`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#functions)、[`SetNetworkOwner`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#functions)、[`IsWeldConstraintRoot`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#functions)、[`IsWeldConstraintChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#functions)、[`GetWeldConstraintRootId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#functions)、[`GetWeldConstraintId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#functions)、[`GetConnectedUnits`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#functions)、[`SyncRenderToPhysics`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html#functions)
* 来自 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
  + 属性：[`Tags`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`EcaPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`Owner`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)
  + 函数：[`HasTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`AddTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`RemoveTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`GetPivot`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`PivotTo`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`ApplyPivotDelta`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`TranslateBy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`IsTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`FindTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 是场景中可同时承担物理模拟与渲染表现的三维实体，既可通过物理网格参与碰撞、受力与冲量计算，也能以渲染网格呈现在世界中。它提供了丰富的物理控制能力，包括设置物体类型、质量、重力、阻尼、速度等属性，以及施加力、冲量、力矩和查询指定位置速度的方法，还支持碰撞组、碰撞事件、抓举与投掷等玩法相关行为。

## 适用场景

适用于实现可交互的动态场景物体，例如可被推动的箱子、可被投掷的道具、触发器或机关部件，以及需要自定义物理行为的静态或动态实体。

## 使用要点

通过 game:CreateUnit("WorldUnit", config) 或 World:CreateUnit("WorldUnit", config) 创建实例，先配置 RenderMeshId 与 PhysicsMeshId 获得可见且可碰撞的实体，再按需设置 BodyType 为 Enums.BodyType.Dynamic 并启用 PhysicsActive。物理交互可通过 ApplyForceToCenterOfMass、ApplyImpulse 等函数驱动，用 AddCollisionWithGroup 管理碰撞组，并监听 OnCollisionEnter 等事件响应碰撞。

## 注意事项

施加力、冲量或力矩前，应把 BodyType 设为 Enums.BodyType.Dynamic 并启用 PhysicsActive；需要可见且可碰撞的实体时，同时设置有效的 RenderMeshId 与 PhysicsMeshId。

## 代码示例

### 创建可见的动态物理单位

```lua
-- @runtime client
local world = game:GetService("World")
local unit = world:CreateUnit("WorldUnit", {
    Name = "DynamicCrate",
    RenderMeshId = "official://mesh/59268",
    PhysicsMeshId = "official://mesh/59268",
    Position = Vector3.New(0, 3, 0),
    BodyType = Enums.BodyType.Dynamic,
    PhysicsActive = true,
})
unit:ApplyImpulse(Vector3.New(0, 80, 0))
```

## 属性 (29)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `RenderMeshId` | `String` | `official://mesh/59268` | 用于渲染显示的网格资源 ID。 |
| `LocalTransparencyModifier` | `Float` | `1` | 本地透明度乘数，影响渲染透明度。 |
| `ModelBindParent` | `Bool` | `false` | ModelBindParent 属性用于控制当前 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 是否跟随其父节点。当设置为 true 时，单位会跟随父节点的移动和旋转，适用于将挂件、装饰物等绑定到角色或载具上的场景。 |
| `TransparentRenderBias` | `Int` | `0` | 控制半透明物体的渲染层级偏置，值越小越先渲染。仅影响半透明物体，不透明物体不受此偏置影响。取值范围 [-15, 16]，超出会被截断到边界。注意：仅当遮挡规则(OcclusionType)为 组件半透明/镜头前推/玩家虚影 时生效；为 不处理 时本偏置不生效 |
| `PhysicsMeshId` | `String` | `official://mesh/59268` | 物理网格资源ID。缺省时，若初始创建时传入了 RenderMeshId，则默认使用该 RenderMeshId 作为物理资源；后续修改 .RenderMeshId 不会影响 PhysicsMeshId |
| `BodyType` | `Int` | `Enums.BodyType.Dynamic` | 物体的物理类型，决定其运动方式。 |
| `PhysicsActive` | `Bool` | `true` | 是否启用物理模拟。 |
| `CollisionGroup` | `String` | `""` | 物体所属的碰撞组名称。 |
| `CanCollide` | `Bool` | `true` | 是否参与物理碰撞。 |
| `CanTouch` | `Bool` | `true` | 是否允许其他 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 触发本物体的碰撞事件。 |
| `CanTrigger` | `Bool` | `true` | 本物体能否触发其他 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 的碰撞事件。 |
| `Mass` | `Float` | `10` | 物体的质量。 |
| `Massless` | `Bool` | `false` | 是否视为无质量物体。 |
| `CustomPhysicalProperties` | [PhysicalProperties](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PhysicalProperties.html) | `-` | 自定义物理材质属性，覆盖默认物理参数。 |
| `CenterOfMass` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | 质心，表示 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 的质心在局部坐标系中的偏移位置。 |
| `GravityEnabled` | `Bool` | `true` | 是否启用重力。 |
| `UseIndividualGravity` | `Bool` | `false` | 是否使用自定义重力值。 |
| `IndividualGravityValue` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, -9.8, 0]` | 自定义重力值，当 UseIndividualGravity 为 true 时，[WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 将使用此重力值而非全局重力。 |
| `LinearDamping` | `Float` | `0` | 线速度的阻尼系数，值越大减速越快，仅对动态(Dynamic)物体生效 |
| `AngularDamping` | `Float` | `0` | 角速度的阻尼系数，值越大旋转减速越快，仅对动态(Dynamic)物体生效 |
| `AngularVelocity` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | 角速度，表示 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 绕各轴旋转的速度。 |
| `LinearVelocity` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | 线速度，表示 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 沿各轴移动的速度。 |
| `Climbable` | `Bool` | `false` | 是否可被角色攀爬。 |
| `Liftable` | `Bool` | `false` | 是否可被角色抓举。 |
| `UseCustomThrownAngle` | `Bool` | `false` | 是否使用自定义投掷角度。 |
| `CustomThrownAngle` | `Float` | `45.0` | 自定义投掷角度，仅在 UseCustomThrownAngle 为 true 时生效。 |
| `UseCustomThrownForce` | `Bool` | `false` | 是否使用自定义投掷力。 |
| `CustomThrownForce` | `Float` | `150.0` | 自定义投掷力大小，仅在 UseCustomThrownForce 为 true 时生效。 |
| `CanQuery` | `Bool` | `true` | 是否允许被射线检测查询到。 |

## 关联类型

* [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html)
* [PhysicalProperties](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PhysicalProperties.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 事件 (6)

### OnCollisionEnter

签名：`OnCollisionEnter(otherUnit: Unit)` 触发：`local`

当该世界单位与其他单位开始发生碰撞时触发。触发时会将发生碰撞的另一个单位实例作为参数传递给监听回调，便于实现碰撞相关的交互逻辑。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `otherUnit` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 与之发生碰撞的另一个物体 |

> 示例代码

> 监听编辑器动态物体开始碰撞

```lua
-- @runtime client
local unit = game:GetService("World"):FindFirstChild("DynamicCrate", true)
if unit == nil or not unit:IsA("WorldUnit") then return end
unit.OnCollisionEnter:Once(function(otherUnit)
    print("开始碰撞:", otherUnit.Name)
end)
```

### OnCollisionExit

签名：`OnCollisionExit(otherUnit: Unit)` 触发：`local`

当该世界单位与其他单位结束碰撞时触发。触发时会将结束碰撞的另一个单位实例作为参数传递给监听回调，便于在接触结束时执行相应的逻辑。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `otherUnit` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 结束碰撞的另一个物体 |

> 示例代码

> 监听编辑器动态物体结束碰撞

```lua
-- @runtime client
local unit = game:GetService("World"):FindFirstChild("DynamicCrate", true)
if unit == nil or not unit:IsA("WorldUnit") then return end
unit.OnCollisionExit:Once(function(otherUnit)
    print("结束碰撞:", otherUnit.Name)
end)
```

### OnLocalCollisionEnter

签名：`OnLocalCollisionEnter(info: CollisionCallbackInfo)` 触发：`local`

[WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 的本地碰撞开始事件。当该单位在本地产生碰撞接触时触发，回调参数携带碰撞信息。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `info` | [CollisionCallbackInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CollisionCallbackInfo.html) | 碰撞回调信息 |

> 示例代码

> 监听 WorldUnit.OnLocalCollisionEnter 事件的示例。

```lua
-- @runtime client
local worldUnit = game:CreateUnit("WorldUnit", {})
worldUnit.OnLocalCollisionEnter:Once(function(info)
    print("info: " .. tostring(info))
end)
```

### OnLocalCollisionExit

签名：`OnLocalCollisionExit(info: CollisionCallbackInfo)` 触发：`local`

[WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 的本地碰撞结束事件。当该单位在本地与另一对象的碰撞接触结束时触发，回调参数携带碰撞信息。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `info` | [CollisionCallbackInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CollisionCallbackInfo.html) | 碰撞回调信息 |

> 示例代码

> 监听 WorldUnit.OnLocalCollisionExit 事件的示例。

```lua
-- @runtime client
local worldUnit = game:CreateUnit("WorldUnit", {})
worldUnit.OnLocalCollisionExit:Once(function(info)
    print("info: " .. tostring(info))
end)
```

### OnLiftedBegin

签名：`OnLiftedBegin()` 触发：`local`

当物体开始被抓起时触发。

> 示例代码

> 监听 WorldUnit.OnLiftedBegin 事件的示例。

```lua
-- @runtime client
local worldUnit = game:CreateUnit("WorldUnit", {})
worldUnit.OnLiftedBegin:Once(function()
    print("OnLiftedBegin event")
end)
```

### OnLiftedEnd

签名：`OnLiftedEnd()` 触发：`local`

当物体被放下时触发。

> 示例代码

> 监听 WorldUnit.OnLiftedEnd 事件的示例。

```lua
-- @runtime client
local worldUnit = game:CreateUnit("WorldUnit", {})
worldUnit.OnLiftedEnd:Once(function()
    print("OnLiftedEnd event")
end)
```

## 函数 (15)

### AddCollisionWithGroup

签名：`AddCollisionWithGroup(groupName: String) -> void`

添加一个允许与当前 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 发生碰撞的碰撞组。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `groupName` | `String` | 要加入的碰撞组名称 |

**返回值** `void`

> 示例代码

> 注册并添加允许碰撞的组

```lua
-- @runtime server
local physicsService = game:GetService("PhysicsService")
local groupName = "MyGroup"
pcall(function() physicsService:RegisterCollisionGroup(groupName) end)
local unit = game:CreateUnit("WorldUnit", {})
unit:AddCollisionWithGroup(groupName)
```

### RemoveCollisionWithGroup

签名：`RemoveCollisionWithGroup(groupName: String) -> void`

从当前 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 的允许碰撞列表中移除指定碰撞组。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `groupName` | `String` | 要移除的碰撞组名称 |

**返回值** `void`

> 示例代码

> 移除已添加的碰撞组

```lua
-- @runtime server
local physicsService = game:GetService("PhysicsService")
local groupName = "TemporaryGroup"
pcall(function() physicsService:RegisterCollisionGroup(groupName) end)
local unit = game:CreateUnit("WorldUnit", {})
unit:AddCollisionWithGroup(groupName)
unit:RemoveCollisionWithGroup(groupName)
```

### GetCollisionWithGroups

签名：`GetCollisionWithGroups() -> Array<String>`

获取当前 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 允许发生碰撞的碰撞组名称列表。

**返回值** `Array<String>`

> 示例代码

> 读取允许碰撞的组

```lua
-- @runtime client
local unit = game:CreateUnit("WorldUnit", {})
for _, groupName in ipairs(unit:GetCollisionWithGroups()) do
    print("允许碰撞组:", groupName)
end
```

### ApplyForceToCenterOfMass

签名：`ApplyForceToCenterOfMass(force: Vector3) -> void`

在质心施加力，力直接作用于 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 的质心。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `force` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界空间中的力向量 |

**返回值** `void`

> 示例代码

> 给动态单位的质心施加向上的力

```lua
-- @runtime client
local unit = game:CreateUnit("WorldUnit", { BodyType = Enums.BodyType.Dynamic, PhysicsActive = true })
unit:ApplyForceToCenterOfMass(Vector3.New(0, 200, 0))
```

### ApplyForceAtLocalPosition

签名：`ApplyForceAtLocalPosition(force: Vector3, localPosition: Vector3) -> void`

在局部坐标位置施加力，力作用于 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 上指定的局部坐标点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `force` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界空间中的力向量 |
| `localPosition` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 物体局部空间中的施力点坐标 |

**返回值** `void`

> 示例代码

> 在动态单位的局部位置施加力

```lua
-- @runtime client
local unit = game:CreateUnit("WorldUnit", { BodyType = Enums.BodyType.Dynamic, PhysicsActive = true })
unit:ApplyForceAtLocalPosition(Vector3.New(0, 100, 0), Vector3.New(1, 0, 0))
```

### ApplyForceAtWorldPosition

签名：`ApplyForceAtWorldPosition(force: Vector3, worldPosition: Vector3) -> void`

在世界坐标位置施加力，力作用于 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 上指定的世界坐标点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `force` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界空间中的力向量 |
| `worldPosition` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界空间中的施力点坐标 |

**返回值** `void`

> 示例代码

> 在动态单位的世界位置施加力

```lua
-- @runtime client
local unit = game:CreateUnit("WorldUnit", { Position = Vector3.New(0, 5, 0), BodyType = Enums.BodyType.Dynamic, PhysicsActive = true })
unit:ApplyForceAtWorldPosition(Vector3.New(0, 0, 100), unit.Position + Vector3.New(0, 0, 1))
```

### ApplyTorque

签名：`ApplyTorque(torque: Vector3) -> void`

施加力矩，使 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 绕质心旋转。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `torque` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 各轴方向的力矩大小 |

**返回值** `void`

> 示例代码

> 给动态单位施加绕 Y 轴的力矩

```lua
-- @runtime client
local unit = game:CreateUnit("WorldUnit", { BodyType = Enums.BodyType.Dynamic, PhysicsActive = true })
unit:ApplyTorque(Vector3.New(0, 10, 0))
```

### ApplyImpulse

签名：`ApplyImpulse(impulse: Vector3) -> void`

在质心施加冲量，冲量直接作用于 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 的质心。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `impulse` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 冲量向量，方向和大小决定瞬时速度变化 |

**返回值** `void`

> 示例代码

> 给动态单位的质心施加向上冲量

```lua
-- @runtime client
local unit = game:CreateUnit("WorldUnit", { BodyType = Enums.BodyType.Dynamic, PhysicsActive = true })
unit:ApplyImpulse(Vector3.New(0, 50, 0))
```

### ApplyImpulseAtLocalPosition

签名：`ApplyImpulseAtLocalPosition(impulse: Vector3, localPosition: Vector3) -> void`

在局部坐标位置施加冲量，冲量作用于 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 上指定的局部坐标点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `impulse` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 冲量向量 |
| `localPosition` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 物体局部空间中的冲量施加点坐标 |

**返回值** `void`

> 示例代码

> 在动态单位的局部位置施加冲量

```lua
-- @runtime client
local unit = game:CreateUnit("WorldUnit", { BodyType = Enums.BodyType.Dynamic, PhysicsActive = true })
unit:ApplyImpulseAtLocalPosition(Vector3.New(0, 0, 50), Vector3.New(0, 0, 1))
```

### ApplyImpulseAtWorldPosition

签名：`ApplyImpulseAtWorldPosition(impulse: Vector3, worldPosition: Vector3) -> void`

在世界坐标位置施加冲量，冲量作用于 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 上指定的世界坐标点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `impulse` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 冲量向量 |
| `worldPosition` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界空间中的冲量施加点坐标 |

**返回值** `void`

> 示例代码

> 在动态单位的世界位置施加冲量

```lua
-- @runtime client
local unit = game:CreateUnit("WorldUnit", { Position = Vector3.New(0, 5, 0), BodyType = Enums.BodyType.Dynamic, PhysicsActive = true })
unit:ApplyImpulseAtWorldPosition(Vector3.New(50, 0, 0), unit.Position + Vector3.New(1, 0, 0))
```

### GetVelocityAtPosition

签名：`GetVelocityAtPosition(position: Vector3) -> Vector3`

获取指定世界坐标处的速度，返回该点由于刚体运动产生的线速度。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 要查询速度的世界空间坐标点 |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 读取动态单位指定世界位置的速度

```lua
-- @runtime client
local unit = game:CreateUnit("WorldUnit", { Position = Vector3.New(0, 5, 0), BodyType = Enums.BodyType.Dynamic, PhysicsActive = true })
unit:ApplyImpulse(Vector3.New(50, 0, 0))
local velocity = unit:GetVelocityAtPosition(unit.Position + Vector3.New(1, 0, 0))
print("指定位置速度:", velocity)
```

### AddNoCollisionPairWithUnit

签名：`AddNoCollisionPairWithUnit(targetUnit: SpaceUnit) -> void`

添加不碰撞单位对，使当前 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 与指定单位之间不发生碰撞。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `targetUnit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 要互不碰撞的目标单位 |

**返回值** `void`

> 示例代码

> 与另一个空间单位禁用碰撞

```lua
-- @runtime client
local world = game:GetService("World")
local worldUnit = world:CreateUnit("WorldUnit", { Position = Vector3.New(0, 2, 0) })
local targetUnit = world:CreateUnit("WorldUnit", { Position = Vector3.New(2, 2, 0) })

worldUnit:AddNoCollisionPairWithUnit(targetUnit)
print("已添加互不碰撞目标:", targetUnit.Name)
```

### RemoveNoCollisionPairWithUnit

签名：`RemoveNoCollisionPairWithUnit(targetUnit: SpaceUnit) -> void`

移除不碰撞单位对，恢复当前 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 与指定单位之间的碰撞响应。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `targetUnit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 要恢复碰撞的目标单位 |

**返回值** `void`

> 示例代码

> 恢复与另一个空间单位碰撞

```lua
-- @runtime client
local world = game:GetService("World")
local worldUnit = world:CreateUnit("WorldUnit", { Position = Vector3.New(0, 2, 0) })
local targetUnit = world:CreateUnit("WorldUnit", { Position = Vector3.New(2, 2, 0) })

worldUnit:AddNoCollisionPairWithUnit(targetUnit)
worldUnit:RemoveNoCollisionPairWithUnit(targetUnit)
print("已恢复与目标单位的碰撞:", targetUnit.Name)
```

### RemoveAllNoCollisionPairWithUnit

签名：`RemoveAllNoCollisionPairWithUnit() -> void`

移除本物体与所有其他 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 的不碰撞关系。

**返回值** `void`

> 示例代码

> 调用 WorldUnit:RemoveAllNoCollisionPairWithUnit 的示例。

```lua
-- @runtime client
local worldUnit = game:CreateUnit("WorldUnit", {})
worldUnit:RemoveAllNoCollisionPairWithUnit()
print("调用完成", worldUnit)
```

### GetNoCollisionPairUnitList

签名：`GetNoCollisionPairUnitList() -> Array&lt;SpaceUnit&gt;`

获取与当前 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 设置了不碰撞关系的所有单位列表。

**返回值** Array<[SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)>

> 示例代码

> 调用 WorldUnit:GetNoCollisionPairUnitList 的示例。

```lua
-- @runtime client
local worldUnit = game:CreateUnit("WorldUnit", {})
local result = worldUnit:GetNoCollisionPairUnitList()  -- 返回 Array
if result ~= nil then
    for index, item in ipairs(result) do
        print(index, item)
    end
end
```
