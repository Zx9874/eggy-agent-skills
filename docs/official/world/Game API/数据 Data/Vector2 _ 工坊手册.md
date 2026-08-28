# Vector2

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

二维向量用于表示平面上的位置、方向或位移，提供坐标访问、长度计算、归一化、点积、叉积、角度、线性插值等常用运算。支持逐分量取绝对值、取整、取符号以及近似相等比较。

## 适用场景

常用于表示二维坐标、屏幕位置、平面方向或位移，例如计算触点位置、方向、距离，或进行二维向量插值与近似相等判断。

## 使用要点

通过 Vector2.New(x, y) 或 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)(x, y) 构造实例，然后调用实例方法如 Dot、Normalize、Angle 等进行运算。属性 Magnitude 和 Unit 可直接读取向量长度和单位向量。

## 注意事项

[Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) 实例通过 Vector2.New(x, y) 或 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)(x, y) 构造。Normalize 会就地修改当前向量；不同运行包可能返回原长度或当前向量，调用方应读取修改后的原变量，不依赖返回值。Unit 返回派生的单位向量，不改写原向量。归一化前应确认向量非零。Magnitude 和 Unit 是只读属性，FuzzyEq 用于在给定误差范围内比较两个向量是否近似相等。

## 代码示例

### 构造 Vector2 并区分原地归一化与派生结果

