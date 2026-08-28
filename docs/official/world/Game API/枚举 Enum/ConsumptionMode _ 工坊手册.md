# ConsumptionMode

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → ConsumptionMode

[ConsumptionMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ConsumptionMode.html) 枚举定义商品或资源的消耗策略，用于区分永久拥有、按数量扣减和按时间限制三类模式。

## 适用场景

当公开配置、商品信息或业务回调提供消耗模式字段时，可使用该枚举判断道具是永久型、数量型还是时限型。

## 使用要点

通过 Enums.ConsumptionMode.PERMANENT、Enums.ConsumptionMode.AMOUNT、Enums.ConsumptionMode.TIME 引用枚举成员，用于读取或比较已有的消耗模式字段。

## 注意事项

当前公开的 CommodityService:ConsumeCommodity(player, commodityId, num) 不接收 [ConsumptionMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ConsumptionMode.html) 参数；不要把该枚举当作 ConsumeCommodity 的额外参数传入。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `PERMANENT` | 消费模式：永久 |
| `1` | `AMOUNT` | 消费模式：数量 |
| `2` | `TIME` | 消费模式：时间 |
