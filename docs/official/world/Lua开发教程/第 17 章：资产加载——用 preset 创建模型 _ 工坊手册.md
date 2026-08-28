# 第 17 章：资产加载——用 preset 创建模型

按资源类型选择公开加载接口，正确挂载 preset，并处理类型与失败分支。

## 你会学到什么

* 官方资产和自定义资产的 URI 格式。
* 新手为什么优先用 `AssetService:LoadUnitAsset` / `LoadUnitAssetAsync` 加载 preset。
* 为什么加载后必须手动设置 Parent，以及如何按根的具体类型设置位姿。
* 什么时候才需要 `World:CreateUnit` 手动创建单个 Unit。
* `RenderMeshId`、`PhysicsMeshId` 和加载失败处理。

## 新手优先路径：加载 preset，而不是手拼模型

如果你的目标是“在场景里生成一个模型”，优先使用编辑器/资源面板里已经配置好的 preset：

运行端：server  
 文件：`server/main.lua`

```lua
local AssetService = game:GetService("AssetService")
local World = game:GetService("World")
if not AssetService or not World then return end

-- LoadUnitAsset 只接收 uri，返回的根 Unit 默认是“游离”的（不在世界树里）
local units = AssetService:LoadUnitAsset("official://preset/105205")

local root = units and units[1]
if not root then
    print("[SE Lua Guide][WARN] preset 加载失败或返回空数组。")
    return
end

-- 这个教学 preset 要求根类型为 ModelUnit，才能整体设置模型枢轴。
if not root:IsA("ModelUnit") then
    print("[SE Lua Guide][WARN] preset 根不是 ModelUnit，不能套用本例的整体位姿写法。")
    root:Destroy()
    return
end

-- 必须手动挂到 World 下，模型才进入活跃场景树。
root.Parent = World
root.Position = Vector3(0, 5, 0)
root.Rotation = Quaternion.FromEulerAngles(0, 0, 0)
print("[SE Lua Guide] preset 创建成功:", root.Name)
```

期望效果：试玩开始后，preset 根 Unit 被挂到 `World` 下，出现在 `Vector3(0, 5, 0)` 附近，并在输出窗口看到创建成功日志。

preset 里已经保存了模型层级、子对象、渲染资源、物理设置等信息。新手只需要关心三件事：

| 你要做什么 | 怎么写 |
| --- | --- |
| 让模型进入场景 | `root.Parent = World`（或 World 树下某个父 Unit） |
| 设置 ModelUnit 根的出生位置 | 先 `root:IsA("ModelUnit")`，再写 `root.Position = Vector3(...)` |
| 设置 ModelUnit 根的出生旋转 | 先证明类型，再写 `root.Rotation = Quaternion.FromEulerAngles(...)` |

`units[1]` 是资产根 Unit，但公开返回类型仍是 `Unit`。只有所选 preset 的根经 `IsA("ModelUnit")` 证明后，才能用 `Position` / `Rotation` 作为模型枢轴语法糖联动整个模型；其他根类型必须查对应类型页面，不能从 Unit 数组直接外推空间属性。

如果挂载后修改位置没有得到预期结果，不要给 `ModelUnit` 补写猜测出来的 `BodyType`：当前公开 `ModelUnit` 没有这个属性。按顺序检查根类型是否真是 `ModelUnit`、`Parent` 是否已设置到活跃场景树、写入的是根的 `Position` / `Rotation` 还是某个子 Unit；如果问题来自 preset 内部子物体的物理配置，应回到 preset 编辑配置，或先证明具体子类型后再使用该类型公开的物理属性。

## 资产 URI 格式

| URI 格式 | 含义 | 常见用途 |
| --- | --- | --- |
| `official://preset/{id}` | 官方 Unit 预设 | `LoadUnitAsset` / `LoadUnitAssetAsync` |
| `map://{name}` | 地图 Unit 资产 | `LoadUnitAsset` / `LoadUnitAssetAsync` |
| `official://mesh/{id}` | 官方网格 | `WorldUnit.RenderMeshId` / `PhysicsMeshId` |
| `official://audio/{id}` | 官方音频 | `SoundService` / `SoundUnit.SoundId` |
| `official://animation/{id}` | 官方动画 | `Animator:LoadAnimation` / `Animation.New` |
| `official://image/{id}` | 官方图片 | EUI 图片组件公开的资源字段 |
| `custom://...` | 用户生产内容 | 先按资产类型选择 Data/Unit 异步加载接口或对应公开接收字段 |

