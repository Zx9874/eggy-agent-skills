# EffectUnit

特效。通过 World:CreateUnit("EffectUnit", {...}) 创建，字段属性可直接读写。

## 概览

特效：在场景中播放特效资源，支持位置、旋转、缩放、颜色、播放速率等配置，可区分敌我显示、强制循环、异步加载。

> 继承自 `Unit`；可通过 `World:CreateUnit("EffectUnit", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Position` | `Vector3` | - | 特效在场景中的位置。 |
| `Rotation` | `Quaternion` | - | 特效的旋转（四元数）。 |
| `Scale` | `Vector3` | - | 特效的缩放。 |
| `EffectId` | `String` | - | 要播放的特效资源路径（official:// 协议）。 |
| `BlendFactor` | `Float` | - | 特效颜色融合系数。取值范围 [0.0, 1.0]。 |
| `EnableColor` | `Bool` | - | 是否启用自定义颜色（启用后基础颜色/强度/融合系数生效）。 |
| `PlayRate` | `Float` | - | 特效播放速率（1.0 为原始速度）。 |
| `EnemyEffectEnable` | `Bool` | - | 是否区分敌我显示特效。 |
| `EnemyEffectId` | `String` | - | 敌方视角显示的特效资源路径（启用敌我区分后生效）。 |
| `AsyncLoad` | `Bool` | - | 是否异步加载特效资源。 |
| `ForceLoop` | `Bool` | - | 是否强制特效循环播放；关闭时按特效资源自带的播放方式执行（资源本身是循环的仍会循环）。对 efx 与 sfx 特效均生效。 |
