# TextChatService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[TextChatService]**（8 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[TextChatService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TextChatService.html) 管理游戏内文字聊天频道、玩家进出频道、消息发送以及聊天界面的显隐控制。

## 适用场景

用于需要服务端创建或移除自定义聊天频道、把玩家加入指定频道、发送系统或频道消息，以及客户端控制聊天按钮和官方频道显示状态的场景。

## 使用要点

服务端调用 AddCustomTextChannel、EnterTextChannel、LeaveTextChannel、SendMessage 等频道与消息接口；客户端调用 SetOfficialTextChannelVisible、SetChatButtonVisible 调整本地聊天 UI 展示。两类接口不要混用运行环境。

## 注意事项

聊天相关接口的调用环境区分服务端与客户端，混用会导致无效果或报错。GetTextChannelInfo 当前只公开返回 Array，未公开数组项字段结构；不要依赖 info.name/info.type 等未声明字段。2026-08-11 当前编辑器运行时在客户端调用 GetTextChannelInfo 会触发内部 append 错误，服务端调用可用，因此示例固定放在服务端。

## 代码示例

### 完整聊天流程：创建频道→玩家进入→收发消息→UI 可见性

```lua
-- @runtime server
-- 【服务端脚本】创建频道、玩家进出、消息发送必须在服务端调用
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

-- 1. 创建自定义频道（创建后需玩家进入才能收发）
local channelName = "队伍频道"
TextChatService:AddCustomTextChannel(channelName)

-- 2. 让当前及后续加入的玩家进入频道并发送欢迎消息
local function joinChannel(player)
    TextChatService:EnterTextChannel(player, channelName)
    TextChatService:SendMessage(player, channelName, "欢迎进入队伍频道")
    print(player:GetName() .. " 已进入 " .. channelName)
end
Players.PlayerAdded:Connect(joinChannel)
for _, player in ipairs(Players:GetPlayers()) do
    joinChannel(player)
end

-- 注意：频道创建后仍需聊天面板 UI 入口才能被玩家感知
-- 如需自定义入口，需配合 EUIManager 创建聊天控件

-- 【客户端脚本】控制官方频道可见性与聊天按钮（必须在客户端调用）
-- local TextChatService = game:GetService("TextChatService")
-- -- 显示官方全体频道
-- TextChatService:SetOfficialTextChannelVisible("All", true)
-- -- 显示聊天按钮
-- TextChatService:SetChatButtonVisible(true)

-- 查询当前所有频道信息（服务端/客户端均可）
local channelInfos = TextChatService:GetTextChannelInfo()
print("当前频道数量:", #channelInfos)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (8)

### AddCustomTextChannel

签名：`AddCustomTextChannel(channelName: String) -> void`

添加一个自定义聊天频道。

⚙ 调用环境：服务端。频道创建后需有聊天面板 UI 入口才会被玩家感知。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `channelName` | `String` | 频道名称 |

**返回值** `void`

> 示例代码

> 在服务端添加自定义频道

```lua
-- @runtime server
local TextChatService = game:GetService('TextChatService')
local channelName = '队伍频道'
TextChatService:AddCustomTextChannel(channelName)
print('已提交频道创建:', channelName)
```

### RemoveCustomTextChannel

签名：`RemoveCustomTextChannel(channelName: String) -> void`

移除一个自定义聊天频道。

⚙ 调用环境：服务端。移除频道会影响后续进入和收发消息逻辑。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `channelName` | `String` | 频道名称 |

**返回值** `void`

> 示例代码

> 在服务端移除自定义频道

```lua
-- @runtime server
local TextChatService = game:GetService('TextChatService')
local channelName = '临时频道'
TextChatService:AddCustomTextChannel(channelName)
TextChatService:RemoveCustomTextChannel(channelName)
print('已提交频道移除:', channelName)
```

### SendMessage

签名：`SendMessage(player: Player, channelName: String, message: String) -> void`

以指定玩家的身份向指定名称的文本聊天频道发送一条消息。

⚙ 调用环境：服务端。在客户端调用不会发送消息。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `channelName` | `String` | 频道名称 |
| `message` | `String` | 消息内容 |

**返回值** `void`

> 示例代码

> 向已加入自定义频道的玩家发送消息

```lua
-- @runtime server
local TextChatService = game:GetService('TextChatService')
local Players = game:GetService('Players')
local player = Players:GetPlayers()[1]
if player == nil then return end
local channelName = '队伍频道'
TextChatService:AddCustomTextChannel(channelName)
TextChatService:EnterTextChannel(player, channelName)
TextChatService:SendMessage(player, channelName, '欢迎进入队伍频道')
```

### EnterTextChannel

签名：`EnterTextChannel(player: Player, channelName: String) -> void`

让指定玩家进入指定名称的文本聊天频道，使其能够接收并参与该频道的聊天。

⚙ 调用环境：服务端。目标频道应已创建。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `channelName` | `String` | 频道名称 |

**返回值** `void`

> 示例代码

> 让在线玩家进入已创建频道

```lua
-- @runtime server
local TextChatService = game:GetService('TextChatService')
local player = game:GetService('Players'):GetPlayers()[1]
if player == nil then return end
local channelName = '活动频道'
TextChatService:AddCustomTextChannel(channelName)
TextChatService:EnterTextChannel(player, channelName)
```

### LeaveTextChannel

签名：`LeaveTextChannel(player: Player, channelName: String) -> void`

让指定玩家退出指定名称的文本聊天频道，退出后不再接收该频道的聊天内容。

⚙ 调用环境：服务端。玩家应已进入目标频道。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `channelName` | `String` | 频道名称 |

**返回值** `void`

> 示例代码

> 让玩家离开已加入频道

```lua
-- @runtime server
local TextChatService = game:GetService('TextChatService')
local player = game:GetService('Players'):GetPlayers()[1]
if player == nil then return end
local channelName = '临时频道'
TextChatService:AddCustomTextChannel(channelName)
TextChatService:EnterTextChannel(player, channelName)
TextChatService:LeaveTextChannel(player, channelName)
```

### SetOfficialTextChannelVisible

签名：`SetOfficialTextChannelVisible(channelName: String, visible: Bool) -> void`

设置官方聊天频道的可见性。

⚙ 调用环境：客户端。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `channelName` | `String` | 频道名称 |
| `visible` | `Bool` | 是否可见 |

**返回值** `void`

> 示例代码

> 切换官方频道可见性（延迟恢复）

```lua
-- @runtime client
local TextChatService = game:GetService("TextChatService")
local Task = game:GetService("Task")

