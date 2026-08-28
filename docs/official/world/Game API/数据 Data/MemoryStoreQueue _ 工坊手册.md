# MemoryStoreQueue

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[MemoryStoreQueue](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueue.html) 是支持整数优先级的临时消息队列，通过 AddAsync 写入任务、ReadAsync 批量读取并暂时隐藏任务，再用 RemoveAsync 确认删除已处理批次。

## 适用场景

用于跨服务器或同一服务器不同脚本之间的临时任务分发；需要按 priority 调整处理顺序时，在 AddAsync 中传入整数优先级。

## 使用要点

通过 MemoryStoreService:GetQueue 获取队列实例；AddAsync 写入任务，ReadAsync 返回 readId 和 items，处理完成后把 readId 传给 RemoveAsync。不要把它描述为不考虑 priority 的纯 FIFO 队列。

## 注意事项

[MemoryStoreQueue](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueue.html) 不可直接构造，必须通过 MemoryStoreService:GetQueue(name, queueInvisibleExpireSecs?) 获取。AddAsync/ReadAsync/RemoveAsync/RemoveByItemIdAsync/GetSizeAsync/DeleteAsync 是异步接口，应在 Task:Spawn 等协程环境中调用。AddAsync 的 priority 是整数优先级，常用 0 表示普通优先级；不要传枚举。ReadAsync 返回 readId 和 items 两个值，处理完 items 后用 readId 调用 RemoveAsync 批量删除已读取项。

## 代码示例

### 获取队列句柄

```lua
-- @runtime server
local MemoryStoreService = game:GetService('MemoryStoreService')
local queue = MemoryStoreService:GetQueue('match_queue', 30)
print('队列句柄:', queue)
```

## 函数 (6)

### AddAsync

签名：`AddAsync(value: Any, priority?: Int, options?: MemoryStoreQueueAddOptions) -> String (成功返回 itemId; 命中条件失败返回 nil)`

向队列中添加一个值，可指定优先级和附加选项。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `value` | `Any` | 队列项数据 |
| `priority?` | `Int` | 优先级, 默认 0 |
| `options?` | [MemoryStoreQueueAddOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueAddOptions.html) | 可选参数, 可通过 MemoryStoreQueueAddOptions.New(...) 或 [MemoryStoreQueueAddOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueAddOptions.html)(...) 创建 |

**返回值** `String` (成功返回 itemId; 命中条件失败返回 nil)

> 示例代码

> 添加队列任务

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local queue = MemoryStoreService:GetQueue('match_queue', 30)

    local options = MemoryStoreQueueAddOptions.New()
    options.EX = 120
    local itemId = queue:AddAsync({ kind = 'matchmaking' }, 0, options)
    print('入队 itemId:', itemId)
end)
```

### ReadAsync

签名：`ReadAsync(count: Int, options?: MemoryStoreQueueReadOptions) -> String, Array (依次返回本批 readId 与队列项数组；空队列超时时 readId 可为 nil。)`

从队列中读取指定数量的项，支持长轮询等待。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `count` | `Int` | 期望读取的项目数 |
| `options?` | [MemoryStoreQueueReadOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueReadOptions.html) | 可选参数, 可通过 MemoryStoreQueueReadOptions.New(...) 或 [MemoryStoreQueueReadOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueReadOptions.html)(...) 创建 |

**返回值** `String, Array` (依次返回本批 readId 与队列项数组；空队列超时时 readId 可为 nil。)

> 示例代码

> 读取队列任务

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local queue = MemoryStoreService:GetQueue('match_queue', 30)

    local options = MemoryStoreQueueReadOptions.New()
    options.WaitTimeout = 0
    local readId, items = queue:ReadAsync(1, options)
    for _, item in ipairs(items or {}) do
        print(item.ItemId, item.Value)
    end
    print('readId:', readId)
end)
```

### RemoveAsync

签名：`RemoveAsync(readId: String) -> void`

根据读取标识批量删除已读取的项。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `readId` | `String` | 批次读取标识 |

**返回值** `void`

> 示例代码

> 删除本批已读取任务

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local queue = MemoryStoreService:GetQueue('match_queue', 30)

    local options = MemoryStoreQueueReadOptions.New()
    options.WaitTimeout = 0
    local readId = queue:ReadAsync(1, options)
    if readId ~= nil then
        queue:RemoveAsync(readId)
    end
end)
```

### RemoveByItemIdAsync

签名：`RemoveByItemIdAsync(itemId: String) -> void`

根据项标识删除单个项。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `itemId` | `String` | 项 id |

**返回值** `void`

> 示例代码

> 按 itemId 删除队列项

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local queue = MemoryStoreService:GetQueue('match_queue', 30)

    local itemId = queue:AddAsync('ticket:1001', 0)
    queue:RemoveByItemIdAsync(itemId)
end)
```

### GetSizeAsync

签名：`GetSizeAsync(options?: MemoryStoreQueueGetSizeOptions) -> Int (队列大小)`

获取队列当前的大小。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `options?` | [MemoryStoreQueueGetSizeOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueGetSizeOptions.html) | 可选参数, 可通过 MemoryStoreQueueGetSizeOptions.New(...) 或 [MemoryStoreQueueGetSizeOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueGetSizeOptions.html)(...) 创建 |

**返回值** `Int` (队列大小)

> 示例代码

> 查询可见队列大小

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local queue = MemoryStoreService:GetQueue('match_queue', 30)

    local options = MemoryStoreQueueGetSizeOptions.New()
    options.ExcludeInvisible = true
    local size = queue:GetSizeAsync(options)
    print('可见队列项数量:', size)
end)
```

### DeleteAsync

签名：`DeleteAsync() -> void`

删除整个队列及其所有数据，操作不可逆。

**返回值** `void`

> 示例代码

> 清空队列

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local queue = MemoryStoreService:GetQueue('DocumentationSandboxQueue', 30)

    -- 仅对已确认可清理的文档沙盒队列执行整队列删除
    queue:DeleteAsync()
end)
```
