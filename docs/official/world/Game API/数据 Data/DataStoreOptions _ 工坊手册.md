# DataStoreOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html) 是获取 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 或 [OrderedDataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OrderedDataStore.html) 句柄时传入的实例级默认选项，后续读写方法未传入自己的 options 时会使用这些默认值。

## 适用场景

当某个 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 的多次操作都需要统一启用 KeyInfo、缓存策略、删除策略或跨 scope 查询时，在 GetDataStore/GetGlobalDataStore/GetOrderedDataStore 阶段传入 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html)。

## 使用要点

使用 DataStoreOptions.New(...) 或 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html)(...) 创建配置对象，设置 AllScopes、WithKeyInfo、KeepOldMetas、ExcludeDeleted、UseCache、PermanentlyRemove 或 UpdateTimeAsc，再传给 DataStoreService:GetDataStore 等方法。

## 注意事项

可通过 DataStoreOptions.New(...) 或 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html)(...) 直接构造。方法级 options（如 [DataStoreGetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetOptions.html)、[DataStoreIncrementOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreIncrementOptions.html)、[DataStoreListKeyOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListKeyOptions.html)）优先级高于 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html) 实例级默认值。AllScopes=true 时，key 按 scope/key 形式解析，适合跨 scope 读取或巡检。

## 代码示例

### 创建带默认选项的 DataStore

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')

local options = DataStoreOptions.New()
options.AllScopes = true
options.WithKeyInfo = true
options.UseCache = false

local dataStore = DataStoreService:GetDataStore('PlayerData', nil, options)
Task:Spawn(function()
    -- AllScopes=true 时，key 可以使用 scope/key 形式
    local value, keyInfo = dataStore:GetAsync('global/player_001')
    if keyInfo ~= nil then
        print(keyInfo.Scope, keyInfo.Key, keyInfo.Version)
    end
end)
```

## 属性 (7)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `AllScopes` | `Bool` | `false` | 是否跨范围查询。 |
| `WithKeyInfo` | `Bool` | `false` | 是否在返回结果中附带键信息（version, created/modified time, UserIds, Metas 等键元数据）。 |
| `KeepOldMetas` | `Bool` | `true` | 更新时是否保留旧元数据。 |
| `ExcludeDeleted` | `Bool` | `false` | 是否排除已删除的条目。 |
| `UseCache` | `Bool` | `false` | 是否使用缓存。 |
| `PermanentlyRemove` | `Bool` | `false` | 是否永久删除（而非软删除）。 |
| `UpdateTimeAsc` | `Bool` | `true` | 是否按更新时间升序排列。 |

## 函数 (1)

### New

签名：`New() -> DataStoreOptions`

创建一个新的 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html) 实例，用于配置数据存储操作的选项。

**返回值** [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html)

> 示例代码

> 构造 DataStoreOptions 并设置属性

```lua
-- @runtime server
-- 构造 DataStoreOptions 实例，使用简写形式
local options = DataStoreOptions()
-- 设置跨 scope 查询
options.AllScopes = true
-- 设置返回 key 的元信息
options.WithKeyInfo = true
-- 设置排除已删除的 key
options.ExcludeDeleted = true
-- 打印属性值验证
print("AllScopes:", options.AllScopes)
print("WithKeyInfo:", options.WithKeyInfo)
print("ExcludeDeleted:", options.ExcludeDeleted)
```
