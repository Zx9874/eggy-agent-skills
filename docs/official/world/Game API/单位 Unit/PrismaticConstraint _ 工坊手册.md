# PrismaticConstraint

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[PrismaticConstraint]**（17 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[PrismaticConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PrismaticConstraint.html) 描述两个已绑定 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 之间沿单一轴向滑动的棱柱约束。

## 适用场景

读取或调整编辑器中已经完成 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 绑定的滑轨、升降机构等结构。

## 使用要点

从场景中查找预配置的 [PrismaticConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PrismaticConstraint.html)，再调整限制、速度或目标位置等公开属性。

## 注意事项

Attachment0 和 Attachment1 使用已存在的 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 实例引用，不要传 UnitId 字符串或数字。物理约束建议在服务端创建和调整；也可继续使用编辑器预配置的绑定。

## 代码示例

### 读取编辑器预配置的棱柱约束

```lua
-- @runtime server
local constraint = game:GetService('World'):FindFirstChild('MyPrismaticConstraint', true)
if constraint == nil or not constraint:IsA('PrismaticConstraint') then return end
print('棱柱约束是否启用:', constraint.Enabled)
```

## 属性 (17)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Enabled` | `Bool` | `true` | 是否启用约束。 |
| `Attachment0` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) | `-` | 约束连接的第一个 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 对象，作为滑移约束的基准端。 |
| `Attachment1` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) | `-` | 约束连接的第二个 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 对象，作为滑移约束的移动端。 |
| `LimitsEnabled` | `Bool` | `false` | 是否启用线性移动范围限制。 |
| `LowerLimit` | `Float` | `0.0` | 线性移动的最小位置，单位为空间单位。 |
| `UpperLimit` | `Float` | `5.0` | 线性移动的最大位置，单位为空间单位。 |
| `Restitution` | `Float` | `0.0` | 约束的弹性系数，取值范围 0 到 1。 |
| `ActuatorType` | `Int` | `Enums.ActuatorType.None` | 驱动类型，决定约束的运动方式。 |
| `Velocity` | `Float` | `0.0` | Motor 模式下的目标移动速度，单位为空间单位/秒。 |
| `MotorMaxForce` | `Float` | `0.0` | Motor 模式下的最大驱动力。 |
| `MotorMaxAcceleration` | `Float` | `500000.0` | Motor 模式下的最大加速度。 |
| `TargetPosition` | `Float` | `0.0` | Servo 模式下的目标位置，单位为空间单位。 |
| `Speed` | `Float` | `0.0` | Servo 模式下的目标移动速度，单位为空间单位/秒。 |
| `ServoMaxForce` | `Float` | `0.0` | Servo 模式下的最大驱动力。 |
| `LinearResponsiveness` | `Float` | `0.0` | Servo 模式下的线性响应系数。 |
| `Active` | `Bool` | `false` | 当前约束是否处于激活状态。 |
| `CurrentPosition` | `Float` | `0.0` | 当前滑动位置，单位为空间单位。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)
