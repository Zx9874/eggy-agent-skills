# 第 5 章：Unit 与场景树

掌握 World 场景树、Unit 查找、类型收窄、创建和生命周期管理。

## 你会学到什么

* Unit 是什么，World 和 Unit 的关系。
* 如何用 `FindFirstChild` 查找对象。
* 如何创建、移动、销毁 Unit。
* 对象命名和父子层级的重要性。
* `ModelUnit.Position` / `Rotation` 和 `ModelBindParent` 如何帮助你整体移动模型。

## World 和 Unit

* `World`：通过 `game:GetService("World")` 获取的 Service，代表当前可见 Unit Tree 的根节点。
* `Unit`：场景对象在 Lua 中的抽象。球体、方块、触发器都是 Unit。
* `World` 是一个明确的跨 Kind 例外：它的类型是 Service，但公开继承关系让它可以使用 `FindFirstChild` 等 Unit 层级能力。不要据此推断其他 Service 也是 Unit。

## Unit 的继承关系

Service 通过 `game:GetService()` 获取，不属于运行时创建的场景 Unit。Unit 体系主要描述场景对象、角色、约束、特效等可以挂在层级树里的对象：

```text
Unit（基类）
├── ModelUnit（模型容器）
│   └── WorldRoot（世界根的 Unit 类型）
├── BasePart（物理部件）
│   ├── PhysicsUnit（物理对象）
│   ├── TriggerUnit（触发器）
│   ├── WorldUnit（世界对象）
│   └── ...

World（Service）── 通过公开关系指向当前 WorldRoot，并保留层级查询能力
```

## 最小示例：查找对象

运行端：server  
 文件：`server/main.lua`

```lua
local World = game:GetService("World")

if not World then
    print("[SE Lua Guide][ERROR] World 服务获取失败")
    return
end

-- 按名称查找 World 的直接子节点
local ball = World:FindFirstChild("球体")
local cube = World:FindFirstChild("方块")

if not ball or not cube then
    print("[SE Lua Guide][WARN] 请先在场景中放置并命名对象。")
    return
end

print("[SE Lua Guide] 球体:", ball)
print("[SE Lua Guide] 方块:", cube)

-- FindFirstChild 的返回类型是泛 Unit；访问 CFrame 前先确认具体类型。
if ball:IsA("BasePart") then
    print("[SE Lua Guide] 球体位置:", ball.CFrame.Position)
else
    print("[SE Lua Guide][WARN] 名为“球体”的对象不是 BasePart，不能读取 CFrame。")
end
```

## 进阶：创建和销毁 Unit

```lua
local World = game:GetService("World")
local Task = game:GetService("Task")

if not World or not Task then
    print("[SE Lua Guide][ERROR] World 或 Task 服务获取失败")
    return
end

-- 创建一个 WorldUnit 并设置初始位置
local newUnit = World:CreateUnit("WorldUnit", {
    Name = "动态方块",
    Position = Vector3.New(0, 10, 0),
    RenderMeshId = "official://mesh/59268",
})

if newUnit then
    print("[SE Lua Guide] 创建成功:", newUnit.Name)

    -- 延迟 3 秒后销毁
    Task:Delay(3, function()
        newUnit:Destroy()
        print("[SE Lua Guide] 已销毁")
    end)
end
```

## ModelUnit：模型容器也能直接设 Position / Rotation

`ModelUnit` 常用来把多个子对象组合成一个整体。公开 API 提供 `Position` 和 `Rotation` 便捷属性：它们按模型枢轴移动或旋转整个组合。复杂模型应先设置 `WorldPivot` 或 `PrimaryPart`，避免默认原点枢轴造成意外偏移。

```lua
local World = game:GetService("World")

if not World then
    print("[SE Lua Guide][ERROR] World 服务获取失败")
    return
end

local ball = World:FindFirstChild("球体")
local cube = World:FindFirstChild("方块")
if not ball or not cube then
    print("[SE Lua Guide][WARN] 请先在场景中放置并命名球体、方块。")
    return
end

local model = World:CreateUnit("ModelUnit", {
    Name = "移动平台",
    WorldPivot = CFrame.New(0, 3, 0),
})

if model and model:IsA("ModelUnit") then
    -- 将球体和方块放到 model 容器下，再整体移动模型。
    ball.Parent = model
    cube.Parent = model

    -- Position / Rotation 都是按模型枢轴工作的便捷属性。
    model.Position = Vector3.New(0, 5, 0)
    -- FromEulerAngles 的三个参数都是弧度；这里绕 Y 轴旋转 15 度。
    model.Rotation = Quaternion.FromEulerAngles(0, math.rad(15), 0)
else
    print("[SE Lua Guide][ERROR] ModelUnit 创建失败")
end
```

对新手来说，`Position` 比直接计算完整 `CFrame` 更直观；但要记住它仍然依赖模型枢轴。需要同时控制位置与旋转时，再使用公开的 `PivotTo(CFrame)`。

## 进阶：父子层级与 ModelBindParent

```lua
local World = game:GetService("World")

if not World then
    print("[SE Lua Guide][ERROR] World 服务获取失败")
    return
end

local ball = World:FindFirstChild("球体")
local cube = World:FindFirstChild("方块")
if not ball or not cube then
    print("[SE Lua Guide][WARN] 请先在场景中放置并命名球体、方块。")
    return
end

-- 获取球体的父节点
local parent = ball.Parent
print("球体的父节点:", parent)

-- 把球体设为方块的子节点
ball.Parent = cube
```

设置父子关系只是把对象放到同一棵层级树里，不必然表示“父对象移动，子对象也跟着做模型变换”。表现层跟随通常由 **ModelBindParent** 控制。它会根据父子双方的 `Position` / `Rotation` 记录相对变换，让子对象在表现层跟随父对象。

