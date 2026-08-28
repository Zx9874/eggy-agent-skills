# Quaternion

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

四元数用于表示三维空间中的旋转，可避免欧拉角的万向节死锁问题。它提供从轴角、欧拉角构造旋转的能力，并支持球面线性插值、归一化、求逆、旋转向量等常用运算。

## 适用场景

在需要平滑旋转插值的场景（如相机过渡、动画混合）中，使用四元数进行球面线性插值（Slerp）可获得均匀的角速度变化。

## 使用要点

通过 Quaternion.New(x, y, z, w) 或 [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)(x, y, z, w) 构造实例，也可使用 FromAxisAngle 或 FromEulerAngles 从其他旋转表示创建。调用 Slerp 或 Nlerp 在两个四元数之间插值，再通过 Apply 方法旋转向量。

## 注意事项

四元数实例可通过 New 或直接调用类型名构造，无需依赖外部服务。使用 Slerp 时需确保输入四元数为单位四元数，否则结果可能不符合预期。

## 代码示例

### 构造四元数并读取属性

```lua
-- @runtime client
-- 使用简写构造一个四元数 (x, y, z, w)
local q = Quaternion(0.0, 0.0, 0.0, 1.0)
-- 读取四元数的各个分量
local x = q.x
local y = q.y
local z = q.z
local w = q.w
-- 读取欧拉角表示
local euler = q.Euler
-- 读取绕各轴的旋转角度
local pitch = q.Pitch
local yaw = q.Yaw
local roll = q.Roll
-- 打印部分属性以验证
print(string.format("x=%.2f, y=%.2f, z=%.2f, w=%.2f", x, y, z, w))
print(string.format("Pitch=%.2f, Yaw=%.2f, Roll=%.2f", pitch, yaw, roll))
```

## 属性 (8)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `x` | `Float` | `-` | 四元数的 X 分量（向量部分）。 |
| `y` | `Float` | `-` | 四元数的 Y 分量（向量部分）。 |
| `z` | `Float` | `-` | 四元数的 Z 分量（向量部分）。 |
| `w` | `Float` | `-` | 四元数的 W 分量（标量部分）。 |
| `Euler` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 四元数对应的欧拉角（弧度，ZXY 顺序），只读。 |
| `Pitch` | `Float` | `-` | 俯仰角（弧度，ZXY 顺序），绕 X 轴的旋转。 |
| `Yaw` | `Float` | `-` | 偏航角（弧度，ZXY 顺序），绕 Z 轴的旋转。 |
| `Roll` | `Float` | `-` | 翻滚角（弧度，ZXY 顺序），绕 Y 轴的旋转。 |

## 关联类型

* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 函数 (28)

### New

签名：`New(x: Float, y: Float, z: Float, w: Float) -> Quaternion`

创建一个新的四元数实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `x` | `Float` | - |
| `y` | `Float` | - |
| `z` | `Float` | - |
| `w` | `Float` | - |

**返回值** [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)

> 示例代码

> 构造单位四元数

```lua
-- @runtime client
local q = Quaternion.New(0, 0, 0, 1)
print(string.format('单位四元数: x=%.1f y=%.1f z=%.1f w=%.1f', q.x, q.y, q.z, q.w))
```

### Identity

签名：`Identity() -> Quaternion`

返回一个单位四元数，其分量为 (0, 0, 0, 1)，表示无旋转。

**返回值** [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)

> 示例代码

> 获取单位四元数（无旋转）

```lua
-- @runtime client
local q = Quaternion.Identity()
print(string.format('单位四元数: x=%.1f y=%.1f z=%.1f w=%.1f', q.x, q.y, q.z, q.w))
print('是否单位四元数:', q:IsUnit())
```

### FromAxisAngle

签名：`FromAxisAngle(axis: Vector3, angle: Float) -> Quaternion`

根据给定的旋转轴和角度（弧度）构造一个单位四元数，表示绕该轴旋转指定角度的旋转。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `axis` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 旋转轴（应为单位向量） |
| `angle` | `Float` | 旋转角度（弧度） |

**返回值** [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)

> 示例代码

> 从轴角构造四元数

