# CampRelationType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → CampRelationType

[CampRelationType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CampRelationType.html) 枚举定义阵营关系标签，用于表达自身、敌对、友好、中立、除自身外全部和全部阵营等筛选语义。

## 适用场景

当某个公开 API、配置字段或业务回调明确声明需要阵营关系参数时，使用该枚举描述目标阵营范围。

## 使用要点

通过 Enums.CampRelationType.SELF、Enums.CampRelationType.ENEMY、Enums.CampRelationType.FRIEND、Enums.CampRelationType.NEUTRAL、Enums.CampRelationType.ALL\_EXCEPT\_SELF、Enums.CampRelationType.ALL 引用枚举成员。

## 注意事项

不要把 [CampRelationType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CampRelationType.html) 用作 [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html) 或 [OverlapParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OverlapParams.html) 的 FilterType；这些空间查询过滤字段使用 Enums.RaycastFilterType.Include/Exclude。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `SELF` | 自身 |
| `1` | `ENEMY` | 敌对 |
| `2` | `FRIEND` | 友好 |
| `4` | `NEUTRAL` | 中立 |
| `6` | `ALL_EXCEPT_SELF` | 除自己外的所有阵营 |
| `7` | `ALL` | 所有阵营 |
