# BaseMotorUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[BaseMotorUnit]**（8 属性 / 5 函数 / 2 事件）
    - [AngularMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AngularMotorUnit.html)（1 属性）
    - [CurveVelMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CurveVelMotorUnit.html)（5 属性）
    - [LinearMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/LinearMotorUnit.html)（1 属性）
    - [PendulumMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PendulumMotorUnit.html)（1 属性）
    - [WaypointMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WaypointMotorUnit.html)（1 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

运动器基类是所有场景运动器（如角速度运动器、线性运动器、曲线速度运动器、摆锤运动器和路径点运动器）的公共基类，定义了统一的运动控制接口与时序配置属性。它负责管理运动的启停、暂停恢复、返程回溯以及周期循环行为，并通过本地事件通知运动开始与结束。实际使用时不应直接创建该基类，而应创建具体子类后使用其继承的控制能力。

## 适用场景

典型场景是在地图中让某个单位持续进行旋转、平移或沿路径往复运动，例如让装饰物绕轴转动、平台在两点间往返移动，并配合运动器本地事件做状态联动。开发者通常在单位初始化后创建具体运动器子类并挂接为父级，再通过统一控制方法驱动运动。

## 使用要点

先通过游戏服务获取世界实例，再调用世界创建单位方法创建一个目标单位作为运动器父级，随后用同样方式创建具体运动器子类（如角速度运动器），将目标单位作为父级传入并配置角度速度等运动参数。创建后设置运动器基类继承的时序属性（如循环开关、返程开关、单程时间、暂停时间与持续时间），最后调用启动、暂停、恢复、返程回溯或停止等控制方法驱动或终止运动。

## 注意事项

[BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html) 是各种运动器（Angular/Linear/CurveVel/Pendulum/Waypoint）的基类，运行时不应直接创建 [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)；演示基类 API 时请创建具体子类。通过 IsCycle、BackTracking、HalfCycleTime、ArrivalPauseTime、BackPauseTime 与 Duration 配置循环、返程和时序，再调用 Start/Pause/Resume/Backtrack/Stop 控制运动。运动器通过 OnMotorStart / OnMotorStop 事件回调感知状态。

## 代码示例

### 用具体运动器子类控制目标单位

```lua
-- @runtime client
local World = game:GetService('World')
local target = World:CreateUnit('WorldUnit', { Position = Vector3.New(0, 3, 0) })
local motor = World:CreateUnit('AngularMotorUnit', {
    Parent = target,
    AngularVelocity = Vector3.New(0, 90, 0),
})
motor.OnMotorStart:Once(function()
    print('运动器已启动')
end)
motor:Start()
```

## 属性 (8)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `InitDelayTime` | `Float` | `0.0` | 设定运动单元从启动到真正开始运动之前的等待时间，单位为秒。延迟期间运动单元保持静止。 |
| `IsCycle` | `Bool` | `false` | 控制运动单元是否循环执行运动。开启后，运动流程会反复进行，直到停止或停用。 |
| `IsActive` | `Bool` | `true` | 控制运动单元是否处于启用状态。关闭后运动单元不再执行运动逻辑，保持当前状态。 |
| `BackTracking` | `Bool` | `false` | 控制运动单元在到达目标位置后是否沿原路径返回起点。开启后运动单元将执行往返运动。 |
| `HalfCycleTime` | `Float` | `2.0` | 设定运动单元完成单程运动所需的时间，单位为秒。单程运动指从起点到目标位置或从目标位置返回起点的单向过程。 |
| `ArrivalPauseTime` | `Float` | `0.0` | 设定运动单元到达目标位置后的暂停时长，单位为秒。到达暂停结束后，运动单元才会继续后续动作（例如返程或结束）。 |
| `BackPauseTime` | `Float` | `0.0` | 设定运动单元从目标位置返程回到起点后的暂停时长，单位为秒。仅当开启返程功能时生效。 |
| `Duration` | `Float` | `0.0` | 设定运动单元执行一次完整运动过程的持续时间，单位为秒。该时间用于控制整体运动的时长基准。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (2)

### OnMotorStart

签名：`OnMotorStart()` 触发：`local`

当运动器开始运动时触发。

> 示例代码

> 监听运动器启动

```lua
-- @runtime client
local World = game:GetService('World')
local target = World:CreateUnit('WorldUnit', { Position = Vector3.New(0, 3, 0) })
local motor = World:CreateUnit('AngularMotorUnit', { Parent = target, AngularVelocity = Vector3.New(0, 90, 0) })
motor.OnMotorStart:Once(function() print('运动器已启动') end)
motor:Start()
```

### OnMotorStop

签名：`OnMotorStop()` 触发：`local`

当运动器停止运动时触发。

> 示例代码

> 监听运动器停止

```lua
-- @runtime client
local World = game:GetService('World')
local motor = World:FindFirstChild('ConfiguredLinearMotor', true)
if motor == nil or not motor:IsA('LinearMotorUnit') then return end
motor.OnMotorStop:Once(function() print('运动器已停止') end)
motor:Start()
motor:Stop()
```

## 函数 (5)

### Start

签名：`Start() -> void`

启动运动器的运动。

**返回值** `void`

> 示例代码

> 启动已配置的具体运动器

```lua
-- @runtime client
local function startMotor(motor)
    if motor ~= nil then motor:Start() end
end
```

### Pause

签名：`Pause() -> void`

暂停运动器的当前运动。

**返回值** `void`

> 示例代码

> 暂停正在运行的运动器

```lua
-- @runtime client
local function pauseMotor(motor)
    if motor ~= nil then motor:Pause() end
end
```

### Resume

签名：`Resume() -> void`

恢复已暂停的运动器运动。

**返回值** `void`

> 示例代码

> 恢复已暂停的运动器

```lua
-- @runtime client
local function resumeMotor(motor)
    if motor ~= nil then motor:Resume() end
end
```

### Backtrack

签名：`Backtrack() -> void`

使运动器立即开始返程运动。

**返回值** `void`

> 示例代码

> 让运动器开始返程

```lua
-- @runtime client
local function backtrackMotor(motor)
    if motor ~= nil then motor:Backtrack() end
end
```

### Stop

签名：`Stop() -> void`

停止运动器的运动。

**返回值** `void`

> 示例代码

> 停止运动器

```lua
-- @runtime client
local function stopMotor(motor)
    if motor ~= nil then motor:Stop() end
end
```
