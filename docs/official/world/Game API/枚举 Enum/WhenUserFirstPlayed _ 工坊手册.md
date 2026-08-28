# WhenUserFirstPlayed

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → WhenUserFirstPlayed

[WhenUserFirstPlayed](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/WhenUserFirstPlayed.html) 枚举表示玩家首次进入游戏的时间段划分，用于区分新老玩家群体。它提供了一组预定义的区间值，如 Unknown、Days0To30、Days31To90 等，帮助开发者根据玩家注册时长进行差异化处理。

## 适用场景

仅在某个公开 API 或项目契约明确返回 [WhenUserFirstPlayed](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/WhenUserFirstPlayed.html) 时，使用命名成员判断玩家首次游玩时间分段。

## 使用要点

通过 Enums.WhenUserFirstPlayed.Unknown、Days0To30 等成员比较已知类型的值。当前公开 Surface 没有直接声明为该枚举的参数、属性或返回值。

## 注意事项

该分段由平台定义；AnalyticsService:GetPlayerSegmentsAsync 只公开返回 Table，未公开包含 [WhenUserFirstPlayed](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/WhenUserFirstPlayed.html) 的字段。不要把枚举值擅自作为 LogCustomEvent 等埋点参数。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Unknown` | 数据不可用 |
| `1` | `Days0To30` | 过去 30 天内首次游玩 |
| `2` | `Days31To90` | 31-90 天前首次游玩 |
| `3` | `Days91To180` | 91-180 天前首次游玩 |
| `4` | `Days181To365` | 181-365 天前首次游玩 |
| `5` | `Days366Plus` | 365 天前首次游玩 |
