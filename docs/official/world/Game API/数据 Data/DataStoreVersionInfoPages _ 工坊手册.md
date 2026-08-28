# DataStoreVersionInfoPages

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

DataStoreVersionInfoPages，继承自 [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)（1 属性 / 2 函数）。

### 继承关系

* [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)（1 属性 / 2 函数）
  + **[DataStoreVersionInfoPages]**

### 继承成员

1 个来源 / 1 属性 / 2 函数

* 来自 [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)（1 属性 / 2 函数）
  + 属性：[`IsFinished`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#properties)
  + 函数：[`GetCurrentPage`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#functions)、[`AdvanceToNextPageAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#functions)

[DataStoreVersionInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreVersionInfo.html) 分页迭代器，由 DataStore:ListVersionsAsync 返回。 GetCurrentPage() 返回 [DataStoreVersionInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreVersionInfo.html)[]。

## 注意事项

[DataStoreVersionInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreVersionInfoPages.html) 不可直接构造，通常由 DataStore:ListVersionsAsync(key, ascending, minDate, maxDate, pageSize) 返回。作者应在返回的 pages 上调用 GetCurrentPage() 和 AdvanceToNextPageAsync()，不要使用空分页工厂作为业务示例。

## 代码示例

### 读取 DataStore 历史版本分页

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local dataStore = DataStoreService:GetDataStore('PlayerData', 'global')

Task:Spawn(function()
    local pages = dataStore:ListVersionsAsync('player_1001', false, 0, 0, 10)
    local currentPage = pages:GetCurrentPage()
    for _, versionInfo in ipairs(currentPage) do
        print('版本:', versionInfo.Version, '创建时间:', versionInfo.CreatedTime)
    end
end)
```

## 关联类型

* [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)
