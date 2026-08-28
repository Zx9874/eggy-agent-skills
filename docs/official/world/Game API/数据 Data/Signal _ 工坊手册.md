# Signal

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html) 是用于同端内部模块间的事件信号，支持持续监听、单次监听以及触发时向所有监听者转发参数。它提供 Connect、Once 和 Fire 方法，可实现灵活的发布订阅通信。

## 适用场景

常用于在模块间传递事件通知，例如在游戏逻辑中当某个状态变化时通知其他模块执行相应处理。

## 使用要点

通过 Signal.New() 或 [Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html)() 创建实例，调用 Connect 或 Once 注册监听函数，在需要时调用 Fire 触发事件并传递参数。监听不再需要时，应调用返回的 [Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html) 对象的 Disconnect 方法断开连接。

## 注意事项

[Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html) 仅限同端通信，不可跨客户端或服务器。Connect/Once 返回 [Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html)；持续监听不再需要时必须 Disconnect。Fire 会把传入的零个或多个参数原样转发给监听函数。

## 代码示例

### 创建信号并触发监听

```lua
-- @runtime client
-- 创建一个信号实例
local mySignal = Signal.New()

-- 定义监听函数
local function onEvent(msg, value)
    print("收到事件: " .. msg .. ", 值: " .. tostring(value))
end

-- 连接监听器
local conn = mySignal:Connect(onEvent)

-- 触发信号，传递参数
mySignal:Fire("测试消息", 42)

-- 断开连接
conn:Disconnect()
```

### 使用 Once 监听单次事件

```lua
-- @runtime client
-- 创建信号
local signal = Signal.New()

-- 使用 Once 监听，触发一次后自动断开
signal:Once(function(data)
    print("单次监听收到: " .. tostring(data))
end)

-- 触发信号
signal:Fire("一次性数据")

-- 再次触发不会调用已断开的监听器
signal:Fire("第二次触发")
```

## 函数 (4)

### New

签名：`New() -> Signal (新创建的 Signal 实例)`

创建一个新的 [Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html) 实例。

**返回值** [Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html) (新创建的 [Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html) 实例)

> 示例代码

> 创建信号并连接/触发

```lua
-- @runtime client
local sig = Signal.New()
local conn = sig:Connect(function(msg)
    print('收到信号:', msg)
end)
sig:Fire('hello')  -- 触发，回调打印 '收到信号: hello'
conn:Disconnect()
```

### Connect

签名：`Connect(func: Function) -> Connection (可用于断开监听的连接句柄)`

为信号连接一个监听函数，当信号被触发时该函数会被调用。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `func` | `Function` | 事件触发时调用的监听函数 |

**返回值** [Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html) (可用于断开监听的连接句柄)

> 示例代码

> 调用示例

```lua
-- @runtime client
local signal = Signal.New()
local func = function() end  -- Function
local result = signal:Connect(func)  -- 返回 Connection
if result ~= nil then
    print("调用成功，结果: " .. tostring(result))
end
```

### Once

签名：`Once(func: Function) -> Connection (可用于提前断开监听的连接句柄)`

为信号连接一个只触发一次的监听函数，当信号第一次被触发时该函数会被调用，之后自动断开连接。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `func` | `Function` | 第一次事件触发时调用的监听函数 |

**返回值** [Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html) (可用于提前断开监听的连接句柄)

> 示例代码

> 单次监听信号

```lua
-- @runtime client
-- 构造 Signal 实例
local signal = Signal()
-- 使用 Once 连接只触发一次的监听函数
signal:Once(function(msg)
    print("单次收到:", msg)
end)
-- 第一次触发，监听函数执行
signal:Fire("第一次触发")
-- 第二次触发，监听函数不再执行
signal:Fire("第二次触发")
```

### Fire

签名：`Fire(args?: Any) -> void`

触发信号，所有通过 Connect 或 Once 连接的监听函数将被调用，并接收传入的参数。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `args?` | `Any` | 零个或多个事件参数，会按原顺序转发给每个监听函数。 |

**返回值** `void`

> 示例代码

> 触发信号并在结束后释放持续监听

```lua
-- @runtime client
local sig = Signal.New()
local conn = sig:Connect(function(a, b)
    print('收到参数:', a, b)
end)
sig:Fire('hello', 123)
conn:Disconnect()
```
