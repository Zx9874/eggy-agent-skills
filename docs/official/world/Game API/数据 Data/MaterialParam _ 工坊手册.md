# MaterialParam

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[MaterialParam](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MaterialParam.html) 是 [SkinUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SkinUnit.html) 的材质参数数据，用于配置粗糙度、金属度、自发光、水体、细节纹理和边缘光等外观表现。

## 适用场景

需要为目标单位挂载 [SkinUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SkinUnit.html) 并覆盖其材质表现时，构造 [MaterialParam](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MaterialParam.html)、设置所需字段，再赋给 SkinUnit.MaterialParam。

## 使用要点

使用 MaterialParam.New() 或 [MaterialParam](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MaterialParam.html)() 创建实例，设置所需材质属性，最后赋给 SkinUnit.MaterialParam。

## 注意事项

[MaterialParam](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MaterialParam.html) 不能通过 game:CreateUnit 创建。当前公开 Meta 只在 [SkinUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SkinUnit.html) 上声明 [MaterialParam](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MaterialParam.html) 属性，[RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html) 没有该公开属性；赋值给 [SkinUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SkinUnit.html) 后如需应用后续修改，应重新赋值。

## 代码示例

### 构造材质参数并应用到 SkinUnit

```lua
-- @runtime client
local world = game:GetService("World")

local target = world:CreateUnit("WorldUnit", {
    Name = "MaterialTarget",
})

local skin = world:CreateUnit("SkinUnit", {
    SkinId = "official://skin/60001",
    Parent = target,
})

local material = MaterialParam.New()
material.MaterialEnableBorder = true
material.MaterialBorderColor = Color.New(255, 220, 80, 255)
material.MaterialBorderIntensity = 1.0
skin.MaterialParam = material
```

