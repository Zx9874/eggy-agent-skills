# Connection

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html) 是事件订阅的句柄，代表一次有效的事件监听连接。它由 Signal:Connect() 返回，用于在不再需要时取消监听，防止内存泄漏。

## 适用场景

当需要监听某个事件（如属性变化、玩家加入）时，通过 Signal:Connect() 获取 [Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html) 实例，并在处理完毕后调用 Disconnect() 取消订阅。

## 使用要点

通过 Signal:Connect() 获取 [Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html) 实例，例如 local conn = unit:GetPropertyChangedSignal("Icon"):Connect(handler)。在不再需要监听时调用 conn:Disconnect() 取消连接。

## 注意事项

[Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html) 是事件订阅的句柄，由 Signal:Connect() 返回，不可直接构造。在不再需要监听时调用 Disconnect() 取消订阅，避免内存泄漏；尤其注意临时监听（如按回合订阅的事件）必须在回合结束时 Disconnect。示例代码必须自包含：通过 Signal:Connect() 获取实例，禁止使用未声明的 player/character/unit 场景变量。

## 代码示例

### 按业务生命周期管理事件连接

```lua
-- @runtime client
local Players = game:GetService('Players')
local connection = nil

local function startListening()
    connection = Players.PlayerAdded:Connect(function(player)
        print('玩家加入:', player:GetName())
    end)
end

local function stopListening()
    if connection ~= nil then
        connection:Disconnect()
        connection = nil
    end
end

startListening()
-- 在回合或界面生命周期结束时调用 stopListening()
```

## 函数 (1)

### Disconnect

签名：`Disconnect() -> void`

断开当前连接，停止接收该连接所监听的事件。

**返回值** `void`

> 示例代码

> 在生命周期结束时取消事件订阅

```lua
-- @runtime client
local Players = game:GetService('Players')
local connection = nil
connection = Players.PlayerAdded:Connect(function(player)
    print('玩家加入:', player:GetName())
end)

local function stopListening()
    connection:Disconnect()
end

-- 在不再需要接收 PlayerAdded 时调用 stopListening()
```
