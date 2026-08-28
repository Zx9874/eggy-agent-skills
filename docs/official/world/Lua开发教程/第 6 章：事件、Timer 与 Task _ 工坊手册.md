# 第 6 章：事件、Timer 与 Task

用事件、Task 与 Timer 组织异步流程，并正确处理连接和延迟任务生命周期。

## 你会学到什么

* 如何用事件把"发生了什么"变成回调。
* 如何用 `TimerService` 做周期性定时器。
* 如何用 `Task` 做延迟和异步——重点理解协程。
* 事件连接的生命周期和防泄漏。

## 第一部分：事件

### 从触发器到事件

在可视化编辑器中，你可能会配置“当某物发生碰撞时执行某动作”。在 Lua 中，具体 `WorldUnit` 的 `OnCollisionEnter` 是一个事件信号；调用 `Connect` 后，引擎在碰撞发生时执行你的回调，并把 `otherUnit` 作为参数传入。完整、可复制的代码放在本章后半部分。

### 事件系统核心 API

| API | 说明 |
| --- | --- |
| `event:Connect(func)` | 绑定回调函数到事件，每次触发都执行 |
| `connection:Disconnect()` | 断开事件连接，不再接收触发 |
| `event:Once(func)` | 绑定只触发一次的回调 |

当前公开 `Signal` API 只有 `Connect`、`Once` 和 `Fire`，没有 `Wait()`；不要从其他 Lua 引擎照搬 `event:Wait()`。

### 事件的生命周期

`Connect` 和 `Once` 都返回公开的 `Connection` 对象。持续监听应保存这个返回值，并在所属系统停止、重新初始化或不再需要监听时调用 `Disconnect()`。后面的完整示例会把碰撞连接保存为局部变量；第 19 章再把它纳入 Manager 的统一清理流程。

### 不要依赖同一帧内多个事件的先后顺序

同一个逻辑帧里可能触发多个单位事件。不要假设“先注册的回调一定先执行”，也不要让两个回调通过隐含顺序共同修改同一份关键状态。更稳妥的做法是：回调只收集本帧发生的事实，再由一个统一的结算函数在明确阶段处理；如果必须错开处理，使用当前公开的 `Task:Delay` 或下一帧调度方式，并再次检查对象是否仍然有效。

这条规则不会改变 `Connect` 的写法，但会影响你的业务设计。例如两个玩家同帧碰到终点时，服务端应按明确规则统一结算，而不是把“哪个碰撞回调碰巧先到”当作胜负依据。

## 第二部分：Timer（定时器）

除了用 Heartbeat 自己实现周期逻辑，SE 还提供了 `TimerService`，用起来更直观：

```lua
local TimerService = game:GetService("TimerService")

if not TimerService then
    print("[SE Lua Guide][ERROR] TimerService 获取失败")
    return
end

-- 创建定时器：重复 5 次，每次间隔 1 秒，不额外立即执行
local timer = TimerService:CreateTimer(5, 1, false, function()
    print("[SE Lua Guide] 定时器触发")
end)

-- CreateTimer 返回的 Timer 已自动启动；需要提前停止时调用：
-- timer:Cancel()
```

### Timer 参数说明

```lua
local TimerService = game:GetService("TimerService")

if not TimerService then
    print("[SE Lua Guide][ERROR] TimerService 获取失败")
    return
end

-- CreateTimer(重复次数, 间隔秒, 是否立即执行, 回调函数)
-- 重复次数：-1 表示无限循环，正数 N 表示执行 N 次
-- 间隔秒：每次触发之间的时间间隔
-- 是否立即执行：true 表示创建后额外立即执行一次，false 表示先等待首个间隔
local triggerCount = 0
local loopTimer

loopTimer = TimerService:CreateTimer(-1, 2, false, function()
    triggerCount = triggerCount + 1
    print("第", triggerCount, "次触发")

    -- 无限定时器必须有明确退出条件；这里演示触发 3 次后取消。
    if triggerCount >= 3 then
        loopTimer:Cancel()
    end
end)
```

> `CreateTimer` 返回的 `Timer` 会自动开始运行，不要紧接着重复调用 `Start()`。`Cancel()` 用于取消；`Pause()` / `Resume()` 用于暂停和从暂停位置继续；`IsRunning()` 可查询当前状态。`Start()` 更适合重新按完整计数启动，而不是首次启动。

