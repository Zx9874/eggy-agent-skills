# DataStoreRemoveVersionOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[DataStoreRemoveVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreRemoveVersionOptions.html) 是 DataStore:RemoveVersionAsync 的可选参数容器，可通过 DataStoreRemoveVersionOptions.New() 创建。

## 适用场景

服务端删除某个历史版本时，通常可只传入 key 和 version；需要同时返回 [DataStoreKeyInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreKeyInfo.html) 时再传入 options。

## 使用要点

在协程中调用 store:RemoveVersionAsync(key, version, options)；options 使用 DataStoreRemoveVersionOptions.New() 创建，并可设置 WithKeyInfo。

## 注意事项

[DataStoreRemoveVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreRemoveVersionOptions.html) 支持 .New()，但不支持 [DataStoreRemoveVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreRemoveVersionOptions.html)(...) 直接调用简写。版本不存在时，RemoveVersionAsync 会返回 nil。

## 代码示例

### 使用 options 删除指定版本

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local dataStore = DataStoreService:GetDataStore('DocumentationSandbox')
local key = 'cleanup_demo'
local options = DataStoreRemoveVersionOptions.New()
options.WithKeyInfo = true

Task:Spawn(function()
    local pages = dataStore:ListVersionsAsync(key, false, 0, 0, 10)
    local versionInfo = pages:GetCurrentPage()[1]
    if versionInfo == nil then
        print('当前键没有可删除的历史版本')
        return
    end
    -- 仅在确认该沙盒版本可以删除后执行
    local removedValue, keyInfo = dataStore:RemoveVersionAsync(key, versionInfo.Version, options)
    print('删除的版本数据:', removedValue, '版本:', keyInfo and keyInfo.Version)
end)
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `WithKeyInfo` | `Bool` | `-` | 是否在移除版本时返回包含版本号、创建和修改日期、UserIds 和 Metas 的 [DataStoreKeyInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreKeyInfo.html) 实例。 |

## 函数 (1)

### New

签名：`New() -> DataStoreRemoveVersionOptions`

创建一个新的 [DataStoreRemoveVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreRemoveVersionOptions.html) 实例，用于配置移除数据存储版本时的选项。

**返回值** [DataStoreRemoveVersionOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreRemoveVersionOptions.html)

> 示例代码

> 构造历史版本删除选项

```lua
-- @runtime server
local options = DataStoreRemoveVersionOptions.New()
options.WithKeyInfo = true
print('是否返回 KeyInfo:', options.WithKeyInfo)
```
