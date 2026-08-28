# HumanUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
    - **[HumanUnit]**（23 属性 / 27 函数 / 2 事件）

### 继承成员

2 个来源 / 7 属性 / 34 函数 / 6 事件

* 来自 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
  + 属性：[`Tags`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`EcaPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`Owner`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)
  + 函数：[`HasTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`AddTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`RemoveTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`GetPivot`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`PivotTo`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`ApplyPivotDelta`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`TranslateBy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`IsTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`FindTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 是场景中可创建的人形生物单位，用于构建玩家角色、NPC 等需要人形外观与物理表现的对象。它提供位置、旋转、缩放、可见性等基础变换属性，以及物理模拟（质量、重力、碰撞组、力的施加）、模型外观（渲染网格、模型颜色与纹理、附加网格）和控制器/动画（Controller、Animator）等完整能力。可通过 OnCollisionEnter 与 OnCollisionExit 事件感知本地碰撞。

## 适用场景

在创建玩家角色或任意人形 NPC 时，通常先通过 game:CreateUnit("HumanUnit", config) 或 World:CreateUnit("HumanUnit", config) 生成实例，再开启 EnableController、EnableAnimator 以启用控制器与动画器，实现角色姿态与行为控制。

## 使用要点

首先通过 game:CreateUnit("HumanUnit", config) 或 World:CreateUnit("HumanUnit", config) 获取 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 实例，随后可直接读写 Position、Rotation、Scale、Visible 等属性。若需要物理表现，设置 PhysicsActive、Mass、GravityEnabled 等属性，并调用 ApplyForceToCenterOfMass、ApplyForceAtWorldPosition 等函数施加力。外观调整可使用 AddMeshByAssetId、SetModelColor、SetModelTexture；碰撞交互则通过 AddCollisionWithGroup 配置碰撞组，并连接 OnCollisionEnter、OnCollisionExit 事件。多端联机时还可借助 SetNetworkOwner 指定网络归属。

## 注意事项

引擎使用 Y 轴向上的坐标系（重力默认 [0, -9.8, 0]）。施加向上的力应使用 Vector3.New(0,正值,0) 而非 Vector3.New(0,0,正值)。

## 代码示例

### 服务端创建人形单位并启用控制器

```lua
-- @runtime server
-- 服务端脚本：创建可控制的人形单位
local World = game:GetService("World")

local humanUnit = World:CreateUnit("HumanUnit", {
    Name = "Hero",
    Position = Vector3.New(0, 0, 0),
    EnableController = true,
})

if humanUnit.Controller ~= nil then
    humanUnit.Controller.WalkSpeed = 16
    humanUnit.Controller.JumpPower = 8
    humanUnit.Controller:Jump()
end
```

## 属性 (23)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0.0, 0.0, 0.0]` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 在世界空间中的位置，类型为 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。 |
| `Rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | `[0.0, 0.0, 0.0, 1.0]` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 当前的旋转姿态，以四元数形式表示。 |
| `Scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[1.0, 1.0, 1.0]` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的缩放比例，类型为 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。 |
| `Visible` | `Bool` | `true` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的可见性。 |
| `RenderMeshId` | `String` | `official://mesh/9000969` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的渲染模型资源标识符。 |
| `Controller` | [HumanController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanController.html) | `-` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 关联的 [HumanController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanController.html) 实例，用于控制移动、跳跃等行为。 |
| `EnableController` | `Bool` | `false` | 是否在创建 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 时自动创建 [HumanController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanController.html)。 |
| `EnableAnimator` | `Bool` | `true` | 是否在创建 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 时自动添加 Animator 组件。 |
| `EnableAnimScript` | `Bool` | `true` | 是否在创建 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 时自动添加动画脚本。 |
| `BodyType` | `Int` | `Enums.BodyType.Dynamic` | 刚体类型：Static(静态，不受力)、Kinematic(运动学，仅脚本控制移动)、Dynamic(动态，受物理模拟) |
| `PhysicsActive` | `Bool` | `true` | 是否启用 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的物理模拟。 |
| `CollisionGroup` | `String` | `Character` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 所属的碰撞组名称。 |
| `CanCollide` | `Bool` | `true` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 是否参与物理碰撞。 |
| `Mass` | `Float` | `10` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的质量。 |
| `Massless` | `Bool` | `false` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 是否视为无质量。 |
| `CenterOfMass` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的质心相对于单位原点的局部偏移，类型为 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。 |
| `RotationLocked` | `Bool` | `true` | 是否锁定 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的旋转。 |
| `GravityEnabled` | `Bool` | `true` | 是否对 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 应用重力。 |
| `UseIndividualGravity` | `Bool` | `false` | 是否使用自定义重力值。 |
| `IndividualGravityValue` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, -9.8, 0]` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的自定义重力值，类型为 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。 |
| `AngularVelocity` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的角速度，类型为 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。 |
| `LinearVelocity` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的线速度，类型为 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。 |
| `Animator` | [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html) | `-` | [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的 Animator 组件，用于控制动画播放。 |

## 关联类型

* [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)
* [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html)
* [HumanController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanController.html)
* [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 事件 (2)

### OnCollisionEnter

签名：`OnCollisionEnter(otherUnit: Unit)` 触发：`local`

当 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 与被碰撞单位开始发生碰撞时触发。回调参数 otherUnit 为当前与该 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 发生碰撞的单位实例。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `otherUnit` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 碰撞到的单位 |

> 示例代码

> 监听人形单位开始碰撞

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero", CollisionGroup = "Player" })
humanUnit.OnCollisionEnter:Once(function(otherUnit)
    print("开始碰撞:", otherUnit.Name)
end)
```

