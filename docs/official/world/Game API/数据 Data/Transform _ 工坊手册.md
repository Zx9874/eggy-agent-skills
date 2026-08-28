# Transform

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

Transform 是描述三维空间位姿的变换数据，将位移（Translation，别名 Position）、以四元数表示的旋转（Rotation）与缩放（Scale）封装为一体，并可直接读取前向、上、右三个方向向量。它提供世界空间与对象空间之间的点与方向换算、变换叠加、插值、求逆、与矩阵互转，以及通过欧拉角或轴角构造变换的能力。

## 适用场景

在需要把局部坐标换算到世界坐标或反向换算的场景中，例如计算单位身上某个挂点在世界空间的位置、沿自身朝向平移或投射方向时使用。可先构造基础变换，再通过 PointToWorldSpace、VectorToWorldSpace 完成换算，或通过 LookAt、FromAxisAngle 快速生成朝向。

## 使用要点

先用 Transform.New(位移, 旋转, 缩放) 或简写 Transform(...) 创建变换实例，单位变换可调用 Transform.Identity()；需要特定朝向时可使用 FromEulerAngles 或 LookAt 构造。随后可调用 PointToWorldSpace 换算点、VectorToWorldSpace 换算方向，并可用 ToWorldSpace、ToObjectSpace 处理父子级联，或通过 Lerp、GetInverse 做过渡和求逆。

## 注意事项

Transform 实例通过 Transform.New(...) 或 Transform(...) 构造，用于组合位移、旋转与缩放。PointToWorldSpace 用于点变换，会应用位移；VectorToWorldSpace 用于方向变换，会忽略位移。Quaternion.FromEulerAngles 的参数按弧度传入；按角度思考时可使用 math.rad(...) 转换。

## 代码示例

### 构造非退化 Transform 并变换点

```lua
-- @runtime client
local transform = Transform.New(
    Vector3.New(10, 5, 0),
    Quaternion.FromEulerAngles(0, math.rad(45), 0),
    Vector3.New(1, 1, 1)
)
local worldPoint = transform:PointToWorldSpace(Vector3.New(1, 0, 0))
print('世界坐标:', worldPoint)
```

