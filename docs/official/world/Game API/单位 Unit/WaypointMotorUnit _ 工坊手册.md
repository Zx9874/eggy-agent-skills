# WaypointMotorUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)（8 属性 / 5 函数 / 2 事件）
    - **[WaypointMotorUnit]**（1 属性）

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

路径点运动器，用于驱动已在编辑器或预配置实例中设置好路线的对象沿路径运动。

## 适用场景

适合移动平台、巡逻物体和按固定路径往返的机关。

## 使用要点

在服务端获取已经配置好路线的 [WaypointMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WaypointMotorUnit.html) 实例，确认目标实例存在后调用 Start()、Pause()、Resume() 或 Stop() 控制运动流程。

## 注意事项

[WaypointMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WaypointMotorUnit.html) 继承 [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html) 的启动语义：路线数据应由编辑器或预配置实例提供；当前公开 Lua Meta 只暴露运动器通用控制成员，不提供脚本直接写入路线点结构的稳定接口。

## 代码示例

### 服务端启动已配置的路径点运动器

```lua
-- @runtime server
local World = game:GetService("World")

local motor = World:FindFirstChild("MovingPlatformMotor", true)
if motor == nil or not motor:IsA("WaypointMotorUnit") then
    print("请先在编辑器中配置 WaypointMotorUnit 实例")
    return
end

motor.OnMotorStart:Connect(function()
    print("路径点运动开始")
end)

motor:Start()
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |

## 关联类型

* [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)
