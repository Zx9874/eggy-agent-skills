# SimplePointLight

穿透点光源。通过 World:CreateUnit("SimplePointLight", {...}) 创建，字段属性可直接读写。

## 概览

穿透点光源：从一点向四周发出光照，不受遮挡影响，可配置亮度、颜色与衰减。

> 继承自 `SimpleLight`；可通过 `World:CreateUnit("SimplePointLight", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Color` | `Color3` | - | 光源颜色。 |
| `Brightness` | `Float` | - | 光源亮度。 |
| `AttenuationEnable` | `Bool` | - | 是否启用慢速衰减。 |
