# CurveVelMotorUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)（8 属性 / 5 函数 / 2 事件）
    - **[CurveVelMotorUnit]**（5 属性）

### 继承成员

2 个来源 / 12 属性 / 30 函数 / 8 事件

* 来自 [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)（8 属性 / 5 函数 / 2 事件）
  + 属性：[`InitDelayTime`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#properties)、[`IsCycle`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#properties)、[`IsActive`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#properties)、[`BackTracking`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#properties)、[`HalfCycleTime`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#properties)、[`ArrivalPauseTime`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#properties)、[`BackPauseTime`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#properties)、[`Duration`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#properties)
  + 函数：[`Start`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#functions)、[`Pause`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#functions)、[`Resume`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#functions)、[`Backtrack`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#functions)、[`Stop`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#functions)
  + 事件：[`OnMotorStart`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#events)、[`OnMotorStop`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html#events)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

曲线速度运动器是一种按预设速度曲线驱动单位运动的场景单位，通过 CurveAccelerationTime、CurveConstantSpeedTime、CurveLinearAcceleration 与 CurveAngularAcceleration 等参数，控制单位在启动后先加速、再匀速的运动过程。创建时可通过 CurveVelType 指定直线或圆周运动，并可将自身挂接到目标单位上，实现平台升降、旋转机关等可配置的运动效果。

## 适用场景

典型用于实现门、平台或机关单位在触发后先加速再匀速的运动动画，例如直线升降平台或绕轴旋转的摆锤。开发者常在创建单位时直接配置各阶段参数，并把运动器放入目标单位下，使其带动父单位运动。

## 使用要点

通过 World:CreateUnit("CurveVelMotorUnit", config) 创建并挂到目标单位，可配置 CurveAccelerationTime、CurveConstantSpeedTime 和 CurveLinearAcceleration 后调用 Start。

## 注意事项

通过 CurveAccelerationTime、CurveConstantSpeedTime、CurveLinearAcceleration 与 CurveAngularAcceleration 配置加速和匀速阶段；当前公开 Meta 未声明可切换的 CurveVelType 或 MotorType 字段，不要在示例中自行补写。

## 代码示例

### 创建曲线速度运动器并启动

```lua
-- @runtime client
local World = game:GetService('World')

local target = World:CreateUnit('WorldUnit', {
    Position = Vector3.New(0, 3, 0),
})
local motor = World:CreateUnit('CurveVelMotorUnit', {
    Parent = target,
    CurveAccelerationTime = 1.0,
    CurveConstantSpeedTime = 2.0,
    CurveLinearAcceleration = Vector3.New(0, 0, 8),
})

motor:Start()
```

## 属性 (5)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `CurveVelType` | `Int` | `0 (Linear)` | 运动类型，决定曲线速度运动单元的运动方式。 |
| `CurveAccelerationTime` | `Float` | `0.0` | 加速时长，表示曲线速度运动中加速阶段持续的时间长度。 |
| `CurveConstantSpeedTime` | `Float` | `0.0` | 匀速时长，表示曲线速度运动中匀速阶段持续的时间长度。 |
| `CurveLinearAcceleration` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | 直线加速度，表示直线运动中的加速度向量。 |
| `CurveAngularAcceleration` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | 角加速度，表示圆周运动中的角加速度向量。 |

## 关联类型

* [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
