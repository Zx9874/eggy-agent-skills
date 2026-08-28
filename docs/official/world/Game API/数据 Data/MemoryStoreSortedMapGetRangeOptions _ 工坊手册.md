# MemoryStoreSortedMapGetRangeOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[MemoryStoreSortedMapGetRangeOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapGetRangeOptions.html) 用于配置 MemoryStoreSortedMap:GetRangeAsync 的范围查询参数。通过设置键和排序键的上下限，可以精确控制返回的数据范围。所有字段默认为空，表示不施加对应限制。

## 适用场景

在需要从有序映射中按范围获取一批数据时，创建该配置对象并传入 GetRangeAsync 方法，以限定返回的键和排序键区间。

## 使用要点

通过 MemoryStoreSortedMapGetRangeOptions.New() 或 [MemoryStoreSortedMapGetRangeOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapGetRangeOptions.html)() 创建实例，然后设置 LowerBoundKey、UpperBoundKey、LowerBoundSortKey、UpperBoundSortKey 等字段，最后作为参数调用 MemoryStoreSortedMap:GetRangeAsync。

## 注意事项

该类型仅作为 GetRangeAsync 的可选参数容器，不应单独使用。设置的边界值均为开区间，即排除边界自身。

## 代码示例

### 按排序键下限读取范围

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local sortedMap = MemoryStoreService:GetSortedMap('season_score')

    local options = MemoryStoreSortedMapGetRangeOptions.New()
    options.LowerBoundSortKey = 1000
    local pages = sortedMap:GetRangeAsync(Enums.SortDirection.Ascending, 20, options)
    for _, item in ipairs(pages:GetCurrentPage()) do
        print(item.Key, item.Value, item.SortKey)
    end
end)
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `LowerBoundKey` | `String` | `-` | 范围查询的键下限，查询结果中键大于此值的项才会被返回。 |
| `UpperBoundKey` | `String` | `-` | 范围查询的键上限，查询结果中键小于此值的项才会被返回。 |
| `LowerBoundSortKey` | `Any` | `-` | 排序键下限（开区间），类型应与写入 SortedMap 的 sortKey 一致。 |
| `UpperBoundSortKey` | `Any` | `-` | 排序键上限（开区间），类型应与写入 SortedMap 的 sortKey 一致。 |

## 函数 (1)

### New

签名：`New() -> MemoryStoreSortedMapGetRangeOptions`

创建一个新的 [MemoryStoreSortedMapGetRangeOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapGetRangeOptions.html) 实例，用于配置有序映射的范围查询选项。

**返回值** [MemoryStoreSortedMapGetRangeOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapGetRangeOptions.html)

> 示例代码

> 构造范围选项并查询

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local sortedMap = MemoryStoreService:GetSortedMap('season_score')
    local options = MemoryStoreSortedMapGetRangeOptions.New()
    options.LowerBoundSortKey = 1000
    local pages = sortedMap:GetRangeAsync(Enums.SortDirection.Ascending, 20, options)
    print('当前页数量:', #pages:GetCurrentPage())
end)
```
