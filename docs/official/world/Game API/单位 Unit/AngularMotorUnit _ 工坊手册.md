# AngularMotorUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)（8 属性 / 5 函数 / 2 事件）
    - **[AngularMotorUnit]**（1 属性）

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

旋转运动器是驱动场景单位持续旋转的运动组件，通过角速度属性设定旋转速度与旋转轴方向。该类型由场景创建并持有，适合用于自动转动的机关、装饰物或动态展示元素。

## 适用场景

在需要让物体自动旋转的场景中，例如旋转舞台、风车或旋转门，开发者创建旋转运动器并为其配置角速度即可实现持续旋转效果。

## 使用要点

通过 game:CreateUnit("AngularMotorUnit", config) 或 World:CreateUnit("AngularMotorUnit", config) 获取实例，其中 config 可传入初始角速度配置。实例创建后可读取或修改 AngularVelocity 属性来动态调整旋转速度与方向。

## 注意事项

[BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html) 是各种运动器（Angular/Linear/CurveVel/Pendulum/Waypoint）的基类，运行时不应直接创建 [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)；演示基类 API 时请创建具体子类。通过 IsCycle、BackTracking、HalfCycleTime、ArrivalPauseTime、BackPauseTime 与 Duration 配置循环、返程和时序，再调用 Start/Pause/Resume/Backtrack/Stop 控制运动。运动器通过 OnMotorStart / OnMotorStop 事件回调感知状态。

## 代码示例

### 创建旋转运动器并设置角速度

```lua
-- @runtime client
local World = game:GetService('World')
local target = World:CreateUnit('WorldUnit', {
    Position = Vector3.New(0, 3, 0),
})
local motor = World:CreateUnit('AngularMotorUnit', {
    Parent = target,
    AngularVelocity = Vector3.New(0, 90, 0),
})

motor:Start()
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `AngularVelocity` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | 角速度属性，用于设置或获取角马达单元旋转的角速度。该属性为三维向量，分别对应绕X、Y、Z轴的旋转速度。 |

## 关联类型

* [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
