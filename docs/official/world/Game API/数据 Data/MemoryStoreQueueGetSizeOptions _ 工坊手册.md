# MemoryStoreQueueGetSizeOptions

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `server` |

[MemoryStoreQueueGetSizeOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueGetSizeOptions.html) 用于配置 MemoryStoreQueue:GetSizeAsync 方法的可选参数，控制是否在计算队列大小时排除不可见元素。通过设置 ExcludeInvisible 字段，可以灵活调整统计范围，满足不同业务场景的需求。

## 适用场景

在需要获取内存存储队列的当前大小时，若希望忽略那些暂时不可见的元素（例如处于处理中或已标记删除但未彻底移除的项），可创建此配置对象并传入 GetSizeAsync 方法。

## 使用要点

通过 MemoryStoreQueueGetSizeOptions.New() 或 [MemoryStoreQueueGetSizeOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueGetSizeOptions.html)() 创建实例，设置 ExcludeInvisible 为 true 或 false，然后作为参数调用 MemoryStoreQueue:GetSizeAsync(options)。

## 注意事项

所有字段默认为 nil，表示未显式设置时采用默认行为。该类型仅作为配置参数使用，不应在外部长期持有或修改其内部状态。

## 代码示例

### 排除不可见项后统计队列大小

```lua
-- @runtime server
local Task = game:GetService("Task")
Task:Spawn(function()
    local MemoryStoreService = game:GetService('MemoryStoreService')
    local queue = MemoryStoreService:GetQueue('match_queue', 30)

    local options = MemoryStoreQueueGetSizeOptions.New()
    options.ExcludeInvisible = true
    local visibleSize = queue:GetSizeAsync(options)
    print('可见队列项数量:', visibleSize)
end)
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `ExcludeInvisible` | `Bool` | `-` | 是否在获取队列大小时排除不可见的元素。 |

## 函数 (1)

### New

签名：`New() -> MemoryStoreQueueGetSizeOptions`

构造一个新的 [MemoryStoreQueueGetSizeOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueGetSizeOptions.html) 实例，用于配置队列大小查询的选项。

**返回值** [MemoryStoreQueueGetSizeOptions](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueueGetSizeOptions.html)

> 示例代码

> 调用示例

```lua
-- @runtime server
local result = MemoryStoreQueueGetSizeOptions.New()  -- 返回 MemoryStoreQueueGetSizeOptions
if result ~= nil then
    print("调用成功，结果: " .. tostring(result))
end
```