### OnCollisionExit

签名：`OnCollisionExit(otherUnit: Unit)` 触发：`local`

当 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 与被碰撞单位结束碰撞时触发。回调参数 otherUnit 为与该 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 结束碰撞的单位实例。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `otherUnit` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 结束碰撞的单位 |

> 示例代码

> 监听人形单位结束碰撞

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero", CollisionGroup = "Player" })
humanUnit.OnCollisionExit:Once(function(otherUnit)
    print("结束碰撞:", otherUnit.Name)
end)
```

## 函数 (27)

### SetNetworkOwner

签名：`SetNetworkOwner(player: Player) -> void`

设置该人形单位的网络拥有者，需要传入一个 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 类型的参数。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |

**返回值** `void`

> 示例代码

> 设置人形单位网络拥有者

```lua
-- @runtime server
local Players = game:GetService("Players")
local World = game:GetService("World")

local player = Players:GetPlayers()[1]
local humanUnit = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
if player ~= nil and humanUnit ~= nil then
    humanUnit:SetNetworkOwner(player)
end
```

### GetNetworkOwner

签名：`GetNetworkOwner() -> Player (网络拥有者；没有明确所有者时可能没有有效结果)`

获取该人形单位的网络拥有者，返回值为 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 类型。

**返回值** [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) (网络拥有者；没有明确所有者时可能没有有效结果)

> 示例代码

> 读取人形单位网络拥有者

```lua
-- @runtime server
local World = game:GetService("World")

local humanUnit = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local owner = humanUnit:GetNetworkOwner()
if owner ~= nil then
    print("网络拥有者:", owner:GetName())
end
```

### GetPosition

签名：`GetPosition() -> Vector3 (位置)`

获取 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的物理位置，返回 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) (位置)

> 示例代码

> 读取人形单位位置

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local position = humanUnit:GetPosition()
print("位置:", position)
```

### SetPosition

签名：`SetPosition(pos: Vector3) -> void`

设置 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的物理位置。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `pos` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 坐标 |

**返回值** `void`

> 示例代码

> 移动人形单位

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
humanUnit:SetPosition(Vector3.New(5, 0, 0))
```

### GetRotation

签名：`GetRotation() -> Quaternion (旋转)`

获取 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 当前的物理旋转四元数。

**返回值** [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) (旋转)

> 示例代码

> 读取人形单位旋转

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local rotation = humanUnit:GetRotation()
print("旋转:", rotation)
```

### SetRotation

签名：`SetRotation(rotation: Quaternion) -> void`

设置 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的物理旋转为指定的四元数。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | 旋转 |

**返回值** `void`

> 示例代码

> 设置人形单位旋转

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local rotation = Quaternion.FromEulerAngles(0, math.rad(90), 0)
humanUnit:SetRotation(rotation)
```

### GetScale

签名：`GetScale() -> Vector3 (缩放)`

获取 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的缩放，返回 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) (缩放)

> 示例代码

> 读取人形单位缩放

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Scale = Vector3.New(1, 1, 1) })
local scale = humanUnit:GetScale()
print("缩放:", scale)
```

### SetScale

签名：`SetScale(scale: Vector3) -> void`

设置 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的缩放。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 缩放 |

**返回值** `void`

> 示例代码

> 设置人形单位缩放

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Scale = Vector3.New(1, 1, 1) })
humanUnit:SetScale(Vector3.New(1.2, 1.2, 1.2))
```

### GetYaw

签名：`GetYaw() -> Float (Yaw朝向)`

获取 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的 Yaw 朝向角度，返回浮点数。

**返回值** `Float` (Yaw朝向)

> 示例代码

> 读取人形单位朝向角

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local yaw = humanUnit:GetYaw()
print("Yaw:", yaw)
```

