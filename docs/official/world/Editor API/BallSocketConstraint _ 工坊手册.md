# BallSocketConstraint

球窝约束。需先通过 PrefabService:CreatePrefab("BallSocketConstraint") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

球窝约束用于在两个物理部件之间创建类似球关节的连接，允许绕连接点自由旋转。通过设置摆动角和扭转角限制，可以精确控制旋转范围。使用时需设置 Attachment0 和 Attachment1 指向两个已存在的 Attachment。物理约束建议在服务端创建。

> 继承自 `Unit`；需先通过 `PrefabService:CreatePrefab("BallSocketConstraint")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Enabled` | `Bool` | - | 启用约束 |
| `Attachment0Id` | `Int` | - | Attachment0 ID |
| `Attachment1Id` | `Int` | - | Attachment1 ID |
| `LimitsEnabled` | `Bool` | - | 启用摆动角限制 |
| `UpperAngle` | `Float` | - | 最大摆动角(度) |
| `TwistLimitsEnabled` | `Bool` | - | 启用扭转角限制 |
| `TwistLowerAngle` | `Float` | - | 最小扭转角(度) |
| `TwistUpperAngle` | `Float` | - | 最大扭转角(度) |
| `Restitution` | `Float` | - | 弹性(0-1) |
| `MaxFrictionTorque` | `Float` | - | 最大摩擦扭矩(当前仅存储) |
| `Radius` | `Float` | - | 可视化半径 |
