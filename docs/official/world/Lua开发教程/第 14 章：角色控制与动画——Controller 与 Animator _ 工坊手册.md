# 第 14 章：角色控制与动画——Controller 与 Animator

使用 Controller 驱动角色状态，并按宿主类型加载和管理动画轨道。

## 你会学到什么

* `Controller` 是通用入口，`EggyController` 是蛋仔控制器类型。
* `BaseController`、`EggyController`、`HumanController` 的能力边界。
* 哪些控制逻辑适合 server，哪些适合 client。
* 如何等待本地 EggyUnit 与 EggyController 就绪。
* 如何用 `Animator:LoadAnimation` 和 `AnimationTrack` 播放动画。
* 动画表现与跨端玩法判定的边界。

## Controller 的正确入口

角色控制器挂在具体角色 Unit 上，公开入口是 `local controller = character.Controller`。这里的 `character` 必须来自已证明的 EggyUnit 或 HumanUnit 上下文，不能把这行脱离类型来源单独复制。

`Controller` 的基础能力来自 `BaseController`：移动、跳跃、状态、生命值、落地、死亡、碰撞、自定义状态等。当前公开 `Player.Character` 是 `EggyUnit`，它的控制器类型是 `EggyController`，额外提供 `Rush`、`Fling`、`Lift`、`Throw` 等蛋仔动作。单独创建的 `HumanUnit` 对应 `HumanController`，额外提供坐下、速度读取、状态机评估和人形状态事件。

| 层级 | 代表能力 | 什么时候关注 |
| --- | --- | --- |
| `BaseController` | `Move`、`MoveTo`、`Jump`、`GetState`、`StateChanged`、`TakeDamage`、`Heal`、`RegisterCustomState`、`OnCollisionEnter` | 所有角色控制的共同基础 |
| `EggyController` | `Rush`、`Fling`、`Lift(目标蛋仔)`、`Throw`，以及蛋仔抓举相关事件 | 使用蛋仔角色能力、快速做派对玩法 |
| `HumanController` | `EvaluateStateMachine`、`GetMoveVelocity`、`Running`、`Climbing`、`FreeFalling`、`Seated` | 人形 NPC、BOSS、专业 3C、动作角色 |

关键判断：`EggyController` 更像“成熟蛋仔角色能力包”；`HumanController` 更像“人形角色控制基座”。前者拿来就能用，后者能改得更深，但更需要作者自己设计控制、动画和 QA。

## 等待本地角色能力就绪

运行端：client  
 文件：`client/main.lua`

```lua
local Players = game:GetService("Players")
local Task = game:GetService("Task")

if not Players or not Task then return end

local function WaitLocalEggyController()
    -- 每轮重新读取角色引用，避免重生时继续等待已失效的旧 Character。
    for _ = 1, 150 do
        local player = Players.LocalPlayer
        if player ~= nil then
            local character = player.Character
            if character and character:IsA("EggyUnit") and character.Controller then
                return character, character.Controller
            end
        end
        Task:Wait(0.033)
    end
    return nil, nil
end
```

这个函数只等待当前公开玩家角色链上的 `EggyUnit` 与 `EggyController`。150 次轮询只是给一次初始化设置约 5 秒上限；长期模块还应监听 `CharacterAdded`，在重生后丢弃旧 Controller、重新绑定并断开旧 Connection。`EggyUnit` 当前没有公开 `Animator` 属性，所以动画示例不会复用这条等待函数，而是单独从 `HumanUnit.Animator` 获取动画器。

## 监听角色状态

运行端：client。这个示例读取 `Players.LocalPlayer`，适合做 UI、音效、镜头反馈；伤害、胜负、奖励等权威逻辑应在 server 端基于对应玩家的角色状态独立处理。

