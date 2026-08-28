# MessageType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → MessageType

日志消息类型枚举，用于区分日志输出的严重程度或类别。它定义了四种标准消息类型：普通输出、信息、警告和错误，供日志系统在记录和过滤时使用。

## 适用场景

在调用 LogService:Log 时指定消息类型，或在订阅 LogService.MessageOut 事件时根据回调参数中的 messageType 进行分支处理。

## 使用要点

通过 Enums.MessageType.MessageOutput 等形式引用成员。调用 LogService:Log 时传入枚举值作为第一个参数，例如 LogService:Log(Enums.MessageType.MessageWarning, "警告信息")。在 MessageOut 事件回调中，第二个参数即为 [MessageType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/MessageType.html) 枚举值，可直接与成员比较。

## 注意事项

枚举值必须通过 Enums.MessageType 命名空间访问，禁止使用数字代替。[MessageType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/MessageType.html) 仅作为参数或事件数据使用，无法直接实例化。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `MessageOutput` | MessageOutput |
| `1` | `MessageInfo` | MessageInfo |
| `2` | `MessageWarning` | MessageWarning |
| `3` | `MessageError` | MessageError |
