# DataStoreSetOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[DataStoreSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreSetOptions.html) 是 DataStore:SetAsync 的可选参数容器，用于设置 KeyInfo 返回、元数据保留策略、前置版本依赖、用户 ID 和自定义元数据。

## 适用场景

服务端写入玩家存档、背包或计数状态时，用该对象附加元数据与用户 ID，或通过 DependPrevVersion 做乐观锁写入。

## 使用要点

使用 DataStoreSetOptions.New(...) 或 [DataStoreSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreSetOptions.html)(...) 创建配置对象，按需设置属性，并调用 SetUserIds、AddUserId、SetMetaDatas、UpdateMetaDatas 或 SetMetaData 管理附加信息，再传入 DataStore:SetAsync。

## 注意事项

可通过 DataStoreSetOptions.New(...) 或 [DataStoreSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreSetOptions.html)(...) 直接构造。[DataStoreSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreSetOptions.html) 的字段优先级高于 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 初始化时的 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html)；nil 字段表示继承实例默认值。DependPrevVersion 用于乐观锁控制，版本不匹配时写入会失败。

## 代码示例

### 构造 SetAsync 选项

```lua
-- @runtime server
local options = DataStoreSetOptions.New()
options.WithKeyInfo = true
options:SetMetaData('source', 'save')
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `WithKeyInfo` | `Bool` | `-` | 是否在返回结果中附带键信息（version, created/modified time, UserIds, Metas 等键元数据）。 |
| `KeepOldMetas` | `Bool` | `-` | 设置更新时是否保留旧的元数据。 |
| `DependPrevVersion` | `String` | `-` | 设置依赖的前置版本号，仅当数据的当前版本与此版本一致时才允许更新。 |

## 函数 (8)

### New

签名：`New() -> DataStoreSetOptions`

创建一个新的 [DataStoreSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreSetOptions.html) 实例，用于配置数据存储写入操作的可选参数。

**返回值** [DataStoreSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreSetOptions.html)

> 示例代码

> 构造 SetAsync 选项

```lua
-- @runtime server
local options = DataStoreSetOptions.New()
options.WithKeyInfo = true
options:SetMetaData('source', 'save')
print('是否返回 KeyInfo:', options.WithKeyInfo)
```

### GetUserIds

签名：`GetUserIds() -> Table (用户ID列表, 未设置时返回 nil)`

获取当前 [DataStoreSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreSetOptions.html) 实例中设置的用户 ID 列表。

**返回值** `Table` (用户ID列表, 未设置时返回 nil)

> 示例代码

> 读取用户 ID 列表

```lua
-- @runtime server
local Players = game:GetService('Players')
local player = Players:GetPlayers()[1]
if player == nil then return end
local options = DataStoreSetOptions.New()
options:SetUserIds({ tostring(player.UserId) })
for _, userId in ipairs(options:GetUserIds() or {}) do
    print(userId)
end
```

### SetUserIds

签名：`SetUserIds(userIds: Table) -> void`

设置用户 ID 列表，整体替换之前添加的所有用户 ID。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `userIds` | `Table` | 用户ID列表 |

**返回值** `void`

> 示例代码

> 整体替换用户 ID 列表

```lua
-- @runtime server
local Players = game:GetService('Players')
local player = Players:GetPlayers()[1]
if player == nil then return end
local options = DataStoreSetOptions.New()
options:SetUserIds({ tostring(player.UserId) })
```

### AddUserId

签名：`AddUserId(userId: String) -> void`

向 [DataStoreSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreSetOptions.html) 实例中添加一个用户 ID，用于标记该数据项与指定用户关联。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `userId` | `String` | 用户ID |

**返回值** `void`

> 示例代码

> 追加单个用户 ID

```lua
-- @runtime server
local Players = game:GetService('Players')
local player = Players:GetPlayers()[1]
if player == nil then return end
local options = DataStoreSetOptions.New()
options:AddUserId(tostring(player.UserId))
```

### GetMetaDatas

签名：`GetMetaDatas() -> Table (元数据字典, 未设置时返回 nil)`

获取当前 [DataStoreSetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreSetOptions.html) 实例中设置的用户自定义元数据字典。

**返回值** `Table` (元数据字典, 未设置时返回 nil)

> 示例代码

> 读取元数据字典

```lua
-- @runtime server
local options = DataStoreSetOptions.New()
options:SetMetaData('source', 'save')
local metas = options:GetMetaDatas() or {}
print(metas.source)
```

### SetMetaDatas

签名：`SetMetaDatas(dict: Table) -> void`

整体替换用户自定义元数据字典，传入的 Table 将完全覆盖之前设置的元数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `dict` | `Table` | 元数据字典 |

**返回值** `void`

> 示例代码

> 整体替换元数据字典

```lua
-- @runtime server
local options = DataStoreSetOptions.New()
options:SetMetaDatas({ source = 'save', season = 's1' })
```

### UpdateMetaDatas

签名：`UpdateMetaDatas(dict: Table) -> void`

合并更新用户自定义元数据，传入的 Table 中的键值对会合并到现有元数据字典中，已存在的 key 会被覆盖。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `dict` | `Table` | 要合并的元数据 |

**返回值** `void`

> 示例代码

> 合并更新元数据字典

```lua
-- @runtime server
local options = DataStoreSetOptions.New()
options:SetMetaDatas({ source = 'save' })
options:UpdateMetaDatas({ season = 's1' })
```

### SetMetaData

签名：`SetMetaData(name: String, value: String) -> void`

设置单个用户自定义元数据键值对，会合并到现有元数据字典中。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 元数据键名 |
| `value` | `String` | 元数据键值 |

**返回值** `void`

> 示例代码

> 设置单个元数据

```lua
-- @runtime server
local options = DataStoreSetOptions.New()
options:SetMetaData('source', 'save')
```
