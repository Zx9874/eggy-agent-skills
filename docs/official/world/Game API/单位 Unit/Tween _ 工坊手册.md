# Tween

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[Tween]**（2 属性 / 3 函数 / 1 事件）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 是用于驱动目标对象属性随时间平滑变化的补间动画对象，由 TweenService:Create() 创建。它提供 Play、Pause、Cancel 三个方法控制动画生命周期，并通过 Completed 事件在动画自然结束时通知调用方。PlaybackState 属性可随时查询当前播放状态。

## 适用场景

常用于 UI 元素或场景对象的过渡动画，例如将部件平滑移动到指定位置、改变尺寸或透明度等。通过 TweenService:Create() 创建动画后，调用 Play() 启动，并可在需要时暂停或取消。

## 使用要点

先通过 TweenService:Create() 传入目标实例、[TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html) 配置和期望的目标属性表，获得 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 对象；随后调用 tween:Play() 开始播放，tween:Pause() 暂停，tween:Cancel() 取消。播放过程中可读取 tween.PlaybackState 判断状态，并监听 tween.Completed 事件获取自然结束时的 [TweenStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TweenStatus.html)。

## 注意事项

[Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 实例只能由 TweenService:Create() 返回，不可直接构造。Play() 开始播放，Pause() 暂停，Cancel() 取消播放并停止继续更新；不要把 Cancel() 描述为自然完成。需要获知自然结束时，监听 Completed 事件并读取回调中的 playbackState。

## 代码示例

### 创建 Tween 并监听完成状态

```lua
-- @runtime client
local TweenService = game:GetService("TweenService")
local World = game:GetService("World")

local target = World:CreateUnit("RenderUnit", {
    Name = "FadeTarget",
    RenderMeshId = "official://mesh/59268",
    ModelAlpha = 1,
})

local tweenInfo = TweenInfo.New(0.5, Enums.EasingStyle.Quad, Enums.EasingDirection.InOut)
local tween = TweenService:Create(target, tweenInfo, {
    Position = Vector3.New(5, 0, 0),
})

tween.Completed:Once(function(playbackState)
    print("Tween 完成状态:", playbackState)
end)
tween:Play()
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `PlaybackState` | [TweenPlayState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TweenPlayState.html) | `Enums.TweenPlayState.Begin` | 获取当前 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 动画的播放状态，返回 [TweenPlayState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TweenPlayState.html) 枚举值。 |
| `Instance` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | `-` | 表示当前补间动画所作用的目标对象，类型为 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)。补间创建时指定的目标单位会记录在该属性中，可用于确认补间正在驱动哪个对象。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [TweenPlayState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TweenPlayState.html)

## 事件 (1)

### Completed

签名：`Completed(playbackState: TweenStatus)` 触发：`local`

[Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 结束时触发的事件，回调参数 playbackState 表示结束状态。

⚙ 当前公开 Meta 只声明 Completed 事件和 Cancel 方法，未明确 Cancel() 是否一定触发 Completed；处理回调时可根据 playbackState 区分状态，但不要把 Cancel() 当作自然完成。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `playbackState` | [TweenStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TweenStatus.html) | 完成状态 |

> 示例代码

> 监听 Tween 完成状态

```lua
-- @runtime client
local TweenService = game:GetService("TweenService")
local World = game:GetService("World")
local target = World:CreateUnit("RenderUnit", { ModelAlpha = 1 })
local tweenInfo = TweenInfo.New(0.5, Enums.EasingStyle.Quad, Enums.EasingDirection.InOut)
local goal = { Position = Vector3.New(5, 0, 0) }
local tween = TweenService:Create(target, tweenInfo, goal)
tween.Completed:Once(function(playbackState)
    print("Tween 完成状态:", playbackState)
end)
tween:Play()
```

## 函数 (3)

### Play

签名：`Play() -> void`

开始播放 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 动画，或从暂停状态恢复播放。

**返回值** `void`

> 示例代码

> 播放 Tween

```lua
-- @runtime client
local TweenService = game:GetService("TweenService")
local World = game:GetService("World")
local target = World:CreateUnit("RenderUnit", { ModelAlpha = 1 })
local tweenInfo = TweenInfo.New(0.5, Enums.EasingStyle.Quad, Enums.EasingDirection.InOut)
local goal = { Position = Vector3.New(5, 0, 0) }
local tween = TweenService:Create(target, tweenInfo, goal)
tween:Play()
```

### Pause

签名：`Pause() -> void`

暂停当前正在播放的 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 动画，保留当前进度。

**返回值** `void`

> 示例代码

> 暂停 Tween

```lua
-- @runtime client
local TweenService = game:GetService("TweenService")
local World = game:GetService("World")
local target = World:CreateUnit("RenderUnit", { ModelAlpha = 1 })
local tweenInfo = TweenInfo.New(1.0, Enums.EasingStyle.Quad, Enums.EasingDirection.InOut)
local goal = { Position = Vector3.New(5, 0, 0) }
local tween = TweenService:Create(target, tweenInfo, goal)
tween:Play()
tween:Pause()
```

### Cancel

签名：`Cancel() -> void`

取消正在播放的 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html)，使其停止继续更新；不要将取消播放等同于自然完成。

**返回值** `void`

> 示例代码

> 取消 Tween

```lua
-- @runtime client
local TweenService = game:GetService("TweenService")
local World = game:GetService("World")
local target = World:CreateUnit("RenderUnit", { ModelAlpha = 1 })
local tweenInfo = TweenInfo.New(1.0, Enums.EasingStyle.Quad, Enums.EasingDirection.InOut)
local goal = { Position = Vector3.New(5, 0, 0) }
local tween = TweenService:Create(target, tweenInfo, goal)
tween:Play()
tween:Cancel()
```
