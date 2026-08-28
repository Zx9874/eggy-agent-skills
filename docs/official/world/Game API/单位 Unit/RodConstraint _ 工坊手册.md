# RodConstraint

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[RodConstraint]**（10 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[RodConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RodConstraint.html) 描述两个已绑定 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 之间保持固定距离的杆约束。

## 适用场景

读取或调整编辑器中已经完成 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 绑定的杆约束。

## 使用要点

从场景树中查找预配置的 [RodConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RodConstraint.html)，再读取长度与状态；动态创建时通过 Attachment0/Attachment1 传入已有 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 实例。

## 注意事项

Attachment0 和 Attachment1 是公开的 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 对象引用，不要传 UnitId 字符串或数字。物理约束建议在服务端创建和调整。

## 代码示例

### 读取编辑器预配置的杆约束

```lua
-- @runtime server
local constraint = game:GetService('World'):FindFirstChild('MyRodConstraint', true)
if constraint == nil or not constraint:IsA('RodConstraint') then return end
print('杆约束长度:', constraint.Length)
```

## 属性 (10)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Enabled` | `Bool` | `true` | 控制约束是否启用。 |
| `Attachment0` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) | `-` | 杆约束的第一个连接点，类型为 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)。该连接点定义了杆的一端所附着的部件和位置。 |
| `Attachment1` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) | `-` | 杆约束的第二个连接点，类型为 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)。该连接点定义了杆的另一端所附着的部件和位置。 |
| `Length` | `Float` | `5.0` | 杆的长度，以空间单位表示。 |
| `LimitsEnabled` | `Bool` | `false` | 是否启用端部角度限制。 |
| `LimitAngle0` | `Float` | `0.0` | Attachment0 端的角度限制，单位为度。 |
| `LimitAngle1` | `Float` | `0.0` | Attachment1 端的角度限制，单位为度。 |
| `Thickness` | `Float` | `0.1` | 约束可视化显示的粗细。 |
| `Active` | `Bool` | `false` | 指示 [RodConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RodConstraint.html) 是否处于激活状态。 |
| `CurrentDistance` | `Float` | `0.0` | 当前两个 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 之间的实际距离，以空间单位表示。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)