`ModelBindParent` 不是所有 Unit 都有。当前 published/meta 中，`RenderUnit`、`PhysicsUnit`、`TriggerUnit`、`RenderTriggerUnit` 等常见可视/物理对象有这个属性；使用前应查对应 Unit 文档。

```lua
local World = game:GetService("World")

if not World then
    print("[SE Lua Guide][ERROR] World 服务获取失败")
    return
end

local parent = World:CreateUnit("RenderUnit", {
    Name = "父模型",
    Position = Vector3.New(0, 3, 0),
    RenderMeshId = "official://mesh/59268",
})

local child = World:CreateUnit("RenderUnit", {
    Name = "跟随装饰",
    Parent = parent,
    Position = Vector3.New(0, 4, 0),
    RenderMeshId = "official://mesh/59268",
    ModelBindParent = true,
})

if parent and child and parent:IsA("RenderUnit") and child:IsA("RenderUnit") then
    parent.Position = Vector3.New(0, 6, 0)
    print("[SE Lua Guide] 子模型将按相对关系跟随父模型:", child)
else
    print("[SE Lua Guide][ERROR] RenderUnit 创建失败")
end
```

默认值通常为 `false`。如果只是把对象挂到父节点下做组织管理，不想跟随父节点变换，就不要打开它。

### 更专业的做法：WeldConstraint（焊接约束）

ModelBindParent 是简化用法，适合"表现层跟随"的场景。当你需要**多个物理对象刚性绑定为一个整体**时（例如把武器焊在角色身上、把多个零件组成一台车），应使用 **WeldConstraint**。

WeldConstraint 会把多个 `BasePart` 刚性焊接成一个装配体。当前公开 API 已提供服务端创建参数 `ExpectRootUnit` 和 `ConnectUnitList`，可以直接传对象引用，不需要也不应该访问内部 Unit ID 字段。完整创建示例和 `GetRootUnit()` 说明请查看本章末的 WeldConstraint API 页面。

**ModelBindParent vs WeldConstraint 选择建议**：

| 场景 | 推荐方式 |
| --- | --- |
| 纯表现跟随（装饰件跟物体、模型子件跟父模型） | ModelBindParent |
| 物理刚性绑定（武器焊手上、多零件组车） | WeldConstraint |

> WeldConstraint 属于进阶内容，第一轮学习可以跳过。真正使用时，连接列表中的对象应是公开契约要求的 `BasePart`，并在 server 创建约束。

## 自定义属性：SetAttribute / GetAttribute

除了内置属性，你还可以给 Unit 添加自定义属性，用于存储游戏状态：

```lua
local World = game:GetService("World")

if not World then
    print("[SE Lua Guide][ERROR] World 服务获取失败")
    return
end

local ball = World:FindFirstChild("球体")
if not ball then
    print("[SE Lua Guide][WARN] 未找到球体")
    return
end

-- 给球体设置自定义属性
ball:SetAttribute("LastOwnerUID", "12345")
ball:SetAttribute("Score", 10)

-- 读取自定义属性
local owner = ball:GetAttribute("LastOwnerUID")
local score = ball:GetAttribute("Score")
print("最后持有者:", owner, "分数:", score)
```

**重要规则**：

* `SetAttribute` / `GetAttribute` 只操作自定义属性，不是修改 `Name`、`Parent`、`Position` 等内置属性的通用入口。
* 当前公开契约没有承诺“客户端写入后如何跨端同步”。计分、归属、胜负等权威数据仍应由 server 维护，不要依赖客户端写属性来改变事实。
* 需要响应变化时，可使用公开的 `GetAttributeChangedSignal("属性名")`；监听建立后仍应主动读取一次当前值，避免只等下一次变化。

## 对象命名建议

* 名字稳定，不随便改。
* 避免同一级多个对象重名（`FindFirstChild` 只返回第一个）。
* 关键对象使用容易理解的名称，如 `球体`、`方块`、`GoalTrigger`。

## 常见错误

### 错误：同名对象只返回第一个

如果 World 下有两个叫"球体"的对象，`FindFirstChild` 只返回找到的第一个。

### 错误：客户端加载时序

客户端资源加载可能有时序差异，导致对象暂时找不到。关键逻辑建议先在 server 中完成。

### 错误：销毁后仍使用旧引用

对象被 `Destroy()` 销毁后，旧引用会失效。访问已销毁对象的属性会出错。

## 练习任务

1. 在场景中放置并命名三个对象，在 server 中查找并打印位置。
2. 用 `CreateUnit` 动态创建一个对象，3 秒后销毁。
3. 创建一个 `ModelUnit`，设置 `Position`，观察整组模型移动。
4. 读取一个对象的 `Parent`，打开/关闭 `ModelBindParent`，观察父子跟随差异。

## 本章验收标准

* [ ] 我知道 World 是场景根对象，Unit 是场景对象的抽象。
* [ ] 我能用 `FindFirstChild` 按名称查找对象。
* [ ] 我能用 `CreateUnit` 创建对象、`Destroy()` 销毁对象。
* [ ] 我知道 `ModelUnit.Position` / `Rotation` 是移动整个模型的简化写法。
* [ ] 我知道同名对象和加载时序的注意事项。

## 本章产物

本章产物是稳定的场景对象引用和生命周期意识。第 22 章会把球体、方块、特效 Unit 都当成场景树里的对象处理，并在缺失时打印 WARN，而不是直接 nil 报错。

## 本章 API 对照

* [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)
* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)
* [ModelUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html)
* [RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html)
* [WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html)

## 下一章预告

你能查找和创建 Unit 了。下一章是主线项目的关键：用碰撞事件实现"球体碰方块→提示→特效→重置"的完整玩法反馈。
