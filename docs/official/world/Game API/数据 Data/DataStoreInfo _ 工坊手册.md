# DataStoreInfo

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[DataStoreInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreInfo.html) 是 [DataStoreService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/DataStoreService.html) 列表接口返回的集合信息条目，包含集合名称、类型、创建/更新时间、键数量、占用大小和删除状态。

## 适用场景

在服务端管理脚本中列出普通 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 或 [OrderedDataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStore.html) 集合时，读取每个集合的元信息用于巡检、迁移或清理。

## 使用要点

先调用 DataStoreService:ListDataStoresAsync 或 ListOrderedDataStoresAsync 获得 [DataStoreInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreInfoPages.html)，再从 pages:GetCurrentPage() 返回的数组中读取 [DataStoreInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreInfo.html) 条目。

## 注意事项

该对象不可直接构造，只能从 [DataStoreInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreInfoPages.html) 分页迭代中获得。DataStoreType 为 1 表示普通数据存储，2 表示有序数据存储。IsDeleted 为 true 时表示该集合已被标记删除，不应再对其进行读写操作。

## 代码示例

### 读取 DataStoreInfo 条目

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')

Task:Spawn(function()
    local pages = DataStoreService:ListDataStoresAsync('', 10)
    for _, info in ipairs(pages:GetCurrentPage()) do
        print('集合:', info.DataStoreName)
        print('类型:', info.DataStoreType, '键数量:', info.KeyCount, '大小:', info.Size)
    end
end)
```

## 属性 (7)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `DataStoreName` | `String` | `""` | 数据存储的名称，用于标识该数据存储。 |
| `DataStoreType` | `Int` | `1` | 数据存储的类型，1 表示普通数据存储，2 表示有序数据存储。 |
| `CreatedTime` | `Int` | `0` | 数据存储的创建时间，以毫秒时间戳表示。 |
| `UpdatedTime` | `Int` | `0` | 数据存储的最后更新时间，以毫秒时间戳表示。 |
| `KeyCount` | `Int` | `0` | 数据存储中包含的键数量。 |
| `Size` | `Int` | `0` | 数据存储中所有数据的总大小，以字节为单位。 |
| `IsDeleted` | `Bool` | `false` | 表示该数据存储是否已被删除。 |
