# CFrame

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 是描述三维空间中物体位置与朝向的坐标帧，既可作为绝对的世界变换，也可作为局部坐标系参与空间换算。它提供位置、旋转矩阵、方向向量等属性，并支持点、向量、坐标帧在相同或不同坐标系之间的相互转换，同时提供角度分解、插值、相似性比较等常用运算。

## 适用场景

在需要为角色、模型或特效设置出生位置与朝向，或在一段路径上插值移动物体时，使用 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 表达其世界变换；在同步与校验中，也常通过读取单位的 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 属性获取其精确位置与旋转。

## 使用要点

通过 CFrame.New(...) 或 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 等价简写创建一个新的坐标帧实例，例如 CFrame.New(0, 5, 0) 表示原点上方五米处；需要面向某目标时，使用静态方法 CFrame.LookAt(at, target, up) 或 CFrame.LookAlong(at, dir, up) 构造朝向。将坐标帧赋值给单位的 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 或 Position 等属性即可应用变换，也可通过实例方法 cf:LookAt(target, up) 在保持自身位置不变的情况下转向目标。

## 注意事项

[CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的静态构造方法（New/LookAt/LookAlong/FromEulerAnglesXYZ 等）必须用点语法 CFrame.Method(...) 调用，禁止冒号语法 CFrame:Method(...)。注意 LookAt 有实例方法和静态方法两种形态：cf:LookAt(target, up) 保持 cf 自身位置不变，只改变朝向；CFrame.LookAt(at, target, up) 才表示在 at 位置构造一个朝向 target 的新 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)。写示例时必须按这两个签名区分参数。注意：[CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 不存在 Angles 方法，请使用 FromEulerAnglesXYZ/FromEulerAnglesYXZ（弧度）。当前运行包调用 FromMatrix(pos, vX, vY, vZ) 会触发 userdata 到 [Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html) 的隐式转换错误，在修复前请使用 LookAlong/LookAt 或 New 的公开重载表达位置与朝向。

## 代码示例

### 构造坐标帧并读取属性

```lua
-- @runtime client
local cf = CFrame.New(10, 20, 30)
local pos = cf.Position
print("位置:", pos.x, pos.y, pos.z)
local inv = cf:Inverse()
print("逆变换位置:", inv.Position.x, inv.Position.y, inv.Position.z)
local look = cf.LookVector
print("朝向分量:", look.x, look.y, look.z)
```

### 使用 LookAt 构造朝向并做坐标变换

```lua
-- @runtime client
local origin = Vector3.New(0, 0, 0)
local target = Vector3.New(10, 0, 0)
local up = Vector3.New(0, 1, 0)
local lookAt = CFrame.LookAt(origin, target, up)
local localPoint = Vector3.New(0, 0, 5)
local worldPoint = lookAt:PointToWorldSpace(localPoint)
print("世界坐标:", worldPoint.x, worldPoint.y, worldPoint.z)
local right = lookAt.RightVector
print("右向量:", right.x, right.y, right.z)
```

## 属性 (12)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `X` | `Float` | `-` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 位置的 X 坐标分量。 |
| `Y` | `Float` | `-` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 位置的 Y 坐标分量。 |
| `Z` | `Float` | `-` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 位置的 Z 坐标分量。 |
| `Position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的位置部分，表示坐标系原点的世界坐标。 |
| `Rotation` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | `-` | 仅保留旋转部分的 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)，位置被清零。 |
| `RightVector` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 右方向单位向量，指向 +X 方向。 |
| `UpVector` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 上方向单位向量，指向 +Y 方向。 |
| `LookVector` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 获取 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的前方朝向单位向量；按当前 Meta 契约，它对应旋转矩阵的 column 2，与 ZVector 等同。 |
| `LeftVector` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 左方向单位向量，等于 -RightVector。 |
| `XVector` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 旋转矩阵的第一列，等同于 RightVector。 |
| `YVector` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 旋转矩阵的第二列，等同于 UpVector。 |
| `ZVector` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 旋转矩阵的第三列，等同于 LookVector。 |

## 关联类型

* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 函数 (29)

### Inverse

签名：`Inverse() -> CFrame`

返回当前 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的逆变换，可用于把世界空间中的变换转换到当前 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的局部空间。

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 计算 CFrame 的逆变换

```lua
-- @runtime client
-- 构造一个非单位 CFrame
local cf = CFrame(Vector3.New(10, 20, 30)) * CFrame.FromEulerAnglesXYZ(0.5, 0.3, 0.1)
-- 求逆变换
local invCf = cf:Inverse()
-- 验证逆变换：原变换再应用逆变换应回到原点
local result = cf * invCf
print("逆变换后的位置:", result.Position)
```

### ToWorldSpace

签名：`ToWorldSpace(cf: CFrame) -> CFrame`

将另一个 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 从当前 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的局部空间变换到世界空间，等价于 self \* cf。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `cf` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | 局部坐标系下的 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 将物体局部空间 CFrame 转换到世界空间

```lua
-- @runtime client
-- 定义物体自身的世界变换
local objectCf = CFrame(Vector3.New(5, 0, 0)) * CFrame.FromEulerAnglesXYZ(0, math.pi / 4, 0)
-- 定义物体局部空间中的一个偏移 CFrame
local localOffset = CFrame(Vector3.New(1, 0, 0))
-- 转换到世界空间
local worldCf = objectCf:ToWorldSpace(localOffset)
print("世界空间位置:", worldCf.Position)
```

### ToObjectSpace

签名：`ToObjectSpace(cf: CFrame) -> CFrame`

将另一个 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 从世界空间变换到当前 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的局部空间，等价于 self:Inverse() \* cf。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `cf` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | 世界坐标系下的 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 将世界空间 CFrame 转换到物体局部空间

```lua
-- @runtime client
-- 定义物体自身的世界变换
local objectCf = CFrame(Vector3.New(5, 0, 0)) * CFrame.FromEulerAnglesXYZ(0, math.pi / 4, 0)
-- 定义世界空间中的另一个 CFrame
local worldCf = CFrame(Vector3.New(6, 1, 0))
-- 转换到物体局部空间
local localCf = objectCf:ToObjectSpace(worldCf)
print("局部空间位置:", localCf.Position)
```

### Lerp

签名：`Lerp(goal: CFrame, alpha: Float) -> CFrame`

在当前 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 和目标 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 之间进行线性插值，位置使用线性插值，旋转使用球面线性插值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `goal` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | 插值目标 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) |
| `alpha` | `Float` | 插值系数 |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 在两个 CFrame 之间进行线性插值

```lua
-- @runtime client
-- 定义起始和目标 CFrame
local startCf = CFrame(Vector3.New(0, 0, 0))
local goalCf = CFrame(Vector3.New(10, 0, 0)) * CFrame.FromEulerAnglesXYZ(0, math.pi / 2, 0)
-- 在中间位置插值
local alpha = 0.5
local midCf = startCf:Lerp(goalCf, alpha)
print("插值结果位置:", midCf.Position)
print("插值结果旋转:", midCf.Rotation)
```

### Orthonormalize

签名：`Orthonormalize() -> CFrame`

对旋转矩阵进行 Gram-Schmidt 正交化，修正因数值累积导致的非正交漂移。

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 正交化坐标帧的旋转基

```lua
-- @runtime client
local cf = CFrame.New(1, 2, 3) * CFrame.FromEulerAnglesXYZ(0.2, 0.4, 0.1)
local ortho = cf:Orthonormalize()
print("正交化后的位置:", ortho.Position)
print("右向量长度:", ortho.RightVector.Magnitude)
```

### FuzzyEq

签名：`FuzzyEq(other: CFrame, epsilon: Float) -> Bool`

判断两个 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 是否在给定容差内近似相等，同时比较位置和旋转部分。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | 用于比较的另一个 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) |
| `epsilon` | `Float` | 允许的最大分量误差，默认 1e-5 |

**返回值** `Bool`

> 示例代码

> 比较两个 CFrame 是否近似相等

```lua
-- @runtime client
-- 构造两个位置和旋转都接近的 CFrame
local cf1 = CFrame(Vector3.New(1, 2, 3)) * CFrame.FromEulerAnglesXYZ(0.1, 0.2, 0.3)
local cf2 = CFrame(Vector3.New(1.0001, 2.0001, 3.0001)) * CFrame.FromEulerAnglesXYZ(0.1001, 0.2001, 0.3001)
-- 使用 FuzzyEq 检查是否在容差范围内相等
local epsilon = 0.001
local isEqual = cf1:FuzzyEq(cf2, epsilon)
print("两个 CFrame 是否近似相等:", isEqual)
```

### LookAt

签名：`LookAt(target: Vector3, up: Vector3) -> CFrame`

返回一个新的 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)，其位置与当前 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 相同，但朝向指向目标点。

⚙ LookAt 同时存在实例方法与静态工厂方法：cf:LookAt(target, up) 使用 cf 当前的位置；CFrame.LookAt(at, target, up) 使用显式 at 位置。两者参数数量不同，不要把静态示例写进实例签名。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `target` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 希望朝向的世界坐标点 |
| `up` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 参考上方向，用于消除滚转自由度，默认 (0,1,0) |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 区分实例 LookAt 与静态 LookAt

```lua
-- @runtime client
local up = Vector3.New(0, 1, 0)
local at = Vector3.New(0, 2, 0)
local target = Vector3.New(10, 2, 0)

-- 静态工厂：显式指定起点 at 与朝向目标 target
local staticCf = CFrame.LookAt(at, target, up)

-- 实例方法：保留 base 的当前位置，只调整朝向
local base = CFrame.New(5, 2, 0)
local instanceCf = base:LookAt(target, up)

print(staticCf.Position, instanceCf.Position)
```

### PointToWorldSpace

签名：`PointToWorldSpace(point: Vector3) -> Vector3`

将局部坐标点变换到世界坐标系下。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `point` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 局部坐标系下的点坐标 |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 将物体局部坐标点转换到世界坐标

```lua
-- @runtime client
-- 定义物体自身的世界变换
local objectCf = CFrame(Vector3.New(5, 0, 0)) * CFrame.FromEulerAnglesXYZ(0, math.pi / 4, 0)
-- 定义物体局部空间中的一个点
local localPoint = Vector3.New(1, 0, 0)
-- 转换到世界空间
local worldPoint = objectCf:PointToWorldSpace(localPoint)
print("世界坐标:", worldPoint)
```

### PointToObjectSpace

签名：`PointToObjectSpace(point: Vector3) -> Vector3`

将世界坐标点变换到当前 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的局部坐标系下。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `point` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界坐标系下的点坐标 |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 将世界坐标点转换到物体局部坐标

```lua
-- @runtime client
-- 定义物体自身的世界变换
local objectCf = CFrame(Vector3.New(5, 0, 0)) * CFrame.FromEulerAnglesXYZ(0, math.pi / 4, 0)
-- 定义世界空间中的一个点
local worldPoint = Vector3.New(6, 1, 0)
-- 转换到物体局部空间
local localPoint = objectCf:PointToObjectSpace(worldPoint)
print("局部坐标:", localPoint)
```

### VectorToWorldSpace

签名：`VectorToWorldSpace(vector: Vector3) -> Vector3`

将局部方向向量变换到世界坐标系下，忽略位移。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `vector` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 局部坐标系下的方向向量 |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 将物体局部方向向量转换到世界方向

```lua
-- @runtime client
-- 定义物体自身的世界变换
local objectCf = CFrame(Vector3.New(5, 0, 0)) * CFrame.FromEulerAnglesXYZ(0, math.pi / 4, 0)
-- 定义物体局部空间中的一个方向向量
local localDir = Vector3.New(1, 0, 0)
-- 转换到世界空间（忽略位移）
local worldDir = objectCf:VectorToWorldSpace(localDir)
print("世界方向:", worldDir)
```

### VectorToObjectSpace

签名：`VectorToObjectSpace(vector: Vector3) -> Vector3`

将世界方向向量变换到当前 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的局部坐标系下，忽略位移。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `vector` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界坐标系下的方向向量 |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 将世界方向向量转换到物体局部方向

```lua
-- @runtime client
-- 定义物体自身的世界变换
local objectCf = CFrame(Vector3.New(5, 0, 0)) * CFrame.FromEulerAnglesXYZ(0, math.pi / 4, 0)
-- 定义世界空间中的一个方向向量
local worldDir = Vector3.New(1, 0, 0)
-- 转换到物体局部空间（忽略位移）
local localDir = objectCf:VectorToObjectSpace(worldDir)
print("局部方向:", localDir)
```

### ToEulerAnglesXYZ

签名：`ToEulerAnglesXYZ() -> Float (X轴旋转（弧度）)`

将旋转部分分解为外部 XYZ 顺序的欧拉角，返回弧度值。

**返回值** `Float` (X轴旋转（弧度）)

> 示例代码

> 按 XYZ 顺序提取欧拉角

```lua
-- @runtime client
local cf = CFrame.FromEulerAnglesXYZ(0.5, 0.3, 0.1)
local x, y, z = cf:ToEulerAnglesXYZ()
print(string.format('XYZ 欧拉角: %.4f, %.4f, %.4f', x, y, z))
```

### ToEulerAnglesYXZ

签名：`ToEulerAnglesYXZ() -> Float (X轴旋转（弧度）)`

将旋转部分分解为外部 YXZ 顺序的欧拉角，返回弧度值。

**返回值** `Float` (X轴旋转（弧度）)

> 示例代码

> 按 YXZ 顺序提取欧拉角

```lua
-- @runtime client
local cf = CFrame.FromEulerAnglesYXZ(0.5, 0.3, 0.1)
local x, y, z = cf:ToEulerAnglesYXZ()
print(string.format('YXZ 欧拉角: %.4f, %.4f, %.4f', x, y, z))
```

### ToEulerAngles

签名：`ToEulerAngles(order: Int) -> Float (X轴旋转（弧度）)`

将旋转部分分解为指定顺序的欧拉角，返回弧度值。

⚙ 当前 Meta 将 order 声明为 Int，但没有公开对应的命名枚举。契约补齐前请使用 ToEulerAnglesXYZ() 或 ToEulerAnglesYXZ()，不要用数字或虚构的枚举成员绕过。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `order` | `Int` | 旋转顺序；当前 Meta 未公开对应的命名枚举，契约补齐前请改用固定顺序方法。 |

**返回值** `Float` (X轴旋转（弧度）)

### ToOrientation

签名：`ToOrientation() -> Float (X轴旋转（弧度）)`

将旋转部分分解为朝向角度，等同于 ToEulerAnglesYXZ。

**返回值** `Float` (X轴旋转（弧度）)

> 示例代码

> 提取朝向角

```lua
-- @runtime client
local cf = CFrame.LookAt(Vector3.New(0,0,0), Vector3.New(1,0,0))
local x, y, z = cf:ToOrientation()
print(string.format('朝向角: %.4f, %.4f, %.4f', x, y, z))
```

### ToAxisAngle

签名：`ToAxisAngle() -> Vector3 (旋转轴)`

将 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的旋转部分分解为旋转轴和旋转角度。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) (旋转轴)

> 示例代码

> 提取 CFrame 的轴角表示

```lua
-- @runtime client
local cf = CFrame.FromEulerAnglesXYZ(0, 1.5708, 0)  -- 绕 Y 轴 90 度
local axis, angle = cf:ToAxisAngle()
print(string.format('旋转轴: %s, 角度(弧度): %.4f', tostring(axis), angle))
```

### AngleBetween

签名：`AngleBetween(other: CFrame) -> Float`

计算两个 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 旋转部分之间的夹角，返回弧度值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | 用于比较的另一个 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) |

**返回值** `Float`

> 示例代码

> 计算两个 CFrame 旋转部分之间的夹角

```lua
-- @runtime client
-- 构造两个朝向不同的 CFrame
local cf1 = CFrame.FromEulerAnglesXYZ(0, 0, 0)
local cf2 = CFrame.FromEulerAnglesXYZ(0, math.pi / 2, 0)
-- 计算夹角（弧度）
local angle = cf1:AngleBetween(cf2)
print("旋转夹角（弧度）:", angle)
print("旋转夹角（度）:", math.deg(angle))
```

### GetComponents

签名：`GetComponents() -> Float (位置 X)`

获取 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的全部 12 个分量，依次为位置 X, Y, Z 和旋转矩阵的 9 个元素（行优先）。

**返回值** `Float` (位置 X)

> 示例代码

> 分解 CFrame 的位置与旋转分量

```lua
-- @runtime client
-- 构造一个带平移和旋转的 CFrame
local cf = CFrame.New(10, 5, 0) * CFrame.FromEulerAnglesXYZ(0, 1.57, 0)
-- GetComponents 返回位置 x/y/z 与 3x3 旋转矩阵的 9 个分量
local x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22 = cf:GetComponents()
print(string.format('位置: %.2f, %.2f, %.2f', x, y, z))
print(string.format('第一行旋转矩阵: %.3f, %.3f, %.3f', r00, r01, r02))
```

### New

签名：`New(pos: Vector3, lookAt: Vector3, x: Float, y: Float, z: Float, qX: Float, qY: Float, qZ: Float, qW: Float, R00: Float, R01: Float, R02: Float, R10: Float, R11: Float, R12: Float, R20: Float, R21: Float, R22: Float) -> CFrame (构造得到的 CFrame。)`

用于构造新的 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)（坐标框架）对象，表示三维空间中的位置与旋转。New 方法提供多种重载形式，可根据位置与朝向点、位置与四元数、位置坐标或旋转矩阵分量等方式创建 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `pos` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `lookAt` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `x` | `Float` | - |
| `y` | `Float` | - |
| `z` | `Float` | - |
| `qX` | `Float` | - |
| `qY` | `Float` | - |
| `qZ` | `Float` | - |
| `qW` | `Float` | - |
| `R00` | `Float` | - |
| `R01` | `Float` | - |
| `R02` | `Float` | - |
| `R10` | `Float` | - |
| `R11` | `Float` | - |
| `R12` | `Float` | - |
| `R20` | `Float` | - |
| `R21` | `Float` | - |
| `R22` | `Float` | - |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) (构造得到的 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)。)

> 示例代码

> 基础构造与属性读取

```lua
-- @runtime client
-- 使用三维坐标构造一个仅表示位置的 CFrame
local posOnly = CFrame.New(10, 20, 30)

-- 读取位置分量，验证构造结果
print("位置:", posOnly.Position.x, posOnly.Position.y, posOnly.Position.z)
print("X/Y/Z:", posOnly.X, posOnly.Y, posOnly.Z)

-- 通过位置向量 + 目标点构造一个“看向目标”的 CFrame
local from = Vector3.New(0, 0, 0)
local to = Vector3.New(10, 0, 0)
local lookAtCf = CFrame.New(from, to)

-- 输出朝向向量，确认 CFrame 已指向目标方向
print("朝向:", lookAtCf.LookVector.x, lookAtCf.LookVector.y, lookAtCf.LookVector.z)
```

### Identity

签名：`Identity() -> CFrame`

返回单位 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)，位置在原点且无旋转。

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 创建单位 CFrame（原点无旋转）

```lua
-- @runtime client
-- 获取单位 CFrame
local identity = CFrame.Identity()
print("单位 CFrame 位置:", identity.Position)
print("单位 CFrame 旋转:", identity.Rotation)
```

### FromMatrix

签名：`FromMatrix(pos: Vector3, vX: Vector3, vY: Vector3, vZ: Vector3) -> CFrame (由位置和基向量构造得到的 CFrame。)`

根据位置和旋转矩阵列向量构造 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)；可传入 pos、vX、vY、vZ，或省略 vZ 由 vX 与 vY 自动推导。

⚙ FromMatrix 当前公开形态是 CFrame.FromMatrix(pos, vX, vY[, vZ])，不是 [Matrix](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix.html) 单参构造；已有 [Matrix](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix.html) 实例不能直接传给 CFrame.FromMatrix。当前运行包实测会触发 userdata 到 [Matrix3x3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix3x3.html) 的隐式转换错误，属于 SDK 实现问题，不是参数数量问题。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `pos` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 新 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的位置。 |
| `vX` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 旋转矩阵的 X 列向量。 |
| `vY` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 旋转矩阵的 Y 列向量。 |
| `vZ` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 旋转矩阵的 Z 列向量；可省略，由 vX 与 vY 推导。 |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) (由位置和基向量构造得到的 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)。)

> 示例代码

> 当前版本使用 LookAlong 替代 FromMatrix

```lua
-- @runtime client
local pos = Vector3.New(0, 3, 0)
local direction = Vector3.New(0, 0, -1)
local up = Vector3.New(0, 1, 0)

-- 当前运行包的 FromMatrix 存在类型转换错误，先用公开的 LookAlong 替代
local cf = CFrame.LookAlong(pos, direction, up)
print("CFrame 位置:", cf.Position)
```

### LookAt

签名：`LookAt(at: Vector3, target: Vector3, up: Vector3) -> CFrame`

构造一个位于 at 点、LookVector 指向 target 点的 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

⚙ LookAt 同时存在实例方法与静态工厂方法：cf:LookAt(target, up) 使用 cf 当前的位置；CFrame.LookAt(at, target, up) 使用显式 at 位置。两者参数数量不同，不要把静态示例写进实例签名。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `at` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 新 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的位置 |
| `target` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 希望朝向的目标点 |
| `up` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 参考上方向，用于消除滚转自由度，默认 (0,1,0) |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 区分实例 LookAt 与静态 LookAt

```lua
-- @runtime client
local up = Vector3.New(0, 1, 0)
local at = Vector3.New(0, 2, 0)
local target = Vector3.New(10, 2, 0)

-- 静态工厂：显式指定起点 at 与朝向目标 target
local staticCf = CFrame.LookAt(at, target, up)

-- 实例方法：保留 base 的当前位置，只调整朝向
local base = CFrame.New(5, 2, 0)
local instanceCf = base:LookAt(target, up)

print(staticCf.Position, instanceCf.Position)
```

### LookAlong

签名：`LookAlong(at: Vector3, dir: Vector3, up: Vector3) -> CFrame`

构造一个位于 at 点、朝向 dir 方向的 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `at` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 新 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) 的位置 |
| `dir` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 希望沿其方向的世界空间向量 |
| `up` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 参考上方向，用于消除滚转自由度，默认 (0,1,0) |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 构造沿指定方向的 CFrame

```lua
-- @runtime client
-- 定义位置、方向和上方向
local at = Vector3.New(0, 0, 0)
local dir = Vector3.New(1, 0, 0)
local up = Vector3.New(0, 1, 0)
-- 使用 LookAlong 构造 CFrame
local cf = CFrame.LookAlong(at, dir, up)
print("构造的 CFrame 位置:", cf.Position)
print("构造的 CFrame 朝向:", cf.LookVector)
```

### FromAxisAngle

签名：`FromAxisAngle(axis: Vector3, angle: Float) -> CFrame`

从旋转轴和角度构造一个 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)，位置为原点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `axis` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 旋转轴的单位向量 |
| `angle` | `Float` | 绕轴旋转的角度，单位为弧度 |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 从旋转轴和角度构造 CFrame

```lua
-- @runtime client
-- 定义旋转轴（Y轴）和旋转角度（90度）
local axis = Vector3.New(0, 1, 0)
local angle = math.pi / 2
-- 使用 FromAxisAngle 构造 CFrame
local cf = CFrame.FromAxisAngle(axis, angle)
print("构造的 CFrame 旋转:", cf.Rotation)
```

### FromEulerAnglesXYZ

签名：`FromEulerAnglesXYZ(rx: Float, ry: Float, rz: Float) -> CFrame`

从外部 XYZ 顺序的欧拉角构造一个 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)，位置为原点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `rx` | `Float` | 绕 X 轴旋转的角度，单位为弧度 |
| `ry` | `Float` | 绕 Y 轴旋转的角度，单位为弧度 |
| `rz` | `Float` | 绕 Z 轴旋转的角度，单位为弧度 |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 从 XYZ 欧拉角构造 CFrame

```lua
-- @runtime client
-- 定义 XYZ 欧拉角（弧度）
local rx, ry, rz = 0.1, 0.2, 0.3
-- 使用 FromEulerAnglesXYZ 构造 CFrame
local cf = CFrame.FromEulerAnglesXYZ(rx, ry, rz)
print("构造的 CFrame 旋转:", cf.Rotation)
```

### FromEulerAnglesYXZ

签名：`FromEulerAnglesYXZ(rx: Float, ry: Float, rz: Float) -> CFrame`

从外部 YXZ 顺序的欧拉角构造一个 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)，位置为原点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `rx` | `Float` | 绕 X 轴旋转的角度，单位为弧度 |
| `ry` | `Float` | 绕 Y 轴旋转的角度，单位为弧度 |
| `rz` | `Float` | 绕 Z 轴旋转的角度，单位为弧度 |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 从 YXZ 欧拉角构造 CFrame

```lua
-- @runtime client
-- 定义 YXZ 欧拉角（弧度）
local rx, ry, rz = 0.1, 0.2, 0.3
-- 使用 FromEulerAnglesYXZ 构造 CFrame
local cf = CFrame.FromEulerAnglesYXZ(rx, ry, rz)
print("构造的 CFrame 旋转:", cf.Rotation)
```

### FromOrientation

签名：`FromOrientation(rx: Float, ry: Float, rz: Float) -> CFrame`

从朝向角度构造一个 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)，位置为原点，等同于 FromEulerAnglesYXZ。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `rx` | `Float` | 绕 X 轴旋转的角度，单位为弧度 |
| `ry` | `Float` | 绕 Y 轴旋转的角度，单位为弧度 |
| `rz` | `Float` | 绕 Z 轴旋转的角度，单位为弧度 |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 从朝向角度构造 CFrame（YXZ 顺序）

```lua
-- @runtime client
-- 定义朝向角度（弧度）
local rx, ry, rz = 0.1, 0.2, 0.3
-- 使用 FromOrientation 构造 CFrame
local cf = CFrame.FromOrientation(rx, ry, rz)
print("构造的 CFrame 旋转:", cf.Rotation)
```

### FromEulerAngles

签名：`FromEulerAngles(rx: Float, ry: Float, rz: Float, order: Int) -> CFrame`

从欧拉角构造一个 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)，位置为原点，可指定旋转顺序。

⚙ 当前 Meta 将 order 声明为 Int，但没有公开对应的命名枚举。契约补齐前请使用 FromEulerAnglesXYZ(...) 或 FromEulerAnglesYXZ(...)，不要用数字或虚构的枚举成员绕过。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `rx` | `Float` | 绕 X 轴旋转的角度，单位为弧度 |
| `ry` | `Float` | 绕 Y 轴旋转的角度，单位为弧度 |
| `rz` | `Float` | 绕 Z 轴旋转的角度，单位为弧度 |
| `order` | `Int` | 旋转顺序；当前 Meta 未公开对应的命名枚举，契约补齐前请改用固定顺序方法。 |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

### FromRotationBetweenVectors

签名：`FromRotationBetweenVectors(from: Vector3, to: Vector3) -> CFrame`

构造一个从 from 向量旋转到 to 向量的最短旋转 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)，位置为原点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `from` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 起始方向向量 |
| `to` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 目标方向向量 |

**返回值** [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)

> 示例代码

> 从两个向量之间的最短旋转构造 CFrame

```lua
-- @runtime client
-- 定义起始方向和目标方向
local fromDir = Vector3.New(1, 0, 0)
local toDir = Vector3.New(0, 1, 0)
-- 使用 FromRotationBetweenVectors 构造旋转 CFrame
local cf = CFrame.FromRotationBetweenVectors(fromDir, toDir)
print("构造的 CFrame 旋转:", cf.Rotation)
```
