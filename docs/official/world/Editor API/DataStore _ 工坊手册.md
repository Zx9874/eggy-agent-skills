# DataStore

DataStore 数据存储服务，通过 GetDataStore / GetGlobalDataStore 等获取。

## 概览

DataStore 数据存储服务，提供键值数据的持久化读写、版本管理和排序查询等能力。通过 DataStoreService 的 GetDataStore / GetGlobalDataStore / GetOrderedDataStore 获取。

> 不可实例化，由接口返回

## 函数

### GetAsync

签名：`GetAsync(key: String, options: DataStoreGetOptions?)`

获取指定 key 对应的数据；key 不存在时返回 nil。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `options` | `DataStoreGetOptions` | 可选参数, 优先级高于 DataStore 创建时的 DataStoreOptions, 可通过 DataStoreGetOptions.New() 创建 |

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

ds:SetAsync("my_key", 100) -- 写入数据

local value, keyInfo = ds:GetAsync("my_key") -- 读回数据
print("value=", value)
print("hasKeyInfo=", keyInfo ~= nil, "version=", keyInfo and keyInfo.Version or "(none)")

local opt = DataStoreGetOptions.New()
opt.WithKeyInfo = true
local _, info2 = ds:GetAsync("my_key", opt) -- 携带键信息读取
print("keyInfo.key=", info2 and info2.Key or "(none)")

ds:RemoveAsync("my_key") -- 删除数据
print("after remove=", ds:GetAsync("my_key"))
```

### SetAsync

签名：`SetAsync(key: String, value: Any, options: DataStoreSetOptions?)`

写入指定 key 的数据，若 key 已存在则覆盖。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `value` | `Any` | 数据值 |
| `options` | `DataStoreSetOptions` | 可选参数, 优先级高于 DataStore 创建时的 DataStoreOptions, 可通过 DataStoreSetOptions.New() 创建 |

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

local version = ds:SetAsync("my_key", 100) -- 写入数据
print("set version:", version)

print("read back:", ds:GetAsync("my_key"))

ds:RemoveAsync("my_key") -- 删除数据
print("after remove:", ds:GetAsync("my_key"))
```

### IncrementAsync

签名：`IncrementAsync(key: String, delta: Int, options: DataStoreIncrementOptions?)`

对指定 key 的数值进行原子自增，返回自增后的值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `delta` | `Int` | 自增值 (非零) |
| `options` | `DataStoreIncrementOptions` | 可选参数, 优先级高于 DataStore 创建时的 DataStoreOptions, 可通过 DataStoreIncrementOptions.New() 创建 |

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

ds:SetAsync("counter", 10) -- 写入初值

local newValue = ds:IncrementAsync("counter", 5) -- 原子自增
print("after increment=", newValue)

print("read back=", ds:GetAsync("counter"))

ds:RemoveAsync("counter") -- 删除数据
print("after remove=", ds:GetAsync("counter"))
```

### RemoveAsync

签名：`RemoveAsync(key: String, options: DataStoreRemoveOptions?)`

删除指定 key 的数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `options` | `DataStoreRemoveOptions` | 可选参数, 优先级高于 DataStore 创建时的 DataStoreOptions, 可通过 DataStoreRemoveOptions.New() 创建 |

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

ds:SetAsync("my_key", 42) -- 写入数据

local oldValue = ds:RemoveAsync("my_key") -- 删除数据
print("removed value=", oldValue)

print("after remove=", ds:GetAsync("my_key"))

print("remove missing=", ds:RemoveAsync("no_such_key"))
```

### UpdateAsync

签名：`UpdateAsync(key: String, transformFunction: Function)`

对指定 key 执行先读后写的复合更新：读取当前值交给变换函数，计算新值后写回；变换函数返回 nil 时放弃更新。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `transformFunction` | `Function` | 变换函数 function(currentValue, keyInfo) -> newValue, DataStoreSetOptions?; 返回 newValue=nil 时放弃更新; 可返回 DataStoreSetOptions 自定义写入选项 (如 metas, userIds); 每轮重试都会重新调用 transformFunction 拿到最新值 |

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

ds:SetAsync("num", 1) -- 写入初值

local newValue = ds:UpdateAsync("num", function(current) -- 复合更新
    return (current or 0) + 1
end)
print("after update=", newValue)

print("read back=", ds:GetAsync("num"))

