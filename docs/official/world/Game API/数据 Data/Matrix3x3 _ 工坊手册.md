# Matrix3x3

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html) 表示一个 3×3 浮点矩阵，用于三维空间中的线性变换计算。它支持矩阵乘法、转置、求逆、行列式与迹等常见运算，并可将矩阵作用于三维向量。

## 适用场景

常用于物理模拟、坐标变换或自定义几何计算中，需要表示旋转、缩放或剪切等线性变换时。

## 使用要点

通过 Matrix3x3.New(...) 或 [Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html)(...) 构造实例，传入九个浮点数按行优先顺序填充。然后可调用 GetTranspose 获取转置矩阵，或使用 Apply 将矩阵作用于 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 得到变换后的向量。

## 注意事项

[Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html) 是纯数据矩阵。Clone、GetTranspose、GetInverse、GetAbsoluteMatrix、Identity、Zero 和 ComputeSkewSymmetricMatrixForCrossProduct 返回新矩阵；SetAllValues、SetToZero 与 SetToIdentity 会原地修改当前实例。求逆前应确保矩阵可逆。

## 代码示例

### 构造可逆矩阵并读取行列式

```lua
-- @runtime client
local matrix = Matrix3x3.New(
    1, 0, 0,
    0, 2, 0,
    0, 0, 3
)
print('行列式:', matrix:GetDeterminant())
local inverse = matrix:GetInverse()
print('逆矩阵第一行:', inverse:GetRow(0))
```

## 函数 (16)

### New

签名：`New(m00: Float, m01: Float, m02: Float, m10: Float, m11: Float, m12: Float, m20: Float, m21: Float, m22: Float) -> Matrix3x3`

创建一个新的 3x3 矩阵，按行主序传入 9 个浮点数参数。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `m00` | `Float` | - |
| `m01` | `Float` | - |
| `m02` | `Float` | - |
| `m10` | `Float` | - |
| `m11` | `Float` | - |
| `m12` | `Float` | - |
| `m20` | `Float` | - |
| `m21` | `Float` | - |
| `m22` | `Float` | - |

**返回值** [Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html)

> 示例代码

> 构造 3x3 矩阵

```lua
-- @runtime client
-- 按 9 个分量构造（行优先）
local m = Matrix3x3.New(1, 0, 0, 0, 1, 0, 0, 0, 1)
print('构造的矩阵:', tostring(m))
```

### Clone

签名：`Clone() -> Matrix3x3`

创建当前矩阵的一个完全独立的副本。

**返回值** [Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html)

> 示例代码

> 克隆矩阵并验证独立性

```lua
-- @runtime client
-- 构造一个 3x3 矩阵
local mat = Matrix3x3(1, 2, 3, 4, 5, 6, 7, 8, 9)
-- 克隆矩阵
local cloned = mat:Clone()
-- 修改原矩阵，验证克隆体不受影响
mat:SetAllValues(0, 0, 0, 0, 0, 0, 0, 0, 0)
-- 打印克隆矩阵的第一行，应为原始值
local row0 = cloned:GetRow(0)
print("克隆矩阵第一行:", row0.x, row0.y, row0.z)
```

### SetAllValues

签名：`SetAllValues(m00: Float, m01: Float, m02: Float, m10: Float, m11: Float, m12: Float, m20: Float, m21: Float, m22: Float) -> void`

一次性设置 3x3 矩阵的全部 9 个元素值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `m00` | `Float` | - |
| `m01` | `Float` | - |
| `m02` | `Float` | - |
| `m10` | `Float` | - |
| `m11` | `Float` | - |
| `m12` | `Float` | - |
| `m20` | `Float` | - |
| `m21` | `Float` | - |
| `m22` | `Float` | - |

**返回值** `void`

> 示例代码

> 批量设置矩阵分量

```lua
-- @runtime client
local m = Matrix3x3.Identity()
m:SetAllValues(1, 0, 0, 0, 1, 0, 0, 0, 1)
print('已设置为单位矩阵')
```

### SetToZero

签名：`SetToZero() -> void`

将当前矩阵的所有元素设置为 0。

**返回值** `void`

> 示例代码

> 重置为零矩阵

```lua
-- @runtime client
local m = Matrix3x3.Identity()
m:SetToZero()
print('已重置为零矩阵')
```

### GetTranspose

签名：`GetTranspose() -> Matrix3x3`

返回当前矩阵的转置矩阵。

**返回值** [Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html)

> 示例代码

> 转置矩阵并检查行列互换

```lua
-- @runtime client
local matrix = Matrix3x3.New(
    1, 2, 3,
    4, 5, 6,
    7, 8, 9
)
local transposed = matrix:GetTranspose()
local originalRow0 = matrix:GetRow(0)
local transposedColumn0 = transposed:GetColumn(0)
print('原矩阵第 0 行:', originalRow0)
print('转置矩阵第 0 列:', transposedColumn0)
```

### GetDeterminant

签名：`GetDeterminant() -> Float`

计算并返回矩阵的行列式值。

**返回值** `Float`

> 示例代码

> 计算矩阵行列式

```lua
-- @runtime client
-- 构造一个可逆矩阵
local mat = Matrix3x3(1, 0, 0, 0, 2, 0, 0, 0, 3)
-- 计算行列式
local det = mat:GetDeterminant()
print("行列式:", det)
```

### GetTrace

签名：`GetTrace() -> Float`

