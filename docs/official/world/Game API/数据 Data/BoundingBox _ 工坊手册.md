# BoundingBox

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

轴对齐包围盒用于定义一个三维空间中的矩形区域，通过最小点和最大点确定范围。它提供获取中心点、半尺寸以及读写最小最大点的能力，常用于空间查询、碰撞检测和区域裁剪。

## 适用场景

在物理查询或空间过滤时，用 [BoundingBox](https://u5-creator.s3.game.163.com/manual/se/game_api/data/BoundingBox.html) 描述一个区域，例如配合 [PhysicsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PhysicsService.html) 的 GetPartBoundsInBox 获取该区域内的部件。

## 使用要点

通过 BoundingBox.New(min, max) 或 [BoundingBox](https://u5-creator.s3.game.163.com/manual/se/game_api/data/BoundingBox.html)(min, max) 创建实例；GetCenter 返回中心点，GetExtent 返回从中心到边界的半尺寸。

## 注意事项

可使用 BoundingBox.New(min, max) 构造，也可使用等价简写 [BoundingBox](https://u5-creator.s3.game.163.com/manual/se/game_api/data/BoundingBox.html)(min, max)；min/max 都是 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)，且应满足各分量 Min <= Max。该类型为纯数据结构，不自动关联任何空间对象。GetExtent 返回包围盒在三个轴向上的**半尺寸**（(Max - Min) / 2）——例如 Min=(-5,-2,-3) Max=(5,2,3) 时 GetExtent 返回 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)(5, 2, 3)。GetCenter 返回中心点 (Min+Max)/2。

## 代码示例

### 构造包围盒并读取中心与半尺寸

```lua
-- @runtime client
local box = BoundingBox.New(
    Vector3.New(-5, -2, -3),
    Vector3.New(5, 2, 3)
)
local center = box:GetCenter()  -- Vector3(0, 0, 0)
local extent = box:GetExtent()  -- Vector3(5, 2, 3)，半尺寸
print("中心:", center, "半尺寸:", extent)
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Min` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 包围盒的最小点坐标。 |
| `Max` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 包围盒的最大点坐标。 |

## 关联类型

* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 函数 (7)

### New

签名：`New(min: Vector3, max: Vector3) -> BoundingBox`

创建一个新的轴对齐包围盒实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `min` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 最小值 |
| `max` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 最大值 |

**返回值** [BoundingBox](https://u5-creator.s3.game.163.com/manual/se/game_api/data/BoundingBox.html)

> 示例代码

> 构造包围盒

```lua
-- @runtime client
local minPoint = Vector3.New(-5, -2, -3)
local maxPoint = Vector3.New(5, 2, 3)
local box = BoundingBox.New(minPoint, maxPoint)
print(tostring(box))
```

### GetCenter

签名：`GetCenter() -> Vector3`

返回包围盒的中心点坐标。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 获取中心点

```lua
-- @runtime client
local box = BoundingBox.New(Vector3.New(-5, -2, -3), Vector3.New(5, 2, 3))
local center = box:GetCenter()  -- 返回 Vector3(0, 0, 0)
print("中心:", tostring(center))
```

### GetExtent

签名：`GetExtent() -> Vector3`

返回包围盒从中心到边界的半尺寸向量，即 (Max - Min) / 2。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 获取半尺寸

```lua
-- @runtime client
local box = BoundingBox.New(Vector3.New(-5, -2, -3), Vector3.New(5, 2, 3))
local extent = box:GetExtent()  -- 返回半尺寸 Vector3(5, 2, 3)
print("半尺寸:", tostring(extent))
```

### GetMin

签名：`GetMin() -> Vector3`

返回包围盒的最小点坐标。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 获取最小点

```lua
-- @runtime client
local box = BoundingBox.New(Vector3.New(-5, -2, -3), Vector3.New(5, 2, 3))
local minP = box:GetMin()  -- 返回 Vector3(-5, -2, -3)
print("最小点:", tostring(minP))
```

### SetMin

签名：`SetMin(v: Vector3) -> void`

设置包围盒的最小角点坐标。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `v` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** `void`

> 示例代码

> 设置最小点

```lua
-- @runtime client
local box = BoundingBox.New(Vector3.New(0, 0, 0), Vector3.New(2, 2, 2))
box:SetMin(Vector3.New(-1, -1, -1))
print("新的最小点:", tostring(box:GetMin()))
```

### GetMax

签名：`GetMax() -> Vector3`

返回包围盒的最大点坐标。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 获取最大点

```lua
-- @runtime client
local box = BoundingBox.New(Vector3.New(-5, -2, -3), Vector3.New(5, 2, 3))
local maxP = box:GetMax()  -- 返回 Vector3(5, 2, 3)
print("最大点:", tostring(maxP))
```

### SetMax

签名：`SetMax(v: Vector3) -> void`

设置包围盒的最大角点坐标。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `v` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** `void`

> 示例代码

> 设置最大点

```lua
-- @runtime client
local box = BoundingBox.New(Vector3.New(0, 0, 0), Vector3.New(2, 2, 2))
box:SetMax(Vector3.New(3, 3, 3))
print("新的最大点:", tostring(box:GetMax()))
```
