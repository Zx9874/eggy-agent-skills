# 第 2 章：编辑器对象、属性、坐标与枚举在 Lua 中的表达

学习安全查找对象、读写属性，并正确使用坐标、Data 构造器和命名枚举。

## 你会学到什么

* 如何在 Lua 中找到编辑器里摆放的对象。
* 为什么位置、旋转、颜色、枚举不是随意 table。
* 如何读写对象的属性。

## 编辑器对象在 Lua 中是什么

你在编辑器场景里摆放的球体、方块，在 Lua 中通过 `World` 场景树找到。查找函数的通用返回类型是 `Unit`，但对象实际会是 `WorldUnit`、`ModelUnit` 等更具体的类型。

具体类型决定了你能访问什么：`Unit` 基类公开名称、父子层级和生命周期；`WorldUnit` 这类物理对象才公开位置、旋转、碰撞等能力。**先确认类型，再访问成员**，是本章最重要的规则。

## 核心类型

| 编辑器里看到的概念 | Lua/SDK 类型 | 推荐写法 | 说明 |
| --- | --- | --- | --- |
| 位置 | `Vector3` | `Vector3(0, 1, 0)` | 三维坐标 |
| 旋转 | `Quaternion` | `Quaternion.FromEulerAngles(0, math.rad(90), 0)` | 欧拉角参数使用弧度 |
| 位置+旋转 | `CFrame` | `CFrame(0, 10, 0)` | 同时包含位置和旋转 |
| 颜色 | `Color` | `Color(255, 0, 0, 255)` | RGBA 分量使用 0～255；这里是不透明红色 |
| 枚举选项 | `Enums` | `Enums.KeyCode.B` | 枚举值 |

**构造写法说明**：可全局构造且支持直接调用的 Data 类型（包括常用内建 math 类型）通常支持两种等价写法：

* **简写（推荐）**：`Vector3(1, 2, 3)`、`Color(255, 0, 0, 255)`、`CFrame(0, 10, 0)`
* **完整写法（需要认识）**：`Vector3.New(1, 2, 3)`、`Color.New(255, 0, 0, 255)`、`CFrame.New(0, 10, 0)`

对这类类型来说，两者完全等价。教程正文优先使用简写，因为它更短、更接近编辑器属性值的直觉；阅读 API 文档或旧示例时看到 `.New(...)`，要知道它和简写表达同一个构造动作。

**分量名说明**：Meta 公开契约中 `Vector2` / `Vector3` 的分量属性是小写 `x`、`y`、`z`。构造器是全局的 `Vector3(...)`，读取分量统一写 `pos.x`；即使某些运行时版本兼容 `pos.X` 这类大写别名，教程和项目代码也不要依赖未进入 Meta 的别名。

> 注意：这条规则只适用于“可全局构造且支持直接调用”的 Data 类型。少数 Data 只能用 `TypeName.New(...)`，不能写 `TypeName(...)`；不可自建 Data、Unit、Service、EUI 节点等运行时对象也不能用 `TypeName.New()` 随手创建。遇到不确定的类型，以当前 API 文档里的“构造方式”一栏为准。

**重要**：不要用普通 table 伪造这些类型。引擎类型有特殊行为，table 无法替代。

## 坐标系

* 左手系，Y 轴向上（伸出左手，拇指=X，食指=Y 向上，中指=Z）。
* 逻辑帧 30fps。

## 属性面板与代码的对应

编辑器属性面板和 Lua API 有交集，但**面板里出现不代表脚本一定公开**。有些字段只供编辑器配置，有些字段在不同具体类型上名称不同；写代码前仍要查看该类型当前 API 页面。

