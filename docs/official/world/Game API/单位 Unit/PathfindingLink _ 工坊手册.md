# PathfindingLink

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[PathfindingLink]**（6 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[PathfindingLink](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PathfindingLink.html) 用于在两个 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 之间建立导航网格外连接，让寻路代理可以跨越原本无法通行的区域。通过设置 Attachment0、Attachment1 和 IsBidirectional 等属性，可以定义连接的方向和端点。运行时修改这些属性需要 [PathfindingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PathfindingService.html) 的动态导航网格支持才能生效。

## 适用场景

在场景中需要连接两个分离的导航网格区域时，例如在两个平台之间搭建空中桥梁，或者为特定角色类型创建专用通道。

## 使用要点

通过 world:CreateUnit("PathfindingLink", {}) 创建实例，然后将 Attachment0 和 Attachment1 设置为场景中已有的 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 实例，并根据需要设置 IsBidirectional 和 Label。运行时修改属性后，需确保 [PathfindingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PathfindingService.html) 的动态导航网格已启用，才会触发重烘焙。

## 注意事项

Attachment0 和 Attachment1 应传入 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 实例引用，而不是 Attachment.UnitId 字符串或数字；它们用于定义寻路连接的两个端点。运行时新增或修改链接时，需确认 PathfindingService.HasDynamicNavMesh 为 true 才会触发重烘焙。

## 代码示例

### 用两个 Attachment 创建动态寻路链接

```lua
-- @runtime server
local World = game:GetService('World')
local PathfindingService = game:GetService('PathfindingService')
if not PathfindingService.HasDynamicNavMesh then
    print('当前未启用动态导航网格')
    return
end
local startPart = World:CreateUnit('WorldUnit', { Position = Vector3.New(0, 0, 0) })
local endPart = World:CreateUnit('WorldUnit', { Position = Vector3.New(5, 0, 0) })
local startAttachment = World:CreateUnit('Attachment', { Parent = startPart })
local endAttachment = World:CreateUnit('Attachment', { Parent = endPart })
local link = World:CreateUnit('PathfindingLink', {
    Attachment0 = startAttachment,
    Attachment1 = endAttachment,
    IsBidirectional = true,
    Label = 'shortcut',
})
print('寻路链接标签:', link.Label)
```

## 属性 (6)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `AttachmentID0` | `Int` | `0` | 起始锚点的 ID，用于标识链接起点的 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 实例。 |
| `AttachmentID1` | `Int` | `0` | 终点锚点的 ID，用于标识链接终点的 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 实例。 |
| `Attachment0` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) | `-` | 寻路链接的起始锚点，用于定义链接的起点位置和朝向。 |
| `Attachment1` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) | `-` | 寻路链接的终点锚点，用于定义链接的终点位置和朝向。 |
| `IsBidirectional` | `Bool` | `true` | 是否允许双向通行，决定寻路时是否可以从终点向起点移动。 |
| `Label` | `String` | `""` | 区域标签，用于对寻路链接进行分类或过滤。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)
