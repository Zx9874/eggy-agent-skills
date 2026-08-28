# SimpleLineShadowLight

穿透线阴影源。通过 World:CreateUnit("SimpleLineShadowLight", {...}) 创建，字段属性可直接读写。

## 概览

穿透线阴影源：从一条线段投射阴影，不受遮挡影响，可配置两端颜色、中间点位置与透明度。

> 继承自 `SimpleLight`；可通过 `World:CreateUnit("SimpleLineShadowLight", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Color` | `Color3` | - | 阴影源起始端颜色。 |
| `Color2` | `Color3` | - | 阴影源末端颜色。 |
| `Pivot` | `Float` | - | 阴影源渐变颜色的分界位置。取值范围 [0.0, 1.0]。 |
| `Transparency` | `Float` | - | 光源模型的透明度，值越小越透明（阴影越暗）。取值范围 [0.0, 1.0]。 |
