# SimpleSpotLight

穿透锥光源。通过 World:CreateUnit("SimpleSpotLight", {...}) 创建，字段属性可直接读写。

## 概览

穿透锥光源：从锥形区域发出光照，不受遮挡影响，可配置亮度、颜色、内角与光束特效。

> 继承自 `SimpleLight`；可通过 `World:CreateUnit("SimpleSpotLight", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Brightness` | `Float` | - | 光源亮度。 |
| `Color` | `Color3` | - | 光源颜色。 |
| `InnerAngleFactor` | `Float` | - | 光束内角占比因子。取值范围 [0.0, 1.0]。 |
| `ShowSfx` | `Bool` | - | 是否显示光束特效。 |
