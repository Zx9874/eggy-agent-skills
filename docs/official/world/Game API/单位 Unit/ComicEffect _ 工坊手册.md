# ComicEffect

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)（1 属性）
    - **[ComicEffect]**（8 属性）

### 继承成员

2 个来源 / 5 属性 / 25 函数 / 6 事件

* 来自 [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)（1 属性）
  + 属性：[`Enabled`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html#properties)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

漫画效果是一种场景后期处理滤镜，可将画面渲染为漫画风格。它通过亮部、暗部和天空颜色的着色控制，配合色阶层级量化、描边宽度与强度以及网点强度参数，模拟漫画的色块、勾线和半调网点质感。

## 适用场景

在需要漫画画风表现的场景中，创建漫画效果单元并调节其颜色与描边、网点参数，即可把实时画面转换为漫画风格。

## 使用要点

先通过 game:CreateUnit("ComicEffect", config) 创建效果实例，再设置 HighlightsColor、ShadowsColor、SkyColor 等颜色属性，并用 Color.New(r, g, b, a) 赋值；随后调整 ColorLevels、OutlineWidth、OutlineStrength 和 HalftoneStrength，控制色阶、描边与网点效果。

## 注意事项

漫画效果属于后处理单元，实例只能通过游戏世界创建接口获取，不可直接构造。调整描边强度、网点强度等参数可以独立控制对应视觉通道，便于分步调试效果。

## 代码示例

### 创建 ComicEffect 并挂载到光照服务

```lua
-- @runtime client
local Lighting = game:GetService('LightingService')
local comicEffect = game:CreateUnit('ComicEffect', {
    Enabled = true,
})
comicEffect.Parent = Lighting
print('后处理已启用:', comicEffect.Enabled)
```

## 属性 (8)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `HighlightsColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(187, 255, 190, 255)` | 漫画后处理效果中亮部区域使用的颜色。 |
| `ShadowsColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 108, 238, 255)` | 漫画后处理效果中暗部区域使用的颜色。 |
| `SkyColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(155, 227, 255, 255)` | 漫画后处理效果中天空区域使用的颜色。 |
| `ColorLevels` | `Int` | `4` | 漫画后处理效果中的色阶层级数量，用于控制画面色阶量化的细致程度。 |
| `OutlineStrength` | `Float` | `1.0` | 漫画后处理效果中描边的强度，用于控制描边效果的强弱。 |
| `OutlineColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(236, 0, 255, 255)` | 漫画后处理效果中描边的颜色。 |
| `OutlineWidth` | `Int` | `1` | 漫画后处理效果中描边的宽度，用于控制轮廓线的粗细。 |
| `HalftoneStrength` | `Float` | `1.0` | 漫画后处理效果中网点纹理的强度，用于控制网点效果的明显程度。 |

## 关联类型

* [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
