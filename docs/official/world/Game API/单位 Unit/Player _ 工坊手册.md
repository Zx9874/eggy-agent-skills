# Player

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[Player]**（4 属性 / 14 函数 / 10 事件）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

玩家对象代表局内的一位玩家，包含唯一标识、所属阵营、玩家界面和当前操控单位等核心属性。提供玩家状态查询与交互方法，例如获取名称、VIP 状态、地图点赞与收藏状态、粉丝团信息、网络延迟，以及踢出玩家、重置角色、加载角色和好友相关操作。同时通过角色创建与移除、聊天、传送、挂机、断线等事件驱动游戏逻辑，也可作为网络消息通信的标识。

## 适用场景

典型场景包括：服务端按玩家标识获取指定玩家后执行权限校验或管理操作；客户端获取本地玩家后监听角色加载完成事件，并在初始化完成后开始游戏逻辑。

## 使用要点

从玩家服务中获取玩家实例，客户端使用本地玩家属性，服务端按玩家标识获取指定玩家。获取后可直接读取玩家属性，使用查询方法获取玩家信息，通过角色属性访问当前操控单位，并在角色创建事件中处理角色切换；还可通过自定义事件信号接口监听自定义游戏事件。

## 注意事项

[Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 不能自行创建，应从 [Players](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Players.html) 获取。Character 可能尚未加载，访问前应判空或监听 CharacterAdded。客户端启动入口中的 Players.LocalPlayer 及其自定义属性信号代理也可能尚未完成初始化；当前运行包有脚本启动后立即调用 LocalPlayer:GetAttributeChangedSignal() 无法正常工作的反馈。需要监听初始阶段属性时，应先确认 LocalPlayer 可用并延迟注册（反馈实测约 1 秒），同时主动读取一次当前属性值，不能只依赖后续变化事件。

## 代码示例

### 客户端获取本地玩家名称

```lua
-- @runtime client
local players = game:GetService("Players")
local player = players.LocalPlayer
if player ~= nil then
    print("本地玩家名称:", player:GetName())
end
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `UserId` | `String` | `-` | 玩家唯一标识。 |
| `Character` | [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) | `-` | 玩家当前所控制的角色单位。 |
| `PlayerGui` | [PlayerGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PlayerGui.html) | `-` | 玩家的 PlayerGui 对象。 |
| `Camp` | [Camp](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Camp.html) | `-` | 玩家当前所属的阵营。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Camp](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Camp.html)
* [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html)
* [PlayerGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PlayerGui.html)

## 事件 (10)

### CharacterAdded

签名：`CharacterAdded(character: EggyUnit)` 触发：`local`

当玩家的角色创建完成时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `character` | [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) | 玩家角色 |

> 示例代码

> 监听角色创建

```lua
-- @runtime client
local players = game:GetService("Players")
local player = players.LocalPlayer
if not player then
    return
end

player.CharacterAdded:Once(function(character)
    local pos = character:GetPosition()
    print(player:GetName() .. " 角色已创建，位置：", pos)
end)
```

### CharacterRemoving

签名：`CharacterRemoving(character: EggyUnit)` 触发：`local`

当玩家的角色即将被销毁时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `character` | [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) | 玩家角色 |

> 示例代码

> 监听角色销毁

```lua
-- @runtime client
local players = game:GetService("Players")
local player = players.LocalPlayer
if not player then
    return
end

player.CharacterRemoving:Once(function(character)
    print(player:GetName() .. " 的角色正在销毁")
end)
```

### OnTeleport

签名：`OnTeleport(teleportState: TeleportState, mapId: String, spawnName: String)` 触发：`local`

当玩家发生传送且传送状态变化时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `teleportState` | [TeleportState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TeleportState.html) | 传送状态 |
| `mapId` | `String` | 目标地图编号 |
| `spawnName` | `String` | 出生点名称 |

> 示例代码

> 监听传送状态变化

```lua
-- @runtime client
local players = game:GetService("Players")
local player = players.LocalPlayer
if not player then
    return
end

player.OnTeleport:Once(function(teleportState, mapId, spawnName)
    print(player:GetName() .. " 传送状态：" .. tostring(teleportState) .. "，目标地图：" .. mapId .. "，出生点：" .. spawnName)
end)
```

### Idled

签名：`Idled(afkTime: Float)` 触发：`local`

当玩家无输入操作超过 2 分钟后触发，并在之后定期重复触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `afkTime` | `Float` | 玩家无输入操作的时间（秒） |

> 示例代码

> 监听玩家挂机

```lua
-- @runtime client
local players = game:GetService("Players")
local player = players.LocalPlayer
if not player then
    return
end

player.Idled:Once(function(afkTime)
    local playerName = player:GetName()
    print(playerName .. " 已挂机 " .. afkTime .. " 秒")
end)
```

### LoseClient

签名：`LoseClient()` 触发：`local`

当玩家客户端掉线或失去连接时触发。

⚙ 该事件用于服务端观察目标玩家客户端掉线或失联；不要在即将掉线的 LocalPlayer 客户端中依赖回调继续执行。

> 示例代码

> 服务端监听玩家客户端失联

```lua
-- @runtime server
local players = game:GetService("Players")
players.PlayerAdded:Connect(function(player)
    player.LoseClient:Once(function()
        print("玩家客户端失联:", player:GetName())
    end)
end)
```

### Chatted

签名：`Chatted(message: String, channelName: String)` 触发：`local`

当玩家发送聊天消息时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `message` | `String` | 聊天文本内容 |
| `channelName` | `String` | 所在频道名 |

> 示例代码

> 监听玩家聊天消息

```lua
-- @runtime client
local players = game:GetService("Players")
local player = players.LocalPlayer
if not player then
    return
end

player.Chatted:Once(function(message, channelName)
    local playerName = player:GetName()
    print(playerName .. " 在 " .. channelName .. " 频道发言：" .. message)
end)
```

### MapLikeChanged

签名：`MapLikeChanged(oldValue: Int, newValue: Int)` 触发：`local`

当玩家对当前地图的点赞状态发生变化时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `oldValue` | `Int` | 变更前状态（0=未点赞，1=已点赞） |
| `newValue` | `Int` | 变更后状态（0=未点赞，1=已点赞） |

> 示例代码

> 监听地图点赞状态变化

```lua
-- @runtime client
local players = game:GetService("Players")
local player = players.LocalPlayer
if not player then
    return
end

player.MapLikeChanged:Once(function(oldValue, newValue)
    local playerName = player:GetName()
    print(playerName .. " 地图点赞状态从 " .. oldValue .. " 变为 " .. newValue)
end)
```

### MapFavoriteChanged

签名：`MapFavoriteChanged(oldValue: Int, newValue: Int)` 触发：`local`

当玩家对当前地图的收藏状态发生变化时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `oldValue` | `Int` | 变更前状态（0=未收藏，1=已收藏） |
| `newValue` | `Int` | 变更后状态（0=未收藏，1=已收藏） |

> 示例代码

> 监听地图收藏状态变化

```lua
-- @runtime client
local players = game:GetService("Players")
local player = players.LocalPlayer
if not player then
    return
end

player.MapFavoriteChanged:Once(function(oldValue, newValue)
    local playerName = player:GetName()
    print(playerName .. " 地图收藏状态从 " .. oldValue .. " 变为 " .. newValue)
end)
```

### AuthorSubscribeChanged

签名：`AuthorSubscribeChanged(oldValue: Int, newValue: Int)` 触发：`local`

当玩家对当前地图作者的订阅状态发生变更时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `oldValue` | `Int` | 变更前状态（0=未订阅，1=已订阅） |
| `newValue` | `Int` | 变更后状态（0=未订阅，1=已订阅） |

> 示例代码

> 监听作者订阅状态变化

```lua
-- @runtime client
local players = game:GetService("Players")
local player = players.LocalPlayer
if not player then
    return
end

player.AuthorSubscribeChanged:Once(function(oldValue, newValue)
    local playerName = player:GetName()
    print(playerName .. " 对作者的订阅状态从 " .. oldValue .. " 变为 " .. newValue)
end)
```

### InFanClubChanged

签名：`InFanClubChanged(oldValue: Int, newValue: Int)` 触发：`local`

当玩家粉丝团的加入状态发生变化时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `oldValue` | `Int` | 变更前状态（0=未加入，1=已加入） |
| `newValue` | `Int` | 变更后状态（0=未加入，1=已加入） |

> 示例代码

> 监听粉丝团状态变化

```lua
-- @runtime client
local players = game:GetService("Players")
local player = players.LocalPlayer
if not player then
    return
end

player.InFanClubChanged:Once(function(oldValue, newValue)
    local playerName = player:GetName()
    print(playerName .. " 粉丝团状态从 " .. oldValue .. " 变为 " .. newValue)
end)
```

## 函数 (14)

### GetName

签名：`GetName() -> String (玩家名称)`

获取玩家名称。

**返回值** `String` (玩家名称)

> 示例代码

> 获取玩家名称

```lua
-- @runtime client
-- 获取本地玩家
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer == nil then return end

-- 获取玩家名称
local playerName = localPlayer:GetName()

print("当前玩家名称:", playerName)
```

### Kick

签名：`Kick() -> void`

将玩家踢出游戏。

⚙ 调用环境：服务端。通过 [Players](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Players.html) 服务获取目标 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 后调用，用于服务器侧踢出指定玩家。

**返回值** `void`

> 示例代码

> 踢出指定玩家

```lua
-- @runtime server
local players = game:GetService("Players")

players.PlayerAdded:Once(function(player)
    print("踢出玩家:", player:GetName())
    player:Kick()
end)
```

### IsVip

签名：`IsVip() -> Bool (是否是乐园会员)`

检查玩家是否为乐园会员。

**返回值** `Bool` (是否是乐园会员)

> 示例代码

> 检查是否为乐园会员

```lua
-- @runtime client
-- 获取本地玩家
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer == nil then return end

-- 检查是否为乐园会员
local isVip = localPlayer:IsVip()

if isVip then
    print("当前玩家是乐园会员")
else
    print("当前玩家不是乐园会员")
end
```

### IsMapLiked

签名：`IsMapLiked() -> Bool (是否点赞本地图)`

检查玩家是否点赞了当前地图。

**返回值** `Bool` (是否点赞本地图)

> 示例代码

> 检查是否点赞本地图

```lua
-- @runtime client
-- 获取本地玩家
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer == nil then return end

-- 检查是否点赞了当前地图
local isLiked = localPlayer:IsMapLiked()

if isLiked then
    print("已点赞当前地图")
else
    print("未点赞当前地图")
end
```

### IsMapFavorited

签名：`IsMapFavorited() -> Bool (是否收藏本地图)`

检查玩家是否收藏了当前地图。

**返回值** `Bool` (是否收藏本地图)

> 示例代码

> 检查是否收藏本地图

```lua
-- @runtime client
-- 获取本地玩家
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer == nil then return end

-- 检查是否收藏了当前地图
local isFavorited = localPlayer:IsMapFavorited()

if isFavorited then
    print("已收藏当前地图")
else
    print("未收藏当前地图")
end
```

### IsInFanClub

签名：`IsInFanClub() -> Bool (是否加入了粉丝团)`

检查玩家是否加入了当前地图作者的粉丝团。

**返回值** `Bool` (是否加入了粉丝团)

> 示例代码

> 检查是否加入粉丝团

```lua
-- @runtime client
-- 获取本地玩家
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer == nil then return end

-- 检查是否加入了粉丝团
local inFanClub = localPlayer:IsInFanClub()

if inFanClub then
    print("已加入粉丝团")
else
    print("未加入粉丝团")
end
```

### GetPartyId

签名：`GetPartyId() -> String (组队标识)`

获取蛋仔岛上的组队标识。

**返回值** `String` (组队标识)

> 示例代码

> 获取组队标识

```lua
-- @runtime client
-- 获取本地玩家
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer == nil then return end

-- 获取蛋仔岛组队ID
local partyId = localPlayer:GetPartyId()

print("当前组队ID:", partyId)
```

### GetJoinData

签名：`GetJoinData() -> JoinData (玩家加入数据字典)`

获取玩家加入游戏时携带的数据，返回 [JoinData](https://u5-creator.s3.game.163.com/manual/se/game_api/data/JoinData.html) 对象。

**返回值** [JoinData](https://u5-creator.s3.game.163.com/manual/se/game_api/data/JoinData.html) (玩家加入数据字典)

> 示例代码

> 获取玩家加入数据

```lua
-- @runtime client
-- 获取本地玩家
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer == nil then return end

-- 获取玩家加入游戏时携带的数据
local joinData = localPlayer:GetJoinData()

-- 打印可能存在的字段
if joinData.SourceMapId then
    print("来源地图ID:", joinData.SourceMapId)
end
if joinData.Members then
    print("组队成员:", table.concat(joinData.Members, ", "))
end
if joinData.TeleportData then
    print("传送数据:", joinData.TeleportData)
end
```

### GetNetworkPing

签名：`GetNetworkPing() -> Float (玩家网络延迟)`

获取玩家网络延迟（秒）。

⚙ 当前编辑器运行时在客户端调用会产生 Internal Error warning；服务端应从 Players:GetPlayers() 获取目标 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 后读取网络延迟。

**返回值** `Float` (玩家网络延迟)

> 示例代码

> 在服务端读取玩家网络延迟

```lua
-- @runtime server
local player = game:GetService("Players"):GetPlayers()[1]
if player == nil then return end
print('玩家网络延迟（秒）:', player:GetNetworkPing())
```

### ResetCharacterToSpawnLocation

签名：`ResetCharacterToSpawnLocation(resetCamera: Bool) -> void`

将玩家角色复位到出生点，并可选择是否重置摄像机。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `resetCamera` | `Bool` | 是否重置相机 |

**返回值** `void`

> 示例代码

> 将角色复位到出生点

```lua
-- @runtime client
-- 获取本地玩家
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer == nil then return end

-- 将角色复位到出生点，并重置相机
localPlayer:ResetCharacterToSpawnLocation(true)

print("角色已复位到出生点，相机已重置")
```

### IsFriendsWithAsync

签名：`IsFriendsWithAsync(userId: String, checkCallback: Function) -> void`

异步检查指定玩家是否为当前玩家的好友，结果通过回调函数返回。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `userId` | `String` | 玩家编号 |
| `checkCallback` | `Function` | 检查结果回调 |

**返回值** `void`

> 示例代码

> 检查与另一位在线玩家的好友关系

```lua
-- @runtime client
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer == nil then return end

local target = nil
for _, candidate in ipairs(players:GetPlayers()) do
    if candidate ~= localPlayer then target = candidate break end
end
if target == nil then
    print("当前没有其他在线玩家可供检查")
    return
end

local targetUserId = tostring(target.UserId)
localPlayer:IsFriendsWithAsync(targetUserId, function(isFriend)
    print("好友关系:", target:GetName(), isFriend)
end)
```

### AddFriendWith

签名：`AddFriendWith(userId: String) -> void`

请求添加指定用户为好友。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `userId` | `String` | 玩家编号 |

**返回值** `void`

> 示例代码

> 向另一位在线玩家发起好友请求

```lua
-- @runtime client
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer == nil then return end

local target = nil
for _, candidate in ipairs(players:GetPlayers()) do
    if candidate ~= localPlayer then target = candidate break end
end
if target == nil then
    print("当前没有其他在线玩家可供添加")
    return
end

local targetUserId = tostring(target.UserId)
localPlayer:AddFriendWith(targetUserId)
print("已向玩家发起好友请求:", target:GetName())
```

### LoadCharacterAsync

签名：`LoadCharacterAsync() -> void`

异步加载玩家角色。

⚙ 该方法会异步触发 CharacterAdded；若需要观察加载结果，应先订阅事件再发起加载，避免角色快速创建时错过通知。

**返回值** `void`

> 示例代码

> 异步加载玩家角色并等待创建事件

```lua
-- @runtime client
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer == nil then return end

-- 先监听再加载，避免角色快速创建时错过 CharacterAdded
localPlayer.CharacterAdded:Once(function(character)
    print("角色加载完成:", character.Name)
end)
localPlayer:LoadCharacterAsync()
```

### GetCustomEventSignal

签名：`GetCustomEventSignal(eventName: String) -> Signal (自定义事件信号)`

获取玩家触发的自定义事件信号，用于监听指定名称的自定义事件。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventName` | `String` | 自定义事件名 |

**返回值** [Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html) (自定义事件信号)

> 示例代码

> 获取本地玩家的自定义事件信号

```lua
-- @runtime client
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer == nil then return end
local signal = localPlayer:GetCustomEventSignal("QuestUpdated")
if signal == nil then
    print('自定义事件不存在，请先确认事件名已注册')
    return
end
signal:Connect(function(payload)
    print("任务事件:", payload)
end)
```
