# SpawnLocationUnit

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
        + **[SpawnLocationUnit]**（8 属性）

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

出生点单元用于定义玩家在场景中的初始生成位置与所属阵营。通过设置阵营编号、预设蛋仔外观和容纳上限，可以控制不同队伍的出生区域与角色外观。它还支持范围出生模式，允许玩家在指定区域内随机分布。

## 适用场景

在多人对战地图中，为红蓝双方分别放置出生点，并指定不同的阵营 ID 和预设蛋仔外观，使玩家加入对应阵营后自动在己方出生点生成。

## 使用要点

使用 game:CreateUnit("SpawnLocationUnit", config) 创建出生点实例，然后设置 CampId 指定阵营、EggyPrefabId 指定预设蛋仔、Capacity 设置容纳上限。若需范围出生，可将 RangeBirth 设为 true。

## 注意事项

Capacity 表示公开契约中的容纳上限；具体超容量分配策略未在 Meta 中声明，不应在脚本中依赖某种固定行为。若编辑器属性面板中不易定位 Capacity，可在脚本中通过 spawnUnit.Capacity 直接读取或设置。

## 代码示例

### 创建指定阵营的出生点

```lua
-- @runtime server
local world = game:GetService("World")

local spawn = world:CreateUnit("SpawnLocationUnit", {
    Name = "Team1Spawn",
    CampId = 1,
    Capacity = 4,
    EggyPrefabId = "official://preset/1",
    InheritPrefabAppearance = true,
    Position = Vector3.New(0, 2, 0),
})

print("出生点阵营:", spawn.CampId, "容量:", spawn.Capacity)
```

## 属性 (8)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `CampId` | `Int` | `1` | 出生点所属的阵营 ID。 |
| `EggyPrefabId` | `String` | `official://preset/1` | 预设蛋仔的资源 ID，用于指定在该出生点生成的蛋仔外观。 |
| `InheritPrefabAppearance` | `Bool` | `false` | 是否继承预设蛋仔的外观。 |
| `Capacity` | `Int` | `1` | 出生点可容纳的玩家数量上限。 |
| `RenderMeshId` | `String` | `-` | 出生点渲染网格的资源 ID。 |
| `SkinId` | `String` | `""` | 出生点使用的皮肤资源 ID。 |
| `Owner` | `Int` | `-3` | 出生点所属的玩家 ID。 |
| `RangeBirth` | `Bool` | `-` | 控制玩家是否在出生点指定范围内随机出生。 |

## 关联类型

* [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)
