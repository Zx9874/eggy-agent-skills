# HpBarShowMode

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → HpBarShowMode

[HpBarShowMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/HpBarShowMode.html) 枚举控制角色头顶血条的显示策略，支持始终隐藏、始终显示或仅在生命值不满时显示三种模式。通过 [BaseController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html) 的 HPBarShowMode 属性设置，可灵活适配不同游戏场景的 UI 需求。

## 适用场景

在设置角色血条可见性时使用，例如在 PVP 战斗中常驻显示血条，或在非战斗状态下仅受伤时才显示血条以保持界面简洁。

## 使用要点

通过 [BaseController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html) 实例的 HPBarShowMode 属性赋值，如 controller.HPBarShowMode = Enums.HpBarShowMode.NotFull。枚举值通过 Enums.HpBarShowMode 命名空间访问，包括 None、Persistent 和 NotFull。

## 注意事项

该枚举仅影响头顶血条，不控制其他 UI 元素。HPBarShowMode 属性位于 [BaseController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html) 上，需通过角色的 Controller 组件获取实例。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `None` | 不显示 |
| `1` | `Persistent` | 常驻显示 |
| `2` | `NotFull` | 血量不满时显示 |
