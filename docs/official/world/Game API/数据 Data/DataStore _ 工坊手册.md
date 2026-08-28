# DataStore

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

### 继承关系

* **[DataStore]**（10 函数）
  + [OrderedDataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStore.html)（1 函数）

数据存储集合，用于持久化保存玩家或地图的键值数据。支持异步读写、递增、更新、版本管理以及键列表查询，所有操作需在协程环境中调用。

## 适用场景

在服务端保存玩家进度、排行榜分数或地图状态时，通过 [DataStoreService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/DataStoreService.html) 获取 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 实例，然后调用 GetAsync 读取数据或 SetAsync 写入数据。

## 使用要点

先通过 DataStoreService:GetDataStore('名称') 获取实例，然后在 Task:Spawn 内调用 GetAsync('键') 读取数据，或调用 SetAsync('键', 值) 写入数据。需要递增数值时可使用 IncrementAsync，需要原子更新时可使用 UpdateAsync。

## 注意事项

[DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 不可直接构造，必须由 DataStoreService:GetDataStore() / GetGlobalDataStore() / GetOrderedDataStore() 返回。所有读写操作是异步的，必须在协程环境（如 Task:Spawn）中调用。GetAsync/SetAsync/IncrementAsync/UpdateAsync 在 options.WithKeyInfo=true 时额外返回 [DataStoreKeyInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreKeyInfo.html)；不设置时返回数据本身。写入有频率限制，建议在关键变更点调用。

## 代码示例

### 数据示例

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local dataStore = DataStoreService:GetDataStore('StoreName')
local key = "attack"  -- String
local options = DataStoreGetOptions.New()
local result = dataStore:GetAsync(key, options)  -- 返回 Any
if result ~= nil then
    print("调用成功，结果: " .. tostring(result))
end
```

## 函数 (10)

### GetAsync

签名：`GetAsync(key: String, options?: DataStoreGetOptions) -> Any (数据值, key 不存在时返回 nil)`

从数据存储中异步获取指定 key 对应的数据值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `options?` | [DataStoreGetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetOptions.html) | 可选参数, 优先级高于 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 初始化时的 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html), 可通过 DataStoreGetOptions.New() 创建 |

**返回值** `Any` (数据值, key 不存在时返回 nil)

> 示例代码

> 读取玩家数据

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local store = DataStoreService:GetDataStore('PlayerBackpack')
local playerId = 'demo-player'
Task:Spawn(function()
    local data = store:GetAsync('player_' .. playerId)  -- 必须传 key
    print('读取到:', data)
end)
```

### SetAsync

签名：`SetAsync(key: String, value: Any, options?: DataStoreSetOptions) -> String (版本号)`

异步设置指定 key 的数据值，并返回新版本号。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `value` | `Any` | 数据值 |
| `options?` | [DataStoreSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreSetOptions.html) | 可选参数, 优先级高于 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 初始化时的 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html), 可通过 DataStoreSetOptions.New() 创建 |

**返回值** `String` (版本号)

> 示例代码

> 写入玩家数据

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local store = DataStoreService:GetDataStore('PlayerBackpack')
local playerId = 'demo-player'
Task:Spawn(function()
    store:SetAsync('player_' .. playerId, {coins=100, level=1})
end)
```

### IncrementAsync

签名：`IncrementAsync(key: String, delta: Int, options?: DataStoreIncrementOptions) -> Any (自增后的值)`

对指定 key 的数值进行原子自增操作，并返回自增后的值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `delta` | `Int` | 自增值 (非零) |
| `options?` | [DataStoreIncrementOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreIncrementOptions.html) | 可选参数, 优先级高于 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 初始化时的 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html), 可通过 DataStoreIncrementOptions.New() 创建 |

**返回值** `Any` (自增后的值)

> 示例代码

> 原子自增计数

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local store = DataStoreService:GetDataStore('PlayerBackpack')
Task:Spawn(function()
    store:IncrementAsync('login_count', 1)  -- delta 必须非零
end)
```

### RemoveAsync

