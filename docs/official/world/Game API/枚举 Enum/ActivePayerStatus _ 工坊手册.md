# ActivePayerStatus

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → ActivePayerStatus

[ActivePayerStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ActivePayerStatus.html) 枚举表示平台定义的玩家付费活跃度分层。

## 适用场景

仅在某个公开 API 或项目契约明确返回 [ActivePayerStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ActivePayerStatus.html) 时，使用命名枚举成员进行分支判断。

## 使用要点

使用 Enums.ActivePayerStatus.Unknown、Casual50Percent、Intermediate35Percent 或 Top15Percent 比较已知类型的值。当前公开 Surface 没有直接声明为 [ActivePayerStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ActivePayerStatus.html) 的返回值或字段。

## 注意事项

AnalyticsService:GetPlayerSegmentsAsync 当前只公开返回 Table，未公开表字段结构，也未声明其中包含 [ActivePayerStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ActivePayerStatus.html)；不要据此推断获取链路或字段名。枚举分层标准由平台定义。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Unknown` | 数据不可用 |
| `1` | `Never` | 玩家在该体验中从未消费过 |
| `2` | `Lapsed` | 玩家曾经消费过，但目前不是活跃付费用户 |
| `3` | `Casual50Percent` | 消费排名 51-100%（低消费玩家） |
| `4` | `Intermediate35Percent` | 消费排名 16-50%（中等消费） |
| `5` | `Top15Percent` | 消费排名 1-15%（顶级消费） |
