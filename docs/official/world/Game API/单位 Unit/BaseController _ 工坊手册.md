# BaseController

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[BaseController]**（12 属性 / 22 函数 / 11 事件）
    - [EggyController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyController.html)（7 属性 / 4 函数 / 4 事件）
    - [HumanController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanController.html)（6 属性 / 2 函数 / 6 事件）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[BaseController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html) 是角色控制器的基类，负责生命值、移动、跳跃和状态切换等通用行为；实例通过 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html)、[EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) 等公开角色类型的 Controller 属性获取，基础 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 不声明 Controller。

## 适用场景

需要读取或切换角色状态、控制移动和跳跃、处理生命值，或监听落地、死亡、碰撞等角色事件时使用。

## 使用要点

客户端通常通过 Players.LocalPlayer.Character.Controller 获取当前角色控制器；获取角色与 Controller 后先判空，再调用 Move、Jump、GetState 等接口或监听状态事件。涉及伤害、复活等会影响游戏状态的操作时，应由业务的权威端决定是否执行。

## 注意事项

Controller 依附于具体角色单位，常见路径是 Players.LocalPlayer.Character.Controller；不要泛化为所有 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 都有 Controller 属性。当前公开 Meta 中 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html)、[EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) 等角色单位暴露 Controller，基础 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 不暴露该属性。

## 代码示例

### 读取当前玩家角色的控制器状态

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local controller = character and character.Controller
if controller == nil then
    return
end

print('当前角色状态:', controller:GetState())
```

## 属性 (12)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Health` | `Float` | `100.0` | 当前生命值。 |
| `MaxHealth` | `Float` | `100.0` | 最大生命值。 |
| `MaxMultiJumpCount` | `Int` | `1` | 允许的最大多段跳次数。 |
| `MultiJumpCooldown` | `Float` | `0.35` | 多段跳之间的冷却时间（秒）。 |
| `WalkSpeed` | `Float` | `7.0` | 移动速度。 |
| `JumpPower` | `Float` | `23.0` | 跳跃时的垂直初速度。 |
| `GravityEnabled` | `Bool` | `true` | 是否启用重力。 |
| `HPBarShowMode` | [HpBarShowMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/HpBarShowMode.html) | `Enums.HpBarShowMode.None` | 血条显示模式。 |
| `DisplayDistanceType` | [DisplayDistanceType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DisplayDistanceType.html) | `Enums.DisplayDistanceType.Viewer` | 控制角色头顶名字和血条的显示距离计算方式。 |
| `NameDisplayDistance` | `Float` | `20.0` | 名字显示距离。 |
| `HealthDisplayDistance` | `Float` | `20.0` | 血条显示距离。 |
| `AutoRotate` | `Bool` | `true` | 是否自动朝向移动方向。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (11)

### StateChanged

签名：`StateChanged(old: ControllerStateType, new: ControllerStateType)` 触发：`local`

当角色的主状态发生变化时触发，返回变化前后的状态类型。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `old` | [ControllerStateType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ControllerStateType.html) | 旧状态 |
| `new` | [ControllerStateType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ControllerStateType.html) | 新状态 |

> 示例代码

> 事件示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
baseController.StateChanged:Once(function(old, new)
    print("old: " .. tostring(old))
end)
```

### ExtraStatesChanged

签名：`ExtraStatesChanged(old: String[], new: String[])` 触发：`local`

当角色的附加状态列表发生变化时触发，返回变化前后的附加状态名数组。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `old` | `String[]` | 旧附加状态列表 |
| `new` | `String[]` | 新附加状态列表 |

> 示例代码

> 事件示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
baseController.ExtraStatesChanged:Once(function(old, new)
    print("old: " .. tostring(old))
end)
```

### OnLanded

签名：`OnLanded()` 触发：`local`

落地时触发，仅客户端生效。

> 示例代码

> 事件示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
baseController.OnLanded:Once(function()
    print("OnLanded event")
end)
```

### OnStartFalling

签名：`OnStartFalling()` 触发：`local`

开始下落时触发，仅客户端生效。

> 示例代码

> 事件示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
baseController.OnStartFalling:Once(function()
    print("OnStartFalling event")
end)
```

### Died

签名：`Died()` 触发：`local`

角色死亡时触发。

> 示例代码

> 事件示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
baseController.Died:Once(function()
    print("Died event")
end)
```

### HealthChanged

签名：`HealthChanged(health: Float)` 触发：`local`

当角色的生命值发生变化时触发，返回当前生命值。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `health` | `Float` | 当前生命值 |

> 示例代码

> 事件示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
baseController.HealthChanged:Once(function(health)
    print("health: " .. tostring(health))
end)
```

