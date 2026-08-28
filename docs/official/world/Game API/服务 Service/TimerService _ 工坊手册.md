# TimerService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[TimerService]**（1 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[TimerService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TimerService.html) 是全局计时器管理服务，负责创建和配置游戏中的定时任务。通过它可生成一次性延迟、循环重复或手动控制的 [Timer](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Timer.html) 对象，用于驱动周期性逻辑或延时回调。

## 适用场景

典型场景包括实现单位往返运动、技能冷却计时、定时刷怪等需要精确时间控制的游戏机制。

## 使用要点

通过 game:GetService("TimerService") 获取服务实例，然后调用 CreateTimer 创建 [Timer](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Timer.html) 对象，传入重复次数、间隔秒数、是否立即执行和回调函数。创建后需显式调用 Timer:Start() 启动，可用 Timer:Cancel() 中途取消。

## 注意事项

CreateTimer 会在创建时自动启动 [Timer](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Timer.html)；execute 只控制是否在创建后额外立即执行一次回调，false 表示首次回调等待 interval。不要在 CreateTimer 后重复调用 Start。需要停止任务时对返回的 [Timer](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Timer.html) 调用 Cancel；需要暂停后继续时使用 Pause/Resume。

## 代码示例

### 创建自动启动的一次性定时器

```lua
-- @runtime client
local timerService = game:GetService("TimerService")

local timer = timerService:CreateTimer(1, 2.0, false, function()
    print("一次性定时器触发")
end)

-- CreateTimer 已自动启动；false 表示不额外立即执行回调
print("定时器剩余次数:", timer:GetTimerRemain())
```

### 创建循环定时器并定时取消

```lua
-- @runtime client
local timerService = game:GetService("TimerService")

local loopTimer = timerService:CreateTimer(-1, 1.0, false, function()
    print("循环定时器触发")
end)

local cancelTimer = timerService:CreateTimer(1, 5.0, false, function()
    loopTimer:Cancel()
    print("循环定时器已取消")
end)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (1)

### CreateTimer

签名：`CreateTimer(repeatCount: Int, interval: Float, execute: Bool, func: Function) -> Timer (计时器对象)`

创建一个新的计时器对象，用于按指定间隔重复执行回调函数。

⚙ repeatCount=-1 表示无限循环；repeatCount=1 表示执行一次。不要把 repeatCount=0 当作无限循环示例使用。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `repeatCount` | `Int` | 重复次数，-1表示无限次 |
| `interval` | `Float` | 时间间隔 |
| `execute` | `Bool` | 是否立即执行 |
| `func` | `Function` | 回调函数 |

**返回值** [Timer](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Timer.html) (计时器对象)

> 示例代码

> 创建无限循环计时器

```lua
-- @runtime client
local TimerService = game:GetService("TimerService")
local timer = TimerService:CreateTimer(-1, 1.0, false, function()
    print("每秒执行一次")
end)

-- CreateTimer 已自动启动；false 表示首次回调等待 1 秒
-- 不再需要时调用 Cancel
-- timer:Cancel()
```
