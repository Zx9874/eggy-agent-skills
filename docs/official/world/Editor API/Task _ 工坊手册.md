# Task

任务调度服务，提供任务的立即执行、延迟执行、等待与取消等能力。通过 editor:GetService 获取。

## Overview

任务调度服务，提供任务的立即执行、延迟执行、等待与取消等能力。通过 `editor:GetService("Task")` 获取。

**Get by:**

```lua
local service = editor:GetService("Task")
```

## Public API

### Spawn

立即执行指定函数。返回的句柄可传给 Cancel 取消该任务。func 内抛出的错误会原样传递给调用方。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `func` | `Function` | 要执行的任务函数 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `thread` | 新任务句柄，可传给 Cancel 取消任务 |

**示例**

```lua
local service = editor:GetService("Task")

local coro = service:Spawn(function()
    print("spawn task executed")
end) -- 立即执行任务
print("spawn coro:", coro ~= nil)

local canceled = service:Cancel(coro) -- 已执行完，取消失败
print("cancel finished task:", canceled)
```

### Defer

将指定函数延迟到下一帧执行。返回的句柄可传给 Cancel 取消该任务。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `func` | `Function` | 要执行的任务函数 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `thread` | 新任务句柄，可传给 Cancel 取消任务 |

**示例**

```lua
local service = editor:GetService("Task")

local coro = service:Defer(function()
    print("next frame task executed")
end) -- 下一帧执行
print("defer coro:", coro ~= nil)

local coro2 = service:Defer(function()
    print("second defer fired (should not print)")
end)
local canceled = service:Cancel(coro2) -- 未执行前取消
print("cancel pending defer:", canceled)
```

### Cancel

取消由 Spawn / Defer / Delay 创建的任务。正在执行中的任务无法取消，返回 false。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `coro` | `thread` | 待取消的任务句柄 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否成功取消；任务已执行完或正在执行中返回 false |

**示例**

```lua
local service = editor:GetService("Task")

local done = service:Spawn(function()
    print("spawn task executed")
end)
print("cancel finished task:", service:Cancel(done)) -- 已执行完，返回 false

local pending = service:Delay(1.0, function()
    print("delayed task fired (should not print)")
end)
print("cancel pending task:", service:Cancel(pending)) -- 未执行，返回 true
```

### Delay

将指定函数延迟执行，duration 秒后开始运行。返回的句柄可传给 Cancel 取消该任务。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `duration` | `Float` | 延迟时间（秒） |
| `func` | `Function` | 要执行的任务函数 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `thread` | 新任务句柄，可传给 Cancel 取消任务 |

**示例**

```lua
local service = editor:GetService("Task")

local task = service:Delay(1.0, function()
    print("delayed task fired (should not print)")
end) -- 延迟 1 秒后执行
print("delay task created:", task ~= nil)

local canceled = service:Cancel(task) -- 未执行前取消
print("canceled:", canceled)
```

### Wait

在当前任务中挂起等待 duration 秒，恢复后返回实际经过的时间。仅在 Spawn / Defer / Delay 创建的任务中可用。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `duration` | `Float` | 等待时长（秒） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Float` | 实际等待的时长（秒） |

**示例**

```lua
local service = editor:GetService("Task")

service:Spawn(function()
    local elapsed = service:Wait(0.5) -- 挂起等待 0.5 秒
    print("waited seconds:", elapsed)
end)
```
