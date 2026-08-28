# BallSocketConstraint

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[BallSocketConstraint]**（12 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[BallSocketConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BallSocketConstraint.html) 描述两个 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 实例之间的球形关节；当前公开契约可通过 Attachment0/Attachment1 直接引用端点。

## 适用场景

仅建议检查或有限调整编辑器中已经绑定完成、并在目标运行包验证过的球形关节。

## 使用要点

从场景中查找预配置的 [BallSocketConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BallSocketConstraint.html)，读取状态或调整已验证安全的限制参数；不要在正式逻辑中动态创建或反复施加高强度物理作用。

## 注意事项

Attachment0 和 Attachment1 使用已存在的 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 实例引用，不需要读取 UnitId。当前运行包仍实测出现动态球窝约束触发执行上限、持续踩踏后断开或物理卡顿等问题；修复前请优先使用编辑器预配置并验证过的 [BallSocketConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BallSocketConstraint.html)。

## 代码示例

### 读取编辑器预配置的球窝约束

```lua
-- @runtime server
local World = game:GetService("World")
local constraint = World:FindFirstChild("MyBallSocketConstraint", true)
if constraint == nil or not constraint:IsA("BallSocketConstraint") then
    print("请先在编辑器中配置 BallSocketConstraint")
    return
end
print("已找到球窝约束:", constraint.Name)
```

## 属性 (12)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Enabled` | `Bool` | `true` | 是否启用该约束。 |
| `Attachment0` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) | `-` | 球窝约束的第一个连接点，用于将约束连接到第一个部件上。 |
| `Attachment1` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) | `-` | 球窝约束的第二个连接点，用于将约束连接到第二个部件上。 |
| `LimitsEnabled` | `Bool` | `false` | 是否启用摆动角限制。 |
| `UpperAngle` | `Float` | `45.0` | 最大摆动角，单位为度。 |
| `TwistLimitsEnabled` | `Bool` | `false` | 是否启用扭转角限制。 |
| `TwistLowerAngle` | `Float` | `-45.0` | 最小扭转角，单位为度。 |
| `TwistUpperAngle` | `Float` | `45.0` | 最大扭转角，单位为度。 |
| `Restitution` | `Float` | `0.0` | 约束的弹性系数，取值范围 0 到 1。 |
| `MaxFrictionTorque` | `Float` | `0.0` | 最大摩擦扭矩，当前仅用于存储。 |
| `Radius` | `Float` | `0.15` | 约束的可视化半径。 |
| `Active` | `Bool` | `false` | 当前约束是否处于激活状态。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)
