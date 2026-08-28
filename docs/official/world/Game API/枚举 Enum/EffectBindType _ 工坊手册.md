# EffectBindType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → EffectBindType

特效绑定类型枚举定义了特效挂载到目标对象时的空间变换方式。它控制特效是否跟随目标的位置、旋转或缩放，从而影响特效在场景中的表现形态。

## 适用场景

在创建 [EffectBindData](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EffectBindData.html) 配置时，通过设置 BindType 字段来指定特效的绑定方式，例如仅跟随位置或同时跟随位置和旋转。

## 使用要点

使用 Enums.EffectBindType.POS 等成员为 [EffectBindData](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EffectBindData.html) 的 BindType 赋值。

## 注意事项

枚举值包括 POS（仅位置）、POS\_ROT（位置和旋转）、POS\_SCALE（位置和缩放）、ALL（全部变换）。必须通过 Enums.EffectBindType 前缀引用，禁止使用数字。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `1` | `POS` | 仅位置 |
| `3` | `POS_ROT` | 位置+旋转 |
| `5` | `POS_SCALE` | 位置+缩放 |
| `7` | `ALL` | 全部跟随 |
