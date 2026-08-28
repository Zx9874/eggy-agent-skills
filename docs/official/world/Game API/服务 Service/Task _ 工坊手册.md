# Task

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[Task]**（5 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[Task](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Task.html) 服务提供协程调度与延迟执行能力，可将函数安排到下一帧、延迟指定秒数后运行，或让当前协程挂起等待。通过 Spawn、Defer、Delay 和 Wait 等函数，开发者能灵活控制代码的执行时机与顺序，并支持取消已调度的任务。

## 适用场景

典型场景是在游戏逻辑中需要延迟执行某个操作，例如等待几秒后触发剧情对话，或者将耗时计算分摊到多帧以避免卡顿。

## 使用要点

通过 game:GetService("Task") 获取服务实例。使用 Task:Spawn 或 Task:Defer 调度函数；使用 Task:Delay 在指定秒数后执行函数；在协程内调用 Task:Wait 挂起当前协程。

## 注意事项

[Task](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Task.html) 服务提供协程调度与延迟执行。Spawn、Defer 与 Delay 均返回 Thread，可传给 Cancel 取消，或用 coroutine.status(coro)（注意：标准库 coroutine 必须用点语法 coroutine.status，禁止冒号语法 coroutine:status）查询状态。Wait 只能在协程内调用。

## 代码示例

### 使用 Spawn 和 Defer 调度任务并检查协程状态

```lua
-- @runtime client
-- 获取 Task 服务实例
local task = game:GetService("Task")

-- 定义两个简单的任务函数
local function taskA()
    print("任务 A 开始执行")
end

local function taskB()
    print("任务 B 开始执行")
end

-- 使用 Spawn 立即调度任务 A，返回协程句柄
local coroA = task:Spawn(taskA)
-- 使用 Defer 将任务 B 放入下一帧调度队列，返回协程句柄
local coroB = task:Defer(taskB)

-- 检查两个协程句柄是否有效
if coroA ~= nil and coroB ~= nil then
    print("两个任务均已成功调度")
    -- 输出协程状态（使用标准库 coroutine.status）
    print("任务 A 协程状态: " .. coroutine.status(coroA))
    print("任务 B 协程状态: " .. coroutine.status(coroB))
else
    print("任务调度失败")
end
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (5)

### Spawn

签名：`Spawn(func: Function) -> Thread (协程)`

创建一个任务协程并立即恢复执行。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `func` | `Function` | 任务 |

**返回值** `Thread` (协程)

> 示例代码

> 立即启动协程任务

```lua
-- @runtime client
local Task = game:GetService('Task')
local coro = Task:Spawn(function()
    print('任务执行中')
end)
-- 标准库 coroutine 用点语法查询状态
print('协程状态:', coroutine.status(coro))
```

### Defer

签名：`Defer(func: Function) -> Thread (协程)`

创建一个任务协程并将其放入调度队列，在当前帧结束后执行。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `func` | `Function` | 任务 |

**返回值** `Thread` (协程)

> 示例代码

> 延迟到当前帧末执行

```lua
-- @runtime client
local Task = game:GetService('Task')
local coro = Task:Defer(function()
    print('延迟任务执行')
end)
print('协程状态:', coroutine.status(coro))
```

### Cancel

签名：`Cancel(coro: Thread) -> Bool (是否取消成功)`

取消一个由 [Task](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Task.html) 服务创建的任务协程。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `coro` | `Thread` | 协程 |

**返回值** `Bool` (是否取消成功)

> 示例代码

> 取消 Spawn 创建的协程

```lua
-- @runtime client
local Task = game:GetService('Task')
local coro = Task:Spawn(function()
    Task:Wait(10.0)  -- 长时间等待，便于取消
end)
local cancelled = Task:Cancel(coro)
print('取消结果:', cancelled)
print('协程状态:', coroutine.status(coro))
```

### Delay

签名：`Delay(duration: Float, func: Function) -> Thread (协程)`

创建一个任务协程，并在指定的延迟时间后恢复执行传入的函数。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `duration` | `Float` | 时长 |
| `func` | `Function` | 任务 |

**返回值** `Thread` (协程)

> 示例代码

> 延迟执行并在需要时取消

```lua
-- @runtime client
local Task = game:GetService('Task')
-- Delay 返回 Thread，可像 Spawn/Defer 的结果一样传给 Cancel
local delayThread = Task:Delay(2.0, function()
    print('2 秒后执行')
end)
local cancelled = Task:Cancel(delayThread)
print('取消结果:', cancelled)
```

### Wait

签名：`Wait(duration: Float) -> Float (执行时过去的时间)`

暂停当前协程的执行，等待指定的时间后恢复。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `duration` | `Float` | 时长 |

**返回值** `Float` (执行时过去的时间)

> 示例代码

> 在协程内暂停当前协程

```lua
-- @runtime client
local Task = game:GetService('Task')
Task:Spawn(function()
    print('开始等待')
    Task:Wait(1.0)  -- 只能在协程内调用
    print('1 秒后继续')
end)
```
