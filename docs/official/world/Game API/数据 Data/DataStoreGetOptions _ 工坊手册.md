# DataStoreGetOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[DataStoreGetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetOptions.html) 是 DataStore:GetAsync 的可选参数容器，用于控制读取时是否返回 KeyInfo、是否排除已删除条目、是否使用缓存和更新时间排序。

## 适用场景

当单次 GetAsync 需要覆盖 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 实例默认选项时，创建 [DataStoreGetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetOptions.html) 并作为第二个参数传入。

## 使用要点

使用 DataStoreGetOptions.New(...) 或 [DataStoreGetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetOptions.html)(...) 创建配置对象，设置需要覆盖的字段；未设置的字段会继续继承 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html) 实例级默认值。

## 注意事项

可通过 DataStoreGetOptions.New(...) 或 [DataStoreGetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetOptions.html)(...) 直接构造。[DataStoreGetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetOptions.html) 是 DataStore:GetAsync 的可选参数容器，优先级高于 [DataStore](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStore.html) 初始化时的 [DataStoreOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreOptions.html)；nil 字段表示继承实例默认值。

## 代码示例

### 构造 GetAsync 选项（启用 KeyInfo 返回）

```lua
-- @runtime server
local options = DataStoreGetOptions.New()
options.WithKeyInfo = true
options.UseCache = false
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `WithKeyInfo` | `Bool` | `-` | 是否在返回结果中附带键信息（version, created/modified time, UserIds, Metas 等键元数据）。 |
| `ExcludeDeleted` | `Bool` | `-` | 是否在读取时排除已标记为删除的条目。 |
| `UseCache` | `Bool` | `-` | 是否允许使用缓存数据。 |
| `UpdateTimeAsc` | `Bool` | `-` | 是否按更新时间升序排列返回的键列表。 |

## 函数 (1)

### New

签名：`New() -> DataStoreGetOptions`

创建一个新的 [DataStoreGetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetOptions.html) 实例，用于配置数据存储读取操作的行为选项。

**返回值** [DataStoreGetOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreGetOptions.html)

> 示例代码

> 调用 DataStoreGetOptions.New 的示例。

```lua
-- @runtime server
local result = DataStoreGetOptions.New()  -- 返回 DataStoreGetOptions
if result ~= nil then
    print("调用成功，结果: " .. tostring(result))
end
```
