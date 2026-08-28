# DataStoreListOptions

DataStoreService:ListDataStoresAsync / ListOrderedDataStoresAsync 的可选参数，可通过 DataStoreListOptions.New() 构造。

## 概览

DataStoreService:ListDataStoresAsync / ListOrderedDataStoresAsync 的可选参数。

> 可通过 `DataStoreListOptions.New()` 构造

## 代码示例

### 构造选项

```lua
local opt = DataStoreListOptions.New() -- 构造集合列表选项
opt.ExcludeDeleted = true
print("ExcludeDeleted=", opt.ExcludeDeleted)

local service = editor:GetService("DataStoreService")
local pages = service:ListDataStoresAsync("my_", 0, nil, opt) -- 携带选项列出集合
print("current page count=", #pages:GetCurrentPage())
```

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `ExcludeDeleted` | `Bool` | - | 是否排除已删除的 DataStore 集合 (可选) |
