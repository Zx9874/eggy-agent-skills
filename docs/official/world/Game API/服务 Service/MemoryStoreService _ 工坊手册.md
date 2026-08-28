# MemoryStoreService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `server` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[MemoryStoreService]**（3 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

内存存储服务是服务端专用的高速数据存储方案，提供有序映射、队列和哈希映射三种集合类型。通过该服务可获取对应集合的句柄，进而执行数据的增删改查及原子更新操作。

## 适用场景

典型场景是在服务端脚本中通过 game:GetService("MemoryStoreService") 获取服务实例，然后调用 GetSortedMap、GetQueue 或 GetHashMap 获取集合对象，用于排行榜、消息队列或临时状态缓存。

## 使用要点

先使用 game:GetService("MemoryStoreService") 获取服务实例，再根据需求调用 GetSortedMap("排行榜")、GetQueue("任务队列", 60) 或 GetHashMap("玩家状态") 获取集合句柄，后续在返回的集合对象上调用 SetAsync、GetAsync 等方法进行读写。

## 注意事项

[MemoryStoreService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/MemoryStoreService.html) 仅服务端可用；GetSortedMap/GetQueue/GetHashMap 都只是获取对应集合句柄，后续读写需在返回的集合对象上调用。各方法示例应聚焦当前工厂方法，不要把三种集合重复写成同一段示例。

## 代码示例

### 获取 SortedMap 和 Queue 句柄并验证

```lua
-- @runtime server
-- 获取 MemoryStoreService 服务实例
local memoryStoreService = game:GetService("MemoryStoreService")

-- 获取有序集合句柄
local sortedMapName = "PlayerScores"
local sortedMap = memoryStoreService:GetSortedMap(sortedMapName)

-- 获取队列句柄，设置默认不可见窗口为 60 秒
local queueName = "MatchQueue"
local queueInvisibleExpireSecs = 60
local queue = memoryStoreService:GetQueue(queueName, queueInvisibleExpireSecs)

-- 验证句柄是否成功获取
if sortedMap ~= nil and queue ~= nil then
    print("成功获取 MemoryStore 集合句柄")
    print("SortedMap 名称:", sortedMapName)
    print("Queue 名称:", queueName)
else
    print("获取集合句柄失败")
end
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (3)

### GetSortedMap

签名：`GetSortedMap(name: String) -> MemoryStoreSortedMap (有序集合句柄)`

根据名称获取一个有序集合（SortedMap）的操作句柄。每次调用都会返回一个新的 [MemoryStoreSortedMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMap.html) 实例，用于对该有序集合进行读写操作。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 集合名称 |

**返回值** [MemoryStoreSortedMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMap.html) (有序集合句柄)

> 示例代码

> 获取有序集合句柄

```lua
-- @runtime server
local MemoryStoreService = game:GetService('MemoryStoreService')
local sortedMap = MemoryStoreService:GetSortedMap('season_score')

if sortedMap ~= nil then
    print('SortedMap 句柄已就绪')
end
```

### GetQueue

签名：`GetQueue(name: String, queueInvisibleExpireSecs?: Int) -> MemoryStoreQueue (队列集合句柄)`

根据名称获取一个队列集合（Queue）的操作句柄。每次调用都会返回一个新的 [MemoryStoreQueue](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueue.html) 实例，用于对该队列进行读写操作。可选参数 queueInvisibleExpireSecs 用于设置队列中消息的不可见超时时间（秒）。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 集合名称 |
| `queueInvisibleExpireSecs?` | `Int` | 队列级默认不可见窗口秒数；后续 ReadAsync 在 options 未指定 QueueInvisibleExpireSecs 时使用该值；不传时默认 30 |

**返回值** [MemoryStoreQueue](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueue.html) (队列集合句柄)

> 示例代码

> 获取队列句柄

```lua
-- @runtime server
local MemoryStoreService = game:GetService('MemoryStoreService')
local queue = MemoryStoreService:GetQueue('match_queue', 30)

if queue ~= nil then
    print('Queue 句柄已就绪')
end
```

### GetHashMap

签名：`GetHashMap(name: String) -> MemoryStoreHashMap (哈希集合句柄)`

根据名称获取一个哈希集合（HashMap）的操作句柄。每次调用都会返回一个新的 [MemoryStoreHashMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMap.html) 实例，用于对该集合进行读写操作。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 集合名称 |

**返回值** [MemoryStoreHashMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMap.html) (哈希集合句柄)

> 示例代码

> 获取哈希集合句柄

```lua
-- @runtime server
local MemoryStoreService = game:GetService('MemoryStoreService')
local hashMap = MemoryStoreService:GetHashMap('match_state')

if hashMap ~= nil then
    print('HashMap 句柄已就绪')
end
```
