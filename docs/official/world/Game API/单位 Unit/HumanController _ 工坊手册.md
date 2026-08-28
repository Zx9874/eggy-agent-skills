# HumanController

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BaseController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html)（12 属性 / 22 函数 / 11 事件）
    - **[HumanController]**（6 属性 / 2 函数 / 6 事件）

### 继承成员

2 个来源 / 16 属性 / 47 函数 / 17 事件

* 来自 [BaseController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html)（12 属性 / 22 函数 / 11 事件）
  + 属性：[`Health`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#properties)、[`MaxHealth`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#properties)、[`MaxMultiJumpCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#properties)、[`MultiJumpCooldown`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#properties)、[`WalkSpeed`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#properties)、[`JumpPower`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#properties)、[`GravityEnabled`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#properties)、[`HPBarShowMode`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#properties)、[`DisplayDistanceType`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#properties)、[`NameDisplayDistance`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#properties)、[`HealthDisplayDistance`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#properties)、[`AutoRotate`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#properties)
  + 函数：[`GetState`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`ChangeState`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`SetStateEnabled`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`GetStateEnabled`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`GetExtraStates`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`AddExtraState`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`RemoveExtraState`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`RegisterCustomState`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`RegisterExtraState`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`UnRegisterExtraState`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`UnRegisterCustomState`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`Move`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`MoveTo`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`Jump`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`IsGrounded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`GetFloor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`TakeDamage`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`Heal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`Reborn`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`SetPhysicsActive`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`ApplyForce`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)、[`SetMaxLinearVelocity`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#functions)
  + 事件：[`StateChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#events)、[`ExtraStatesChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#events)、[`OnLanded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#events)、[`OnStartFalling`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#events)、[`Died`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#events)、[`HealthChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#events)、[`MoveToFinished`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#events)、[`OnReborn`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#events)、[`OnJump`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#events)、[`OnCollisionEnter`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#events)、[`OnCollisionExit`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html#events)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

人形生物控制器，是附着在人形单位上的行为控制组件，负责驱动角色移动、坐立等状态，并提供运行速度与落地速度的查询接口。它同时监听攀爬、奔跑、坠落、起身、自由落体以及坐下等状态变化事件，便于上层逻辑响应角色的行为切换。此外还可配置目标点、状态机开关、惯性以及名称显示偏移等参数。

## 适用场景

在需要对玩家或 NPC 人形角色进行移动控制和状态感知时使用，例如根据奔跑或攀爬事件触发动作表现，或通过目标点引导角色走向指定位置。

## 使用要点

通过 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html) 的控制器属性获取实例，先使用类型判定确认角色为人形单位后再访问专属成员。可读取或设置目标点、坐立等属性，调用获得移动速度与相对地面速度的方法，并监听奔跑、攀爬、坐下等状态事件来驱动游戏逻辑。

## 注意事项

[HumanController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanController.html) 只能从 HumanUnit.Controller 获取；Players.LocalPlayer.Character 也可能是 [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) 等其它角色类型，调用 [HumanController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanController.html) 专属成员前必须先用 IsA("HumanUnit") 判定。

## 代码示例

### 从 HumanUnit.Controller 获取控制器

```lua
-- @runtime client
-- @contract-audit exempt: HumanUnit.Controller 的 Meta 返回类型仍为 EggyController，但当前 Editor 已实测返回支持 HumanController 专属成员的控制器；等待上游 Meta 对齐
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

if localPlayer ~= nil and localPlayer.Character ~= nil then
    local humanUnit = localPlayer.Character
    if not humanUnit:IsA("HumanUnit") then return end
    local controller = humanUnit.Controller
    if controller ~= nil then
        local velocity = controller:GetMoveVelocity()
        print("移动速度:", velocity)
    end
end
```

## 属性 (6)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `SeatPart` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | `-` | 当前人类单位坐下时关联的座椅部件单位。该属性用于获取角色当前所坐的座椅单位。 |
| `Sit` | `Bool` | `false` | 控制角色是否处于坐下状态，设置为 true 时角色会尝试坐下。 |
| `TargetPoint` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | 角色移动的目标点。 |
| `EvaluateStateMachine` | `Bool` | `true` | 是否启用内置状态机评估（移动、跳跃、下落等）。关闭后状态机副作用暂停，但脚本驱动 ChangeState 仍可用 |
| `InertiaEnabled` | `Bool` | `true` | 是否启用引擎层惯性位移。设为 false 时，人物在 Move / MoveTo 停止后立即静止，不再因惯性继续向前滑动；恢复为 true 时还原原有反向加速度 |
| `NameBarOffset` | `Float` | `0.0` | 设置角色头顶名称显示的高度偏移量。 |

## 关联类型

* [BaseController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 事件 (6)

### Climbing

签名：`Climbing(speed: Float)` 触发：`local`

当角色开始或结束攀爬状态时触发，参数 speed 表示当前攀爬速度。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `speed` | `Float` | 当前攀爬速度 |

> 示例代码

> 监听角色攀爬速度

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local humanUnit = localPlayer ~= nil and localPlayer.Character or nil
if humanUnit == nil or not humanUnit:IsA("HumanUnit") then return end
local controller = humanUnit ~= nil and humanUnit.Controller or nil
if controller ~= nil then
    controller.Climbing:Once(function(speed)
        print("攀爬速度:", speed)
    end)
end
```

### Running

签名：`Running(speed: Float)` 触发：`local`

当角色奔跑时持续触发，参数 speed 表示当前奔跑速度。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `speed` | `Float` | 当前水平移动速度 |

> 示例代码

> 监听角色奔跑速度

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local humanUnit = localPlayer ~= nil and localPlayer.Character or nil
if humanUnit == nil or not humanUnit:IsA("HumanUnit") then return end
local controller = humanUnit ~= nil and humanUnit.Controller or nil
if controller ~= nil then
    controller.Running:Once(function(speed)
        print("水平移动速度:", speed)
    end)
end
```

### FallingDown

签名：`FallingDown(active: Bool)` 触发：`local`

当角色进入或退出摔倒状态时触发，参数 active 为 true 表示开始摔倒，false 表示结束摔倒。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `active` | `Bool` | true=进入绊倒，false=离开绊倒 |

> 示例代码

> 监听角色绊倒状态

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local humanUnit = localPlayer ~= nil and localPlayer.Character or nil
if humanUnit == nil or not humanUnit:IsA("HumanUnit") then return end
local controller = humanUnit ~= nil and humanUnit.Controller or nil
if controller ~= nil then
    controller.FallingDown:Once(function(active)
        print("绊倒状态:", active)
    end)
end
```

### GettingUp

签名：`GettingUp(active: Bool)` 触发：`local`

当角色开始或结束起身动作时触发，参数 active 为 true 表示开始起身，false 表示起身完成。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `active` | `Bool` | true=开始起身，false=起身完成 |

> 示例代码

> 监听角色起身状态

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local humanUnit = localPlayer ~= nil and localPlayer.Character or nil
if humanUnit == nil or not humanUnit:IsA("HumanUnit") then return end
local controller = humanUnit ~= nil and humanUnit.Controller or nil
if controller ~= nil then
    controller.GettingUp:Once(function(active)
        print("起身状态:", active)
    end)
end
```

### FreeFalling

签名：`FreeFalling(active: Bool)` 触发：`local`

当角色进入或退出自由落体状态时触发，参数 active 为 true 表示开始自由落体，false 表示结束自由落体。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `active` | `Bool` | true=开始下落，false=落地 |

> 示例代码

> 监听角色自由下落状态

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local humanUnit = localPlayer ~= nil and localPlayer.Character or nil
if humanUnit == nil or not humanUnit:IsA("HumanUnit") then return end
local controller = humanUnit ~= nil and humanUnit.Controller or nil
if controller ~= nil then
    controller.FreeFalling:Once(function(active)
        print("自由下落:", active)
    end)
end
```

### Seated

签名：`Seated(active: Bool, seat: Unit)` 触发：`local`

当人类单位坐下或离开座椅时触发。事件会携带两个参数：active 表示当前是否处于坐下状态，seat 表示关联的座椅单位。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `active` | `Bool` | true=坐下，false=起身 |
| `seat` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 座位 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) |

> 示例代码

> 监听角色坐下状态

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local humanUnit = localPlayer ~= nil and localPlayer.Character or nil
if humanUnit == nil or not humanUnit:IsA("HumanUnit") then return end
local controller = humanUnit ~= nil and humanUnit.Controller or nil
if controller ~= nil then
    controller.Seated:Once(function(active, seat)
        print("坐下状态:", active, "座位:", seat)
    end)
end
```

## 函数 (2)

### GetMoveVelocity

签名：`GetMoveVelocity() -> Vector3 (当前移动速度向量)`

返回角色当前的移动速度向量。

⚙ 返回角色当前的移动速度向量（来自 Controller 输入），与 BasePart.AssemblyLinearVelocity（物理装配体线速度）含义不同：前者反映操控意图，后者反映实际物理运动。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) (当前移动速度向量)

> 示例代码

> 从 HumanUnit.Controller 获取移动速度

```lua
-- @runtime client
-- HumanController 通过 HumanUnit.Controller 属性获取
-- @contract-audit exempt: HumanUnit.Controller 的 Meta 返回类型仍为 EggyController，但当前 Editor 已实测返回支持 HumanController 专属成员的控制器；等待上游 Meta 对齐
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer and localPlayer.Character then
    local humanUnit = localPlayer.Character
    if not humanUnit:IsA("HumanUnit") then return end
    local controller = humanUnit.Controller
    if controller ~= nil then
        local velocity = controller:GetMoveVelocity()
        print(string.format('移动速度: %s', tostring(velocity)))
    end
end
```

### GetRelativeVelocityAtFloor

签名：`GetRelativeVelocityAtFloor() -> Vector3 (相对于站立表面的速度向量（世界空间方向）)`

返回角色相对于站立表面的速度向量（世界空间方向）。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) (相对于站立表面的速度向量（世界空间方向）)

> 示例代码

> 从 HumanUnit.Controller 获取相对地面速度

```lua
-- @runtime client
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local humanUnit = localPlayer ~= nil and localPlayer.Character or nil
if humanUnit == nil or not humanUnit:IsA("HumanUnit") then return end
local controller = humanUnit ~= nil and humanUnit.Controller or nil
if controller ~= nil then
    local velocity = controller:GetRelativeVelocityAtFloor()
    print("相对地面速度:", velocity)
end
```
