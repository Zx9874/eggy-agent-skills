# SelectionService

SelectionService 选择管理服务。 管理编辑器中当前选中的 Unit，支持获取、替换、追加和移除选中。

## Overview

编辑器两端共用的选中管理服务，通过 `editor:GetService("SelectionService")` 获取。管理编辑器中当前选中的 Unit，支持获取、替换、追加与移除选中。入参可传 Unit 对象列表。

**Get by:**

```lua
local service = editor:GetService("SelectionService")
```

## Public

### Get

获取当前选中的 Unit 列表，未选中时返回空表。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 当前选中的单位数组 |

**示例**

```lua
local world = editor:GetService("World")
local sel = editor:GetService("SelectionService")

local selected = sel:Get() -- 读取当前选中
local unit
if #selected == 0 then
    unit = world:FindFirstChild("MyUnit")
    sel:Add({ unit })
    selected = sel:Get()
    print("已联动 Add 一个单位，重新读取选中：")
end

for _, u in ipairs(selected) do
    print("selected:", u:GetName(), "type:", u:GetUnitType())
end
print("count:", #selected)

if unit then
    sel:Remove({ unit }) -- 清理加入的单位
end
```

### Set

替换当前选中，传入 Unit 对象列表。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `units` | `Array` | Unit 对象列表 |

**示例**

```lua
local world = editor:GetService("World")
local sel = editor:GetService("SelectionService")
local unit = world:FindFirstChild("MyUnit")

sel:Set({ unit }) -- 替换选中为指定单位
print("after Set, count:", #sel:Get())

sel:Set({}) -- 清空选中
print("after clear, count:", #sel:Get())
```

### Add

追加 Unit 到当前选中，已存在的自动去重。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `units` | `Array` | Unit 对象列表 |

**示例**

```lua
local world = editor:GetService("World")
local sel = editor:GetService("SelectionService")
local unit = world:FindFirstChild("MyUnit")

sel:Add({ unit }) -- 追加单位到选中
local selected = sel:Get()
print("after Add, count:", #selected)
for _, u in ipairs(selected) do
    print("  selected:", u:GetName())
end

sel:Remove({ unit }) -- 清理选中
print("after cleanup, count:", #sel:Get())
```

### Remove

从当前选中移除指定 Unit。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `units` | `Array` | Unit 对象列表 |

**示例**

```lua
local world = editor:GetService("World")
local sel = editor:GetService("SelectionService")
local unitA = world:FindFirstChild("MyUnit")
local unitB = world:FindFirstChild("MyUnit2")

sel:Add({ unitA, unitB })
print("after Add, count:", #sel:Get())

sel:Remove({ unitA }) -- 移除其中一个单位
print("after Remove one, count:", #sel:Get())
for _, u in ipairs(sel:Get()) do
    print("  remained:", u:GetName())
end

sel:Remove({ unitB })
print("after cleanup, count:", #sel:Get())
```
