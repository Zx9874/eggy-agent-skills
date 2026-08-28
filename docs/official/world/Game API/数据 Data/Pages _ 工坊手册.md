# Pages

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

### 继承关系

* **[Pages]**（1 属性 / 2 函数）
  + [DataStoreInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreInfoPages.html)
  + [DataStoreKeyBriefInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreKeyBriefInfoPages.html)
  + [DataStoreVersionInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreVersionInfoPages.html)
  + [MemoryStoreHashMapPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMapPages.html)
  + [MemoryStoreSortedMapPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMapPages.html)
  + [OrderedDataStoreKeyValueInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStoreKeyValueInfoPages.html)

分页迭代器基类，用于分批读取大量数据条目。通过判断是否已迭代完毕来控制遍历流程，支持读取当前页数据与异步推进到下一页。该对象不能直接创建，只能从各类列表查询接口的返回值中获得。

## 适用场景

适合在需要遍历大量数据存储条目时使用，例如分批读取数据存储中的键列表或内存存储中的哈希表条目。

## 使用要点

先从数据服务的列表接口获取分页实例，例如通过数据存储的键列表接口获得返回的分页对象。循环中先检查是否已迭代完毕，未完毕则调用 GetCurrentPage 读取当前页数据，处理完后调用 AdvanceToNextPageAsync 推进到下一页，并等待其完成后再进行下一轮判断。

## 注意事项

[Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html) 是由 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html)/MemoryStore 等列表接口返回的分页迭代器，不可直接构造。GetCurrentPage 读取当前页；AdvanceToNextPageAsync 会推进到下一页并返回是否成功，分页循环中应等待该调用完成后再继续读取下一页，不要把 AdvanceToNextPageAsync 放进另一个 Task:Spawn 后让外层 while 立即继续。

## 代码示例

### 遍历分页数据

```lua
-- @runtime server
local DataStoreService = game:GetService("DataStoreService")
local Task = game:GetService("Task")
local orderedStore = DataStoreService:GetOrderedDataStore("PlayerScores")

Task:Spawn(function()
  local pages = orderedStore:GetSortedAsync(false, 10)
  while true do
    local currentPage = pages:GetCurrentPage()
    for _, item in ipairs(currentPage) do
      print("Key:", item.Key, "Value:", item.Value)
    end

    if pages.IsFinished then
      break
    end

    local ok = pages:AdvanceToNextPageAsync()
    if not ok then
      print("翻页失败，停止遍历")
      break
    end
  end
end)
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `IsFinished` | `Bool` | `false` | 指示分页是否已经迭代完毕。 |

## 函数 (2)

### GetCurrentPage

签名：`GetCurrentPage() -> Array<String> (当前页的数据对象列表)`

返回当前页的数据列表；具体元素结构由创建该分页对象的列表接口决定。

**返回值** `Array<String>` (当前页的数据对象列表)

> 示例代码

> 读取当前页数据

```lua
-- @runtime server
local DataStoreService = game:GetService("DataStoreService")
local Task = game:GetService("Task")
local orderedStore = DataStoreService:GetOrderedDataStore("PlayerScores")

Task:Spawn(function()
  local pages = orderedStore:GetSortedAsync(false, 10)
  local currentPage = pages:GetCurrentPage()
  for _, item in ipairs(currentPage) do
    print("Key:", item.Key, "Value:", item.Value)
  end
end)
```

### AdvanceToNextPageAsync

签名：`AdvanceToNextPageAsync() -> Bool (是否成功翻页)`

异步将分页数据翻到下一页，并返回是否成功翻页。

⚙ 推进到下一页并返回是否成功。分页循环中应等待该调用完成后再读取下一页，不要在外层 while 中用 Task:Spawn 异步调用后立即继续循环。

**返回值** `Bool` (是否成功翻页)

> 示例代码

> 等待翻页并继续读取

```lua
-- @runtime server
local DataStoreService = game:GetService("DataStoreService")
local Task = game:GetService("Task")
local orderedStore = DataStoreService:GetOrderedDataStore("PlayerScores")

Task:Spawn(function()
  local pages = orderedStore:GetSortedAsync(false, 10)
  while true do
    for _, item in ipairs(pages:GetCurrentPage()) do
      print("Key:", item.Key, "Value:", item.Value)
    end
    if pages.IsFinished then
      break
    end
    local ok = pages:AdvanceToNextPageAsync()
    if not ok then
      break
    end
  end
end)
```
