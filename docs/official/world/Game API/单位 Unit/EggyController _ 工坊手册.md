# EggyController

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BaseController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html)（12 属性 / 22 函数 / 11 事件）
    - **[EggyController]**（7 属性 / 4 函数 / 4 事件）

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

[EggyController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyController.html) 是 [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) 的控制器组件，通过 EggyUnit.Controller 属性获取，用于触发前扑、翻滚、抓举和投掷等蛋仔角色动作。

## 适用场景

当脚本需要控制当前玩家角色或场景中的 [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) 执行动作时，先取得该 [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) 的 Controller，再调用 Rush/Fling/Lift/Throw 等接口。

## 使用要点

通过 .Controller 属性取得控制器。Lift 的 force\_lift\_unit 在最新 Meta 中为可选参数：省略时尝试抓举身前目标；需要强制指定目标时，传入已经存在的 [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) 实例。当前运行包即使抓举成功也可能不触发 OnLiftBegin，不要把该事件作为成功判据。

## 注意事项

[EggyController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyController.html) 通过 EggyUnit.Controller 属性获取。Lift 可省略 force\_lift\_unit；若传入，该值必须是场景中已存在的 [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) 实例。当前运行包实测 Lift 成功时 OnLiftBegin 仍可能不触发；在运行时事件实现与 Meta 对齐前，不要依赖 OnLiftBegin 驱动抓举后的关键业务逻辑。

## 代码示例

### 从 EggyUnit.Controller 获取控制器并执行动作

```lua
-- @runtime client
-- EggyController 通过 EggyUnit.Controller 属性获取
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer and localPlayer.Character then
    local eggyUnit = localPlayer.Character
    local controller = eggyUnit.Controller  -- 通过 Controller 属性获取
    if controller ~= nil then
        -- 执行前扑动作
        controller:Rush()
        print('EggyController 已触发 Rush')
    end
end
```

## 属性 (7)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `LiftedEnabled` | `Bool` | `true` | 是否允许蛋仔被其他蛋仔抓举。 |
| `RollCDTime` | `Float` | `0.1` | 蛋仔滚动技能的冷却时间。 |
| `RollTime` | `Float` | `3.5` | 蛋仔单次滚动持续的时间。 |
| `RollChargeTime` | `Float` | `15.0` | 蛋仔滚动技能充能所需的时间。 |
| `RollSpeed` | `Float` | `13.0` | 蛋仔滚动时的移动速度。 |
| `ClimbEnabled` | `Bool` | `false` | 是否允许蛋仔进行攀爬。 |
| `ClimbSpeed` | `Float` | `3.0` | 蛋仔攀爬时的移动速度。 |

## 关联类型

* [BaseController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html)

## 事件 (4)

### OnLiftBegin

签名：`OnLiftBegin(liftedUnit: SpaceUnit)` 触发：`local`

当本控制器所属单位开始抓举其他单位时触发。

⚙ 最新 Meta 已声明 OnLiftBegin；当前运行包实测调用 Lift 成功抓举目标时仍可能不触发。在运行时事件实现与 Meta 对齐前，该事件只能作为辅助观察信号，不能作为抓举成功判据或关键业务逻辑的唯一入口。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `liftedUnit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 举起的单位 |

> 示例代码

> 当前版本的事件可用性说明

```lua
-- @runtime client
print('当前运行包可能不触发 OnLiftBegin，请勿依赖该事件驱动关键逻辑')
```

### OnLiftEnd

签名：`OnLiftEnd()` 触发：`local`

当本控制器所属单位结束抓举（扔出或打断）时触发。

> 示例代码

> 监听抓举结束

```lua
-- @runtime client
local Players = game:GetService("Players")
local character = Players.LocalPlayer and Players.LocalPlayer.Character
local controller = character and character.Controller
if controller == nil then return end
controller.OnLiftEnd:Once(function()
    print("抓举已结束")
end)
```

### OnLiftedBegin

签名：`OnLiftedBegin(liftunit: EggyUnit)` 触发：`local`

当本控制器所属单位被其他生物抓举起时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `liftunit` | [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) | 举起当前对象的生物 |

> 示例代码

> 监听开始被抓举

```lua
-- @runtime client
local Players = game:GetService("Players")
local character = Players.LocalPlayer and Players.LocalPlayer.Character
local controller = character and character.Controller
if controller == nil then return end
controller.OnLiftedBegin:Once(function(liftUnit)
    print("被单位抓举:", liftUnit and liftUnit.Name)
end)
```

### OnLiftedEnd

签名：`OnLiftedEnd()` 触发：`local`

当本控制器所属单位结束被抓举状态时触发。

> 示例代码

> 监听结束被抓举

```lua
-- @runtime client
local Players = game:GetService("Players")
local character = Players.LocalPlayer and Players.LocalPlayer.Character
local controller = character and character.Controller
if controller == nil then return end
controller.OnLiftedEnd:Once(function()
    print("已结束被抓举状态")
end)
```

## 函数 (4)

### Rush

签名：`Rush() -> void`

让蛋仔执行一次前扑动作。

**返回值** `void`

> 示例代码

> 前扑

```lua
-- @runtime client
local Players = game:GetService("Players")
local eggyUnit = Players.LocalPlayer and Players.LocalPlayer.Character
local controller = eggyUnit and eggyUnit.Controller
if controller ~= nil then
    controller:Rush()  -- 执行一次前扑
end
```

### Fling

签名：`Fling() -> void`

让蛋仔执行一次翻滚动作。

**返回值** `void`

> 示例代码

> 翻滚

```lua
-- @runtime client
local Players = game:GetService("Players")
local eggyUnit = Players.LocalPlayer and Players.LocalPlayer.Character
local controller = eggyUnit and eggyUnit.Controller
if controller ~= nil then
    controller:Fling()  -- 执行一次翻滚
end
```

### Lift

签名：`Lift(force_lift_unit?: EggyUnit) -> void`

尝试抓举身前的目标单位，可通过可选参数指定强制抓举对象。

⚙ force\_lift\_unit 是可选参数；省略时尝试抓举身前目标，传入时必须是已存在的 [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html)。当前运行包实测抓举成功时 OnLiftBegin 仍可能不触发；Lift 调用与事件回调不能互相作为成功验证。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `force_lift_unit?` | [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) | 强制抓举目标 |

**返回值** `void`

> 示例代码

> 抓举目标单位

```lua
-- @runtime client
local World = game:GetService("World")
local Players = game:GetService("Players")
local eggyUnit = Players.LocalPlayer and Players.LocalPlayer.Character
local controller = eggyUnit and eggyUnit.Controller
-- force_lift_unit 可省略；这里查找场景中已有目标，避免为演示留下临时单位
local targetEggyUnit = World:FindFirstChild("LiftTarget", true)
if controller ~= nil and targetEggyUnit ~= nil then
    controller:Lift(targetEggyUnit)
    print('已发起抓举；当前版本不要以 OnLiftBegin 是否触发作为成功判据')
end
```

### Throw

签名：`Throw() -> void`

扔出当前抓举的对象。

**返回值** `void`

> 示例代码

> 投掷抓举的对象

```lua
-- @runtime client
local Players = game:GetService("Players")
local eggyUnit = Players.LocalPlayer and Players.LocalPlayer.Character
local controller = eggyUnit and eggyUnit.Controller
if controller ~= nil then
    controller:Throw()  -- 扔出当前抓举的对象
end
```
