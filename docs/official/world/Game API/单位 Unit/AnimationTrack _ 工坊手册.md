# AnimationTrack

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[AnimationTrack]**（11 属性 / 10 函数 / 3 事件）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html) 是动画轨道对象，用于控制单个动画的播放、停止、速度与权重。它由 [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html) 加载动画后返回，提供对动画时间位置、循环、骨骼过滤和优先级的精细调节，并支持在指定时间点添加标记和回调。

## 适用场景

典型场景是通过 Animator:LoadAnimation 加载动画资源后，调用 Play 播放角色动作，并利用 AddCue 在特定时刻触发音效或逻辑。

## 使用要点

先通过 Animator:LoadAnimation(animation) 获取 [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html) 实例，然后调用 track:Play(fadeTime, weight, speed) 开始播放。可通过 track:AdjustSpeed(speed) 动态调速，或使用 track:AddCue(name, timePosition) 在指定时间点添加标记，并通过 track:GetCueReachedSignal(name):Connect(callback) 监听标记到达。

## 注意事项

[AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html) 不可直接创建，必须由 Animator:LoadAnimation 返回。播放结束后会触发 Ended 事件，循环播放时触发 DidLoop。权重渐变过程中 WeightCurrent 会从旧值平滑过渡到 WeightTarget。

## 代码示例

### 通过 Animator 获取轨道并播放动画

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then
    print("HumanUnit 未提供 Animator")
    return
end

local track = animator:LoadAnimation("official://animation/100001")
track.Priority = Enums.AnimationPriority.Action
track.Looped = true
track:Play(0.1, 1.0, 1.0)
```

## 属性 (11)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Animation` | [Animation](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Animation.html) | `-` | 动画资源引用对象（只读），包含 Name（短名）和 AnimationId（资源 URI）属性。 |
| `IsPlaying` | `Bool` | `-` | 表示动画是否正在播放。 |
| `Length` | `Float` | `-` | 动画长度，单位秒。 |
| `Looped` | `Bool` | `-` | 是否循环播放。 |
| `Speed` | `Float` | `-` | 播放速度，1.0 为正常速度，0 为暂停。 |
| `TimePosition` | `Float` | `-` | 当前播放位置，单位秒。 |
| `FilterType` | [AnimationFilterType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AnimationFilterType.html) | `-` | 骨骼过滤类型，决定动画在哪些骨骼上生效。 |
| `Priority` | [AnimationPriority](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AnimationPriority.html) | `-` | 播放优先级，决定多个动画同时播放时的混合顺序。 |
| `WeightTarget` | `Float` | `-` | 目标权重，取值范围 0 到 1。 |
| `WeightCurrent` | `Float` | `-` | 当前实际权重，在渐变过程中会从旧值过渡到 WeightTarget。 |
| `Parent` | [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html) | `-` | 所属的 [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html)。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Animation](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Animation.html)
* [AnimationFilterType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AnimationFilterType.html)
* [AnimationPriority](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AnimationPriority.html)
* [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html)

## 事件 (3)

### DidLoop

签名：`DidLoop()` 触发：`local`

当动画播放到结尾并完成一次循环时触发。仅在 Looped 属性为 true 时才会发生。

> 示例代码

> 监听动画循环

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
track.Looped = true
track.DidLoop:Once(function()
    print("动画完成一次循环")
end)
track:Play()
```

### Ended

签名：`Ended()` 触发：`local`

当动画播放到结尾时触发。仅在 Looped 属性为 false 时才会发生。

> 示例代码

> 监听动画结束

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
track.Ended:Once(function()
    print("动画自然播放结束")
end)
track:Play()
```

### Stopped

签名：`Stopped()` 触发：`local`

当动画被 Stop 函数停止时触发。

> 示例代码

> 监听动画停止

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
track.Stopped:Once(function()
    print("动画已停止")
end)
track:Play()
track:Stop(0.2)
```

## 函数 (10)

### Play

签名：`Play(fadeTime: Float, weight: Float, speed: Float) -> void`

播放动画，若动画尚未加载完成（Length == 0），等待加载完成后自动播放。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `fadeTime` | `Float` | 淡入时间（秒），默认 0.1 |
| `weight` | `Float` | 目标混合权重，默认 1 |
| `speed` | `Float` | 播放速度，默认 1，不支持负数（会被置为 1） |

**返回值** `void`

> 示例代码

> 播放动画轨道

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
track.Priority = Enums.AnimationPriority.Action
track:Play(0.1, 1.0, 1.0)
```

