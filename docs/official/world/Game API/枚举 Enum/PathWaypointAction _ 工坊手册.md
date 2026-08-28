# PathWaypointAction

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → PathWaypointAction

[PathWaypointAction](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PathWaypointAction.html) 枚举定义了寻路路径点上的行为类型，用于标记角色到达该点后应执行的动作。它包含 Walk（行走）、Jump（跳跃）和 Custom（自定义）三种选项，供寻路系统在生成路径时使用。

## 适用场景

在调用 Path:ComputeAsync 计算路径后，通过 [PathWaypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PathWaypoint.html) 的 Action 属性获取该枚举值，以判断角色在路径点上的移动方式。

## 使用要点

通过 Enums.PathWaypointAction.Walk 等形式引用枚举成员，避免使用数字。通常从 [PathWaypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PathWaypoint.html) 实例的 Action 属性读取，然后根据值执行相应逻辑。

## 注意事项

该枚举值由寻路系统自动设置，开发者无需手动创建。Custom 类型允许通过脚本自定义行为，但需结合具体游戏逻辑实现。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Walk` | 普通地面移动 |
| `1` | `Jump` | 跳跃（off-mesh link） |
| `2` | `Custom` | 自定义动作（预留） |
