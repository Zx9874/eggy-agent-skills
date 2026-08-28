# OrderedDataStore

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

### 继承关系

* [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html)（10 函数）
  + **[OrderedDataStore]**（1 函数）

### 继承成员

1 个来源 / 10 函数

* 来自 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html)（10 函数）
  + 函数：[`GetAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html#functions)、[`SetAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html#functions)、[`IncrementAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html#functions)、[`RemoveAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html#functions)、[`UpdateAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html#functions)、[`ListKeysAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html#functions)、[`GetVersionAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html#functions)、[`GetVersionAtTimeAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html#functions)、[`ListVersionsAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html#functions)、[`RemoveVersionAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html#functions)

有序数据存储集合，用于存储键值对并支持按值排序检索。它继承自 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html)，额外提供 GetSortedAsync 方法，可按升序或降序分页获取数据。写入的值必须是整数，适合排行榜、分数记录等需要排序的场景。

## 适用场景

典型场景是实现玩家排行榜，将玩家分数作为值存入 [OrderedDataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStore.html)，然后通过 GetSortedAsync 按分数降序获取排名列表。

## 使用要点

通过 DataStoreService:GetOrderedDataStore 获取实例，使用 SetAsync 写入整数键值对，再调用 GetSortedAsync 并指定排序方向与分页大小，返回的 [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html) 对象可通过 GetCurrentPage 和 AdvanceToNextPageAsync 遍历结果。

## 注意事项

[OrderedDataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStore.html) 不可直接构造，必须由 DataStoreService:GetOrderedDataStore 返回；写入值必须是整数。GetSortedAsync 是异步读操作，应在 Task:Spawn 或协程中调用；返回 [OrderedDataStoreKeyValueInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStoreKeyValueInfoPages.html) 后通过 GetCurrentPage/AdvanceToNextPageAsync 分页读取。

## 代码示例

### 写入分数并按降序读取排行榜

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local orderedStore = DataStoreService:GetOrderedDataStore('PlayerScore')

Task:Spawn(function()
    orderedStore:SetAsync('player_1001', 1200)
    orderedStore:SetAsync('player_1002', 900)

    local options = DataStoreGetOptions.New()
    local pages = orderedStore:GetSortedAsync(false, 10, nil, nil, options)
    for _, item in ipairs(pages:GetCurrentPage()) do
        print(item.Key, item.Value)
    end
end)
```

## 关联类型

* [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html)

## 函数 (1)

### GetSortedAsync

签名：`GetSortedAsync(ascending: Bool, pageSize?: Int, minValue?: Int, maxValue?: Int, options?: DataStoreGetOptions) -> OrderedDataStoreKeyValueInfoPages (分页迭代器)`

获取有序数据存储中按 value 排序的分页数据。返回一个分页迭代器，可遍历排序后的键值对。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `ascending` | `Bool` | 是否升序 |
| `pageSize?` | `Int` | 页大小, 默认 0 (使用服务端默认值) |
| `minValue?` | `Int` | 最小值过滤, 包含 |
| `maxValue?` | `Int` | 最大值过滤, 包含 |
| `options?` | [DataStoreGetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetOptions.html) | 可选参数, 优先级高于 [OrderedDataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStore.html) 初始化时的 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html), 可通过 DataStoreGetOptions.New() 创建 |

**返回值** [OrderedDataStoreKeyValueInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStoreKeyValueInfoPages.html) (分页迭代器)

> 示例代码

> 按 value 降序读取分页

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local orderedStore = DataStoreService:GetOrderedDataStore('PlayerScore')

Task:Spawn(function()
    local options = DataStoreGetOptions.New()
    local pages = orderedStore:GetSortedAsync(false, 10, nil, nil, options)
    for _, item in ipairs(pages:GetCurrentPage()) do
        print(item.Key, item.Value)
    end
end)
```
