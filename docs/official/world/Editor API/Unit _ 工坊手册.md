# Unit

Unit 对象 API 参考。Unit 对象由 World 方法返回（FindFirstChild、GetDescendants、CreateAsset 等）。

## Overview

Unit 是所有单位的抽象基类，提供通用的单位属性与方法（类型判断、父子关系、场景树查询等）。Unit 不可直接创建，请使用具体子类（如 WorldUnit、PhysicsUnit、RenderUnit）创建单位，或通过 World 服务获取单位对象。属性（Property）为单位的内置同步属性，自定义属性（Attribute）为单位预设中定义的键值。

## Methods

### Destroy

销毁本单位及所有子单位。

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

print("destroying:", unit:GetName())
unit:Destroy() -- 销毁单位
print("Destroy() called")

local gone = world:FindFirstChild("MyUnit")
print("after destroy, FindFirstChild result:", gone)
if gone == nil then
    print("验证通过：MyUnit 已从场景删除")
end
```

## Public

### GetProperty

读取内置属性。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 单位内置属性名 |
| `default` | `Any` | 属性不存在时返回的默认值 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Any` | 属性值；属性不存在时返回 nil |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldBodyType = unit:GetProperty("BodyType") -- 读取内置属性
print("before BodyType:", oldBodyType)

unit:SetProperty("BodyType", 1)
print("after BodyType:", unit:GetProperty("BodyType"))

unit:SetProperty("BodyType", oldBodyType) -- 恢复原值
print("restored BodyType:", unit:GetProperty("BodyType"))
```

### SetProperty

修改内置属性。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 单位内置属性名 |
| `value` | `Any` | 属性值 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldBodyType = unit:GetProperty("BodyType") -- 记录原属性值
print("before BodyType:", oldBodyType)

unit:SetProperty("BodyType", 2) -- 修改内置属性
print("after BodyType:", unit:GetProperty("BodyType"))

unit:SetProperty("BodyType", oldBodyType) -- 恢复原值
print("restored BodyType:", unit:GetProperty("BodyType"))
```

### GetUnitType

获取单位类型。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `String` | 单位类型 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local unitType = unit:GetUnitType() -- 读取单位类型
print("unit type:", unitType)

if unit:IsA("SpaceUnit") then
    print("是 SpaceUnit，可直接调用 GetPosition 等空间方法，pos:", unit:GetPosition())
else
    print("不是 SpaceUnit，仅可用 Unit 基础方法")
end
```

### GetName

获取单位名称。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `String` | 单位名称 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldName = unit:GetName() -- 读取单位名称
print("before name:", oldName)

unit:SetName("TempName")
print("after rename:", unit:GetName())

unit:SetName(oldName) -- 恢复原名
print("restored name:", unit:GetName())
```

### SetName

设置单位名称。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 新的单位名称 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldName = unit:GetName() -- 记录原名
print("before name:", oldName)

unit:SetName("NewName") -- 设置新名称
print("after name:", unit:GetName())

unit:SetName(oldName) -- 恢复原名
print("restored name:", unit:GetName())
```

### IsA

判断单位类型。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `className` | `String` | 要判断的类型名称 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否属于指定类型 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

print("is Unit:", unit:IsA("Unit"))
local isSpace = unit:IsA("SpaceUnit") -- 判断是否空间单位
print("is SpaceUnit:", isSpace)

if isSpace then
    print("按 SpaceUnit 处理，pos:", unit:GetPosition(), "scale:", unit:GetScale())
else
    print("按 Unit 处理，仅可使用基础方法")
end
```

### SetPhysicsEnabled

设置物理碰撞开关。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `enabled` | `Bool` | 是否开启物理碰撞 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

unit:SetPhysicsEnabled(false) -- 关闭物理碰撞
print("SetPhysicsEnabled(false) called")
print("physic_enable after:", unit:GetProperty("physic_enable"))

unit:SetPhysicsEnabled(true) -- 恢复物理碰撞
print("physic_enable after restore:", unit:GetProperty("physic_enable"))
```

### GetLocked

获取锁定状态。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否处于锁定状态 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldLocked = unit:GetLocked() -- 读取锁定状态
print("before locked:", oldLocked)

unit:SetLocked(not oldLocked)
print("after locked:", unit:GetLocked())

unit:SetLocked(oldLocked) -- 恢复原状态
print("restored locked:", unit:GetLocked())
```

### SetLocked

设置锁定。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `locked` | `Bool` | 是否锁定 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldLocked = unit:GetLocked() -- 记录原锁定状态
print("before locked:", oldLocked)

unit:SetLocked(true) -- 设置锁定
print("after locked:", unit:GetLocked())

unit:SetLocked(oldLocked) -- 恢复原状态
print("restored locked:", unit:GetLocked())
```

### GetVisible

获取显隐状态。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否可见 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldVisible = unit:GetVisible() -- 读取显隐状态
print("before visible:", oldVisible)

unit:SetVisible(not oldVisible)
print("after visible:", unit:GetVisible())

unit:SetVisible(oldVisible) -- 恢复原状态
print("restored visible:", unit:GetVisible())
```

### SetVisible

设置显隐。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `visible` | `Bool` | 是否可见 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldVisible = unit:GetVisible() -- 记录原显隐状态
print("before visible:", oldVisible)

unit:SetVisible(false) -- 隐藏单位
print("after visible:", unit:GetVisible())

unit:SetVisible(oldVisible) -- 恢复原状态
print("restored visible:", unit:GetVisible())
```

## Public

### GetAttribute

获取自定义属性值。若属性名在预设中不存在则返回 default。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 属性名（必须已在预设或单位属性配置中定义） |
| `default` | `Any` | 属性不存在时返回的默认值 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Any` | 属性值；属性不存在时返回 default |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldHp = unit:GetAttribute("HP", 100) -- 读取自定义属性
print("before HP:", oldHp)

