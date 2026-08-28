# MaterialParam

材质参数用于控制单位表面材质的各项表现属性，涵盖粗糙度、金属度、自发光、水体、贴花、细节纹理、边缘光等模块。

## 概览

材质参数用于控制单位表面材质的各项表现属性，涵盖粗糙度、金属度、自发光、水体、贴花、细节纹理、边缘光等模块。

> 不可实例化，由接口返回

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `MaterialIntensityG` | `Float` | - | 材质整体表面粗糙度。值越小表面越光滑、反射越聚集；值越大越粗糙、反射越发散。仅在“粗糙度局部调整”关闭时生效。 |
| `MaterialIntensityB` | `Float` | - | 材质整体金属度。0 表示非金属（绝缘体），1 表示完全金属。仅在“金属度局部调整”关闭时生效。 |
| `MaterialIntensityA` | `Float` | - | 材质整体自发光的亮度倍率，0 表示不发光。 |
| `MaterialWaveSpeed` | `Float` | - | 顶点扰动动画的播放速度，值越大波动越快。 |
| `MaterialWaveIntensity` | `Float` | - | 顶点扰动的幅度，0 表示无顶点偏移。 |
| `MaterialFlowSpeed` | `Float` | - | 表面波纹纹理沿 UV 方向的流动速度。 |
| `MaterialUVtilingX` | `Float` | - | 波纹沿表面 X 轴方向的纹理重复次数。 |
| `MaterialUVtilingY` | `Float` | - | 波纹沿表面 Y 轴方向的纹理重复次数。 |
| `MaterialNoiseSpeed` | `Float` | - | 噪声波形的动画播放速度。 |
| `MaterialIconColor` | `Color` | - | 附带贴花的整体染色颜色，需要材质上带有附带贴花。 |
| `MaterialEmissiveColor` | `Color` | - | 材质整体自发光的颜色。 |
| `MaterialDepthScale` | `Float` | - | 水体的视觉深度，影响深浅区域的过渡与颜色变化。 |
| `MaterialRippleDensity` | `Float` | - | 水面波浪的整体密集程度。 |
| `MaterialEmissiveIntensity1` | `Float` | - | 染色区域1的自发光亮度倍率。 |
| `MaterialEmissiveIntensity2` | `Float` | - | 染色区域2的自发光亮度倍率。 |
| `MaterialEmissiveIntensity3` | `Float` | - | 染色区域3的自发光亮度倍率。 |
| `MaterialEmissiveIntensity4` | `Float` | - | 染色区域4的自发光亮度倍率。 |
| `MaterialOffsetScale` | `Float` | - | 云层扰动的密度，控制云表面扰动发生的细致程度。 |
| `MaterialOffsetSpeed` | `Float` | - | 云层扰动的动画播放速度。 |
| `MaterialOffsetStrength` | `Float` | - | 云层扰动的幅度，0 表示无扰动。 |
| `MaterialEnableBorder` | `Bool` | - | 是否开启轮廓边缘发光效果（菲涅尔效果）。 |
| `MaterialBorderColor` | `Color` | - | 边缘光的颜色。仅在“开启边缘光”开启时生效。 |
| `MaterialBorderIntensity` | `Float` | - | 边缘光的亮度倍率。仅在“开启边缘光”开启时生效。 |
| `MaterialBorderScale` | `Float` | - | 边缘光的覆盖范围（菲涅尔角度）。仅在“开启边缘光”开启时生效。 |
| `MaterialRepeatScale` | `Float` | - | 纹理的整体缩放比例。仅在“纹理自由缩放”关闭时生效。 |
| `MaterialDecalRepeatX` | `Float` | - | 纹理沿 X 轴的单独缩放比例。仅在“纹理自由缩放”开启时生效。 |
| `MaterialDecalRepeatY` | `Float` | - | 纹理沿 Y 轴的单独缩放比例。仅在“纹理自由缩放”开启时生效。 |
| `MaterialDecalAngle` | `Float` | - | 纹理的旋转角度（度）。 |
| `MaterialDecalOffsetX` | `Float` | - | 纹理沿 X 轴方向的偏移量。 |
| `MaterialDecalOffsetY` | `Float` | - | 纹理沿 Y 轴方向的偏移量。 |
| `MaterialDecalIsFreeScaling` | `Bool` | - | 开启后可对纹理 X/Y 轴单独设置缩放，关闭时使用整体缩放。 |
| `MaterialRoughness1` | `Float` | - | 染色区域1的局部粗糙度。仅在“粗糙度局部调整”开启时生效。 |
| `MaterialRoughness2` | `Float` | - | 染色区域2的局部粗糙度。仅在“粗糙度局部调整”开启时生效。 |
| `MaterialRoughness3` | `Float` | - | 染色区域3的局部粗糙度。仅在“粗糙度局部调整”开启时生效。 |
| `MaterialRoughness4` | `Float` | - | 染色区域4的局部粗糙度。仅在“粗糙度局部调整”开启时生效。 |
| `MaterialMetalness1` | `Float` | - | 染色区域1的局部金属度。仅在“金属度局部调整”开启时生效。 |
| `MaterialMetalness2` | `Float` | - | 染色区域2的局部金属度。仅在“金属度局部调整”开启时生效。 |
| `MaterialMetalness3` | `Float` | - | 染色区域3的局部金属度。仅在“金属度局部调整”开启时生效。 |
| `MaterialMetalness4` | `Float` | - | 染色区域4的局部金属度。仅在“金属度局部调整”开启时生效。 |
| `MaterialUseRoughness4` | `Bool` | - | 开启后可对4个染色区域分别设置粗糙度，关闭时使用整体粗糙度。 |
| `MaterialUseMetalness4` | `Bool` | - | 开启后可对4个染色区域分别设置金属度，关闭时使用整体金属度。 |
| `MaterialPatternTexture` | `String` | - | 细节纹理使用的贴图资源。 |
| `MaterialPatternOp` | `Float` | - | 细节纹理的透明度，0 表示细节纹理完全透光。 |
| `MaterialPatternColor` | `Color` | - | 细节纹理的颜色。 |
| `MaterialPatternColorKey` | `Float` | - | 细节纹理被细节颜色染色的程度，0 表示完全去色；部分或完全去色可更大程度使用细节纹理的法线效果，可以叠加出有特色的质感。 |
| `MaterialPatternRepeatX` | `Float` | - | 细节纹理沿 X 轴方向的缩放程度。 |
| `MaterialPatternRepeatY` | `Float` | - | 细节纹理沿 Y 轴方向的缩放程度。 |
| `MaterialPatternOffsetX` | `Float` | - | 细节纹理沿 X 轴方向的偏移量。 |
| `MaterialPatternOffsetY` | `Float` | - | 细节纹理沿 Y 轴方向的偏移量。 |
| `MaterialPatternDepth` | `Float` | - | 细节纹理的视差/凹凸深度，0 表示无凹凸。 |
| `MaterialPatternAngle` | `Float` | - | 细节纹理的旋转角度（度）。 |
| `MaterialPatternRoughness` | `Float` | - | 细节纹理区域的粗糙度。 |
| `MaterialPatternMetalness` | `Float` | - | 细节纹理区域的金属度。 |
| `MaterialPatternEmissive` | `Float` | - | 细节纹理的自发光亮度倍率。 |
| `MaterialPatternUV` | `Bool` | - | 开启后细节纹理使用世界坐标 UV，移动模型时，纹理维持在世界空间中的位置不变，从而看起来在模型表面的位置有变化，而非模型局部 UV。只读属性。 |
| `MaterialEnableTiling` | `Bool` | - | 开启后，采用三面映射纹理；关闭时，采用模型本身的UV。 |
| `MaterialOpacityMax` | `Float` | - | 水体的最大不透明度，值越大水体越浑浊，值越小越清澈。 |
| `MaterialDepthContrast` | `Float` | - | 水体深浅区域颜色的过渡平滑度。 |
| `MaterialFoamWidth` | `Float` | - | 岸边浮沫的覆盖宽度。 |
| `MaterialFoamStep` | `Float` | - | 岸边浮沫与水面的过渡平滑度。 |
| `MaterialFoamStrength` | `Float` | - | 岸边浮沫的扰动幅度。 |
| `MaterialFoamSpeed` | `Float` | - | 水面浮沫扰动的动画播放速度。 |
| `MaterialFoamEmis` | `Float` | - | 岸边浮沫的自发光亮度。 |
| `MaterialEdgeWeaken` | `Float` | - | 靠近岸边时波浪起伏的弱化程度。 |
| `MaterialEdgeWidth` | `Float` | - | 岸边波浪弱化效果的影响范围。 |
| `MaterialSFoamType` | `Float` | - | 水面浮沫的形状类型。 |
| `MaterialSFoamContrast` | `Float` | - | 水面浮沫的过渡对比度。 |
| `MaterialSFoamBrightness` | `Float` | - | 水面浮沫的覆盖范围。 |
| `MaterialSFoamTiling` | `Float` | - | 水面浮沫纹理的密度。 |
| `MaterialReflectStrength` | `Float` | - | 水面环境反射的强度。 |
| `MaterialReflectScope` | `Float` | - | 水面反射的范围/模糊程度。 |
| `MaterialWaveLightScale` | `Float` | - | 水面波光的大小。 |
| `MaterialWaveLightDensity` | `Float` | - | 水面波光的密集程度。 |
| `MaterialWaveLightScope` | `Float` | - | 水面波光的覆盖范围。 |
| `MaterialEnableRipples` | `Bool` | - | 是否开启水面涟漪效果。 |
| `MaterialRipplesScale` | `Float` | - | 涟漪的密集程度。 |
| `MaterialRipplesScope` | `Float` | - | 涟漪效果的影响范围。 |
| `MaterialRipplesIntensity` | `Float` | - | 涟漪的起伏幅度。 |
| `MaterialWaterIntensityX` | `Float` | - | 水面波浪整体的起伏幅度。 |
| `MaterialWaterIntensityY` | `Float` | - | 水面波浪整体的朝向角度（度）。 |
| `MaterialWaterIntensityZ` | `Float` | - | 水体的金属度。 |
| `MaterialWaterIntensityW` | `Float` | - | 水体的自发光强度。 |
| `MaterialWaveformParmX` | `Float` | - | 第一组波纹的起伏幅度。 |
| `MaterialWaveformParmY` | `Float` | - | 第一组波纹的密度。 |
| `MaterialWaveformParmZ` | `Float` | - | 第一组波纹的动画播放速度。 |
| `MaterialWaveformParmW` | `Float` | - | 第一组波纹的朝向。 |
| `MaterialDisturbanceParmX` | `Float` | - | 第二组波纹的起伏幅度。 |
| `MaterialDisturbanceParmY` | `Float` | - | 第二组波纹的密度。 |
| `MaterialDisturbanceParmZ` | `Float` | - | 第二组波纹的动画播放速度。 |
| `MaterialDisturbanceParmW` | `Float` | - | 第二组波纹的朝向。 |
| `MaterialWaveLightSpeed` | `Float` | - | 水面波光的动画播放速度。 |
| `MaterialWaveLightStrength` | `Float` | - | 水面波光的发光亮度倍率。 |
| `MaterialGradientAxis` | `Float` | - | 颜色渐变所沿的坐标轴方向，0 为 X 轴、1 为 Y 轴、2 为 Z 轴。 |
| `MaterialGradientCenter` | `Float` | - | 渐变在所选轴向上的中心位置。 |
| `MaterialGradientContrast` | `Float` | - | 两种颜色间渐变的过渡对比度，0 为完全混为一种颜色，1 为不过渡有一条直线边界。 |
| `MaterialAlpha` | `Float` | - | 材质整体不透明度，0 为完全透明、1 为完全不透明。 |