| 具体公开类型 | 代码中的属性 | 说明 |
| --- | --- | --- |
| `Unit` | `unit.Name` | 基类公开名称，可读写 |
| `WorldUnit` 等 `BasePart` 子类 | `part.Position`、`part.Rotation`、`part.CFrame` | 公开空间变换；`CFrame` 同时包含位置和旋转 |
| `WorldUnit` 等 `BasePart` 子类 | `part.Scale`、`part.ModelVisible` | 物理渲染对象的缩放和模型可见性 |
| `ModelUnit` | `model.Position`、`model.Rotation` | 对模型枢轴的公开便捷属性；不要使用未公开的 `ModelUnit.Scale` |

**技巧**：先在编辑器中确认对象类型，再打开同名 API 页面。只有页面公开列出的成员才写入脚本；不要仅凭属性面板、旧示例或自动补全猜测。

## 场景准备

1. 放置一个球体，命名为“球体”，物理类型设为受力物体（`Dynamic`）。
2. 放置一个方块，命名为“方块”，物理类型设为运动物体（`Kinematic`）。

`Dynamic`、`Kinematic` 等物理类型会在[第 12 章](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/chapters/12-physics-raycast-constraints.html)详细说明；本章先按上述设置准备场景即可。

## 最小示例：查找对象并读取位置

运行端：server  
 文件：`server/main.lua`

```lua
-- 获取 World 服务：场景管理的核心
local World = game:GetService("World")

-- 按名称查找编辑器中摆放的对象
local ball = World:FindFirstChild("球体")
local cube = World:FindFirstChild("方块")

-- 安全检查
if not ball or not cube then
    print("[SE Lua Guide][WARN] 请先在场景中放置并命名「球体」和「方块」。")
    return
end

-- FindFirstChild 的通用返回类型是 Unit；先确认这个对象确实是物理组件。
if not ball:IsA("WorldUnit") then
    print("[SE Lua Guide][WARN] 「球体」必须是 WorldUnit 或其子类，当前类型不支持本例的位置读写。")
    return
end

-- WorldUnit 从 BasePart 获得公开 Position 属性。
local pos = ball.Position
print("[SE Lua Guide] 球体位置:", pos.x, pos.y, pos.z)

-- 读取方块的名称
print("[SE Lua Guide] 方块名称:", cube.Name)
```

## 最小示例：修改对象位置

运行端：server  
 文件：`server/main.lua`

对新手来说，设置物件坐标最简单的方式是直接用 `Position` 属性：

```lua
local World = game:GetService("World")
local ball = World:FindFirstChild("球体")
if not ball or not ball:IsA("WorldUnit") then
    print("[SE Lua Guide][WARN] 请先在场景中放置并命名一个 WorldUnit「球体」。")
    return
end

-- 最简写法：直接设 Position
ball.Position = Vector3(0, 5, 0)   -- 把球体移到坐标 (0, 5, 0)
```

这里能够写 `Position`，是因为示例先确认了对象为 `WorldUnit`。不要把这条规则推广到所有 `Unit`。`ModelUnit` 也单独公开了 `Position` / `Rotation`，它们是模型枢轴操作的便捷属性。

## 进阶：用 CFrame 同时设位置和旋转

当你需要**同时设置位置和旋转**时，才需要用 `CFrame`：

```lua
local World = game:GetService("World")
local ball = World:FindFirstChild("球体")
if not ball or not ball:IsA("WorldUnit") then
    print("[SE Lua Guide][WARN] 请先在场景中放置并命名一个 WorldUnit「球体」。")
    return
end

local position = CFrame.New(0, 5, 0)
local rotation = CFrame.FromEulerAnglesXYZ(0, math.rad(90), 0)

ball.CFrame = position * rotation  -- 位置(0,5,0)，绕 Y 转 90°
```

