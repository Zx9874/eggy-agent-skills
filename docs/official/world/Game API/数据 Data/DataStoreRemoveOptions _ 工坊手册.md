# DataStoreRemoveOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

DataStore:RemoveAsync 的可选参数类型，可控制删除时是否返回键元信息、是否永久删除，以及是否要求当前版本匹配指定前置版本。

## 适用场景

在需要精确控制数据删除行为时使用，例如永久删除玩家存档、在删除前校验数据版本以防止并发冲突，或获取被删除键的元数据信息。

## 使用要点

先构造 [DataStoreRemoveOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreRemoveOptions.html)，再按需设置 WithKeyInfo、PermanentlyRemove 或 DependPrevVersion，最后作为第二个参数传入 DataStore:RemoveAsync。

## 注意事项

未设置的字段保持 nil，表示沿用 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 实例默认行为；DependPrevVersion 可用于乐观锁删除，避免误删已被其它流程更新的数据。

## 代码示例

### 在文档沙盒中永久删除并返回 KeyInfo

```lua
-- @runtime server
local Task = game:GetService("Task")
local dataStoreService = game:GetService("DataStoreService")
local dataStore = dataStoreService:GetDataStore("DocumentationSandbox")
local options = DataStoreRemoveOptions.New()
options.PermanentlyRemove = true
options.WithKeyInfo = true
Task:Spawn(function()
    -- 仅对已确认可清理的文档沙盒键执行永久删除
    local value, keyInfo = dataStore:RemoveAsync("cleanup_demo", options)
    print("删除值:", value, "版本:", keyInfo and keyInfo.Version)
end)
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `WithKeyInfo` | `Bool` | `-` | 是否在返回结果中附带键信息（version, created/modified time, UserIds, Metas 等键元数据）。 |
| `PermanentlyRemove` | `Bool` | `-` | 控制是否永久删除键，而非软删除（标记为已删除但保留版本历史）。 |
| `DependPrevVersion` | `String` | `-` | 指定一个版本号字符串，仅当要删除的键的当前版本与此版本号一致时才执行删除操作，用于实现乐观锁机制。 |

## 函数 (1)

### New

签名：`New() -> DataStoreRemoveOptions`

创建一个新的 [DataStoreRemoveOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreRemoveOptions.html) 实例，用于配置数据存储移除操作的可选参数。

**返回值** [DataStoreRemoveOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreRemoveOptions.html)

> 示例代码

> 构造安全的删除选项

```lua
-- @runtime server
local options = DataStoreRemoveOptions.New()
options.WithKeyInfo = true
options.PermanentlyRemove = false
print('是否返回 KeyInfo:', options.WithKeyInfo)
```
