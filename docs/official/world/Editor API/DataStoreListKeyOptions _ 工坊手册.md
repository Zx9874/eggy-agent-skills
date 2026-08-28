# DataStoreListKeyOptions

DataStore:ListKeysAsync 的可选参数，可通过 DataStoreListKeyOptions.New() 构造。

## 概览

DataStore:ListKeysAsync 的可选参数。 优先级高于 DataStore 创建时的 DataStoreOptions，nil 字段表示使用实例默认值。

> 可通过 `DataStoreListKeyOptions.New()` 构造

## 代码示例

### 构造选项

```lua
local opt = DataStoreListKeyOptions.New() -- 构造键列表选项
opt.ExcludeDeleted = true
print("ExcludeDeleted=", opt.ExcludeDeleted)

local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")
ds:SetAsync("my_key", 100)

local pages = ds:ListKeysAsync("my_", 0, nil, opt) -- 携带选项列出键
print("current page count=", #pages:GetCurrentPage())

ds:RemoveAsync("my_key") -- 清理测试数据
```

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `ExcludeDeleted` | `Bool` | - | 是否排除已删除的条目 (可选) |
