# OrderedDataStore

有序数据存储集合，仅由 DataStoreService:GetOrderedDataStore() 返回。

## 概览

有序数据存储集合，继承自 DataStore，添加 GetSortedAsync 方法，支持按值排序查询键值对。 不可实例化，仅由 DataStoreService:GetOrderedDataStore() 返回；存入的值必须是整数。

> 继承自 `DataStore`

## 函数

### GetSortedAsync

签名：`GetSortedAsync(ascending: Bool, pageSize: Int?, minValue: Int?, maxValue: Int?, options: DataStoreGetOptions?) -> OrderedDataStoreKeyValueInfoPages`

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `ascending` | `Bool` | 是否升序 |
| `pageSize` | `Int` | 页大小, 默认 0 (使用服务端默认值) |
| `minValue` | `Int` | 最小值过滤, 包含 |
| `maxValue` | `Int` | 最大值过滤, 包含 |
| `options` | `DataStoreGetOptions` | 可选参数, 优先级高于 OrderedDataStore 创建时的 DataStoreOptions, 可通过 DataStoreGetOptions.New() 创建 |

**返回值** `OrderedDataStoreKeyValueInfoPages` — 分页的键值对结果，按值排序，通过迭代器逐页获取

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetOrderedDataStore("my_rank")

ds:SetAsync("player_a", 10)
ds:SetAsync("player_b", 30)
ds:SetAsync("player_c", 20)

local pages = ds:GetSortedAsync(true) -- 按值升序获取排序数据
print("current page count=", #pages:GetCurrentPage())

ds:RemoveAsync("player_a") -- 清理测试数据
ds:RemoveAsync("player_b")
ds:RemoveAsync("player_c")
```
