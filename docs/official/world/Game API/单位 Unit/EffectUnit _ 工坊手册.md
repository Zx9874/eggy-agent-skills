# EffectUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[EffectUnit]**（20 属性 / 13 函数）
    - [LinkEffectUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/LinkEffectUnit.html)（3 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[EffectUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EffectUnit.html) 是场景中已配置特效实例的运行时控制单位，用于调整可见性、位置、旋转、缩放、颜色、时长和绑定关系。

## 适用场景

当关卡中已经放置或由编辑流程配置好特效实例后，脚本可按战斗、交互或机关状态切换特效表现。

## 使用要点

先通过 World:FindFirstChild 等公开对象树接口获取目标 [EffectUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EffectUnit.html)，再调用 SetVisible、SetPosition、SetScale、SetColor、SetDuration、SetBindData 等公开成员控制表现；EffectId 是 Meta 已公开的只读资源标识，示例不虚构未验证的特效资源 ID。

## 注意事项

[EffectUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EffectUnit.html) 当前公开 Meta 包含只读的 EffectId，以及 EnemyEffectEnable 启用时可配置的 EnemyEffectId。文档示例应优先获取场景中已配置好的 [EffectUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EffectUnit.html)，再调用 SetVisible、SetPosition、SetScale、SetColor、SetDuration 等公开成员控制表现。播放控制应通过 SetVisible(true/false)，当前版本没有独立的 Play 方法。SetColor 第一个参数是 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 类型（如 Color.New(255,0,0,255)），不是字符串十六进制；强度 strength 取 0-100，混合因子 blendFactor 取 0-1。Duration 的自动回收行为由具体特效资源决定，不能据此承诺所有资源都会销毁。SetBindData/StartposAttach 还依赖有效挂点和运行包绑定实现；若绑定后仍停在固定位置，应改用编辑器预先配置 Parent/[Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 跟随并反馈 SDK，而不是反复调整 offset。

## 代码示例

### 控制场景中已配置的特效

```lua
-- @runtime client
local world = game:GetService("World")

local effect = world:FindFirstChild("MyEffect", true)
if effect ~= nil and effect:IsA("EffectUnit") then
    effect:SetColor(Color.New(255, 0, 0, 255), 100, 0.5)
    effect:SetPosition(Vector3.New(0, 5, 0))
    effect:SetVisible(true)
end
```

### 通过 Parent 让已配置特效跟随玩家角色

```lua
-- @runtime client
local world = game:GetService("World")
local players = game:GetService("Players")
local player = players.LocalPlayer
if player == nil then return end
local character = player and player.Character
if not character then
    print("当前没有可绑定的玩家角色")
    return
end

local effect = world:FindFirstChild("MyEffect", true)
if effect ~= nil and effect:IsA("EffectUnit") then
    -- 当前 SetBindData/StartposAttach 的挂点绑定表现依赖运行包，优先使用预配置 Parent 跟随
    effect.Parent = character
    effect:SetVisible(true)
end
```

## 属性 (20)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0.0, 0.0, 0.0]` | 特效在世界空间中的位置。 |
| `Rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | `[0.0, 0.0, 0.0, 1.0]` | 特效的当前旋转，以四元数表示。 |
| `Scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[1.0, 1.0, 1.0]` | 特效的缩放比例。 |
| `EffectId` | `String` | `""` | 特效资源标识，用于指定当前特效单元播放的特效资源。该属性为字符串类型，保存了编辑器或资源系统中定义的特效ID。 |
| `DiffuseColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 特效的基础颜色，影响特效的整体色调。 |
| `ColorStrength` | `Int` | `100` | 特效颜色的强度。 |
| `BlendFactor` | `Float` | `1.0` | 特效颜色与原始颜色的混合比例。 |
| `EnableColor` | `Bool` | `false` | 是否启用自定义颜色。 |
| `PlayRate` | `Float` | `1.0` | 特效的播放速率。 |
| `Visible` | `Bool` | `true` | 特效是否可见。 |
| `Volume` | `Float` | `50.0` | 特效的音量。 |
| `Duration` | `Float` | `-1` | 特效的持续时间。 |
| `IsMute` | `Bool` | `false` | 特效是否静音。 |
| `EffectBindData` | [EffectBindData](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EffectBindData.html) | `{}` | 特效绑定的单位数据，用于将特效附加到某个单位上。 |
| `EffectEndBindData` | [EffectBindData](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EffectBindData.html) | `{}` | 特效终点绑定的单位数据，用于连线特效的终点绑定。 |
| `AttachEndPos` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `Vector3.New(0, 0, 0)` | 特效终点绑定的位置偏移量，用于连线特效时指定终点相对于绑定单位的偏移。 |
| `EnemyEffectEnable` | `Bool` | `false` | 是否启用敌我特效区分。 |
| `EnemyEffectId` | `String` | `""` | 敌方显示的特效资源 ID。 |
| `AsyncLoad` | `Bool` | `false` | 是否异步加载特效资源。 |
| `ForceLoop` | `Bool` | `false` | 特效单位是否强制循环播放的布尔属性。启用后，特效将持续循环播放，不受其它播放条件限制。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
* [EffectBindData](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EffectBindData.html)
* [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 函数 (13)

### SetRate

签名：`SetRate(rate: Float) -> void`

设置特效的播放速率。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `rate` | `Float` | 速率 |

**返回值** `void`

> 示例代码

> 调整已配置特效播放速率

```lua
-- @runtime client
local world = game:GetService("World")

local effect = world:FindFirstChild("MyEffect", true)
if effect ~= nil and effect:IsA("EffectUnit") then
    effect:SetRate(2)
end
```

### SetScale

签名：`SetScale(scale: Vector3) -> void`

设置特效的缩放。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 缩放 |

**返回值** `void`

> 示例代码

> 调整已配置特效缩放

```lua
-- @runtime client
local world = game:GetService("World")

local effect = world:FindFirstChild("MyEffect", true)
if effect ~= nil and effect:IsA("EffectUnit") then
    effect:SetScale(Vector3.New(1.5, 1.5, 1.5))
end
```

### SetVisible

签名：`SetVisible(visible: Bool) -> void`

设置特效的可见性。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `visible` | `Bool` | 可见性 |

**返回值** `void`

> 示例代码

> 切换已配置特效可见性

```lua
-- @runtime client
local world = game:GetService("World")

local effect = world:FindFirstChild("MyEffect", true)
if effect ~= nil and effect:IsA("EffectUnit") then
    effect:SetVisible(true)
end
```

### SetRotation

签名：`SetRotation(rotate: Quaternion) -> void`

设置特效的旋转。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `rotate` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | 旋转 |

**返回值** `void`

> 示例代码

> 调整已配置特效旋转

```lua
-- @runtime client
local world = game:GetService("World")

local effect = world:FindFirstChild("MyEffect", true)
if effect ~= nil and effect:IsA("EffectUnit") then
    effect:SetRotation(Quaternion.New(0, 0, 0, 1))
end
```

### SetPosition

签名：`SetPosition(position: Vector3) -> void`

设置特效的世界坐标位置。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 位置 |

**返回值** `void`

> 示例代码

> 调整已配置特效位置

```lua
-- @runtime client
local world = game:GetService("World")

local effect = world:FindFirstChild("MyEffect", true)
if effect ~= nil and effect:IsA("EffectUnit") then
    effect:SetPosition(Vector3.New(0, 5, 0))
end
```

### RemoveSound

签名：`RemoveSound() -> void`

移除特效的声音。

**返回值** `void`

> 示例代码

> 移除已配置特效声音

```lua
-- @runtime client
local world = game:GetService("World")

local effect = world:FindFirstChild("MyEffect", true)
if effect ~= nil and effect:IsA("EffectUnit") then
    effect:RemoveSound()
end
```

### SetColor

签名：`SetColor(color: Color, strength: Int, blendFactor: Float) -> void`

设置特效的颜色、强度和混合比例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `color` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | 颜色 |
| `strength` | `Int` | 强度 |
| `blendFactor` | `Float` | 混合比例 |

**返回值** `void`

> 示例代码

> 设置特效颜色（Color 类型）

```lua
-- @runtime client
local World = game:GetService('World')
local effect = World:FindFirstChild('MyEffect', true)
if effect ~= nil and effect:IsA('EffectUnit') then
    local color = Color.New(255, 0, 0, 255)  -- 红色，Color 类型
    effect:SetColor(color, 100, 0.5)  -- strength=100, blendFactor=0.5
end
```

### SetBindData

签名：`SetBindData(otherUnit: SpaceUnit, socket: String, offset: Vector3, bindType: EffectBindType) -> void`

将特效绑定到指定单位的挂点上，并设置绑定类型。

⚙ 当前运行包的挂点绑定表现依赖特效资源和有效 socket；实测存在调用后仍停在固定位置的情况。绑定不可用时优先改用编辑器预配置 Parent/[Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 跟随。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `otherUnit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 单位预设 |
| `socket` | `String` | 挂点 |
| `offset` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 位置偏移 |
| `bindType` | [EffectBindType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EffectBindType.html) | 绑定类型 |

**返回值** `void`

> 示例代码

> 当前版本使用 Parent 跟随作为绑定替代

```lua
-- @runtime client
local World = game:GetService('World')
local targetUnit = World:FindFirstChild('MyTargetUnit', true)
local effect = World:FindFirstChild('MyEffect', true)
if effect ~= nil and effect:IsA('EffectUnit') and targetUnit ~= nil then
    -- SetBindData 当前可能无法持续跟随；先使用已配置的父子关系
    effect.Parent = targetUnit
    effect:SetVisible(true)
end
```

### StartposAttach

签名：`StartposAttach(otherUnit: SpaceUnit, socket: String, offset: Vector3, bindType: EffectBindType) -> void`

设置连线特效的起点绑定到指定单位的挂点上。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `otherUnit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 单位预设 |
| `socket` | `String` | 挂点 |
| `offset` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 位置偏移 |
| `bindType` | [EffectBindType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EffectBindType.html) | 绑定类型 |

**返回值** `void`

> 示例代码

> 绑定已配置特效起点到单位

```lua
-- @runtime client
local world = game:GetService("World")

local effect = world:FindFirstChild("MyEffect", true)
local target = world:FindFirstChild("MyTargetUnit", true)
if effect ~= nil and effect:IsA("EffectUnit") and target ~= nil and target:IsA("SpaceUnit") then
    effect:StartposAttach(target, "Origin", Vector3.New(0, 2, 0), Enums.EffectBindType.ALL)
end
```

### EndposAttach

签名：`EndposAttach(otherUnit: SpaceUnit, socket: String, offset: Vector3) -> void`

设置连线特效的终点绑定到指定单位的挂点上。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `otherUnit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 单位预设 |
| `socket` | `String` | 挂点 |
| `offset` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 位置偏移 |

**返回值** `void`

> 示例代码

> 绑定已配置特效终点到单位

```lua
-- @runtime client
local world = game:GetService("World")

local effect = world:FindFirstChild("MyEffect", true)
local target = world:FindFirstChild("MyTargetUnit", true)
if effect ~= nil and effect:IsA("EffectUnit") and target ~= nil and target:IsA("SpaceUnit") then
    effect:EndposAttach(target, "Origin", Vector3.New(0, 2, 0))
end
```

### SetDuration

签名：`SetDuration(duration: Float) -> void`

设置特效的播放时长。

⚙ SetDuration 只能更新当前 [EffectUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EffectUnit.html) 的公开时长字段，不负责重新选择特效资源；是否自动回收还取决于具体特效资源。需要稳定短生命周期表现时，应由业务计时器主动 SetVisible(false) 或销毁宿主，而不要只依赖 Duration。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `duration` | `Float` | 时长 |

**返回值** `void`

> 示例代码

> 调整已配置特效的持续时长

```lua
-- @runtime client
local world = game:GetService("World")

local effect = world:FindFirstChild("MyEffect", true)
if effect ~= nil and effect:IsA("EffectUnit") then
    effect:SetDuration(3)
    effect:SetVisible(true)
end
```

### MoveTo

签名：`MoveTo(targetPos: Vector3, speed: Float, callBack: Function) -> void`

让特效以指定速度移动到目标位置，并在到达后执行回调。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `targetPos` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 目标位置 |
| `speed` | `Float` | 线速度(米/秒) |
| `callBack` | `Function` | 结束回调 |

**返回值** `void`

> 示例代码

> 移动已配置特效到目标位置

```lua
-- @runtime client
local world = game:GetService("World")

local effect = world:FindFirstChild("MyEffect", true)
if effect ~= nil and effect:IsA("EffectUnit") then
    effect:MoveTo(Vector3.New(0, 5, 0), 3, function()
        print("特效移动结束")
    end)
end
```

### SetMute

签名：`SetMute() -> void`

设置特效静音。

**返回值** `void`

> 示例代码

> 静音已配置特效

```lua
-- @runtime client
local world = game:GetService("World")

local effect = world:FindFirstChild("MyEffect", true)
if effect ~= nil and effect:IsA("EffectUnit") then
    effect:SetMute()
end
```
