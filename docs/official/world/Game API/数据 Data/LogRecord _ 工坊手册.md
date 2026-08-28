# LogRecord

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[LogRecord](https://u5-creator.s3.game.163.com/manual/se/game_api/data/LogRecord.html) 是 LogService:GetLogHistory 返回的单条历史日志记录。

## 适用场景

用于读取已写入 [LogService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LogService.html) 历史记录中的消息、类型、记录时间和结构化上下文。

## 使用要点

调用 LogService:GetLogHistory() 取得数组后逐条读取 Message、MessageType、Timestamp 和可选的 Context；[LogRecord](https://u5-creator.s3.game.163.com/manual/se/game_api/data/LogRecord.html) 由日志服务返回，不由作者构造。

## 注意事项

字段名称大小写敏感。Timestamp 是日志写入历史时的服务器时间，单位秒；Context 为可选的 Map<String, Any>。

## 代码示例

### 读取结构化日志记录

```lua
-- @runtime client
local LogService = game:GetService("LogService")
for _, record in ipairs(LogService:GetLogHistory()) do
    print(record.Timestamp, record.MessageType, record.Message)
    if record.Context ~= nil then
        print("日志上下文:", record.Context)
    end
end
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Message` | `String` | `-` | 日志消息内容。 |
| `MessageType` | [MessageType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/MessageType.html) | `-` | 日志类型枚举值。 |
| `Timestamp` | `Float` | `-` | 写入历史时的服务器时间，单位秒。 |
| `Context?` | `Map` | `-` | 可选的结构化上下文数据，类型为 Map<String, Any>。 |

## 关联类型

* [MessageType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/MessageType.html)
