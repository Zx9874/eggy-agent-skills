# OrderedDataStoreKeyValueInfoPages

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

### 继承关系

* [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)（1 属性 / 2 函数）
  + **[OrderedDataStoreKeyValueInfoPages]**

### 继承成员

1 个来源 / 1 属性 / 2 函数

* 来自 [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)（1 属性 / 2 函数）
  + 属性：[`IsFinished`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#properties)
  + 函数：[`GetCurrentPage`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#functions)、[`AdvanceToNextPageAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#functions)

[OrderedDataStoreKeyValueInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStoreKeyValueInfoPages.html) 是 OrderedDataStore:GetSortedAsync 返回的分页迭代器，GetCurrentPage() 返回 [OrderedDataStoreKeyValueInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStoreKeyValueInfo.html) 数组。

## 适用场景

用于读取 [OrderedDataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStore.html) 排序结果，例如排行榜或按数值排序的统计项。

## 使用要点

该类型不可直接构造，应从 DataStoreService:GetOrderedDataStore 获取 [OrderedDataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStore.html)，再调用 GetSortedAsync 得到 pages。GetSortedAsync 是异步方法，需在协程环境中调用。

## 代码示例

### 分页读取 OrderedDataStore 排序结果

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local orderedStore = DataStoreService:GetOrderedDataStore('PlayerScore')

Task:Spawn(function()
    local options = DataStoreGetOptions.New()
    local pages = orderedStore:GetSortedAsync(false, 10, nil, nil, options)
    while true do
        for _, item in ipairs(pages:GetCurrentPage()) do
            print(item.Scope, item.Key, item.Value, item.UpdatedTime)
        end
        if pages.IsFinished then
            break
        end
        local ok = pages:AdvanceToNextPageAsync()
        if not ok then
            break
        end
    end
end)
```

## 关联类型

* [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)
