# DataStoreListKeyOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[DataStoreListKeyOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListKeyOptions.html) 是 DataStore:ListKeysAsync 的可选参数容器，用于控制列 key 时是否排除已删除条目。

## 适用场景

分页巡检某个 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 的 key 时，设置 ExcludeDeleted 过滤软删除条目。

## 使用要点

使用 DataStoreListKeyOptions.New(...) 或 [DataStoreListKeyOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListKeyOptions.html)(...) 创建配置对象，设置 ExcludeDeleted 后作为 DataStore:ListKeysAsync 的 options 参数传入。

## 注意事项

可通过 DataStoreListKeyOptions.New(...) 或 [DataStoreListKeyOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListKeyOptions.html)(...) 直接构造。该对象只承载 ListKeysAsync 的可选参数，不直接返回数据。

## 代码示例

### 构造 ListKeysAsync 选项

```lua
-- @runtime server
local options = DataStoreListKeyOptions.New()
options.ExcludeDeleted = true
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `ExcludeDeleted` | `Bool` | `-` | 一个布尔值，指示在列出键时是否排除已标记为删除的条目。 |

## 函数 (1)

### New

签名：`New() -> DataStoreListKeyOptions`

构造一个新的 [DataStoreListKeyOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListKeyOptions.html) 实例，用于配置列出数据存储键时的过滤选项。

**返回值** [DataStoreListKeyOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListKeyOptions.html)

> 示例代码

> 构造选项并按签名列出 key

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local store = DataStoreService:GetDataStore('PlayerData')
local options = DataStoreListKeyOptions.New()
options.ExcludeDeleted = true

Task:Spawn(function()
    local pages = store:ListKeysAsync('', 10, '', options)
    print('当前页键数量:', #pages:GetCurrentPage())
end)
```
