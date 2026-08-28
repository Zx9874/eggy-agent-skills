# ChatStyle

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → ChatStyle

[ChatStyle](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ChatStyle.html) 枚举定义当前客户端聊天 UI 的经典面板与头顶气泡显示组合。

## 适用场景

客户端需要切换本地聊天界面外观时，将命名枚举成员传给 Players:SetChatStyle。

## 使用要点

在客户端通过 game:GetService("Players"):SetChatStyle(Enums.ChatStyle.Classic) 等调用设置当前客户端的显示样式。

## 注意事项

该调用用于当前客户端聊天 UI，不应描述为一次客户端调用即可修改所有玩家的显示。枚举值必须通过 Enums.ChatStyle 命名空间引用。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `ClassicAndBubble` | 经典聊天 + 头顶气泡 |
| `1` | `Classic` | 仅经典聊天 |
| `2` | `Bubble` | 仅头顶气泡 |