```lua
-- @runtime client
local original = Vector2.New(3, 4)
local unitCopy = original.Unit  -- 不修改 original
local mutable = Vector2.New(original.x, original.y)
mutable:Normalize()             -- 就地修改 mutable
print('原向量长度:', original.Magnitude)
print('派生/原地单位向量:', unitCopy, mutable)
print('与目标插值:', original:Lerp(Vector2.New(1, 2), 0.5))
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `x` | `Float` | `-` | 向量的 X 坐标分量。 |
| `y` | `Float` | `-` | 向量的 Y 坐标分量。 |
| `Magnitude` | `Float` | `-` | 向量的长度（模），即 sqrt(x^2 + y^2)。 |
| `Unit` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | `-` | 返回当前向量的单位向量，方向相同但长度为 1。 |

## 函数 (14)

### New

签名：`New(x: Float, y: Float) -> Vector2`

创建一个新的 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) 实例，指定 x 和 y 分量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `x` | `Float` | X 坐标 |
| `y` | `Float` | Y 坐标 |

**返回值** [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)

> 示例代码

> 构造 Vector2

```lua
-- @runtime client
local v = Vector2.New(3, 4)
print(string.format('x=%.1f y=%.1f', v.x, v.y))
-- 常用运算
print('长度:', v.Magnitude)
print('单位向量:', tostring(v.Unit))
```

### Dot

签名：`Dot(other: Vector2) -> Float`

计算当前向量与另一个向量的点积，返回一个标量值。点积等于两向量长度乘积与夹角余弦的乘积。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | - |

**返回值** `Float`

> 示例代码

> 计算两个向量的点积

```lua
-- @runtime client
-- 构造两个向量
local v1 = Vector2(1, 2)
local v2 = Vector2(3, 4)
-- 计算点积
local dot = v1:Dot(v2)
print("v1 · v2 =", dot)  -- 输出 11.0
```

### Normalize

签名：`Normalize() -> Vector2`

原地归一化当前向量；调用方应读取修改后的原变量，不依赖返回值。

**返回值** [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)

> 示例代码

> 原地归一化 Vector2

```lua
-- @runtime client
local vector = Vector2.New(3, 4)
vector:Normalize()  -- 不依赖不同运行包中的返回值形态
print('归一化后的分量:', vector.x, vector.y)
print('归一化后的长度:', vector.Magnitude)
```

### Cross

签名：`Cross(other: Vector2) -> Float`

计算当前二维向量与另一个二维向量的叉积，返回一个标量值。叉积的几何意义是两个向量构成的平行四边形的有向面积。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | - |

**返回值** `Float`

> 示例代码

> 计算二维叉积（标量）

```lua
-- @runtime client
-- 构造两个向量
local v1 = Vector2(2, 3)
local v2 = Vector2(4, 1)
-- 计算叉积（标量）
local cross = v1:Cross(v2)
print("v1 × v2 =", cross)  -- 输出 -10.0
```

### Cross2d

签名：`Cross2d(other: Vector2) -> Float`

计算当前二维向量与另一个二维向量的二维叉积（标量值），等价于 Cross 方法，主要用于兼容旧代码。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | - |

**返回值** `Float`

> 示例代码

> 使用 Cross2d 别名计算叉积

```lua
-- @runtime client
-- 构造两个向量
local v1 = Vector2(2, 3)
local v2 = Vector2(4, 1)
-- 使用 Cross2d 别名计算叉积
local cross = v1:Cross2d(v2)
print("v1 × v2 =", cross)  -- 输出 -10.0
```

### Angle

签名：`Angle(other: Vector2) -> Float`

计算当前向量与另一个向量之间的有符号夹角，返回弧度值。符号由二维叉积（x1*y2 - y1*x2）决定，正号表示从当前向量到目标向量为逆时针旋转。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | - |

**返回值** `Float`

> 示例代码

> 计算两个向量的有符号夹角

```lua
-- @runtime client
-- 构造两个向量
local v1 = Vector2(1, 0)  -- 指向右侧
local v2 = Vector2(0, 1)  -- 指向上方
-- 计算 v1 到 v2 的有符号夹角（弧度）
local angle = v1:Angle(v2)
print("v1 到 v2 的夹角（弧度）:", angle)  -- 输出约 1.5708（π/2）
```

### Lerp

签名：`Lerp(goal: Vector2, alpha: Float) -> Vector2`

在当前 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) 与目标 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) 之间按比例 alpha 进行线性插值，返回插值后的新 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `goal` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | - |
| `alpha` | `Float` | 插值因子 [0, 1] |

**返回值** [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)

> 示例代码

> 在两个向量之间进行线性插值

```lua
-- @runtime client
-- 构造起始和目标向量
local start = Vector2(0, 0)
local goal = Vector2(10, 20)
-- 在 30% 处插值
local result = start:Lerp(goal, 0.3)
print("插值结果:", result.x, result.y)  -- 输出 3.0 6.0
```

### Max

签名：`Max(others: Vector2) -> Vector2`

返回一个新的 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)，其每个分量取当前向量与另一个向量对应分量的最大值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `others` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | - |

**返回值** [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)

> 示例代码

> 逐分量取最大值

```lua
-- @runtime client
-- 构造两个向量
local v1 = Vector2(3, 8)
local v2 = Vector2(5, 2)
-- 逐分量取最大值
local maxVec = v1:Max(v2)
print("最大值向量:", maxVec.x, maxVec.y)  -- 输出 5.0 8.0
```

### Min

签名：`Min(others: Vector2) -> Vector2`

返回一个新的 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)，其 x 和 y 分量分别取当前向量与参数向量对应分量的较小值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `others` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | - |

**返回值** [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)

> 示例代码

> 逐分量取最小值

```lua
-- @runtime client
-- 构造两个向量
local v1 = Vector2(3, 8)
local v2 = Vector2(5, 2)
-- 逐分量取最小值
local minVec = v1:Min(v2)
print("最小值向量:", minVec.x, minVec.y)  -- 输出 3.0 2.0
```

### Abs

签名：`Abs() -> Vector2`

返回一个新的 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)，其每个分量（x, y）均为原向量对应分量的绝对值。

**返回值** [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)

> 示例代码

> 逐分量取绝对值

```lua
-- @runtime client
-- 构造包含负分量的向量
local v = Vector2(-3.5, 2.0)
-- 取绝对值
local absVec = v:Abs()
print("绝对值向量:", absVec.x, absVec.y)  -- 输出 3.5 2.0
```

### Ceil

签名：`Ceil() -> Vector2`

返回一个新的 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)，其每个分量是对应原分量向上取整的结果。

**返回值** [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)

> 示例代码

> 逐分量向上取整

```lua
-- @runtime client
-- 构造包含小数的向量
local v = Vector2(3.2, -1.7)
-- 向上取整
local ceilVec = v:Ceil()
print("向上取整:", ceilVec.x, ceilVec.y)  -- 输出 4.0 -1.0
```

### Floor

签名：`Floor() -> Vector2`

返回一个新的 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)，其每个分量（x, y）为原向量对应分量的向下取整值。

**返回值** [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)

> 示例代码

> 逐分量向下取整

```lua
-- @runtime client
-- 构造包含小数的向量
local v = Vector2(3.2, -1.7)
-- 向下取整
local floorVec = v:Floor()
print("向下取整:", floorVec.x, floorVec.y)  -- 输出 3.0 -2.0
```

### Sign

签名：`Sign() -> Vector2`

返回一个新的 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)，其每个分量是原向量对应分量的符号值（正数返回 1，负数返回 -1，零返回 0）。

**返回值** [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)

> 示例代码

> 逐分量取符号

```lua
-- @runtime client
-- 构造包含正负分量的向量
local v = Vector2(-3.5, 0.0)
-- 取符号
local signVec = v:Sign()
print("符号向量:", signVec.x, signVec.y)  -- 输出 -1.0 0.0
```

### FuzzyEq

签名：`FuzzyEq(other: Vector2, epsilon: Float) -> Bool`

判断当前 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) 与另一个 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) 是否在给定误差范围内近似相等。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | - |
| `epsilon` | `Float` | 允许的误差范围 |

**返回值** `Bool`

> 示例代码

> 用容差比较 Vector2

```lua
-- @runtime client
local a = Vector2.New(1.000001, 2.000001)
local b = Vector2.New(1.0, 2.0)

print('容差 0.00001:', a:FuzzyEq(b, 0.00001))
print('容差 0.0000001:', a:FuzzyEq(b, 0.0000001))
```
