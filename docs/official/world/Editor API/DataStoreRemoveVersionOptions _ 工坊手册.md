# DataStoreRemoveVersionOptions

DataStore:RemoveVersionAsync 的可选参数，可通过 DataStoreRemoveVersionOptions.New() 构造。

## 概览

DataStore:RemoveVersionAsync 的可选参数。 优先级高于 DataStore 创建时的 DataStoreOptions，nil 字段表示使用实例默认值。

> 可通过 `DataStoreRemoveVersionOptions.New()` 构造

## 代码示例

### 构造选项

```lua
local opt = DataStoreRemoveVersionOptions.New() -- 构造版本删除选项
opt.WithKeyInfo = true
print("WithKeyInfo=", opt.WithKeyInfo)

local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")
local version = ds:SetAsync("my_key", 100)

local removed, keyInfo = ds:RemoveVersionAsync("my_key", version, opt) -- 删除指定版本
print("removed value=", removed, "keyInfo=", keyInfo ~= nil)

ds:RemoveAsync("my_key") -- 清理测试数据
```

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `WithKeyInfo` | `Bool` | - | 是否返回包含版本号、创建和修改日期、UserIds和Metas的DataStoreKeyInfo 实例(可选), 为 true 时若版本不存在，则返回nil |