> 在编辑器中右键资源，选择“复制引用 ID”即可获取 URI。不要手写或猜 URI。 特效播放请看第 16 章：教程作者面门禁不开放 Lua 侧特效资源选择。先在编辑器中配置并命名特效对象，再通过公开对象树接口定位和控制它。

## LoadUnitAsset 与 LoadUnitAssetAsync

官方 preset 通常可以同步加载：

```lua
local AssetService = game:GetService("AssetService")
local World = game:GetService("World")
if not AssetService or not World then return end

local units = AssetService:LoadUnitAsset("official://preset/105205")
local root = units and units[1]
if root and root:IsA("ModelUnit") then
    root.Parent = World
    root.Position = Vector3(0, 5, 0)
else
    print("[SE Lua Guide][WARN] 加载失败，或该 preset 根不是本例要求的 ModelUnit。")
    if root then root:Destroy() end
end
```

自定义 preset 或需要下载的资源必须异步加载：

```lua
local AssetService = game:GetService("AssetService")
local World = game:GetService("World")
if not AssetService or not World then return end

AssetService:LoadUnitAssetAsync("custom://12345", function(ok, units)
    if not ok or not units or #units == 0 then
        print("[SE Lua Guide][WARN] 自定义资产加载失败")
        return
    end

    local root = units[1]
    if not root:IsA("ModelUnit") then
        print("[SE Lua Guide][WARN] 自定义 preset 根不是本例要求的 ModelUnit。")
        root:Destroy()
        return
    end

    root.Parent = World
    root.Position = Vector3(0, 5, 0)
    print("[SE Lua Guide] 自定义 preset 创建成功:", root.Name)
end)
```

### 为什么必须设 Parent？

`LoadUnitAsset` / `LoadUnitAssetAsync` 只接收资源 URI，返回的根 Unit 默认是“游离”的（Detached），不在世界树里。必须手动设置 Parent，决定它是否进入当前活跃场景。跨端可见性还取决于创建发生在哪一端和该 Unit 的复制契约，不能只凭 Parent 推断。

| 所在树 | 当前场景渲染/物理 | 跨端可见性 |
| --- | --- | --- |
| World 后代 | 具备进入活跃状态的前提 | 继续看创建端与具体 Unit 复制契约 |
| 无 Parent（游离） | 不进入活跃场景 | 不能当作已发布到场景的对象 |

所以加载 preset 后，通常先写 `root.Parent = World`（或 World 树下的某个父 Unit），再根据根的具体类型设置位姿。只有 ModelUnit 根才直接套用本章的整体 `Position` / `Rotation` 写法。

## 进阶：手动创建单个 WorldUnit

当你只需要一个简单物体，且知道它的网格资源时，可以手动创建 `WorldUnit`：

```lua
local World = game:GetService("World")
if not World then return end

local box = World:CreateUnit("WorldUnit", {
    Name = "Box",
    Position = Vector3(0, 5, 0),
    RenderMeshId = "official://mesh/59268",
    BodyType = Enums.BodyType.Dynamic,
})

if not box then
    print("[SE Lua Guide][WARN] WorldUnit 创建失败。")
end
```

创建时未传 `PhysicsMeshId`，会使用这次创建所传的 `RenderMeshId`，因此多数新手示例只需要写渲染网格。对象创建完成后再修改 RenderMeshId 不会同步修改物理网格；运行中换网格时要分别管理。只有“看起来的模型”和“用于碰撞的模型”需要不同资源，才在创建时显式填写两者：

```lua
local World = game:GetService("World")
if not World then return end

local bridge = World:CreateUnit("WorldUnit", {
    Name = "Bridge",
    Position = Vector3(0, 5, 0),
    RenderMeshId = "official://mesh/59268",
    PhysicsMeshId = "official://mesh/59273",
})

if not bridge then
    print("[SE Lua Guide][WARN] Bridge 创建失败。")
end
```

## 选择建议

