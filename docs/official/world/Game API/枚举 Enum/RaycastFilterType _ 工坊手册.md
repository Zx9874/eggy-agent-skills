# RaycastFilterType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → RaycastFilterType

射线过滤类型枚举用于控制射线检测或重叠检测时，如何对待传入的实例列表。Exclude 表示跳过列表中的实例，Include 表示仅检测列表中的实例。

## 适用场景

在使用 [PhysicsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PhysicsService.html) 进行射线检测或空间查询时，通过 [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html) 设置过滤规则，决定是排除还是仅包含特定实例。

## 使用要点

通过 Enums.RaycastFilterType.Exclude 或 Enums.RaycastFilterType.Include 引用枚举值，将其赋值给 [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html) 的 FilterType 属性，配合 FilterDescendantsInstances 列表使用。

## 注意事项

该枚举不单独使用，必须与 [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html) 或 [OverlapParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OverlapParams.html) 配合。Exclude 和 Include 的行为完全相反，需根据检测需求选择。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Exclude` | 排除列表 |
| `1` | `Include` | 仅包含列表 |
