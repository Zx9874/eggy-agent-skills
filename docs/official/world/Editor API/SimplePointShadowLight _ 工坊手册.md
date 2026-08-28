# SimplePointShadowLight

穿透点阴影源。通过 World:CreateUnit("SimplePointShadowLight", {...}) 创建，字段属性可直接读写。

## 概览

穿透点阴影源：从一点投射阴影，不受遮挡影响，可配置颜色、衰减与透明度。

> 继承自 `SimpleLight`；可通过 `World:CreateUnit("SimplePointShadowLight", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Color` | `Color3` | - | 阴影源颜色。 |
| `AttenuationEnable` | `Bool` | - | 是否启用慢速衰减。 |
| `Transparency` | `Float` | - | 光源模型的透明度，值越小越透明（阴影越暗）。取值范围 [0.0, 1.0]。 |