unit:SetAttribute("HP", 200)
print("after HP:", unit:GetAttribute("HP", 100))

unit:SetAttribute("HP", oldHp) -- 恢复原值
print("restored HP:", unit:GetAttribute("HP", 100))
```

### SetAttribute

设置自定义属性。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 属性名 |
| `value` | `Any` | 属性值 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local oldHp = unit:GetAttribute("HP", 100) -- 记录旧值
print("before HP:", oldHp)

unit:SetAttribute("HP", 200) -- 修改属性值
print("after HP:", unit:GetAttribute("HP", 100))

unit:SetAttribute("HP", oldHp) -- 恢复原值
print("restored HP:", unit:GetAttribute("HP", 100))
```

## Public

### GetParent

获取父单位。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Unit` | 父单位；无父单位时返回 nil |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local parent = unit:GetParent() -- 获取父单位
print("parent name:", parent:GetName())

local children = parent:GetChildren()
print("parent children count:", #children)
for i = 1, math.min(3, #children) do
    print("sibling", i, children[i]:GetName())
end
```

### GetChildren

获取直接子单位列表。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 直接子单位数组 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local children = unit:GetChildren() -- 获取直接子单位
print("children count:", #children)
for i = 1, math.min(3, #children) do
    print("child", i, children[i]:GetName())
end
```

### DestroyChildren

删除所有子单位。

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local children = unit:GetChildren()
print("before children count:", #children)

unit:DestroyChildren() -- 删除全部子单位
print("DestroyChildren() called")

local after = unit:GetChildren()
print("after children count:", #after)
```

### GetDescendants

递归获取所有后代单位。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 所有后代单位数组（含子单位及其后代） |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local descendants = unit:GetDescendants() -- 递归获取后代
print("descendants count:", #descendants)
for i = 1, math.min(3, #descendants) do
    print("descendant", i, descendants[i]:GetName())
end
```

### FindFirstChild

按名称查找直接子单位。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 要查找的子单位名称 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Unit` | 找到的子单位；未找到时返回 nil |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local child = unit:FindFirstChild("ChildName") -- 按名称查找子单位
print("found child:", child:GetName(), "type:", child:GetUnitType())

local oldPos = child:GetPosition()
print("before pos:", oldPos)
child:SetPosition(Vector3.New(0, 0, 5)) -- 调整子单位位置

local newPos = child:GetPosition()
print("after pos:", newPos)

child:SetPosition(oldPos) -- 恢复原位置
```

### FindFirstAncestor

沿父链向上查找第一个名称匹配的祖先单位（不含自身）。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 要查找的祖先单位名称 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Unit` | 找到的祖先单位；未找到时返回 nil |

> 示例待补充（示例验证库暂无 `FindFirstAncestor` 对应文件）

### FindFromPath

从本单位开始按点分路径逐级查找后代单位，如 "Child.GrandChild"。任一段未找到时返回 nil。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `path` | `String` | 点分路径，各层级名称用 "." 分隔 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Unit` | 路径终点单位；任一段未找到时返回 nil |

> 示例待补充（示例验证库暂无 `FindFromPath` 对应文件）

### GetFullPath

获取本单位到顶层祖先的完整点分路径（含自身名称）。顶层单位返回自身名称。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `String` | 形如 "A.B.C" 的点分路径 |

> 示例待补充（示例验证库暂无 `GetFullPath` 对应文件）

### IsAncestorOf

判断本单位是否为指定后代单位的祖先。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `descendant` | `Unit` | 要判断的后代单位 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 本单位是否为指定单位的祖先 |

> 示例待补充（示例验证库暂无 `IsAncestorOf` 对应文件）

### IsDescendantOf

判断本单位是否为指定祖先单位的后代。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `ancestor` | `Unit` | 要判断的祖先单位 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 本单位是否为指定单位的后代 |

> 示例待补充（示例验证库暂无 `IsDescendantOf` 对应文件）

### HasChildren

判断本单位是否有直接子单位。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否有直接子单位 |

> 示例待补充（示例验证库暂无 `HasChildren` 对应文件）

### GetChildCount

获取直接子单位数量。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Number` | 直接子单位数量 |

> 示例待补充（示例验证库暂无 `GetChildCount` 对应文件）

### GetChildAtIndex

按索引获取直接子单位（索引从 1 开始，越界返回 nil）。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `index` | `Number` | 子单位索引（从 1 开始） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Unit` | 指定索引的子单位；越界时返回 nil |

> 示例待补充（示例验证库暂无 `GetChildAtIndex` 对应文件）

### GetUnitInfo

获取单位摘要信息。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Table` | 单位摘要信息，包含字段：name（单位名称）、unitType（单位类型） |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")

local info = unit:GetUnitInfo() -- 读取单位摘要
print("info.name:", info.name, "info.unitType:", info.unitType)
print("GetName():", unit:GetName())
print("GetUnitType():", unit:GetUnitType())
```

## 父子关系操作

### SetParent

设置父单位。传 nil 解除父子关系。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `parent` | `Unit` | nil 则解除父子关系 |

**示例**

```lua
local world = editor:GetService("World")
local unit = world:FindFirstChild("MyUnit")
local newParent = world:FindFirstChild("ParentUnit")

local oldParent = unit:GetParent() -- 记录旧父单位
print("before parent:", oldParent and oldParent:GetName() or "(root)")

unit:SetParent(newParent) -- 挂到新父单位
local cur = unit:GetParent()
print("after parent:", cur and cur:GetName() or "(root)")

unit:SetParent(oldParent) -- 恢复原父单位
cur = unit:GetParent()
print("restored parent:", cur and cur:GetName() or "(root)")
```
