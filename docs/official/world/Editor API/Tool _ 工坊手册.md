# Tool

工具。需先通过 PrefabService:CreatePrefab("Tool") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

工具单位，支持装备(Equipped)/卸下(Unequipped)/激活(Activated)/停用(Deactivated)等操作的工具类型。

> 继承自 `BackpackItem`；需先通过 `PrefabService:CreatePrefab("Tool")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `RequiresHandle` | `Bool` | - | 需要 Handle |
| `CanBeDropped` | `Bool` | - | 可丢弃 |
| `Enabled` | `Bool` | - | 可使用 |
| `ToolTip` | `String` | - | 提示文本 |
