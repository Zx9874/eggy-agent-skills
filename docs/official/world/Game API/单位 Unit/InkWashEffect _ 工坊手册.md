# InkWashEffect

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)（1 属性）
    - **[InkWashEffect]**（5 属性）

### 继承成员

2 个来源 / 5 属性 / 25 函数 / 6 事件

* 来自 [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)（1 属性）
  + 属性：[`Enabled`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html#properties)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

水墨效果是一种作用于整体画面呈现的后期处理滤镜，通过描边宽度、描边强度、水墨浓度、纸张颜色和去色强度等参数，将场景渲染成类似传统水墨画的风格，适合国风、写意或特殊视觉表现的地图氛围营造。

## 适用场景

常用于需要水墨画风格或特殊画面质感的地图，在创建效果实例后动态调整各项参数，让场景逐步呈现水墨晕染与描边效果。

## 使用要点

通过 game:CreateUnit("InkWashEffect", ...) 创建效果实例，并挂入场景环境后，设置 OutlineWidth、InkDensity、OutlineStrength、PaperColor、DesaturationStrength 等属性来调节水墨风格，例如将 InkDensity 调低以减弱墨色浓度，或用 Color.New 设置 PaperColor 改变纸张底色，修改后效果实时反映在画面上。

## 注意事项

实例只能通过 game:CreateUnit 或 World:CreateUnit 创建，不能自行构造；效果挂入环境后才生效，修改属性即可实时调整画面风格。

## 代码示例

### 创建 InkWashEffect 并挂载到光照服务

```lua
-- @runtime client
local Lighting = game:GetService('LightingService')
local inkWashEffect = game:CreateUnit('InkWashEffect', {
    Enabled = true,
})
inkWashEffect.Parent = Lighting
print('后处理已启用:', inkWashEffect.Enabled)
```

## 属性 (5)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `OutlineWidth` | `Float` | `1.0` | 控制水墨效果中描边的宽度，决定轮廓线条的粗细。 |
| `InkDensity` | `Float` | `1.0` | 控制水墨效果中水墨的浓淡程度，影响画面整体的墨色浓度。 |
| `OutlineStrength` | `Float` | `1.0` | 控制水墨效果中描边的强度，数值越大，物体轮廓的水墨描边越明显。 |
| `PaperColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 247, 232, 255)` | 设置水墨效果中纸张的底色，用于模拟不同纸张颜色对整体画面色调的影响。 |
| `DesaturationStrength` | `Float` | `1.0` | 控制水墨效果对画面色彩的去色强度，数值越大，画面色彩越接近黑白水墨。 |

## 关联类型

* [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
