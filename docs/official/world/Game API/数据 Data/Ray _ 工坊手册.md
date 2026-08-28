# Ray

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[Ray](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Ray.html) 表示三维空间中的射线，由起点和方向向量定义。它提供最近点计算和点到射线距离的几何方法，常用于空间查询和碰撞检测前的数学预处理。

## 适用场景

在执行射线检测前，先用 [Ray](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Ray.html) 封装起点和方向，然后通过 ClosestPoint 或 Distance 进行几何计算，或将其 Origin 与 Direction 传入 PhysicsService:Raycast 进行物理查询。

## 使用要点

通过 Ray.New(origin, direction) 或简写 [Ray](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Ray.html)(origin, direction) 创建实例。调用 ray:ClosestPoint(point) 获取点在射线上的最近点，或 ray:Distance(point) 计算点到射线的距离。需要物理射线检测时，将 ray.Origin 和 ray.Direction 作为参数传入 PhysicsService:Raycast。

## 注意事项

[Ray](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Ray.html) 是用于最近点和距离计算的几何数据结构。PhysicsService:Raycast 不直接接收 [Ray](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Ray.html) 实例，而是分别接收 origin、direction 和可选 [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html)；需要执行物理检测时，应传入 ray.Origin 与 ray.Direction。

## 代码示例

### 构造射线并计算最近点与距离

```lua
-- @runtime client
-- 构造射线：从原点出发，方向为 (1, 0, 0)
local ray = Ray(Vector3(0, 0, 0), Vector3(1, 0, 0))

-- 计算点 (2, 3, 0) 到射线的最近点
local closest = ray:ClosestPoint(Vector3(2, 3, 0))
print("最近点: " .. tostring(closest))

-- 计算点 (2, 3, 0) 到射线的距离
local dist = ray:Distance(Vector3(2, 3, 0))
print("距离: " .. tostring(dist))

-- 获取射线的单位方向向量
local unitDir = ray.Unit
print("单位方向: " .. tostring(unitDir))
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Origin` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 射线的起点坐标。 |
| `Direction` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 射线的方向向量。 |
| `Unit` | [Ray](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Ray.html) | `-` | 返回方向归一化后的新射线，其方向向量长度为1。 |

## 关联类型

* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 函数 (3)

### New

签名：`New(origin: Vector3, direction: Vector3) -> Ray`

创建一个新的射线对象，由起点和方向向量定义。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `origin` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `direction` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Ray](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Ray.html)

> 示例代码

> 构造射线

```lua
-- @runtime client
local origin = Vector3.New(0, 10, 0)
local direction = Vector3.New(0, -1, 0)  -- 向下
local ray = Ray.New(origin, direction)
print('起点:', tostring(ray.Origin))
print('方向:', tostring(ray.Direction))
```

### ClosestPoint

签名：`ClosestPoint(point: Vector3) -> Vector3`

计算射线上距离给定点最近的点，并返回该点的坐标。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `point` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 计算射线上离目标点最近的点

```lua
-- @runtime client
-- 构造射线：起点 (0,0,0)，方向 (1,0,0)
local ray = Ray(Vector3(0, 0, 0), Vector3(1, 0, 0))
-- 目标点 (2, 3, 0)
local point = Vector3(2, 3, 0)
-- 获取射线上最近的点
local closest = ray:ClosestPoint(point)
print("最近点坐标: ", closest.x, closest.y, closest.z)
```

### Distance

签名：`Distance(point: Vector3) -> Float`

计算给定点到射线的最短距离。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `point` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** `Float`

> 示例代码

> 计算点到射线的最短距离

```lua
-- @runtime client
-- 构造射线：起点 (0,0,0)，方向 (0,1,0)
local ray = Ray(Vector3(0, 0, 0), Vector3(0, 1, 0))
-- 目标点 (3, 4, 0)
local point = Vector3(3, 4, 0)
-- 获取点到射线的最短距离
local dist = ray:Distance(point)
print("点到射线的最短距离: ", dist)
```
