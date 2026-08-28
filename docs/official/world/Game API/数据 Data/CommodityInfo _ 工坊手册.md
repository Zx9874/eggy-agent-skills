# CommodityInfo

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[CommodityInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CommodityInfo.html) 是商品信息条目数据，用于承载商品 ID 与数量。

## 适用场景

当公开 API 或业务回调提供 [CommodityInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CommodityInfo.html) 条目时，读取 CommodityId 与 CommodityNum 展示或处理商品数量。

## 使用要点

接收已有的 [CommodityInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CommodityInfo.html) 条目后直接读取 CommodityId 和 CommodityNum；查询玩家是否拥有商品用 CommodityService:HasCommodity，查询数量用 CommodityService:GetCommodityCount。

## 注意事项

[CommodityInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CommodityInfo.html) 是只读数据结构，不可直接构造。CommodityService:GetGoodsInfo(goodsId) 返回商品详情 Map；需要商品数量时使用 GetCommodityCount(player, commodityId)，需要判断是否拥有时使用 HasCommodity(player, commodityId)。

## 代码示例

### 读取 CommodityInfo 条目

```lua
-- @runtime client
local function printCommodityInfo(info)
    if info == nil then
        return
    end
    print('商品 ID:', info.CommodityId, '数量:', info.CommodityNum)
end
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `CommodityId` | `Int` | `0` | 道具的唯一标识符，用于在商品服务中区分不同的道具。 |
| `CommodityNum` | `Int` | `0` | 道具的数量，表示该道具当前持有的个数。 |
