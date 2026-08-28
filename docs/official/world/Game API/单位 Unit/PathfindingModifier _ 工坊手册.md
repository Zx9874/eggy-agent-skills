# PathfindingModifier

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[PathfindingModifier]**（3 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[PathfindingModifier](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PathfindingModifier.html) 用于标记父级物理单位在导航网格中的区域标签、穿越性和烘焙模式。通过设置 Label 可定义区域类型，PassThrough 控制是否允许穿越，BakeMode 决定该修饰器在导航网格烘焙时的处理方式。运行时修改这些属性需要 [PathfindingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PathfindingService.html) 的动态导航网格支持才能触发重烘焙。

## 适用场景

在需要动态改变场景中某些区域的寻路行为时使用，例如将特定地板标记为不可穿越或改变其区域标签，从而影响 AI 的路径计算。

## 使用要点

通过 game:CreateUnit("PathfindingModifier", config) 创建实例，将其 Parent 设置为要影响的物理单位。然后设置 Label、PassThrough 和 BakeMode 属性来定义寻路行为。

## 注意事项

[PathfindingModifier](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PathfindingModifier.html) 必须挂到要影响的物理单位上。运行时新增、销毁或修改 Parent/Label/PassThrough/BakeMode 时，需确认 PathfindingService.HasDynamicNavMesh 为 true 才会触发 tile 重烘焙。

## 代码示例

### 给物理单位添加动态寻路修饰器

```lua
-- @runtime server
local World = game:GetService('World')
local PathfindingService = game:GetService('PathfindingService')
if not PathfindingService.HasDynamicNavMesh then
    print('当前未启用动态导航网格')
    return
end
local obstacle = World:CreateUnit('WorldUnit', { Position = Vector3.New(0, 0, 0) })
local modifier = World:CreateUnit('PathfindingModifier', {
    Parent = obstacle,
    Label = 'obstacle',
    PassThrough = false,
    BakeMode = Enums.BakeMode.Force,
})
print('寻路修饰器标签:', modifier.Label)
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Label` | `String` | `""` | 区域标签，用于标识该寻路修饰区域，可在寻路时通过标签区分不同区域。 |
| `PassThrough` | `Bool` | `false` | 是否允许角色直接穿越该区域，而不受寻路修饰影响。 |
| `BakeMode` | [BakeMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/BakeMode.html) | `Enums.BakeMode.Auto` | 寻路烘焙模式，决定该区域在导航网格烘焙时的处理方式。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [BakeMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/BakeMode.html)
