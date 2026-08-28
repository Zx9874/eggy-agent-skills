# AnimationPriority

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → AnimationPriority

[AnimationPriority](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AnimationPriority.html) 枚举定义了动画轨道的播放覆盖顺序，用于控制多个动画同时播放时哪个动画的姿势优先显示。开发者可用的优先级从低到高依次为 Idle、Movement、Action、Action2、Action3、Action4，其中 Action4 是最高优先级，会覆盖所有低优先级动画；Core 是引擎内部保留的最低优先级，供默认动画兜底使用，开发者不应主动设置。

## 适用场景

在需要同时播放多个动画时，通过设置 [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html) 的 Priority 属性来决定动画的混合权重，例如让攻击动画覆盖行走动画，或让待机动画作为基础层。

## 使用要点

通过 Enums.AnimationPriority.Idle 等形式引用枚举值，然后赋值给 [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html) 的 Priority 属性，如 animTrack.Priority = Enums.AnimationPriority.Action4。在条件判断中可直接比较，如 if animTrack.Priority == Enums.AnimationPriority.Action4 then ... end。

## 注意事项

[AnimationPriority](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AnimationPriority.html) 控制动画轨道的播放覆盖顺序。优先级数值：Core(1000) 是引擎内部保留的最低优先级（供 Eggy 默认动画使用，开发者不应主动使用，会被所有开发者动画覆盖）；开发者可用的优先级从低到高为 Idle(0) < Movement(1) < Action(2) < Action2(3) < Action3(4) < Action4(5)，Action4(5) 是开发者可用的最高优先级。设置更高优先级的动画会覆盖低优先级动画。注意 Core 虽数值最大(1000)但语义上是最低优先级（供默认动画兜底），不要被数值误导。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Idle` | 推荐用于角色休闲动画的优先级 |
| `1` | `Movement` | 推荐用于走路、跑步、游泳、攀爬和其他运动动画的优先级 |
| `2` | `Action` | 推荐用于必须覆盖休闲和运动动画的角色动作的优先级 |
| `3` | `Action2` | Action2 将覆盖 Action |
| `4` | `Action3` | Action3 将覆盖 Action2 |
| `5` | `Action4` | Action4 是可用的最高优先级，覆盖所有其他优先级值 |
| `1000` | `Core` | 最低优先级，供 Eggy 默认动画使用 |