### 重要：不要用浮点累加判断结束

```lua
-- ❌ 错误：浮点误差会导致判断不准
local elapsed = 0
elapsed = elapsed + 0.1  -- 累加 10 次后可能不等于 1.0

-- ✅ 正确：用整数 tick 计数
local tickCount = 0
tickCount = tickCount + 1  -- 整数不会有误差
```

或者直接用 `TimerService:CreateTimer`，它的重复次数是整数，不会有浮点问题。

## 第三部分：Task（延迟与异步）

Task 服务是 SE 中处理"延迟执行"和"异步操作"的核心工具。对新手来说，异步和协程是最难理解的概念之一，这里展开讲解。

### 3.1 先理解问题：为什么需要异步？

看一段"同步"代码：

```lua
print("第一步")
print("第二步")  -- 必须等第一步执行完才执行
print("第三步")
```

这是顺序执行——当前函数会从上到下运行。普通函数调用结束后才会继续下一行，但“顺序”本身不等于整个游戏一定卡住。

但有时你需要"等一会儿再继续"，比如：

* 等玩家角色加载完成。
* 等 2 秒后再重置球体。
* 等数据存储读取完成。

如果在当前执行线索里做长时间忙等或重计算，后续逻辑就无法及时继续。`Task` 使用协作式协程调度：某个协程等待时，引擎可以继续调度其他工作；它不是并行运行的操作系统后台线程。

### 3.2 Task:Delay——延迟执行

最简单的异步用法是 `Task:Delay`：

```lua
local Task = game:GetService("Task")

if not Task then
    print("[SE Lua Guide][ERROR] Task 服务获取失败")
    return
end

print("第一步")

-- 2 秒后执行这段代码，但不阻塞后面的第三步
Task:Delay(2, function()
    print("第二步：2 秒到了！")
end)

print("第三步")  -- 立刻执行，不会等 2 秒
```

输出顺序：

```text
第一步
第三步
（2 秒后）
第二步：2 秒到了！
```

**理解关键**：`Task:Delay` 不会暂停代码。它说"2 秒后帮我执行这个函数"，然后立刻继续往下走。

### 3.3 Task:Spawn——在新协程中执行

`Task:Spawn` 创建并立即恢复一个新的协程。协程可以理解为“一条可暂停、可恢复的执行线索”；它与其他任务协作调度，不等于新建并行线程。

```lua
local Task = game:GetService("Task")

if not Task then
    print("[SE Lua Guide][ERROR] Task 服务获取失败")
    return
end

-- 主线程代码
print("主线程：开始")

-- 在新协程中执行
Task:Spawn(function()
    print("协程：开始")
    Task:Wait(1)       -- 等待 1 秒（只暂停协程，不暂停主线程）
    print("协程：1 秒后继续")
end)

print("主线程：继续")
```

输出顺序：

```text
主线程：开始
协程：开始
主线程：继续
（1 秒后）
协程：1 秒后继续
```

**为什么需要协程？** 因为公开 Task 文档要求在协程内调用 `Task:Wait`。它只挂起当前协程 N 秒，等待结束后再恢复，不会让同一协程越过这行继续执行。

### 3.4 Task:Wait——在协程中等待

```lua
local Task = game:GetService("Task")

if not Task then
    print("[SE Lua Guide][ERROR] Task 服务获取失败")
    return
end

Task:Spawn(function()
    print("开始等待")
    Task:Wait(2)  -- 暂停 2 秒（必须在协程中调用）
    print("2 秒后继续")
end)

-- ❌ 错误：不能在主线程直接调用 Task:Wait
-- Task:Wait(2)  -- 会报错！
```

### 3.5 协程到底在干什么？一个生活类比

想象你在厨房做菜：

* **主线程**：你本人，只能同时做一件事。
* **同步执行**：烧水 → 等水开 → 煮面。你必须盯着锅等水开，什么都做不了。
* **Task:Delay**：设个闹钟，2 分钟后叫我。你可以先去切菜，闹钟响了再回来。
* **Task:Spawn**：叫一个助手（协程）来帮你。助手和你轮流获得执行机会，不是两个人在不同 CPU 上保证同时工作。
* **Task:Wait**：助手说"我等 5 分钟"，助手暂停 5 分钟，但你（主线程）继续切菜。

### 3.6 什么时候必须用协程？