### MoveToFinished

签名：`MoveToFinished(isReached: Bool)` 触发：`local`

当 MoveTo 移动结束时触发，返回是否成功到达目标。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `isReached` | `Bool` | 是否到达目的地 |

> 示例代码

> 事件示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
baseController.MoveToFinished:Once(function(isReached)
    print("isReached: " .. tostring(isReached))
end)
```

### OnReborn

签名：`OnReborn(unit: SpaceUnit)` 触发：`local`

当控制器所属单位完成复活时触发。该事件用于通知外部单位已经复活，可执行复活后的逻辑处理。事件参数 unit 提供了触发本次事件的单位实例，类型为 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `unit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 触发的生物 |

> 示例代码

> 监听复活事件并触发复活

```lua
-- @runtime client
-- 获取本地玩家角色控制器
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end

-- 监听一次角色复活事件，回调参数为触发复活的单位
baseController.OnReborn:Once(function(unit)
    print("角色复活，触发单位存在：", unit ~= nil)
end)

-- 主动调用复活，让上述事件产生响应
baseController:Reborn()
```

### OnJump

签名：`OnJump(unit: SpaceUnit)` 触发：`local`

当控制器所属单位执行起跳动作时触发。该事件用于通知外部单位已经开始跳跃。事件参数 unit 提供了触发本次事件的单位实例，类型为 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `unit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 触发的生物 |

> 示例代码

> 监听起跳事件并触发起跳

```lua
-- @runtime client
-- 获取本地玩家角色控制器
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end

-- 监听一次角色起跳事件，回调参数为触发起跳的单位
baseController.OnJump:Once(function(unit)
    print("角色起跳，触发单位存在：", unit ~= nil)
end)

-- 主动调用跳跃，让上述事件产生响应
baseController:Jump()
```

### OnCollisionEnter

签名：`OnCollisionEnter(other: Unit, info: Table)` 触发：`local`

控制器所属单位与其他单位开始发生碰撞时触发的事件。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 碰撞的对方对象 |
| `info` | `Table` | 碰撞信息，包含point和normal |

> 示例代码

> 监听角色碰撞进入事件

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end

-- 监听一次碰撞进入：回调参数 other 为碰撞到的单位，info 为碰撞详情
baseController.OnCollisionEnter:Once(function(other, info)
    print("发生碰撞进入，对方单位：", other.Name)
    print("碰撞详情：", info)
end)
```

### OnCollisionExit

签名：`OnCollisionExit(other: Unit)` 触发：`local`

控制器所属单位与其他单位结束碰撞时触发的事件。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 碰撞的对方对象 |

> 示例代码

> 监听角色碰撞结束事件

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end

-- 监听一次碰撞结束：回调参数 other 为离开碰撞的单位
baseController.OnCollisionExit:Once(function(other)
    print("碰撞结束，离开单位：", other.Name)
end)
```

## 函数 (22)

### GetState

签名：`GetState() -> ControllerStateType (当前状态类型)`

获取角色当前的主状态类型。

**返回值** [ControllerStateType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ControllerStateType.html) (当前状态类型)

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local result = baseController:GetState()  -- 返回 ControllerStateType
if result ~= nil then
    print("调用成功，结果: " .. tostring(result))
end
```

### ChangeState

签名：`ChangeState(state: ControllerStateType) -> void`

将角色切换到指定的主状态。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `state` | [ControllerStateType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ControllerStateType.html) | 目标状态 |

**返回值** `void`

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local state = Enums.ControllerStateType.Idle  -- ControllerStateType
baseController:ChangeState(state)
print("调用完成", baseController)
```

### SetStateEnabled

签名：`SetStateEnabled(state: ControllerStateType, enabled: Bool) -> void`

启用或禁用指定的主状态。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `state` | [ControllerStateType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ControllerStateType.html) | 指定状态 |
| `enabled` | `Bool` | 是否启用 |

**返回值** `void`

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local state = Enums.ControllerStateType.Idle  -- ControllerStateType
local enabled = true  -- Bool
baseController:SetStateEnabled(state, enabled)
local currentValue = baseController:GetStateEnabled(state)
if currentValue ~= nil then
    print("当前值: " .. tostring(currentValue))
end
```

### GetStateEnabled

签名：`GetStateEnabled(state: ControllerStateType) -> Bool (该状态是否已启用)`

