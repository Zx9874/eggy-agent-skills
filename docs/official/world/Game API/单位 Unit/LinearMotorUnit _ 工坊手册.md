# LinearMotorUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)（8 属性 / 5 函数 / 2 事件）
    - **[LinearMotorUnit]**（1 属性）

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

直线运动器用于驱动关联的单位沿直线方向持续移动。它继承自基础运动器，支持通过配置表设定运动参数，并可通过事件监听运动开始与停止。

## 适用场景

在需要让平台、门或障碍物沿固定方向往复运动的场景中，创建直线运动器并绑定到目标单位上。

## 使用要点

从场景中获取编辑器已配置运动方向与速度的 [LinearMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/LinearMotorUnit.html)，再通过 Duration、IsCycle 等公开属性调整时序，并调用 Start/Pause/Resume/Stop 控制运动。

## 注意事项

LinearVelocity 在当前 Meta 中标记为 publish=false，作者示例不得读取或写入；需要设置直线方向与速度时先在编辑器中配置。Lua 只使用 MotorType、Duration 等当前公开成员和继承自 [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html) 的控制接口。

## 代码示例

### 启动编辑器预配置的直线运动器

```lua
-- @runtime client
local World = game:GetService('World')
local motor = World:FindFirstChild('ConfiguredLinearMotor', true)
if motor == nil or not motor:IsA('LinearMotorUnit') then
    print('请先在编辑器中配置 LinearMotorUnit')
    return
end
motor.Duration = 5
motor:Start()
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `MotorType` | `Int` | `0 (FixLinear)` | 线性运动器的运动类型，决定运动器沿直线运动时的行为模式。 |

## 关联类型

* [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)
