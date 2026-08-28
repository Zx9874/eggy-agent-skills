# PhysicsService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[PhysicsService]**（1 属性 / 14 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[PhysicsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PhysicsService.html) 提供空间查询与碰撞组管理能力：可执行射线、方块、球体、形状和重叠范围查询，也可注册碰撞组并配置组间碰撞关系。空间查询按公开的 common Realm 使用；碰撞组注册和关系变更由服务端权威配置。

## 适用场景

需要检测射线路径、查询指定盒体或半径内的单位，或配置特定碰撞组之间是否碰撞时使用。

## 使用要点

通过 game:GetService("PhysicsService") 获取服务。Raycast、Blockcast、Spherecast、Shapecast 的过滤参数在最新 Meta 中为可选；只有需要实例列表或碰撞组过滤时才构造 [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html)。

## 注意事项

[PhysicsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PhysicsService.html) 提供物理碰撞检测与碰撞组管理。Raycast/Blockcast/Spherecast 返回 [RaycastResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastResult.html) 或 nil；未命中时应依次检查方向向量长度、目标 PhysicsActive/CanQuery、FilterDescendantsInstances 和 CollisionGroup 关系。碰撞组注册与关系变更以服务端为权威，客户端不应承担配置职责。GetCollisionWithGroupDict 的最新 Meta 尚未声明返回值；在公开契约补齐前，不要读取或遍历其返回结果。2026-08-11 当前运行包的 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 桥接在首次调用 Blockcast/GetPartBoundsInBox 时可能写入 Lua VM warning，但调用会完成并返回结果；这是运行包告警，不应改用错误的 FromMatrix(pos, [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)) 形态规避。

## 代码示例

### 执行射线检测

```lua
-- @runtime client
local PhysicsService = game:GetService('PhysicsService')

local origin = Vector3.New(0, 10, 0)
local direction = Vector3.New(0, -100, 0)
local params = RaycastParams.New()
local hit = PhysicsService:Raycast(origin, direction, params)
if hit ~= nil and hit.Instance ~= nil then
    print('命中单位:', hit.Instance.Name, '距离:', hit.Distance)
else
    print('射线未命中')
end
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `ContinuousCollisionEnabled` | `Bool` | `false` | 控制物理引擎是否启用连续碰撞检测（CCD），用于减少高速运动物体的穿透现象。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (14)

### Raycast

签名：`Raycast(origin: Vector3, direction: Vector3, raycastParams?: RaycastParams) -> RaycastResult | nil (射线检测结果(无命中返回nil))`

射线检测。从指定起点沿指定方向发射射线进行检测，返回第一个命中的检测结果；未命中时返回 nil。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `origin` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 射线起点 |
| `direction` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 射线方向(长度=最大距离) |
| `raycastParams?` | [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html) | 射线过滤参数(可选) |

**返回值** [RaycastResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastResult.html) | nil (射线检测结果(无命中返回nil))

> 示例代码

> 射线检测并确认碰撞组服务状态

```lua
-- @runtime client
local physicsService = game:GetService("PhysicsService")
-- 从原点沿 Z 轴正方向发射一条最大距离 100 的射线
local origin = Vector3.New(0, 0, 0)
local direction = Vector3.New(0, 0, 100)
-- 射线过滤参数，未指定过滤对象时默认检测全部可碰撞对象
local raycastParams = RaycastParams.New()
local hit = physicsService:Raycast(origin, direction, raycastParams)
if hit then
    -- 命中时输出命中的单位与命中点位置
    print("射线命中:", hit.Instance.Name, "位置:", hit.Position)
else
    print("射线未命中任何对象")
