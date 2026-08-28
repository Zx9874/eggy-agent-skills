# MemoryStoreQueueAddOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[MemoryStoreQueueAddOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueAddOptions.html) 用于配置向内存存储队列添加数据时的可选行为，支持设置条目过期时间与存在性前置条件。通过设置 MSXX 或 MSNX 字段，可控制仅在队列存在或不存在时才执行添加操作；EX、PX、EXAT、PXAT 字段则允许以秒或毫秒为单位指定条目的生存时间。

## 适用场景

在调用 MemoryStoreQueue:AddAsync 时，若需要为添加的条目设置过期时间或添加存在性检查条件，可创建 [MemoryStoreQueueAddOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueAddOptions.html) 实例并传入。例如，在排行榜数据更新场景中，可设置 PX 字段让条目在指定毫秒后自动过期。

## 使用要点

通过 MemoryStoreQueueAddOptions.New() 或 [MemoryStoreQueueAddOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueAddOptions.html)() 创建配置对象，然后设置所需字段（如 MSXX、PX 等），最后将其作为参数传递给 MemoryStoreQueue:AddAsync 方法。

## 注意事项

该类型只作为 Queue:AddAsync 的配置参数使用。EX、PX、EXAT、PXAT 表示不同单位或形态的过期时间，一次写入只选择其中一种；所有字段默认 nil 时采用运行时默认行为。

## 代码示例

### 设置队列项过期时间

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local queue = MemoryStoreService:GetQueue('match_queue', 30)

    local options = MemoryStoreQueueAddOptions.New()
    options.EX = 120
    local itemId = queue:AddAsync('ticket:1001', 0, options)
    print('入队 itemId:', itemId)
end)
```

## 属性 (6)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `MSXX` | `Bool` | `-` | 仅当整个 MemoryStore 存在时才执行添加操作。 |
| `MSNX` | `Bool` | `-` | 仅当整个 MemoryStore 不存在时才执行添加操作。 |
| `EX` | `Int` | `-` | 以秒为单位的生存时间（TTL），用于设置添加的数据项在队列中的存活时长。 |
| `PX` | `Int` | `-` | 以毫秒为单位的生存时间（TTL），用于设置添加的数据项在队列中的存活时长。 |
| `EXAT` | `Int` | `-` | 以秒为单位的绝对生存时间（Unix 时间戳），用于设置数据项在指定时刻过期。 |
| `PXAT` | `Int` | `-` | 以毫秒为单位的绝对生存时间（Unix 时间戳），用于设置数据项在指定时刻过期。 |

## 函数 (1)

### New

签名：`New() -> MemoryStoreQueueAddOptions`

创建一个新的 [MemoryStoreQueueAddOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueAddOptions.html) 实例，用于配置向 [MemoryStoreQueue](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueue.html) 添加数据时的选项。

**返回值** [MemoryStoreQueueAddOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueAddOptions.html)

> 示例代码

> 构造队列写入选项

```lua
-- @runtime server
local options = MemoryStoreQueueAddOptions.New()
options.EX = 120  -- 秒；EX 与 PX/EXAT/PXAT 只选一种
print('队列项存活秒数:', options.EX)
```