计算并返回矩阵的迹，即主对角线元素之和。

**返回值** `Float`

> 示例代码

> 计算矩阵的迹

```lua
-- @runtime client
-- 构造一个矩阵
local mat = Matrix3x3(1, 2, 3, 4, 5, 6, 7, 8, 9)
-- 计算迹（对角线元素之和）
local trace = mat:GetTrace()
print("迹:", trace)
```

### GetInverse

签名：`GetInverse() -> Matrix3x3`

计算并返回当前矩阵的逆矩阵。

**返回值** [Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html)

> 示例代码

> 求逆矩阵并验证

```lua
-- @runtime client
-- 构造一个可逆矩阵
local mat = Matrix3x3(1, 0, 0, 0, 2, 0, 0, 0, 3)
-- 求逆矩阵
local inv = mat:GetInverse()
-- 用逆矩阵乘以原矩阵的列向量，应得到单位向量
local col0 = mat:GetColumn(0)
local result = inv:Apply(col0)
print("逆矩阵作用后:", result.x, result.y, result.z)
```

### GetAbsoluteMatrix

签名：`GetAbsoluteMatrix() -> Matrix3x3`

返回一个新矩阵，其每个元素是原矩阵对应元素的绝对值。

**返回值** [Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html)

> 示例代码

> 获取逐元素绝对值矩阵

```lua
-- @runtime client
-- 构造一个包含负数的矩阵
local mat = Matrix3x3(-1, 2, -3, 4, -5, 6, -7, 8, -9)
-- 获取绝对值矩阵
local absMat = mat:GetAbsoluteMatrix()
-- 打印绝对值矩阵的第一行
local row0 = absMat:GetRow(0)
print("绝对值矩阵第一行:", row0.x, row0.y, row0.z)
```

### SetToIdentity

签名：`SetToIdentity() -> void`

将当前矩阵设置为单位矩阵，对角线元素变为 1，其余变为 0。

**返回值** `void`

> 示例代码

> 重置为单位矩阵

```lua
-- @runtime client
local m = Matrix3x3.New(2, 0, 0, 0, 2, 0, 0, 0, 2)
m:SetToIdentity()
print('已重置为单位矩阵')
```

### Identity

签名：`Identity() -> Matrix3x3`

返回一个 3x3 单位矩阵（对角线元素为 1，其余为 0）。

**返回值** [Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html)

> 示例代码

> 获取 3x3 单位矩阵

```lua
-- @runtime client
local m = Matrix3x3.Identity()
print('3x3 单位矩阵:', tostring(m))
```

### Zero

签名：`Zero() -> Matrix3x3`

返回一个所有元素均为 0 的 3x3 零矩阵。

**返回值** [Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html)

> 示例代码

> 获取零矩阵

```lua
-- @runtime client
-- 获取零矩阵
local zero = Matrix3x3.Zero()
-- 验证零矩阵乘以向量得到零向量
local vec = Vector3(1, 2, 3)
local result = zero:Apply(vec)
print("零矩阵作用后:", result.x, result.y, result.z)
```

### GetColumn

签名：`GetColumn(col: Int) -> Vector3`

获取矩阵中指定列（索引从 0 开始）的三个元素，以 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 形式返回。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `col` | `Int` | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 获取矩阵指定列

```lua
-- @runtime client
-- 构造一个矩阵
local mat = Matrix3x3(1, 2, 3, 4, 5, 6, 7, 8, 9)
-- 获取第1列（索引从0开始）
local col1 = mat:GetColumn(1)
print("第1列:", col1.x, col1.y, col1.z)
```

### GetRow

签名：`GetRow(row: Int) -> Vector3`

获取矩阵中指定行（索引从 0 开始）的三个元素，以 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 形式返回。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `row` | `Int` | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 获取矩阵指定行

```lua
-- @runtime client
-- 构造一个矩阵
local mat = Matrix3x3(1, 2, 3, 4, 5, 6, 7, 8, 9)
-- 获取第2行（索引从0开始）
local row2 = mat:GetRow(2)
print("第2行:", row2.x, row2.y, row2.z)
```

### ComputeSkewSymmetricMatrixForCrossProduct

签名：`ComputeSkewSymmetricMatrixForCrossProduct(v: Vector3) -> Matrix3x3`

根据给定的向量构造一个反对称矩阵，使得该矩阵与任意向量的乘积等于原向量与任意向量的叉积。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `v` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html)

> 示例代码

> 构造叉积反对称矩阵

```lua
-- @runtime client
local v = Vector3.New(1, 2, 3)
local w = Vector3.New(4, 5, 6)
local skewMatrix = Matrix3x3.ComputeSkewSymmetricMatrixForCrossProduct(v)
local fromMatrix = skewMatrix:Apply(w)
local fromCross = v:Cross(w)
print('矩阵结果:', fromMatrix, '叉积结果:', fromCross)
```

### Apply

签名：`Apply(v: Vector3) -> Vector3`

将当前 3x3 矩阵与一个 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 向量相乘，返回变换后的新向量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `v` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 矩阵乘以向量

```lua
-- @runtime client
-- 构造一个缩放矩阵
local mat = Matrix3x3(2, 0, 0, 0, 3, 0, 0, 0, 4)
-- 构造一个向量
local vec = Vector3(1, 1, 1)
-- 矩阵乘向量
local result = mat:Apply(vec)
print("结果向量:", result.x, result.y, result.z)
```
