# Fog

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[Fog]**（15 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

雾效用于在场景中添加大气雾和高度雾，控制雾的颜色、浓度、距离和高度范围，营造氛围或遮挡远景。通过调整散射参数，还能模拟阳光穿过雾气的效果。

## 适用场景

在需要营造朦胧氛围或优化远景渲染时，创建雾效实例并挂载到光照服务下，通过调整大气雾和高度雾属性来改变场景视觉效果。

## 使用要点

使用 game:CreateUnit("Fog", { Enabled = true }) 创建雾效实例，将其 Parent 设置为 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html)。然后设置 AtmosphericColor、AtmosphericDensity 等属性来调节大气雾，或设置 HeightFogColor、HeightFogBeginHeight 等属性来调节高度雾。

## 注意事项

雾效实例必须挂载到 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 下并设置 Enabled=true 才生效。AtmosphericColor/HeightFogColor/SunInscatterColor 三个颜色属性默认都是黑色 Color.New(0, 0, 0, 255)，创建后若不主动设置非零颜色，雾效几乎不可见——这是「创建后看不出差别」的常见原因。调试时建议先把 AtmosphericColor 设为明显可见的颜色（如 Color.New(180, 200, 220, 255)），并把 AtmosphericDensity 调到 5 以上、AtmosphericStartDistance 调小，才能直观看到雾效。

## 代码示例

### 创建可见的雾效（设置颜色与浓度）

```lua
-- @runtime client
local World = game:GetService('World')
local LightingService = game:GetService('LightingService')

-- 创建雾效实例并配置明显的视觉效果
local fog = World:CreateUnit('Fog', {
    Enabled = true,
    AtmosphericColor = Color.New(180, 200, 220, 255),  -- 浅蓝色雾（默认黑色不明显）
    AtmosphericDensity = 8.0,                          -- 浓度，数值越大越浓
    AtmosphericStartDistance = 20.0,                   -- 雾开始距离
    AtmosphericEndDistance = 200.0,                    -- 雾完全遮蔽距离
})

-- 必须挂到 LightingService 下才会生效
fog.Parent = LightingService
print('雾效已启用:', fog.Enabled)
```

## 属性 (15)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Enabled` | `Bool` | `false` | 是否启用雾效。 |
| `AtmosphericColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(0, 0, 0, 255)` | 大气雾的颜色，用于控制场景中大气散射效果的整体色调。 |
| `AtmosphericBrightness` | `Float` | `1.0` | 大气雾的亮度系数，控制大气雾颜色的明亮程度。 |
| `AtmosphericDensity` | `Float` | `1.0` | 大气雾的浓度，值越大雾越浓。 |
| `AtmosphericStartDistance` | `Float` | `100.0` | 大气雾开始出现的距离，在此距离内不受雾影响。 |
| `AtmosphericEndDistance` | `Float` | `1000.0` | 大气雾完全覆盖的距离，超过此距离的物体完全被雾遮挡。 |
| `HeightFogColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(0, 0, 0, 255)` | 高度雾的颜色，用于控制基于高度变化的雾效颜色。 |
| `HeightFogDensity` | `Float` | `0.0` | 高度雾的浓度，值越大雾越浓。 |
| `HeightFogBeginHeight` | `Float` | `0.0` | 高度雾开始出现的高度。 |
| `HeightFogEndHeight` | `Float` | `0.0` | 高度雾完全覆盖的高度上限。 |
| `SunInscatterColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(0, 0, 0, 255)` | 太阳光散射颜色，用于模拟阳光在大气中的散射效果。 |
| `SunInscatterExponent` | `Float` | `1.0` | 太阳散射的收束度，控制散射光线的集中程度。 |
| `SunInscatterStartDistance` | `Float` | `0.0` | 太阳散射开始出现的距离。 |
| `SunInscatterBrightness` | `Float` | `0.0` | 太阳散射的亮度。 |
| `SunInscatterAtmosphericBlend` | `Float` | `0.0` | 太阳散射效果受大气雾影响的程度。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
