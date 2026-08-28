# 第 13 章：角色系统——EggyUnit、HumanUnit 与外观

区分玩家角色与自建人形，安全获取 Controller、Animator 和外观能力。

## 你会学到什么

* `Player` 和 `Character` 不是同一个对象。
* 当前公开的 `Player.Character` 是 `EggyUnit`，它封装了成熟蛋仔角色能力，简单易用。
* `HumanUnit` 面向通用人形角色，开放更多物理、碰撞和控制参数，适合更专业的角色定制。
* 如何等待角色加载，并用角色反查玩家。
* `EggyController`、`EggyAppearance`，以及 `HumanUnit.Animator` 分别负责什么。

## Player 与 Character

`Player` 代表玩家账号与对局身份，`Character` 代表场景里可移动、可碰撞、可播放动画的角色 Unit。

```text
Players
└── Player
    ├── UserId（字符串玩家编号） / GetName()
    ├── PlayerGui
    └── Character -> EggyUnit（当前公开契约）
          ├── Controller -> EggyController
          └── EggyAppearance -> 外观组件
```

在触发器、碰撞、Raycast 命中里，你拿到的是 Unit，不是 Player；它也不一定就是玩家角色。只有先确认对象是 `EggyUnit`，才传给当前公开签名只接受 `EggyUnit` 的 `GetPlayerFromCharacter`。

运行端：server 或 client

```lua
local Players = game:GetService("Players")
if not Players then return end

local function GetPlayerFromUnit(unit)
    if not unit or not unit:IsA("EggyUnit") then
        return nil
    end
    return Players:GetPlayerFromCharacter(unit)
end
```

找不到对应玩家时会返回 nil，后续读取玩家属性前要先判空。这条规则会贯穿计分、伤害、结算和排行榜。

## EggyUnit 与 HumanUnit

这两个类型都属于角色 Unit，但抽象层级完全不同。

| 类型 | 定位 | 优点 | 代价 |
| --- | --- | --- | --- |
| `EggyUnit` | 蛋仔角色，高层封装 | 默认蛋仔控制、移动、跳跃、前扑、翻滚、抓举、投掷和蛋仔外观能力都已经封装好 | 定制空间有限，更适合沿用蛋仔角色范式 |
| `HumanUnit` | 通用人形角色，底层能力更开放 | 暴露更多物理、碰撞、Animator、HumanController、攀爬、坐下、速度和状态机参数 | 需要作者自己设计更多 3C、动画、碰撞和同步规则 |

当前公开文档把 `Player.Character` 和 `CharacterAdded` 事件参数都标注为 `EggyUnit`。因此玩家主线围绕 `EggyUnit` 展开；`HumanUnit` 是另外创建的人形 Unit，适合 NPC、BOSS 或动作展示，不能把它当成 `Player.Character` 的另一种公开返回类型。

更具体地看：

| 维度 | EggyUnit | HumanUnit |
| --- | --- | --- |
| 角色范式 | 蛋仔玩法角色 | 通用人形角色 |
| Controller | `EggyController`，通过 `character.Controller` 取得 | `HumanController`，通过 `character.Controller` 取得 |
| 典型动作 | `EggyController` 的 `Rush()`、`Fling()`、`Lift()`、`Throw()` | 继承的 `Move()`、`MoveTo()`、`Jump()`，以及人形状态、速度读取 |
| 外观 | `EggyAppearance` 管理蛋仔外观 | 依赖人形 mesh、Animator、动画脚本和资源组织 |
| Unit 属性规模 | 位置、旋转、缩放、可见、Controller、EnableController、EggyAppearance 等高层入口；当前没有公开 Animator 属性 | 位置、旋转、缩放、RenderMeshId、Animator、BodyType、CanCollide、Mass、重力、速度、碰撞组等更底层属性 |
| Unit 事件 | 主要使用继承自 `Unit` 的子节点/销毁等事件，角色行为事件在 Controller 上 | 额外有 `OnCollisionEnter` / `OnCollisionExit`，Controller 上还有 Running、Climbing、FreeFalling、Seated 等事件 |
| 定制方式 | 调整蛋仔控制器参数和蛋仔动作，改外观，叠加技能/表现 | 可以从物理、碰撞、Animator、Controller 状态机和移动逻辑层面重新组织 3C |