```lua
local Players = game:GetService("Players")
local Task = game:GetService("Task")
if not Players or not Task then return end

local function WaitLocalEggyController()
    for _ = 1, 150 do
        local player = Players.LocalPlayer
        if player ~= nil then
            local character = player.Character
            if character and character:IsA("EggyUnit") and character.Controller then
                return character, character.Controller
            end
        end
        Task:Wait(0.033)
    end
    return nil, nil
end

Task:Spawn(function()
    local character, controller = WaitLocalEggyController()
    if not character or not controller then
        print("[SE Lua Guide][WARN] 5 秒内未取得本地 EggyController。")
        return
    end

    controller.StateChanged:Connect(function(oldState, newState)
        print("[SE Lua Guide] 状态:", oldState, "->", newState)
    end)

    print("[SE Lua Guide] 当前状态:", controller:GetState())
    print("[SE Lua Guide] 是否在地面:", controller:IsGrounded())
end)
```

状态值来自 `Enums.ControllerStateType`，例如 `Idle`、`Moving`、`Jumping`、`Dead`、`EggyRush`、`EggyRoll`。

## 主动控制角色

通用控制能力：

```lua
local Players = game:GetService("Players")
if not Players then return end
local player = Players.LocalPlayer
if not player then
    print("[SE Lua Guide][WARN] 本地玩家尚未就绪")
    return
end
local character = player.Character
if not character or not character:IsA("EggyUnit") then
    print("[SE Lua Guide][WARN] 本地角色尚未就绪")
    return
end
local controller = character.Controller
if not controller then
    print("[SE Lua Guide][WARN] 本地角色控制器尚未就绪")
    return
end

controller:Jump()
controller:Move(Vector3(0, 0, 1), false)
controller:MoveTo(Vector3(10, 0, 10))
```

蛋仔专属动作：

```lua
local Players = game:GetService("Players")
if not Players then return end
local player = Players.LocalPlayer
if not player then
    print("[SE Lua Guide][WARN] 本地玩家尚未就绪")
    return
end
local character = player.Character
if not character or not character:IsA("EggyUnit") then
    print("[SE Lua Guide][WARN] 本地角色尚未就绪")
    return
end
local controller = character.Controller
if character:IsA("EggyUnit") and controller then
    controller:Rush()
    controller:Fling()
else
    print("[SE Lua Guide][WARN] 当前角色不是已就绪的 EggyUnit")
end
```

主动控制玩家自己的角色时要克制：玩家移动通常由输入系统处理。脚本主动 `MoveTo` 更适合 NPC、自动引导、过场、训练靶等场景。涉及胜负、伤害、强制控制时，server 应保持最终权威。

## HumanController：更开放的人形控制

`HumanController` 适合需要人形移动和专业角色控制的项目。它既继承 `BaseController` 的移动、跳跃、生命、状态和碰撞能力，又额外暴露人形相关参数与事件。

常用能力可以分成三类：

| 能力 | 入口 | 用途 |
| --- | --- | --- |
| 移动状态事件 | `Running`、`Climbing`、`FreeFalling`、`Seated` | 做人形角色的跑、跳、攀爬、落地和坐下表现 |
| 速度与地面关系 | `GetMoveVelocity()`、`GetRelativeVelocityAtFloor()`、`IsGrounded()`、`GetFloor()` | 驱动动画混合、脚步声、相机反馈 |
| 状态机与自定义控制 | `EvaluateStateMachine`、`RegisterCustomState()`、`ChangeState()`、`SetStateEnabled()` | 扩展或接管人形状态流 |

`ClimbEnabled` / `ClimbSpeed` 是当前 `EggyController` 的公开属性，不是 `HumanController` 属性。不要因为 HumanController 有 `Climbing` 事件，就反推它一定公开同名开关。

运行端：server 或 client；权威 NPC 状态优先由 server 处理。

