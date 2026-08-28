# TextChatChannelType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `String`
* **继承链**: `String` → TextChatChannelType

[TextChatChannelType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TextChatChannelType.html) 枚举定义文字聊天的官方频道类型，目前包含全体频道与阵营频道两类。

## 适用场景

当聊天接口、配置或业务回调明确需要区分官方聊天频道范围时，可使用该枚举表达全体频道或阵营频道。

## 使用要点

通过 Enums.TextChatChannelType.All 或 Enums.TextChatChannelType.Camp 引用成员，用于与实际获得的频道类型字段比较或传给明确声明需要 [TextChatChannelType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TextChatChannelType.html) 的接口。

## 注意事项

TextChatService:AddCustomTextChannel 的公开签名只接收 channelName 字符串，不接收 [TextChatChannelType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TextChatChannelType.html)；不要把该枚举当作 AddCustomTextChannel 的额外参数传入。

## 枚举值

| 名称 | 说明 |
| --- | --- |
| `All` | 所有 |
| `Camp` | 阵营 |
