# SortDirection

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `server` |

* **Inherit**: `Int`
* **继承链**: `Int` → SortDirection

[SortDirection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/SortDirection.html) 枚举定义 [MemoryStoreSortedMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMap.html) 范围查询的排序方向，Ascending 表示按排序键升序返回，Descending 表示按排序键降序返回。

## 适用场景

调用 MemoryStoreSortedMap:GetRangeAsync(direction, count, options) 获取排序映射分页结果时，使用该枚举控制返回顺序。

## 使用要点

通过 Enums.SortDirection.Ascending 或 Enums.SortDirection.Descending 作为 GetRangeAsync 的第一个参数，例如 sortedMap:GetRangeAsync(Enums.SortDirection.Descending, 10, options)。

## 注意事项

GetRangeAsync 的公开签名是 direction、count、options；上下界等过滤条件放在 [MemoryStoreSortedMapGetRangeOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapGetRangeOptions.html) 中，不要把 lowerBound、upperBound 当作额外位置参数传入。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `1` | `Ascending` | 升序 (ASC) |
| `-1` | `Descending` | 降序 (DESC) |
