# Players

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[Players]**（2 属性 / 5 函数 / 2 事件）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

玩家服务，负责管理当前对局中的所有玩家对象，是获取玩家列表、按用户编号查找玩家、根据角色反查玩家的统一入口；同时提供玩家加入与离开事件，并在客户端暴露本地玩家属性，便于访问玩家自身的界面与信息。

## 适用场景

在需要获取玩家列表、监听玩家进出对局，或通过本地玩家访问其界面层级（如 [PlayerGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PlayerGui.html)）的场景中，通过 game:GetService("Players") 获取该服务后使用。

## 使用要点

先调用 game:GetService("Players") 获取服务实例；在客户端可直接读取 LocalPlayer 属性获取本地玩家，进而访问其 [PlayerGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PlayerGui.html)；需要枚举玩家时调用 GetPlayers，按用户编号查找可调用 GetPlayerByUserId，监听玩家加入或离开则分别连接 PlayerAdded 与 PlayerRemoving 事件。

## 注意事项

[Players](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Players.html) 是玩家管理服务。LocalPlayer 是当前客户端的玩家对象（仅客户端可用）。注意 GetUserThumbnailAsync 实际返回双值 (contentUrl: String, isReady: Bool)，isReady=false 表示头像尚未加载完成；签名只声明了 String 是 Meta 数据遗漏。GetPlayerFromCharacter 通过角色 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 反查玩家对象。

## 代码示例

### 遍历在线玩家并监听下一位加入

```lua
-- @runtime client
local Players = game:GetService('Players')

for _, player in ipairs(Players:GetPlayers()) do
    print('当前玩家:', player:GetName())
end

Players.PlayerAdded:Once(function(player)
    print('新玩家加入:', player:GetName())
end)
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `LocalPlayer` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | `-` | 仅客户端可用的本地玩家对象。 |
| `CharacterAutoLoads` | `Bool` | `true` | 控制游戏是否自动加载玩家角色单位。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)

## 事件 (2)

### PlayerAdded

签名：`PlayerAdded(player: Player)` 触发：`local`

当有新玩家加入服务器时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |

> 示例代码

> 示例：监听新玩家加入事件

```lua
-- @runtime client
local players = game:GetService("Players")

-- 订阅新玩家加入事件
players.PlayerAdded:Once(function(player)
    -- 回调参数 player 即为新加入的玩家对象，在回调内直接消费
    print("新玩家加入: " .. player:GetName())
end)
```

### PlayerRemoving

签名：`PlayerRemoving(player: Player)` 触发：`local`

当有玩家即将离开服务器时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |

> 示例代码

> 示例：监听玩家即将离开事件

```lua
-- @runtime client
local players = game:GetService("Players")

-- 订阅玩家离开事件
players.PlayerRemoving:Once(function(player)
    -- 回调参数 player 为即将离开的玩家对象，在回调内直接消费
    print("玩家即将离开: " .. player:GetName())
end)
```

## 函数 (5)

### GetPlayers

签名：`GetPlayers() -> Array&lt;Player&gt; (所有玩家列表)`

获取所有玩家的列表。

**返回值** Array<[Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)> (所有玩家列表)

> 示例代码

> 遍历所有在线玩家

```lua
-- @runtime client
local Players = game:GetService('Players')
for _, player in ipairs(Players:GetPlayers()) do
    print('玩家:', player.Name, player.UserId)
end
```

### GetPlayerByUserId

签名：`GetPlayerByUserId(userId: String) -> Player | nil (玩家)`

通过玩家编号获取对应的玩家对象。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `userId` | `String` | 玩家编号 |

**返回值** [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | nil (玩家)

> 示例代码

> 使用在线玩家的 UserId 执行查询

```lua
-- @runtime client
local Players = game:GetService('Players')
local target = Players:GetPlayers()[1]
if target == nil then
    print('当前没有在线玩家可供查询')
    return
end

local player = Players:GetPlayerByUserId(tostring(target.UserId))
if player ~= nil then
    print('找到玩家:', player:GetName())
end
```

### GetPlayerFromCharacter

签名：`GetPlayerFromCharacter(character: EggyUnit) -> Player | nil (玩家)`

通过角色对象获取对应的玩家对象。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `character` | [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) | 角色对象 |

**返回值** [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | nil (玩家)

> 示例代码

> 通过角色安全反查玩家

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then
    print('当前运行环境没有 LocalPlayer')
    return
end

local character = localPlayer.Character
if character == nil then
    print('本地玩家角色尚未创建')
    return
end

local player = Players:GetPlayerFromCharacter(character)
if player ~= nil then
    print('玩家名称:', player:GetName())
end
```

### GetUserThumbnailAsync

签名：`GetUserThumbnailAsync(userId: String, thumbnailType: ThumbnailType, thumbnailSize: ThumbnailSize) -> String, Bool (头像内容地址与是否已准备好)`

异步获取指定玩家的头像缩略图地址。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `userId` | `String` | 玩家编号 |
| `thumbnailType` | [ThumbnailType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ThumbnailType.html) | 头像类型 |
| `thumbnailSize` | [ThumbnailSize](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ThumbnailSize.html) | 头像尺寸 |

**返回值** `String, Bool` (头像内容地址与是否已准备好)

> 示例代码

> 获取玩家头像（协程内双返回值）

```lua
-- @runtime client
local Players = game:GetService('Players')
local Task = game:GetService('Task')
-- GetUserThumbnailAsync 是异步方法，必须在协程中调用；实际返回双值：contentUrl, isReady
Task:Spawn(function()
    local player = Players:GetPlayers()[1]
    if player == nil then return end
    local contentUrl, isReady = Players:GetUserThumbnailAsync(
        tostring(player.UserId), Enums.ThumbnailType.HeadShot, Enums.ThumbnailSize.Size420x420)
    if isReady then
        print('头像 URL:', contentUrl)
    else
        print('头像尚未加载')
    end
end)
```

### SetChatStyle

签名：`SetChatStyle(chatStyle: ChatStyle) -> void`

设置聊天消息的显示样式。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `chatStyle` | [ChatStyle](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ChatStyle.html) | 聊天显示样式 |

**返回值** `void`

> 示例代码

> 设置聊天显示样式

```lua
-- @runtime client
-- 获取玩家服务
local players = game:GetService("Players")

-- 设置聊天样式为经典与气泡混合模式
players:SetChatStyle(Enums.ChatStyle.ClassicAndBubble)

print("聊天样式已设置为经典与气泡混合模式")
```
