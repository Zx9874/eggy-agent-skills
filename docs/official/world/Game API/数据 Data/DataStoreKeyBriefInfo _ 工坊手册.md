# DataStoreKeyBriefInfo

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[DataStoreKeyBriefInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreKeyBriefInfo.html) 是 DataStore:ListKeysAsync 返回的 key 摘要条目，包含 Scope、Key 和 IsDeleted。

## 适用场景

在服务端分页巡检某个 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 的 key 时，快速读取 key 名、所属 scope 和删除状态。

## 使用要点

先通过 DataStoreService:GetDataStore 获取 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html)，再调用 dataStore:ListKeysAsync 获得 [DataStoreKeyBriefInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreKeyBriefInfoPages.html)；从 pages:GetCurrentPage() 返回的数组中读取条目。

## 注意事项

该对象不可直接构造，必须通过数据存储的列表操作获得。IsDeleted 属性仅表示键是否被标记为删除，不代表数据已物理清除。

## 代码示例

### 读取 key 摘要条目

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local dataStore = DataStoreService:GetDataStore('PlayerData', 'global')

Task:Spawn(function()
    local pages = dataStore:ListKeysAsync('player_', 10)
    for _, briefInfo in ipairs(pages:GetCurrentPage()) do
        print(briefInfo.Scope, briefInfo.Key, briefInfo.IsDeleted)
    end
end)
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Scope` | `String` | `""` | 该键所属的作用域。 |
| `Key` | `String` | `""` | 数据存储中该键的名称。 |
| `IsDeleted` | `Bool` | `false` | 表示该键是否已被标记为删除。 |