## 属性 (7)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Translation` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 获取或设置 Transform 的平移部分。 |
| `Position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 获取或设置 Transform 的平移部分，与 Translation 属性相同。 |
| `Rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | `-` | 当前 Transform 的旋转分量，以 [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) 表示。 |
| `Scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 获取或设置 Transform 的缩放部分。 |
| `LookVector` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 获取 Transform 的前向方向向量，即局部 -Z 轴在世界空间中的方向。 |
| `UpVector` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 获取 Transform 的上方向向量，即局部 Y 轴在世界空间中的方向。 |
| `RightVector` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 获取 Transform 的右方向向量，即局部 X 轴在世界空间中的方向。 |

## 关联类型

* [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 函数 (27)

### New

签名：`New(translation: Vector3, rotation: Quaternion, scale?: Vector3) -> Transform`

创建一个新的 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 实例，用于表示空间中的位置、旋转和缩放。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `translation` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | - |
| `scale?` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 缩放（默认 (1,1,1)） |

**返回值** [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)

> 示例代码

> 构造 Transform（位置+旋转+缩放）

```lua
-- @runtime client
local t = Transform.New(
    Vector3.New(10, 5, 0),       -- 位置
    Quaternion.FromAxisAngle(Vector3.New(0,1,0), 1.5708),  -- 旋转
    Vector3.New(1, 1, 1)         -- 缩放
)
print('Transform 已创建:', tostring(t))
```

### Identity

签名：`Identity() -> Transform`

返回一个单位 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)，即无平移、无旋转、缩放为 (1,1,1) 的变换。

**返回值** [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)

> 示例代码

> 获取单位 Transform

```lua
-- @runtime client
local t = Transform.Identity()
print('单位 Transform:', tostring(t))
```

### FromMatrix

签名：`FromMatrix(matrix: Matrix) -> Transform`

从给定的 4x4 矩阵创建一个 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 对象。矩阵中通常包含平移、旋转和缩放信息，该函数会将其转换为对应的 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 表示。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `matrix` | [Matrix](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix.html) | - |

**返回值** [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)

> 示例代码

> 从矩阵构造 Transform

```lua
-- @runtime client
local m = Matrix.Identity()
local t = Transform.FromMatrix(m)
print('从矩阵构造的 Transform:', tostring(t))
```

### InterpolateTransforms

签名：`InterpolateTransforms(a: Transform, b: Transform, t: Float) -> Transform`

在两个 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 之间进行插值，根据参数 t 返回中间变换。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `a` | [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) | - |
| `b` | [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) | - |
| `t` | `Float` | 插值因子 [0, 1] |

**返回值** [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)

> 示例代码

> 在两个 Transform 之间插值

```lua
-- @runtime client
local startTransform = Transform.Identity()
local endTransform = Transform.New(
    Vector3.New(10, 0, 0),
    Quaternion.FromEulerAngles(0, math.rad(90), 0),
    Vector3.New(2, 2, 2)
)
local halfway = Transform.InterpolateTransforms(startTransform, endTransform, 0.5)
print('中间位置:', halfway.Position)
```

### GetPosition

签名：`GetPosition() -> Vector3`

获取当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 的平移部分，以 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 形式返回。

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 读取 Transform 的位置

```lua
-- @runtime client
local transform = Transform.New(Vector3.New(10, 5, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
print('位置:', transform:GetPosition())
```

### SetPosition

签名：`SetPosition(pos: Vector3) -> void`

设置当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 的平移部分。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `pos` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** `void`

> 示例代码

> 设置 Transform 的位置

```lua
-- @runtime client
local transform = Transform.Identity()
transform:SetPosition(Vector3.New(10, 5, 0))
print('新位置:', transform:GetPosition())
```

### GetOrientation

签名：`GetOrientation() -> Quaternion`

返回当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 的旋转分量，以 [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) 表示。

**返回值** [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)

> 示例代码

> 读取 Transform 的旋转

```lua
-- @runtime client
local rot = Quaternion.FromEulerAngles(math.rad(45), 0, 0)
local t = Transform(Vector3(0, 0, 0), rot, Vector3(1, 1, 1))
local q = t:GetOrientation()
print("旋转四元数:", q.x, q.y, q.z, q.w)
```

### SetOrientation

签名：`SetOrientation(quat: Quaternion) -> void`

设置当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 的旋转分量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `quat` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | - |

**返回值** `void`

> 示例代码

> 设置 Transform 的旋转

```lua
-- @runtime client
local t = Transform(Vector3(0, 0, 0), Quaternion.Identity(), Vector3(1, 1, 1))
local rot = Quaternion.FromEulerAngles(0, math.rad(90), 0)
t:SetOrientation(rot)
print("旋转已更新")
```

### SetToIdentity

签名：`SetToIdentity() -> void`

将当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 重置为单位 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)。

**返回值** `void`

> 示例代码

> 重置为单位 Transform

```lua
-- @runtime client
local t = Transform(
    Vector3.New(10, 5, 0),
    Quaternion.FromEulerAngles(0, math.rad(45), 0),
    Vector3.New(2, 2, 2)
)
t:SetToIdentity()
print('重置后位置和缩放:', t.Position, t.Scale)
```

### GetInverse

签名：`GetInverse() -> Transform`

返回当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 的逆变换。

**返回值** [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)

> 示例代码

> 获取逆 Transform 副本

```lua
-- @runtime client
local transform = Transform.New(Vector3.New(10, 0, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
local inverse = transform:GetInverse()
print('逆变换位置:', inverse.Position)
```

### Inverse

签名：`Inverse() -> Transform`

返回当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 的逆变换，与 GetInverse 功能相同。

**返回值** [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)

> 示例代码

> 返回当前 Transform 的逆变换

```lua
-- @runtime client
local t = Transform(Vector3.New(10, 0, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
local inverse = t:Inverse()
local origin = inverse:Apply(t.Position)
print('逆变换后的原位置:', origin)
```

### IsValid

签名：`IsValid() -> Bool`

检查 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 的位移、旋转和缩放分量是否构成有效变换，例如不包含 NaN 或无穷值且旋转有效。

**返回值** `Bool`

> 示例代码

> 检查 Transform 是否有效

```lua
-- @runtime client
local transform = Transform.Identity()
print('单位 Transform 是否有效:', transform:IsValid())
```

### Transform

签名：`Transform(other: Transform) -> Transform`

将当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 与另一个 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 组合，返回 self \* other（先应用 other，再应用 self）。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) | - |

**返回值** [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)

> 示例代码

> 组合两个 Transform

```lua
-- @runtime client
local base = Transform.New(Vector3.New(10, 0, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
local offset = Transform.New(Vector3.New(0, 2, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
local combined = base:Transform(offset)
print('组合后位置:', combined.Position)
```

### Apply

签名：`Apply(point: Vector3) -> Vector3`

对给定的点应用当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)，包括平移、旋转和缩放。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `point` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 将 Transform 应用到点

```lua
-- @runtime client
local transform = Transform.New(Vector3.New(10, 0, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
local worldPoint = transform:Apply(Vector3.New(1, 2, 3))
print('世界坐标:', worldPoint)
```

### ApplyDirection

签名：`ApplyDirection(dir: Vector3) -> Vector3`

对给定的方向向量应用当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 的旋转和缩放，忽略平移。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `dir` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 对方向应用 Transform

```lua
-- @runtime client
local rot = Quaternion.FromEulerAngles(0, math.rad(90), 0)
local t = Transform(Vector3(5, 0, 0), rot, Vector3(1, 1, 1))
local localDir = Vector3(1, 0, 0)
local worldDir = t:ApplyDirection(localDir)
print("世界方向:", worldDir.x, worldDir.y, worldDir.z)
```

### ToMatrix

签名：`ToMatrix() -> Matrix`

将当前的 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 对象转换并返回为 4x4 矩阵表示。

**返回值** [Matrix](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix.html)

> 示例代码

> 转换为 Matrix

```lua
-- @runtime client
local transform = Transform.New(Vector3.New(10, 0, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
local matrix = transform:ToMatrix()
print('矩阵平移:', matrix.Translation)
```

### Lerp

签名：`Lerp(goal: Transform, alpha: Float) -> Transform`

对当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 和目标 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 进行线性插值，返回中间变换。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `goal` | [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) | - |
| `alpha` | `Float` | - |

**返回值** [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)

> 示例代码

> 插值到目标 Transform

```lua
-- @runtime client
local startTransform = Transform.Identity()
local goal = Transform.New(Vector3.New(10, 0, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
local halfway = startTransform:Lerp(goal, 0.5)
print('中间位置:', halfway.Position)
```

### ToWorldSpace

签名：`ToWorldSpace(cf: Transform) -> Transform`

将本地空间中的 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 转换到世界空间。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `cf` | [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) | - |

**返回值** [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)

> 示例代码

> 将局部 Transform 转到世界空间

```lua
-- @runtime client
local parent = Transform.New(Vector3.New(10, 0, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
local localTransform = Transform.New(Vector3.New(0, 2, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
local worldTransform = parent:ToWorldSpace(localTransform)
print('世界位置:', worldTransform.Position)
```

### ToObjectSpace

签名：`ToObjectSpace(cf: Transform) -> Transform`

将世界空间中的 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 转换到当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 的本地空间。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `cf` | [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) | - |

**返回值** [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)

> 示例代码

> 将世界 Transform 转到局部空间

```lua
-- @runtime client
local parent = Transform.New(Vector3.New(10, 0, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
local worldTransform = Transform.New(Vector3.New(10, 2, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
local localTransform = parent:ToObjectSpace(worldTransform)
print('局部位置:', localTransform.Position)
```

### PointToWorldSpace

签名：`PointToWorldSpace(v: Vector3) -> Vector3`

将本地空间中的点转换到世界空间。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `v` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 将局部点转到世界空间

```lua
-- @runtime client
local transform = Transform.New(Vector3.New(10, 0, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
print('世界坐标:', transform:PointToWorldSpace(Vector3.New(1, 2, 3)))
```

### PointToObjectSpace

签名：`PointToObjectSpace(v: Vector3) -> Vector3`

将世界空间中的点转换到当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 的本地空间。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `v` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 将世界点转到局部空间

```lua
-- @runtime client
local transform = Transform.New(Vector3.New(10, 0, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
print('局部坐标:', transform:PointToObjectSpace(Vector3.New(11, 2, 3)))
```

### VectorToWorldSpace

签名：`VectorToWorldSpace(v: Vector3) -> Vector3`

将本地空间中的方向向量转换到世界空间，忽略平移。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `v` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 本地方向转世界方向

```lua
-- @runtime client
local rot = Quaternion.FromEulerAngles(0, math.rad(90), 0)
local t = Transform(Vector3(0, 0, 0), rot, Vector3(1, 1, 1))
local localDir = Vector3(1, 0, 0)
local worldDir = t:VectorToWorldSpace(localDir)
print("世界方向:", worldDir.x, worldDir.y, worldDir.z)
```

### VectorToObjectSpace

签名：`VectorToObjectSpace(v: Vector3) -> Vector3`

将世界空间中的方向向量转换到当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 的本地空间，忽略平移。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `v` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 世界方向转本地方向

```lua
-- @runtime client
local rot = Quaternion.FromEulerAngles(0, math.rad(90), 0)
local t = Transform(Vector3(0, 0, 0), rot, Vector3(1, 1, 1))
local worldDir = Vector3(0, 0, -1)
local localDir = t:VectorToObjectSpace(worldDir)
print("本地方向:", localDir.x, localDir.y, localDir.z)
```

### FuzzyEq

签名：`FuzzyEq(other: Transform, epsilon: Float) -> Bool`

判断当前 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 与另一个 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) 是否在给定误差范围内近似相等。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html) | - |
| `epsilon` | `Float` | - |

**返回值** `Bool`

> 示例代码

> 用容差比较 Transform

```lua
-- @runtime client
local first = Transform.Identity()
local second = Transform.New(Vector3.New(0.0001, 0, 0), Quaternion.Identity(), Vector3.New(1, 1, 1))
print('近似相等:', first:FuzzyEq(second, 0.001))
```

### FromEulerAngles

签名：`FromEulerAngles(rx: Float, ry: Float, rz: Float) -> Transform`

根据欧拉角（ZXY 旋转顺序）创建一个纯旋转的 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)，平移为 (0,0,0)，缩放为 (1,1,1)。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `rx` | `Float` | - |
| `ry` | `Float` | - |
| `rz` | `Float` | - |

**返回值** [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)

> 示例代码

> 从欧拉角构造旋转部分

```lua
-- @runtime client
local t = Transform.FromEulerAngles(0.5, 0.3, 0.1)
print('欧拉角 Transform:', tostring(t))
```

### FromAxisAngle

签名：`FromAxisAngle(axis: Vector3, angle: Float) -> Transform`

根据给定的轴和角度创建一个纯旋转的 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)，平移为 (0,0,0)，缩放为 (1,1,1)。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `axis` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `angle` | `Float` | - |

**返回值** [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)

> 示例代码

> 从轴角构造旋转部分

```lua
-- @runtime client
local t = Transform.FromAxisAngle(Vector3.New(0,1,0), 1.5708)
print('轴角 Transform:', tostring(t))
```

### LookAt

签名：`LookAt(at: Vector3, lookAt: Vector3, up: Vector3) -> Transform`

构造一个位于 at 点、朝向 lookAt 点的 [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)，上方向由 up 向量指定。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `at` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `lookAt` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `up` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Transform](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Transform.html)

> 示例代码

> 构造朝向目标点的 Transform

```lua
-- @runtime client
local at = Vector3.New(0, 2, 0)
local target = Vector3.New(10, 2, 0)
local up = Vector3.New(0, 1, 0)
local transform = Transform.LookAt(at, target, up)
print('位置:', transform.Position, '前向:', transform.LookVector)
```
