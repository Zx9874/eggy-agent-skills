# SketchEffect

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)（1 属性）
    - **[SketchEffect]**（15 属性）

### 继承成员

2 个来源 / 5 属性 / 25 函数 / 6 事件

* 来自 [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)（1 属性）
  + 属性：[`Enabled`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html#properties)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

素描效果是一种后处理滤镜，能将场景画面渲染为手绘素描风格。它提供暗角缩放、去色强度、描边宽度与强度、笔触密度以及密集、中度、稀疏三档笔触的强度与阈值等参数，配合纸张颜色与亮度设置，可精细调节画面的笔触观感。

## 适用场景

适用于为场景添加艺术化的素描风格渲染，例如在演示关卡或特殊玩法阶段切换画面呈现方式，营造手绘质感。

## 使用要点

通过 game:CreateUnit("SketchEffect", ...) 创建效果实例，拿到实例后按需设置 VignetteZoom、DesaturationStrength、OutlineWidth、StrokeColor、OutlineStrength、StrokeDensity、SceneOpacity 等属性，即可实时调整素描化程度与笔触表现。

## 注意事项

该实例只能通过 CreateUnit 方式创建，不能直接构造；调整属性前建议先将实例挂载到场景光照节点下以确保效果生效；颜色类属性需使用 Color.New 赋值。

## 代码示例

### 创建 SketchEffect 并挂载到光照服务

```lua
-- @runtime client
local Lighting = game:GetService('LightingService')
local sketchEffect = game:CreateUnit('SketchEffect', {
    Enabled = true,
})
sketchEffect.Parent = Lighting
print('后处理已启用:', sketchEffect.Enabled)
```

## 属性 (15)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `VignetteZoom` | `Float` | `1.0` | 暗角缩放，控制素描效果中暗角区域的缩放程度。 |
| `DesaturationStrength` | `Float` | `0.0` | 去色强度，控制画面颜色被去除的程度。数值越大，画面颜色越暗淡，越接近灰度表现。 |
| `OutlineWidth` | `Int` | `4` | 描边宽度，控制轮廓描边线条的粗细程度，取值为整数。 |
| `StrokeColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(0, 0, 0, 255)` | 笔触颜色，控制素描效果中笔触与描边线条使用的颜色。 |
| `OutlineStrength` | `Float` | `1.0` | 描边强度，控制轮廓描边线条的明显程度。数值越大，描边越突出。 |
| `StrokeDensity` | `Float` | `1.0` | 笔触密度，控制素描效果中笔触线条的密集程度。数值越大，笔触越密集。 |
| `DenseStrokeStrength` | `Float` | `1.0` | 密集笔触强度，控制画面中密集线条区域的笔触强度。 |
| `MediumStrokeStrength` | `Float` | `1.0` | 中度笔触强度，控制画面中中等密度线条区域的笔触强度。 |
| `SparseStrokeStrength` | `Float` | `1.0` | 稀疏笔触强度，控制画面中稀疏线条区域的笔触强度。 |
| `SceneOpacity` | `Float` | `1.0` | 画面不透明度，控制经素描处理后的画面整体的不透明度。 |
| `DenseThreshold` | `Float` | `0.35` | 密集线条阈值，控制笔触区域被划分为密集线条的判定界限。 |
| `MediumThreshold` | `Float` | `0.45` | 中度线条阈值，控制笔触区域被划分为中等密度线条的判定界限。 |
| `SparseThreshold` | `Float` | `0.55` | 稀疏线条阈值，控制笔触区域被划分为稀疏线条的判定界限。 |
| `PaperColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(0, 0, 0, 255)` | 纸张颜色，控制素描效果底层的纸张背景颜色。 |
| `PaperLightness` | `Float` | `1.0` | 纸张亮度，控制素描效果底层纸张背景的明暗程度。 |

## 关联类型

* [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