```lua
-- @runtime client
-- 绕 Y 轴旋转 90 度（弧度）
local axis = Vector3.New(0, 1, 0)
local angle = 1.5708  -- 90 度
local q = Quaternion.FromAxisAngle(axis, angle)
print(string.format('四元数: x=%.4f y=%.4f z=%.4f w=%.4f', q.x, q.y, q.z, q.w))
```

### FromEulerAngles

签名：`FromEulerAngles(x: Float, y: Float, z: Float) -> Quaternion`

根据欧拉角（弧度，ZXY 顺序）构造四元数，参数依次为 pitch、yaw、roll。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `x` | `Float` | Pitch（弧度） |
| `y` | `Float` | Yaw（弧度） |
| `z` | `Float` | Roll（弧度） |

**返回值** [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)

> 示例代码

> 从欧拉角构造四元数

```lua
-- @runtime client
-- FromEulerAngles 的参数按 Meta 标注传入弧度：pitch, yaw, roll
local q = Quaternion.FromEulerAngles(math.rad(30), math.rad(45), 0)
print(string.format('Pitch=%.4f Yaw=%.4f Roll=%.4f', q.Pitch, q.Yaw, q.Roll))
```

### Slerp

签名：`Slerp(a: Quaternion, b: Quaternion, t: Float) -> Quaternion`

在两个四元数之间进行球面线性插值，返回插值后的四元数。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `a` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | - |
| `b` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | - |
| `t` | `Float` | 插值因子 [0, 1] |

**返回值** [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)

> 示例代码

> 球面线性插值两个四元数（恒定角速度）

```lua
-- @runtime client
local q1 = Quaternion.Identity()
local q2 = Quaternion.FromAxisAngle(Vector3.New(0,1,0), 1.5708)
local mid = Quaternion.Slerp(q1, q2, 0.5)  -- 50% 球面插值
print(string.format('Slerp 结果 w=%.4f', mid.w))
```

### Nlerp

签名：`Nlerp(a: Quaternion, b: Quaternion, t: Float) -> Quaternion`

对两个四元数 a 和 b 进行归一化线性插值，返回插值结果。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `a` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | - |
| `b` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | - |
| `t` | `Float` | 插值因子 [0, 1] |

**返回值** [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)

> 示例代码

> 归一化线性插值两个四元数

```lua
-- @runtime client
local q1 = Quaternion.Identity()
local q2 = Quaternion.FromAxisAngle(Vector3.New(0,1,0), 1.5708)
local mid = Quaternion.Nlerp(q1, q2, 0.5)  -- 50% 插值
print(string.format('插值结果 w=%.4f', mid.w))
```

### Length

签名：`Length() -> Float`

计算四元数的模长（即各分量平方和的平方根）。

**返回值** `Float`

> 示例代码

> 计算四元数的长度

```lua
-- @runtime client
-- 构造一个非单位四元数
local q = Quaternion(1, 2, 3, 4)
-- 计算长度
local len = q:Length()
print("四元数长度:", len)
```

### LengthSquare

签名：`LengthSquare() -> Float`

计算四元数长度的平方，即各分量平方和。

**返回值** `Float`

> 示例代码

> 计算四元数长度的平方

```lua
-- @runtime client
-- 构造一个四元数
local q = Quaternion(1, 2, 3, 4)
-- 计算长度的平方
local lenSq = q:LengthSquare()
print("四元数长度平方:", lenSq)
```

### Normalize

签名：`Normalize() -> void`

将当前四元数归一化为单位四元数，使其模长为1。归一化后的四元数保持相同的旋转方向，但长度变为1。

**返回值** `void`

> 示例代码

> 归一化四元数并验证长度

```lua
-- @runtime client
-- 创建一个非单位四元数
local q = Quaternion(1, 2, 3, 4)
-- 归一化
q:Normalize()
-- 输出归一化后的分量
print("x:", q.x, "y:", q.y, "z:", q.z, "w:", q.w)
-- 验证长度是否接近 1
print("Length:", q:Length())
```

### Inverse

签名：`Inverse() -> void`

将当前四元数就地修改为其逆四元数。逆四元数表示与原旋转相反的旋转。

**返回值** `void`

