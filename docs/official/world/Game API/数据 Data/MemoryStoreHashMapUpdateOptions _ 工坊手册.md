# MemoryStoreHashMapUpdateOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[MemoryStoreHashMapUpdateOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapUpdateOptions.html) 用于配置 MemoryStoreHashMap:UpdateAsync 的原子更新条件，支持基于旧值的阈值比较和键的生存时间控制。通过设置 LTT、GTET、EQT 等字段，可确保仅在满足指定条件时才执行更新，避免并发冲突。

## 适用场景

在需要原子更新哈希表键值对时，通过 transform 函数返回该配置对象，以指定更新必须满足的前置条件，例如仅当旧值大于某个阈值时才更新。

## 使用要点

通过 MemoryStoreHashMapUpdateOptions.New() 或 [MemoryStoreHashMapUpdateOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapUpdateOptions.html)() 创建实例，设置所需的条件字段（如 LTT、GTET）和 TTL 字段（如 EX、KEEPTTL），然后在 MemoryStoreHashMap:UpdateAsync 的 transform 回调中返回该对象。

## 注意事项

该类型仅用于 UpdateAsync 的 transform 返回值，不可单独使用。条件字段均为可选，若未设置则不做阈值检查。TTL 字段与条件字段可同时使用，但需确保原子性语义正确。

## 代码示例

### 创建条件更新选项

```lua
-- @runtime server
local options = MemoryStoreHashMapUpdateOptions.New()
options.GTT = 5
options.EX = 60
print('条件更新选项:', options.GTT, options.EX)
```

## 属性 (11)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `LTT` | `Float` | `-` | 设置一个数值，仅当键的当前值小于该值时，更新操作才会执行。 |
| `LTET` | `Float` | `-` | 设置一个数值，仅当键的当前值小于或等于该值时，更新操作才会执行。 |
| `GTT` | `Float` | `-` | 设置一个数值，仅当键的当前值大于该值时，更新操作才会执行。 |
| `GTET` | `Float` | `-` | 设置一个数值，仅当键的当前值大于或等于该值时，更新操作才会执行。 |
| `EQT` | `Any` | `-` | 设置一个值，仅当键的当前值等于该值时，更新操作才会执行。 |
| `NEQT` | `Any` | `-` | 设置一个值，仅当键的当前值不等于该值时，更新操作才会执行。 |
| `EX` | `Int` | `-` | 设置键的生存时间（秒），从更新操作成功时开始计算。 |
| `PX` | `Int` | `-` | 设置键的生存时间（毫秒），从更新操作成功时开始计算。 |
| `EXAT` | `Int` | `-` | 设置键的绝对生存时间（秒），使用 Unix 时间戳指定过期时刻。 |
| `PXAT` | `Int` | `-` | 设置键的绝对生存时间（毫秒），使用 Unix 时间戳指定过期时刻。 |
| `KEEPTTL` | `Bool` | `-` | 设置为 true 时，更新操作将保留键原有的生存时间，不重置 TTL。 |

## 函数 (1)

### New

签名：`New() -> MemoryStoreHashMapUpdateOptions`

创建一个新的 [MemoryStoreHashMapUpdateOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapUpdateOptions.html) 实例，用于配置 HashMap 更新操作的条件选项。

**返回值** [MemoryStoreHashMapUpdateOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapUpdateOptions.html)

> 示例代码

> 构造 MemoryStoreHashMapUpdateOptions 并设置阈值与 TTL

```lua
-- @runtime server
-- 构造一个 MemoryStoreHashMapUpdateOptions 实例
local opts = MemoryStoreHashMapUpdateOptions.New()
-- 设置数值比较阈值：仅当当前值大于 100 时才允许更新
opts.GTT = 100
-- 设置新的过期时间（毫秒）
opts.PX = 60000
-- 打印配置信息
print("GTT threshold:", opts.GTT)
print("PX TTL:", opts.PX)
```