查询指定主状态是否已启用。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `state` | [ControllerStateType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ControllerStateType.html) | 指定状态 |

**返回值** `Bool` (该状态是否已启用)

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local state = Enums.ControllerStateType.Idle  -- ControllerStateType
local result = baseController:GetStateEnabled(state)  -- 返回 Bool
if result then
    print("调用结果为 true")
else
    print("调用结果为 false")
end
```

### GetExtraStates

签名：`GetExtraStates() -> String[] (附加状态名列表)`

获取角色当前所有附加状态的名称列表。

**返回值** `String[]` (附加状态名列表)

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local result = baseController:GetExtraStates()  -- 返回 String[]
if result ~= nil then
    for index, item in ipairs(result) do
        print(index, item)
    end
end
```

### AddExtraState

签名：`AddExtraState(stateName: String) -> Bool (是否添加成功)`

为角色添加一个附加状态。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `stateName` | `String` | 附加状态名 |

**返回值** `Bool` (是否添加成功)

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local stateName = "default"  -- String
local result = baseController:AddExtraState(stateName)  -- 返回 Bool
if result then
    print("调用结果为 true")
else
    print("调用结果为 false")
end
```

### RemoveExtraState

签名：`RemoveExtraState(stateName: String) -> Bool (是否删除成功)`

移除指定的附加状态。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `stateName` | `String` | 附加状态名 |

**返回值** `Bool` (是否删除成功)

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local stateName = "default"  -- String
local result = baseController:RemoveExtraState(stateName)  -- 返回 Bool
if result then
    print("调用结果为 true")
else
    print("调用结果为 false")
end
```

### RegisterCustomState

签名：`RegisterCustomState(stateName: String, onPreEnter: Function, onEnter: Function, onPreLeave: Function, onLeave: Function) -> Bool (是否注册成功)`

注册一个自定义主状态，并指定进入和离开时的回调函数。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `stateName` | `String` | 状态名称 |
| `onPreEnter` | `Function` | 预进入回调 |
| `onEnter` | `Function` | 进入回调 |
| `onPreLeave` | `Function` | 预离开回调 |
| `onLeave` | `Function` | 离开回调 |

**返回值** `Bool` (是否注册成功)

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local stateName = "default"  -- String
local onPreEnter = function() end  -- Function
local onEnter = function() end  -- Function
local onPreLeave = function() end  -- Function
local onLeave = function() end  -- Function
local result = baseController:RegisterCustomState(stateName, onPreEnter, onEnter, onPreLeave, onLeave)  -- 返回 Bool
if result then
    print("调用结果为 true")
else
    print("调用结果为 false")
end
```

### RegisterExtraState

签名：`RegisterExtraState(stateName: String, onPreEnter: Function, onEnter: Function, onPreLeave: Function, onLeave: Function) -> Bool (是否注册成功)`

注册一个自定义附加状态，并指定进入和离开时的回调函数。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `stateName` | `String` | 状态名称 |
| `onPreEnter` | `Function` | 预进入回调 |
| `onEnter` | `Function` | 进入回调 |
| `onPreLeave` | `Function` | 预离开回调 |
| `onLeave` | `Function` | 离开回调 |

**返回值** `Bool` (是否注册成功)

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local stateName = "default"  -- String
local onPreEnter = function() end  -- Function
local onEnter = function() end  -- Function
local onPreLeave = function() end  -- Function
local onLeave = function() end  -- Function
local result = baseController:RegisterExtraState(stateName, onPreEnter, onEnter, onPreLeave, onLeave)  -- 返回 Bool
if result then
    print("调用结果为 true")
else
    print("调用结果为 false")
end
```

### UnRegisterExtraState

签名：`UnRegisterExtraState(stateName: String) -> Bool (是否取消注册成功)`

取消注册一个自定义附加状态。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `stateName` | `String` | 状态名称 |

**返回值** `Bool` (是否取消注册成功)

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local stateName = "default"  -- String
local result = baseController:UnRegisterExtraState(stateName)  -- 返回 Bool
if result then
    print("调用结果为 true")
else
    print("调用结果为 false")
end
```

### UnRegisterCustomState

签名：`UnRegisterCustomState(stateName: String) -> Bool (是否取消注册成功)`

取消注册一个自定义主状态。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `stateName` | `String` | 状态名称 |

**返回值** `Bool` (是否取消注册成功)

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local stateName = "default"  -- String
local result = baseController:UnRegisterCustomState(stateName)  -- 返回 Bool
if result then
    print("调用结果为 true")
else
    print("调用结果为 false")
end
```

