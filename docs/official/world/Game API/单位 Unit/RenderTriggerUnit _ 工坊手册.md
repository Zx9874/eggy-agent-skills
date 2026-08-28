# RenderTriggerUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
    - [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html)（23 属性 / 9 函数）
      * [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html)（8 属性 / 7 函数 / 4 事件）
        + **[RenderTriggerUnit]**（16 属性）

### 继承成员

4 个来源 / 38 属性 / 50 函数 / 10 事件

* 来自 [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html)（8 属性 / 7 函数 / 4 事件）
  + 属性：[`CFrame`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#properties)、[`Scale`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#properties)、[`PhysicsMeshId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#properties)、[`DisplayModelId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#properties)、[`PhysicsActive`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#properties)、[`ModelBindParent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#properties)、[`CollisionGroup`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#properties)、[`CanTouch`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#properties)
  + 函数：[`AddCollisionWithGroup`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#functions)、[`RemoveCollisionWithGroup`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#functions)、[`GetCollisionWithGroups`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#functions)、[`AddNoCollisionPairWithUnit`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#functions)、[`RemoveNoCollisionPairWithUnit`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#functions)、[`RemoveAllNoCollisionPairWithUnit`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#functions)、[`GetNoCollisionPairUnitList`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#functions)
  + 事件：[`OnTriggerEnter`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#events)、[`OnTriggerExit`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#events)、[`OnLocalTriggerEnter`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#events)、[`OnLocalTriggerExit`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html#events)
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

[RenderTriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderTriggerUnit.html) 是兼具运行时模型渲染与触发检测能力的场景单位；RenderMeshId 指定实际渲染网格，DisplayModelId 只用于编辑器预览。

## 适用场景

在需要制作可交互区域（如触发器、危险地带、事件区域）时，通过创建触发区域单位并配置其外观与物理属性，再配合其他逻辑实现区域检测与反馈。

## 使用要点

通过 World:CreateUnit 创建实例，在 config 中把 RenderMeshId 设置为项目提供的有效网格资源 URI，并监听 OnTriggerEnter/OnTriggerExit 处理进入和离开。

## 注意事项

运行时外观使用 RenderMeshId，DisplayModelId 是 editOnly 的编辑器预览字段，不影响运行时渲染。当前公开 Surface 只提供 ModelColor1~ModelColor4 等外观属性，不应调用未发布的染色接口。[Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 使用 0-255 RGBA 四参数构造。

## 代码示例

### 创建可见触发区域并监听进入事件

```lua
-- @runtime client
local function createRenderTrigger(meshId)
    local world = game:GetService("World")
    local renderTrigger = world:CreateUnit("RenderTriggerUnit", {
        RenderMeshId = meshId,
        ModelColor1 = Color.New(255, 0, 0, 255),
        ModelVisible = true,
    })
    renderTrigger.OnTriggerEnter:Once(function(otherUnit)
        print("进入触发区域:", otherUnit.Name)
    end)
    return renderTrigger
end
```

## 属性 (16)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `RenderMeshId` | `String` | `official://mesh/59268` | 指定该单元使用的模型资源ID。 |
| `ModelAlpha` | `Float` | `1` | 控制模型的整体透明度，0 为完全透明，1 为完全不透明 |
| `LocalTransparencyModifier` | `Float` | `1` | 该单元的本地透明度乘数，用于在本地客户端进一步调整模型透明度。 |
| `ModelVisible` | `Bool` | `true` | 控制模型是否可见，隐藏后仍参与物理碰撞 |
| `CastShadow` | `Bool` | `true` | 控制该单元是否投射阴影。 |
| `ModelBindParent` | `Bool` | `false` | 启用后，当父节点为 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)、[RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html)、[TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html)、[PhysicsUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PhysicsUnit.html) 等支持父子带动的场景单位时，当前模型渲染表现将跟随父节点的变换自动同步。运行时可通过脚本设置 .ModelBindParent = true/false 动态切换该行为。 |
| `PhysicsMeshId` | `String` | `official://mesh/59268` | 物理网格资源ID。缺省时，若初始创建时传入了 RenderMeshId，则默认使用该 RenderMeshId 作为物理资源；后续修改 .RenderMeshId 不会影响 PhysicsMeshId |
| `DisplayModelId` | `String` | `""` | 用于在编辑器中预览的模型资源 ID，不影响运行时实际渲染的模型。 |
| `ModelColor1` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 模型的染色区域1颜色，用于控制模型指定区域的颜色表现。 |
| `ModelColor2` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 模型的染色区域2颜色，用于控制模型指定区域的颜色表现。 |
| `ModelColor3` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 模型的染色区域3颜色，用于控制模型指定区域的颜色表现。 |
| `ModelColor4` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 模型的染色区域4颜色，用于控制模型指定区域的颜色表现。 |
| `SkinId` | `String` | `""` | 应用于 [RenderTriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderTriggerUnit.html) 的皮肤资源 ID。 |
| `UseCustomAppearance` | `Bool` | `false` | 是否启用自定义外观。 |
| `CustomAppearanceId` | `String` | `""` | 自定义外观的资源 ID，用于覆盖默认外观。 |
| `OcclusionType` | `Int` | `3 (不处理)` | OcclusionType 属性用于设置该渲染触发单位在遮挡玩家视角时所采用的规则，影响其被相机遮挡时的表现方式。该属性为整数类型，具体取值对应不同的遮挡处理规则。 |

## 关联类型

* [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
