# MemoryStoreSortedMapPages

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

### 继承关系

* [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)（1 属性 / 2 函数）
  + **[MemoryStoreSortedMapPages]**

### 继承成员

1 个来源 / 1 属性 / 2 函数

* 来自 [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)（1 属性 / 2 函数）
  + 属性：[`IsFinished`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#properties)
  + 函数：[`GetCurrentPage`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#functions)、[`AdvanceToNextPageAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#functions)

[MemoryStoreSortedMapPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapPages.html) 是 MemoryStoreSortedMap:GetRangeAsync 返回的分页迭代器，当前页元素形如 { Key = String, Value = Any, SortKey = Any }。

## 适用场景

用于读取排行榜、时间线等有序结果集。先通过 MemoryStoreService:GetSortedMap 获取 SortedMap，再调用 GetRangeAsync 得到 pages，随后读取 GetCurrentPage()。

## 使用要点

该类型不可直接构造，应从 MemoryStoreSortedMap:GetRangeAsync 返回值获取。遍历多页时，在处理完当前页后调用 AdvanceToNextPageAsync()，直到 IsFinished 为 true。

## 代码示例

### 读取 SortedMap 分页结果

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local sortedMap = MemoryStoreService:GetSortedMap('season_score')

    local pages = sortedMap:GetRangeAsync(Enums.SortDirection.Descending, 10)
    while true do
        for _, item in ipairs(pages:GetCurrentPage()) do
            print(item.Key, item.Value, item.SortKey)
        end
        if pages.IsFinished then
            break
        end
        if not pages:AdvanceToNextPageAsync() then
            break
        end
    end
end)
```

## 关联类型

* [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)
