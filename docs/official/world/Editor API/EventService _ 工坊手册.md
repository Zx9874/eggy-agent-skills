# EventService

EventService 事件系统服务，提供事件的注册、注销与触发能力，用于编辑器插件之间的消息通信和编辑器事件监听。

## Overview

EventService 事件系统服务。 提供事件的注册、注销与触发能力，用于编辑器插件之间的消息通信和编辑器事件监听。

**Get by:**

```lua
local service = editor:GetService("EventService")
```

## Public

### On

注册事件回调

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventName` | `String` | 事件名称 |
| `callback` | `Function` | 事件回调函数 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Number` | 注册ID（用于取消注册） |

**示例**

```lua
local service = editor:GetService("EventService")
local eventName = "demo_on_event"

local received
local id = service:On(eventName, function(value) -- 注册回调
    received = value
    print("event fired, value:", value)
end)

service:Fire(eventName, 42)
print("received value:", received)

service:Off(eventName, id)
print("after Off, listeners:", service:GetListenerCount(eventName))
```

### Once

注册一次性事件回调（触发一次后自动注销）

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventName` | `String` | 事件名称 |
| `callback` | `Function` | 事件回调函数（触发一次后自动注销） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Number` | 注册ID |

**示例**

```lua
local service = editor:GetService("EventService")
local eventName = "demo_once_event"

local normalCount = 0
local onceCount = 0
local normalId = service:On(eventName, function()
    normalCount = normalCount + 1
    print("normal fired, count:", normalCount)
end)
local onceId = service:Once(eventName, function() -- 注册一次性回调
    onceCount = onceCount + 1
    print("once fired, count:", onceCount)
end)

service:Fire(eventName)
service:Fire(eventName)

print("result - normal:", normalCount, "once:", onceCount)
service:Off(eventName, normalId)
service:Off(eventName, onceId)
print("after Off, listeners:", service:GetListenerCount(eventName))
```

### Off

取消事件回调

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventName` | `String` | 事件名称 |
| `listenerId` | `Number` | 注册时返回的监听 ID |

**示例**

```lua
local service = editor:GetService("EventService")
local eventName = "demo_off_event"

local fireCount = 0
local id = service:On(eventName, function(value)
    fireCount = fireCount + 1
    print("event fired, value:", value, "count:", fireCount)
end)

service:Fire(eventName, "first")
service:Off(eventName, id) -- 取消注册

service:Fire(eventName, "second")
print("after re-fire, count:", fireCount)
print("listeners:", service:GetListenerCount(eventName))
```

### OffAll

取消某个事件的所有回调

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventName` | `String` | 事件名称 |

**示例**

```lua
local service = editor:GetService("EventService")
local eventName = "demo_offall_event"

local fireCount = 0
service:On(eventName, function()
    fireCount = fireCount + 1
    print("listener 1 fired, count:", fireCount)
end)
service:On(eventName, function()
    print("listener 2 fired")
end)

service:Fire(eventName)
service:OffAll(eventName) -- 取消全部回调

service:Fire(eventName)
print("after OffAll + re-fire, count:", fireCount)
print("listeners:", service:GetListenerCount(eventName))
```

### Fire

触发事件

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventName` | `String` | 事件名称 |
| `args` | `Any` | 传递给回调的可变参数 |

**示例**

```lua
local service = editor:GetService("EventService")
local eventName = "demo_score_event"

local received
local id = service:On(eventName, function(score)
    received = score
    print("event received, score:", score)
end)

service:Fire(eventName, 100) -- 触发事件并携带参数
print("received score:", received)

service:Off(eventName, id)
print("after Off, listeners:", service:GetListenerCount(eventName))
```

### HasListeners

检查某个事件是否有监听者

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventName` | `String` | 事件名称 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否存在监听 |

**示例**

```lua
local service = editor:GetService("EventService")
local eventName = "demo_has_event"

print("before On - has:", service:HasListeners(eventName)) -- 探测监听是否存在

local id = service:On(eventName, function()
    print("event fired")
end)
print("after On - has:", service:HasListeners(eventName))

service:Fire(eventName)

service:Off(eventName, id)
print("after Off - has:", service:HasListeners(eventName))
```

### GetListenerCount

获取某个事件的监听者数量

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventName` | `String` | 事件名称 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Int` | 当前监听数量 |

**示例**

```lua
local service = editor:GetService("EventService")
local eventName = "demo_count_event"

service:On(eventName, function()
    print("listener 1 fired")
end)
service:On(eventName, function()
    print("listener 2 fired")
end)
print("listener count:", service:GetListenerCount(eventName)) -- 统计监听数量

service:Fire(eventName)

service:OffAll(eventName)
print("after OffAll, count:", service:GetListenerCount(eventName))
```