### GetRenderPosition

签名：`GetRenderPosition() -> Vector3 (显示位置)`

获取 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的渲染位置，返回 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) (显示位置)

> 示例代码

> 读取人形单位渲染位置

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local renderPosition = humanUnit:GetRenderPosition()
print("渲染位置:", renderPosition)
```

### GetRenderRotation

签名：`GetRenderRotation() -> Quaternion (显示旋转)`

获取 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的显示旋转，即渲染表现所使用的旋转四元数。

**返回值** [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) (显示旋转)

> 示例代码

> 读取人形单位渲染旋转

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local renderRotation = humanUnit:GetRenderRotation()
print("渲染旋转:", renderRotation)
```

### AddCollisionWithGroup

签名：`AddCollisionWithGroup(groupName: String) -> void`

添加一个允许与当前 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 发生碰撞的碰撞组。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `groupName` | `String` | 碰撞组名 |

**返回值** `void`

> 示例代码

> 添加允许碰撞的碰撞组

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero" })
humanUnit:AddCollisionWithGroup("Prop")
```

### RemoveCollisionWithGroup

签名：`RemoveCollisionWithGroup(groupName: String) -> void`

从当前 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的允许碰撞列表中移除指定碰撞组。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `groupName` | `String` | 碰撞组名 |

**返回值** `void`

> 示例代码

> 移除允许碰撞的碰撞组

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero" })
humanUnit:AddCollisionWithGroup("Prop")
humanUnit:RemoveCollisionWithGroup("Prop")
```

### GetCollisionWithGroups

签名：`GetCollisionWithGroups() -> Array<String>`

获取当前 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 允许发生碰撞的碰撞组名称列表。

**返回值** `Array<String>`

> 示例代码

> 读取已添加的碰撞组

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero" })
humanUnit:AddCollisionWithGroup("Prop")
for _, groupName in ipairs(humanUnit:GetCollisionWithGroups()) do
    print("碰撞组:", groupName)
end
```

### ApplyForceToCenterOfMass

签名：`ApplyForceToCenterOfMass(force: Vector3) -> void`

在 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的质心施加力。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `force` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 施加的力 |

**返回值** `void`

> 示例代码

> 在质心施加向上的力

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
humanUnit:ApplyForceToCenterOfMass(Vector3.New(0, 500, 0))
```

### ApplyForceAtLocalPosition

签名：`ApplyForceAtLocalPosition(force: Vector3, localPosition: Vector3) -> void`

在 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的局部坐标位置施加力。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `force` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 施加的力 |
| `localPosition` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 局部空间坐标系下的力量的施加点 |

**返回值** `void`

> 示例代码

> 在局部位置施加力

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local force = Vector3.New(0, 300, 0)
local localPosition = Vector3.New(0, 1, 0)
humanUnit:ApplyForceAtLocalPosition(force, localPosition)
```

### ApplyForceAtWorldPosition

签名：`ApplyForceAtWorldPosition(force: Vector3, worldPosition: Vector3) -> void`

在 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的世界坐标位置施加力。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `force` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 施加的力 |
| `worldPosition` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界空间坐标系下的力量的施加点 |

**返回值** `void`

> 示例代码

> 在世界位置施加力

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local force = Vector3.New(0, 300, 0)
local worldPosition = humanUnit:GetPosition() + Vector3.New(0, 1, 0)
humanUnit:ApplyForceAtWorldPosition(force, worldPosition)
```

### AddNoCollisionPairWithUnit

签名：`AddNoCollisionPairWithUnit(targetUnit: SpaceUnit) -> void`

添加 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 与指定 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 的不碰撞对。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `targetUnit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 目标单位 |

**返回值** `void`

> 示例代码

> 让 HumanUnit 与指定单位互不碰撞

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero" })
local targetUnit = World:CreateUnit("WorldUnit", { Name = "IgnoredTarget" })
humanUnit:AddNoCollisionPairWithUnit(targetUnit)
```

### RemoveNoCollisionPairWithUnit

签名：`RemoveNoCollisionPairWithUnit(targetUnit: SpaceUnit) -> void`

移除 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 与指定 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 的不碰撞对。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `targetUnit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 目标单位 |

**返回值** `void`

> 示例代码

> 恢复 HumanUnit 与指定单位碰撞

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero" })
local targetUnit = World:CreateUnit("WorldUnit", { Name = "IgnoredTarget" })
humanUnit:AddNoCollisionPairWithUnit(targetUnit)
humanUnit:RemoveNoCollisionPairWithUnit(targetUnit)
```

