# MemoryStoreQueueReadOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[MemoryStoreQueueReadOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueReadOptions.html) 是 MemoryStoreQueue:ReadAsync 的读取配置，用于控制是否要求全部读取成功、空队列等待时间以及已读元素的不可见过期时间。

## 适用场景

当服务端消费临时队列任务时，使用该 options 可以快速返回空队列、等待新元素，或调整元素被读取后的不可见窗口。

## 使用要点

通过 MemoryStoreQueueReadOptions.New() 创建实例，设置 WaitTimeout、AllOrNothing 或 QueueInvisibleExpireSecs 后作为 ReadAsync 的第二个参数传入。

## 注意事项

所有字段均为可选，未设置时采用默认行为。WaitTimeout 设为 -1 表示无限等待。该对象仅作为配置参数使用，不持有队列资源。

## 代码示例

### 设置队列读取超时并读取元素

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local queue = MemoryStoreService:GetQueue('match_queue')

    queue:AddAsync('ticket:1001', 0)
    local options = MemoryStoreQueueReadOptions.New()
    options.WaitTimeout = 0
    options.QueueInvisibleExpireSecs = 30

    local readId, items = queue:ReadAsync(1, options)
    for _, item in ipairs(items or {}) do
        print(item.ItemId, item.Value)
    end
    print('readId:', readId)
end)
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `AllOrNothing` | `Bool` | `-` | 控制读取操作是否采用原子性：当设为 true 时，所有请求的项要么全部成功读取，要么全部失败；默认为 false。 |
| `WaitTimeout` | `Int` | `-` | 设置读取操作的等待超时时间（秒）。当队列为空时，读取操作将等待直到超时或新元素到达。 |
| `QueueInvisibleExpireSecs` | `Int` | `-` | 设置队列中不可见元素的过期时间（秒）。当元素被读取后进入不可见状态，若在此时间内未删除，将重新变为可见。 |

## 函数 (1)

### New

签名：`New() -> MemoryStoreQueueReadOptions`

创建一个新的 [MemoryStoreQueueReadOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueReadOptions.html) 实例，用于配置从 [MemoryStoreQueue](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueue.html) 读取数据时的行为选项。

**返回值** [MemoryStoreQueueReadOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueReadOptions.html)

> 示例代码

> 构造 MemoryStoreQueueReadOptions 并设置读取参数

```lua
-- @runtime server
-- 构造一个 MemoryStoreQueueReadOptions 实例，用于配置队列读取行为
local options = MemoryStoreQueueReadOptions.New()
-- 设置读取参数：要求一次性返回所有可见消息
options.AllOrNothing = true
-- 设置等待超时时间为 5 秒
options.WaitTimeout = 5
-- 设置消息不可见过期时间为 30 秒
options.QueueInvisibleExpireSecs = 30
-- 打印配置信息，验证参数已正确设置
print("AllOrNothing:", options.AllOrNothing)
print("WaitTimeout:", options.WaitTimeout)
print("QueueInvisibleExpireSecs:", options.QueueInvisibleExpireSecs)
```
