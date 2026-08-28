# DataStoreKeyBriefInfoPages

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

### 继承关系

* [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)（1 属性 / 2 函数）
  + **[DataStoreKeyBriefInfoPages]**

### 继承成员

1 个来源 / 1 属性 / 2 函数

* 来自 [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)（1 属性 / 2 函数）
  + 属性：[`IsFinished`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#properties)
  + 函数：[`GetCurrentPage`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#functions)、[`AdvanceToNextPageAsync`](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html#functions)

[DataStoreKeyBriefInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreKeyBriefInfoPages.html) 是 DataStore:ListKeysAsync 返回的分页迭代器，GetCurrentPage() 返回 [DataStoreKeyBriefInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreKeyBriefInfo.html) 数组。

## 适用场景

用于按前缀分页列出某个 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 内的 key，常见于管理存档、清理废弃 key 或做数据迁移检查。

## 使用要点

该类型不可直接构造，应先通过 DataStoreService:GetDataStore 获取 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html)，再调用 ListKeysAsync 得到 pages。ListKeysAsync 是异步方法，需在协程环境中调用。

## 代码示例

### 列出 DataStore key 分页

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local dataStore = DataStoreService:GetDataStore('PlayerData', 'global')

Task:Spawn(function()
    local options = DataStoreListKeyOptions.New()
    options.ExcludeDeleted = true
    local pages = dataStore:ListKeysAsync('player_', 10, '', options)
    for _, keyInfo in ipairs(pages:GetCurrentPage()) do
        print(keyInfo.Scope, keyInfo.Key, keyInfo.IsDeleted)
    end
end)
```

## 关联类型

* [Pages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Pages.html)
