# TriggerUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
    - [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html)（23 属性 / 9 函数）
      * **[TriggerUnit]**（8 属性 / 7 函数 / 4 事件）
        + [RenderTriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderTriggerUnit.html)（16 属性）

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

[TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html)是场景中的触发区域单位，专门用于检测其他单位的进入与离开。它允许通过碰撞组白名单或指定单位黑名单来精确控制哪些对象可以触发事件，并提供物理网格、显示模型、碰撞组等配置项。当检测到单位进入或离开时，会触发相应的本地事件，供逻辑脚本响应。

## 适用场景

在关卡中放置一个[TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html)作为区域触发器，当玩家或特定单位进入该区域时启动剧情、开启机关或记录数据；也可用作拾取范围提示，配合其他单位实现交互。

## 使用要点

通过 World:CreateUnit("TriggerUnit", config) 创建，并在 config 中为 PhysicsMeshId 传入 String 类型的有效资源 URI，为 Scale、Position 传入 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。随后监听 OnTriggerEnter/OnTriggerExit 或本地对应事件；需要过滤时，使用 AddCollisionWithGroup 添加允许触发的碰撞组，或用 AddNoCollisionPairWithUnit 排除指定 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)。

## 注意事项

触发过滤分两类：AddCollisionWithGroup/RemoveCollisionWithGroup 操作碰撞组名称，是允许触发的白名单；AddNoCollisionPairWithUnit/RemoveNoCollisionPairWithUnit 操作具体 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 实例，是排除指定单位的黑名单。两类 API 不要混用，碰撞组传字符串，单位配对传 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)。

## 代码示例

### 创建触发区域并监听进入事件

```lua
-- @runtime client
local world = game:GetService("World")

local trigger = world:CreateUnit("TriggerUnit", {
    Name = "CheckpointTrigger",
    Position = Vector3.New(0, 5, 0),
    Scale = Vector3.New(3, 2, 1),
    CollisionGroup = "Trigger",
    CanTouch = true,
})
trigger:AddCollisionWithGroup("Player")

trigger.OnTriggerEnter:Once(function(otherUnit)
    print("进入触发区:", otherUnit.Name)
end)
```

## 属性 (8)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `CFrame` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | `[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0]` | 触发器单位的空间变换信息，包含位置与旋转，用于表示触发器单位在场景中的摆放位置与朝向。 |
| `Scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[1.0, 1.0, 1.0]` | [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html) 的缩放比例。 |
| `PhysicsMeshId` | `String` | `official://mesh/59268` | [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html) 用于物理碰撞检测的网格资源 ID。 |
| `DisplayModelId` | `String` | `official://mesh/59268` | [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html) 在编辑器中显示的预览模型资源 ID。 |
| `PhysicsActive` | `Bool` | `true` | 控制 [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html) 的物理模拟是否激活。 |
| `ModelBindParent` | `Bool` | `false` | 启用后，当父节点为 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)、[RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html)、[TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html)、[PhysicsUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PhysicsUnit.html) 等支持父子带动的场景单位时，当前单位将整体跟随父节点运动，保持与父节点的相对位置和旋转。运行时可通过脚本设置 .ModelBindParent = true/false 动态切换该行为。 |
| `CollisionGroup` | `String` | `""` | [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html) 所属的碰撞组名称。 |
| `CanTouch` | `Bool` | `true` | 控制 [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html) 是否能被其他单位触发碰撞事件。 |

## 关联类型