### Move

签名：`Move(moveDirection: Vector3, relativeToCamera: Bool) -> void`

让角色按指定方向持续移动。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `moveDirection` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 移动方向 |
| `relativeToCamera` | `Bool` | 是否相对于相机 |

**返回值** `void`

> 示例代码

> 按镜头方向移动当前角色

```lua
-- @runtime client
local Players = game:GetService("Players")
local player = Players.LocalPlayer
if player == nil then return end
local character = player and player.Character
local controller = character and character.Controller
if controller == nil then return end
controller:Move(Vector3.New(1, 0, 0), true)
```

### MoveTo

签名：`MoveTo(position: Vector3, targetUnit: Unit) -> void`

使控制器控制所属单位向指定位置或目标对象移动。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 目标位置 |
| `targetUnit` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 目标模型(可选) |

**返回值** `void`

> 示例代码

> 通过角色 Controller 让角色移动到目标位置

```lua
-- @runtime client
-- BaseController 通过角色宿主单位的 .Controller 属性获取
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer.Character
if character == nil then
    return
end
local baseController = character.Controller
if baseController == nil then
    return
end

-- MoveTo(目标位置, 目标单位(可选))
local position = Vector3.New(0, 0, 0)
baseController:MoveTo(position)
print("调用完成", baseController)
```

### Jump

签名：`Jump() -> void`

执行一次跳跃。

**返回值** `void`

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
baseController:Jump()
print("调用完成", baseController)
```

### IsGrounded

签名：`IsGrounded() -> Bool (是否地面站立)`

判断角色是否处于地面站立状态。

**返回值** `Bool` (是否地面站立)

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local result = baseController:IsGrounded()  -- 返回 Bool
if result then
    print("调用结果为 true")
else
    print("调用结果为 false")
end
```

### GetFloor

签名：`GetFloor() -> SpaceUnit (脚下所踩Unit)`

获取角色脚下所踩的对象。

**返回值** [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) (脚下所踩[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html))

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local result = baseController:GetFloor()  -- 返回 SpaceUnit
if result ~= nil then
    print("调用成功，结果: " .. tostring(result))
end
```

### TakeDamage

签名：`TakeDamage(damage: Float) -> void`

对角色造成指定数值的伤害。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `damage` | `Float` | 伤害数值 |

**返回值** `void`

> 示例代码

> 在服务端对角色控制器结算伤害

```lua
-- @runtime server
local function applyDamage(controller, amount)
    if controller == nil or amount <= 0 then return end
    controller:TakeDamage(amount)
end
```

### Heal

签名：`Heal(health: Float) -> void`

为角色恢复指定数值的生命值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `health` | `Float` | 治疗数值 |

**返回值** `void`

> 示例代码

> 在服务端治疗角色控制器

```lua
-- @runtime server
local function healController(controller, amount)
    if controller == nil or amount <= 0 then return end
    controller:Heal(amount)
end
```

### Reborn

签名：`Reborn() -> void`

复活角色。

**返回值** `void`

> 示例代码

> 在服务端复活角色

```lua
-- @runtime server
local function rebornController(controller)
    if controller ~= nil then controller:Reborn() end
end
```

### SetPhysicsActive

签名：`SetPhysicsActive(active: Bool) -> void`

设置角色的物理模拟是否激活。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `active` | `Bool` | 物理开关 |

**返回值** `void`

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local active = true  -- Bool
baseController:SetPhysicsActive(active)
print("已调用 SetPhysicsActive", active)
```

### ApplyForce

签名：`ApplyForce(force: Vector3) -> void`

对角色施加一个力。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `force` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 施加的力 |

**返回值** `void`

> 示例代码

> 给当前角色施加向上的力

```lua
-- @runtime client
local Players = game:GetService("Players")
local player = Players.LocalPlayer
if player == nil then return end
local character = player and player.Character
local controller = character and character.Controller
if controller == nil then return end
controller:ApplyForce(Vector3.New(0, 200, 0))
```

### SetMaxLinearVelocity

签名：`SetMaxLinearVelocity(velocity: Float) -> void`

设置角色的最大线速度。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `velocity` | `Float` | 最大线速度 |

**返回值** `void`

> 示例代码

> 调用示例

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer and localPlayer.Character
local baseController = character and character.Controller
if baseController == nil then return end
local velocity = 10.0  -- Float
baseController:SetMaxLinearVelocity(velocity)
print("已调用 SetMaxLinearVelocity", velocity)
```
