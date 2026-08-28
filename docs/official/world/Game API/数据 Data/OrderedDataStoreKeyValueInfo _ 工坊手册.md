# OrderedDataStoreKeyValueInfo

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

有序数据存储键值对信息对象，封装了有序数据存储中单条记录的完整信息。它提供了键名、值、前置域和更新时间等属性，用于在分页查询结果中遍历和读取数据。

## 适用场景

当通过 [OrderedDataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStore.html) 的 GetSortedAsync 方法获取排序后的数据分页时，遍历 [OrderedDataStoreKeyValueInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStoreKeyValueInfoPages.html) 即可得到该类型的实例，从而读取每条记录的键、值和元数据。

## 使用要点

先通过 [DataStoreService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/DataStoreService.html) 获取 [OrderedDataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStore.html) 实例，再调用其 GetSortedAsync 方法得到 [OrderedDataStoreKeyValueInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStoreKeyValueInfoPages.html) 对象。使用 [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html) 的 GetCurrentPage 方法获取当前页的 [OrderedDataStoreKeyValueInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStoreKeyValueInfo.html) 数组，然后遍历数组读取每个元素的 Scope、Key、Value 和 UpdatedTime 属性。

## 注意事项

该类型不可直接构造，只能通过 [OrderedDataStoreKeyValueInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStoreKeyValueInfoPages.html) 的分页迭代获得实例。Value 属性为整数类型，确保存储和读取时数据类型匹配。UpdatedTime 为毫秒时间戳，可用于判断数据的新鲜度。

## 代码示例

### 从排序分页结果读取条目信息

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local orderedStore = DataStoreService:GetOrderedDataStore('PlayerScore')

Task:Spawn(function()
    local pages = orderedStore:GetSortedAsync(false, 10)
    for _, item in ipairs(pages:GetCurrentPage()) do
        print(item.Scope, item.Key, item.Value, item.UpdatedTime)
    end
end)
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Scope` | `String` | `""` | 该键值对所属的前置域（Scope），用于区分不同命名空间下的数据。 |
| `Key` | `String` | `""` | 有序数据存储中该键值对的键名。 |
| `Value` | `Int` | `0` | 该键值对存储的整数值。 |
| `UpdatedTime` | `Int` | `0` | 该键值对最后一次更新的时间，以毫秒时间戳表示。 |
