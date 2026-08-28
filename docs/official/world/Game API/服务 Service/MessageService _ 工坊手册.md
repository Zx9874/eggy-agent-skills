# MessageService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `server` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[MessageService]**（2 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[MessageService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/MessageService.html) 提供跨服务器实时消息发布与订阅能力，通过主题隔离不同消息流。开发者可调用 PublishAsync 向指定主题发送消息，或通过 SubscribeAsync 监听主题并处理回调。消息传递为尽力而为，不保证可靠送达。

## 适用场景

适用于同一地图不同服务器实例间的数据同步或事件通知，例如跨服聊天、全局状态广播。

## 使用要点

通过 game:GetService("MessageService") 获取服务实例。使用 SubscribeAsync 订阅主题并传入回调函数，返回 [Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html) 对象；调用 PublishAsync 向主题发布消息。PublishAsync 为异步方法，建议按异步调用方式在合适的协程上下文中使用。

## 注意事项

[MessageService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/MessageService.html) 用于跨服务器发布/订阅消息（主题隔离）。PublishAsync 是异步方法，必须在协程（Task:Spawn 或 coroutine.wrap）中调用，禁止裸调用。SubscribeAsync 返回 [Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html) 对象，不再需要时调用 :Disconnect 取消订阅，避免泄漏。消息体序列化后不能超过 1KB。注意：SDK 没有 Publish（无 Async 后缀）方法，必须用 PublishAsync。

## 代码示例

### 订阅主题并在协程中发布消息

```lua
-- @runtime server
local MessageService = game:GetService('MessageService')
local Task = game:GetService('Task')
local topic = 'GameEvent'

local connection = MessageService:SubscribeAsync(topic, function(message)
    -- message 的公开类型是 Any；仅按本项目约定解析其结构
    print('收到消息:', tostring(message))
end)

Task:Spawn(function()
    MessageService:PublishAsync(topic, { type = 'Start', data = 100 })
end)

local function stopSubscription()
    if connection ~= nil then
        connection:Disconnect()
        connection = nil
    end
end
-- 在脚本或活动生命周期结束时调用 stopSubscription()
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (2)

### PublishAsync

签名：`PublishAsync(topic: String, message: Any) -> void`

向指定主题发布一条跨服务器消息；所有订阅同一主题的服务器回调都有机会收到该消息。

⚙ PublishAsync 是异步方法，必须在协程中调用；消息交付为尽力而为，不保证可靠送达。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `topic` | `String` | 主题的长度限制: 1-80个字符, 否则将引发错误 |
| `message` | `Any` | 注意: 序列化后大小不能超过1k字节, 否则将引发错误 |

**返回值** `void`

> 示例代码

> 协程中向主题发布消息

```lua
-- @runtime server
local MessageService = game:GetService('MessageService')
local Task = game:GetService('Task')
-- PublishAsync 是异步方法，必须在协程中调用
Task:Spawn(function()
    MessageService:PublishAsync('GameEvent', { type = 'Start', data = 100 })
end)
```

### SubscribeAsync

签名：`SubscribeAsync(topic: String, callback: Function) -> Connection (与信号之间的连接器，可用于取消订阅)`

订阅指定主题；当同一主题收到跨服务器消息时，注册的回调函数会被调用。

⚙ SubscribeAsync 返回 [Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html)；不再需要监听时调用 Disconnect 取消订阅，避免泄漏。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `topic` | `String` | 主题的长度限制: 1-80个字符, 否则将引发错误 |
| `callback` | `Function` | function(message); 注意: 该函数不能是异步函数 |

**返回值** [Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html) (与信号之间的连接器，可用于取消订阅)

> 示例代码

> 订阅主题并在不需要时取消

```lua
-- @runtime server
local MessageService = game:GetService('MessageService')
-- SubscribeAsync 返回 Connection，回调在收到消息时触发
local connection = MessageService:SubscribeAsync('GameEvent', function(message)
    -- message 的公开类型是 Any；仅按本项目约定解析其结构
    print('收到消息:', tostring(message))
end)
-- 保存 connection，并在脚本或活动生命周期结束时调用 connection:Disconnect()
```