ds:RemoveAsync("num") -- 删除数据
print("after remove=", ds:GetAsync("num"))
```

### ListKeysAsync

签名：`ListKeysAsync(prefix: String?, pageSize: Int?, cursor: String?, options: DataStoreListKeyOptions?) -> DataStoreKeyBriefInfoPages`

分页列出存储中的 key，可按前缀过滤。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefix` | `String` | 前缀过滤, 默认空字符串 |
| `pageSize` | `Int` | 页大小, 默认 0 (使用服务端默认值) |
| `cursor` | `String` | 分页游标 |
| `options` | `DataStoreListKeyOptions` | 可选参数, 优先级高于 DataStore 创建时的 DataStoreOptions, 可通过 DataStoreListKeyOptions.New() 创建 |

**返回值** `DataStoreKeyBriefInfoPages` — 分页的键信息列表，通过迭代器逐页获取

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

ds:SetAsync("my_aaa", 1) -- 写入数据
ds:SetAsync("my_bbb", 2)

local pages = ds:ListKeysAsync("my_") -- 分页列 key
print("pages ok:", pages ~= nil)

if pages then
    local items = pages:GetCurrentPage()
    print("current page count=", #items, "first=", items[1])
end

ds:RemoveAsync("my_aaa") -- 删除数据
ds:RemoveAsync("my_bbb")
```

### GetVersionAsync

签名：`GetVersionAsync(key: String, version: String, options: DataStoreGetVersionOptions?)`

获取指定 key 在指定版本的数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `version` | `String` | 版本号 |
| `options` | `DataStoreGetVersionOptions` | 可选参数, 优先级高于 DataStore 创建时的 DataStoreOptions, 可通过 DataStoreGetVersionOptions.New() 创建 |

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

local version = ds:SetAsync("my_key", 100) -- 写入数据
print("version=", version)

if version then
    local value = ds:GetVersionAsync("my_key", version) -- 按版本读回
    print("version value=", value)
end

ds:SetAsync("my_key", 200) -- 覆盖写入
if version then
    print("old version value=", ds:GetVersionAsync("my_key", version))
end

ds:RemoveAsync("my_key") -- 删除数据
print("after remove=", ds:GetAsync("my_key"))
```

### GetVersionAtTimeAsync

签名：`GetVersionAtTimeAsync(key: String, timestamp: Int, options: DataStoreGetVersionOptions?)`

获取指定 key 在指定时间点（毫秒时间戳）的数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `timestamp` | `Int` | 时间戳 (毫秒) |
| `options` | `DataStoreGetVersionOptions` | 可选参数, 优先级高于 DataStore 创建时的 DataStoreOptions, 可通过 DataStoreGetVersionOptions.New() 创建 |

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

ds:SetAsync("my_key", 100) -- 写入数据

local value = ds:GetVersionAtTimeAsync("my_key", os.time() * 1000) -- 按时间回查
if value ~= nil then
    print("value at time=", value)
else
    print("value at time=(none)")
end

print("current value=", ds:GetAsync("my_key"))

ds:RemoveAsync("my_key") -- 删除数据
```

### ListVersionsAsync

签名：`ListVersionsAsync(key: String, ascending: Bool?, minDate: Int?, maxDate: Int?, pageSize: Int?) -> DataStoreVersionInfoPages`

分页列出指定 key 的历史版本，可按时间范围过滤。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `ascending` | `Bool` | 排序方向, true 时按版本更新时间升序, false 时降序 |
| `minDate` | `Int` | 最小时间 (毫秒) |
| `maxDate` | `Int` | 最大时间 (毫秒) |
| `pageSize` | `Int` | 页大小, 默认 0 (使用服务端默认值) |

**返回值** `DataStoreVersionInfoPages` — 分页的版本信息列表，通过迭代器逐页获取

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

ds:SetAsync("my_key", 1) -- 写入数据
ds:SetAsync("my_key", 2)

local pages = ds:ListVersionsAsync("my_key", false) -- 分页列版本
print("pages ok:", pages ~= nil)

if pages then
    print("version page count=", #pages:GetCurrentPage())
end

ds:RemoveAsync("my_key") -- 删除数据
```

### RemoveVersionAsync

签名：`RemoveVersionAsync(key: String, version: String, options: DataStoreRemoveVersionOptions?)`

删除指定 key 的指定历史版本。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 键名 |
| `version` | `String` | 版本号 |
| `options` | `DataStoreRemoveVersionOptions` | 可选参数, 优先级高于 DataStore 创建时的 DataStoreOptions, 可通过 DataStoreRemoveVersionOptions.New() 创建 |

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

local version = ds:SetAsync("my_key", 100) -- 写入数据

if version then
    local removed = ds:RemoveVersionAsync("my_key", version) -- 按版本删除
    print("removed version value=", removed)
end

if version then
    print("version value after remove=", ds:GetVersionAsync("my_key", version))
end

ds:RemoveAsync("my_key") -- 删除数据
```
