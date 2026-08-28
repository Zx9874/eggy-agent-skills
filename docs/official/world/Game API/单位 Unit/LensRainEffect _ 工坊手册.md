# LensRainEffect

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)（1 属性）
    - **[LensRainEffect]**（8 属性）

### 继承成员

2 个来源 / 5 属性 / 25 函数 / 6 事件

* 来自 [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)（1 属性）
  + 属性：[`Enabled`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html#properties)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

镜头雨水效果，用于在游戏画面上叠加一层雨痕与雨点的视觉特效。通过中心清晰区半径控制画面中央无雨区域的大小，雨痕组与雨点组的各项参数则分别调节雨丝滑落和雨点滴落的形态与强度。

## 适用场景

在需要营造雨天氛围的场景中，创建该效果并挂载到光照节点下，通过调整雨痕与雨点的密度、速度等属性实时改变雨势表现。

## 使用要点

通过 game:CreateUnit("LensRainEffect", 配置参数) 或 World:CreateUnit 创建实例，随后将其 Parent 设为光照服务节点以启用效果。创建后可依次设置 CenterClearRadius、StreakSpeed、StreakDensity、StreakStrength 以及 DropletSpeed、DropletDensity、DropletStrength、DropletRotationRandomness 等属性来调节雨效细节。

## 注意事项

实例必须通过 CreateUnit 接口创建，不能直接构造；效果需要挂在光照节点下才会生效。属性修改会实时反映到画面中，可在运行中动态调整雨势；若要完全移除效果，可调用 Destroy 方法将实例销毁。

## 代码示例

### 创建 LensRainEffect 并挂载到光照服务

```lua
-- @runtime client
local Lighting = game:GetService('LightingService')
local lensRainEffect = game:CreateUnit('LensRainEffect', {
    Enabled = true,
})
lensRainEffect.Parent = Lighting
print('后处理已启用:', lensRainEffect.Enabled)
```

## 属性 (8)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `CenterClearRadius` | `Float` | `0.0` | 中心清晰区半径属性，用于控制镜头雨效果中画面中心保持清晰（无雨）区域的半径大小。 |
| `StreakSpeed` | `Float` | `1.5` | 雨痕滑落速度属性，用于控制镜头雨效果中雨痕在镜头表面滑落的快慢。 |
| `StreakDensity` | `Float` | `1.0` | 雨痕密度属性，用于控制镜头雨效果中雨痕（雨丝）的密集程度。 |
| `StreakStrength` | `Float` | `3.0` | 雨痕强度属性，用于控制镜头雨效果中雨痕的视觉强度。 |
| `DropletSpeed` | `Float` | `1.0` | 雨点速度属性，用于控制镜头雨效果中雨点的下落速度。 |
| `DropletDensity` | `Float` | `1.0` | 雨点密度属性，用于控制镜头雨效果中雨点的密集程度。 |
| `DropletStrength` | `Float` | `1.0` | 雨点强度属性，用于控制镜头雨效果中雨点的视觉强度。 |
| `DropletRotationRandomness` | `Float` | `1.0` | 雨点旋转随机度属性，用于控制镜头雨效果中雨点旋转的随机变化程度。 |

## 关联类型

* [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)
