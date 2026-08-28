# FriendShipService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

好友服务，负责在游戏内查询两名玩家之间的好友关系，并支持向指定玩家发起添加好友的请求。查询结果通过异步回调返回，而发起请求的接口仅提交好友申请，不负责确认申请结果。

## 适用场景

在需要判断两名玩家是否为好友，或为玩家提供添加好友入口的功能中，先通过游戏服务接口获取该服务实例，再调用公开方法完成查询或发起申请。

## 使用要点

先通过 game:GetService("FriendShipService") 获取服务实例，再调用 IsPlayerFriendsWithAsync 传入玩家、目标玩家标识和回调函数，在回调中处理查询结果；需要发起好友申请时调用 AddFriendWith 传入当前玩家和目标玩家标识。

## 注意事项

IsPlayerFriendsWithAsync 的结果通过回调异步返回；AddFriendWith 只发起好友请求，不提供完成回调，也不表示对方已同意。

## 代码示例

### 查询业务传入的目标用户

```lua
-- @runtime client
local FriendShipService = game:GetService('FriendShipService')
local Players = game:GetService('Players')

local function checkFriend(targetUserId)
    local player = Players.LocalPlayer
    if player == nil or targetUserId == nil or targetUserId == '' then return end
    FriendShipService:IsPlayerFriendsWithAsync(player, targetUserId, function(isFriend)
        print('是否为好友:', isFriend)
    end)
end

-- 调用方应把玩家列表或业务输入中的真实 UserId 传给 checkFriend
```

### 向业务传入的目标用户发起好友请求

```lua
-- @runtime client
local FriendShipService = game:GetService('FriendShipService')
local Players = game:GetService('Players')

local function addFriend(targetUserId)
    local player = Players.LocalPlayer
    if player == nil or targetUserId == nil or targetUserId == '' then return end
    FriendShipService:AddFriendWith(player, targetUserId)
end

-- 调用方应把玩家列表或业务输入中的真实 UserId 传给 addFriend
```

## 函数 (2)

### IsPlayerFriendsWithAsync

签名：`IsPlayerFriendsWithAsync(player: Player, userId: String, checkCallback: Function) -> void`

异步查询指定玩家是否是指定 UserId 的好友，查询结果通过回调函数返回。

⚙ 参数 userId 是目标玩家的 UserId 字符串（不是 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 对象）；第二个参数 checkCallback 是异步结果回调，回调签名为 function(isFriend: Bool)。结果不会通过返回值给出，必须在回调内处理。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 指定玩家，必须在当前场景中 |
| `userId` | `String` | 目标玩家的UserId |
| `checkCallback` | `Function` | 查询结果回调函数 |

**返回值** `void`

> 示例代码

> 查询业务传入的目标用户

```lua
-- @runtime client
local FriendShipService = game:GetService('FriendShipService')
local Players = game:GetService('Players')

local function checkFriend(targetUserId)
    local player = Players.LocalPlayer
    if player == nil or targetUserId == nil or targetUserId == '' then return end
    FriendShipService:IsPlayerFriendsWithAsync(player, targetUserId, function(isFriend)
        print('是否为好友:', isFriend)
    end)
end

-- 调用方应把玩家列表或业务输入中的真实 UserId 传给 checkFriend
```

### AddFriendWith

签名：`AddFriendWith(player: Player, userId: String) -> void`

向目标用户发起好友请求；调用成功不表示对方已经同意或双方已经成为好友。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 指定玩家，必须在当前场景中 |
| `userId` | `String` | 目标玩家的UserId |

**返回值** `void`

> 示例代码

> 向业务传入的目标用户发起好友请求

```lua
-- @runtime client
local FriendShipService = game:GetService('FriendShipService')
local Players = game:GetService('Players')

local function addFriend(targetUserId)
    local player = Players.LocalPlayer
    if player == nil or targetUserId == nil or targetUserId == '' then return end
    FriendShipService:AddFriendWith(player, targetUserId)
end

-- 调用方应把玩家列表或业务输入中的真实 UserId 传给 addFriend
```
