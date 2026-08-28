# PathfindingLink

寻路链接。需先通过 PrefabService:CreatePrefab("PathfindingLink") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

寻路链接：在两个 Attachment 之间建立导航网格外的连接，让寻路可以跨越断开区域。

> 继承自 `Unit`；需先通过 `PrefabService:CreatePrefab("PathfindingLink")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `AttachmentID0` | `Int` | - | 起始 Attachment 的 UnitId。 |
| `AttachmentID1` | `Int` | - | 终点 Attachment 的 UnitId。 |
| `IsBidirectional` | `Bool` | - | 该链接是否允许双向通行。 |
| `Label` | `String` | - | 链接对应的导航区域标签，可配合 CreatePath 的 Costs 或 Path:SetAreaCost 设置区域代价。 |
