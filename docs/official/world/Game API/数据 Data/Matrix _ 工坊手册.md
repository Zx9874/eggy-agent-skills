# Matrix

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

矩阵类型，用于表示三维空间中的平移、旋转和缩放组合变换，并可直接读取右、上、前方向向量以及按 ZXY 顺序解释的俯仰、偏航、翻滚角。支持构造单位矩阵、零矩阵，以及通过欧拉角、轴向旋转或两向量间的旋转生成矩阵，还提供了求逆、转置和对向量应用变换等常用运算。

## 适用场景

在需要将物体的位置、朝向和缩放统一为一个变换对象进行传递或存储时使用，例如构造单位的外观变换或计算方向向量对应的旋转矩阵。

## 使用要点

通过 Matrix.New(平移向量, 旋转四元数, 缩放向量) 或 Matrix.Identity() 获取矩阵实例，随后可读取 Translation、Rotation、Scale 等属性，或调用 Apply 对向量施加变换，调用 Inverse、Transpose 进行矩阵运算。

## 注意事项

[Matrix](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix.html) 实例通过 Matrix.New(translation, rotation, scale)、[Matrix](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix.html)(translation, rotation, scale) 或 Matrix.Identity() 等公开构造/工厂方法获取；Rotation 属性为 [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) 类型，Pitch、Yaw、Roll 按 ZXY 顺序解释。

## 代码示例

### 构造平移、旋转与缩放矩阵

```lua
-- @runtime client
local translation = Vector3.New(10, 20, 30)
local rotation = Quaternion.FromEulerAngles(0, math.rad(90), 0)  -- 绕 Y 轴 90 度
local scale = Vector3.New(1, 2, 1)
local matrix = Matrix.New(translation, rotation, scale)
print('矩阵:', tostring(matrix))
```

## 属性 (9)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Translation` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 矩阵的平移分量，表示局部坐标系原点在世界空间中的位置。 |
| `Rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | `-` | 获取或设置矩阵的旋转分量，以四元数形式表示。 |
| `Scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 矩阵的缩放分量，表示沿各轴的缩放因子。 |
| `Right` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 矩阵的右方向向量，对应局部坐标系的 X 轴方向。 |
| `Up` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 矩阵的上方向向量，对应局部坐标系的 Y 轴方向。 |
| `Forward` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 矩阵的前方向向量，对应局部坐标系的 Z 轴负方向。 |
| `Pitch` | `Float` | `-` | 矩阵在俯仰方向上的旋转角分量，以弧度为单位，遵循 ZXY 旋转顺序。 |
| `Yaw` | `Float` | `-` | 矩阵在偏航方向上的旋转角分量，以弧度为单位，遵循 ZXY 旋转顺序。 |
| `Roll` | `Float` | `-` | 矩阵在翻滚方向上的旋转角分量，以弧度为单位，遵循 ZXY 旋转顺序。 |

## 关联类型