签名：`RemoveAsync(key: String, options?: DataStoreRemoveOptions) -> Any (删除前的数据值, key 不存在时返回 nil)`

异步删除指定 key 及其数据，返回删除前的数据值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `options?` | [DataStoreRemoveOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreRemoveOptions.html) | 可选参数, 优先级高于 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 初始化时的 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html), 可通过 DataStoreRemoveOptions.New() 创建 |

**返回值** `Any` (删除前的数据值, key 不存在时返回 nil)

> 示例代码

> 删除玩家数据

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local store = DataStoreService:GetDataStore('PlayerBackpack')
local options = DataStoreRemoveOptions.New()
options.WithKeyInfo = true

Task:Spawn(function()
    local removedValue, keyInfo = store:RemoveAsync('player_demo', options)
    print('删除值:', removedValue, '版本:', keyInfo and keyInfo.Version)
end)
```

### UpdateAsync

签名：`UpdateAsync(key: String, transformFunction: Function) -> Any (更新后的值, 放弃更新时返回 nil)`

执行先读后写的复合更新操作，通过回调函数安全地修改数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `transformFunction` | `Function` | 变换函数 function(currentValue, keyInfo) -> newValue, [DataStoreSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreSetOptions.html)?; 返回 newValue=nil 时放弃更新; 可返回 [DataStoreSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreSetOptions.html) 自定义写入选项 (如 metas, userIds); 每轮重试都会重新调用 transformFunction 拿到最新值 |

**返回值** `Any` (更新后的值, 放弃更新时返回 nil)

> 示例代码

> 读-改-写原子更新

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local store = DataStoreService:GetDataStore('PlayerBackpack')
local playerId = 'demo-player'
Task:Spawn(function()
    store:UpdateAsync('player_' .. playerId, function(oldValue, keyInfo)
        oldValue = oldValue or {coins=0}
        oldValue.coins = oldValue.coins + 50
        return oldValue  -- 返回 nil 放弃更新
    end)
end)
```

### ListKeysAsync

签名：`ListKeysAsync(prefix?: String, pageSize?: Int, cursor?: String, options?: DataStoreListKeyOptions) -> DataStoreKeyBriefInfoPages (分页迭代器)`

分页列出数据存储中的 key，支持按前缀过滤。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefix?` | `String` | 前缀过滤, 默认空字符串 |
| `pageSize?` | `Int` | 页大小, 默认 0 (使用服务端默认值) |
| `cursor?` | `String` | 分页游标 |
| `options?` | [DataStoreListKeyOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListKeyOptions.html) | 可选参数, 优先级高于 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 初始化时的 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html), 可通过 DataStoreListKeyOptions.New() 创建 |

**返回值** [DataStoreKeyBriefInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreKeyBriefInfoPages.html) (分页迭代器)

> 示例代码

> 分页列出键名

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local store = DataStoreService:GetDataStore('PlayerBackpack')
local options = DataStoreListKeyOptions.New()
options.ExcludeDeleted = false

Task:Spawn(function()
    local pages = store:ListKeysAsync('player_', 10, '', options)
    for _, keyInfo in ipairs(pages:GetCurrentPage()) do
        print('键名:', keyInfo.Key)
    end
end)
```

### GetVersionAsync

签名：`GetVersionAsync(key: String, version: String, options?: DataStoreGetVersionOptions) -> Any (数据值, 版本或 key 不存在时返回 nil)`

按版本号读取指定 key 的历史版本；options 可省略，也可通过 DataStoreGetVersionOptions.New() 创建。

⚙ [DataStoreGetVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetVersionOptions.html) 支持 .New()，但不支持类型名直接调用简写。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `version` | `String` | 版本号 |
| `options?` | [DataStoreGetVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetVersionOptions.html) | 可选参数；可通过 DataStoreGetVersionOptions.New() 创建，需要 KeyInfo 时设置 WithKeyInfo=true。 |

**返回值** `Any` (数据值, 版本或 key 不存在时返回 nil)

> 示例代码

