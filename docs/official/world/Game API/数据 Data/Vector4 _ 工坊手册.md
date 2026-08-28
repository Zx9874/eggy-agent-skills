# Vector4

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

四维向量用于表示和操作包含四个分量的数值结构，常用于颜色、裁剪区域或齐次坐标等场景。它提供了长度计算、点积、归一化以及分量极值查询等数学运算。

## 适用场景

适用于公开 API 明确需要四分量数值的场景，例如 [EUIButton](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUIButton.html)/[EUIImage](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUIImage.html) 的 StretchArea，或读取 Quaternion:GetRotationAngleAxis 返回的轴角数据。

## 使用要点

通过 Vector4.New(x, y, z, w) 或简写 [Vector4](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector4.html)(x, y, z, w) 创建实例。然后可读取 x、y、z、w 分量，或调用 Length() 获取长度、Normalize() 就地归一化、GetUnit() 返回单位向量。

## 注意事项

[Vector4](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector4.html) 是四分量数据结构。Normalize 会就地修改当前向量；不同运行包可能返回原长度或当前向量，调用方应读取修改后的原变量，不依赖返回值。Unit、GetUnit、GetAbsoluteVector 等读取或派生操作返回计算结果，不会改写原向量。归一化前应确认向量非零。Magnitude 和 Unit 属性为只读，由内部计算得出。

## 代码示例

### 构造与属性读写

```lua
-- @runtime client
-- 使用简写构造一个四维向量
local v = Vector4(1.0, 2.0, 3.0, 4.0)
-- 读取各分量
print("x:", v.x, "y:", v.y, "z:", v.z, "w:", v.w)
-- 读取只读属性 Magnitude 和 Unit
print("Magnitude:", v.Magnitude)
print("Unit:", v.Unit)
-- 调用 Length() 方法
print("Length:", v:Length())
-- 调用 GetMinValue() 和 GetMaxValue()
print("Min:", v:GetMinValue(), "Max:", v:GetMaxValue())
-- 调用 GetAbsoluteVector() 返回各分量绝对值的新向量
local absV = v:GetAbsoluteVector()
print("Abs:", absV.x, absV.y, absV.z, absV.w)
```

## 属性 (6)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `x` | `Float` | `-` | 四维向量的第一个分量，通常表示 X 轴坐标或颜色 R 通道。 |
| `y` | `Float` | `-` | 四维向量的第二个分量，通常表示 Y 轴坐标或颜色 G 通道。 |
| `z` | `Float` | `-` | 四维向量的第三个分量，通常表示 Z 轴坐标或颜色 B 通道。 |
| `w` | `Float` | `-` | 四维向量的第四个分量，通常表示齐次坐标的 W 分量或颜色 A 通道。 |
| `Magnitude` | `Float` | `-` | 向量的长度（模），等于各分量平方和的平方根。 |
| `Unit` | [Vector4](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector4.html) | `-` | 返回当前向量的单位向量，方向相同但长度为 1。 |

## 函数 (8)

### New

签名：`New(x: Float, y: Float, z: Float, w: Float) -> Vector4`

创建一个新的 [Vector4](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector4.html) 实例，指定 x、y、z、w 四个分量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `x` | `Float` | - |
| `y` | `Float` | - |
| `z` | `Float` | - |
| `w` | `Float` | - |

**返回值** [Vector4](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector4.html)

> 示例代码

> 构造 Vector4

```lua
-- @runtime client
local v = Vector4.New(1, 2, 3, 4)
print(string.format('x=%.1f y=%.1f z=%.1f w=%.1f', v.x, v.y, v.z, v.w))
```

### Length

签名：`Length() -> Float`

计算向量的欧几里得长度（模）。

**返回值** `Float`

> 示例代码

> 计算向量的长度（模）

```lua
-- @runtime client
-- 构造一个 Vector4 实例
local v = Vector4(3, 4, 0, 0)
-- 计算向量长度
local len = v:Length()
print("向量长度:", len)
```

### Dot

签名：`Dot(rhs: Vector4) -> Float`

计算当前向量与另一个 [Vector4](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector4.html) 的点积，返回一个标量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `rhs` | [Vector4](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector4.html) | - |

**返回值** `Float`

> 示例代码

> 计算两个四维向量的点积

```lua
-- @runtime client
-- 构造两个 Vector4 实例
local v1 = Vector4(1, 2, 3, 4)
local v2 = Vector4(5, 6, 7, 8)
-- 调用 Dot 方法计算点积
local dotProduct = v1:Dot(v2)
print("点积结果:", dotProduct)
```

### Normalize

签名：`Normalize() -> Vector4`

原地归一化当前向量；调用方应读取修改后的原变量，不依赖返回值。

**返回值** [Vector4](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector4.html)

> 示例代码

> 原地归一化 Vector4

```lua
-- @runtime client
local vector = Vector4.New(3, 0, 4, 0)
vector:Normalize()  -- 不依赖不同运行包中的返回值形态
print('归一化后的分量:', vector.x, vector.y, vector.z, vector.w)
print('归一化后的长度:', vector:Length())
```

### GetUnit

签名：`GetUnit() -> Vector4`

返回当前向量的单位向量（长度为 1），方向与原向量相同。

**返回值** [Vector4](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector4.html)

> 示例代码

> 获取单位向量（不修改原向量）

```lua
-- @runtime client
-- 构造一个非零 Vector4
local v = Vector4(3, 0, 4, 0)
-- 获取单位向量，原向量保持不变
local unitV = v:GetUnit()
-- 输出单位向量的各分量
print("单位向量:", unitV.x, unitV.y, unitV.z, unitV.w)
```

### GetAbsoluteVector

签名：`GetAbsoluteVector() -> Vector4`

返回一个新的 [Vector4](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector4.html)，其每个分量是原向量对应分量的绝对值。

**返回值** [Vector4](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector4.html)

> 示例代码

> 获取各分量绝对值组成的新向量

```lua
-- @runtime client
-- 构造一个包含负分量的 Vector4
local v = Vector4(-3, 4, -5, 6)
-- 获取绝对值向量，原向量不变
local absV = v:GetAbsoluteVector()
-- 输出绝对值向量的各分量
print("绝对值向量:", absV.x, absV.y, absV.z, absV.w)
```

### GetMinValue

签名：`GetMinValue() -> Float`

返回向量四个分量中的最小值。

**返回值** `Float`

> 示例代码

> 获取向量中的最小分量值

```lua
-- @runtime client
-- 构造一个 Vector4 实例
local v = Vector4(10, 20, 5, 15)
-- 获取最小分量值
local minVal = v:GetMinValue()
-- 输出最小分量值
print("最小分量值:", minVal)
```

### GetMaxValue

签名：`GetMaxValue() -> Float`

返回向量四个分量中的最大值。

**返回值** `Float`

> 示例代码

> 获取向量中的最大分量值

```lua
-- @runtime client
-- 构造一个 Vector4 实例
local v = Vector4(10, 20, 5, 15)
-- 获取最大分量值
local maxVal = v:GetMaxValue()
-- 输出最大分量值
print("最大分量值:", maxVal)
```