### RemoveAllNoCollisionPairWithUnit

签名：`RemoveAllNoCollisionPairWithUnit() -> void`

移除 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的所有不碰撞单位对。

**返回值** `void`

> 示例代码

> 清空 HumanUnit 的不碰撞配对

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero" })
humanUnit:RemoveAllNoCollisionPairWithUnit()
```

### GetNoCollisionPairUnitList

签名：`GetNoCollisionPairUnitList() -> Array&lt;SpaceUnit&gt;`

获取与 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 不碰撞的单位列表，返回 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 数组。

**返回值** Array<[SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)>

> 示例代码

> 读取 HumanUnit 的不碰撞单位列表

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero" })
local targetUnit = World:CreateUnit("WorldUnit", { Name = "IgnoredTarget" })
humanUnit:AddNoCollisionPairWithUnit(targetUnit)
for _, unit in ipairs(humanUnit:GetNoCollisionPairUnitList()) do
    print("不碰撞单位:", unit.Name)
end
```

### AddMeshByAssetId

签名：`AddMeshByAssetId(assetId: String) -> void`

为 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 添加指定资源 ID 的人形蒙皮。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `assetId` | `String` | 蒙皮资源路径 |

**返回值** `void`

> 示例代码

> 给人形单位添加蒙皮资源

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero" })
humanUnit:AddMeshByAssetId("official://skin/10001")
```

### RemoveMeshByAssetId

签名：`RemoveMeshByAssetId(assetId: String) -> void`

移除 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 上指定资源 ID 的人形蒙皮。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `assetId` | `String` | 要移除的蒙皮资源路径 |

**返回值** `void`

> 示例代码

> 移除人形单位蒙皮资源

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero" })
local assetId = "official://skin/10001"
humanUnit:AddMeshByAssetId(assetId)
humanUnit:RemoveMeshByAssetId(assetId)
```

### SetMeshColor

签名：`SetMeshColor(assetId: String, colorKey: HumanMeshColor, color: Color, materialIndex: Int) -> void`

设置 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 上指定蒙皮资源的染色。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `assetId` | `String` | 蒙皮网格资源路径，需与AddMeshByAssetId传入的一致 |
| `colorKey` | [HumanMeshColor](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/HumanMeshColor.html) | 要设置的染色区域类型 |
| `color` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | 要设置的目标颜色 |
| `materialIndex` | `Int` | 目标材质索引 |

**返回值** `void`

> 示例代码

> 设置指定蒙皮染色区域

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero" })
local assetId = "official://skin/10001"
humanUnit:AddMeshByAssetId(assetId)
humanUnit:SetMeshColor(assetId, Enums.HumanMeshColor.COLOR1, Color.New(255, 180, 120, 255), 0)
```

### SetMeshTexture

签名：`SetMeshTexture(meshAssetId: String, textureAssetId: String, materialIndex: Int) -> void`

设置人形单位的蒙皮贴图，需要依次传入网格资源 ID、贴图资源 ID 和材质索引。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `meshAssetId` | `String` | 蒙皮网格资源路径，需与AddMeshByAssetId传入的一致 |
| `textureAssetId` | `String` | 要应用的贴图资源路径 |
| `materialIndex` | `Int` | 目标材质索引 |

**返回值** `void`

> 示例代码

> 设置指定蒙皮的材质贴图

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero" })
local meshAssetId = "official://skin/10001"
humanUnit:AddMeshByAssetId(meshAssetId)
humanUnit:SetMeshTexture(meshAssetId, "official://image/10001", 0)
```

### SetModelTexture

签名：`SetModelTexture(assetId: String, materialIndex: Int) -> void`

设置 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 本体的贴图。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `assetId` | `String` | 贴图资源路径 |
| `materialIndex` | `Int` | 目标材质索引 |

**返回值** `void`

> 示例代码

> 设置人形模型贴图

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero" })
humanUnit:SetModelTexture("official://skin/10001", 0)
```

### SetModelColor

签名：`SetModelColor(colorKey: HumanMeshColor, color: Color, materialIndex: Int) -> void`

设置 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 本体的染色。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `colorKey` | [HumanMeshColor](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/HumanMeshColor.html) | 要设置的染色区域类型 |
| `color` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | 要设置的目标颜色 |
| `materialIndex` | `Int` | 目标材质索引 |

**返回值** `void`

> 示例代码

> 设置人形模型染色

```lua
-- @runtime client
local World = game:GetService("World")
local humanUnit = World:CreateUnit("HumanUnit", { Name = "Hero" })
humanUnit:SetModelColor(Enums.HumanMeshColor.COLOR1, Color.New(255, 200, 160, 255), 0)
```
