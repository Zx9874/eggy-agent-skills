# MemoryStoreHashMapPages

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

### 继承关系

* [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)（1 属性 / 2 函数）
  + **[MemoryStoreHashMapPages]**

### 继承成员

1 个来源 / 1 属性 / 2 函数

* 来自 [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)（1 属性 / 2 函数）
  + 属性：[`IsFinished`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#properties)
  + 函数：[`GetCurrentPage`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#functions)、[`AdvanceToNextPageAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#functions)

[MemoryStoreHashMapPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapPages.html) 是 MemoryStoreHashMap:ListItemsAsync 返回的分页迭代器，GetCurrentPage() 返回 { Key = String, Value = Any } 数组。

## 适用场景

用于调试或管理 [MemoryStoreHashMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMap.html) 中的条目，例如查看房间状态、临时匹配数据或计数器快照。

## 使用要点

该类型不可直接构造，应从 MemoryStoreService:GetHashMap(name) 获取 HashMap 后调用 ListItemsAsync(count) 得到 pages。

## 代码示例

### 分页列出 HashMap 条目

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local hashMap = MemoryStoreService:GetHashMap('match_state')

    local pages = hashMap:ListItemsAsync(20)
    while true do
        for _, item in ipairs(pages:GetCurrentPage()) do
            print(item.Key, item.Value)
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
