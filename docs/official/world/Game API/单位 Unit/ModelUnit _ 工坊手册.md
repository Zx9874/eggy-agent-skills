# ModelUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
    - **[ModelUnit]**（4 属性 / 1 函数）
      * [WorldRoot](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldRoot.html)
        + [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)（1 属性 / 4 函数）

### 继承成员

2 个来源 / 7 属性 / 34 函数 / 6 事件

* 来自 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
  + 属性：[`Tags`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`EcaPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`Owner`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)
  + 函数：[`HasTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`AddTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`RemoveTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`GetPivot`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`PivotTo`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`ApplyPivotDelta`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`TranslateBy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`IsTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`FindTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[ModelUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html) 是用于组织多个 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 子对象并以统一枢轴进行整体移动的模型容器。

## 适用场景

典型场景是在场景中创建模型容器，将多个部件或单位作为子对象挂载后，通过设置 PrimaryPart 或 WorldPivot 来确定整体基准，再借助 Position、Rotation 或 MoveTo 对模型整体进行移动、旋转与定位。

## 使用要点

通过 World:CreateUnit 创建 [ModelUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html)，把多个 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 子对象的 Parent 设为该容器；先设置 WorldPivot 或 PrimaryPart，再设置 Position/Rotation、调用 MoveTo(position) 或使用继承的 PivotTo 移动整个组合。

## 注意事项

PrimaryPart 是模型整体移动和物理模拟的参考基准；设置后枢轴跟随该部件，WorldPivot 会被忽略。未设置 PrimaryPart 时，WorldPivot 只更新模型自身枢轴，不会直接移动子对象，但 PivotTo、MoveTo 等操作会以它计算位移增量。新模型在首次设置 WorldPivot 前以原点为默认枢轴，建议移动前主动设置 WorldPivot 或 PrimaryPart。Position 与 Rotation 是 PivotTo 的便捷属性，同时仍可使用从 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 公开继承的 PivotTo、GetPivot、TranslateBy 等成员。

## 代码示例

### 创建模型并按枢轴整体移动

```lua
-- @runtime client
local World = game:GetService("World")
local model = World:CreateUnit("ModelUnit", {
    Name = "MovingGroup",
    WorldPivot = CFrame.New(0, 0, 0),
})
World:CreateUnit("WorldUnit", { Name = "ChildA", Parent = model })
World:CreateUnit("WorldUnit", { Name = "ChildB", Parent = model })
model:MoveTo(Vector3.New(10, 0, 0))
print("模型位置:", model.Position)
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `PrimaryPart` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | `-` | 模型的核心部件，作为整体移动和物理模拟的参考基准。设置后枢轴跟随该部件；未设置时由 WorldPivot 决定。 |
| `WorldPivot` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | `-` | 未设置 PrimaryPart 时使用的世界空间枢轴。直接赋值只更新 [ModelUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html) 自身枢轴，不会移动子对象；PivotTo、MoveTo 等操作以它计算位移增量。 |
| `Position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0.0, 0.0, 0.0]` | 模型在世界空间中的位置，是调用 PivotTo 的便捷属性。 |
| `Rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | `[0.0, 0.0, 0.0, 1.0]` | 模型在世界空间中的四元数旋转，是调用 PivotTo 的便捷属性。 |

## 关联类型

* [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)
* [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)
* [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 函数 (1)

### MoveTo

签名：`MoveTo(position: Vector3) -> void`

将模型整体移动到指定的世界空间位置。

⚙ MoveTo 使用当前模型枢轴计算整体位移；移动前应先设置 WorldPivot 或 PrimaryPart，避免新模型默认原点枢轴带来意外偏移。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界空间中的目标坐标 |

**返回值** `void`

> 示例代码

> 按已设置的枢轴移动模型

```lua
-- @runtime client
local World = game:GetService("World")
local model = World:CreateUnit("ModelUnit", {
    Name = "MovingModel",
    WorldPivot = CFrame.New(0, 0, 0),
})
World:CreateUnit("WorldUnit", { Name = "Child", Parent = model })
model:MoveTo(Vector3.New(10, 5, 0))
print("移动后位置:", model.Position)
```