> 示例代码

> 求四元数的逆（反向旋转）

```lua
-- @runtime client
local q = Quaternion.FromAxisAngle(Vector3.New(0,1,0), 1.5708)
q:Inverse()
-- Inverse 会就地修改当前四元数
print('逆四元数 w:', q.w)
```

### GetUnit

签名：`GetUnit() -> Quaternion`

返回当前四元数的单位化版本，即方向相同但长度为1的四元数。

**返回值** [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)

> 示例代码

> 获取四元数的单位化版本

```lua
-- @runtime client
-- 构造一个非单位四元数
local q = Quaternion(1, 2, 3, 4)
-- 获取单位四元数
local unitQ = q:GetUnit()
print("单位化后的长度:", unitQ:Length())
```

### GetConjugate

签名：`GetConjugate() -> Quaternion`

返回当前四元数的共轭四元数。共轭四元数的虚部取反，实部不变。

**返回值** [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)

> 示例代码

> 获取四元数的共轭

```lua
-- @runtime client
-- 构造一个四元数
local q = Quaternion(1, 2, 3, 4)
-- 获取共轭
local conj = q:GetConjugate()
print("共轭四元数:", conj.x, conj.y, conj.z, conj.w)
```

### GetInverse

签名：`GetInverse() -> Quaternion`

返回当前四元数的逆。逆四元数表示相反的旋转，满足 q \* q:GetInverse() = 单位四元数。

**返回值** [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)

> 示例代码

> 获取四元数的逆

```lua
-- @runtime client
local q = Quaternion.FromEulerAngles(0, math.rad(90), 0)
local qInv = q:GetInverse()
print('逆四元数 w:', qInv.w)
```

### GetMatrix

签名：`GetMatrix() -> Matrix3x3`

返回当前四元数对应的 3x3 旋转矩阵。

**返回值** [Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html)

> 示例代码

> 获取四元数对应的旋转矩阵

```lua
-- @runtime client
local q = Quaternion.FromEulerAngles(0, math.rad(90), 0)
local matrix = q:GetMatrix()
print('旋转矩阵:', tostring(matrix))
```

### GetVectorV

签名：`GetVectorV() -> Vector3`

返回当前四元数的向量部分，即 (x, y, z) 分量构成的 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 获取四元数的向量部分

```lua
-- @runtime client
-- 构造一个四元数
local q = Quaternion(1, 2, 3, 4)
-- 获取向量部分 (x, y, z)
local v = q:GetVectorV()
print("向量部分:", v)
```

### SetToIdentity

签名：`SetToIdentity() -> void`

将当前四元数重置为单位四元数（即无旋转状态）。

**返回值** `void`

> 示例代码

> 将四元数设置为单位四元数

```lua
-- @runtime client
-- 创建一个非单位四元数
local q = Quaternion(1, 2, 3, 4)
-- 设置为单位四元数
q:SetToIdentity()
-- 输出分量，应为 (0, 0, 0, 1)
print("x:", q.x, "y:", q.y, "z:", q.z, "w:", q.w)
-- 验证是否为单位四元数
print("IsUnit:", q:IsUnit())
```

### Dot

签名：`Dot(rhs: Quaternion) -> Float`

计算当前四元数与另一个四元数的点积，返回一个标量值。点积可用于衡量两个四元数方向的相似程度，值越大表示方向越接近。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `rhs` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | - |

**返回值** `Float`

> 示例代码

> 计算两个四元数的点积

```lua
-- @runtime client
-- 创建两个四元数
local q1 = Quaternion(1, 0, 0, 0)
local q2 = Quaternion(0, 1, 0, 0)
-- 计算点积
local dot = q1:Dot(q2)
print("点积:", dot)
```

### GetRotationAngleAxis

签名：`GetRotationAngleAxis() -> Vector4`

返回当前四元数所表示的旋转角度和旋转轴，结果为一个 [Vector4](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector4.html)，其中前三个分量为旋转轴的单位向量，第四个分量为旋转角度（弧度）。

**返回值** [Vector4](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector4.html)

> 示例代码

> 获取轴角表示