## 属性 (96)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `MaterialIntensityG` | `Float` | `-` | 材质整体表面粗糙度。值越小表面越光滑、反射越聚集；值越大越粗糙、反射越发散。仅在“粗糙度局部调整”关闭时生效。 |
| `MaterialIntensityB` | `Float` | `-` | 材质整体金属度。0 表示非金属（绝缘体），1 表示完全金属。仅在“金属度局部调整”关闭时生效。 |
| `MaterialIntensityA` | `Float` | `-` | 材质整体自发光的亮度倍率，0 表示不发光。 |
| `MaterialWaveSpeed` | `Float` | `-` | 顶点扰动动画的播放速度，值越大波动越快。 |
| `MaterialWaveIntensity` | `Float` | `-` | 顶点扰动的幅度，0 表示无顶点偏移。 |
| `MaterialFlowSpeed` | `Float` | `-` | 控制材质波纹的流动速度。 |
| `MaterialUVtilingX` | `Float` | `-` | 控制材质流动纹理在 X 方向的重复度。 |
| `MaterialUVtilingY` | `Float` | `-` | 控制材质流动纹理在 Y 方向的重复度。 |
| `MaterialNoiseSpeed` | `Float` | `-` | 控制材质波形播放速度。 |
| `MaterialIconColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `-` | 控制材质贴花（Decal）的颜色，类型为 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)。 |
| `MaterialEmissiveColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `-` | 控制材质整体自发光颜色，类型为 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)。 |
| `MaterialDepthScale` | `Float` | `-` | 水体的视觉深度，影响深浅区域的过渡与颜色变化。 |
| `MaterialRippleDensity` | `Float` | `-` | 控制材质水波纹的密度。 |
| `MaterialEmissiveIntensity1` | `Float` | `-` | 控制材质染色区域 1 的自发光强度。 |
| `MaterialEmissiveIntensity2` | `Float` | `-` | 控制材质染色区域 2 的自发光强度。 |
| `MaterialEmissiveIntensity3` | `Float` | `-` | 控制材质染色区域 3 的自发光强度。 |
| `MaterialEmissiveIntensity4` | `Float` | `-` | 控制材质染色区域 4 的自发光强度。 |
| `MaterialOffsetScale` | `Float` | `-` | 云层扰动的密度，控制云表面扰动发生的细致程度。 |
| `MaterialOffsetSpeed` | `Float` | `-` | 控制材质云扰动的速度。 |
| `MaterialOffsetStrength` | `Float` | `-` | 云层扰动的幅度，0 表示无扰动。 |
| `MaterialEnableBorder` | `Bool` | `-` | 是否开启轮廓边缘发光效果（菲涅尔效果）。 |
| `MaterialBorderColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `-` | 控制材质边缘光效果的颜色，类型为 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)。 |
| `MaterialBorderIntensity` | `Float` | `-` | 边缘光的亮度倍率。仅在“开启边缘光”开启时生效。 |
| `MaterialBorderScale` | `Float` | `-` | 边缘光的覆盖范围（菲涅尔角度）。仅在“开启边缘光”开启时生效。 |
| `MaterialRepeatScale` | `Float` | `-` | 纹理的整体缩放比例。仅在“纹理自由缩放”关闭时生效。 |
| `MaterialDecalRepeatX` | `Float` | `-` | 纹理沿 X 轴的单独缩放比例。仅在“纹理自由缩放”开启时生效。 |
| `MaterialDecalRepeatY` | `Float` | `-` | 纹理沿 Y 轴的单独缩放比例。仅在“纹理自由缩放”开启时生效。 |
| `MaterialDecalAngle` | `Float` | `-` | 控制材质纹理的旋转角度。 |
| `MaterialDecalOffsetX` | `Float` | `-` | 控制材质纹理在 X 方向的偏移。 |
| `MaterialDecalOffsetY` | `Float` | `-` | 控制材质纹理在 Y 方向的偏移。 |
| `MaterialDecalIsFreeScaling` | `Bool` | `-` | 开启后可对纹理 X/Y 轴单独设置缩放，关闭时使用整体缩放。 |
| `MaterialRoughness1` | `Float` | `-` | 染色区域1的局部粗糙度。仅在“粗糙度局部调整”开启时生效。 |
| `MaterialRoughness2` | `Float` | `-` | 染色区域2的局部粗糙度。仅在“粗糙度局部调整”开启时生效。 |
| `MaterialRoughness3` | `Float` | `-` | 染色区域3的局部粗糙度。仅在“粗糙度局部调整”开启时生效。 |
| `MaterialRoughness4` | `Float` | `-` | 染色区域4的局部粗糙度。仅在“粗糙度局部调整”开启时生效。 |
| `MaterialMetalness1` | `Float` | `-` | 染色区域1的局部金属度。仅在“金属度局部调整”开启时生效。 |
| `MaterialMetalness2` | `Float` | `-` | 染色区域2的局部金属度。仅在“金属度局部调整”开启时生效。 |
| `MaterialMetalness3` | `Float` | `-` | 染色区域3的局部金属度。仅在“金属度局部调整”开启时生效。 |
| `MaterialMetalness4` | `Float` | `-` | 染色区域4的局部金属度。仅在“金属度局部调整”开启时生效。 |
| `MaterialUseRoughness4` | `Bool` | `-` | 开启后可对4个染色区域分别设置粗糙度，关闭时使用整体粗糙度。 |
| `MaterialUseMetalness4` | `Bool` | `-` | 开启后可对4个染色区域分别设置金属度，关闭时使用整体金属度。 |
| `MaterialPatternTexture` | `String` | `-` | 控制材质细节纹理的图片样式。 |
| `MaterialPatternOp` | `Float` | `-` | 细节纹理的透明度，0 表示细节纹理完全透光。 |
| `MaterialPatternColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `-` | 控制材质细节纹理（Pattern）的颜色，类型为 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)。 |
| `MaterialPatternColorKey` | `Float` | `-` | 细节纹理被细节颜色染色的程度，0 表示完全去色；部分或完全去色可更大程度使用细节纹理的法线效果，可以叠加出有特色的质感。 |
| `MaterialPatternRepeatX` | `Float` | `-` | 控制材质细节纹理在 X 方向的重复度。 |
| `MaterialPatternRepeatY` | `Float` | `-` | 控制材质细节纹理在 Y 方向的重复度。 |
| `MaterialPatternOffsetX` | `Float` | `-` | 控制材质细节纹理在 X 方向的偏移。 |
| `MaterialPatternOffsetY` | `Float` | `-` | 控制材质细节纹理在 Y 方向的偏移。 |
| `MaterialPatternDepth` | `Float` | `-` | 细节纹理的视差/凹凸深度，0 表示无凹凸。 |
| `MaterialPatternAngle` | `Float` | `-` | 控制材质细节纹理的旋转角度。 |
| `MaterialPatternRoughness` | `Float` | `-` | 控制材质细节纹理的粗糙度。 |
| `MaterialPatternMetalness` | `Float` | `-` | 控制材质细节纹理的金属度。 |
| `MaterialPatternEmissive` | `Float` | `-` | 控制材质细节纹理的自发光强度。 |
| `MaterialPatternUV` | `Bool` | `-` | 开启后细节纹理使用世界坐标 UV，移动模型时，纹理维持在世界空间中的位置不变，从而看起来在模型表面的位置有变化，而非模型局部 UV。只读属性。 |
| `MaterialEnableTiling` | `Bool` | `-` | 开启后，采用三面映射纹理；关闭时，采用模型本身的UV。 |
| `MaterialOpacityMax` | `Float` | `-` | 水体的最大不透明度，值越大水体越浑浊，值越小越清澈。 |
| `MaterialDepthContrast` | `Float` | `-` | 控制材质水体深度的颜色过渡。 |
| `MaterialFoamWidth` | `Float` | `-` | 控制材质岸边浮沫的宽度。 |
| `MaterialFoamStep` | `Float` | `-` | 控制材质岸边浮沫的过渡效果。 |
| `MaterialFoamStrength` | `Float` | `-` | 控制材质岸边浮沫的扰动强度。 |
| `MaterialFoamSpeed` | `Float` | `-` | 控制材质水面浮沫的扰动速度。 |
| `MaterialFoamEmis` | `Float` | `-` | 控制材质岸边浮沫的自发光强度。 |
| `MaterialEdgeWeaken` | `Float` | `-` | 控制材质岸边波浪起伏的弱化程度。 |
| `MaterialEdgeWidth` | `Float` | `-` | 控制材质岸边波浪弱化的范围。 |
| `MaterialSFoamType` | `Float` | `-` | 控制材质水面浮沫的形状。 |
| `MaterialSFoamContrast` | `Float` | `-` | 控制材质水面浮沫的过渡效果。 |
| `MaterialSFoamBrightness` | `Float` | `-` | 控制材质水面浮沫的范围。 |
| `MaterialSFoamTiling` | `Float` | `-` | 控制材质水面浮沫的密度。 |
| `MaterialReflectStrength` | `Float` | `-` | 控制材质水体的反射强度。 |
| `MaterialReflectScope` | `Float` | `-` | 控制材质水体反射的范围。 |
| `MaterialWaveLightScale` | `Float` | `-` | 控制材质波光的大小。 |
| `MaterialWaveLightDensity` | `Float` | `-` | 控制材质波光的密度。 |
| `MaterialWaveLightScope` | `Float` | `-` | 控制材质波光的范围。 |
| `MaterialEnableRipples` | `Bool` | `-` | 控制是否开启涟漪效果。 |
| `MaterialRipplesScale` | `Float` | `-` | 控制材质涟漪的密度。 |
| `MaterialRipplesScope` | `Float` | `-` | 控制材质涟漪的范围。 |
| `MaterialRipplesIntensity` | `Float` | `-` | 控制材质涟漪的起伏强度。 |
| `MaterialWaterIntensityX` | `Float` | `-` | 控制材质波浪的整体起伏强度。 |
| `MaterialWaterIntensityY` | `Float` | `-` | 控制材质波浪的整体朝向。 |
| `MaterialWaterIntensityZ` | `Float` | `-` | 控制材质水体的金属度。 |
| `MaterialWaterIntensityW` | `Float` | `-` | 控制材质水体的自发光强度。 |
| `MaterialWaveformParmX` | `Float` | `-` | 控制材质波纹 1 的起伏强度。 |
| `MaterialWaveformParmY` | `Float` | `-` | 控制材质波纹 1 的密度。 |
| `MaterialWaveformParmZ` | `Float` | `-` | 控制材质波纹 1 的速度。 |
| `MaterialWaveformParmW` | `Float` | `-` | 控制材质波纹 1 的朝向。 |
| `MaterialDisturbanceParmX` | `Float` | `-` | 控制材质波纹 2 的起伏强度。 |
| `MaterialDisturbanceParmY` | `Float` | `-` | 控制材质波纹 2 的密度。 |
| `MaterialDisturbanceParmZ` | `Float` | `-` | 控制材质波纹 2 的速度。 |
| `MaterialDisturbanceParmW` | `Float` | `-` | 控制材质波纹 2 的朝向。 |
| `MaterialWaveLightSpeed` | `Float` | `-` | 控制材质波光的速度。 |
| `MaterialWaveLightStrength` | `Float` | `-` | 控制材质波光的发光强度。 |
| `MaterialGradientAxis` | `Float` | `-` | 颜色渐变所沿的坐标轴方向，0 为 X 轴、1 为 Y 轴、2 为 Z 轴。 |
| `MaterialGradientCenter` | `Float` | `-` | 控制材质渐变的轴心位置。 |
| `MaterialGradientContrast` | `Float` | `-` | 两种颜色间渐变的过渡对比度，0 为完全混为一种颜色，1 为不过渡有一条直线边界。 |
| `MaterialAlpha` | `Float` | `-` | 材质整体不透明度，0 为完全透明、1 为完全不透明。 |

## 关联类型

* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)

## 函数 (1)

### New

签名：`New(initData?: Table) -> MaterialParam`

创建并返回一个新的材质参数（[MaterialParam](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MaterialParam.html)）实例。材质参数用于描述单元材质的外观表现，包含透明度、颜色、波纹、流动、描边等多项可调属性。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `initData?` | `Table` | 初始属性表 |

**返回值** [MaterialParam](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MaterialParam.html)

> 示例代码

> 调用 New

```lua
-- @runtime client
local initData = {}  -- Table
local result = MaterialParam.New(initData)  -- 返回 MaterialParam
if result ~= nil then
    print("调用成功，结果: " .. tostring(result))
end
```