### Stop

签名：`Stop(fadeTime: Float) -> void`

停止动画播放。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `fadeTime` | `Float` | 淡出时间（秒），默认 0.1 |

**返回值** `void`

> 示例代码

> 停止动画轨道

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
track:Play()
track:Stop(0.2)
```

### AdjustSpeed

签名：`AdjustSpeed(speed: Float) -> void`

调整动画播放速度，设为 0 可暂停动画，恢复非零值可继续播放。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `speed` | `Float` | 新的播放速度，默认 1 |

**返回值** `void`

> 示例代码

> 调整动画播放速度

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
track:Play()
track:AdjustSpeed(0.5)
```

### AdjustWeight

签名：`AdjustWeight(weight: Float, fadeTime: Float) -> void`

将动画轨道的混合权重在指定时间内平滑过渡到目标值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `weight` | `Float` | 目标权重，默认 1 |
| `fadeTime` | `Float` | 渐变时间（秒），默认 0.1 |

**返回值** `void`

> 示例代码

> 调整动画混合权重

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
track:Play()
track:AdjustWeight(0.5, 0.2)
```

### AddCue

签名：`AddCue(cueName: String, timePosition: Float) -> void`

在动画时间轴上添加一个 Cue 标记点，当动画播放到该时间点时会触发对应的信号。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `cueName` | `String` | Cue 名称，非空字符串 |
| `timePosition` | `Float` | Cue 触发的时间位置（秒），非负数 |

**返回值** `void`

> 示例代码

> 添加动画 Cue

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
track:AddCue("hit", 0.5)
track:GetCueReachedSignal("hit"):Once(function()
    print("hit Cue 到达")
end)
track:Play()
```

### RemoveCue

签名：`RemoveCue(cueName: String) -> void`

移除指定名称的所有 Cue 标记点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `cueName` | `String` | 要移除的 Cue 名称 |

**返回值** `void`

> 示例代码

> 移除动画 Cue

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
track:AddCue("hit", 0.5)
track:RemoveCue("hit")
```

### GetCueReachedSignal

签名：`GetCueReachedSignal(name: String) -> Signal (可用于 Connect 的信号对象)`

获取指定 Cue 的信号对象，动画播放到该 Cue 时触发。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | Cue 名称 |

**返回值** [Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html) (可用于 Connect 的信号对象)

> 示例代码

> 监听 Cue 到达信号

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
track:AddCue("hit", 0.5)
track:GetCueReachedSignal("hit"):Once(function()
    print("Cue hit")
end)
track:Play()
```

### GetTimeOfCue

签名：`GetTimeOfCue(name: String) -> Float (Cue 的时间位置（秒），不存在则返回 nil)`

获取指定 Cue 的时间位置。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | Cue 名称 |

**返回值** `Float` (Cue 的时间位置（秒），不存在则返回 nil)

> 示例代码

> 读取 Cue 时间

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
track:AddCue("hit", 0.5)
local timePosition = track:GetTimeOfCue("hit")
print("hit Cue 时间:", timePosition)
```

### GetMarkerReachedSignal

签名：`GetMarkerReachedSignal(name: String) -> Signal (可用于 Connect 的信号对象)`

获取指定 Marker 的信号对象（GetCueReachedSignal 的别名）。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | Marker 名称 |

**返回值** [Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html) (可用于 Connect 的信号对象)

> 示例代码

> 监听动画 Marker

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
track:GetMarkerReachedSignal("hit"):Once(function()
    print("Marker hit")
end)
track:Play()
```

### GetTimeOfKeyframe

签名：`GetTimeOfKeyframe(name: String) -> Float (时间位置（秒），不存在则返回 nil)`

获取指定 Keyframe 的时间位置（GetTimeOfCue 的别名）。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | Keyframe 名称 |

**返回值** `Float` (时间位置（秒），不存在则返回 nil)

> 示例代码

> 读取关键帧时间

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
local ok, timePosition = pcall(function()
    return track:GetTimeOfKeyframe("Start")
end)
if ok then
    print("Start 关键帧时间:", timePosition)
end
```