以下操作会等待或恢复协程，应放在可挂起的任务里，并按对应公开 API 说明处理失败：

* `Task:Wait(n)` — 等待
* `store:GetAsync(key, options)` — 读取数据存储；`options` 是可选的 `DataStoreGetOptions`
* `store:UpdateAsync(key, fn)` — 更新数据存储

不同 `Async` API 不一定采用同一种完成方式：有的挂起当前协程，有的通过回调返回。必须查看该成员的公开签名，不能仅凭 `Async` 后缀猜调用方式。如果遇到“必须在协程中调用”的报错，再检查是否忘了用 `Task:Spawn` 包裹。

### 3.7 Task 服务速查

| API | 说明 | 能否在主线程调用 |
| --- | --- | --- |
| `Task:Delay(秒, fn)` | 延迟执行 | ✅ 可以 |
| `Task:Spawn(fn)` | 在新协程中执行 | ✅ 可以 |
| `Task:Wait(秒)` | 暂停当前协程 | ❌ 必须在协程中 |
| `Task:Defer(fn)` | 类似 Spawn，延迟到帧末执行 | ✅ 可以 |

## 场景准备

1. 放置一个球体，命名为“球体”，物理类型设为受力物体（`Dynamic`）。
2. 放置一个方块，命名为“方块”，物理类型设为运动物体（`Kinematic`）。
3. 确认两者是 `WorldUnit`，并启用碰撞和碰撞事件所需的 `CanCollide`、`CanTouch`、`CanTrigger`。
4. 放置并配置一个 `EffectUnit`，命名为 `HitEffect`，初始设为不可见；特效资源在编辑器中选择。
5. **球体和方块之间留出距离，不要重叠或紧贴。**

为什么留距离？如果球体和方块一开始就重叠，物理引擎第一帧就会判定碰撞，导致玩家还没操作就自动触发。

## 完整示例：碰撞 → 提示 → 特效 → 重置

运行端：server  
 文件：`server/main.lua`

```lua
local World = game:GetService("World")
local Task = game:GetService("Task")

if not World or not Task then
    print("[SE Lua Guide][ERROR] World 或 Task 服务获取失败")
    return
end

local ball = World:FindFirstChild("球体")
local cube = World:FindFirstChild("方块")

if not ball or not cube then
    print("[SE Lua Guide][WARN] 请先放置并命名「球体」和「方块」。")
    return
end

if not ball:IsA("WorldUnit") or not cube:IsA("WorldUnit") then
    print("[SE Lua Guide][ERROR] 球体和方块都必须是 WorldUnit")
    return
end

local startCF = ball.CFrame      -- 记录球体初始位姿
local lastHitTime = 0           -- 防抖时间戳

local function ResetBall()
    ball.CFrame = startCF
    ball.LinearVelocity = Vector3.New(0, 0, 0)
    ball.AngularVelocity = Vector3.New(0, 0, 0)
end

-- 保存连接；所属玩法系统停止时应调用 collisionConnection:Disconnect()。
local collisionConnection
collisionConnection = cube.OnCollisionEnter:Connect(function(otherUnit)
    -- 只关心球体碰方块
    if otherUnit ~= ball then return end

    -- 防抖：1 秒内只触发一次
    local now = World:GetServerTime()
    if now - lastHitTime < 1 then return end
    lastHitTime = now

    -- 显示提示
    print("[SE Lua Guide] 球体命中方块！")

    -- 特效资源先在编辑器配置；Lua 只通过公开表现接口控制已有对象。
    local effect = World:FindFirstChild("HitEffect", true)
    if effect and effect:IsA("EffectUnit") then
        effect:SetPosition(ball.CFrame.Position)
        effect:SetVisible(true)

        -- Duration 不保证所有资源都会自动回收，因此业务侧显式收尾。
        Task:Delay(1, function()
            effect:SetVisible(false)
        end)
    end

    -- 重置球体
    ResetBall()
end)
```

## 期望结果

* 玩家操控蛋仔把球体推向方块。
* 碰撞后看到提示。
* 命中位置显示编辑器中预先配置的特效，并在 1 秒后隐藏。
* 球体被重置到初始位置，可重复游玩。

## 进阶：随机刷新方块位置

固定的方块位置很容易让玩家找到固定得分角度。我们可以在每次命中后随机刷新方块的位置。

