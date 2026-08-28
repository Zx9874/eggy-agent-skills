# Attachment

附件锚点。需先通过 PrefabService:CreatePrefab("Attachment") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

Attachment 表示依附于 Parent 的局部坐标锚点，可通过局部 Position、Rotation 或虚拟的世界空间属性读写变换。世界空间属性会根据 Parent 的世界变换与局部变换互相换算。

> 继承自 `Unit`；需先通过 `PrefabService:CreatePrefab("Attachment")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Visible` | `Bool` | - | 控制编辑器或调试显示中该 Attachment 锚点是否可见。 |
| `ShowOrientation` | `Bool` | - | Visible 为 true 时，控制是否显示该 Attachment 的朝向辅助标记。 |
