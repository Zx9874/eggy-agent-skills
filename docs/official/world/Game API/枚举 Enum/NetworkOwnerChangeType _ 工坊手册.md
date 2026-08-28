# NetworkOwnerChangeType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → NetworkOwnerChangeType

[NetworkOwnerChangeType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/NetworkOwnerChangeType.html) 枚举定义网络所有权策略值，用于表达物理对象由系统自动处理所有权，或由脚本按业务逻辑手动处理。

## 适用场景

仅在某个公开 API 或项目契约明确声明 [NetworkOwnerChangeType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/NetworkOwnerChangeType.html) 时，用 Automatically 或 Manually 表达所有权策略。

## 使用要点

通过 Enums.NetworkOwnerChangeType.Automatically 或 Manually 引用成员。当前公开 Surface 没有直接声明为 [NetworkOwnerChangeType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/NetworkOwnerChangeType.html) 的参数、属性或返回值。

## 注意事项

当前 BasePart:SetNetworkOwner(player) 只接收 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)，不接收 [NetworkOwnerChangeType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/NetworkOwnerChangeType.html)；不要把该枚举添加为额外参数。枚举值必须通过 Enums.NetworkOwnerChangeType 命名空间访问。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `1` | `Automatically` | Automatically |
| `2` | `Manually` | Manually |