```lua
local World = game:GetService("World")

if not World then
    print("[SE Lua Guide][ERROR] World 服务获取失败")
    return
end

local cube = World:FindFirstChild("方块")
if not cube or not cube:IsA("WorldUnit") then
    print("[SE Lua Guide][WARN] 未找到名为“方块”的 WorldUnit")
    return
end

-- 记录方块的初始位置
local cubeStartPos = cube.Position

-- 随机刷新方块位置
local function RandomUpdateCube()
    -- 在初始位置基础上，z 轴随机偏移 -5 到 5
    local z = cubeStartPos.z + math.random(-5, 5)
    cube.Position = Vector3.New(cubeStartPos.x, cubeStartPos.y, z)
end

RandomUpdateCube()
```

整合进上一节时，在碰撞回调的 `ResetBall()` 后调用 `RandomUpdateCube()`；不要把两个独立代码块原样重复粘贴到同一文件，以免重复声明局部变量。

**注意**：方块需要在编辑器中把物理类型设为运动学（`Kinematic`）。当前 `WorldUnit.BodyType` 公开说明明确：`Static` 不可移动，`Kinematic` 由脚本驱动，`Dynamic` 参与完整物理模拟。不要硬编码它们的底层数字。

## 进阶：标记最后触碰玩家

在碰撞中，球体可能先碰到角色的一部分，再碰到方块。`Players:GetPlayerFromCharacter` 的公开参数要求是 `EggyUnit`，而 `OnCollisionEnter` 只承诺传入泛 `Unit`；不能把任意碰撞对象直接当作角色传入。

因此本章不提供猜测式的“碰撞对象 → Player”代码。第 7 章会先讲清 `Player.Character`、`EggyUnit` 和反查条件，再构造可验证的归属流程。现在只需记住：最终得分归属仍由 server 判定，不能由 client 自报。

## 常见错误

### 错误：一运行就自动碰撞

原因：球体和方块摆放太近或重叠。  
 正确做法：两者之间留出距离。

### 错误：碰撞连续触发

物理碰撞可能在短时间内多次触发。用 `lastHitTime` 做防抖。

### 错误：只靠特效 Duration 自动收尾

`Duration` 的自动回收行为取决于具体特效资源。需要稳定的短时反馈时，像完整示例一样由业务计时器主动 `SetVisible(false)`，不要承诺所有资源都会自行隐藏或销毁。

### 错误：在主线程调用 Task:Wait

`Task:Wait` 只能在协程中调用。如果在 `main.lua` 顶层直接调用会报错。用 `Task:Spawn` 包裹。

### 错误：事件连接不断开

如果对象被销毁但事件连接没断开，可能导致内存泄漏或访问已销毁对象。

## 练习任务

1. 调整防抖间隔，观察连续碰撞是否还会重复触发。
2. 用 `Task:Delay` 在碰撞命中后延迟 2 秒再重置球体，观察效果。
3. 思考：如果要把"命中次数"作为分数，应该把计数放在 server 还是 client？

## 本章验收标准

* [ ] 我知道如何用 `Connect` 绑定事件回调。
* [ ] 我知道如何用 `TimerService:CreateTimer` 做定时器。
* [ ] 我理解 `Task:Delay` 不阻塞、`Task:Spawn` 创建协程、`Task:Wait` 必须在协程中。
* [ ] 我能实现碰撞 → 提示 → 特效 → 重置的完整逻辑。
* [ ] 我知道防抖和事件断开的重要性。

## 本章产物

* 一段可运行的碰撞反馈逻辑：球体碰到方块后提示、播放特效、重置球体。
* 一份期望现象：碰撞只计一次、预配置特效在命中位置短暂显示、球体回到初始位置。
* 一条失败复盘候选：连续碰撞重复触发、对象初始重叠或事件连接未断开。

这些产物会在第 22 章升级为 `server/round_manager.lua` 内部的 `onCubeTouched(...)` 和 `playHitEffect()`。

## 本章 API 对照

* [Task](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Task.html)
* [TimerService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TimerService.html)
* [Timer](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Timer.html)
* [Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html)
* [Connection](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Connection.html)
* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)
* [EffectUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EffectUnit.html)

## 下一章预告

你能做出碰撞反馈了。下一章我们将学习玩家服务——`PlayerAdded` 事件、角色获取、键盘输入和阵营成员变化。
