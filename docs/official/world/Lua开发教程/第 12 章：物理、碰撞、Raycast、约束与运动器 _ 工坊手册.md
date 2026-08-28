# 第 12 章：物理、碰撞、Raycast、约束与运动器

使用物理服务、射线检测、碰撞过滤和约束构建可验证的交互。

## 你会学到什么

* `WorldUnit`、`TriggerUnit` 和物理属性的分工。
* 碰撞事件、触发器事件、射线检测分别适合什么场景。
* 如何用 `PhysicsService` 管理碰撞组和空间查询。
* 什么时候用力 / 冲量，什么时候用运动器，什么时候再进入约束。

本章是第一轮主线后的按需进阶章节。新手先掌握碰撞、触发器和 Raycast；约束、运动器、复杂机关可以等项目真的需要时再回来查。

## 先分清三类物理问题

| 你想做什么 | 优先用什么 | 典型例子 |
| --- | --- | --- |
| 真实碰到并产生物理反应 | `WorldUnit` 碰撞事件 | 球撞方块、箱子被推开 |
| 进入区域就触发逻辑，不需要反弹 | `TriggerUnit` 触发器事件 | 得分区、传送门、伤害区 |
| 从一点向某方向探测是否命中 | `PhysicsService:Raycast` | 落地检测、视线检测、点击拾取 |
| 让物体按固定方式运动 | 具体运动器或脚本更新 | 移动平台、旋转障碍 |
| 让多个物体按物理连接关系运动 | Constraint | 门铰链、摆锤、连杆 |

不要一上来就写约束。很多玩法只需要“碰撞事件 + 防抖 + 计分”或“TriggerUnit + 进入/离开事件”。

## WorldUnit：会渲染也会物理

`WorldUnit` 是常见的 3D 物理实体。创建时若只传 `RenderMeshId`，缺省的 `PhysicsMeshId` 会使用这次创建所传的渲染网格。注意：对象创建完成后再修改 `RenderMeshId`，不会同步修改 `PhysicsMeshId`。只有外观和碰撞形状不同，或运行中更换网格时，才需要分别管理两个字段。

运行端：server

```lua
local World = game:GetService("World")
if not World then
    print("[SE Lua Guide][WARN] 当前运行域无法获取 World。")
    return
end

local box = World:CreateUnit("WorldUnit", {
    Name = "box",
    Position = Vector3(0, 3, 0),
    Scale = Vector3(2, 2, 2),
    RenderMeshId = "official://mesh/59268",
    BodyType = Enums.BodyType.Dynamic,
    PhysicsActive = true,
    GravityEnabled = true,
})

if not box then
    print("[SE Lua Guide][WARN] WorldUnit 创建失败。")
end
```

常用物理字段：

| 字段 | 含义 | 新手判断 |
| --- | --- | --- |
| `BodyType` | 刚体类型 | 地面/墙用 `Static`，可推动物体用 `Dynamic`，脚本控制平台用 `Kinematic` |
| `PhysicsActive` | 是否启用物理模拟 | 需要碰撞、受力、射线命中时保持 `true` |
| `CanCollide` | 是否参与物理碰撞 | 需要阻挡和反弹时为 `true` |
| `CanTouch` | 是否可触发碰撞事件 | 需要事件回调时为 `true` |
| `CanQuery` | 是否可被 Raycast / 区域查询命中 | 需要射线检测时为 `true` |
| `CollisionGroup` | 所属碰撞组 | 需要分层碰撞时再设置 |

`BodyType` 必须写枚举名，例如 `Enums.BodyType.Dynamic`，不要直接写数字。

## 碰撞事件：真实碰到才触发

运行端：server 或 client，涉及计分、胜负、机关状态时优先放 server。

```lua
local World = game:GetService("World")
if not World then return end

local ball = World:FindFirstChild("球体")
local cube = World:FindFirstChild("方块")

if not ball or not ball:IsA("WorldUnit") or not cube or not cube:IsA("WorldUnit") then
    print("[SE Lua Guide][WARN] 请先放置两个 WorldUnit，并命名为「球体」和「方块」。")
    return
end

local lastHitTime = 0

cube.OnCollisionEnter:Connect(function(otherUnit)
    if otherUnit ~= ball then return end

    local now = World:GetServerTime()
    if now - lastHitTime < 1 then
        return
    end
    lastHitTime = now

    print("[SE Lua Guide] 球体命中方块")
end)
```