```lua
local World = game:GetService("World")
if not World then return end

local human = World:FindFirstChild("人形NPC", true)
if not human or not human:IsA("HumanUnit") then
    print("[SE Lua Guide][WARN] 请先创建并命名 HumanUnit 为「人形NPC」。")
    return
end

local controller = human.Controller
if controller then
    controller.Running:Connect(function(speed)
        print("[SE Lua Guide] 人形奔跑速度:", speed)
    end)

    controller.FreeFalling:Connect(function(active)
        print("[SE Lua Guide] 自由落体:", active)
    end)
end
```

更专业的项目会把移动输入、相机、动画和物理反馈拆成自己的 3C 模块。如果你确实要深度接管人形控制，可以关闭或绕开部分内建状态机逻辑，再用 `RunService.Heartbeat` 每帧根据输入驱动 `Move` / `Jump` / 动画状态。这个方向适合有角色控制经验的作者；第一版玩法不要一上来就这样做。

运行端：client  
 文件：`client/human_controller_driver.lua`

```lua
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
if not RunService or not UserInputService then return {} end

local HumanControllerDriver = {}

function HumanControllerDriver.Start(character)
    if not character or not character:IsA("HumanUnit") then
        return nil
    end

    local controller = character.Controller
    if not controller then
        return nil
    end

    -- 只有在确认要接管人形状态流时才关闭内建状态机评估。
    controller.EvaluateStateMachine = false

    return RunService.Heartbeat:Connect(function()
        local move = Vector3(0, 0, 0)
        if UserInputService:IsKeyDown(Enums.KeyCode.W) then
            move = move + Vector3(0, 0, 1)
        end
        if UserInputService:IsKeyDown(Enums.KeyCode.S) then
            move = move + Vector3(0, 0, -1)
        end
        if UserInputService:IsKeyDown(Enums.KeyCode.A) then
            move = move + Vector3(-1, 0, 0)
        end
        if UserInputService:IsKeyDown(Enums.KeyCode.D) then
            move = move + Vector3(1, 0, 0)
        end

        controller:Move(move, false)
        if UserInputService:IsKeyDown(Enums.KeyCode.Space) and controller:IsGrounded() then
            controller:Jump()
        end
    end)
end

function HumanControllerDriver.Stop(connection)
    if connection then
        connection:Disconnect()
    end
end

return HumanControllerDriver
```

这个示例只展示“每帧接管输入”的形态，不等于完整 3C。调用方必须保存 `Start` 返回的 Connection，并在 HumanUnit 销毁、脚本重载或退出控制时调用 `Stop`。真正上线还要补：输入状态缓存、相机相对方向、动画状态机、服务器校验、移动速度限制和截图/日志证据。

## Animator 与 AnimationTrack

当前 `HumanUnit` 公开 `Animator` 属性。创建 HumanUnit 时启用 `EnableAnimator`，再从 `human.Animator` 取得动画器，是最清晰的新手路径。`Animator` 本身在 Meta 中也允许创建，但 Parent 必须是拥有骨骼或动画组件的宿主；没有这种明确需求时不要重复创建。

`Animator:LoadAnimation` 接受两种公开输入：资源 URI 字符串，或 `Animation` 数据对象。返回的 `AnimationTrack` 不能直接创建，只能由 `LoadAnimation` 获得。

运行端：server

```lua
local World = game:GetService("World")
if not World then return end

local human = World:FindFirstChild("动画示例人形", true)
if not human or not human:IsA("HumanUnit") then
    print("[SE Lua Guide][WARN] 请先创建启用 Animator 的 HumanUnit。")
    return
end

local animator = human.Animator
if not animator then
    print("[SE Lua Guide][WARN] HumanUnit 尚未提供 Animator。")
    return
end

-- 简单写法：直接传 URI 字符串。
local track = animator:LoadAnimation("official://animation/24316")

-- 数据写法：先构造 Animation，再传给 LoadAnimation。
local animation = Animation.New("wave", "official://animation/24316")
local track2 = animator:LoadAnimation(animation)

print("[SE Lua Guide] 已加载两条动画轨道:", track ~= nil, track2 ~= nil)
```

