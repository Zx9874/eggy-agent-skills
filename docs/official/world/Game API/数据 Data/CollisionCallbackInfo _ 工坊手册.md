# CollisionCallbackInfo

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[CollisionCallbackInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CollisionCallbackInfo.html) 是 [PhysicsUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PhysicsUnit.html)、[WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 本地碰撞事件传入的只读回调数据，公开提供 OtherUnit，用于标识与当前单位开始或结束碰撞的另一方。该类型不可直接构造。

## 适用场景

监听 [PhysicsUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PhysicsUnit.html) 或 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 的 OnLocalCollisionEnter、OnLocalCollisionExit 时，从 info.OtherUnit 读取碰撞另一方，并据此执行本地表现或判定逻辑。

## 使用要点

在 OnLocalCollisionEnter/OnLocalCollisionExit 的回调中接收 info 并读取 info.OtherUnit。若后续逻辑需要名称等信息，应在对象仍可安全访问时缓存；退出事件可能因碰撞对方提前销毁而补发。

## 注意事项

该类型只能由本地碰撞事件提供，不能主动创建。公开契约未声明 OtherUnit 可空；不要自行扩写可空语义。OnLocalCollisionExit 在碰撞对方提前销毁时也可能补发，因此回调中不要假定对方对象仍可执行依赖存活状态的操作。

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `OtherUnit` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | `-` | 碰撞回调信息中记录的另一方单位实例，即与当前单位发生碰撞的对面单位。 |
