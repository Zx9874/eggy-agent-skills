# SocialService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[SocialService]**（2 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

社交服务，作为好友邀请、分享等社交玩法的基础入口，当前向开发者公开的核心能力是基于队伍 ID 查询队员信息：既支持异步获取队伍的结构化信息，也支持同步取得队伍下的玩家对象列表，便于实现组队联动等场景。

## 适用场景

在组队玩法中，服务端需要根据玩家所在的队伍 ID 查询同队玩家，以便实现“与好友组队”“传送到队友房间”等联动功能。

## 使用要点

先通过 game:GetService("SocialService") 获取服务实例，再从玩家对象取得真实的队伍 ID，随后以该 ID 为参数调用 GetPartyAsync 获取队伍信息，或调用 GetPlayersByPartyId 直接取得玩家数组。

## 注意事项

[SocialService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/SocialService.html) 当前公开能力只有队伍查询。GetPartyAsync 是异步方法，必须在协程中调用；GetPlayersByPartyId 是同步方法。两者都依赖真实 Player:GetPartyId() 返回或由可信业务流程传入的 partyId（String），不要使用伪造的固定队伍 ID。GetPartyAsync 的成员信息可能含预留服务器访问凭据，只按业务需要使用，禁止写入日志或对客户端公开。

## 代码示例

### 查询在线玩家所在队伍

```lua
-- @runtime server
local SocialService = game:GetService('SocialService')
local Players = game:GetService('Players')
local Task = game:GetService('Task')
local player = Players:GetPlayers()[1]
if player == nil then return end
local partyId = player:GetPartyId()
if partyId == nil or partyId == '' then
    print('当前玩家未加入队伍')
    return
end

for _, partyPlayer in ipairs(SocialService:GetPlayersByPartyId(partyId)) do
    print('当前 Space 内的队友:', partyPlayer:GetName())
end
Task:Spawn(function()
    print('完整队伍信息:', SocialService:GetPartyAsync(partyId))
end)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (2)

### GetPartyAsync

签名：`GetPartyAsync(partyId: String) -> Table | nil (队伍成员信息字典 &#123; [UserId] = &#123; mmo_map_id, server_instance_id, reserved_server_access_code &#125; &#125;)`

异步获取指定队伍的成员传送信息，返回一个字典，键为玩家 UserId，值为包含地图 ID、服务器实例 ID 和预留服务器访问码的表格。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `partyId` | `String` | 队伍 Id |

**返回值** `Table | nil` (队伍成员信息字典 { [UserId] = { mmo\_map\_id, server\_instance\_id, reserved\_server\_access\_code } })

> 示例代码

> 协程中查询队伍信息

```lua
-- @runtime server
local SocialService = game:GetService('SocialService')
local Players = game:GetService('Players')
local Task = game:GetService('Task')
Task:Spawn(function()
    local player = Players:GetPlayers()[1]
    if player == nil then return end
    local partyId = player:GetPartyId()
    if partyId == nil or partyId == '' then
        print('当前玩家未加入队伍')
        return
    end
    local partyInfo = SocialService:GetPartyAsync(partyId)
    print('队伍信息:', partyInfo)
end)
```

### GetPlayersByPartyId

签名：`GetPlayersByPartyId(partyId: String) -> Array&lt;Player&gt; | nil (同队伍的在线玩家列表)`

根据传入的队伍 ID，获取当前 Space 内同队伍且处于在线状态的玩家列表。该接口仅服务端可调用。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `partyId` | `String` | 队伍 Id |

**返回值** Array<[Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)> | nil (同队伍的在线玩家列表)

> 示例代码

> 查询在线玩家的当前队友

```lua
-- @runtime server
local SocialService = game:GetService('SocialService')
local player = game:GetService('Players'):GetPlayers()[1]
if player == nil then return end
local partyId = player:GetPartyId()
if partyId == nil or partyId == '' then return end
for _, partyPlayer in ipairs(SocialService:GetPlayersByPartyId(partyId)) do
    print('当前 Space 内的队友:', partyPlayer:GetName())
end
```