`Animation.New(...)` 与 `Animation(...)` 等价；本章使用 `.New`，便于直接对照公开 API 页面。

## 按键播放动画

运行端：client  
 文件：`client/main.lua`

```lua
local World = game:GetService("World")
local UserInputService = game:GetService("UserInputService")
if not World or not UserInputService then return end

local human = World:FindFirstChild("动画示例人形", true)
if not human or not human:IsA("HumanUnit") then
    print("[SE Lua Guide][WARN] 请先准备名为「动画示例人形」且启用 Animator 的 HumanUnit。")
    return
end

local animator = human.Animator
if not animator then
    print("[SE Lua Guide][WARN] HumanUnit 尚未提供 Animator。")
    return
end

local animationId = "official://animation/24316"
local ok, trackOrError = pcall(function()
    return animator:LoadAnimation(animationId)
end)
if not ok or not trackOrError then
    print("[SE Lua Guide][WARN] 动画加载失败:", trackOrError)
    return
end

local track = trackOrError
track.Priority = Enums.AnimationPriority.Action

track.Ended:Once(function()
    print("[SE Lua Guide] 动画自然结束")
end)

track.Stopped:Once(function()
    print("[SE Lua Guide] 动画被主动停止")
end)

local inputConnection = UserInputService.InputBegan:Connect(function(inputObject, gameProcessedEvent)
    if gameProcessedEvent then return end
    if inputObject.UserInputType == Enums.UserInputType.Keyboard
        and inputObject.KeyCode == Enums.KeyCode.B then
        if track.IsPlaying then
            track:Stop(0.1)
        else
            track:Play(0.05, 1, 1)
        end
    end
end)
```

`Animator:LoadAnimation` 对同一个 contentId 会返回缓存轨道。示例在初始化时只加载一次，并持有返回的 `track`，避免每次按键重复加载。这里同时保留了 `inputConnection`；完整工程应在页面或模块销毁时调用 `inputConnection:Disconnect()`，第 19 章会统一处理生命周期。

## AnimationTrack 常用控制

| 能力 | 写法 | 说明 |
| --- | --- | --- |
| 播放 | `track:Play(fadeTime, weight, speed)` | 三个参数都有默认值 |
| 停止 | `track:Stop(fadeTime)` | 触发 `Stopped` |
| 调速 | `track:AdjustSpeed(speed)` | `0` 表示暂停，恢复非零值继续 |
| 调权重 | `track:AdjustWeight(weight, fadeTime)` | weight 通常取 0～1 |
| 自然结束 | `track.Ended` | 非循环动画播放到结尾触发 |
| 完成循环 | `track.DidLoop` | `Looped=true` 时每次循环触发 |

一次性提示可使用 `Once`；长期监听需要保存 Connection，并在宿主销毁或脚本重载时 `Disconnect()`。

## 动画表现与同步边界

当前公开 Meta/API 说明了 Animator 和 AnimationTrack 的本地调用契约，但没有承诺“任意客户端播放都会自动同步到服务端和其他客户端”。教程不能把历史运行现象写成公开保证。多人都需要看见的 NPC / BOSS 动画，应由 server 或项目明确验证过的同步链统一驱动；本地预览和 UI 表现可以在 client 播放。

| 场景 | 建议 |
| --- | --- |
| 本地预览、只影响当前玩家的表现 | client 播放 |
| 多人都需看见的 NPC / BOSS 动画 | server 或项目已验证的统一同步链驱动 |
| 技能是否命中、是否造成伤害 | server 判定 |
| 动画只是技能表现 | client 播放表现，server 同步结果 |

记住一句话：动画表现可以分端，玩法结果必须由 server 判定；表现是否跨端可见也要单独验证，不能靠猜。

## 常见错误

### 错误：绕过统一控制器入口

