# PrismaticConstraint

滑轨约束。需先通过 PrefabService:CreatePrefab("PrismaticConstraint") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

滑轨约束用于在两个物理部件之间创建单轴滑动连接，限制其中一个部件只能沿固定轴相对另一个部件平移。支持 Motor（恒速滑动）和 Servo（目标位置）两种驱动模式，并可设置线性位置限制。使用时需设置 Attachment0 和 Attachment1 指向两个已存在的 Attachment。物理约束建议在服务端创建。

> 继承自 `Unit`；需先通过 `PrefabService:CreatePrefab("PrismaticConstraint")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Enabled` | `Bool` | - | 启用约束 |
| `Attachment0Id` | `Int` | - | Attachment0 ID |
| `Attachment1Id` | `Int` | - | Attachment1 ID |
| `LimitsEnabled` | `Bool` | - | 启用线性限制 |
| `LowerLimit` | `Float` | - | 最小位置(空间单位) |
| `UpperLimit` | `Float` | - | 最大位置(空间单位) |
| `Restitution` | `Float` | - | 弹性(0-1) |
| `ActuatorType` | `Int` | - | 驱动类型 |
| `Velocity` | `Float` | - | Motor目标速度(空间单位/秒) |
| `MotorMaxForce` | `Float` | - | Motor最大力 |
| `MotorMaxAcceleration` | `Float` | - | Motor最大加速度(当前仅存储) |
| `TargetPosition` | `Float` | - | Servo目标位置(空间单位) |
| `Speed` | `Float` | - | Servo速度(空间单位/秒) |
| `ServoMaxForce` | `Float` | - | Servo最大力 |
| `LinearResponsiveness` | `Float` | - | Servo线性响应 |