> **建议**：新手优先用 `Position` 设置位置；需要用角度描述旋转时，用 `Rotation = Quaternion.FromEulerAngles(...)`。只有在你已经理解四元数分量时，才直接写 `Quaternion(...)`。需要同时组合位置、旋转、朝向或插值时，再学习 `CFrame` / `PivotTo`。
>
> **角度单位别混用**：当前 Meta 中 `Quaternion.FromEulerAngles(...)` 和 `CFrame.FromEulerAnglesXYZ(...)` 都使用弧度。人更习惯用度数思考时，先用 `math.rad(90)` 转成弧度。
>
> **EffectUnit 特殊说明**：EffectUnit 有公开 `Position` 属性，也提供 `effect:SetPosition()` 方法。本教程在特效示例中统一使用 `SetPosition()`，便于和 `SetVisible()`、`SetScale()` 等 EffectUnit 方法保持同一风格。

## 枚举的使用

```lua
-- 枚举写法：Enums.<枚举类型>.<枚举值>
local keyCode = Enums.KeyCode.B           -- 键盘 B 键
local inputType = Enums.UserInputType.Keyboard  -- 键盘输入类型

print("KeyCode B =", keyCode)
print("Keyboard =", inputType)
```

日志里可能显示枚举的底层数值，但业务代码仍必须使用 `Enums.KeyCode.B`、`Enums.UserInputType.Keyboard` 这类命名枚举，不能把观察到的数字抄回代码。

## 常见错误

### 错误：用 table 伪造位置

```lua
-- 错误：这不是引擎 Vector3，引擎无法识别
local pos = {x = 0, y = 1, z = 0}
ball.Position = pos  -- 不会生效

-- 正确：使用引擎类型
ball.Position = Vector3(0, 1, 0)
```

### 错误：对象名称不一致

`FindFirstChild("球体")` 返回 nil，多半是因为编辑器里的对象实际叫"球"或"Ball"。请统一命名。

### 错误：只看名字，不确认具体类型

`FindFirstChild("球体")` 只保证找到同名 `Unit`，不保证它拥有 `Position`、`CFrame` 或碰撞事件。访问具体成员前，用 `IsA(...)` 或其它公开获取链确认类型。

### 错误：在 client 第一帧就找对象

客户端加载存在时序差异，可能导致对象暂时找不到。关键玩法逻辑建议先在 server 中完成。

## 练习任务

1. 在场景中放置三个对象并命名，在 server 中查找并打印它们的位置。
2. 用 `IsA("WorldUnit")` 确认类型后，修改一个物理对象的 CFrame，观察它是否移动和旋转。
3. 分别用 `Quaternion.FromEulerAngles(0, math.rad(90), 0)` 和 `CFrame.FromEulerAnglesXYZ(0, math.rad(90), 0)` 表达绕 Y 轴 90°，记住两者都接收弧度。
4. 打印 `Enums.KeyCode.B` 和 `Enums.UserInputType.Keyboard`；无论日志如何显示，都不要在业务代码里改写成裸数字。

## 本章验收标准

* [ ] 我知道如何用 `FindFirstChild` 找编辑器中命名的对象。
* [ ] 我知道通用返回值是 `Unit`，访问位置、碰撞等成员前要确认具体类型。
* [ ] 我知道位置、颜色、旋转应使用可全局构造的 Data 类型，优先写简写，也认识 `.New(...)`。
* [ ] 我知道颜色 RGBA 分量使用 0～255，欧拉角构造参数使用弧度。
* [ ] 我知道枚举写法是 `Enums.<类型>.<值>`。
* [ ] 我能读取和修改对象属性。

## 本章产物

本章产物是能在 Lua 中找到“球体”“方块”，确认“球体”的具体类型后再读写位置。第 22 章中 `World:FindFirstChild("球体")`、`Vector3(...)` 和小写 `x/y/z` 分量都来自这里。

## 本章 API 对照

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)
* [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
* [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
* [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)
* [KeyCode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/KeyCode.html)
* [UserInputType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputType.html)
* [BodyType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/BodyType.html)

## 下一章预告

你能找到对象和修改属性了。下一章我们将理解世界版"统一运转的世界"——为什么分数必须在服务端，客户端只负责显示。
