# DataStoreService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `server` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[DataStoreService]**（5 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

数据存储服务，提供玩家存档与持久化数据的存取能力。通过该服务可创建普通数据存储、全局数据存储和有序数据存储，并支持列出所有数据存储的元信息。所有数据读写操作均为异步，建议按异步调用方式在合适的协程上下文中使用。

## 适用场景

在服务端脚本中，通过 game:GetService("DataStoreService") 获取服务实例，然后使用 GetDataStore 创建玩家数据存储，用于保存和读取玩家的金币、胜场等持久化数据。

## 使用要点

先调用 game:GetService("DataStoreService") 获取服务，再通过 GetDataStore 传入名称和可选作用域创建 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 对象。之后在协程中使用 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 的 GetAsync 和 SetAsync 进行数据读写。

## 注意事项

[DataStoreService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/DataStoreService.html) 仅服务端可用。所有 Async 后缀方法（ListDataStoresAsync/ListOrderedDataStoresAsync）及返回的 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html)/[OrderedDataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStore.html) 的读写方法（GetAsync/SetAsync/IncrementAsync/UpdateAsync）都是异步方法，必须在协程（Task:Spawn 或 coroutine.wrap）中调用，禁止裸调用。GetDataStore/GetGlobalDataStore/GetOrderedDataStore 本身是同步的（只返回句柄），但返回对象上的操作是异步的。

## 代码示例

### 在任务协程中读取玩家数据

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Players = game:GetService('Players')
local Task = game:GetService('Task')
local player = Players:GetPlayers()[1]
if player == nil then return end

local playerStore = DataStoreService:GetDataStore('PlayerData', 'global')
Task:Spawn(function()
    local value = playerStore:GetAsync(tostring(player.UserId))
    print('读取到的玩家数据:', value)
end)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (5)

### GetDataStore

签名：`GetDataStore(name: String, scope?: String, options?: DataStoreOptions) -> DataStore (数据存储集合)`

获取一个普通数据存储集合，用于存储键值对数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 集合名称 |
| `scope?` | `String` | 前置域, 默认 global |
| `options?` | [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html) | 获取[DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html)的额外选项, 可通过 DataStoreOptions.New() 创建 |

**返回值** [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) (数据存储集合)

> 示例代码

> 获取普通数据存储集合并验证句柄

```lua
-- @runtime server
-- 获取 DataStoreService 服务实例
local dataStoreService = game:GetService("DataStoreService")

local options = DataStoreOptions.New()
options.AllScopes = false  -- 不跨作用域

-- 获取名为 "PlayerScores" 的普通数据存储集合
local dataStore = dataStoreService:GetDataStore("PlayerScores", "public", options)

-- 验证返回的句柄非空
if dataStore then
    print("成功获取 DataStore 句柄")
else
    print("获取 DataStore 句柄失败")
end
```

### GetGlobalDataStore

签名：`GetGlobalDataStore(options?: DataStoreOptions) -> DataStore (全局数据存储集合)`

获取全局数据存储集合，等价于调用 GetDataStore 并指定名称为空字符串、作用域为 "global"。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `options?` | [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html) | 获取[DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html)的额外选项, 可通过 DataStoreOptions.New() 创建 |

**返回值** [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) (全局数据存储集合)

> 示例代码

> 获取全局数据存储集合并验证句柄

```lua
-- @runtime server
-- 获取 DataStoreService 服务实例
local dataStoreService = game:GetService("DataStoreService")

local options = DataStoreOptions.New()
options.AllScopes = true  -- 允许跨作用域访问

-- 获取全局数据存储集合（等价于 GetDataStore("", "global", options)）
local globalStore = dataStoreService:GetGlobalDataStore(options)

-- 验证返回的句柄非空
if globalStore then
    print("成功获取全局 DataStore 句柄")
else
    print("获取全局 DataStore 句柄失败")
end
```

### GetOrderedDataStore

签名：`GetOrderedDataStore(name: String, scope?: String, options?: DataStoreOptions) -> OrderedDataStore (有序数据存储集合)`

获取一个有序数据存储集合，其中的键值对按数值排序，适用于排行榜等场景。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 集合名称 |
| `scope?` | `String` | 前置域, 默认 global |
| `options?` | [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html) | 获取[DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html)的额外选项, 可通过 DataStoreOptions.New() 创建 |

**返回值** [OrderedDataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStore.html) (有序数据存储集合)

> 示例代码

> 获取有序数据存储集合并验证句柄

```lua
-- @runtime server
-- 获取 DataStoreService 服务实例
local dataStoreService = game:GetService("DataStoreService")

local options = DataStoreOptions.New()
options.AllScopes = false  -- 不跨作用域

-- 获取名为 "Leaderboard" 的有序数据存储集合
local orderedStore = dataStoreService:GetOrderedDataStore("Leaderboard", "global", options)

-- 验证返回的句柄非空
if orderedStore then
    print("成功获取 OrderedDataStore 句柄")
else
    print("获取 OrderedDataStore 句柄失败")
end
```

### ListDataStoresAsync

签名：`ListDataStoresAsync(prefix?: String, pageSize?: Int, cursor?: String, options?: DataStoreListOptions) -> DataStoreInfoPages (分页迭代器)`

分页列出所有普通 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 集合，返回一个分页迭代器。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefix?` | `String` | 名称前缀过滤, 默认空字符串 |
| `pageSize?` | `Int` | 页大小, 默认 0 (使用服务端默认值) |
| `cursor?` | `String` | 分页游标 |
| `options?` | [DataStoreListOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListOptions.html) | 可选参数, 可通过 DataStoreListOptions.New() 创建 |

**返回值** [DataStoreInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreInfoPages.html) (分页迭代器)

> 示例代码

> 协程中分页列出普通 DataStore 集合

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local listOptions = DataStoreListOptions.New()
-- ListDataStoresAsync 是异步方法，必须在协程中调用
Task:Spawn(function()
    local pages = DataStoreService:ListDataStoresAsync('', 10, '', listOptions)
    local currentPage = pages:GetCurrentPage()
    print('当前页 DataStore 数量:', #currentPage)
end)
```

### ListOrderedDataStoresAsync

签名：`ListOrderedDataStoresAsync(prefix?: String, pageSize?: Int, cursor?: String, options?: DataStoreListOptions) -> DataStoreInfoPages (分页迭代器)`

分页列出所有有序 [OrderedDataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStore.html) 集合，返回一个分页迭代器。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefix?` | `String` | 名称前缀过滤, 默认空字符串 |
| `pageSize?` | `Int` | 页大小, 默认 0 (使用服务端默认值) |
| `cursor?` | `String` | 分页游标 |
| `options?` | [DataStoreListOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListOptions.html) | 可选参数, 可通过 DataStoreListOptions.New() 创建 |

**返回值** [DataStoreInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreInfoPages.html) (分页迭代器)

> 示例代码

> 协程中分页列出有序 OrderedDataStore 集合

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local listOptions = DataStoreListOptions.New()
Task:Spawn(function()
    local pages = DataStoreService:ListOrderedDataStoresAsync('', 10, '', listOptions)
    local currentPage = pages:GetCurrentPage()
    print('当前页 OrderedDataStore 数量:', #currentPage)
end)
```
