# Animator

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[Animator]**（1 属性 / 2 函数 / 1 事件）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

动画控制器负责为角色单位加载动画资源、创建 [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html)，并查询当前正在播放的动画轨道。

## 适用场景

需要为 [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html)、[EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) 等公开暴露 [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html) 属性的角色单位播放骨骼动画时使用。

## 使用要点

先从角色单位的 [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html) 属性取得实例，再调用 animator:LoadAnimation(资源 URI) 获取 [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html)，最后通过轨道的 Play、Stop 等方法控制播放。

## 注意事项

[HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html)、[EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) 等角色通常已通过 [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html) 属性公开可用实例，应优先直接获取，避免重复创建。Meta 允许创建 [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html)；确需创建时必须把 Parent 设为拥有骨骼或动画组件的宿主 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)，否则无法驱动动画。[AnimatedUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimatedUnit.html) 使用自身的 PlayAnimation/StopAnimation 接口，当前公开 Meta 未声明其 [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html) 属性。LoadAnimation 的 animationId 参数使用 official://animation/{id} 格式（如 official://animation/100001）。

## 代码示例

### 从 HumanUnit 获取 Animator 并播放动画

```lua
-- @runtime server
local World = game:GetService("World")

-- 角色通常已公开 Animator 属性，优先复用已有实例
local human = World:CreateUnit("HumanUnit", {
    Position = Vector3.New(0, 0, 0),
    Scale = Vector3.New(1, 1, 1),
})

local animator = human.Animator
if animator == nil then return end
local track = animator:LoadAnimation("official://animation/100001")
track.Priority = Enums.AnimationPriority.Action
track.Looped = true
track:Play()
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Parent` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | `-` | Parent 属性用于设置或获取该 [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html) 所驱动的父 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)。父级 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 通常是拥有骨骼、动画组件或其他可被动画驱动的实体，[Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html) 通过该属性与目标 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 建立层级关联。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (1)

### AnimationPlayed

签名：`AnimationPlayed(animationTrack: AnimationTrack)` 触发：`local`

当动画开始播放时触发，携带被播放的 [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html) 实例。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `animationTrack` | [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html) | 开始播放的动画轨道 |

> 示例代码

> 监听角色动画开始播放

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

animator.AnimationPlayed:Once(function(animationTrack)
    print("动画开始播放:", animationTrack.Animation.Name)
end)
animator:LoadAnimation("official://animation/100001"):Play()
```

## 函数 (2)

### LoadAnimation

签名：`LoadAnimation(contentId: String|Animation) -> AnimationTrack (动画轨道对象)`

加载动画资源并返回一个可播放的 [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html)。如果同一个 contentId 已经加载过，则返回缓存的实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `contentId` | String | [Animation](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Animation.html) |

**返回值** [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html) (动画轨道对象)

> 示例代码

> 加载动画资源并播放

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

-- animationId 必须用 official://animation/{id} 格式
local track = animator:LoadAnimation("official://animation/100001")
track:Play()
```

### GetPlayingAnimationTracks

签名：`GetPlayingAnimationTracks() -> AnimationTrack[] (AnimationTrack 数组)`

返回当前所有正在播放的 [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html) 数组。

**返回值** [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html)[] ([AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html) 数组)

> 示例代码

> 读取角色当前播放的动画轨道

```lua
-- @runtime server
local World = game:GetService("World")
local human = World:CreateUnit("HumanUnit", { Position = Vector3.New(0, 0, 0) })
local animator = human.Animator
if animator == nil then return end

local track = animator:LoadAnimation("official://animation/100001")
track:Play()
for _, playingTrack in ipairs(animator:GetPlayingAnimationTracks()) do
    print("正在播放:", playingTrack.Animation.Name)
end
```
