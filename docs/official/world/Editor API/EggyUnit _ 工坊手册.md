# EggyUnit

蛋形生物。通过 World:CreateUnit("EggyUnit", {...}) 创建，字段属性可直接读写。

## 概览

蛋形生物：玩家在游戏中操控的蛋仔角色，也可作为怪物/NPC 等存在。具备空间位置、姿态、外观等属性。

> 继承自 `SpaceUnit`；可通过 `World:CreateUnit("EggyUnit", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `UseCustomAppearance` | `Bool` | - | 是否使用自定义外观替代默认模型渲染。 |
| `CustomAppearanceId` | `String` | - | 自定义外观的资源 ID（启用自定义外观后生效）。 |
