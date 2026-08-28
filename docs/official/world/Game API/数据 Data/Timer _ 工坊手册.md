# Timer

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

计时器对象，用于在指定延迟后或按固定间隔重复执行回调函数。它由 [TimerService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TimerService.html) 创建，提供启动、暂停、恢复、取消等控制能力，并可查询运行状态、间隔和剩余次数。

## 适用场景

常用于需要延迟执行或周期性触发逻辑的场景，例如冷却计时、定时刷怪、限时挑战等。通过 TimerService:CreateTimer 创建实例并绑定回调，即可在游戏逻辑中实现时间驱动行为。

## 使用要点

通过 TimerService:CreateTimer 创建 [Timer](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Timer.html) 实例，传入重复次数、间隔、是否立即执行和回调函数。创建后自动开始运行，可调用 Start、Pause、Resume、Cancel 控制执行，使用 IsRunning、GetTimerInterval、GetTimerRemain 查询状态。

## 注意事项

TimerService:CreateTimer 返回的 [Timer](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Timer.html) 已自动启动。Start 对正在运行的 [Timer](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Timer.html) 是幂等空操作；暂停后调用 Start 会按完整计数重新启动，若要从暂停位置继续应使用 Resume。当前 SDK 实现的 GetTimerInterval 读取字段不一致，可能返回 nil；修复前不要把该返回值用于关键计时逻辑。

## 代码示例

### 通过 TimerService 创建并控制 Timer

```lua
-- @runtime client
local TimerService = game:GetService("TimerService")
local timer = TimerService:CreateTimer(1, 0.5, false, function()
    print("定时器触发")
end)

print("运行中:", timer:IsRunning())
print("间隔:", timer:GetTimerInterval())
timer:Cancel()
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `OnEvent` | [Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html) | `-` | 计时器每次触发时发出的事件，可用于连接自定义回调函数。 |

## 关联类型

* [Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html)

## 函数 (7)

### Start

签名：`Start() -> void`

启动计时器，开始按设定的间隔触发事件。

**返回值** `void`

> 示例代码

> 启动 Timer

```lua
-- @runtime client
local TimerService = game:GetService("TimerService")
local timer = TimerService:CreateTimer(1, 0.5, false, function()
    print("触发一次")
end)
timer:Pause()
timer:Start()  -- 从完整计数重新启动；从暂停位置继续请用 Resume
timer:Cancel()
```

### Cancel

签名：`Cancel() -> void`

取消计时器，停止触发并释放资源。

**返回值** `void`

> 示例代码

> 取消 Timer

```lua
-- @runtime client
local TimerService = game:GetService("TimerService")
local timer = TimerService:CreateTimer(-1, 1.0, false, function()
    print("循环触发")
end)
timer:Cancel()
```

### Pause

签名：`Pause() -> void`

暂停计时器，暂停期间不会触发事件。

**返回值** `void`

> 示例代码

> 暂停 Timer

```lua
-- @runtime client
local TimerService = game:GetService("TimerService")
local timer = TimerService:CreateTimer(-1, 1.0, false, function() end)
timer:Pause()
timer:Cancel()
```

### Resume

签名：`Resume() -> void`

从暂停状态恢复计时器运行。

**返回值** `void`

> 示例代码

> 恢复 Timer

```lua
-- @runtime client
local TimerService = game:GetService("TimerService")
local timer = TimerService:CreateTimer(-1, 1.0, false, function() end)
timer:Pause()
timer:Resume()
timer:Cancel()
```

### IsRunning

签名：`IsRunning() -> Bool (是否正在运行)`

检查计时器当前是否处于运行状态。

**返回值** `Bool` (是否正在运行)

> 示例代码

> 检查 Timer 是否运行

```lua
-- @runtime client
local TimerService = game:GetService("TimerService")
local timer = TimerService:CreateTimer(1, 0.5, false, function() end)
print("运行中:", timer:IsRunning())
timer:Cancel()
```

### GetTimerInterval

签名：`GetTimerInterval() -> Float (间隔时间（秒）)`

返回创建计时器时设置的间隔时间，单位为秒。

**返回值** `Float` (间隔时间（秒）)

> 示例代码

> 读取 Timer 间隔

```lua
-- @runtime client
local TimerService = game:GetService("TimerService")
local timer = TimerService:CreateTimer(1, 0.5, false, function() end)
print("间隔:", timer:GetTimerInterval())
timer:Cancel()
```

### GetTimerRemain

签名：`GetTimerRemain() -> Int (剩余次数)`

返回计时器剩余触发次数；无限循环时的具体表示以运行时为准，不依赖固定哨兵值。

**返回值** `Int` (剩余次数)

> 示例代码

> 读取 Timer 剩余次数

```lua
-- @runtime client
local TimerService = game:GetService("TimerService")
local timer = TimerService:CreateTimer(3, 1.0, false, function() end)
timer:Start()
print("剩余次数:", timer:GetTimerRemain())
timer:Cancel()
```
