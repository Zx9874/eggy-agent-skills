# RemoteEvent

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

远程事件用于客户端与服务端之间的异步单向通信，支持服务端向指定客户端或全部客户端发送消息，也支持客户端向服务端发送消息。通过匹配的事件名称在两端建立通道，并借助 FireServer、FireClient、FireAllClients 触发，由 OnServerEvent、OnClientEvent 接收。

## 适用场景

在需要客户端请求服务端执行权威逻辑（如开箱、移动校验）或服务端向玩家推送通知（如全服公告、个人奖励）时使用。典型模式是客户端调用 FireServer 传递请求，服务端在 OnServerEvent 中处理后用 FireClient 或 FireAllClients 回发结果。

## 使用要点

先通过 RemoteEvent.New("事件名") 创建事件对象，并在服务端与客户端使用相同名称获取。服务端对事件对象连接 OnServerEvent 接收客户端消息，客户端调用 FireServer(参数) 发起请求；服务端需要广播时调用 FireAllClients 或 FireClient(玩家, 参数)，客户端再连接 OnClientEvent 处理回包。

## 注意事项

[RemoteEvent](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RemoteEvent.html) 用于客户端与服务端之间的事件通信。真实可用方法仅有：FireServer/FireClient/FireAllClients/OnServerEvent/OnClientEvent。注意：本类型没有 GetAllPlayers、GetPlayers 方法（那是 [Players](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Players.html) 服务的职责）——请勿在 [RemoteEvent](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RemoteEvent.html) 示例中调用不相关服务的方法。当前版本不支持直接传递 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 参数，请拆分为 position([Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)) 与 rotation([Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)/[Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)) 等可序列化字段，或转换为 table 后再传递。服务端必须把 OnServerEvent 的 args 视为不可信客户端输入，校验类型、取值范围和玩家权限后才能修改权威状态。

## 代码示例

### 客户端发送事件，服务端监听

```lua
-- @runtime client
local remoteEvent = RemoteEvent.New('RoundStateChanged')
remoteEvent:FireServer({ state = 'Ready' })

-- 服务端脚本中使用 remoteEvent.OnServerEvent 监听该事件
```

## 事件 (2)

### OnServerEvent

签名：`OnServerEvent(player: Player, args?: Any)` 触发：`local`

服务端监听客户端消息的信号事件。当客户端向该远程事件发送消息后，服务端会触发此事件，回调中携带发送消息的玩家对象以及客户端传送的数据参数。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 触发事件的玩家 |
| `args?` | `Any` | 事件参数 |

> 示例代码

> 服务端监听客户端事件

```lua
-- @runtime server
local remoteEvent = RemoteEvent.New('RoundStateChanged')
remoteEvent.OnServerEvent:Once(function(player, args)
    if type(args) ~= 'table' or args.state ~= 'Ready' then
        return  -- 拒绝类型或取值不符合约定的客户端输入
    end
    -- 继续前还应按业务规则校验 player 是否有权修改回合状态
    print('收到已校验状态:', player, args.state)
end)
```

### OnClientEvent

签名：`OnClientEvent(args?: Any)` 触发：`local`

当服务端通过 FireAllClients 或 FireClient 发送事件时，在客户端触发此信号。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `args?` | `Any` | 事件参数 |

> 示例代码

> 客户端监听服务端事件

```lua
-- @runtime client
local remoteEvent = RemoteEvent.New('RoundStateChanged')
remoteEvent.OnClientEvent:Once(function(args)
    print('服务端广播:', args and args.state)
end)
```

## 函数 (4)

### New

签名：`New(eventName: String) -> RemoteEvent (新创建的 RemoteEvent 实例)`

创建一个新的 [RemoteEvent](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RemoteEvent.html) 实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventName` | `String` | 事件名称，用于标识该远程事件 |

**返回值** [RemoteEvent](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RemoteEvent.html) (新创建的 [RemoteEvent](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RemoteEvent.html) 实例)

> 示例代码

> 创建远程事件通道

```lua
-- @runtime client
local remoteEvent = RemoteEvent.New('RoundStateChanged')
print('远程事件:', tostring(remoteEvent))
```

### FireAllClients

签名：`FireAllClients(args?: Any) -> void`

从服务端向所有客户端广播事件。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `args?` | `Any` | 事件参数 |

**返回值** `void`

> 示例代码

> 服务端向所有客户端广播

```lua
-- @runtime server
local remoteEvent = RemoteEvent.New('RoundStateChanged')
remoteEvent:FireAllClients({ state = 'Started' })
```

### FireClient

签名：`FireClient(player: Player, args?: Any) -> void`

从服务端向指定玩家客户端发送事件的方法。调用时传入目标玩家对象与需要传递的数据，即可将事件定向发送给该玩家。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 目标玩家 |
| `args?` | `Any` | 事件参数 |

**返回值** `void`

> 示例代码

> 服务端向指定客户端发送事件

```lua
-- @runtime server
local Players = game:GetService('Players')
local remoteEvent = RemoteEvent.New('PrivateMessage')
local player = Players:GetPlayers()[1]
if player ~= nil then
    remoteEvent:FireClient(player, { text = 'hello' })
end
```

### FireServer

签名：`FireServer(args?: Any) -> void`

从客户端向服务端发送事件。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `args?` | `Any` | 事件参数 |

**返回值** `void`

> 示例代码

> 客户端向服务端发送事件

```lua
-- @runtime client
local remoteEvent = RemoteEvent.New('RoundStateChanged')
remoteEvent:FireServer({ state = 'Ready' })
```
