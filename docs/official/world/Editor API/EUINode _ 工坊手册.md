# EUINode

EUINode 对象 API 参考。EUINode 由 EUIService 方法返回（FindFirstChild、GetDescendants、CreateEUINode 等）。

## 概览

编辑器 EUI（编辑器 UI 系统）的节点对象。提供获取属性、设置属性接口。

> 不可实例化，由接口返回

## 函数

### GetUnitType

签名：`GetUnitType() -> String`

获取 EUI 控件类型名称。

**返回值** `String` — 控件类型

**示例**

```lua
local eui = editor:GetService("EUIService")
local node = eui:FindFirstChild("MyNode")

print("unit type:", node:GetUnitType()) -- 获取控件类型
print("name:", node:GetName())
print("Text:", node:GetProperty("Text"))
```

### GetName

签名：`GetName() -> String`

获取节点名称。

**返回值** `String` — 节点名称

**示例**

```lua
local eui = editor:GetService("EUIService")
local node = eui:FindFirstChild("MyNode")

print("name:", node:GetName()) -- 获取节点名称
print("type:", node:GetUnitType())
local parent = node:GetParent()
print("parent:", parent and parent:GetName() or "nil（根层级）")
```

### GetProperty

签名：`GetProperty(name: String, default: Any?) -> Any`

获取内置属性

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 属性名 |
| `default` | `Any` | 默认值 |

**返回值** `Any` — 属性值；属性不存在时返回默认值

**示例**

```lua
local eui = editor:GetService("EUIService")
local node = eui:FindFirstChild("MyNode")

local old = node:GetProperty("Text") -- 读取文本属性
print("before Text:", old)

print("SetProperty:", node:SetProperty("Text", "临时内容")) -- 写入新值
print("readback Text:", node:GetProperty("Text"))

node:SetProperty("Text", old) -- 恢复原值
print("restored Text:", node:GetProperty("Text"))
```

### SetProperty

签名：`SetProperty(name: String, value: Any) -> Bool`

设置内置属性

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 属性名 |
| `value` | `Any` | 属性值 |

**返回值** `Bool` — 是否设置成功

**示例**

```lua
local eui = editor:GetService("EUIService")
local node = eui:FindFirstChild("MyNode")

local old = node:GetProperty("Text") -- 记录旧值
print("before Text:", old)

print("SetProperty:", node:SetProperty("Text", "示例新内容")) -- 设置内置属性

print("readback Text:", node:GetProperty("Text"))

node:SetProperty("Text", old) -- 恢复原值
print("restored Text:", node:GetProperty("Text"))
```

### GetParent

签名：`GetParent() -> EUINode`

获取父节点。

**返回值** `EUINode` — 父节点；无父节点时返回 nil

**示例**

```lua
local eui = editor:GetService("EUIService")
local node = eui:FindFirstChild("MyNode")

local parent = node:GetParent() -- 获取父节点
print("parent:", parent:GetName())

for _, child in ipairs(parent:GetChildren()) do
    if child == node then
        print("parent-child relation verified")
        break
    end
end
```

### SetParent

签名：`SetParent(parent: EUINode?) -> Bool`

设置父节点。传 nil 移动到根层级。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `parent` | `EUINode` | 父节点 |

**返回值** `Bool` — 是否设置成功

**示例**

```lua
local eui = editor:GetService("EUIService")
local child = eui:FindFirstChild("Child")
local parent = eui:FindFirstChild("Parent")

local oldParent = child:GetParent() -- 记录旧父节点
print("old parent:", oldParent and oldParent:GetName() or "nil（根层级）")

print("SetParent:", child:SetParent(parent)) -- 设置新父节点

local nowParent = child:GetParent()
print("now parent:", nowParent and nowParent:GetName() or "nil")

child:SetParent(oldParent) -- 恢复原父子关系
print("restored parent:", child:GetParent() == oldParent)
```

### GetChildren

签名：`GetChildren() -> Array`

获取直接子节点列表。

**返回值** `Array` — 直接子节点数组

**示例**

```lua
local eui = editor:GetService("EUIService")
local node = eui:FindFirstChild("MyNode")

local children = node:GetChildren() -- 获取直接子节点
print("children count:", #children)
for _, child in ipairs(children) do
    print("  child:", child:GetName(), "type:", child:GetUnitType())
end

local target = node:FindFirstChild("ChildName")
local oldText = target:GetProperty("Text")
target:SetProperty("Text", "联动修改") -- 修改子节点属性
print("target Text:", target:GetProperty("Text"))

target:SetProperty("Text", oldText) -- 恢复原值
```

### GetDescendants

签名：`GetDescendants() -> Array`

递归获取所有后代节点。

**返回值** `Array` — 所有后代节点数组

**示例**

```lua
local eui = editor:GetService("EUIService")
local node = eui:FindFirstChild("MyNode")

local descendants = node:GetDescendants() -- 递归获取后代节点
print("descendants count:", #descendants)
for _, d in ipairs(descendants) do
    print("  descendant:", d:GetName(), "type:", d:GetUnitType())
end

local target = node:FindFirstChild("ChildName")
local oldText = target:GetProperty("Text")
target:SetProperty("Text", "联动修改") -- 修改子节点属性
print("target Text:", target:GetProperty("Text"))

target:SetProperty("Text", oldText) -- 恢复原值
```

### FindFirstChild

签名：`FindFirstChild(name: String) -> EUINode`

按名称查找第一个直接子节点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 名称 |

**返回值** `EUINode` — 找到的子节点；未找到时返回 nil

**示例**

```lua
local eui = editor:GetService("EUIService")
local node = eui:FindFirstChild("MyNode")

local child = node:FindFirstChild("ChildName") -- 按名称查找子节点
print("found child:", child:GetName(), "type:", child:GetUnitType())

local oldText = child:GetProperty("Text")
child:SetProperty("Text", "已联动修改") -- 修改文本属性
print("readback Text:", child:GetProperty("Text"))

child:SetProperty("Text", oldText) -- 恢复原值
```

### Destroy

签名：`Destroy() -> Bool`

删除节点及其所有子节点（支持撤销/重做）。

**返回值** `Bool` — 是否销毁成功

**示例**

```lua
local eui = editor:GetService("EUIService")
local node = eui:FindFirstChild("MyNode")

print("before Destroy:", node:GetName(), "type:", node:GetUnitType())
print("Destroy:", node:Destroy()) -- 销毁节点

local found = eui:FindFirstChild("MyNode")
print("still in tree:", found ~= nil)
```