```lua
-- @runtime client
local q = Quaternion.FromEulerAngles(0, math.rad(90), 0)
local axisAngle = q:GetRotationAngleAxis()
print('旋转轴:', axisAngle.x, axisAngle.y, axisAngle.z)
print('旋转角度（弧度）:', axisAngle.w)
```

### GetPitch

签名：`GetPitch() -> Float`

返回当前四元数旋转的俯仰角（Pitch），单位为弧度。

**返回值** `Float`

> 示例代码

> 读取俯仰角

```lua
-- @runtime client
local q = Quaternion.FromEulerAngles(math.rad(30), 0, 0)
local pitch = q:GetPitch()
print('俯仰角（弧度）:', pitch)
```

### GetYaw

签名：`GetYaw() -> Float`

获取四元数对应的偏航角（弧度）。

**返回值** `Float`

> 示例代码

> 读取偏航角

```lua
-- @runtime client
local q = Quaternion.FromEulerAngles(0, math.rad(60), 0)
local yaw = q:GetYaw()
print('偏航角（弧度）:', yaw)
```

### GetRoll

签名：`GetRoll() -> Float`

返回当前四元数对应的翻滚角（Roll），单位为弧度。

**返回值** `Float`

> 示例代码

> 读取翻滚角

```lua
-- @runtime client
local q = Quaternion.FromEulerAngles(0, 0, math.rad(45))
local roll = q:GetRoll()
print('翻滚角（弧度）:', roll)
```

### IsFinite

签名：`IsFinite() -> Bool`

检查四元数的所有分量（x, y, z, w）是否均为有限数值，即不是 NaN 或无穷大。

**返回值** `Bool`

> 示例代码

> 检查四元数分量是否均为有限数

```lua
-- @runtime client
-- 构造一个正常四元数
local q = Quaternion(1, 2, 3, 4)
-- 检查是否有限
print("IsFinite:", q:IsFinite())
```

### IsUnit

签名：`IsUnit() -> Bool`

判断当前四元数是否为单位四元数，即模长是否接近 1。

**返回值** `Bool`

> 示例代码

> 检查四元数是否为单位四元数

```lua
-- @runtime client
-- 构造一个单位四元数
local q = Quaternion.Identity()
-- 检查是否为单位四元数
print("IsUnit:", q:IsUnit())
```

### IsValid

签名：`IsValid() -> Bool`

判断当前四元数是否有效，即所有分量均为有限数值且模长为1（单位四元数）。

**返回值** `Bool`

> 示例代码

> 检查四元数是否有效（有限且单位）

```lua
-- @runtime client
-- 构造一个单位四元数
local q = Quaternion.Identity()
-- 检查是否有效
print("IsValid:", q:IsValid())
```

### Apply

签名：`Apply(v: Vector3) -> Vector3`

将当前四元数表示的旋转应用到传入的三维向量上，返回旋转后的新向量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `v` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 将旋转应用到向量

```lua
-- @runtime client
local q = Quaternion.FromEulerAngles(0, math.rad(90), 0)
local forward = Vector3.New(0, 0, 1)
local rotated = q:Apply(forward)
print('旋转后的向量:', tostring(rotated))
```

### GetForward

签名：`GetForward() -> Vector3`

返回当前四元数旋转所对应的前向方向向量（局部 Z 轴正方向在世界空间中的指向）。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 获取前向向量

```lua
-- @runtime client
local q = Quaternion.FromEulerAngles(0, math.rad(90), 0)
local forward = q:GetForward()
print('前向向量:', tostring(forward))
```

### GetUp

签名：`GetUp() -> Vector3`

返回当前四元数旋转所对应的上方向单位向量（世界坐标系 Y 轴方向）。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 获取上向向量

```lua
-- @runtime client
local q = Quaternion.FromEulerAngles(math.rad(-90), 0, 0)
local up = q:GetUp()
print('上向向量:', tostring(up))
```

### GetRight

签名：`GetRight() -> Vector3`

返回当前四元数旋转对应的右方向单位向量。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 获取右向向量

```lua
-- @runtime client
local q = Quaternion.FromEulerAngles(0, math.rad(90), 0)
local right = q:GetRight()
print('右向向量:', tostring(right))
```