第一轮学习建议：玩家主线和普通蛋仔 NPC 优先 `EggyUnit`。当你要做“人形敌人”“类动作游戏角色”“完全自定义移动/攀爬/坐下/倒地/起身”“非蛋仔骨骼动画角色”时，再考虑 `HumanUnit`。

## 等待角色加载

角色加载有时晚于玩家对象创建。不要在脚本一启动就假设 `player.Character` 必定存在。

运行端：server

```lua
local Players = game:GetService("Players")
if not Players then return end

local function OnCharacterReady(player, character)
    if not character or not character:IsA("EggyUnit") then
        return
    end

    print("[SE Lua Guide] 角色已加载:", player:GetName(), character.Name)
    print("[SE Lua Guide] 角色位置:", character:GetPosition())

    local controller = character.Controller
    if controller then
        print("[SE Lua Guide] Controller 已存在")
    end
end

local characterConnections = {}

local function BindPlayer(player)
    if characterConnections[player] then
        return
    end

    local lastCharacter = nil
    local function HandleCharacter(character)
        if character == lastCharacter then
            return
        end
        lastCharacter = character
        OnCharacterReady(player, character)
    end

    characterConnections[player] = player.CharacterAdded:Connect(HandleCharacter)
    HandleCharacter(player.Character)
end

Players.PlayerAdded:Connect(BindPlayer)
for _, player in ipairs(Players:GetPlayers()) do
    BindPlayer(player)
end

Players.PlayerRemoving:Connect(function(player)
    local connection = characterConnections[player]
    if connection then
        connection:Disconnect()
        characterConnections[player] = nil
    end
end)
```

运行端：client

```lua
local Players = game:GetService("Players")
local Task = game:GetService("Task")
if not Players or not Task then return end

local function WaitLocalCharacter()
    -- 最多等待约 5 秒；超时后交给调用方记录并停止当前流程。
    for _ = 1, 150 do
        local player = Players.LocalPlayer
        if player and player.Character then
            return player.Character
        end
        Task:Wait(0.033)
    end
    return nil
end

Task:Spawn(function()
    local character = WaitLocalCharacter()
    if not character or not character:IsA("EggyUnit") then
        print("[SE Lua Guide][WARN] 5 秒内未取得本地 EggyUnit。")
        return
    end
    print("[SE Lua Guide] 本地蛋仔角色已加载:", character.Name)
end)
```

实际项目里，等待逻辑最好封成函数或模块，不要在每个按钮、每个输入回调里重复写一段循环。这里的 5 秒是“让当前初始化流程有界”的教学值，不是角色加载时限：超时不代表角色之后不会出现。持续运行的系统应优先订阅 `CharacterAdded`，在角色到达或重生时重新初始化；一次性页面则可以提示用户重试或重新进入，而不是无限阻塞。

## 角色对象的常用入口

| 你要做什么 | 入口 |
| --- | --- |
| 读取 / 设置蛋仔位置 | `character:GetPosition()` / `character:SetPosition(Vector3(...))` |
| 读取 / 设置朝向 | `character:GetRotation()` / `character:SetRotation(Quaternion.FromEulerAngles(...))` |
| 获取控制器 | `character.Controller` |
| 获取 HumanUnit 动画器 | 先确认 `human:IsA("HumanUnit")`，再读 `human.Animator` |
| 获取外观组件 | `character.EggyAppearance` |
| 从玩家蛋仔角色找玩家 | 先确认 `character:IsA("EggyUnit")`，再调用 `Players:GetPlayerFromCharacter(character)` |

控制器统一从具体角色 Unit 的 `Controller` 取得，但属性类型不同：`EggyUnit.Controller` 是 `EggyController`，`HumanUnit.Controller` 是 `HumanController`。下面从公开的 `Player.Character` 取到的一定按 `EggyUnit` 使用；`HumanUnit` 在后文从 World 单独创建。

运行端：client 或 server

```lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
if not Players or not RunService then return end
local player = nil
if RunService:IsClient() then
    player = Players.LocalPlayer
else
    local allPlayers = Players:GetPlayers()
    player = allPlayers[1]
end
if not player then
    print("[SE Lua Guide][WARN] 当前没有玩家")
    return
end
local character = player.Character
if not character or not character:IsA("EggyUnit") then
    print("[SE Lua Guide][WARN] 当前没有已加载的角色")
    return
end

local controller = character.Controller
if not controller then
    print("[SE Lua Guide][WARN] 角色还没有 Controller:", character.Name)
    return
end

print("[SE Lua Guide] 这是 Player.Character，可通过 EggyController 使用蛋仔动作")
```

## 移动角色位置和朝向

运行端：server 或 client，取决于你的用途。权威传送、出生点、胜负状态建议由 server 做。

```lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = nil
if RunService:IsClient() then
    player = Players.LocalPlayer
else
    local allPlayers = Players:GetPlayers()
    player = allPlayers[1]
end
if not player then
    print("[SE Lua Guide][WARN] 当前没有玩家")
    return
end
local character = player.Character
if not character or not character:IsA("EggyUnit") then
    print("[SE Lua Guide][WARN] 当前没有已加载的角色")
    return
end

character:SetPosition(Vector3(0, 10, 0))

-- 绕 Y 轴旋转 180 度。FromEulerAngles 的三个参数是弧度（Pitch/Yaw/Roll）。
local rotation = Quaternion.FromEulerAngles(0, math.rad(180), 0)
character:SetRotation(rotation)
```

不要把 `Quaternion(0, 3.14159, 0)` 当作“绕 Y 轴 180 度”。`Quaternion(...)` 是四元数构造，不是欧拉角构造；需要从欧拉角转四元数时，用 `Quaternion.FromEulerAngles(...)`。

## 角色外观：先知道入口

`EggyAppearance` 是蛋仔外观组件，管理盲盒、染色、时装散件、配饰、脸型、表情等外观信息。第 13 章只建立认知，不把换装 API 展开成完整系统。

```lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
if not Players or not RunService then return end
local player = nil
if RunService:IsClient() then
    player = Players.LocalPlayer
else
    local allPlayers = Players:GetPlayers()
    player = allPlayers[1]
end
if not player then
    print("[SE Lua Guide][WARN] 当前没有玩家")
    return
end
local character = player.Character
if not character or not character:IsA("EggyUnit") then
    print("[SE Lua Guide][WARN] 当前没有已加载的角色")
    return
end

local appearance = character.EggyAppearance
if appearance then
    print("[SE Lua Guide] 可读取或设置蛋仔外观")
end
```

外观改动一般属于表现层，但如果它影响玩法身份、阵营或奖励展示，仍应由 server 决定“是否允许换”，客户端只负责发请求和显示结果。

## HumanUnit 什么时候用

`HumanUnit` 适合人形 NPC、BOSS、带骨骼动画的展示角色，也适合你要做更专业角色控制时使用。它有 `Controller` 和 `Animator`，并额外开放了更多物理与控制入口。

运行端：server

```lua
local World = game:GetService("World")
if not World then return end

local npc = World:CreateUnit("HumanUnit", {
    Name = "npc_guard",
    Position = Vector3(5, 0, 5),
    EnableController = true,
    EnableAnimator = true,
})

if not npc or not npc:IsA("HumanUnit") then
    print("[SE Lua Guide][WARN] HumanUnit 创建失败。")
    return
end

local controller = npc.Controller
local animator = npc.Animator
if not controller then
    print("[SE Lua Guide][WARN] HumanController 尚未创建。")
end
if not animator then
    print("[SE Lua Guide][WARN] Animator 尚未创建。")
end
```

常见人形定制点包括：

| 需求 | HumanUnit / HumanController 入口 |
| --- | --- |
| 自定义人形 mesh | `RenderMeshId` |
| 开关物理模拟 | `PhysicsActive`、`BodyType` |
| 碰撞与触发 | `CanCollide`、`CollisionGroup`、`OnCollisionEnter` / `OnCollisionExit` |
| 重力和速度 | `GravityEnabled`、`UseIndividualGravity`、`LinearVelocity`、`AngularVelocity` |
| 施加力 | `ApplyForceToCenterOfMass`、`ApplyForceAtWorldPosition` |
| 动画 | `Animator`、`EnableAnimator`、`EnableAnimScript` |
| 人形控制 | `HumanController` 的 `EvaluateStateMachine`、`GetMoveVelocity()`，以及 `Climbing` / `Running` / `Seated` 等事件 |

