# EasingDirection

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → EasingDirection

[EasingDirection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingDirection.html) 枚举定义缓动曲线在补间时间轴上的作用阶段：In 表示缓动效果主要作用于开始阶段，Out 表示作用于结束阶段，InOut 表示两端都应用，OutIn 表示先按 Out 再按 In 组合。

## 适用场景

在构造 [TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html) 时，通过 [EasingDirection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingDirection.html) 决定所选 [EasingStyle](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingStyle.html) 曲线如何分布在动画开始、结束或两端阶段，例如 InOut 常用于先加速后减速的平滑过渡。

## 使用要点

通过 Enums.EasingDirection.In、Enums.EasingDirection.Out、Enums.EasingDirection.InOut、Enums.EasingDirection.OutIn 引用枚举成员，并作为 TweenInfo.New 的第三个参数传入。

## 注意事项

[EasingDirection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingDirection.html) 不是动画播放方向，也不会让动画反向播放；反向/往返播放由 [TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html) 的 Reverses、RepeatCount 等参数控制。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `In` | 缓动效果主要作用于动画开始阶段 |
| `1` | `Out` | 缓动效果主要作用于动画结束阶段 |
| `2` | `InOut` | 开始和结束阶段都应用缓动，中段变化更平滑 |
| `3` | `OutIn` | 先按 Out 曲线进入中段，再按 In 曲线离开中段 |
