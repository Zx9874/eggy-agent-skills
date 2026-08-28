# DataStoreService

DataStoreService 数据存储服务，提供数据持久化的读写、版本管理和排序查询能力。

## Overview

DataStoreService 数据存储服务，提供键值数据的持久化读写、版本管理和排序查询等能力。通过 `editor:GetService("DataStoreService")` 获取，DataStore 数据集合由本服务的 GetDataStore / GetGlobalDataStore / GetOrderedDataStore 获取。

**Get by:**

```lua
local service = editor:GetService("DataStoreService")
```

## Public

### GetDataStore

获取普通数据存储集合（DataStore）。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 数据存储名称 |
| `scope` | `String` | 作用域（可选） |
| `options` | `DataStoreOptions` | 存储选项（可选） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `DataStore` | 数据存储集合对象，用于键值读写 |

**示例**

```lua
local service = editor:GetService("DataStoreService")

local ds = service:GetDataStore("my_store") -- 获取普通数据存储
local version = ds:SetAsync("demo_key", 100) -- 写入数据
print("写入版本:", version)
print("读回值:", ds:GetAsync("demo_key"))

ds:RemoveAsync("demo_key") -- 清理 key
print("清理后:", ds:GetAsync("demo_key"))
```

### GetGlobalDataStore

获取全局数据存储集合（GlobalDataStore），等价于 GetDataStore("", "global", options)。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `options` | `DataStoreOptions` | 存储选项（可选） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `DataStore` | 全局数据存储集合对象 |

**示例**

```lua
local service = editor:GetService("DataStoreService")

local gds = service:GetGlobalDataStore() -- 获取全局数据存储
local version = gds:SetAsync("global_config", { level = 1 }) -- 写入配置
print("写入版本:", version)
local value = gds:GetAsync("global_config")
print("读回值:", value and value.level or "nil")

gds:RemoveAsync("global_config") -- 清理 key
print("清理后:", gds:GetAsync("global_config"))
```

### GetOrderedDataStore

获取有序数据存储集合（OrderedDataStore），支持按 value 排序查询。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 有序数据存储名称 |
| `scope` | `String` | 作用域（可选） |
| `options` | `DataStoreOptions` | 存储选项（可选） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `OrderedDataStore` | 有序数据存储集合对象，支持按值排序 |

**示例**

```lua
local service = editor:GetService("DataStoreService")

local ods = service:GetOrderedDataStore("my_rank") -- 获取有序数据存储
print("player_1 分数:", ods:IncrementAsync("player_1", 10))
print("player_2 分数:", ods:IncrementAsync("player_2", 30))

local pages = ods:GetSortedAsync(true) -- 按 value 升序读回
for _, kv in ipairs(pages:GetCurrentPage()) do
    print("排名项:", kv.Key, kv.Value)
end
```

### ListDataStoresAsync

分页列出当前存档的所有普通 DataStore 集合。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefix` | `String` | 名称前缀过滤（可选） |
| `pageSize` | `Int` | 每页数量（可选） |
| `cursor` | `String` | 分页游标（可选） |
| `options` | `DataStoreListOptions` | 分页选项（可选） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `DataStoreInfoPages` | 数据存储信息的分页迭代器 |

**示例**

```lua
local service = editor:GetService("DataStoreService")

service:GetDataStore("my_store") -- 确保存在普通集合
local pages = service:ListDataStoresAsync() -- 分页列出全部集合
local page = pages:GetCurrentPage() -- 取第一页
print("第一页集合数量:", #page)
for _, info in ipairs(page) do
    print("集合:", info.DataStoreName, "键数量:", info.KeyCount)
end
```

### ListOrderedDataStoresAsync

分页列出当前存档的所有有序 OrderedDataStore 集合。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefix` | `String` | 名称前缀过滤（可选） |
| `pageSize` | `Int` | 每页数量（可选） |
| `cursor` | `String` | 分页游标（可选） |
| `options` | `DataStoreListOptions` | 分页选项（可选） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `DataStoreInfoPages` | 有序数据存储信息的分页迭代器 |

**示例**

```lua
local service = editor:GetService("DataStoreService")

service:GetOrderedDataStore("my_rank") -- 确保存在有序集合
local pages = service:ListOrderedDataStoresAsync() -- 分页列出全部集合
local page = pages:GetCurrentPage() -- 取第一页
print("第一页有序集合数量:", #page)
for _, info in ipairs(page) do
    print("有序集合:", info.DataStoreName, "键数量:", info.KeyCount)
end
```