* [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html)
* [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 事件 (4)

### OnTriggerEnter

签名：`OnTriggerEnter(otherUnit: Unit)` 触发：`local`

当其他单位进入触发器单位的触发区域时触发的事件，回调参数 otherUnit 为进入触发区域的单位实例。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `otherUnit` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | - |

> 示例代码

> 监听单位进入触发区域

```lua
-- @runtime client
local world = game:GetService("World")
local trigger = world:CreateUnit("TriggerUnit", {
    Scale = Vector3.New(2, 2, 2),
    CFrame = CFrame.New(0, 3, 0),
})
trigger.OnTriggerEnter:Once(function(otherUnit)
    print("检测到单位进入触发区域:", otherUnit.Name)
end)
```

### OnTriggerExit

签名：`OnTriggerExit(otherUnit: Unit)` 触发：`local`

当其他单位离开触发器单位的触发区域时触发的事件，回调参数 otherUnit 为离开触发区域的单位实例。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `otherUnit` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | - |

> 示例代码

> 监听单位离开触发区域

```lua
-- @runtime client
local world = game:GetService("World")
local trigger = world:CreateUnit("TriggerUnit", {
    Scale = Vector3.New(2, 2, 2),
    CFrame = CFrame.New(0, 3, 0),
})
trigger.OnTriggerExit:Once(function(otherUnit)
    print("检测到单位离开触发区域:", otherUnit.Name)
end)
```

### OnLocalTriggerEnter

签名：`OnLocalTriggerEnter(info: TriggerCallbackInfo)` 触发：`local`

当本地单位进入触发区域时触发的事件。回调函数接收一个 [TriggerCallbackInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TriggerCallbackInfo.html) 类型的参数 info，可通过 info.OtherUnit 属性获取进入触发区域的单位。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `info` | [TriggerCallbackInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TriggerCallbackInfo.html) | 触发回调信息 |

> 示例代码

> 基础监听本地单位进入

```lua
-- @runtime client
local trigger = game:CreateUnit("TriggerUnit", {
    CFrame = CFrame.New(0, 5, 0),
    Scale = Vector3.New(4, 4, 4),
    CanTouch = true,
})

-- 当本地单位进入触发器范围时，触发该回调
trigger.OnLocalTriggerEnter:Once(function(info)
    print("有本地单位进入了触发区域")
end)
```

### OnLocalTriggerExit

签名：`OnLocalTriggerExit(info: TriggerCallbackInfo)` 触发：`local`

当本地单位离开触发区域时触发的事件。回调函数接收一个 [TriggerCallbackInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TriggerCallbackInfo.html) 类型的参数 info，可通过 info.OtherUnit 属性获取离开触发区域的单位。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `info` | [TriggerCallbackInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TriggerCallbackInfo.html) | 触发回调信息 |

> 示例代码

> 基础监听本地单位离开

```lua
-- @runtime client
local trigger = game:CreateUnit("TriggerUnit", {
    CFrame = CFrame.New(0, 3, 0),
    Scale = Vector3.New(3, 3, 3),
})

-- 当本地单位离开触发器范围时，触发该回调
trigger.OnLocalTriggerExit:Once(function(info)
    print("有本地单位离开了触发区域")
end)
```

## 函数 (7)

### AddCollisionWithGroup

签名：`AddCollisionWithGroup(groupName: String) -> void`

把指定碰撞组加入当前触发器的允许触发白名单。

⚙ 白名单语义：每次调用累加碰撞组到允许列表，而非替换。触发器仅与已添加的碰撞组中的单位发生碰撞交互。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `groupName` | `String` | 要加入的碰撞组名称 |

**返回值** `void`

> 示例代码

> 允许指定碰撞组触发

```lua
-- @runtime client
local World = game:GetService("World")
local trigger = World:CreateUnit("TriggerUnit", { CollisionGroup = "Trigger" })
trigger:AddCollisionWithGroup("Player")
print("允许碰撞组:", table.concat(trigger:GetCollisionWithGroups(), ","))
```

### RemoveCollisionWithGroup

签名：`RemoveCollisionWithGroup(groupName: String) -> void`

从当前触发器的允许触发白名单中移除指定碰撞组。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `groupName` | `String` | 要移除的碰撞组名称 |

**返回值** `void`

> 示例代码

> 移除允许触发的碰撞组

```lua
-- @runtime client
local World = game:GetService("World")
local trigger = World:CreateUnit("TriggerUnit", { CollisionGroup = "Trigger" })
trigger:AddCollisionWithGroup("Player")
trigger:RemoveCollisionWithGroup("Player")
```

### GetCollisionWithGroups

签名：`GetCollisionWithGroups() -> Array<String>`

获取当前触发器允许触发的碰撞组名称列表。

**返回值** `Array<String>`

> 示例代码

> 读取当前允许的碰撞组

```lua
-- @runtime client
local World = game:GetService("World")
local trigger = World:CreateUnit("TriggerUnit", { CollisionGroup = "Trigger" })
trigger:AddCollisionWithGroup("Player")
for _, groupName in ipairs(trigger:GetCollisionWithGroups()) do
    print("允许碰撞组:", groupName)
end
```

### AddNoCollisionPairWithUnit

签名：`AddNoCollisionPairWithUnit(targetUnit: SpaceUnit) -> void`

添加一个不碰撞的单位对，使 [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html) 与指定单位之间不发生碰撞。

⚙ 黑名单语义：针对具体 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 而非碰撞组，加入后该 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 不参与碰撞。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `targetUnit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 要互不碰撞的目标单位 |

**返回值** `void`

> 示例代码

> 排除指定单位触发

```lua
-- @runtime client
local World = game:GetService("World")
local trigger = World:CreateUnit("TriggerUnit", { CollisionGroup = "Trigger" })
local targetUnit = World:CreateUnit("WorldUnit", { Name = "IgnoredTarget" })
trigger:AddNoCollisionPairWithUnit(targetUnit)
```

### RemoveNoCollisionPairWithUnit

签名：`RemoveNoCollisionPairWithUnit(targetUnit: SpaceUnit) -> void`

移除与指定单位的不碰撞关系，恢复正常的碰撞检测。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `targetUnit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 要恢复碰撞的目标单位 |

**返回值** `void`

> 示例代码

> 恢复指定单位触发

```lua
-- @runtime client
local World = game:GetService("World")
local trigger = World:CreateUnit("TriggerUnit", { CollisionGroup = "Trigger" })
local targetUnit = World:CreateUnit("WorldUnit", { Name = "IgnoredTarget" })
trigger:AddNoCollisionPairWithUnit(targetUnit)
trigger:RemoveNoCollisionPairWithUnit(targetUnit)
```

### RemoveAllNoCollisionPairWithUnit

签名：`RemoveAllNoCollisionPairWithUnit() -> void`

移除 [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html) 的所有不碰撞单位对，恢复与所有单位的正常碰撞。

**返回值** `void`

> 示例代码

> 清空所有不碰撞单位配对

```lua
-- @runtime client
local World = game:GetService("World")
local trigger = World:CreateUnit("TriggerUnit", { CollisionGroup = "Trigger" })
trigger:RemoveAllNoCollisionPairWithUnit()
```

### GetNoCollisionPairUnitList

签名：`GetNoCollisionPairUnitList() -> Array&lt;SpaceUnit&gt;`

获取与 [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html) 设置了不碰撞关系的所有单位列表。

**返回值** Array<[SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)>

> 示例代码

> 读取不碰撞单位列表

```lua
-- @runtime client
local World = game:GetService("World")
local trigger = World:CreateUnit("TriggerUnit", { CollisionGroup = "Trigger" })
local targetUnit = World:CreateUnit("WorldUnit", { Name = "IgnoredTarget" })
trigger:AddNoCollisionPairWithUnit(targetUnit)
for _, unit in ipairs(trigger:GetNoCollisionPairUnitList()) do
    print("不触发单位:", unit.Name)
end
```
