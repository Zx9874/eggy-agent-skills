# RodConstraint

杆约束。需先通过 PrefabService:CreatePrefab("RodConstraint") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

杆约束用于在两个物理部件之间保持固定的距离，类似刚性连杆。与刚性约束不同，杆约束允许两部件在保持距离的前提下自由旋转。使用时需设置 Attachment0 和 Attachment1 指向两个已存在的 Attachment，并通过 Length 属性指定杆长。物理约束建议在服务端创建。

> 继承自 `Unit`；需先通过 `PrefabService:CreatePrefab("RodConstraint")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Enabled` | `Bool` | - | 启用约束 |
| `Attachment0Id` | `Int` | - | Attachment0 ID |
| `Attachment1Id` | `Int` | - | Attachment1 ID |
| `Length` | `Float` | - | 杆长(空间单位) |
| `LimitsEnabled` | `Bool` | - | 启用端部角度限制(当前仅存储) |
| `LimitAngle0` | `Float` | - | Attachment0端角度限制(度, 当前仅存储) |
| `LimitAngle1` | `Float` | - | Attachment1端角度限制(度, 当前仅存储) |
| `Thickness` | `Float` | - | 可视化粗细(当前仅存储) |
