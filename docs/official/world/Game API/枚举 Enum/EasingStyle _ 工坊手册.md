# EasingStyle

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → EasingStyle

[EasingStyle](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingStyle.html) 定义了动画缓动曲线类型，用于控制补间动画在时间进程中的速度变化模式。它提供了从线性匀速到弹性、弹跳等多种预设曲线，让开发者可以精细调整动画的加速与减速效果。

## 适用场景

在创建 [TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html) 时指定缓动风格，使 UI 元素的移动、缩放或透明度变化呈现自然的加速或弹跳效果。

## 使用要点

通过 Enums.EasingStyle.Linear 等形式引用具体曲线，将其作为 TweenInfo.New 的第二个参数传入。

## 注意事项

[EasingStyle](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingStyle.html) 与 [EasingDirection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingDirection.html) 共同决定补间曲线；[EasingDirection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingDirection.html) 有默认值，未显式传入时仍会按当前默认方向生效。枚举成员必须使用 Enums.EasingStyle 前缀，不能用裸名称或数字代替。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Linear` | 线性 |
| `1` | `Quad` | 二次曲线 |
| `2` | `Cubic` | 三次曲线 |
| `3` | `Quart` | 四次曲线 |
| `4` | `Quint` | 五次曲线 |
| `5` | `Sine` | 正弦曲线 |
| `6` | `Back` | 回弹效果 |
| `7` | `Bounce` | 弹跳效果 |
| `8` | `Elastic` | 弹性效果 |
| `9` | `Exponential` | 指数曲线 |
| `10` | `Circular` | 圆弧曲线 |
