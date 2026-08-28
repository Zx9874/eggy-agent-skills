# PendulumMotorUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)（8 属性 / 5 函数 / 2 事件）
    - **[PendulumMotorUnit]**（1 属性）

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

摆锤运动器是一种以摆锤方式驱动对象运动的场景运动器，通过 AngularVelocity 属性设定摆动角速度，并继承 [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html) 的完整运动控制能力，可配合 IsCycle、BackTracking、HalfCycleTime、ArrivalPauseTime、BackPauseTime 与 Duration 等参数配置循环、返程与停留时序，同时借助 OnMotorStart、OnMotorStop 事件感知运动状态变化。

## 适用场景

适用于制作钟摆、闸门、吊桥等需要周期性摆动或往复运动的场景机关，通常在创建后设置角速度与循环时序，再启动运动即可驱动目标持续摆动。

## 使用要点

先通过 game:CreateUnit 或 World:CreateUnit 创建 [PendulumMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PendulumMotorUnit.html) 实例，并配置 AngularVelocity 与基类提供的 IsCycle、BackTracking、Duration 等时序属性；随后调用 Start 启动运动，运行过程中可使用 Pause、Resume、Backtrack、Stop 控制状态，并监听 OnMotorStart、OnMotorStop 事件以同步外部逻辑。

## 注意事项

[BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html) 是各种运动器（Angular/Linear/CurveVel/Pendulum/Waypoint）的基类，运行时不应直接创建 [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)；演示基类 API 时请创建具体子类。通过 IsCycle、BackTracking、HalfCycleTime、ArrivalPauseTime、BackPauseTime 与 Duration 配置循环、返程和时序，再调用 Start/Pause/Resume/Backtrack/Stop 控制运动。运动器通过 OnMotorStart / OnMotorStop 事件回调感知状态。

## 代码示例

### 创建往复摆锤运动器并驱动目标

```lua
-- @runtime client
local World = game:GetService('World')
local target = World:CreateUnit('WorldUnit', { Position = Vector3.New(0, 3, 0) })
local motor = World:CreateUnit('PendulumMotorUnit', {
    Parent = target,
    AngularVelocity = Vector3.New(0, 30, 0),
    Duration = 10,
    IsCycle = true,
    BackTracking = true,
    HalfCycleTime = 2,
})
motor:Start()
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `AngularVelocity` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | [PendulumMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PendulumMotorUnit.html) 的角速度属性，以三维向量表示摆动马达单元的旋转角速度。 |

## 关联类型

* [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
