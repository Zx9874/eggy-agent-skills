# DataStoreInfoPages

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

### 继承关系

* [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)（1 属性 / 2 函数）
  + **[DataStoreInfoPages]**

### 继承成员

1 个来源 / 1 属性 / 2 函数

* 来自 [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)（1 属性 / 2 函数）
  + 属性：[`IsFinished`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#properties)
  + 函数：[`GetCurrentPage`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#functions)、[`AdvanceToNextPageAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#functions)

[DataStoreInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreInfoPages.html) 是 DataStoreService:ListDataStoresAsync 或 ListOrderedDataStoresAsync 返回的分页迭代器，GetCurrentPage() 返回 [DataStoreInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreInfo.html) 数组。

## 适用场景

用于管理后台或运维脚本中分页列出当前作品的数据存储集合，读取名称、类型、键数量、数据大小等元信息。

## 使用要点

该类型不可直接构造，应从 [DataStoreService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/DataStoreService.html) 的列表接口返回值获取。ListDataStoresAsync 是异步方法，需放在 Task:Spawn 等协程环境中调用。

## 代码示例

### 列出 DataStore 集合分页

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')

Task:Spawn(function()
    local options = DataStoreListOptions.New()
    options.ExcludeDeleted = true
    local pages = DataStoreService:ListDataStoresAsync('', 10, '', options)
    for _, info in ipairs(pages:GetCurrentPage()) do
        print(info.DataStoreName, info.KeyCount, info.Size)
    end
end)
```

## 关联类型

* [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)
