# EUIService

EUIService 世界编辑器 EUI 服务，负责在编辑器中创建、查找、删除 EUI 节点。

## Overview

世界编辑器专属的 EUI（编辑器 UI 系统）服务，通过 editor:GetService("EUIService") 获取。仅开放节点的创建、查找与删除能力，节点属性设置基于节点操作。写操作经编辑器命令系统执行，支持撤销/重做。多数操作要求 EUI 编辑器已打开。

**Get by:**

```lua
local service = editor:GetService("EUIService")
```

## Public

### FindFirstChild

按名称查找第一个 EUI 节点。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 要查找的节点名称 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `EUINode` | 找到的节点；未找到时返回 nil |

**示例**

```lua
local eui = editor:GetService("EUIService")

eui:OpenEUIEditor()
local node = eui:FindFirstChild("MyNode") -- 按名称查找节点
print("name:", node:GetName())
print("type:", node:GetUnitType())
print("Text:", node:GetProperty("Text"))
```

### GetDescendants

获取场景中所有 EUI 节点对象。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 全部 EUI 节点数组 |

**示例**

```lua
local eui = editor:GetService("EUIService")

eui:OpenEUIEditor()
local nodes = eui:GetDescendants() -- 获取全部 EUI 节点
print("total nodes:", #nodes)

for i = 1, math.min(3, #nodes) do
    local node = nodes[i]
    print(i .. ":", node:GetName(), "type:", node:GetUnitType())
end
```

### CreateEUINode

按控件类型名创建 EUI 节点（SE 专属）。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `unitType` | `String` | 控件类型（如 EUIButton、EUITextLabel） |
| `parent` | `EUINode` | 父节点；nil 时挂到当前画布根节点 |
| `pos` | `Vector2` | 节点位置（可选） |
| `size` | `Vector2` | 节点尺寸（可选） |
| `name` | `String` | 节点名称（可选） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `EUINode` | 创建的节点；失败时返回 nil |

**示例**

```lua
local eui = editor:GetService("EUIService")

eui:OpenEUIEditor()
local layer = eui:CreateEUICanvasLayer("DemoLayer")
local btn = eui:CreateEUINode("EUIButton", layer) -- 创建按钮节点
btn:SetProperty("Text", "点击我")
print("created:", btn:GetName(), "type:", btn:GetUnitType(), "text:", btn:GetProperty("Text"))

local found = eui:FindFirstChild(btn:GetName()) -- 读回验证
print("verify in tree:", found ~= nil)
```

### CreateEUICanvasLayer

创建画布层（CanvasLayer）节点。画布层的父级恒为顶层节点，无需指定父节点。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 画布层名称 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `EUINode` | 创建的画布层节点；失败时返回 nil |

**示例**

```lua
local eui = editor:GetService("EUIService")

eui:OpenEUIEditor()
local layer = eui:CreateEUICanvasLayer("MyLayer") -- 创建画布层
print("created:", layer:GetName(), "type:", layer:GetUnitType())

local root = layer:GetParent()
print("parent:", root and root:GetName() or "nil")
local inTree = false
for _, child in ipairs(root:GetChildren()) do
    if child == layer then
        inTree = true
        break
    end
end
print("layer in top-level tree:", inTree)
```

### CreateEUISceneCanvasLayer

创建场景界面画布（SceneCanvasLayer）节点，自动生成并绑定对应场景界面预设数据。父级恒为顶层节点，无需指定父节点。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `EUINode` | 创建的场景画布节点；失败时返回 nil |

**示例**

```lua
local eui = editor:GetService("EUIService")

eui:OpenEUIEditor()
local before = #eui:GetDescendants()

local layer = eui:CreateEUISceneCanvasLayer() -- 创建场景界面画布
print("created:", layer:GetName(), "type:", layer:GetUnitType())
print("nodes before/after:", before, #eui:GetDescendants())
```

### OpenEUIEditor

打开 EUI 编辑器（已打开则不重复操作）。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否成功打开（已处于打开状态时也返回 true） |

**示例**

```lua
local eui = editor:GetService("EUIService")

local result = eui:OpenEUIEditor() -- 打开 EUI 编辑器
print("OpenEUIEditor:", result)

local editing = eui:IsInEUIEditMode()
print("IsInEUIEditMode:", editing)
if editing then
    print("已进入编辑模式，可继续 CreateEUICanvasLayer / CreateEUINode 建节点")
else
    print("未进入编辑模式，请手动打开 EUI 编辑器后重试")
end
```

### IsInEUIEditMode

当前是否处于 UI 编辑模式。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否处于 UI 编辑模式 |

**示例**

```lua
local eui = editor:GetService("EUIService")

local editing = eui:IsInEUIEditMode() -- 查询是否处于编辑模式
print("IsInEUIEditMode:", editing)
if editing then
    print("当前处于 UI 编辑模式，可进行节点创建/查找操作")
else
    print("当前未处于 UI 编辑模式")
end
```

### SwitchToSceneUICanvasEditMode

切换到场景界面（场景界面画布）预设编辑模式，进入后只显示指定画布。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `layer` | `EUINode` | 要切入编辑的场景画布节点 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否切换成功 |

**示例**

```lua
local eui = editor:GetService("EUIService")

eui:OpenEUIEditor()
local layer = eui:CreateEUISceneCanvasLayer()

print("switch to scene mode:", eui:SwitchToSceneUICanvasEditMode(layer)) -- 切入场景界面模式
print("IsInSceneUICanvasEditMode:", eui:IsInSceneUICanvasEditMode())

print("back to normal:", eui:SwitchToNormalCanvasEditMode()) -- 恢复普通模式
```

### SwitchToNormalCanvasEditMode

从场景界面（场景界面画布）编辑模式切换回普通画布编辑模式。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否切换成功 |

**示例**

```lua
local eui = editor:GetService("EUIService")

eui:OpenEUIEditor()
local layer = eui:CreateEUISceneCanvasLayer()
print("to scene mode:", eui:SwitchToSceneUICanvasEditMode(layer))

print("back to normal:", eui:SwitchToNormalCanvasEditMode()) -- 切回普通画布模式
print("in scene mode after:", eui:IsInSceneUICanvasEditMode())
```

### IsInSceneUICanvasEditMode

当前是否处于场景界面（场景界面画布）预设编辑模式。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否处于场景画布编辑模式 |

**示例**

```lua
local eui = editor:GetService("EUIService")

local editing = eui:IsInSceneUICanvasEditMode() -- 查询是否处于场景界面编辑模式
print("IsInSceneUICanvasEditMode:", editing)
if editing then
    print("当前处于场景界面画布编辑模式，仅显示指定场景界面画布")
else
    print("当前未处于场景界面画布编辑模式")
end
```
