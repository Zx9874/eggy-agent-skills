# PresetSky

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BaseSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html)（1 属性）
    - **[PresetSky]**（1 属性）

### 继承成员

2 个来源 / 5 属性 / 25 函数 / 6 事件

* 来自 [BaseSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html)（1 属性）
  + 属性：[`AffectedByFog`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html#properties)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[PresetSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PresetSky.html) 是预置天空单元，内置多套精选固定材质的天空球方案。通过切换 Template 属性即可快速改变场景的整体天空氛围，无需手动调整任何参数。它继承自 [BaseSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html)，因此也支持 AffectedByFog 属性来控制是否受雾效影响。

## 适用场景

适用于需要快速为场景设定统一天空背景的场合，例如在关卡初始化时根据主题选择对应的预置模板，或在运行时动态切换天空风格以配合剧情或环境变化。

## 使用要点

使用 game:CreateUnit("PresetSky", {}) 创建实例，将 Parent 设置为 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html)，再把 Template 赋值为 Enums.PresetSkyTemplate 的命名成员；AffectedByFog 控制是否受雾效影响。

## 注意事项

[PresetSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PresetSky.html) 是预设天空单元，模板数量较少且仅能整体切换 Template，灵活性不如 [Sky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Sky.html)。在需要精细控制天空参数（旋转、扰动、垂直偏移）的场景，建议改用 [Sky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Sky.html)。[PresetSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PresetSky.html) 设置后若需还原默认天空，应通过 Destroy 销毁实例或将其从 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 下移除，而非依赖 Template 回退。

## 代码示例

### 创建并切换预置天空模板

```lua
-- @runtime client
local Lighting = game:GetService("LightingService")
local presetSky = game:CreateUnit("PresetSky", {
    Template = Enums.PresetSkyTemplate.DreamGalaxy,
    AffectedByFog = true,
})
presetSky.Parent = Lighting
print("当前天空模板:", presetSky.Template)
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Template` | [PresetSkyTemplate](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PresetSkyTemplate.html) | `Enums.PresetSkyTemplate.DreamGalaxy` | 预设天空的模板样式，决定天空的视觉效果。 |

## 关联类型

* [BaseSky](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseSky.html)
* [PresetSkyTemplate](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PresetSkyTemplate.html)