如果只是想用一个玩家蛋仔做主线角色，不要为了“看起来更高级”主动换成 `HumanUnit`。玩家角色加载、重生、出生点通常由引擎和 `Player` 相关 API 管理。`HumanUnit` 的优势是可塑性强，但它会把更多 3C 设计责任交给作者。

## 常见错误

### 错误：把 Player 当成 Character

`player.UserId`（字符串玩家编号）在 Player 上；位置、碰撞、动画在 Character 上。触发器回调给你的 `otherUnit` 通常是 Character，需要 `Players:GetPlayerFromCharacter(otherUnit)`。

### 错误：角色还没加载就访问属性

`player.Character` 可能暂时为 nil。使用 `CharacterAdded` 或封装等待函数。

### 错误：直接假设所有角色控制器能力相同

不同角色都从具体 Unit 的 `Controller` 取得控制器，但可用的专属能力不同。通用逻辑只依赖 `BaseController` 公开的移动、跳跃、状态等基础能力；蛋仔动作和人形状态事件需要先证明 Unit / Controller 的具体类型再调用。`ClimbEnabled`、`ClimbSpeed` 当前属于 `EggyController`，不能写成 `HumanController` 属性。

### 错误：把 HumanUnit 当成 EggyUnit 的升级版

`HumanUnit` 不是“更高级的蛋仔”。它是更底层、更开放的人形角色载体。项目没有明确的人形 mesh、动作状态机或自定义 3C 需求时，优先沿用 `EggyUnit` 会更稳。

### 错误：把四元数当欧拉角

`Quaternion(0, 3.14159, 0)` 不是“绕 Y 轴旋转 180 度”。用 `Quaternion.FromEulerAngles(0, math.rad(180), 0)`（参数是弧度，不是度）。

## 练习任务

1. 服务端监听 `PlayerAdded` 和 `CharacterAdded`，打印玩家名和角色位置。
2. 客户端等待本地角色加载，打印 `character.Controller` 是否存在。
3. 写一个触发器回调：拿到 `otherUnit` 后用 `Players:GetPlayerFromCharacter(otherUnit)` 反查玩家。
4. 写一张 `EggyUnit` / `HumanUnit` 选型表：你的项目是继续使用蛋仔角色，还是需要人形角色？理由是什么？

## 本章验收标准

* [ ] 我知道 `Player` 和 `Character` 的区别。
* [ ] 我知道玩家角色通常是 `EggyUnit`。
* [ ] 我知道 `EggyUnit` 是高层蛋仔封装，`HumanUnit` 是更开放的人形角色载体。
* [ ] 我能用 `CharacterAdded` 或等待函数处理角色加载时序。
* [ ] 我知道控制器入口是 `character.Controller`。
* [ ] 我知道 `Quaternion.FromEulerAngles` 和 `Quaternion(...)` 的区别。

## 本章产物

* 一段角色加载日志：PlayerAdded、CharacterAdded、角色类型和初始位置。
* 一个从碰撞对象反查 Player 的示例，避免把 Character 当作玩家身份。
* 一张角色入口表：`Player`、`Character`、`Controller`、`Animator`、外观相关能力分别在哪里取得。
* 一张 `EggyUnit` / `HumanUnit` 选型表，说明封装程度、可定制空间、Controller 差异和当前项目选择。

## 本章 API 对照

* [Players](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Players.html)
* [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)
* [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html)
* [EggyController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyController.html)
* [EggyAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EggyAppearance.html)
* [HumanUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanUnit.html)
* [HumanController](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HumanController.html)
* [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html)

## 下一章预告

角色对象拿到了。下一章继续学习角色控制与动画：如何使用 `Controller` 监听状态、触发动作，以及如何用 `Animator` 播放动画。
