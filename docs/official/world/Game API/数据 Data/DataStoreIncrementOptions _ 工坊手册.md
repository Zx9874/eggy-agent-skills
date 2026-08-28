# DataStoreIncrementOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[DataStoreIncrementOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreIncrementOptions.html) 是 DataStore:IncrementAsync 的可选参数容器，用于设置自增初始值、元数据、用户 ID、KeyInfo 返回和前置版本依赖。

## 适用场景

在服务端对计数器、积分或库存数量做原子自增时，使用该对象补充默认初始值、元数据或乐观锁条件。

## 使用要点

使用 DataStoreIncrementOptions.New(...) 或 [DataStoreIncrementOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreIncrementOptions.html)(...) 创建配置对象，按需设置属性，并调用 SetUserIds、AddUserId、SetMetaDatas、UpdateMetaDatas 或 SetMetaData 管理附加信息，再传入 DataStore:IncrementAsync。

## 注意事项

可通过 DataStoreIncrementOptions.New(...) 或 [DataStoreIncrementOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreIncrementOptions.html)(...) 直接构造。[DataStoreIncrementOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreIncrementOptions.html) 的字段优先级高于 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 初始化时的 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html)；nil 字段表示继承实例默认值。DependPrevVersion 用于乐观锁控制，版本不匹配时自增会失败。

## 代码示例

### 构造 IncrementAsync 选项

```lua
-- @runtime server
local options = DataStoreIncrementOptions.New()
options.WithKeyInfo = true
options.DefaultInitValue = 100
options:SetMetaData('source', 'daily_reward')
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `WithKeyInfo` | `Bool` | `-` | 是否在返回结果中附带键信息（version, created/modified time, UserIds, Metas 等键元数据）。 |
| `KeepOldMetas` | `Bool` | `-` | 更新时是否保留旧的元数据。 |
| `DefaultInitValue` | `Int` | `-` | 当键不存在时的默认初始化值，自增操作将在此基础上进行。 |
| `DependPrevVersion` | `String` | `-` | 依赖的前置版本号，只有数据的当前版本与此版本一致时才允许自增。 |

## 函数 (8)

### New

签名：`New() -> DataStoreIncrementOptions`

创建一个新的 [DataStoreIncrementOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreIncrementOptions.html) 实例，用于配置数据存储递增操作的选项。

**返回值** [DataStoreIncrementOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreIncrementOptions.html)

> 示例代码

> 构造 IncrementAsync 选项

```lua
-- @runtime server
local options = DataStoreIncrementOptions.New()
options.WithKeyInfo = true
options.DefaultInitValue = 100
options:SetMetaData('source', 'daily_reward')
print('默认初始值:', options.DefaultInitValue)
```

### GetUserIds

签名：`GetUserIds() -> Table (用户ID列表, 未设置时返回 nil)`

返回当前增量操作选项中已设置的用户ID列表。

**返回值** `Table` (用户ID列表, 未设置时返回 nil)

> 示例代码

> 读取用户 ID 列表

```lua
-- @runtime server
local Players = game:GetService('Players')
local player = Players:GetPlayers()[1]
if player == nil then return end
local options = DataStoreIncrementOptions.New()
options:SetUserIds({ tostring(player.UserId) })
for _, userId in ipairs(options:GetUserIds() or {}) do
    print(userId)
end
```

### SetUserIds

签名：`SetUserIds(userIds: Table) -> void`

整体替换用户ID列表，传入一个表来设置所有关联的用户ID。

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
local options = DataStoreIncrementOptions.New()
options:SetUserIds({ tostring(player.UserId) })
```

### AddUserId

签名：`AddUserId(userId: String) -> void`

向选项实例中添加一个用户ID，用于标记该操作关联的玩家。

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
local options = DataStoreIncrementOptions.New()
options:AddUserId(tostring(player.UserId))
```

### GetMetaDatas

签名：`GetMetaDatas() -> Table (元数据字典, 未设置时返回 nil)`

获取当前增量操作选项中已设置的用户自定义元数据字典。

**返回值** `Table` (元数据字典, 未设置时返回 nil)

> 示例代码

> 读取元数据字典

```lua
-- @runtime server
local options = DataStoreIncrementOptions.New()
options:SetMetaData('source', 'daily_reward')
local metas = options:GetMetaDatas() or {}
print(metas.source)
```

### SetMetaDatas

签名：`SetMetaDatas(dict: Table) -> void`

整体替换用户自定义元数据字典，传入一个表来设置所有元数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `dict` | `Table` | 元数据字典 |

**返回值** `void`

> 示例代码

> 整体替换元数据字典

```lua
-- @runtime server
local options = DataStoreIncrementOptions.New()
options:SetMetaDatas({ source = 'daily_reward', season = 's1' })
```

### UpdateMetaDatas

签名：`UpdateMetaDatas(dict: Table) -> void`

合并更新用户自定义元数据，传入一个表，已存在的键会被覆盖，不存在的键会被添加。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `dict` | `Table` | 要合并的元数据 |

**返回值** `void`

> 示例代码

> 合并更新元数据字典

```lua
-- @runtime server
local options = DataStoreIncrementOptions.New()
options:SetMetaDatas({ source = 'daily_reward' })
options:UpdateMetaDatas({ season = 's1' })
```

### SetMetaData

签名：`SetMetaData(name: String, value: String) -> void`

设置单个用户自定义元数据键值对。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 元数据键名 |
| `value` | `String` | 元数据键值 |

**返回值** `void`

> 示例代码

> 设置单个元数据

```lua
-- @runtime server
local options = DataStoreIncrementOptions.New()
options:SetMetaData('source', 'daily_reward')
```
