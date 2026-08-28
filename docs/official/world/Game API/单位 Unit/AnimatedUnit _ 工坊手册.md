# AnimatedUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
    - [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html)（23 属性 / 9 函数）
      * [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)（29 属性 / 15 函数 / 6 事件）
        + **[AnimatedUnit]**（3 函数）

### 继承成员

4 个来源 / 59 属性 / 58 函数 / 12 事件

* 来自 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)（29 属性 / 15 函数 / 6 事件）
  + 属性：[`RenderMeshId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`LocalTransparencyModifier`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`ModelBindParent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`TransparentRenderBias`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`PhysicsMeshId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`BodyType`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`PhysicsActive`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`CollisionGroup`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`CanCollide`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`CanTouch`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`CanTrigger`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`Mass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`Massless`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`CustomPhysicalProperties`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`CenterOfMass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`GravityEnabled`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`UseIndividualGravity`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`IndividualGravityValue`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`LinearDamping`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`AngularDamping`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`AngularVelocity`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`LinearVelocity`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`Climbable`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`Liftable`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`UseCustomThrownAngle`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`CustomThrownAngle`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`UseCustomThrownForce`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`CustomThrownForce`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)、[`CanQuery`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#properties)
  + 函数：[`AddCollisionWithGroup`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`RemoveCollisionWithGroup`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`GetCollisionWithGroups`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`ApplyForceToCenterOfMass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`ApplyForceAtLocalPosition`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`ApplyForceAtWorldPosition`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`ApplyTorque`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`ApplyImpulse`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`ApplyImpulseAtLocalPosition`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`ApplyImpulseAtWorldPosition`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`GetVelocityAtPosition`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`AddNoCollisionPairWithUnit`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`RemoveNoCollisionPairWithUnit`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`RemoveAllNoCollisionPairWithUnit`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)、[`GetNoCollisionPairUnitList`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#functions)
  + 事件：[`OnCollisionEnter`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#events)、[`OnCollisionExit`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#events)、[`OnLocalCollisionEnter`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#events)、[`OnLocalCollisionExit`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#events)、[`OnLiftedBegin`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#events)、[`OnLiftedEnd`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html#events)
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

[AnimatedUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimatedUnit.html) 是可播放模型内置动画片段的场景单位，适合机关、装饰物等非角色对象；类型本身属于 common，动画播放/停止接口按函数契约在服务端调用，状态查询可用于读取当前播放状态。

## 适用场景

用于在场景中放置带动画片段的机关门、装饰物或模型道具，由服务端触发播放/停止，并在需要时读取动画状态。

## 使用要点

先在编辑器或资源流程中准备带模型动画片段的 [AnimatedUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimatedUnit.html)，再由服务端通过 World:FindFirstChild 获取实例并调用 PlayAnimation/StopAnimation；GetAnimationState 用于读取当前动画状态。

## 注意事项

[AnimatedUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimatedUnit.html) 只对模型资源内部真实存在的动画片段生效。当前官方预设资源列表没有可直接用于作者验证的 [AnimatedUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimatedUnit.html)，普通“带动画外观”的预设也可能仍是 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)；在编辑器/资源流程提供可用实例前，不应使用虚构的 official://mesh ID 作为可运行示例。角色动画通常应走 [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html)/[HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 上的 [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html)。PlayAnimation 和 StopAnimation 仅服务端可调用。

## 代码示例

### 服务端播放模型动画并读取状态

```lua
-- @runtime server
local World = game:GetService("World")
local animatedUnit = World:FindFirstChild("MyAnimatedUnit", true)
if animatedUnit == nil or not animatedUnit:IsA("AnimatedUnit") then
    print("请先在编辑器或资源流程中准备带动画片段的 AnimatedUnit")
    return
end

animatedUnit:PlayAnimation("idle", { looped = true, speed = 1.0 })
local state = animatedUnit:GetAnimationState()
if state ~= nil then
    print("动画状态:", state)
end

animatedUnit:StopAnimation()
```

## 关联类型

* [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)

## 函数 (3)

### PlayAnimation

签名：`PlayAnimation(animName: String, params: Map) -> void`

在服务端播放 [AnimatedUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimatedUnit.html) 上指定名称的模型动画，并可通过参数表控制播放行为。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `animName` | `String` | 动画名称 |
| `params` | `Map` | 播放参数 { startTime, looped, speed } |

**返回值** `void`

> 示例代码

> 服务端播放模型自带动画片段

```lua
-- @runtime server
-- 【服务端】AnimatedUnit 用于播放模型自身携带的动画片段
local World = game:GetService("World")
local animatedUnit = World:FindFirstChild("MyAnimatedUnit", true)
if animatedUnit == nil or not animatedUnit:IsA("AnimatedUnit") then return end

-- animName 必须是该模型资源内存在的动画片段名
animatedUnit:PlayAnimation("idle", {
    startTime = 0,
    looped = true,
    speed = 1.0,
})
```

### StopAnimation

签名：`StopAnimation() -> void`

停止当前正在播放的模型动画。

**返回值** `void`

> 示例代码

> 停止 AnimatedUnit 当前动画

```lua
-- @runtime server
-- 【服务端】停止模型当前播放的动画
local World = game:GetService("World")
local animatedUnit = World:FindFirstChild("MyAnimatedUnit", true)
if animatedUnit == nil or not animatedUnit:IsA("AnimatedUnit") then return end
animatedUnit:PlayAnimation("idle", { looped = true, speed = 1.0 })
animatedUnit:StopAnimation()
```

### GetAnimationState

签名：`GetAnimationState() -> Map (动画状态 &#123; animName, startTime, looped, speed, isPlaying, playToken, serverTime &#125;)`

获取当前动画的播放状态信息，返回一个包含动画名称、开始时间、是否循环、播放速度、是否正在播放、播放令牌和服务器时间的映射表。

**返回值** `Map` (动画状态 { animName, startTime, looped, speed, isPlaying, playToken, serverTime })

> 示例代码

> 读取 AnimatedUnit 动画状态

```lua
-- @runtime server
local World = game:GetService("World")
local animatedUnit = World:FindFirstChild("MyAnimatedUnit", true)
if animatedUnit == nil or not animatedUnit:IsA("AnimatedUnit") then return end
local state = animatedUnit:GetAnimationState()
if state ~= nil then
    print("动画状态:", state)
end
```
