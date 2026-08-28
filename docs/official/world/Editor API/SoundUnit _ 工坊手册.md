# SoundUnit

3D 空间音效。可通过 World:CreateUnit("SoundUnit", {...}) 创建，字段属性可直接读写。

## 概览

> 继承自 `Unit`；可通过 `World:CreateUnit("SoundUnit", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `SoundId` | `String` | - | 音效资源 |
| `Speed` | `Float` | - | 播放速率 |
| `Volume` | `Float` | - | 音量 |
| `Duration` | `Float` | - | 持续时间 |
| `FadeDistance` | `Float` | - | 衰减距离 |
| `Playing` | `Bool` | - | 自动播放 |
| `Looped` | `Bool` | - | 循环播放 |
