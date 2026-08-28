# SimpleAreaLight

穿透面光源。通过 World:CreateUnit("SimpleAreaLight", {...}) 创建，字段属性可直接读写。

## 概览

穿透面光源：从面状区域发出光照，不受遮挡影响，可配置亮度、颜色、尺寸与照射图案。

> 继承自 `SimpleLight`；可通过 `World:CreateUnit("SimpleAreaLight", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Brightness` | `Float` | - | 光源亮度。 |
| `Color` | `Color3` | - | 光源颜色。 |
| `Size` | `Vector2` | - | 光源面的尺寸。 |
| `LightPattern` | `String` | - | 面光源的照射图案资源。 |
