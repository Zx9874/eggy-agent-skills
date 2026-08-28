# ClickDetector

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[ClickDetector]**（2 属性 / 2 事件）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

点击检测器是一种挂载在其他单位上的交互组件，用于捕捉玩家对目标物体的左键与右键点击操作。它通过最大激活距离控制交互生效范围，并以启用开关决定是否响应点击；在有效点击发生时，会触发对应事件并将触发玩家作为参数传出。

## 适用场景

在场景中需要让玩家通过点击某个单位触发后续逻辑时，可为其创建一个点击检测器，监听左键与右键事件并区分不同操作，再在事件回调中执行对应处理。

## 使用要点

先通过 World:CreateUnit("ClickDetector", { Parent = 目标单位, MaxActivationDistance = 距离, Enabled = true }) 创建并挂载实例，随后对 MouseClick 与 RightMouseClick 事件调用 Connect 注册回调；回调中可通过 player 参数识别触发玩家，也可在回调内修改 MaxActivationDistance 或 Enabled 属性，动态调整后续交互的生效距离与可用状态。

## 注意事项

[ClickDetector](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ClickDetector.html) 的触发端与部署环境有关，实测存在客户端与服务端都可监听到事件的情况。若同一交互同时在双端监听，请在业务层去重；MouseClick/RightMouseClick 回调中的 player 参数用于识别触发交互的玩家。

## 代码示例

### 创建点击检测器并监听一次左键点击

```lua
-- @runtime client
local world = game:GetService("World")
local target = world:CreateUnit("WorldUnit", { Position = Vector3.New(0, 2, 0) })
local detector = world:CreateUnit("ClickDetector", {
    Parent = target,
    MaxActivationDistance = 15,
    Enabled = true,
})
detector.MouseClick:Once(function(player)
    print("点击玩家:", player:GetName())
end)
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `MaxActivationDistance` | `Float` | `32.0` | 玩家与物体之间的最大距离，超过此距离点击事件不会触发。 |
| `Enabled` | `Bool` | `true` | 控制 [ClickDetector](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ClickDetector.html) 是否启用点击检测。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (2)

### MouseClick

签名：`MouseClick(player: Player)` 触发：`local`

当玩家使用鼠标左键点击带有 [ClickDetector](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ClickDetector.html) 检测器的单位时触发的事件，回调函数会收到触发本次点击的玩家对象。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 触发的玩家 |

> 示例代码

> 监听鼠标左键点击

```lua
-- @runtime client
-- 获取世界服务
local world = game:GetService("World")
-- 创建一个单位作为点击检测器的挂载对象
local triggerUnit = world:CreateUnit("WorldUnit", { Position = Vector3.New(0, 1, 0) })
-- 创建点击检测器并挂载到单位上
local detector = world:CreateUnit("ClickDetector", {
    Parent = triggerUnit,
    MaxActivationDistance = 10, -- 最大激活距离
    Enabled = true, -- 启用点击检测
})
-- 监听左键点击事件（单次触发）
detector.MouseClick:Once(function(player)
    print("玩家左键点击了目标单位：", player:GetName())
end)
```

### RightMouseClick

签名：`RightMouseClick(player: Player)` 触发：`local`

当玩家使用鼠标右键点击带有 [ClickDetector](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ClickDetector.html) 检测器的单位时触发的事件，回调函数会收到触发本次点击的玩家对象。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 触发的玩家 |

> 示例代码

> 监听鼠标右键点击

```lua
-- @runtime client
-- 获取世界服务
local world = game:GetService("World")
-- 创建另一个挂载单位
local triggerUnit = world:CreateUnit("WorldUnit", { Position = Vector3.New(5, 0, 5) })
-- 创建点击检测器
local detector = world:CreateUnit("ClickDetector", {
    Parent = triggerUnit,
    MaxActivationDistance = 5, -- 较短激活距离
    Enabled = true,
})
-- 监听右键点击事件（单次触发）
detector.RightMouseClick:Once(function(player)
    print("玩家右键点击了目标单位：", player:GetName())
end)
```