-- 先隐藏“全部”官方频道
TextChatService:SetOfficialTextChannelVisible("All", false)
print("官方频道 All 已隐藏")

-- 3 秒后恢复显示
Task:Delay(3, function()
    TextChatService:SetOfficialTextChannelVisible("All", true)
    print("官方频道 All 已恢复显示")
end)
```

### SetChatButtonVisible

签名：`SetChatButtonVisible(visible: Bool) -> void`

设置聊天按钮的可见性。

⚙ 调用环境：客户端。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `visible` | `Bool` | 是否可见 |

**返回值** `void`

> 示例代码

> 切换聊天按钮可见性（延迟恢复）

```lua
-- @runtime client
local TextChatService = game:GetService("TextChatService")
local Task = game:GetService("Task")

-- 先隐藏聊天按钮
TextChatService:SetChatButtonVisible(false)
print("聊天按钮已隐藏")

-- 3 秒后恢复显示
Task:Delay(3, function()
    TextChatService:SetChatButtonVisible(true)
    print("聊天按钮已恢复显示")
end)
```

### GetTextChannelInfo

签名：`GetTextChannelInfo() -> Array<Any> (频道信息列表；数组项字段结构尚未公开，应按不透明值处理)`

获取当前所有文本聊天频道的信息列表。

⚙ 当前公开 Meta 只声明返回 Array，未声明每个数组项的字段结构；可读取数组长度或把条目作为不透明值处理。当前编辑器运行时的客户端实现会触发内部 append 错误，暂时从服务端调用。

**返回值** `Array<Any>` (频道信息列表；数组项字段结构尚未公开，应按不透明值处理)

> 示例代码

> 获取频道信息数组

```lua
-- @runtime server
local TextChatService = game:GetService('TextChatService')
local channelInfos = TextChatService:GetTextChannelInfo()
print('当前频道数量:', #channelInfos)
for index, info in ipairs(channelInfos) do
    print('频道条目', index, tostring(info))
end
```
