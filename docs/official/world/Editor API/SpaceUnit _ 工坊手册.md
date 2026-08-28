# SpaceUnit

继承 Unit，具有位置/旋转/缩放的空间单位。通过 World 服务返回的 SpaceUnit 对象访问。

## 概览

继承 Unit，具有位置/旋转/缩放的空间单位。通过 World 服务返回的 SpaceUnit 对象访问。

> 继承自 `Unit`；不可实例化，由接口返回

## 函数

### GetPosition

签名：`GetPosition() -> Array`

获取世界坐标。

**返回值** `Array` — 单位的世界坐标

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldPos = unit:GetPosition() -- 记录原坐标
print("before pos:", oldPos)

unit:SetPosition(Vector3.New(0, 0, 10)) -- 设置新坐标
print("after pos:", unit:GetPosition())

unit:SetPosition(oldPos) -- 恢复原位
print("restored pos:", unit:GetPosition())
```

### SetPosition

签名：`SetPosition(position: Vector3)`

设置世界坐标（支持撤销/重做）。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `position` | `Vector3` | 世界坐标 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldPos = unit:GetPosition() -- 记录原坐标
print("before:", oldPos)

unit:SetPosition(Vector3.New(0, 0, 10)) -- 设置位置
print("after:", unit:GetPosition())

unit:SetPosition(oldPos) -- 恢复原位
print("restored:", unit:GetPosition())
```

### GetRotation

签名：`GetRotation() -> Quaternion`

获取旋转。

**返回值** `Quaternion` — 单位的旋转四元数

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldRot = unit:GetRotation() -- 记录原旋转
print("before rot:", oldRot)

unit:SetRotation(Quaternion.New(0, 0, 1, 0)) -- 设置新旋转
print("after rot:", unit:GetRotation())

unit:SetRotation(oldRot) -- 恢复原旋转
print("restored rot:", unit:GetRotation())
```

### SetRotation

签名：`SetRotation(rotation: Quaternion)`

设置旋转（支持撤销/重做）。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `rotation` | `Quaternion` | 旋转四元数 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldRot = unit:GetRotation() -- 记录原旋转
print("before rot:", oldRot)

unit:SetRotation(Quaternion.New(0, 0, 1, 0)) -- 设置旋转
print("after rot:", unit:GetRotation())

unit:SetRotation(oldRot) -- 恢复原旋转
print("restored rot:", unit:GetRotation())
```

### GetScale

签名：`GetScale() -> Array`

获取缩放。

**返回值** `Array` — 单位的缩放

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldScale = unit:GetScale() -- 记录原缩放
print("before scale:", oldScale)

unit:SetScale(Vector3.New(2, 2, 2)) -- 放大 2 倍
print("after scale:", unit:GetScale())

unit:SetScale(oldScale) -- 恢复原缩放
print("restored scale:", unit:GetScale())
```

### SetScale

签名：`SetScale(scale: Vector3)`

设置缩放（支持撤销/重做）。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `scale` | `Vector3` | 缩放 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldScale = unit:GetScale() -- 记录原缩放
print("before scale:", oldScale)

unit:SetScale(Vector3.New(2, 2, 2)) -- 设置缩放
print("after scale:", unit:GetScale())

unit:SetScale(oldScale) -- 恢复原缩放
print("restored scale:", unit:GetScale())
```

### GetProperty

签名：`GetProperty(propName: String) -> Any`

读取任意内置属性。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `propName` | `String` | 属性名（如 "Name" / "BodyType" / "SkinId" / "physic\_enable"） |

**返回值** `Any` — 属性值；属性不存在时返回 nil

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldBodyType = unit:GetProperty("BodyType") -- 记录原值
print("before BodyType:", oldBodyType)

unit:SetProperty("BodyType", 1) -- 设置新值
print("after BodyType:", unit:GetProperty("BodyType"))

unit:SetProperty("BodyType", oldBodyType) -- 恢复原值
print("restored BodyType:", unit:GetProperty("BodyType"))
```

### SetProperty

签名：`SetProperty(propName: String, value: Any)`

设置任意内置属性（支持撤销/重做）。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `propName` | `String` | 属性名（如 "Name" / "BodyType"） |
| `value` | `Any` | 属性值（枚举属性传对应数字，如 BodyType：0=Static / 1=Kinematic / 2=Dynamic） |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldBodyType = unit:GetProperty("BodyType") -- 记录原值
print("before BodyType:", oldBodyType)

unit:SetProperty("BodyType", 2) -- 设置属性值
print("after BodyType:", unit:GetProperty("BodyType"))

unit:SetProperty("BodyType", oldBodyType) -- 恢复原值
print("restored BodyType:", unit:GetProperty("BodyType"))
```

### SetTRS

签名：`SetTRS(position: Vector3, rotation: Quaternion, scale: Vector3)`

设置完整变换（位置、旋转、缩放一次提交，支持撤销/重做）。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `position` | `Vector3` | 世界坐标 |
| `rotation` | `Quaternion` | 旋转四元数 |
| `scale` | `Vector3` | 缩放 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldPos = unit:GetPosition() -- 记录原位置
local oldRot = unit:GetRotation() -- 记录原旋转
local oldScale = unit:GetScale() -- 记录原缩放
print("before pos:", oldPos, "rot:", oldRot, "scale:", oldScale)

unit:SetTRS(Vector3.New(0, 0, 10), Quaternion.New(0, 0, 1, 0), Vector3.New(2, 2, 2)) -- 提交变换
print("after pos:", unit:GetPosition(), "rot:", unit:GetRotation(), "scale:", unit:GetScale())

unit:SetTRS(oldPos, oldRot, oldScale) -- 恢复原变换
print("restored pos:", unit:GetPosition(), "rot:", unit:GetRotation(), "scale:", unit:GetScale())
```
