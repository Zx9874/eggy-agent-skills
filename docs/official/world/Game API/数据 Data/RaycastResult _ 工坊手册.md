# RaycastResult

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

射线或形状投射命中后返回的数据结构，包含被命中的单位、命中点、命中面法线和命中距离。开发者通过它获取碰撞信息，并据此实现交互逻辑或特效放置。

## 适用场景

适用于需要射线检测或形状检测的场景，例如瞄准判定、视野检测、地形交互，用来获取命中目标及命中点的具体信息。典型用法是先调用 [PhysicsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PhysicsService.html) 的投射方法得到结果，再读取结果字段。

## 使用要点

通过 [PhysicsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PhysicsService.html) 的 Raycast、Blockcast、Spherecast 或 Shapecast 等投射函数获取实例，函数返回的命中结果即为 [RaycastResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastResult.html)。拿到结果后可直接访问 Instance、Position、Normal、Distance 四个属性，未命中时返回空值，应先判断命中是否存在再读取属性。

## 注意事项

[RaycastResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastResult.html) 不可直接构造，只能由 [PhysicsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PhysicsService.html) 的投射函数返回。未命中时投射函数返回 nil，应先判空；结果非 nil 时再读取 Instance、Position、Normal 和 Distance。

## 代码示例

### 执行射线检测并读取命中结果

```lua
-- @runtime client
local PhysicsService = game:GetService('PhysicsService')
local origin = Vector3.New(0, 5, 0)
local direction = Vector3.New(0, -100, 0)
local result = PhysicsService:Raycast(origin, direction)
if result ~= nil then
    print('命中对象:', result.Instance)
    print('位置、法线和距离:', result.Position, result.Normal, result.Distance)
end
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Instance` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | `-` | 射线命中到的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 实例。 |
| `Position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 射线命中点在游戏世界中的坐标，类型为 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。 |
| `Normal` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 射线命中点的表面法线方向，类型为 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。 |
| `Distance` | `Float` | `-` | 射线命中点与射线起点之间的距离，类型为浮点数。 |

## 关联类型

* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