| 目标 | 推荐方式 |
| --- | --- |
| 生成一个完整模型或编辑器预设 | `AssetService:LoadUnitAsset("official://preset/...")` |
| 生成自定义上传的模型组合 | `AssetService:LoadUnitAssetAsync("custom://...")` |
| 创建一个简单可见物体 | `World:CreateUnit("WorldUnit", values)` |
| 创建游离 Unit 做高级组装 | `game:CreateUnit(type, values)`；Parent 语义与清理责任必须由调用方明确设计 |

第一轮学习先掌握 preset 路线。`CreateUnit` 更适合你已经知道 Unit 类型、资源字段和物理属性时使用。

## 资产加载失败处理

```lua
local AssetService = game:GetService("AssetService")
if not AssetService then return end

AssetService.AssetFetchFailed:Connect(function(uri, errorMsg)
    print("[SE Lua Guide][WARN] 资产加载失败:", uri, errorMsg)
end)
```

自定义资产尤其要准备降级方案，例如失败时加载一个官方 preset。

## 预加载资产

```lua
local AssetService = game:GetService("AssetService")
if not AssetService then return end

AssetService:PreloadAsync({
    "official://preset/105205",
    "official://audio/10772",
    "official://animation/24316",
}, function(uri, status)
    print("[SE Lua Guide] 预加载:", uri, "状态:", status)
end)
```

## 常见错误

### 错误：用 mesh 当 preset 加载

`official://mesh/{id}` 是网格资源，通常填给 `RenderMeshId`；`LoadUnitAsset` / `LoadUnitAssetAsync` 加载的是 Unit 资产，常见 URI 是 `official://preset/{id}` 或 `custom://...`。

### 错误：加载 preset 后忘了 Parent

加载成功不等于已经进场景。忘写 `root.Parent = World` 时，根 Unit 游离，玩家看不到，也不参与物理。

### 错误：误以为后改 RenderMeshId 会同步物理网格

缺省继承只发生在初始创建阶段。创建时碰撞模型和渲染模型相同，可以只传 RenderMeshId；对象创建后再更换渲染网格，不会自动更新 PhysicsMeshId。

### 错误：用同步接口加载 custom://

`custom://` 资源需要下载，必须使用已经公开的异步加载接口，并处理失败分支。完整 Unit 资产使用 `LoadUnitAssetAsync`。当前公开契约没有“异步 `CreateUnit`”接口，因此不要把 `custom://mesh/...` 直接塞进同步 `World:CreateUnit` 后假设引擎会等待下载；请先在编辑器中把自定义网格保存为 preset，再用 `LoadUnitAssetAsync` 加载。若未来 Meta 新增了明确的单网格异步接口，应以届时的 API 页面签名为准。

## 练习任务

1. 用 `LoadUnitAsset` 加载一个官方 preset，再 `root.Parent = World` 并设置 `Position`。
2. 把根 Unit 移动到另一个位置，观察整个模型是否移动。
3. 用 `World:CreateUnit` 创建一个简单 `WorldUnit`，只填写 `RenderMeshId`，不填写 `PhysicsMeshId`。
4. 写一个 `custom://` 加载失败时降级到官方 preset 的逻辑。

## 本章验收标准

* [ ] 我知道新手创建模型优先使用 preset。
* [ ] 我知道 `LoadUnitAsset` / `LoadUnitAssetAsync` 返回的 `units[1]` 是根 Unit。
* [ ] 我知道加载后必须手动 `root.Parent = World`，根 Unit 才会进入场景。
* [ ] 我知道 `ModelUnit.Position` / `Rotation` 可用于整体移动和旋转模型。
* [ ] 我知道 `PhysicsMeshId` 缺省时会自动使用 `RenderMeshId`。

## 本章产物

* 一个官方 preset 加载记录，包含 URI、Parent、Position 和根 Unit 名称。
* 一个单个 `WorldUnit` 创建示例，能说明 `RenderMeshId` / `PhysicsMeshId` 的关系。
* 一份加载失败处理草案，为第 18 章自定义资产降级逻辑做准备。

## 本章 API 对照

* [AssetService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/AssetService.html)
* [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)
* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [ModelUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html)
* [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)

## 下一章预告

官方 preset 用完了怎么办？下一章我们将学习自定义资产系统：上传自己的模型、图片和音频，并用异步方式安全加载。
