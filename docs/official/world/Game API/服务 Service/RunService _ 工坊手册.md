# RunService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[RunService]**（4 函数 / 5 事件）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[RunService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/RunService.html) 是引擎运行时服务，负责提供帧循环各阶段的时序事件，并用于判断当前代码所处的运行环境（客户端、服务端或编辑器试玩）。通过它可以在每帧更新逻辑、监听物理模拟前后回调，以及根据 IsClient/IsServer/IsStudio 分流不同端的代码。

## 适用场景

典型场景是在客户端或服务端脚本中获取 [RunService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/RunService.html)，然后监听 Heartbeat 事件来驱动持续更新的逻辑（如角色移动、动画更新），或使用 IsClient/IsServer 判断当前环境以执行不同分支。

## 使用要点

通过 game:GetService("RunService") 获取服务实例。调用 IsClient/IsServer/IsStudio 判断运行环境；使用 RunService.Heartbeat:Connect(function(deltaTime) ... end) 注册每帧回调，deltaTime 为自上一帧以来的时间间隔（秒）。

## 注意事项

Heartbeat 事件当前在客户端与服务端均可监听（用户验证确认），服务端可用于驱动每帧逻辑（deltaTime 单位为秒）。事件在订阅的端本地触发，跨端不会自动同步。IsClient/IsServer/IsStudio 用于在运行时区分当前脚本执行环境，常用于在同一脚本中分流客户端与服务端逻辑。WaitForDebugger 会阻塞当前执行线程直到调试器连接，只应由开发者在已启动调试器的专用调试会话中手工调用，普通示例、自动化和发布跑测不得直接执行。

## 代码示例

### 监听 Heartbeat 并在首帧后断开

```lua
-- @runtime client
local RunService = game:GetService("RunService")

local connection = nil
connection = RunService.Heartbeat:Connect(function(deltaTime, maxTaskCount)
    print(string.format("Heartbeat: deltaTime=%.4f maxTaskCount=%d", deltaTime, maxTaskCount))
    if connection ~= nil then
        connection:Disconnect()
        connection = nil
    end
end)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (5)

### PreSimulation

签名：`PreSimulation(deltaTimeSim: Float)` 触发：`local`

每帧在物理模拟前触发，用于在物理计算前设置力或速度等。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `deltaTimeSim` | `Float` | 物理步长 |

> 示例代码

> 监听 PreSimulation 事件

```lua
-- @runtime client
-- 获取 RunService 服务实例
local runService = game:GetService("RunService")

-- 连接 PreSimulation 事件，每帧在物理模拟前触发
runService.PreSimulation:Once(function(deltaTimeSim)
    -- deltaTimeSim 为物理模拟的时间步长（秒）
    print("PreSimulation deltaTimeSim:", deltaTimeSim)
end)
```

### PostSimulation

签名：`PostSimulation(deltaTimeSim: Float)` 触发：`local`

每帧在物理模拟完成后触发，用于处理物理模拟后的逻辑。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `deltaTimeSim` | `Float` | 物理步长 |

> 示例代码

> 监听 PostSimulation 事件

```lua
-- @runtime client
-- 获取 RunService 服务实例
local runService = game:GetService("RunService")

-- 连接 PostSimulation 事件，每帧在物理模拟完成后触发
runService.PostSimulation:Once(function(deltaTimeSim)
    -- deltaTimeSim 为物理模拟的时间步长（秒）
    print("PostSimulation deltaTimeSim:", deltaTimeSim)
end)
```

### Heartbeat

签名：`Heartbeat(deltaTime: Float, maxTaskCount: Int)` 触发：`local`

每帧逻辑帧更新时触发，提供 deltaTime 和 maxTaskCount 参数。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `deltaTime` | `Float` | 逻辑帧时间长 |
| `maxTaskCount` | `Int` | 最大任务数 |

> 示例代码

> 监听 Heartbeat 事件

```lua
-- @runtime client
-- 获取 RunService 服务实例
local runService = game:GetService("RunService")

-- 连接 Heartbeat 事件，每帧逻辑帧更新时触发
runService.Heartbeat:Once(function(deltaTime, maxTaskCount)
    -- deltaTime 为时间间隔（秒），maxTaskCount 为最大任务数
    print("Heartbeat deltaTime:", deltaTime, "maxTaskCount:", maxTaskCount)
end)
```

### FrameUpdate

签名：`FrameUpdate(deltaTime: Float)` 触发：`local`

每帧逻辑帧更新时触发，用于执行与渲染同步的每帧逻辑。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `deltaTime` | `Float` | 逻辑帧时间长 |

> 示例代码

> 监听 FrameUpdate 事件

```lua
-- @runtime client
-- 获取 RunService 服务实例
local runService = game:GetService("RunService")

-- 连接 FrameUpdate 事件，每帧逻辑帧更新时触发
runService.FrameUpdate:Once(function(deltaTime)
    -- deltaTime 为上一帧到当前帧的时间间隔（秒）
    print("FrameUpdate deltaTime:", deltaTime)
end)
```

### PostFrameUpdate

签名：`PostFrameUpdate(deltaTime: Float)` 触发：`local`

每帧逻辑帧更新完成后触发，适合执行帧末清理或延迟操作。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `deltaTime` | `Float` | 逻辑帧时间长 |

> 示例代码

> 监听 PostFrameUpdate 事件

```lua
-- @runtime client
-- 获取 RunService 服务实例
local runService = game:GetService("RunService")

-- 连接 PostFrameUpdate 事件，每帧逻辑帧更新完成后触发
runService.PostFrameUpdate:Once(function(deltaTime)
    -- deltaTime 为时间间隔（秒）
    print("PostFrameUpdate deltaTime:", deltaTime)
end)
```

## 函数 (4)

### IsClient

签名：`IsClient() -> Bool (是否是客户端)`

判断当前代码是否在客户端环境运行。

**返回值** `Bool` (是否是客户端)

> 示例代码

> 判断当前是否在客户端

```lua
-- @runtime client
local RunService = game:GetService("RunService")
print("是否客户端:", RunService:IsClient())
```

### IsServer

签名：`IsServer() -> Bool (是否是服务端)`

判断当前代码是否在服务端环境运行。

**返回值** `Bool` (是否是服务端)

> 示例代码

> 判断当前是否在服务端

```lua
-- @runtime server
local RunService = game:GetService("RunService")
print("是否服务端:", RunService:IsServer())
```

### IsStudio

签名：`IsStudio() -> Bool (是否是编辑器试玩环境)`

判断当前是否在编辑器试玩环境运行。

**返回值** `Bool` (是否是编辑器试玩环境)

> 示例代码

> 判断当前是否在编辑器试玩

```lua
-- @runtime client
local RunService = game:GetService("RunService")
print("是否编辑器试玩:", RunService:IsStudio())
```

### WaitForDebugger

签名：`WaitForDebugger() -> void`

等待 VSCode 调试器连接，编辑器会阻塞直到连接成功。

⚙ 该调用会阻塞当前执行线程直到 PC 调试器连接。仅在已启动 VS Code 调试器的专用调试会话中手工调用；不要放入正常游戏流程、可复制示例或自动化任务。

**返回值** `void`

> 示例代码

> 说明调试器等待的使用前提

```lua
-- @runtime client
-- WaitForDebugger 会阻塞执行；请先启动 VS Code 调试器，再在专用调试会话中手工调用。
print("RunService:WaitForDebugger() 仅用于已连接调试器的专用调试会话")
```
