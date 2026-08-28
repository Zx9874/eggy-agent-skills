# Region3

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[Region3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3.html) 表示由两个 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 对角点界定的轴对齐三维区域，并可按指定分辨率向外扩展到网格边界。

## 适用场景

用于在脚本内部表达三维范围、保存区域配置或执行网格对齐计算；当前公开 Surface 没有接收 [Region3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3.html) 的 [PhysicsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PhysicsService.html) 查询参数，具体消费入口应以对应 API 的 Meta 签名为准。

## 使用要点

先构造 min/max 两个 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)，再用 Region3.New(min, max) 或 [Region3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3.html)(min, max) 创建区域；通过 Size 读取尺寸，通过 ExpandToGrid(resolution) 获得向外对齐网格的新区域。

## 注意事项

[Region3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3.html) 本身不执行物理查询。PhysicsService:GetPartBoundsInBox 接收 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)、[Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 和可选 [OverlapParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OverlapParams.html)，不接收 [Region3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3.html)；不要把两种范围表达混用。

## 代码示例

### 构造 Region3 并读取尺寸

```lua
-- @runtime client
-- 构造两个对角点，定义三维区域
local minPoint = Vector3.New(0, 0, 0)
local maxPoint = Vector3.New(10, 5, 8)
-- 使用简写构造 Region3 实例
local region = Region3(minPoint, maxPoint)
-- 读取区域的尺寸属性
local size = region.Size
print("区域尺寸: X=" .. size.x .. ", Y=" .. size.y .. ", Z=" .. size.z)
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Size` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 获取区域的尺寸，即最大点与最小点的差值。 |

## 关联类型

* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 函数 (2)

### New

签名：`New(min: Vector3, max: Vector3) -> Region3`

创建一个新的 [Region3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3.html) 实例，表示由最小点和最大点定义的三维轴对齐包围盒。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `min` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `max` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Region3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3.html)

> 示例代码

> 构造 3D 区域

```lua
-- @runtime client
local min = Vector3.New(0, 0, 0)
local max = Vector3.New(100, 50, 100)
local region = Region3.New(min, max)
print('区域 Size:', tostring(region.Size))
```

### ExpandToGrid

签名：`ExpandToGrid(resolution: Float) -> Region3`

将当前区域按指定分辨率扩展为对齐网格的更大区域。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `resolution` | `Float` | - |

**返回值** [Region3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3.html)

> 示例代码

> 按格子大小扩展区域

```lua
-- @runtime client
-- 构造一个原始区域
local minVec = Vector3(0, 0, 0)
local maxVec = Vector3(10, 10, 10)
local region = Region3(minVec, maxVec)

-- 按格子大小 2.0 扩展区域，使边界对齐到 2.0 的整数倍
local expanded = region:ExpandToGrid(2.0)

-- 输出扩展后的区域尺寸
print("扩展后区域尺寸:", expanded.Size)
```
