# SpawnLocationUnit

出生点。可通过 World:CreateUnit("SpawnLocationUnit", {...}) 创建，字段属性可直接读写。

## 概览

> 继承自 `SpaceUnit`；可通过 `World:CreateUnit("SpawnLocationUnit", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `CampId` | `Int` | - | 阵营id |
| `EggyPrefabId` | `String` | - | 预设蛋仔 |
| `InheritPrefabAppearance` | `Bool` | - | 是否继承预设外观 |
| `Capacity` | `Int` | - | 容纳上限 |
| `RangeBirth` | `Bool` | - | 是否在范围内出生 |
