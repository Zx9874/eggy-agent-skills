# DisplayDistanceType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → DisplayDistanceType

[DisplayDistanceType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DisplayDistanceType.html) 枚举控制生物头顶名字与血条的显示距离判定方式。它提供三种模式：不显示、按观察者距离显示、按被观察者距离显示，用于灵活适配不同视角下的信息可见性。

## 适用场景

在设置 [BaseController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html) 的 [DisplayDistanceType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DisplayDistanceType.html) 属性时，根据游戏视角需求选择判定方式，例如在第三人称游戏中常用 Subject 模式让名字随角色距离渐隐。

## 使用要点

将 Enums.DisplayDistanceType.None、Viewer 或 Subject 赋给 BaseController.DisplayDistanceType，选择头顶名字与血条的距离判定视角；最大距离分别由 NameDisplayDistance 与 HealthDisplayDistance 控制。

## 注意事项

[DisplayDistanceType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DisplayDistanceType.html) 负责距离判定方式；HPBarShowMode 另行控制血条显示模式，NameDisplayDistance/HealthDisplayDistance 控制最大显示距离。不要把这些独立属性描述成必须成对设置才生效。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `None` | 隐藏 |
| `1` | `Viewer` | 观察者距离 |
| `2` | `Subject` | 被观察者距离 |