> 按版本号读取历史数据

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local store = DataStoreService:GetDataStore('PlayerBackpack')
local key = 'player_demo'
Task:Spawn(function()
    local pages = store:ListVersionsAsync(key, false, 0, 0, 10)
    local versionInfo = pages:GetCurrentPage()[1]
    if versionInfo == nil then
        print('当前键没有可读取的历史版本')
        return
    end
    local value = store:GetVersionAsync(key, versionInfo.Version)
    print('历史版本数据:', value)
end)
```

### GetVersionAtTimeAsync

签名：`GetVersionAtTimeAsync(key: String, timestamp: Int, options?: DataStoreGetVersionOptions) -> Any (数据值, 该时间点无对应版本时返回 nil)`

按时间点读取指定 key 在该时间附近的历史版本；options 可省略，也可通过 DataStoreGetVersionOptions.New() 创建。

⚙ [DataStoreGetVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetVersionOptions.html) 支持 .New()，但不支持类型名直接调用简写。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `timestamp` | `Int` | 时间戳 (毫秒) |
| `options?` | [DataStoreGetVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetVersionOptions.html) | 可选参数；可通过 DataStoreGetVersionOptions.New() 创建，需要 KeyInfo 时设置 WithKeyInfo=true。 |

**返回值** `Any` (数据值, 该时间点无对应版本时返回 nil)

> 示例代码

> 按时间点读取历史数据

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local store = DataStoreService:GetDataStore('PlayerBackpack')
local key = 'player_demo'
local timestamp = 1700000000 * 1000
Task:Spawn(function()
    local value = store:GetVersionAtTimeAsync(key, timestamp)
    print('指定时间附近的数据:', value)
end)
```

### ListVersionsAsync

签名：`ListVersionsAsync(key: String, ascending?: Bool, minDate?: Int, maxDate?: Int, pageSize?: Int) -> DataStoreVersionInfoPages (分页迭代器)`

列出指定 key 的所有历史版本信息。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `ascending?` | `Bool` | 排序方向, true 时按版本更新时间升序, false 时降序 |
| `minDate?` | `Int` | 最小时间 (毫秒) |
| `maxDate?` | `Int` | 最大时间 (毫秒) |
| `pageSize?` | `Int` | 页大小, 默认 0 (使用服务端默认值) |

**返回值** [DataStoreVersionInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreVersionInfoPages.html) (分页迭代器)

> 示例代码

> 列出指定键的历史版本

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local store = DataStoreService:GetDataStore('PlayerBackpack')

Task:Spawn(function()
    local pages = store:ListVersionsAsync('player_demo', false, 0, 0, 10)
    for _, versionInfo in ipairs(pages:GetCurrentPage()) do
        print('版本:', versionInfo.Version, '创建时间:', versionInfo.CreatedTime)
    end
end)
```

### RemoveVersionAsync

签名：`RemoveVersionAsync(key: String, version: String, options?: DataStoreRemoveVersionOptions) -> Any (删除前的数据值, 版本不存在时返回 nil)`

删除指定 key 的历史版本；options 可省略，也可通过 DataStoreRemoveVersionOptions.New() 创建。

⚙ [DataStoreRemoveVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreRemoveVersionOptions.html) 支持 .New()，但不支持类型名直接调用简写。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `version` | `String` | 版本号 |
| `options?` | [DataStoreRemoveVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreRemoveVersionOptions.html) | 可选参数；可通过 DataStoreRemoveVersionOptions.New() 创建，需要 KeyInfo 时设置 WithKeyInfo=true。 |

**返回值** `Any` (删除前的数据值, 版本不存在时返回 nil)

> 示例代码

> 删除指定历史版本

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local store = DataStoreService:GetDataStore('DocumentationSandbox')
local key = 'cleanup_demo'
Task:Spawn(function()
    local pages = store:ListVersionsAsync(key, false, 0, 0, 10)
    local versionInfo = pages:GetCurrentPage()[1]
    if versionInfo == nil then
        print('当前键没有可删除的历史版本')
        return
    end
    -- 仅在确认该沙盒版本可以删除后执行
    local removedValue = store:RemoveVersionAsync(key, versionInfo.Version)
    print('删除的版本数据:', removedValue)
end)
```
