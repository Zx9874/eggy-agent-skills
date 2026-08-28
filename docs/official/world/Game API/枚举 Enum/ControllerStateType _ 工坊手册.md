# ControllerStateType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `String`
* **继承链**: `String` → ControllerStateType

[ControllerStateType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ControllerStateType.html) 枚举定义了角色控制器可能处于的各种行为状态，如待机、移动、跳跃、攀爬、死亡等。通过监听控制器的状态变化事件，可以在不同状态间切换时触发对应的游戏逻辑。

## 适用场景

在角色移动、跳跃、落地、攀爬、受控/失控、死亡或复活等状态变化时，通过控制器事件判断新旧状态并执行对应游戏逻辑。

## 使用要点

通过 [BaseController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html) 的 StateChanged 事件获取新旧状态，然后使用 Enums.ControllerStateType.Jumping 等形式与 newState 进行比较，从而在特定状态切换时执行自定义逻辑。

## 注意事项

枚举值必须通过 Enums.ControllerStateType 前缀引用，禁止使用数字代替。状态变化事件由 [BaseController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html) 触发，需确保控制器实例已正确获取。

## 枚举值

| 名称 | 说明 |
| --- | --- |
| `Idle` | 待机 |
| `Moving` | 移动 |
| `Jumping` | 跳跃 |
| `Dead` | 死亡 |
| `LostControl` | 失控 |
| `ResumeControl` | 恢复控制 |
| `Climbing` | 攀爬 |
| `Seated` | 乘坐 |
| `PlatformStanding` | PlatformStand 状态：自主移动禁用、外力可推、跳跃不退出 |
| `Swimming` | 游泳 |
| `EggyRush` | 蛋仔前仆 |
| `EggyRoll` | 蛋仔滚动 |
| `EggyLifted` | 蛋仔被抓举 |
| `EggyLiftStart` | 蛋仔开始抓举 |
| `EggyLiftThrow` | 蛋仔开始扔掉抓举单位 |
| `HumanRun` | 人形生物跑步 |
| `HumanCrouchIdle` | 人形蹲下静止状态 |
| `HumanCrouchMove` | 人形蹲下移动状态 |
