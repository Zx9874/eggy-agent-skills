# SimpleLineLight

穿透线光源。通过 World:CreateUnit("SimpleLineLight", {...}) 创建，字段属性可直接读写。

## 概览

穿透线光源：从一条线段发出光照，不受遮挡影响，可配置亮度、两端颜色与中间点位置。

> 继承自 `SimpleLight`；可通过 `World:CreateUnit("SimpleLineLight", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Brightness` | `Float` | - | 光源亮度。 |
| `Color` | `Color3` | - | 光源起始端颜色。 |
| `Color2` | `Color3` | - | 光源末端颜色。 |
| `Pivot` | `Float` | - | 光源渐变颜色的分界位置。取值范围 [0.0, 1.0]。 |
