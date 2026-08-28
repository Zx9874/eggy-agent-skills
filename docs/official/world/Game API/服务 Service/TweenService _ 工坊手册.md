# TweenService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[TweenService]**（1 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

补间动画服务，负责根据配置生成属性渐变动画。通过传入单位实例、补间信息和目标属性表，创建出可独立控制的补间对象，实现平滑过渡效果。

## 适用场景

常用于单位移动、缩放、旋转等属性动画场景，也可用于界面元素的透明度或颜色渐变。

## 使用要点

先通过 game:GetService("TweenService") 获取服务，再使用 TweenInfo.New 创建补间配置，最后调用 TweenService:Create 传入目标单位、补间配置和属性变化表，获得 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 对象后即可播放。

## 注意事项

Create 需要有效的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 实例、[TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html) 和与目标 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 公开属性匹配的目标表。通过返回 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 的 Completed 事件监听结束状态；若要从新的起始状态再次执行补间，请基于当时的目标状态重新创建 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html)。

## 代码示例

### 创建 Tween 动画并播放（使用正确的 Unit 类型）

```lua
-- @runtime client
-- 获取 TweenService
local TweenService = game:GetService("TweenService")
local World = game:GetService("World")

-- 创建 RenderUnit（作为补间目标）
local part = World:CreateUnit("RenderUnit", {
    RenderMeshId = "official://mesh/59268",
    ModelVisible = true,
    ModelAlpha = 1.0,
})
if part == nil then
    print('RenderUnit 创建失败，无法创建 Tween')
    return
end

-- 定义 TweenInfo 和目标值
local tweenInfo = TweenInfo.New(0.5, Enums.EasingStyle.Quad, Enums.EasingDirection.InOut)
local goal = { Position = Vector3.New(5, 0, 0) }

-- 创建并播放 Tween
local tween = TweenService:Create(part, tweenInfo, goal)
tween:Play()

-- 监听完成事件
tween.Completed:Once(function(playState)
    print('Tween 完成，状态:', playState)
    part:Destroy()
end)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (1)

### Create

签名：`Create(instance: Unit, tweenInfo: TweenInfo, goalTable: Table) -> Tween (Tween 对象)`

[TweenService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TweenService.html) 的 Create 函数用于创建一个 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 动画对象，通过对指定实例的属性进行插值来实现平滑过渡。该函数返回一个 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 对象，可通过该对象控制动画的播放、暂停和取消。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `instance` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 目标对象 |
| `tweenInfo` | [TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html) | [TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html) 配置 |
| `goalTable` | `Table` | 目标属性表 |

**返回值** [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) ([Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 对象)

> 示例代码

> 创建并播放位移 Tween

```lua
-- @runtime client
local TweenService = game:GetService("TweenService")
local World = game:GetService("World")

local target = World:CreateUnit("RenderUnit", {
    RenderMeshId = "official://mesh/59268",
    ModelVisible = true,
    ModelAlpha = 1.0,
})
if target == nil then
    print('RenderUnit 创建失败，无法创建 Tween')
    return
end

local tweenInfo = TweenInfo.New(0.5, Enums.EasingStyle.Quad, Enums.EasingDirection.InOut)
local goal = { Position = Vector3.New(5, 0, 0) }
local tween = TweenService:Create(target, tweenInfo, goal)
tween.Completed:Once(function(playState)
    print('Tween 完成状态:', playState)
    target:Destroy()
end)
tween:Play()
```
