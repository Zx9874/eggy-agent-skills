# DataStoreGetOptions

DataStore:GetAsync 的可选参数，可通过 DataStoreGetOptions.New() 构造。

## 概览

DataStore:GetAsync 的可选参数。 优先级高于 DataStore 创建时的 DataStoreOptions，nil 字段表示使用实例默认值。

> 可通过 `DataStoreGetOptions.New()` 构造

## 代码示例

### 构造选项

```lua
local opt = DataStoreGetOptions.New() -- 构造读取选项
opt.WithKeyInfo = true
opt.UseCache = true
print("WithKeyInfo=", opt.WithKeyInfo, "UseCache=", opt.UseCache)

local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")
ds:SetAsync("my_key", 100)

local value, keyInfo = ds:GetAsync("my_key", opt) -- 携带选项读取
print("value=", value, "keyInfo=", keyInfo ~= nil)
if keyInfo then
    print("key=", keyInfo.Key, "version=", keyInfo.Version)
end

ds:RemoveAsync("my_key") -- 清理测试数据
```

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `WithKeyInfo` | `Bool` | - | 是否返回包含版本号、创建和修改日期、UserIds和Metas的DataStoreKeyInfo 实例(可选) |
| `ExcludeDeleted` | `Bool` | - | 是否排除已删除的条目 (可选) |
| `UseCache` | `Bool` | - | 是否使用缓存 (可选) |
| `UpdateTimeAsc` | `Bool` | - | 是否按更新时间升序排列 (可选) |
