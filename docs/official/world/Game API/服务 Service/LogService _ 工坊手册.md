# LogService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[LogService]**（7 函数 / 1 事件）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[LogService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LogService.html) 是全局日志服务，提供分级日志输出、自定义消息类型记录、历史记录查询、清空和实时消息事件。

## 适用场景

用于开发调试和运行时监控：输出普通、信息、警告或错误日志，附加可选结构化上下文，并通过 MessageOut 或 GetLogHistory 观察日志。

## 使用要点

通过 game:GetService("LogService") 获取服务；调用 Output、Info、Warn、Error 时传入消息并按需省略 context，调用 Log 时额外指定 Enums.MessageType。GetLogHistory 返回 [LogRecord](https://u5-creator.s3.game.163.com/manual/se/game_api/data/LogRecord.html) 数组。

## 注意事项

[LogService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LogService.html) 提供日志输出与查询。GetLogHistory 返回 [LogRecord](https://u5-creator.s3.game.163.com/manual/se/game_api/data/LogRecord.html) 数组，每条记录包含 Message、[MessageType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/MessageType.html)、Timestamp 与可选的 Context 字段；字段名称大小写敏感。Output、Info、Warn、Error、Log 的 context 参数均可省略。

## 代码示例

### 先监听日志事件再输出日志

```lua
-- @runtime client
local LogService = game:GetService('LogService')

LogService.MessageOut:Once(function(message, messageType)
    print('收到日志:', message, tostring(messageType))
end)

LogService:Info('这是一条测试信息')

local history = LogService:GetLogHistory()
print('历史日志数量:', #history)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (1)

### MessageOut

签名：`MessageOut(message: String, messageType: MessageType)` 触发：`local`

当 [LogService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LogService.html) 输出任意日志消息时触发，携带消息内容和消息类型。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `message` | `String` | 日志消息内容 |
| `messageType` | [MessageType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/MessageType.html) | 日志类型枚举值 |

> 示例代码

> 监听下一条日志输出

```lua
-- @runtime client
local LogService = game:GetService('LogService')

LogService.MessageOut:Once(function(message, messageType)
    print('收到日志:', message, tostring(messageType))
end)

LogService:Info('触发一条日志', { source = 'demo' })
```

## 函数 (7)

### Output

签名：`Output(message: String, context?: Map) -> void`

输出一条普通输出级别的日志消息，可附带可选的上下文信息。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `message` | `String` | 日志消息 |
| `context?` | `Map` | 结构化上下文数据 |

**返回值** `void`

> 示例代码

> 先监听再输出普通日志

```lua
-- @runtime client
local LogService = game:GetService('LogService')

LogService.MessageOut:Once(function(message, messageType)
    print('捕获到日志:', message, tostring(messageType))
end)

LogService:Output('系统启动完成', { module = 'core' })
```

### Info

签名：`Info(message: String, context?: Map) -> void`

输出一条信息级别的日志消息，可附带可选的上下文信息。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `message` | `String` | 日志消息 |
| `context?` | `Map` | 结构化上下文数据 |

**返回值** `void`

> 示例代码

> 先监听再输出信息日志

```lua
-- @runtime client
local LogService = game:GetService('LogService')

LogService.MessageOut:Once(function(message, messageType)
    print('捕获到信息日志:', message, tostring(messageType))
end)

LogService:Info('玩家登录成功', { userId = 12345, level = 10 })
```

### Warn

签名：`Warn(message: String, context?: Map) -> void`

输出一条警告级别的日志消息，可附带可选的上下文信息。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `message` | `String` | 日志消息 |
| `context?` | `Map` | 结构化上下文数据 |

**返回值** `void`

> 示例代码

> 先监听再输出警告日志

```lua
-- @runtime client
local LogService = game:GetService('LogService')

LogService.MessageOut:Once(function(message, messageType)
    print('捕获到警告日志:', message, tostring(messageType))
end)

LogService:Warn('该接口将在下个版本移除', { api = 'oldMethod' })
```

### Error

签名：`Error(message: String, context?: Map) -> void`

输出一条错误级别的日志消息，可附带可选的上下文信息。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `message` | `String` | 日志消息 |
| `context?` | `Map` | 结构化上下文数据 |

**返回值** `void`

> 示例代码

> 先监听再输出错误日志

```lua
-- @runtime client
local LogService = game:GetService('LogService')

LogService.MessageOut:Once(function(message, messageType)
    print('捕获到错误日志:', message, tostring(messageType))
end)

LogService:Error('网络连接超时', { requestId = 'req-001' })
```

### Log

签名：`Log(messageType: MessageType, message: String, context?: Map) -> void`

输出一条指定类型的日志消息，可附带可选的上下文信息。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `messageType` | [MessageType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/MessageType.html) | 日志类型枚举值 |
| `message` | `String` | 日志消息 |
| `context?` | `Map` | 结构化上下文数据 |

**返回值** `void`

> 示例代码

> 先监听再输出指定类型日志

```lua
-- @runtime client
local LogService = game:GetService('LogService')

LogService.MessageOut:Once(function(message, messageType)
    print('捕获到指定类型日志:', message, tostring(messageType))
end)

LogService:Log(Enums.MessageType.MessageWarning, '自定义警告', { reason = '测试' })
```

### GetLogHistory

签名：`GetLogHistory() -> Array&lt;LogRecord&gt; (历史记录数组，每条包含 Message, MessageType, Timestamp, Context)`

获取日志服务中已输出的日志历史记录列表，返回一个数组，每个元素为一条日志记录，包含日志消息、日志类型、时间戳和上下文信息。

**返回值** Array<[LogRecord](https://u5-creator.s3.game.163.com/manual/se/game_api/data/LogRecord.html)> (历史记录数组，每条包含 Message, [MessageType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/MessageType.html), Timestamp, Context)

> 示例代码

> 读取日志历史

```lua
-- @runtime client
local LogService = game:GetService('LogService')
local history = LogService:GetLogHistory()  -- 返回日志数组
for i, entry in ipairs(history) do
    print(string.format('[%d] %s: %s', i, tostring(entry.MessageType), entry.Message))
end
```

### ClearOutput

签名：`ClearOutput() -> void`

清除 [LogService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LogService.html) 中所有已输出的日志历史记录。

**返回值** `void`

> 示例代码

> 清空日志历史

```lua
-- @runtime client
local LogService = game:GetService('LogService')

LogService:Output('第一条日志', {})
LogService:Warn('第二条警告', {})
LogService:ClearOutput()

local history = LogService:GetLogHistory()
print('历史记录数量:', #history)
```
