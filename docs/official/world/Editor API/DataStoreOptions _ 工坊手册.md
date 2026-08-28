# DataStoreOptions

DataStore 获取存储集合的额外选项，在 GetDataStore / GetOrderedDataStore 时传入，可通过 DataStoreOptions.New() 构造。

## 概览

DataStore 获取存储集合的额外选项。 在 DataStoreService:GetDataStore / GetOrderedDataStore 时传入，作为实例级默认值；各方法的 options 参数优先级高于此选项。

> 可通过 `DataStoreOptions.New()` 构造

## 代码示例

### 构造选项

```lua
local opt = DataStoreOptions.New() -- 构造实例默认选项
opt.WithKeyInfo = true
opt.ExcludeDeleted = true
print("WithKeyInfo=", opt.WithKeyInfo, "ExcludeDeleted=", opt.ExcludeDeleted)

local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store", nil, opt) -- 作为实例默认值
local _, keyInfo = ds:SetAsync("my_key", 100)
print("keyInfo from instance option=", keyInfo ~= nil)

ds:RemoveAsync("my_key") -- 清理测试数据
```

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `AllScopes` | `Bool` | `false` | 是否跨范围查询 |
| `WithKeyInfo` | `Bool` | `false` | 是否返回包含版本号、创建和修改日期、UserIds和Metas的DataStoreKeyInfo 实例 |
| `KeepOldMetas` | `Bool` | `true` | 更新时是否保留旧元数据 |
| `ExcludeDeleted` | `Bool` | `false` | 是否排除已删除的条目 |
| `UseCache` | `Bool` | `false` | 是否使用缓存 |
| `PermanentlyRemove` | `Bool` | `false` | 是否永久删除 (而非软删除) |
| `UpdateTimeAsc` | `Bool` | `true` | 是否按更新时间升序排列 |