物理碰撞可能在很短时间内连续触发多次，尤其是球体抖动、贴边、反弹时。计分、扣血、任务完成这类逻辑要做防抖。

## TriggerUnit：进入区域触发，不产生反弹

`TriggerUnit` 适合“检测进入/离开”，不适合做真实阻挡。事件名是 `OnTriggerEnter` / `OnTriggerExit`，不是 `OnEnter` / `OnExit`。

运行端：server

```lua
local World = game:GetService("World")
if not World then return end

local trigger = World:FindFirstChild("得分区")
if not trigger or not trigger:IsA("TriggerUnit") then
    print("[SE Lua Guide][WARN] 请先在场景中创建 TriggerUnit 并命名为「得分区」。")
    return
end

trigger.OnTriggerEnter:Connect(function(otherUnit)
    if otherUnit then
        print("[SE Lua Guide] 进入得分区:", otherUnit.Name)
    end
end)

trigger.OnTriggerExit:Connect(function(otherUnit)
    if otherUnit then
        print("[SE Lua Guide] 离开得分区:", otherUnit.Name)
    end
end)
```

如果你用代码创建触发器，常见写法是：

```lua
local World = game:GetService("World")
if not World then return end

local trigger = World:CreateUnit("TriggerUnit", {
    Name = "score_zone",
    CFrame = CFrame(0, 1, 0),
    Scale = Vector3(5, 2, 5),
    PhysicsActive = true,
})

if not trigger then
    print("[SE Lua Guide][WARN] TriggerUnit 创建失败。")
end
```

`CFrame(...)` 与 `CFrame.New(...)` 等价；本教程优先用简写，遇到 API 文档里的 `.New` 写法也要能读懂。

## Raycast：方向长度就是检测距离

Raycast 的 `direction` 不是单位方向，而是“方向 × 最大距离”。要从 10 米高向下检测 50 米，就写 `Vector3(0, -50, 0)`。

运行端：server 或 client。影响玩法结果时，最终判定应在 server。

```lua
local PhysicsService = game:GetService("PhysicsService")
if not PhysicsService then return end

local origin = Vector3(0, 10, 0)
local direction = Vector3(0, -50, 0)

local result = PhysicsService:Raycast(origin, direction)
if result then
    local hitUnit = result.Instance
    print("[SE Lua Guide] 命中对象:", hitUnit and hitUnit.Name or "未知对象")
    print("[SE Lua Guide] 命中位置:", result.Position)
    print("[SE Lua Guide] 命中距离:", result.Distance)
else
    print("[SE Lua Guide] 未命中")
end
```

`RaycastResult` 需要先判空。常用属性：

| 属性 | 含义 |
| --- | --- |
| `Instance` | 命中的 Unit |
| `Position` | 命中点世界坐标 |
| `Normal` | 命中面的法线方向 |
| `Distance` | 从起点到命中点的距离 |

## RaycastParams：过滤自己或限定碰撞组

如果射线从角色或道具身上发出，经常要排除自己，否则一发射就打到自己。

```lua
local PhysicsService = game:GetService("PhysicsService")
local World = game:GetService("World")
if not PhysicsService or not World then return end

local selfUnit = World:FindFirstChild("球体")
if not selfUnit then
    print("[SE Lua Guide][WARN] 未找到要排除的「球体」。")
    return
end

local params = RaycastParams.New()
params.FilterType = Enums.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { selfUnit }
-- CollisionGroup 默认是 nil；仅在已配置碰撞组关系时再设置具体组名

local result = PhysicsService:Raycast(
    Vector3(0, 10, 0),
    Vector3(0, -50, 0),
    params
)
```

射线过滤参数使用 `RaycastParams.New()` 创建。过滤类型使用枚举：`Enums.RaycastFilterType.Exclude` 或 `Enums.RaycastFilterType.Include`，不要直接写数字。

## 碰撞组：先全局规则，再挂到具体 Unit

碰撞组分两步：

1. 用 `PhysicsService` 注册组并设置组与组之间是否可碰撞。
2. 把具体物理 Unit 的 `CollisionGroup` 设置为已注册的组名。

