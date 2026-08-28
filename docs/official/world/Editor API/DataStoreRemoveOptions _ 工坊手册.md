# DataStoreRemoveOptions

DataStore:RemoveAsync 的可选参数，可通过 DataStoreRemoveOptions.New() 构造。

## 概览

DataStore:RemoveAsync 的可选参数。 优先级高于 DataStore 创建时的 DataStoreOptions，nil 字段表示使用实例默认值。

> 可通过 `DataStoreRemoveOptions.New()` 构造

## 代码示例

### 构造选项

```lua
local opt = DataStoreRemoveOptions.New() -- 构造删除选项
opt.WithKeyInfo = true
opt.PermanentlyRemove = false
print("WithKeyInfo=", opt.WithKeyInfo, "PermanentlyRemove=", opt.PermanentlyRemove)

local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")
ds:SetAsync("my_key", 100)

local oldValue, keyInfo = ds:RemoveAsync("my_key", opt) -- 携带选项删除
print("removed value=", oldValue, "keyInfo=", keyInfo ~= nil)
print("after remove=", ds:GetAsync("my_key"))
```

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `WithKeyInfo` | `Bool` | - | 是否返回包含版本号、创建和修改日期、UserIds和Metas的DataStoreKeyInfo 实例(可选), 为 true 时若 key 不存在，则返回nil |
| `PermanentlyRemove` | `Bool` | - | 是否永久删除 (而非软删除) (可选) |
| `DependPrevVersion` | `String` | - | 依赖的前置版本号, 只有数据的当前版本与此版本一致时才允许删除 (可选) |
