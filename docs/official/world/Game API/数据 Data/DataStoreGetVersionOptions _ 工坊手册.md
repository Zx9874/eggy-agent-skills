# DataStoreGetVersionOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

DataStore:GetVersionAsync / GetVersionAtTimeAsync 的可选参数类型，可通过 DataStoreGetVersionOptions.New() 创建。

## 适用场景

在需要获取数据存储中特定版本信息时，通过 [DataStoreGetVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetVersionOptions.html) 指定是否附带键信息，以便在版本查询结果中直接获取版本号、创建时间等元数据。

## 使用要点

服务端读取历史版本时，可省略 options；需要同时返回 [DataStoreKeyInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreKeyInfo.html) 时，使用 DataStoreGetVersionOptions.New() 创建实例并设置 WithKeyInfo=true，再作为第三个参数传入。

## 注意事项

[DataStoreGetVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetVersionOptions.html) 支持 .New()，但不支持 [DataStoreGetVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetVersionOptions.html)(...) 直接调用简写。未设置的字段保持 nil，表示沿用 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 实例默认行为。

## 代码示例

### 读取指定版本并返回 KeyInfo

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local dataStore = DataStoreService:GetDataStore('PlayerData')
local key = 'player_1001'
local options = DataStoreGetVersionOptions.New()
options.WithKeyInfo = true

Task:Spawn(function()
    local pages = dataStore:ListVersionsAsync(key, false, 0, 0, 10)
    local versionInfo = pages:GetCurrentPage()[1]
    if versionInfo == nil then
        print('当前键没有可读取的历史版本')
        return
    end
    local value, keyInfo = dataStore:GetVersionAsync(key, versionInfo.Version, options)
    print('版本值:', value, '版本号:', keyInfo and keyInfo.Version)
end)
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `WithKeyInfo` | `Bool` | `-` | 是否在返回结果中附带键信息（version, created/modified time, UserIds, Metas 等键元数据）。 |

## 函数 (1)

### New

签名：`New() -> DataStoreGetVersionOptions`

创建一个新的 [DataStoreGetVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetVersionOptions.html) 实例，用于配置获取数据存储版本时的选项。

**返回值** [DataStoreGetVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetVersionOptions.html)

> 示例代码

> 构造历史版本读取选项

```lua
-- @runtime server
local options = DataStoreGetVersionOptions.New()
options.WithKeyInfo = true
print('是否返回 KeyInfo:', options.WithKeyInfo)
```
