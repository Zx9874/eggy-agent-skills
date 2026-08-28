# RenderUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
    - [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html)（23 属性 / 9 函数）
      * **[RenderUnit]**（15 属性）

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

[RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html) 是一种可在三维场景中创建的渲染组件，负责承载并展示模型资源。它提供了模型资源绑定、透明度与可见性控制、阴影投射、多区域染色、皮肤以及自定义外观等表现能力，适合用来搭建场景中的装饰物或需要独立控制渲染效果的物件。

## 适用场景

在搭建地图场景时，常通过创建 [RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html) 来摆放静态模型，例如建筑、植被、道具等装饰元素，并利用其属性动态控制模型的显隐、透明度和染色效果。

## 使用要点

通过 game:CreateUnit("RenderUnit", config) 或 World:CreateUnit("RenderUnit", config) 创建实例，在配置中指定 RenderMeshId 等初始属性。创建后可直接读写 ModelVisible、ModelAlpha、ModelColor 系列属性来调整表现，也可以设置 CastShadow、SkinId、UseCustomAppearance 等属性丰富渲染细节。

## 注意事项

创建后必须设置 RenderMeshId 指定模型资源才能在场景中显示。[TweenService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TweenService.html) 对 [RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html) 属性的支持有限，建议直接修改属性而非 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 驱动。[Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 类型必须用 0-255 RGBA 四参数构造（如 Color.New(255, 0, 0, 255)），不能用 0-1 归一化值。

## 代码示例

### 创建并显示渲染单位

```lua
-- @runtime client
local World = game:GetService("World")
local renderUnit = World:CreateUnit("RenderUnit", {
    Name = "SceneDecoration",
    RenderMeshId = "official://mesh/59268",
    Position = Vector3.New(0, 2, 0),
    ModelVisible = true,
    ModelAlpha = 1.0,
    ModelColor1 = Color.New(255, 255, 255, 255),
})
print("已创建渲染单位:", renderUnit.Name)
```

## 属性 (15)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `RenderMeshId` | `String` | `official://mesh/59268` | [RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html) 使用的模型资源 ID。 |
| `ModelAlpha` | `Float` | `1` | 控制模型的整体透明度，0 为完全透明，1 为完全不透明 |
| `LocalTransparencyModifier` | `Float` | `1` | 本地透明度乘数，影响 [RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html) 的最终透明度。 |
| `ModelVisible` | `Bool` | `true` | 控制 [RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html) 模型的可见性。 |
| `CastShadow` | `Bool` | `true` | 控制 [RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html) 是否投射阴影。 |
| `TransparentRenderBias` | `Int` | `0` | 控制 [RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html) 的半透明渲染偏置值，用于调整渲染顺序，解决半透明物体之间的渲染遮挡问题。 |
| `ModelBindParent` | `Bool` | `false` | 是否让 [RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html) 的模型跟随其父节点的变换。 |
| `ModelColor1` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 模型染色区域1的颜色，使用 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 类型表示。 |
| `ModelColor2` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 模型染色区域2的颜色，使用 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 类型表示。 |
| `ModelColor3` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 模型染色区域3的颜色，使用 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 类型表示。 |
| `ModelColor4` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 模型染色区域4的颜色，使用 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 类型表示。 |
| `SkinId` | `String` | `""` | [RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html) 使用的皮肤资源 ID。 |
| `UseCustomAppearance` | `Bool` | `false` | 是否启用自定义外观。 |
| `CustomAppearanceId` | `String` | `""` | 当 UseCustomAppearance 为 true 时，指定自定义外观资源的 ID。 |
| `OcclusionType` | `Int` | `3 (不处理)` | [RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html) 的 OcclusionType 属性用于设置该渲染单元在遮挡玩家时采用的规则。 |

## 关联类型

* [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