* [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 函数 (14)

### New

签名：`New(translation: Vector3, rotation: Quaternion, scale: Vector3) -> Matrix`

通过平移、旋转和缩放三个分量构造一个 4x4 变换矩阵。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `translation` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | - |
| `scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Matrix](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix.html)

> 示例代码

> 构造平移、旋转与缩放矩阵

```lua
-- @runtime client
local translation = Vector3.New(10, 20, 30)
local rotation = Quaternion.FromEulerAngles(0, math.rad(90), 0)  -- 绕 Y 轴 90 度
local scale = Vector3.New(1, 2, 1)
local matrix = Matrix.New(translation, rotation, scale)
print('矩阵:', tostring(matrix))
```

### Identity

签名：`Identity() -> Matrix`

返回一个单位矩阵，无平移、无旋转、缩放为 1。

**返回值** [Matrix](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix.html)

> 示例代码

> 获取单位矩阵

```lua
-- @runtime client
local m = Matrix.Identity()
print('单位矩阵已创建:', tostring(m))
```

### Zero

签名：`Zero() -> Matrix`

返回一个零矩阵，无平移、无旋转、缩放为 0。

**返回值** [Matrix](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix.html)

> 示例代码

> 调用示例

```lua
-- @runtime client
local result = Matrix.Zero()  -- 返回 Matrix
if result ~= nil then
    print(result)
    local resultText = tostring(result)
    print(resultText)
end
```

### FromEulerAngles

签名：`FromEulerAngles(x: Float, y: Float, z: Float) -> Matrix`

根据欧拉角（弧度，ZXY 顺序）构造仅包含旋转的矩阵，平移为零，缩放为 1。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `x` | `Float` | Pitch（弧度） |
| `y` | `Float` | Yaw（弧度） |
| `z` | `Float` | Roll（弧度） |

**返回值** [Matrix](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix.html)

> 示例代码

> 从欧拉角构造旋转矩阵

```lua
-- @runtime client
-- FromEulerAngles 的参数按 Meta 标注传入弧度：pitch, yaw, roll
local m = Matrix.FromEulerAngles(math.rad(30), math.rad(45), 0)
print('旋转矩阵:', tostring(m))
```

### Inverse

签名：`Inverse() -> Matrix`

原地求逆，将当前矩阵变为其逆矩阵。

**返回值** [Matrix](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix.html)

> 示例代码

> 原地求矩阵的逆

```lua
-- @runtime client
local matrix = Matrix.New(
    Vector3.New(5, 0, 0),
    Quaternion.FromEulerAngles(0, 0, math.rad(60)),
    Vector3.New(2, 2, 2)
)
matrix:Inverse()
print('逆矩阵:', tostring(matrix))
```

### GetInverse

签名：`GetInverse() -> Matrix`

返回当前矩阵的逆矩阵副本，不修改原矩阵。

**返回值** [Matrix](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix.html)

> 示例代码

> 获取逆矩阵副本

```lua
-- @runtime client
local matrix = Matrix.New(
    Vector3.New(10, 0, 0),
    Quaternion.FromEulerAngles(0, math.rad(45), 0),
    Vector3.New(1, 1, 1)
)
local inverse = matrix:GetInverse()
print('逆矩阵副本:', tostring(inverse))
```

### Transpose

签名：`Transpose() -> Matrix`

返回当前矩阵的转置矩阵。

**返回值** [Matrix](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Matrix.html)

> 示例代码

> 转置矩阵

```lua
-- @runtime client
local matrix = Matrix.New(
    Vector3.New(0, 0, 0),
    Quaternion.FromEulerAngles(math.rad(45), 0, 0),
    Vector3.New(1, 1, 1)
)
local transposed = matrix:Transpose()
print('转置矩阵:', tostring(transposed))
```

### Apply

签名：`Apply(v: Vector3) -> Vector3`

对传入的向量应用矩阵变换，返回变换后的向量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `v` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

> 示例代码

> 将矩阵变换应用到向量

```lua
-- @runtime client
local matrix = Matrix.New(
    Vector3.New(5, 0, 0),
    Quaternion.FromEulerAngles(0, math.rad(90), 0),
    Vector3.New(1, 1, 1)
)
local transformed = matrix:Apply(Vector3.New(1, 0, 0))
print('变换结果:', tostring(transformed))
```

### MakeOrient

签名：`MakeOrient(forward: Vector3, up: Vector3) -> void`

将当前矩阵原地构造为朝向旋转矩阵，基于给定的前方向和上方向。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `forward` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `up` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** `void`

> 示例代码

> 构造朝向矩阵

```lua
-- @runtime client
local m = Matrix.Identity()  -- 先取得可修改的矩阵实例
m:MakeOrient(Vector3.New(1,0,0), Vector3.New(0,1,0))  -- 原地修改为朝向旋转
print('朝向矩阵:', tostring(m))
```

### MakeRotationX

签名：`MakeRotationX(angle: Float) -> void`

将当前矩阵原地构造为绕 X 轴旋转指定角度的旋转矩阵。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `angle` | `Float` | - |

**返回值** `void`

> 示例代码

> 构造绕 X 轴的旋转矩阵

```lua
-- @runtime client
local m = Matrix.Identity()  -- 先取得可修改的矩阵实例
m:MakeRotationX(1.5708)  -- 原地修改为绕 X 轴 90 度
print('X 轴旋转矩阵:', tostring(m))
```

### MakeRotationY

签名：`MakeRotationY(angle: Float) -> void`

将当前矩阵原地构造为绕 Y 轴旋转指定角度的旋转矩阵。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `angle` | `Float` | - |

**返回值** `void`

> 示例代码

> 构造绕 Y 轴的旋转矩阵

```lua
-- @runtime client
local m = Matrix.Identity()  -- 先取得可修改的矩阵实例
m:MakeRotationY(1.5708)  -- 原地修改为绕 Y 轴 90 度
print('Y 轴旋转矩阵:', tostring(m))
```

### MakeRotationZ

签名：`MakeRotationZ(angle: Float) -> void`

将当前矩阵原地构造为绕 Z 轴旋转指定角度的旋转矩阵。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `angle` | `Float` | - |

**返回值** `void`

> 示例代码

> 构造绕 Z 轴的旋转矩阵

```lua
-- @runtime client
local m = Matrix.Identity()  -- 先取得可修改的矩阵实例
m:MakeRotationZ(1.5708)  -- 原地修改为绕 Z 轴 90 度
print('Z 轴旋转矩阵:', tostring(m))
```

### MakeRotation

签名：`MakeRotation(axis: Vector3, angle: Float) -> void`

将当前矩阵原地构造为绕指定轴旋转指定角度的旋转矩阵。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `axis` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `angle` | `Float` | - |

**返回值** `void`

> 示例代码

> 构造绕指定轴的旋转矩阵

```lua
-- @runtime client
local m = Matrix.Identity()  -- 先取得可修改的矩阵实例
m:MakeRotation(Vector3.New(0, 1, 0), 1.5708)  -- 原地修改为绕 Y 轴 90 度
print('旋转矩阵:', tostring(m))
```

### MakeRotationBetween

签名：`MakeRotationBetween(from: Vector3, to: Vector3) -> void`

将当前矩阵原地构造为从 from 方向旋转到 to 方向的旋转矩阵。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `from` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |
| `to` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | - |

**返回值** `void`

> 示例代码

> 构造从一向量旋转到另一向量的矩阵

```lua
-- @runtime client
local m = Matrix.Identity()  -- 先取得可修改的矩阵实例
m:MakeRotationBetween(Vector3.New(1,0,0), Vector3.New(0,1,0))  -- 原地修改
print('从 X 轴到 Y 轴的旋转矩阵:', tostring(m))
```
