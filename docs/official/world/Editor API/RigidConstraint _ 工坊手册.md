# RigidConstraint

刚性约束。需先通过 PrefabService:CreatePrefab("RigidConstraint") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

刚性约束用于将两个物理部件完全固定在一起，使其之间不能有任何相对运动（位置和旋转均锁定）。使用时需设置 Attachment0 和 Attachment1 指向两个已存在的 Attachment。物理约束建议在服务端创建。

> 继承自 `Unit`；需先通过 `PrefabService:CreatePrefab("RigidConstraint")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Enabled` | `Bool` | - | 启用约束 |
| `Attachment0Id` | `Int` | - | Attachment0 ID |
| `Attachment1Id` | `Int` | - | Attachment1 ID |
