# Vector3

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

三维向量，用于表示位置、方向、速度或缩放等三维量。提供向量运算方法，如点积、叉积、线性插值和归一化，并支持通过只读属性获取长度和单位向量。

## 适用场景

常用于计算物体间的距离、方向，或进行坐标变换与物理模拟，例如获取玩家角色位置后计算朝向另一个目标的方向向量。

## 使用要点

通过 Vector3.New(x, y, z) 或 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)(x, y, z) 构造实例。使用 Dot 计算点积，Cross 计算叉积，Normalize 就地归一化，Unit 获取单位向量而不改变原向量。

## 注意事项

[Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 是三维向量数据值，用于表示位置、方向、速度或缩放等三维量。可通过 Vector3.New(x, y, z) 或 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)(x, y, z) 构造实例；Normalize 会就地修改当前向量，不同运行包可能返回原长度或当前向量，调用方应读取修改后的原变量，不依赖返回值。Unit 返回不改写原向量的派生单位向量。归一化前应确认向量非零。Magnitude 和 Unit 是只读派生属性。

## 代码示例

### 构造 Vector3 并安全归一化

```lua
-- @runtime client
local vector = Vector3.New(3, 4, 0)
print('原长度:', vector.Magnitude)
vector:Normalize()  -- 原地修改，不依赖返回值形态
print('单位向量:', vector, '长度:', vector.Magnitude)
local other = Vector3.New(1, 2, 3)
print('点积:', vector:Dot(other), '叉积:', vector:Cross(other))
```

## 属性 (7)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `x` | `Float` | `-` | 向量的 X 坐标分量。 |
| `y` | `Float` | `-` | 向量的 Y 坐标分量。 |
| `z` | `Float` | `-` | 向量的 Z 坐标分量。 |
| `Magnitude` | `Float` | `-` | 返回向量的长度（模），即 sqrt(x^2 + y^2 + z^2)。 |
| `Unit` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 返回与原向量方向相同的单位向量，长度为 1。 |
| `Pitch` | `Float` | `-` | 返回向量的俯仰角（弧度），由方向向量推算。 |
| `Yaw` | `Float` | `-` | 返回向量的偏航角（弧度），由方向向量推算。 |

## 函数 (14)

### New

签名：`New(x: Float, y: Float, z: Float) -> Vector3`

创建一个新的 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 实例，指定 x、y、z 分量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `x` | `Float` | - |
| `y` | `Float` | - |
| `z` | `Float` | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 构造 Vector3 并做常用运算

```lua
-- @runtime client
local v = Vector3.New(1, 2, 3)
print(string.format('x=%.1f y=%.1f z=%.1f', v.x, v.y, v.z))
-- 点积、叉积、长度
local other = Vector3.New(4, 5, 6)
print('点积:', v:Dot(other))
print('叉积:', tostring(v:Cross(other)))
print('长度:', v.Magnitude)
```

### Length

签名：`Length() -> Float`

计算向量的长度（模），返回一个标量。

**返回值** `Float`

> 示例代码

> 计算向量的长度

```lua
-- @runtime client
-- 构造一个向量
local v = Vector3(3, 4, 0)
-- 计算长度
local len = v:Length()
-- 输出结果：5
print("Length:", len)
```

### Normalize

签名：`Normalize() -> Vector3`

原地归一化当前向量；调用方应读取修改后的原变量，不依赖返回值。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 原地归一化 Vector3

```lua
-- @runtime client
local vector = Vector3.New(3, 0, 4)
vector:Normalize()  -- 不依赖不同运行包中的返回值形态
print('归一化后的分量:', vector.x, vector.y, vector.z)
print('归一化后的长度:', vector:Length())
```

### Dot

签名：`Dot(other: Vector3) -> Float`

计算当前向量与另一个向量的点积，返回一个标量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** `Float`

> 示例代码

> 计算两个向量的点积

```lua
-- @runtime client
-- 构造两个向量
local v1 = Vector3(1, 2, 3)
local v2 = Vector3(4, 5, 6)
-- 计算点积
local dot = v1:Dot(v2)
print("Dot:", dot)
```

### Cross

签名：`Cross(other: Vector3) -> Vector3`

计算当前向量与另一个向量的叉积，返回一个新的 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 计算两个向量的叉积

```lua
-- @runtime client
-- 构造两个向量
local v1 = Vector3(1, 0, 0)
local v2 = Vector3(0, 1, 0)
-- 计算叉积，结果应为 (0, 0, 1)
local crossV = v1:Cross(v2)
-- 输出结果
print("Cross:", crossV.x, crossV.y, crossV.z)
```

### Lerp

