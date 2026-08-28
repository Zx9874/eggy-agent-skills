# HingeConstraint

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[HingeConstraint]**（16 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[HingeConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HingeConstraint.html) 描述两个已绑定 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 之间绕共享轴旋转的铰链约束。

## 适用场景

读取或调整编辑器中已经完成 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 绑定的门轴、旋转平台等铰链结构。

## 使用要点

从场景中查找预配置的 [HingeConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HingeConstraint.html)，再调整 LimitsEnabled、ActuatorType、TargetAngle 等公开属性。

## 注意事项

Attachment0 和 Attachment1 使用已存在的 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 实例引用，不要传 UnitId 字符串或数字。物理约束建议在服务端创建和调整；也可继续使用编辑器预配置的绑定。

## 代码示例

### 调整编辑器预配置的铰链约束

```lua
-- @runtime server
local hinge = game:GetService('World'):FindFirstChild('MyHingeConstraint', true)
if hinge == nil or not hinge:IsA('HingeConstraint') then return end
hinge.Enabled = true
hinge.LimitsEnabled = true
hinge.LowerAngle = -45
hinge.UpperAngle = 90
print('铰链角度范围:', hinge.LowerAngle, hinge.UpperAngle)
```

## 属性 (16)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Enabled` | `Bool` | `true` | 是否启用铰链约束。 |
| `Attachment0` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) | `-` | 铰链约束的第一个连接点，类型为 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)。 |
| `Attachment1` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) | `-` | 铰链约束的第二个连接点，类型为 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)。 |
| `ActuatorType` | `Int` | `Enums.ActuatorType.None` | 铰链约束的驱动类型，决定约束如何施加力或运动。 |
| `AngularVelocity` | `Float` | `0.0` | Motor 模式下的目标角速度，单位 rad/s。 |
| `MotorMaxTorque` | `Float` | `0.0` | Motor 模式下的最大扭矩。 |
| `MotorMaxAcceleration` | `Float` | `500000.0` | Motor 模式下的最大角加速度，单位 rad/s²。 |
| `TargetAngle` | `Float` | `0.0` | Servo 模式下的目标角度，单位度。 |
| `AngularSpeed` | `Float` | `0.0` | Servo 模式下的角速度，单位 rad/s。 |
| `ServoMaxTorque` | `Float` | `0.0` | Servo 模式下的最大扭矩。 |
| `AngularResponsiveness` | `Float` | `0.0` | Servo 模式下的响应灵敏度，控制到达目标角度的速度。 |
| `LimitsEnabled` | `Bool` | `false` | 是否启用角度限制。 |
| `LowerAngle` | `Float` | `-45.0` | 角度限制的最小角度，单位度。 |
| `UpperAngle` | `Float` | `45.0` | 角度限制的最大角度，单位度。 |
| `Restitution` | `Float` | `0.0` | 约束在达到角度限制时的弹性，取值范围 0 到 1。 |
| `Radius` | `Float` | `0.5` | 约束在编辑器中的可视化半径。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)
