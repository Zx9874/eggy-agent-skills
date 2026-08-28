# DataStoreSetOptions

DataStore:SetAsync 的可选参数，可通过 DataStoreSetOptions.New() 构造。

## 概览

DataStore:SetAsync 的可选参数。 优先级高于 DataStore 创建时的 DataStoreOptions，nil 字段表示使用实例默认值。

> 可通过 `DataStoreSetOptions.New()` 构造

## 代码示例

### 构造选项

```lua
local opt = DataStoreSetOptions.New() -- 构造写入选项
opt.WithKeyInfo = true
opt:AddUserId("u3")
opt:SetMetaData("season", "se0725")

local userIds = opt:GetUserIds()
local metas = opt:GetMetaDatas()
print("userId[1]=", userIds[1], "meta.season=", metas.season)

local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")
local version, keyInfo = ds:SetAsync("my_key", 100, opt) -- 携带选项写入
print("version=", version, "keyInfo=", keyInfo ~= nil)

ds:RemoveAsync("my_key") -- 清理测试数据
```

## 函数

### GetUserIds

签名：`GetUserIds() -> Table`

获取用户 ID 列表。

**返回值** `Table` — 用户 ID 列表

**示例**

```lua
local opts = DataStoreSetOptions.New()
opts:SetUserIds({ "u1", "u2" })

local ids = opts:GetUserIds() -- 读回用户列表
print("userIds count=", #ids, "userId[1]=", ids[1])

local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")
ds:SetAsync("my_key", 100, opts)

ds:RemoveAsync("my_key") -- 清理测试数据
```

### SetUserIds

签名：`SetUserIds(userIds: Array)`

设置用户 ID 列表（整体替换）。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `userIds` | `Array` | 用户ID列表 |

**示例**

```lua
local opts = DataStoreSetOptions.New()
opts:SetUserIds({ "u1", "u2" }) -- 整体替换用户列表

local userIds = opts:GetUserIds()
print("count=", #userIds, "userId[1]=", userIds[1])

local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")
ds:SetAsync("my_key", 100, opts)

ds:RemoveAsync("my_key") -- 清理测试数据
```

### AddUserId

签名：`AddUserId(userId: String)`

添加单个用户 ID 到列表。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `userId` | `String` | 用户ID |

**示例**

```lua
local opts = DataStoreSetOptions.New()
opts:AddUserId("u1") -- 追加用户
opts:AddUserId("u2")

local userIds = opts:GetUserIds()
print("userId count=", #userIds, "userId[1]=", userIds[1])

local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")
ds:SetAsync("my_key", 100, opts)

ds:RemoveAsync("my_key") -- 清理测试数据
```

### GetMetaDatas

签名：`GetMetaDatas() -> Table`

获取用户自定义元数据字典。

**返回值** `Table` — 元数据表（键为字符串，值为任意类型）

**示例**

```lua
local opts = DataStoreSetOptions.New()
opts:SetMetaDatas({ level = "10" })

local metas = opts:GetMetaDatas() -- 读回元数据
print("meta.level=", metas.level)

local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")
ds:SetAsync("my_key", 100, opts)

ds:RemoveAsync("my_key") -- 清理测试数据
```

### SetMetaDatas

签名：`SetMetaDatas(dict: Table)`

整体替换用户自定义元数据字典。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `dict` | `Table` | 元数据字典 |

**示例**

```lua
local opts = DataStoreSetOptions.New()
opts:SetMetaDatas({ level = "10", season = "s1" }) -- 整体替换元数据

local metas = opts:GetMetaDatas()
print("meta.level=", metas.level, "meta.season=", metas.season)

local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")
ds:SetAsync("my_key", 100, opts)

ds:RemoveAsync("my_key") -- 清理测试数据
```

### UpdateMetaDatas

签名：`UpdateMetaDatas(dict: Table)`

合并更新用户自定义元数据，已存在的 key 会被覆盖。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `dict` | `Table` | 要合并的元数据 |

**示例**

```lua
local opts = DataStoreSetOptions.New()
opts:SetMetaDatas({ level = "1" })
opts:UpdateMetaDatas({ level = "10", season = "s1" }) -- 合并更新元数据

local metas = opts:GetMetaDatas()
print("meta.level=", metas.level, "meta.season=", metas.season)

local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")
ds:SetAsync("my_key", 100, opts)

ds:RemoveAsync("my_key") -- 清理测试数据
```

### SetMetaData

签名：`SetMetaData(name: String, value: String)`

设置单个用户自定义元数据项。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 元数据键名 |
| `value` | `String` | 元数据键值 |

**示例**

```lua
local opts = DataStoreSetOptions.New()
opts:SetMetaData("level", "10") -- 设置元数据

local metas = opts:GetMetaDatas()
print("meta.level=", metas.level)

local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")
ds:SetAsync("my_key", 100, opts)

ds:RemoveAsync("my_key") -- 清理测试数据
```

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `WithKeyInfo` | `Bool` | - | 是否返回包含版本号、创建和修改日期、UserIds和Metas的DataStoreKeyInfo 实例(可选) |
| `KeepOldMetas` | `Bool` | - | 更新时是否保留旧元数据 (可选) |
| `DependPrevVersion` | `String` | - | 依赖的前置版本号, 只有数据的当前版本与此版本一致时才允许更新 (可选) |
