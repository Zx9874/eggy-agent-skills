# TweenStatus

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → TweenStatus

[TweenStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TweenStatus.html) 枚举表示 EUI 节点补间动画的结束状态，用于区分补间是正常播放完成还是被同通道的新补间抢占取消。

## 适用场景

调用 EUI 节点的 TweenPosition、TweenSize、TweenSizeAndPosition 或 TweenOpacity 时，在 callback 参数中读取结束状态并决定后续逻辑。

## 使用要点

在 EUI 节点补间方法的 callback(status) 中，将 status 与 Enums.TweenStatus.Completed 或 Enums.TweenStatus.Canceled 比较。

## 注意事项

[TweenStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TweenStatus.html) 只服务于 EUI 节点 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html) 系列方法的回调，不适用于 [TweenService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TweenService.html) 创建的 [Tween](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tween.html)；[TweenService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TweenService.html) 的播放阶段使用 Enums.TweenPlayState。枚举值必须通过 Enums.TweenStatus 命名空间访问，禁止使用数字代替。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Completed` | EUI 节点补间自然完成，或持续时间不大于 0 时立即完成。 |
| `1` | `Canceled` | EUI 节点补间被同通道 override=true 的新补间抢占而提前终止。 |
