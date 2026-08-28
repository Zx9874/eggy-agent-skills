# MemoryStoreSortedMap

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[MemoryStoreSortedMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMap.html) 是内存键值存储中的有序集合，支持按排序键对数据进行排序和范围查询。它提供设置、获取、删除、更新条目以及获取集合大小等操作，适用于需要快速排序和分页读取的场景。

## 适用场景

常用于排行榜、积分列表等需要按分数或时间排序的功能，通过 MemoryStoreService:GetSortedMap 获取实例后，使用 SetAsync 写入带排序键的数据，再用 GetRangeAsync 分页读取排序后的结果。

## 使用要点

通过 MemoryStoreService:GetSortedMap 获取 [MemoryStoreSortedMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMap.html) 实例。调用 SetAsync 写入键值对并指定排序键，使用 GetRangeAsync 按 Enums.SortDirection.Ascending 或 Descending 方向分页获取数据，返回的 [MemoryStoreSortedMapPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapPages.html) 可通过 GetCurrentPage 和 AdvanceToNextPageAsync 遍历。

## 注意事项

[MemoryStoreSortedMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMap.html) 不可直接构造，必须通过 MemoryStoreService:GetSortedMap(name) 获取。key 是业务字符串键名，不是 Enums.\* 枚举值；GetRangeAsync 的 direction 使用 Enums.SortDirection.Ascending/Descending；UpdateAsync 的 transformFunction 应返回 newValue 和可选 newSortKey。

## 代码示例

### 获取 SortedMap 并写入排行榜分数

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local sortedMap = MemoryStoreService:GetSortedMap('season_score')

    local key = 'player:1001'
    local score = 1200
    local options = MemoryStoreSortedMapSetOptions.New()
    sortedMap:SetAsync(key, score, score, options)

    local pages = sortedMap:GetRangeAsync(Enums.SortDirection.Descending, 10)
    for _, item in ipairs(pages:GetCurrentPage()) do
        print(item.Key, item.Value)
    end
end)
```

## 函数 (7)

### SetAsync

签名：`SetAsync(key: String, value: Any, sortKey?: Any, options?: MemoryStoreSortedMapSetOptions) -> Any, Any (依次返回成功写入的 value 与 sortKey；条件不满足时返回 nil。)`

向有序映射中设置指定 key 的值，并可附带排序键和条件选项。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `value` | `Any` | 数据值 |
| `sortKey?` | `Any` | 排序键, 可为数字/字符串/nil |
| `options?` | [MemoryStoreSortedMapSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapSetOptions.html) | 可选参数 (条件修饰/TTL 等), 可通过 MemoryStoreSortedMapSetOptions.New(...) 或 [MemoryStoreSortedMapSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapSetOptions.html)(...) 创建 |

**返回值** `Any, Any` (依次返回成功写入的 value 与 sortKey；条件不满足时返回 nil。)

> 示例代码

> 写入 SortedMap 值和排序键

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local sortedMap = MemoryStoreService:GetSortedMap('season_score')

    local options = MemoryStoreSortedMapSetOptions.New()
    local score = 1200
    local writtenValue, writtenSortKey = sortedMap:SetAsync('player:1001', score, score, options)
    print('写入结果:', writtenValue, writtenSortKey)
end)
```

### GetAsync

签名：`GetAsync(key: String) -> Any, Any (依次返回 value 与 sortKey；键不存在时两者均为 nil。)`

从有序映射中获取指定 key 对应的值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |

**返回值** `Any, Any` (依次返回 value 与 sortKey；键不存在时两者均为 nil。)

> 示例代码

> 读取 SortedMap 键值

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local sortedMap = MemoryStoreService:GetSortedMap('season_score')

    local score, sortKey = sortedMap:GetAsync('player:1001')
    print('玩家分数和排序键:', score, sortKey)
end)
```

### RemoveAsync

签名：`RemoveAsync(key: String) -> void`

从有序映射中删除指定 key 的条目。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |

**返回值** `void`

> 示例代码

> 删除 SortedMap 键

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local sortedMap = MemoryStoreService:GetSortedMap('season_score')

    sortedMap:RemoveAsync('player:1001')
end)
```

### GetRangeAsync

签名：`GetRangeAsync(direction: SortDirection, count: Int, options?: MemoryStoreSortedMapGetRangeOptions) -> MemoryStoreSortedMapPages (分页迭代器)`

按排序键范围分页查询有序映射中的条目。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `direction` | [SortDirection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/SortDirection.html) | 排序方向，使用 Enums.SortDirection.Ascending 或 Enums.SortDirection.Descending。 |
| `count` | `Int` | 每页数量 |
| `options?` | [MemoryStoreSortedMapGetRangeOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapGetRangeOptions.html) | 可选参数, 可通过 MemoryStoreSortedMapGetRangeOptions.New(...) 或 [MemoryStoreSortedMapGetRangeOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapGetRangeOptions.html)(...) 创建 |

**返回值** [MemoryStoreSortedMapPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapPages.html) (分页迭代器)

> 示例代码

> 按分数降序读取排行榜

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local sortedMap = MemoryStoreService:GetSortedMap('season_score')

    local pages = sortedMap:GetRangeAsync(Enums.SortDirection.Descending, 10)
    for _, item in ipairs(pages:GetCurrentPage()) do
        print(item.Key, item.Value)
    end
end)
```

### GetSizeAsync

签名：`GetSizeAsync() -> Int (元素数量)`

获取有序映射中当前存储的元素总数。

**返回值** `Int` (元素数量)

> 示例代码

> 读取 SortedMap 元素数量

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local sortedMap = MemoryStoreService:GetSortedMap('season_score')

    local size = sortedMap:GetSizeAsync()
    print('排行榜人数:', size)
end)
```

### DeleteAsync

签名：`DeleteAsync() -> void`

删除整个 [MemoryStoreSortedMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMap.html) 集合，包括其中的所有键值对。

**返回值** `void`

> 示例代码

> 仅删除确认可清理的文档沙盒 SortedMap

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    -- DeleteAsync 会删除整张表，只能用于确认可清理的文档沙盒
    local sortedMap = MemoryStoreService:GetSortedMap('DocumentationSandboxSortedMap')

    sortedMap:DeleteAsync()
end)
```

### UpdateAsync

签名：`UpdateAsync(key: String, transformFunction: Function, sortKey?: Any) -> Any, Any (依次返回更新后的 value 与 sortKey；transform 返回 nil 时两者均为 nil。)`

通过比较并交换语义原子更新指定 key 的值和排序键；发生并发冲突时可能重新调用 transformFunction。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `transformFunction` | `Function` | 变换函数 (oldValue, oldSortKey) → newValue, newSortKey?, options? |
| `sortKey?` | `Any` | 初始 sortKey 兜底 (仅在键首次创建时生效) |

**返回值** `Any, Any` (依次返回更新后的 value 与 sortKey；transform 返回 nil 时两者均为 nil。)

> 示例代码

> 原子更新分数和排序键

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local sortedMap = MemoryStoreService:GetSortedMap('season_score')

    local newScore, newSortKey = sortedMap:UpdateAsync('player:1001', function(oldValue, oldSortKey)
        local score = (oldValue or 0) + 10
        return score, score
    end, 0)
    print('更新后分数和排序键:', newScore, newSortKey)
end)
```
