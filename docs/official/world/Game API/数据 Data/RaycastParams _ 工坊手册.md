# RaycastParams

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

射线检测的过滤参数，用于控制 [PhysicsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PhysicsService.html) 的射线、球体、盒体与形状检测在命中判定时排除或仅保留指定单位，同时支持按碰撞组进行二次过滤。它通过过滤类型、实例列表和碰撞组三个关键字段共同决定最终命中结果。

## 适用场景

当需要让射线检测只命中特定单位（如地面）或排除某个动态盒子时，构造过滤参数并传给射线检测调用，是物理交互玩法中最常用的过滤手段。

## 使用要点

先调用 RaycastParams.New() 创建实例，再设置 FilterType 为 Enums.RaycastFilterType.Include 或 Exclude，并将需要过滤的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 列表赋给 FilterDescendantsInstances。将配置好的实例作为第三个参数传给 PhysicsService:Raycast，即可按过滤规则得到命中结果；CollisionGroup 字段可选，用于按已配置的碰撞关系进一步过滤。

## 注意事项

[RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html) 是 PhysicsService:Raycast/Blockcast/Spherecast/Shapecast 的可选过滤参数；需要过滤时先用 RaycastParams.New() 构造，再设置 FilterType、FilterDescendantsInstances、CollisionGroup。FilterType 建议使用 Enums.RaycastFilterType.Include/Exclude。CollisionGroup 是用于按已配置碰撞关系过滤的组名，不是只按 WorldUnit.CollisionGroup 字符串同名匹配；最终结果同时受目标 WorldUnit.CollisionGroup、碰撞关系配置和实例过滤影响。不设置（nil，Meta 默认值）表示不启用碰撞组过滤。

## 代码示例

### 构造并配置射线过滤参数

```lua
-- @runtime client
-- 使用简写构造 RaycastParams，等价于 RaycastParams.New()
local params = RaycastParams()

-- 打印 SDK 默认的过滤配置，便于确认初始状态
print('默认 FilterType =', tostring(params.FilterType))
print('默认 CollisionGroup =', params.CollisionGroup)

-- 配置为仅包含指定实例的过滤模式
params.FilterType = Enums.RaycastFilterType.Include
params.CollisionGroup = 'Default'
params.FilterDescendantsInstances = {}

-- 打印更新后的过滤配置
print('更新后 FilterType =', tostring(params.FilterType))
```

### 配合 PhysicsService 执行排除自身的射线检测

```lua
-- @runtime client
-- 获取物理与玩家服务
local PhysicsService = game:GetService('PhysicsService')
local Players = game:GetService('Players')

-- 构造过滤参数：排除玩家自身角色，避免射线命中自己
local params = RaycastParams.New()
params.FilterType = Enums.RaycastFilterType.Exclude
params.CollisionGroup = 'Default'

-- 若角色尚未加载则退化为空过滤列表
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local character = localPlayer.Character
params.FilterDescendantsInstances = character and { character } or {}

-- 从 (0, 20, 0) 向下发射长距离射线，观察命中物体
local origin = Vector3.New(0, 20, 0)
local direction = Vector3.New(0, -500, 0)
local hit = PhysicsService:Raycast(origin, direction, params)
if hit then
    print('命中单位:', hit.Instance.Name)
else
    print('未命中任何单位')
end
```

### 创建 RaycastParams 并传入 PhysicsService:Raycast

```lua
-- @runtime client
local PhysicsService = game:GetService("PhysicsService")

local params = RaycastParams.New()
params.FilterType = Enums.RaycastFilterType.Exclude
-- 如需忽略某些单位，将已存在的 Unit 实例放入数组；空数组表示不排除特定单位
params.FilterDescendantsInstances = {}
-- CollisionGroup 默认是 nil；仅在已配置碰撞组关系时再设置组名

-- direction 的长度就是最大检测距离
local origin = Vector3.New(0, 5, 0)
local direction = Vector3.New(0, -100, 0)
local result = PhysicsService:Raycast(origin, direction, params)
if result ~= nil then
    print("命中位置:", result.Position)
end
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `FilterType` | [RaycastFilterType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/RaycastFilterType.html) | `Enums.RaycastFilterType.Exclude` | 过滤模式：Exclude 排除列表中的实例，Include 仅检测列表中的实例。 |
| `FilterDescendantsInstances` | Array<[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)> | `[]` | 用于射线检测时进行过滤的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 列表。该属性接收一个 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 实例数组，作为射线检测时的过滤依据，决定哪些单位参与检测。默认为空数组。 |
| `CollisionGroup` | `String` | `-` | 用于按已配置碰撞关系过滤的碰撞组名称，不是只按 WorldUnit.CollisionGroup 字符串同名匹配；不设置（nil，Meta 默认值）表示不启用碰撞组过滤。 |

## 函数 (1)

### New

签名：`New() -> RaycastParams`

创建新的 [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html) 参数实例，用于配置射线检测的过滤条件。

**返回值** [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html)

> 示例代码

> 构造并设置过滤

```lua
-- @runtime client
-- 创建射线检测的过滤参数
local params = RaycastParams.New()
-- 设置过滤类型为 Exclude
params.FilterType = Enums.RaycastFilterType.Exclude
-- 设置需要排除的实例列表
params.FilterDescendantsInstances = {}
-- 设置碰撞组
params.CollisionGroup = "Default"

-- 发起一次射线检测
local rayOrigin = Vector3.New(0, 10, 0)
local rayDirection = Vector3.New(0, -20, 0)
local result = game:GetService("PhysicsService"):Raycast(rayOrigin, rayDirection, params)

-- 输出检测结果
if result then
	print("射线命中:", result.Instance.Name)
else
	print("射线未命中")
end
```