角色控制器统一从具体角色 Unit 的 `Controller` 取得。玩家 `Character` 按 EggyUnit / EggyController 使用；另行创建的 HumanUnit 按 HumanController 使用。通用模块只依赖 `BaseController` 能力。

### 错误：把 EggyController 和 HumanController 当成同一套能力

二者都继承 `BaseController`，所以都有移动、跳跃、状态、生命等基础能力；但蛋仔动作、抓举/投掷及 `ClimbEnabled` / `ClimbSpeed` 属于 `EggyController`，人形速度读取、坐下和状态事件属于 `HumanController`。不要仅凭相似概念互相搬运成员。

### 错误：过早关闭 HumanController 状态机

`EvaluateStateMachine = false` 意味着作者要接管更多控制责任。没有完整输入、动画、物理和 QA 方案时，不要为了“专业”而关闭它。

### 错误：从 EggyUnit 读取 Animator

当前 EggyUnit 没有公开 Animator 属性。需要骨骼动画时，从启用了 `EnableAnimator` 的 HumanUnit 读取 `human.Animator`，或者为明确支持骨骼的宿主创建并挂载 Animator。

### 错误：假定客户端动画必然自动同步

当前公开契约没有承诺任意客户端播放会广播到其他端。先按“本地表现”和“多人共同表现”分类，再选择 client、本地预览或 server 统一驱动，并在目标版本中留下行为证据。

### 错误：把动画表现当成技能判定

动画播了不代表命中。伤害、得分、击退、奖励必须由 server 按规则确认。

### 错误：动画优先级乱用

技能动作通常用 `Enums.AnimationPriority.Action` 或更高。不要主动使用 `Core`，它是引擎默认动画使用的保留语义。

## 练习任务

1. 等待本地角色，打印 `controller:GetState()`。
2. 监听 `StateChanged`，按状态打印不同提示。
3. 按 B 键播放动画，并用 `track:Stop(0.1)` 增加一个停止逻辑。
4. 写一句判断：这个动画对应的玩法结果应该由 client 还是 server 决定？
5. 选择一个人形 NPC 需求，列出是否需要 `HumanController` 的攀爬、速度事件、状态机接管；如果不需要，说明为什么继续用 `EggyUnit` 更合适。

## 本章验收标准

* [ ] 我知道控制器入口是 `character.Controller`。
* [ ] 我知道 `EggyController` 和 `HumanController` 都继承 `BaseController`，但专属能力不同。
* [ ] 我能等待本地 EggyUnit 与 EggyController 就绪。
* [ ] 我能用 `Animator:LoadAnimation` 和 `AnimationTrack:Play` 播放动画。
* [ ] 我知道 `Animation(...)` 与 `Animation.New(...)` 等价。
* [ ] 我知道 HumanUnit 公开 Animator，而 EggyUnit 当前没有公开 Animator 属性。
* [ ] 我不会假定客户端动画自动跨端同步，玩法结果仍由 server 判定。
* [ ] 我知道 `HumanController` 的状态机接管属于专业 3C 方向，需要额外 QA。

## 本章产物

* 一个 client HumanUnit 动画预览示例，包含加载、播放和停止。
* 一段状态变化日志，能说明 Controller 当前状态如何影响表现。
* 一张“动画表现 vs 玩法判定”分工表，标出哪些在 client，哪些必须回到 server。
* 一张 Controller 分层表：BaseController 通用能力、EggyController 蛋仔动作、HumanController 人形定制能力。

## 本章 API 对照

* [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html)
* [BaseController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseController.html)
* [EggyController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyController.html)
* [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html)
* [HumanController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanController.html)
* [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html)
* [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html)
* [Animation](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Animation.html)

## 下一章预告

角色能动，也能播放动作了。下一章学习相机系统：CameraService、CameraUnit、相机模式，以及如何把玩家看到的画面变成可控的玩法反馈。
