# DataStoreVersionInfo

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[DataStoreVersionInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreVersionInfo.html) 是 DataStore:ListVersionsAsync 返回的历史版本条目，包含版本创建时间、版本号和删除状态。

## 适用场景

服务端列出某个 key 的历史版本时，读取 [DataStoreVersionInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreVersionInfo.html) 条目用于版本列表、审计或回滚前确认。

## 使用要点

先通过 DataStore:ListVersionsAsync 获得 [DataStoreVersionInfoPages](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreVersionInfoPages.html)，再从 pages:GetCurrentPage() 返回的数组中读取 [DataStoreVersionInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreVersionInfo.html) 条目。

## 注意事项

该对象仅由版本列表 API 返回，不可自行构造。版本号格式为特定字符串，随意构造的字符串可能导致 API 抛出异常。注意版本列表接口存在调用频率限制，建议缓存结果避免频繁请求。

## 代码示例

### 读取历史版本条目

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local dataStore = DataStoreService:GetDataStore('PlayerData', 'global')

Task:Spawn(function()
    local pages = dataStore:ListVersionsAsync('player_1001', false, 0, 0, 10)
    for _, versionInfo in ipairs(pages:GetCurrentPage()) do
        print(versionInfo.Version, versionInfo.CreatedTime, versionInfo.IsDeleted)
    end
end)
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `CreatedTime` | `Int` | `0` | 该版本创建时的时间戳，单位为毫秒。 |
| `Version` | `String` | `""` | 该版本的唯一标识字符串。 |
| `IsDeleted` | `Bool` | `false` | 标识该版本是否已被删除。 |
