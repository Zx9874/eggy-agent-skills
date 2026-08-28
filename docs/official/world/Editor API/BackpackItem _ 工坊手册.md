# BackpackItem

物品基类。需先通过 PrefabService:CreatePrefab("BackpackItem") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

物品基类：所有可放入背包的物品的基类，提供图标等基础属性。

> 继承自 `Unit`；需先通过 `PrefabService:CreatePrefab("BackpackItem")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Icon` | `String` | - | 物品图标资源路径。 |
