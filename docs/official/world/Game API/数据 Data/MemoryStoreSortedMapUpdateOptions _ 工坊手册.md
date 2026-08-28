# MemoryStoreSortedMapUpdateOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[MemoryStoreSortedMapUpdateOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapUpdateOptions.html) 是 MemoryStoreSortedMap:UpdateAsync transform 回调返回的可选参数，用于约束旧 sortKey 条件和 TTL 行为。

## 适用场景

当排行榜或有序临时数据需要在原子更新时检查旧排序键、设置过期时间或保留 TTL 时，在 transform 中创建并返回该 options。

## 使用要点

通过 MemoryStoreSortedMapUpdateOptions.New() 创建实例，在 UpdateAsync 的 transformFunction 中与 newValue、newSortKey 一起返回。

## 注意事项

比较字段和 TTL 字段均为可选。EX、PX、EXAT、PXAT 与 KEEPTTL 是互斥的 TTL 策略，一次更新只选择其中一种。

## 代码示例

### 在 UpdateAsync transform 中返回更新选项

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local sortedMap = MemoryStoreService:GetSortedMap('season_score')

    sortedMap:SetAsync('player:1001', 100, 100)
    local newScore = sortedMap:UpdateAsync('player:1001', function(oldValue, oldSortKey)
        local options = MemoryStoreSortedMapUpdateOptions.New()
        options.GTET = 100
        options.EX = 60
        local score = (oldValue or 0) + 10
        return score, score, options
    end)
    print('更新后分数:', newScore)
end)
```

## 属性 (11)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `LTT` | `Float` | `-` | 设置更新条件：仅当当前排序键（sortKey）小于指定值时，才允许执行更新操作。 |
| `LTET` | `Float` | `-` | 设置更新条件：仅当当前排序键（sortKey）小于或等于指定值时，才允许执行更新操作。 |
| `GTT` | `Float` | `-` | 设置更新条件：仅当当前排序键（sortKey）大于指定值时，才允许执行更新操作。 |
| `GTET` | `Float` | `-` | 设置更新条件：仅当当前排序键（sortKey）大于或等于指定值时，才允许执行更新操作。 |
| `EQT` | `Float` | `-` | 设置更新条件：仅当当前排序键（sortKey）等于指定值时，才允许执行更新操作。 |
| `NEQT` | `Float` | `-` | 设置更新条件：仅当当前排序键（sortKey）不等于指定值时，才允许执行更新操作。 |
| `EX` | `Int` | `-` | 设置键的生存时间（TTL），单位为秒。超过该时间后键将被自动删除。 |
| `PX` | `Int` | `-` | 设置键的生存时间（TTL），单位为毫秒。超过该时间后键将被自动删除。 |
| `EXAT` | `Int` | `-` | 设置键的绝对生存时间（TTL），单位为秒，表示一个 Unix 时间戳。超过该时间后键将被自动删除。 |
| `PXAT` | `Int` | `-` | 设置键的绝对生存时间（TTL），单位为毫秒，表示一个 Unix 时间戳。超过该时间后键将被自动删除。 |
| `KEEPTTL` | `Bool` | `-` | 设置是否保留键原有的生存时间（TTL）。设为 true 时，更新操作不会修改键的 TTL。 |

## 函数 (1)

### New

签名：`New() -> MemoryStoreSortedMapUpdateOptions`

构造一个新的 [MemoryStoreSortedMapUpdateOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapUpdateOptions.html) 实例，用于配置有序映射更新操作的条件与过期策略。

**返回值** [MemoryStoreSortedMapUpdateOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapUpdateOptions.html)

> 示例代码

> 构造 MemoryStoreSortedMapUpdateOptions 并设置比较条件

```lua
-- @runtime server
-- 构造一个更新选项实例，用于 MemoryStoreSortedMap:UpdateAsync 的 transform 回调
local opts = MemoryStoreSortedMapUpdateOptions.New()
-- 设置条件：仅当当前 sortKey 大于 100 时才允许更新
opts.GTT = 100
-- 设置 TTL 为 3600 秒（相对过期）
opts.EX = 3600
print("GTT:", opts.GTT, "EX:", opts.EX)
```