运行端：server

```lua
local PhysicsService = game:GetService("PhysicsService")
local World = game:GetService("World")
if not PhysicsService or not World then return end

local function EnsureCollisionGroup(groupName)
    for _, registeredName in ipairs(PhysicsService:GetUserRegisteredCollisionGroups()) do
        if registeredName == groupName then
            return
        end
    end
    PhysicsService:RegisterCollisionGroup(groupName)
end

EnsureCollisionGroup("Player")
EnsureCollisionGroup("Pickup")

-- 玩家和拾取物不产生物理阻挡
PhysicsService:CollisionGroupSetCollidable("Player", "Pickup", false)

local canCollide = PhysicsService:CollisionGroupsAreCollidable("Player", "Pickup")
print("[SE Lua Guide] Player/Pickup 可碰撞:", canCollide)

local pickup = World:FindFirstChild("拾取物")
if pickup and pickup:IsA("WorldUnit") then
    pickup.CollisionGroup = "Pickup"
end
```

注册是全局规则，赋值才让具体对象进入该组。如果只是让两个具体物理对象不碰撞，也可以在 `PhysicsUnit`、`WorldUnit` 或 `TriggerUnit` 等公开了该函数的具体类型上调用 `AddNoCollisionPairWithUnit(otherUnit)`。对象少时用 pair 更直观；规则多时用碰撞组更清晰，不要把这个函数外推成所有 `Unit` 的能力。

## 力、冲量和速度

让动态物体动起来有三类常见方式：

| 方式 | API / 字段 | 适用 |
| --- | --- | --- |
| 持续施力 | `ApplyForceToCenterOfMass` | 风、持续推力、悬浮 |
| 瞬间冲量 | `ApplyImpulse` | 弹射、爆炸、击飞 |
| 直接速度 | `LinearVelocity` / `AngularVelocity` | 重置、短期脚本控制 |

运行端：server

```lua
local World = game:GetService("World")
if not World then return end

local ball = World:FindFirstChild("球体")
if ball and ball:IsA("WorldUnit") then
    ball:ApplyImpulse(Vector3(0, 80, 0))
end
```

使用力和冲量前确认对象是动态物体，且 `PhysicsActive = true`。如果对象是 `Static`，你给它施加力也不会得到想要的运动效果。

## 运动器：做稳定机关比手写每帧移动更合适

移动平台、旋转障碍、摆锤这类机关，优先考虑编辑器里的具体运动器。它们继承 `BaseMotorUnit` 的公开控制接口：

* `Start()` 启动，`Pause()` 暂停，`Resume()` 恢复，`Stop()` 停止。
* `OnMotorStart` / `OnMotorStop` 可监听状态。

常见类型：

| 类型 | 用途 |
| --- | --- |
| `LinearMotorUnit` | 直线移动平台、传送带 |
| `AngularMotorUnit` | 持续旋转障碍 |
| `PendulumMotorUnit` | 摆锤 |
| `WaypointMotorUnit` | 路径点移动 |

`IsActive` 在当前 Meta 中没有公开，教程代码不要读取或写入它。不同运动器还有各自的公开差异：例如 `LinearMotorUnit.LinearVelocity` 当前未公开，不能为了脚本调参去访问。新手通常先在编辑器配置运动方向和目标，再用 Lua 调整 `Duration`、`IsCycle` 等公开参数并控制启停。

运行端：server 或 client；权威机关状态优先由 server 控制。

```lua
local World = game:GetService("World")
if not World then return end

local motor = World:FindFirstChild("移动平台运动器", true)
if not motor or not motor:IsA("LinearMotorUnit") then
    print("[SE Lua Guide][WARN] 请先在编辑器中配置 LinearMotorUnit。")
    return
end

motor.Duration = 5
motor.IsCycle = true
motor.OnMotorStart:Once(function()
    print("[SE Lua Guide] 移动平台开始运动")
end)
motor:Start()
```

## 约束：真正需要物理连接时再用

约束用于把两个或多个物理对象按某种物理关系连接起来。它比运动器更底层，也更难调。

