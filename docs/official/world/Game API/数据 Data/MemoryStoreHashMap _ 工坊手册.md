# MemoryStoreHashMap

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[MemoryStoreHashMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMap.html) 是内存级键值存储的哈希集合，提供快速的异步读写能力。它支持对单个键进行设置、获取、更新和删除操作，并能列出所有存储项或清空整个集合。

## 适用场景

常用于需要在服务器端快速存取临时数据的场景，例如记录玩家会话状态、缓存跨请求的中间结果，或实现轻量级的排行榜和计数器。

## 使用要点

通过 MemoryStoreService:GetHashMap("名称") 获取实例，然后调用 SetAsync 写入键值对，或使用 GetAsync 读取指定键的值。更新已有键时可用 UpdateAsync 传入变换函数，批量遍历则调用 ListItemsAsync 获取分页对象。

## 注意事项

[MemoryStoreHashMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMap.html) 不可直接构造，必须通过 MemoryStoreService:GetHashMap(name) 获取。SetAsync/GetAsync/RemoveAsync/UpdateAsync/ListItemsAsync/DeleteAsync 是异步接口，应在 Task:Spawn 等协程环境中调用。key 是业务字符串键名，不是 Enums.\* 枚举值；UpdateAsync 的 transformFunction 应返回新值，返回 nil 表示取消或删除语义，示例中不要用空函数。

## 代码示例

### 获取 HashMap 并写入读取键值

```lua
-- @runtime server
local MemoryStoreService = game:GetService('MemoryStoreService')
local Task = game:GetService('Task')
local hashMap = MemoryStoreService:GetHashMap('match_state')

Task:Spawn(function()
    local key = 'room:1001'
    local options = MemoryStoreHashMapSetOptions.New()
    hashMap:SetAsync(key, { state = 'waiting' }, options)
    local value = hashMap:GetAsync(key)
    if value ~= nil then
        print('房间状态:', value.state)
    end
end)
```

## 函数 (6)

### SetAsync

签名：`SetAsync(key: String, value: Any, options?: MemoryStoreHashMapSetOptions) -> Any (成功返回写入的 value 或 INCR 累加后的值; 命中条件失败返回 nil)`

异步设置指定 key 的值，可附带条件选项。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `value` | `Any` | 数据值 (INCR 模式下需为数字) |
| `options?` | [MemoryStoreHashMapSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapSetOptions.html) | 可选参数, 可通过 MemoryStoreHashMapSetOptions.New(...) 或 [MemoryStoreHashMapSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapSetOptions.html)(...) 创建 |

**返回值** `Any` (成功返回写入的 value 或 INCR 累加后的值; 命中条件失败返回 nil)

> 示例代码

> 写入 HashMap 键值

```lua
-- @runtime server
local MemoryStoreService = game:GetService('MemoryStoreService')
local Task = game:GetService('Task')
local hashMap = MemoryStoreService:GetHashMap('match_state')

Task:Spawn(function()
    local key = 'room:1001'
    local options = MemoryStoreHashMapSetOptions.New()
    local result = hashMap:SetAsync(key, { state = 'waiting' }, options)
    print('写入结果:', result)
end)
```

### GetAsync

签名：`GetAsync(key: String) -> Any (键不存在时返回 nil)`

异步获取指定 key 对应的值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |

**返回值** `Any` (键不存在时返回 nil)

> 示例代码

> 读取 HashMap 键值

```lua
-- @runtime server
local MemoryStoreService = game:GetService('MemoryStoreService')
local Task = game:GetService('Task')
local hashMap = MemoryStoreService:GetHashMap('match_state')

Task:Spawn(function()
    local value = hashMap:GetAsync('room:1001')
    print('房间状态:', value)
end)
```

### RemoveAsync

签名：`RemoveAsync(key: String) -> void`

异步删除指定 key 及其对应的值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |

**返回值** `void`

> 示例代码

> 删除 HashMap 键

```lua
-- @runtime server
local MemoryStoreService = game:GetService('MemoryStoreService')
local Task = game:GetService('Task')
local hashMap = MemoryStoreService:GetHashMap('match_state')

Task:Spawn(function()
    hashMap:RemoveAsync('room:1001')
end)
```

### ListItemsAsync

签名：`ListItemsAsync(count: Int) -> MemoryStoreHashMapPages (分页迭代器)`

分页列出 HashMap 中的所有键值对。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `count` | `Int` | 每页数量 |

**返回值** [MemoryStoreHashMapPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapPages.html) (分页迭代器)

> 示例代码

> 分页列出 HashMap 条目

```lua
-- @runtime server
local MemoryStoreService = game:GetService('MemoryStoreService')
local Task = game:GetService('Task')
local hashMap = MemoryStoreService:GetHashMap('match_state')

Task:Spawn(function()
    local pages = hashMap:ListItemsAsync(20)
    while true do
        for _, item in ipairs(pages:GetCurrentPage()) do
            print(item.Key, item.Value)
        end
        if pages.IsFinished then break end
        if not pages:AdvanceToNextPageAsync() then break end
    end
end)
```

### DeleteAsync

签名：`DeleteAsync() -> void`

删除整个 [MemoryStoreHashMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMap.html) 集合及其所有数据。

**返回值** `void`

> 示例代码

> 删除整个 HashMap

```lua
-- @runtime server
local MemoryStoreService = game:GetService('MemoryStoreService')
local Task = game:GetService('Task')
local hashMap = MemoryStoreService:GetHashMap('DocumentationSandboxHashMap')

Task:Spawn(function()
    -- 仅对已确认可清理的文档沙盒集合执行整表删除
    hashMap:DeleteAsync()
end)
```

### UpdateAsync

签名：`UpdateAsync(key: String, transformFunction: Function) -> Any (更新后的值; transform 返回 nil 时为 nil)`

原子更新操作：先读取当前值，通过 transform 函数计算新值后写回，最多重试 5 次。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `transformFunction` | `Function` | 变换函数 (oldValue) → newValue, options? |

**返回值** `Any` (更新后的值; transform 返回 nil 时为 nil)

> 示例代码

> 原子更新 HashMap 值

```lua
-- @runtime server
local MemoryStoreService = game:GetService('MemoryStoreService')
local Task = game:GetService('Task')
local hashMap = MemoryStoreService:GetHashMap('match_counter')

Task:Spawn(function()
    local newValue = hashMap:UpdateAsync('room:1001', function(oldValue)
        return (oldValue or 0) + 1
    end)
    print('更新后计数:', newValue)
end)
```
