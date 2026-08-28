# TweenPlayState

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → TweenPlayState

[TweenPlayState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TweenPlayState.html) 枚举定义 Tween.PlaybackState 属性可能返回的播放阶段，包括 Begin、Delayed、Playing、Paused、Completed 和 Cancelled。

## 适用场景

在需要轮询或读取补间动画当前阶段时，访问 tween.PlaybackState，并与 Enums.TweenPlayState.Playing、Paused、Completed 等成员比较。

## 使用要点

通过 TweenService:Create 创建 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 后，读取 tween.PlaybackState 判断播放阶段；Tween.Completed 事件的回调参数表示终止原因，使用 Enums.TweenStatus 判断。

## 注意事项

[TweenPlayState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TweenPlayState.html) 用于 PlaybackState 属性；Tween.Completed 事件回调参数使用 [TweenStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TweenStatus.html)。枚举值必须通过 Enums.TweenPlayState 命名空间访问，禁止使用数字代替。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Begin` | 初始状态，尚未播放 |
| `1` | `Delayed` | 等待延迟时间结束 |
| `2` | `Playing` | 正在插值中 |
| `3` | `Paused` | 已暂停 |
| `4` | `Completed` | 已完成所有循环 |
| `5` | `Cancelled` | 已被取消 |