end
-- 顺带查询当前已注册的碰撞组，确认服务状态
local groups = physicsService:GetRegisteredCollisionGroups()
print("已注册碰撞组数量:", #groups)
```

### Blockcast

签名：`Blockcast(cframe: CFrame, size: Vector3, direction: Vector3, raycastParams?: RaycastParams) -> RaycastResult | nil (命中结果(无命中返回nil))`

方块形状投射。以给定的位置与尺寸定义一个长方体形状，并沿指定方向进行投射检测，返回第一个命中的检测结果；未命中时返回 nil。

⚙ cframe 必须传 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)。当前运行包可能在首次桥接 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 时写 warning，但调用仍会完成。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `cframe` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | 方块位置与朝向 |
| `size` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 方块尺寸 |
| `direction` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 投射方向(长度=最大距离) |
| `raycastParams?` | [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html) | 过滤参数(可选) |

**返回值** [RaycastResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastResult.html) | nil (命中结果(无命中返回nil))

> 示例代码

> 向下执行方块投射

```lua
-- @runtime client
local PhysicsService = game:GetService('PhysicsService')
local cframe = CFrame.New(0, 5, 0)
local size = Vector3.New(2, 2, 2)
local direction = Vector3.New(0, -10, 0)
local result = PhysicsService:Blockcast(cframe, size, direction)
print(result and '方块投射命中' or '方块投射未命中')
```

### Spherecast

签名：`Spherecast(position: Vector3, radius: Float, direction: Vector3, raycastParams?: RaycastParams) -> RaycastResult | nil (命中结果(无命中返回nil))`

球形投射。以给定位置和半径定义球体形状，沿指定方向投射检测，返回第一个命中的检测结果；未命中时返回 nil。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 球心位置 |
| `radius` | `Float` | 球半径 |
| `direction` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 投射方向(长度=最大距离) |
| `raycastParams?` | [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html) | 过滤参数(可选) |

**返回值** [RaycastResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastResult.html) | nil (命中结果(无命中返回nil))

> 示例代码

> 球形投射检测前方障碍

```lua
-- @runtime client
local physicsService = game:GetService("PhysicsService")
-- 以原点为球心、半径 1.5 的球体沿 Z 轴正方向扫描 100 距离
local position = Vector3.New(0, 0, 0)
local direction = Vector3.New(0, 0, 100)
local hit = physicsService:Spherecast(position, 1.5, direction)
if hit then
    -- 命中后输出被扫中的单位与命中距离
    print("球形投射命中:", hit.Instance.Name, "距离:", hit.Distance)
else
    print("球形投射未命中任何对象")
end
```

### Shapecast

签名：`Shapecast(part: Unit, direction: Vector3, raycastParams?: RaycastParams) -> RaycastResult | nil (命中结果(无命中返回nil))`

形状投射。以指定 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 的碰撞形状为模板，沿指定方向投射检测，返回第一个命中的检测结果；未命中时返回 nil。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `part` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 用作形状的部件 |
| `direction` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 投射方向(长度=最大距离) |
| `raycastParams?` | [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html) | 过滤参数(可选) |

**返回值** [RaycastResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastResult.html) | nil (命中结果(无命中返回nil))

> 示例代码

> 使用临时形状执行投射并清理

```lua
-- @runtime client
local PhysicsService = game:GetService('PhysicsService')
local World = game:GetService('World')
local shapeUnit = World:CreateUnit('WorldUnit', {
    Position = Vector3.New(0, 5, 0),
    Scale = Vector3.New(1, 1, 1),
})
if shapeUnit == nil then return end

local result = PhysicsService:Shapecast(shapeUnit, Vector3.New(0, -10, 0))
if result ~= nil then
    print('形状投射命中:', result.Instance and result.Instance.Name)
end
shapeUnit:Destroy()
```

### RegisterCollisionGroup

签名：`RegisterCollisionGroup(name: String) -> void`

注册一个新的碰撞组，供后续碰撞关系设置使用。

⚙ 碰撞组注册属于服务端权威配置；客户端只读取已同步的碰撞关系，不负责注册。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 碰撞组名称 |

**返回值** `void`

> 示例代码

> 在服务端注册碰撞组

```lua
-- @runtime server
local PhysicsService = game:GetService('PhysicsService')
local groupName = 'DemoPlayer'
pcall(function()
    PhysicsService:RegisterCollisionGroup(groupName)
end)
```

### CollisionGroupSetCollidable

签名：`CollisionGroupSetCollidable(name1: String, name2: String, collidable: Bool) -> void`

设置两个碰撞组之间是否允许发生碰撞。

⚙ 碰撞关系修改属于服务端权威配置；客户端不应调用本方法承担初始化职责。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name1` | `String` | 碰撞组名称1 |
| `name2` | `String` | 碰撞组名称2 |
| `collidable` | `Bool` | 是否可碰撞 |

**返回值** `void`

> 示例代码

> 在服务端配置碰撞关系

```lua
-- @runtime server
local PhysicsService = game:GetService('PhysicsService')
pcall(function() PhysicsService:RegisterCollisionGroup('DemoPlayer') end)
pcall(function() PhysicsService:RegisterCollisionGroup('DemoGhost') end)
PhysicsService:CollisionGroupSetCollidable('DemoPlayer', 'DemoGhost', false)
```

### CollisionGroupsAreCollidable

签名：`CollisionGroupsAreCollidable(name1: String, name2: String) -> Bool (是否可碰撞)`

查询两个碰撞组之间当前是否允许发生碰撞。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name1` | `String` | 碰撞组名称1 |
| `name2` | `String` | 碰撞组名称2 |

**返回值** `Bool` (是否可碰撞)

> 示例代码

> 在服务端配置后核对碰撞关系

```lua
-- @runtime server
local PhysicsService = game:GetService('PhysicsService')
pcall(function() PhysicsService:RegisterCollisionGroup('DemoPlayer') end)
pcall(function() PhysicsService:RegisterCollisionGroup('DemoGhost') end)
PhysicsService:CollisionGroupSetCollidable('DemoPlayer', 'DemoGhost', false)
local canCollide = PhysicsService:CollisionGroupsAreCollidable('DemoPlayer', 'DemoGhost')
print('两个碰撞组是否可碰撞:', canCollide)
```

### GetRegisteredCollisionGroups

签名：`GetRegisteredCollisionGroups() -> Array<String> (碰撞组名称列表)`

获取所有已注册的碰撞组名称列表，包括引擎预留和用户注册的。

**返回值** `Array<String>` (碰撞组名称列表)

> 示例代码

> 幂等注册后读取全部碰撞组

```lua
-- @runtime server
local PhysicsService = game:GetService('PhysicsService')
pcall(function() PhysicsService:RegisterCollisionGroup('DemoPlayer') end)
pcall(function() PhysicsService:RegisterCollisionGroup('DemoGhost') end)
for index, name in ipairs(PhysicsService:GetRegisteredCollisionGroups()) do
    print('碰撞组', index, name)
end
```

### GetEngineRegisteredCollisionGroups

签名：`GetEngineRegisteredCollisionGroups() -> Array<String> (引擎预留碰撞组名称列表)`

获取引擎预留的碰撞组名称列表。

**返回值** `Array<String>` (引擎预留碰撞组名称列表)

> 示例代码

> 获取引擎预留碰撞组列表

```lua
-- @runtime client
-- 获取 PhysicsService 服务
local physicsService = game:GetService("PhysicsService")

-- 获取引擎预留的碰撞组名称列表
local engineGroups = physicsService:GetEngineRegisteredCollisionGroups()

-- 输出引擎预留碰撞组数量及名称
print("引擎预留碰撞组数量: " .. #engineGroups)
for i, name in ipairs(engineGroups) do
    print("引擎碰撞组[" .. i .. "]: " .. name)
end
```

### GetUserRegisteredCollisionGroups

签名：`GetUserRegisteredCollisionGroups() -> Array<String> (用户碰撞组名称列表)`

获取用户通过 RegisterCollisionGroup 注册的碰撞组名称列表。

**返回值** `Array<String>` (用户碰撞组名称列表)

> 示例代码

> 读取用户注册的碰撞组

```lua
-- @runtime server
local PhysicsService = game:GetService('PhysicsService')
pcall(function() PhysicsService:RegisterCollisionGroup('DemoPlayer') end)
for index, name in ipairs(PhysicsService:GetUserRegisteredCollisionGroups()) do
    print('用户碰撞组', index, name)
end
```

### GetCollisionWithGroupDict

签名：`GetCollisionWithGroupDict(collisionGroupName: String) -> void`

按名称查询指定碰撞组的关系；最新 Meta 未声明返回值，当前不要依赖返回数据。

⚙ 最新 Meta 仅声明 collisionGroupName 参数，未声明返回值；在 Meta 补齐前不要把运行时观察到的值当作公开 Table 契约。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `collisionGroupName` | `String` | 碰撞组名称 |

**返回值** `void`

> 示例代码

> 返回值契约尚未公开

```lua
-- @runtime client
print('GetCollisionWithGroupDict 的返回值尚未写入 Meta，请勿依赖')
```

### GetPartBoundsInBox

签名：`GetPartBoundsInBox(cframe: CFrame, size: Vector3, overlapParams?: OverlapParams) -> Array&lt;Unit&gt; (AABB与OBB重叠的Unit列表)`

OBB 区域查询。以给定的位置与尺寸构成一个有向包围盒（OBB），返回其范围内 AABB 与 OBB 重叠的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 列表。

⚙ cframe 必须传 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)；不要把 [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) 作为 CFrame.FromMatrix 的基向量参数。当前运行包可能在首次桥接 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 时写 warning，但查询仍会返回数组。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `cframe` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | OBB位姿 |
| `size` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | OBB尺寸 |
| `overlapParams?` | [OverlapParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OverlapParams.html) | 过滤参数(可选) |

**返回值** Array<[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)> (AABB与OBB重叠的[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)列表)

> 示例代码

> 查询方框范围内的单位

```lua
-- @runtime client
local PhysicsService = game:GetService('PhysicsService')
local cframe = CFrame.New(0, 5, 0)
local size = Vector3.New(10, 10, 10)
local units = PhysicsService:GetPartBoundsInBox(cframe, size)
print('范围内单位数:', #units)
```

### GetPartBoundsInRadius

签名：`GetPartBoundsInRadius(position: Vector3, radius: Float, overlapParams?: OverlapParams) -> Array&lt;Unit&gt; (AABB与球重叠的Unit列表)`

球形区域查询。以给定球心位置和半径构成一个球形范围，返回 AABB 与该球体重叠的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 列表。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 球心位置 |
| `radius` | `Float` | 球半径 |
| `overlapParams?` | [OverlapParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OverlapParams.html) | 过滤参数(可选) |

**返回值** Array<[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)> (AABB与球重叠的[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)列表)

> 示例代码

> 查询球形区域内的单位

```lua
-- @runtime client
local physicsService = game:GetService("PhysicsService")
-- 创建过滤参数，用于后续的区域查询（此处使用默认配置）
local overlapParams = OverlapParams.New()
-- 查询以原点为球心、半径 5 的球形区域内的所有单位
local center = Vector3.New(0, 0, 0)
local units = physicsService:GetPartBoundsInRadius(center, 5, overlapParams)
if #units > 0 then
    print("球形区域内检测到单位数量:", #units)
    for _, unit in ipairs(units) do
        print("  单位:", unit.Name)
    end
else
    print("球形区域内未检测到单位")
end
```

### GetPartsInPart

签名：`GetPartsInPart(part: Unit, overlapParams?: OverlapParams) -> Array&lt;Unit&gt; (与part碰撞形状精确重叠的Unit列表)`

精确形状重叠查询。返回与指定 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 的碰撞形状精确重叠的其他 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 列表。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `part` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 用于检测的参考[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) |
| `overlapParams?` | [OverlapParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OverlapParams.html) | 过滤参数(可选) |

**返回值** Array<[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)> (与part碰撞形状精确重叠的[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)列表)

> 示例代码

> 查询临时形状的重叠单位并清理

```lua
-- @runtime client
local PhysicsService = game:GetService('PhysicsService')
local World = game:GetService('World')
local queryPart = World:CreateUnit('WorldUnit', {
    Position = Vector3.New(0, 0, 0),
    Scale = Vector3.New(2, 2, 2),
})
if queryPart == nil then return end

for index, unit in ipairs(PhysicsService:GetPartsInPart(queryPart)) do
    print('重叠单位', index, unit.Name)
end
queryPart:Destroy()
```
