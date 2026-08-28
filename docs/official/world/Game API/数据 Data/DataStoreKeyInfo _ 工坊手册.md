# DataStoreKeyInfo

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[DataStoreKeyInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreKeyInfo.html) 是 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 读写操作返回的键信息对象，包含创建/更新时间、版本号、scope、key、元数据、用户 ID 和删除状态。

## 适用场景

启用 WithKeyInfo 后，在 GetAsync、SetAsync、IncrementAsync、RemoveAsync、UpdateAsync 等操作中读取版本号、元数据或用户 ID，用于审计、展示或乐观锁处理。

## 使用要点

在对应 options 中设置 WithKeyInfo=true 后，从 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 方法的额外返回值获得 [DataStoreKeyInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreKeyInfo.html)；读取属性或调用 GetMetaDatas/GetUserIds 获取写入时附加的信息。

## 注意事项

[DataStoreKeyInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreKeyInfo.html) 不可直接构造，必须通过 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 的 API 调用获得。其属性值由服务端填充，只读不可修改。元数据和用户列表需在写入时通过 [DataStoreSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreSetOptions.html) 等选项设置，读取时才能通过 GetMetaDatas 和 GetUserIds 获取。

## 代码示例

### 通过 GetAsync 获取 KeyInfo

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local dataStore = DataStoreService:GetDataStore('PlayerData', 'global')

Task:Spawn(function()
    local options = DataStoreGetOptions.New()
    options.WithKeyInfo = true
    local value, keyInfo = dataStore:GetAsync('player_001', options)
    if keyInfo ~= nil then
        print('版本:', keyInfo.Version, 'scope:', keyInfo.Scope, 'key:', keyInfo.Key)
        print('元数据:', keyInfo:GetMetaDatas())
        print('用户 ID:', keyInfo:GetUserIds())
    end
end)
```

## 属性 (8)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `CreatedTime` | `Int` | `0` | 键的创建时间，以毫秒时间戳表示。 |
| `UpdatedTime` | `Int` | `0` | 键的最后更新时间，以毫秒时间戳表示。 |
| `Version` | `String` | `""` | 键的当前版本号。 |
| `Scope` | `String` | `""` | 键所属的前置域。 |
| `Key` | `String` | `""` | 键的名称。 |
| `Metas` | `Table` | `{}` | 用户自定义的元数据表。 |
| `UserIds` | `Table` | `[]` | 与该键关联的用户 ID 列表。 |
| `IsDeleted` | `Bool` | `false` | 指示该键是否已被删除。 |

## 函数 (2)

### GetMetaDatas

签名：`GetMetaDatas() -> Table (元数据)`

获取该键的元数据字典。

**返回值** `Table` (元数据)

> 示例代码

> 读取 KeyInfo 元数据

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local dataStore = DataStoreService:GetDataStore('PlayerData', 'global')

Task:Spawn(function()
    local options = DataStoreGetOptions.New()
    options.WithKeyInfo = true
    local _, keyInfo = dataStore:GetAsync('player_001', options)
    local metas = keyInfo and keyInfo:GetMetaDatas() or {}
    print(metas.source)
end)
```

### GetUserIds

签名：`GetUserIds() -> Table (用户ID列表)`

获取与该键关联的用户 ID 列表。

**返回值** `Table` (用户ID列表)

> 示例代码

> 读取 KeyInfo 用户 ID

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local dataStore = DataStoreService:GetDataStore('PlayerData', 'global')

Task:Spawn(function()
    local options = DataStoreGetOptions.New()
    options.WithKeyInfo = true
    local _, keyInfo = dataStore:GetAsync('player_001', options)
    for _, userId in ipairs((keyInfo and keyInfo:GetUserIds()) or {}) do
        print(userId)
    end
end)
```
