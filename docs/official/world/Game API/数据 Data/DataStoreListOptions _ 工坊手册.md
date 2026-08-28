# DataStoreListOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[DataStoreListOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListOptions.html) 是 [DataStoreService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/DataStoreService.html) 列表接口的可选参数容器，用于控制列 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 集合时是否排除已删除集合。

## 适用场景

通过 ListDataStoresAsync 或 ListOrderedDataStoresAsync 分页遍历集合时，设置 ExcludeDeleted 过滤软删除集合。

## 使用要点

使用 DataStoreListOptions.New(...) 或 [DataStoreListOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListOptions.html)(...) 创建配置对象，设置 ExcludeDeleted 后作为列表接口的 options 参数传入。

## 注意事项

可通过 DataStoreListOptions.New(...) 或 [DataStoreListOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListOptions.html)(...) 直接构造。该对象只承载 [DataStoreService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/DataStoreService.html) 列表接口的可选参数。

## 代码示例

### 构造 DataStore 列表选项

```lua
-- @runtime server
local options = DataStoreListOptions.New()
options.ExcludeDeleted = true
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `ExcludeDeleted` | `Bool` | `-` | 是否在列出 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 时排除已删除的 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html)。 |

## 函数 (1)

### New

签名：`New() -> DataStoreListOptions`

构造一个新的 [DataStoreListOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListOptions.html) 实例，用于配置数据存储列表操作的可选参数。

**返回值** [DataStoreListOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreListOptions.html)

> 示例代码

> 构造选项并列出 DataStore

```lua
-- @runtime server
local DataStoreService = game:GetService('DataStoreService')
local Task = game:GetService('Task')
local options = DataStoreListOptions.New()
options.ExcludeDeleted = true

Task:Spawn(function()
    local pages = DataStoreService:ListDataStoresAsync('', 10, '', options)
    print('当前页集合数:', #pages:GetCurrentPage())
end)
```
