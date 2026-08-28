# Pages

分页迭代器，提供通用的分页数据访问能力，由 DataStore 的 ListKeysAsync 等分页方法返回。

## 概览

分页迭代器，提供通用的分页数据访问能力。通常由 DataStore 的 ListKeysAsync 等分页方法返回，也可通过 Pages.New() 构造。 通过 GetCurrentPage 获取当前页数据，AdvanceToNextPageAsync 翻到下一页，IsFinished 判断是否已迭代完毕。

> 不可实例化，由接口返回

## 函数

### GetCurrentPage

签名：`GetCurrentPage() -> Array`

**返回值** `Array` — 当前页的数据数组；没有更多数据时返回空数组

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

ds:SetAsync("my_aaa", 1) -- 写入数据
ds:SetAsync("my_bbb", 2)
local pages = ds:ListKeysAsync("my_") -- 获取分页对象

local items = pages:GetCurrentPage() -- 读取当前页
print("page count=", #items, "first=", items[1])

local ok = pages:AdvanceToNextPageAsync() -- 翻到下一页
print("advance ok=", ok)
local nextItems = pages:GetCurrentPage() -- 读取新当前页
print("next page count=", #nextItems)

ds:RemoveAsync("my_aaa") -- 删除数据
ds:RemoveAsync("my_bbb")
```

### AdvanceToNextPageAsync

签名：`AdvanceToNextPageAsync() -> Bool`

**返回值** `Bool` — 是否成功翻到下一页；已无更多数据时返回 false

**示例**

```lua
local service = editor:GetService("DataStoreService")
local ds = service:GetDataStore("my_store")

ds:SetAsync("my_aaa", 1) -- 写入数据
ds:SetAsync("my_bbb", 2)
local pages = ds:ListKeysAsync("my_") -- 获取分页对象

local before = pages:GetCurrentPage() -- 读取当前页
print("before count=", #before)

local ok = pages:AdvanceToNextPageAsync() -- 翻到下一页
print("advance ok=", ok, "isFinished=", pages.IsFinished)

local after = pages:GetCurrentPage() -- 读取新当前页
print("after count=", #after)

ds:RemoveAsync("my_aaa") -- 删除数据
ds:RemoveAsync("my_bbb")
```

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `IsFinished` | `Bool` | `false` | 是否已迭代完毕（只读） |
