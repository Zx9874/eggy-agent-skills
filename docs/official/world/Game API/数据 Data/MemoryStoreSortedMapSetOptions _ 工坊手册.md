# MemoryStoreSortedMapSetOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[MemoryStoreSortedMapSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapSetOptions.html) 用于配置 MemoryStoreSortedMap:SetAsync 的写入行为，支持条件更新、自增操作和键的生存时间设置。通过组合 XX、NX、LT、GT 等条件字段，可实现仅在满足特定条件时才执行写入；INCR 字段允许对数值型排序键进行原子累加；EX、PX 等字段则控制键的过期策略。

## 适用场景

在排行榜或计数器场景中，需要原子地累加排序键并同时刷新键的生存时间时，使用 [MemoryStoreSortedMapSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapSetOptions.html) 配置 INCR 和 EX 字段，确保写入的并发安全与数据时效性。

## 使用要点

通过 MemoryStoreSortedMapSetOptions.New() 创建配置对象，设置所需的条件字段（如 INCR = true）和 TTL 字段（如 EX = 86400），然后将该对象作为参数传入 sortedMap:SetAsync(key, value, sortKey, opts)。

## 注意事项

所有字段均为可选；INCR 仅对数值 sortKey 生效。EX、PX、EXAT、PXAT 与 KEEPTTL 是互斥的 TTL 策略，一次写入只选择其中一种。

## 代码示例

### 设置 TTL 并写入排行榜分数

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local sortedMap = MemoryStoreService:GetSortedMap('season_score')

    local options = MemoryStoreSortedMapSetOptions.New()
    options.EX = 86400
    sortedMap:SetAsync('player:1001', 1200, 1200, options)
end)
```

## 属性 (20)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `XX` | `Bool` | `-` | 仅当键存在时设置。 |
| `NX` | `Bool` | `-` | 仅当键不存在时设置。 |
| `MSXX` | `Bool` | `-` | 仅当整个 MemoryStore 存在时设置。 |
| `MSNX` | `Bool` | `-` | 仅当整个 MemoryStore 不存在时设置。 |
| `LT` | `Bool` | `-` | 仅当新旧 sortKey 都为数值且新值小于当前值时更新。 |
| `LTE` | `Bool` | `-` | 仅当新旧 sortKey 都为数值且新值小于等于当前值时更新。 |
| `GT` | `Bool` | `-` | 仅当新旧 sortKey 都为数值且新值大于当前值时更新。 |
| `GTE` | `Bool` | `-` | 仅当新旧 sortKey 都为数值且新值大于等于当前值时更新。 |
| `INCR` | `Bool` | `-` | 累加而非覆盖 sortKey，要求新旧值均为数值。 |
| `LTT` | `Float` | `-` | 仅当旧 sortKey 小于指定值时更新。 |
| `LTET` | `Float` | `-` | 仅当旧 sortKey 小于等于指定值时更新。 |
| `GTT` | `Float` | `-` | 仅当旧 sortKey 大于指定值时更新。 |
| `GTET` | `Float` | `-` | 仅当旧 sortKey 大于等于指定值时更新。 |
| `EQT` | `Float` | `-` | 仅当旧 sortKey 等于指定值时更新。 |
| `NEQT` | `Float` | `-` | 仅当旧 sortKey 不等于指定值时更新。 |
| `EX` | `Int` | `-` | 以秒为单位的生存时间。 |
| `PX` | `Int` | `-` | 以毫秒为单位的生存时间。 |
| `EXAT` | `Int` | `-` | 以秒为单位的绝对生存时间。 |
| `PXAT` | `Int` | `-` | 以毫秒为单位的绝对生存时间。 |
| `KEEPTTL` | `Bool` | `-` | 保留现有键的生存时间。 |

## 函数 (1)

### New

签名：`New() -> MemoryStoreSortedMapSetOptions`

创建一个新的 [MemoryStoreSortedMapSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapSetOptions.html) 实例，用于配置 SortedMap 的 SetAsync 操作选项。

**返回值** [MemoryStoreSortedMapSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapSetOptions.html)

> 示例代码

> 构造 MemoryStoreSortedMapSetOptions 并设置条件写入选项

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local memoryStoreService = game:GetService("MemoryStoreService")
    local sortedMap = memoryStoreService:GetSortedMap("TestMap")

    -- 使用 New() 构造选项对象，并设置 NX 条件（仅当 key 不存在时写入）
    local opts = MemoryStoreSortedMapSetOptions.New()
    opts.NX = true

    -- 调用 SetAsync 写入数据，传入选项
    sortedMap:SetAsync("player_001", "score_value", 100, opts)
    print("已尝试条件写入：仅当 key 不存在时设置。")
end)
```
