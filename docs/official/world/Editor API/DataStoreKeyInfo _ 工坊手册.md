# DataStoreKeyInfo

DataStore 键信息对象，由 GetAsync / SetAsync 等方法返回。

## 概览

DataStore 键信息对象，包含键名、版本号、创建/更新时间、用户 ID 列表与自定义元数据。 不可实例化，由 GetAsync / SetAsync / IncrementAsync / RemoveAsync / UpdateAsync 等方法返回，可通过 GetUserIds / GetMetaDatas 获取用户与元数据信息。

## 函数

### GetMetaDatas

签名：`GetMetaDatas() -> Table`

获取该键关联的用户自定义元数据字典。

**返回值** `Table` — 元数据表（键为字符串，值为任意类型）

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

local opt = DataStoreSetOptions.New()
opt.WithKeyInfo = true
opt:SetMetaData("season", "se0725")

local _, keyInfo = ds:SetAsync("my_key", 100, opt)
local metas = keyInfo:GetMetaDatas() -- 读回键元数据
print("version=", keyInfo.Version, "meta.season=", metas.season)

ds:RemoveAsync("my_key") -- 清理测试数据
```

### GetUserIds

签名：`GetUserIds() -> Table`

获取该键关联的用户 ID 列表。

**返回值** `Table` — 用户 ID 列表

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

local opt = DataStoreSetOptions.New()
opt.WithKeyInfo = true
opt:AddUserId("u1")

local _, keyInfo = ds:SetAsync("my_key", 100, opt)
local userIds = keyInfo:GetUserIds() -- 读回键归属用户
print("key=", keyInfo.Key, "userId[1]=", userIds[1])

ds:RemoveAsync("my_key") -- 清理测试数据
```

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `CreatedTime` | `Int` | `0` | 创建时间 (毫秒时间戳)（只读） |
| `UpdatedTime` | `Int` | `0` | 更新时间 (毫秒时间戳)（只读） |
| `Version` | `String` | `""` | 版本号（只读） |
| `Scope` | `String` | `""` | 前置域（只读） |
| `Key` | `String` | `""` | 键名（只读） |
| `Metas` | `Table` | `{}` | 用户自定义元数据（只读） |
| `UserIds` | `Table` | `[]` | 用户ID列表（只读） |
| `IsDeleted` | `Bool` | `false` | 是否已删除（只读） |
