# MemoryStoreHashMapSetOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[MemoryStoreHashMapSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapSetOptions.html) 用于配置 MemoryStoreHashMap:SetAsync 方法的可选行为，通过设置布尔条件、数值比较或生存时间等字段，精确控制键值对的写入策略。它支持存在性检查、值大小比较、累加操作以及键的过期管理，帮助开发者实现复杂的条件更新逻辑。

## 适用场景

在需要根据键是否存在、旧值大小或设置过期时间等条件来更新哈希表数据时，创建 [MemoryStoreHashMapSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapSetOptions.html) 实例并传入 SetAsync 方法，以实现原子化的条件写入。

## 使用要点

通过 MemoryStoreHashMapSetOptions.New() 或 [MemoryStoreHashMapSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapSetOptions.html)() 创建选项，设置所需字段后，作为第三个参数传入 MemoryStoreHashMap:SetAsync(key, value, options)。

## 注意事项

所有字段默认为 nil，表示不启用对应条件；仅当新旧值均为数值时，LT、GT、INCR 等比较和累加字段才有效；生存时间字段 EX、PX、EXAT、PXAT 和 KEEPTTL 用于控制键的过期行为，注意单位差异。

## 代码示例

### 创建仅在键不存在时写入的选项

```lua
-- @runtime server
local options = MemoryStoreHashMapSetOptions()
options.NX = true
options.EX = 60
print('条件写入选项:', options.NX, options.EX)
```

## 属性 (18)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `XX` | `Bool` | `-` | 设置此属性为 true 时，仅当指定的键已存在于 HashMap 中时，才会执行设置操作。 |
| `NX` | `Bool` | `-` | 设置此属性为 true 时，仅当指定的键不存在于 HashMap 中时，才会执行设置操作。 |
| `LT` | `Bool` | `-` | 设置此属性为 true 时，仅当新旧值均为数值且新值小于当前值时，才会执行更新操作。 |
| `LTE` | `Bool` | `-` | 设置此属性为 true 时，仅当新旧值均为数值且新值小于或等于当前值时，才会执行更新操作。 |
| `GT` | `Bool` | `-` | 设置此属性为 true 时，仅当新旧值均为数值且新值大于当前值时，才会执行更新操作。 |
| `GTE` | `Bool` | `-` | 设置此属性为 true 时，仅当新旧值均为数值且新值大于或等于当前值时，才会执行更新操作。 |
| `INCR` | `Bool` | `-` | 设置此属性为 true 时，新值将累加到当前值上，而不是覆盖。要求新旧值均为数值。 |
| `LTT` | `Float` | `-` | 设置此属性为指定数值后，仅当键的当前值小于该指定值时，才会执行更新操作。 |
| `LTET` | `Float` | `-` | 设置此属性为指定数值后，仅当键的当前值小于或等于该指定值时，才会执行更新操作。 |
| `GTT` | `Float` | `-` | 设置此属性为指定数值后，仅当键的当前值大于该指定值时，才会执行更新操作。 |
| `GTET` | `Float` | `-` | 设置此属性为指定数值后，仅当键的当前值大于或等于该指定值时，才会执行更新操作。 |
| `EQT` | `Any` | `-` | 设置此属性为指定值后，仅当键的当前值等于该指定值时，才会执行更新操作。 |
| `NEQT` | `Any` | `-` | 设置此属性为指定值后，仅当键的当前值不等于该指定值时，才会执行更新操作。 |
| `EX` | `Int` | `-` | 设置键的生存时间（TTL），单位为秒。超过该时间后键将自动过期。 |
| `PX` | `Int` | `-` | 设置键的生存时间（TTL），单位为毫秒。超过该时间后键将自动过期。 |
| `EXAT` | `Int` | `-` | 设置键的绝对过期时间，单位为秒（Unix 时间戳）。到达该时间后键将自动过期。 |
| `PXAT` | `Int` | `-` | 设置键的绝对过期时间，单位为毫秒（Unix 时间戳）。到达该时间后键将自动过期。 |
| `KEEPTTL` | `Bool` | `-` | 设置此属性为 true 时，将保留键现有的生存时间，不会重置或修改 TTL。 |

## 函数 (1)

### New

签名：`New() -> MemoryStoreHashMapSetOptions`

创建一个新的 [MemoryStoreHashMapSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapSetOptions.html) 实例，用于配置 HashMap 的 SetAsync 操作选项。

**返回值** [MemoryStoreHashMapSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapSetOptions.html)

> 示例代码

> 创建条件写入选项

```lua
-- @runtime server
local options = MemoryStoreHashMapSetOptions.New()
options.NX = true
options.EX = 60
print('选项已创建:', options.NX, options.EX)
```