签名：`Lerp(goal: Vector3, alpha: Float) -> Vector3`

在当前向量与目标向量之间进行线性插值，返回一个新的 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `goal` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `alpha` | `Float` | 插值因子 [0, 1] |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 在两个向量之间进行线性插值

```lua
-- @runtime client
-- 构造起始和目标向量
local startV = Vector3(0, 0, 0)
local goalV = Vector3(10, 10, 10)
local lerpV = startV:Lerp(goalV, 0.3)
print("Lerp:", lerpV.x, lerpV.y, lerpV.z)
```

### Max

签名：`Max(others: Vector3) -> Vector3`

返回一个新的 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)，其每个分量取当前向量与另一个向量对应分量的最大值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `others` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 取两个向量各分量的最大值

```lua
-- @runtime client
-- 构造两个向量
local v1 = Vector3(1, 5, 3)
local v2 = Vector3(4, 2, 6)
-- 取各分量最大值
local maxV = v1:Max(v2)
print("Max:", maxV.x, maxV.y, maxV.z)
```

### Min

签名：`Min(others: Vector3) -> Vector3`

返回一个新的 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)，其每个分量取当前向量与另一个向量对应分量的最小值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `others` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 取两个向量各分量的最小值

```lua
-- @runtime client
-- 构造两个向量
local v1 = Vector3(1, 5, 3)
local v2 = Vector3(4, 2, 6)
-- 取各分量最小值
local minV = v1:Min(v2)
print("Min:", minV.x, minV.y, minV.z)
```

### Abs

签名：`Abs() -> Vector3`

返回一个新的 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)，其每个分量是原向量对应分量的绝对值。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 对向量各分量取绝对值

```lua
-- @runtime client
-- 构造一个包含负分量的向量
local v = Vector3(-3.5, 2.0, -1.2)
-- 调用 Abs 获取各分量绝对值的新向量
local absV = v:Abs()
print("Abs:", absV.x, absV.y, absV.z)
```

### Ceil

签名：`Ceil() -> Vector3`

返回一个新的 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)，其每个分量是原向量对应分量向上取整的结果。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 对向量各分量向上取整

```lua
-- @runtime client
-- 构造一个带小数的向量
local v = Vector3(1.2, 3.7, -0.5)
-- 调用 Ceil 获取各分量向上取整的新向量
local ceilV = v:Ceil()
print("Ceil:", ceilV.x, ceilV.y, ceilV.z)
```

### Floor

签名：`Floor() -> Vector3`

返回一个新的 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)，其每个分量是原向量对应分量向下取整的结果。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 对向量各分量向下取整

```lua
-- @runtime client
-- 构造一个带小数的向量
local v = Vector3(1.8, -2.3, 3.9)
-- 调用 Floor 获取各分量向下取整的新向量
local floorV = v:Floor()
print("Floor:", floorV.x, floorV.y, floorV.z)
```

### Sign

签名：`Sign() -> Vector3`

返回一个新的 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)，其每个分量是原向量对应分量的符号（正为 1，负为 -1，零为 0）。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 获取向量各分量的符号

```lua
-- @runtime client
-- 构造一个包含正负零的向量
local v = Vector3(-3.5, 0.0, 2.1)
-- 调用 Sign 获取各分量符号
local signV = v:Sign()
print("Sign:", signV.x, signV.y, signV.z)
```

### FuzzyEq

签名：`FuzzyEq(other: Vector3, epsilon: Float) -> Bool`

判断当前向量与另一个向量是否在给定误差范围内近似相等。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `epsilon` | `Float` | 允许的误差范围 |

**返回值** `Bool`

> 示例代码

> 近似比较两个向量是否相等

```lua
-- @runtime client
-- 构造两个非常接近的向量
local v1 = Vector3(1.0001, 2.0001, 3.0001)
local v2 = Vector3(1.0002, 2.0002, 3.0002)
-- 使用 FuzzyEq 判断是否在误差范围内相等
local isEqual = v1:FuzzyEq(v2, 0.001)
-- 输出结果：true（误差小于 0.001）
print("FuzzyEq:", isEqual)
```

### Angle

签名：`Angle(other: Vector3) -> Float`

计算当前向量与另一个向量之间的夹角，返回弧度值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** `Float`

> 示例代码

> 计算两个向量之间的夹角（弧度）

```lua
-- @runtime client
-- 构造两个向量
local v1 = Vector3(1, 0, 0)
local v2 = Vector3(0, 1, 0)
-- 计算夹角（弧度）
local angle = v1:Angle(v2)
-- 输出结果：约 1.5708（π/2）
print("Angle:", angle)
```
