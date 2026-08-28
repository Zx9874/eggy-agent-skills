# TriggerUnit

纯触发区域。可通过 World:CreateUnit("TriggerUnit", {...}) 创建，字段属性可直接读写。

## 概览

> 继承自 `SpaceUnit`；可通过 `World:CreateUnit("TriggerUnit", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `PhysicsMeshId` | `String` | - | 物理资源ID |
| `PhysicsActive` | `Bool` | - | 是否启用物理模拟，关闭后物体不参与碰撞和物理计算 |
| `ModelBindParent` | `Bool` | - | 启用后，当父节点为 WorldUnit、RenderUnit、TriggerUnit、PhysicsUnit 等支持父子带动的场景单位时，当前单位将整体跟随父节点运动，保持与父节点的相对位置和旋转。运行时可通过脚本设置 .ModelBindParent = true/false 动态切换该行为。 |
| `CollisionGroup` | `String` | - | 物体所属的碰撞组名称，用于按碰撞组规则过滤碰撞关系 |
| `CanTouch` | `Bool` | - | 其他物体碰到此物体时，是否触发此物体的碰撞事件 |
