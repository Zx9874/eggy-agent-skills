# PlayerPlatformSpenderStatus

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → PlayerPlatformSpenderStatus

[PlayerPlatformSpenderStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PlayerPlatformSpenderStatus.html) 枚举表示平台定义的玩家跨平台消费状态分类。

## 适用场景

仅在某个公开 API 或项目契约明确返回 [PlayerPlatformSpenderStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PlayerPlatformSpenderStatus.html) 时，使用命名成员进行分支判断。

## 使用要点

通过 Enums.PlayerPlatformSpenderStatus.Unknown、Active 或 OtherPayer 比较已知类型的值。当前公开 Surface 没有直接声明为该枚举的返回值或字段。

## 注意事项

AnalyticsService:GetPlayerSegmentsAsync 当前只公开返回 Table，未公开 PlatformSpenderStatus 字段或表结构；不要据此推断获取链路。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Unknown` | 数据不可用 |
| `1` | `Active` | 活跃的跨平台消费者 |
| `2` | `OtherPayer` | 非活跃消费者（包括完全未消费） |