| 约束 | 作用 | 典型用途 |
| --- | --- | --- |
| `HingeConstraint` | 铰链，允许绕轴旋转 | 门、摆臂、车轮 |
| `PrismaticConstraint` | 滑轨，只允许沿轴移动 | 电梯、抽屉 |
| `BallSocketConstraint` | 球窝，自由旋转 | 万向节、吊挂 |
| `WeldConstraint` | 刚性焊接成一个整体 | 多零件组合、车体 |

约束的核心模型：

```text
物体 A -- Attachment -- Constraint -- Attachment -- 物体 B
```

当前 API 已公开 `Attachment`，也公开了约束上的 `Attachment0` / `Attachment1` 对象引用。绑定时直接使用 `Attachment` 实例，不要读取或填写仍未公开的 `Attachment0Id` / `Attachment1Id` 数字字段。对新手而言，先在编辑器里放置锚点、校准轴向和观察约束效果仍然更容易；Lua 再负责启停和修改公开参数。

运行端：server

```lua
local World = game:GetService("World")
if not World then return end

local hinge = World:FindFirstChild("门铰链", true)
if not hinge or not hinge:IsA("HingeConstraint") then
    print("[SE Lua Guide][WARN] 请先在编辑器中配置 HingeConstraint。")
    return
end

if not hinge.Attachment0 or not hinge.Attachment1 then
    print("[SE Lua Guide][WARN] 门铰链尚未绑定两个 Attachment。")
    return
end

hinge.Enabled = true
hinge.LimitsEnabled = true
hinge.LowerAngle = -45
hinge.UpperAngle = 90
```

如果只是想“子物体跟着父物体移动/旋转”，先看第 5 章的 `ModelBindParent`；如果想“几个物理部件刚性成为一个整体”，再看 `WeldConstraint`。两者不是同一种能力。

## 常见错误

### 错误：触发器事件名写错

`TriggerUnit` 的事件是 `OnTriggerEnter` / `OnTriggerExit`，不是 `OnEnter` / `OnExit`。

### 错误：Raycast direction 写成单位向量

`Vector3(0, -1, 0)` 只检测 1 米。要检测 50 米，应写 `Vector3(0, -50, 0)`。

### 错误：静态物体怎么推都不动

地面、墙体用 `Enums.BodyType.Static`；可推动的箱子、球体用 `Enums.BodyType.Dynamic`。

### 错误：把可视模型和碰撞模型混在一起

常规情况只写 `RenderMeshId` 即可；只有碰撞形状需要和外观不同，才显式设置 `PhysicsMeshId`。

### 错误：玩法判定只放客户端

客户端可以做瞄准预览、命中提示、镜头表现；计分、伤害、胜负、奖励这类权威结果应在 server 确认。

## 练习任务

1. 用 Raycast 做“向下检测是否落地”，打印命中的对象名和距离。
2. 创建一个 `TriggerUnit` 得分区，进入时打印进入对象名。
3. 注册 `Player` 和 `Pickup` 两个碰撞组，并设置它们互不阻挡。
4. 思考：移动平台的轨迹由 server 控制，客户端只做表现，会带来什么好处？

## 本章验收标准

* [ ] 我知道碰撞和触发器的区别。
* [ ] 我能正确使用 `OnCollisionEnter`、`OnTriggerEnter`。
* [ ] 我知道 Raycast 的 direction 长度就是最大检测距离。
* [ ] 我能用 `RaycastParams` 排除自己或限定碰撞组。
* [ ] 我知道 `Static`、`Dynamic`、`Kinematic` 的基本用途。
* [ ] 我知道什么时候选运动器，什么时候再考虑约束。

## 本章产物

* 一份物理/Raycast 运行记录，至少包含命中、未命中和过滤参数三种日志。
* 一个 Trigger 得分区或碰撞组最小场景，用来验证 server 权威判定。
* 一张“碰撞 / 触发 / Raycast / 运动器 / 约束”选型表，说明各自适用场景。

## 本章 API 对照

* [PhysicsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PhysicsService.html)
* [PhysicsUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PhysicsUnit.html)
* [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)
* [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html)
* [BaseMotorUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseMotorUnit.html)
* [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)
* [HingeConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/HingeConstraint.html)
* [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html)
* [RaycastResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastResult.html)

## 下一章预告

下一章开始进入 3C 系统。第 13 章先学习角色系统：EggyUnit、HumanUnit、玩家角色加载与外观。
