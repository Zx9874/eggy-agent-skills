# RigidConstraint

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[RigidConstraint]**（4 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[RigidConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RigidConstraint.html) 描述两个 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 实例之间的刚性连接；当前公开契约可通过 Attachment0/Attachment1 直接引用端点。

## 适用场景

仅建议检查编辑器中已经绑定完成、并在目标运行包验证过的刚性约束；稳定跟随优先采用成熟的焊接或父子层级方案。

## 使用要点

从场景中查找预配置的 [RigidConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RigidConstraint.html) 并读取状态；若动态创建，Attachment0/Attachment1 应传入已有 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 实例。

## 注意事项

Attachment0 和 Attachment1 使用 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 实例引用，不需要读取 UnitId。当前运行包仍实测出现动态创建后表现为弹性连接、对象固定异常等问题；修复前请优先使用编辑器预配置的 [RigidConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RigidConstraint.html)，需要稳定刚性跟随时采用已验证的 [WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html) 或父子层级方案。

## 代码示例

### 读取编辑器预配置的刚性约束

```lua
-- @runtime server
local World = game:GetService("World")
local constraint = World:FindFirstChild("MyRigidConstraint", true)
if constraint == nil or not constraint:IsA("RigidConstraint") then
    print("请先在编辑器中配置 RigidConstraint")
    return
end
print("已找到刚性约束:", constraint.Name)
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Enabled` | `Bool` | `true` | 控制 [RigidConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RigidConstraint.html) 是否启用。 |
| `Attachment0` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) | `-` | 刚性约束的第一个连接点，类型为 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)。 |
| `Attachment1` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) | `-` | 刚性约束的第二个连接点，类型为 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)。 |
| `Active` | `Bool` | `false` | 指示 [RigidConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RigidConstraint.html) 当前是否处于激活状态。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)
