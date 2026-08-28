# World

World 编辑世界服务。 管理场景中的所有 Unit，提供查找、创建等操作。

## Overview

编辑器两端共用的场景单位管理服务，通过 `editor:GetService("World")` 获取。负责场景单位的查找、查询、创建等。返回的单位为 Unit 对象封装。

**Get by:**

```lua
local service = editor:GetService("World")
```

## Public

### FindFirstChild

通过名称查找 Unit。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 要查找的单位名称 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Unit` | 找到的单位；未找到时返回 nil |

**示例**

```lua
local world = editor:GetService("World")

local unit = world:FindFirstChild("MyUnit") -- 按名称查找单位
print("found:", unit:GetName(), "type:", unit:GetUnitType())

local oldPos = unit:GetPosition()
print("before pos:", oldPos)
unit:SetPosition(Vector3.New(0, 0, 10)) -- 移动单位
print("after pos:", unit:GetPosition())

unit:SetPosition(oldPos) -- 恢复原位置
print("restored pos:", unit:GetPosition())
```

### GetDescendants

获取场景中所有 Unit。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 场景中的所有单位数组 |

**示例**

```lua
local world = editor:GetService("World")

local units = world:GetDescendants() -- 获取场景全部单位
print("scene units count:", #units)
for i = 1, math.min(3, #units) do
    local u = units[i]
    print(string.format("[%d] name=%s type=%s", i, u:GetName(), u:GetUnitType()))
end
```

### CreateAsset

通过资产 ID 在场景中创建单位。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `contentId` | `String` | 预设资产 ID，可通过 PrefabService:CreatePrefab 创建后获取 |
| `pos` | `Vector3` | 创建位置（世界坐标） |
| `options` | `Table` | 创建选项：rot（旋转）、scale（缩放），均为可选 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 创建的单位数组 |

**示例**

```lua
local prefab = editor:GetService("PrefabService")
local world = editor:GetService("World")

local prefabId = prefab:CreatePrefab("WorldUnit") -- 先创建预设
local units = world:CreateAsset(prefabId, Vector3.New(0, 0, 0), {
    scale = Vector3.New(2, 2, 2),
}) -- 用预设 ID 创建单位
local unit = units[1]
print("created:", unit:GetName(), "type:", unit:GetUnitType())

unit:SetName("DemoUnit") -- 修改名称
unit:SetPosition(Vector3.New(10, 0, 0)) -- 修改位置
print("after rename:", unit:GetName(), "pos:", unit:GetPosition())

unit:Destroy() -- 清理单位
prefab:RemovePrefab({ prefabId }) -- 清理预设
```

### CreateUnit

按单位类型在场景中创建单位，自动查找该类型的默认预设资源；也可通过 values.AssetId 直接指定预设。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `unitType` | `String` | 要创建的单位类型名称（如 WorldUnit、ModelUnit） |
| `values` | `Table` | 创建参数：Position（位置）、Rotation（旋转）、Scale（缩放）、AssetId（直接指定预设资产 ID），均为可选 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 创建的单位数组；该类型无可用预设且未传 AssetId 时返回空数组 |

**示例**

```lua
local world = editor:GetService("World")

local unit = world:CreateUnit("WorldUnit", {})[1] -- 创建单位
print("created:", unit:GetName(), unit:GetUnitType())

unit:SetName("DemoCreateUnit")
print("rename readback:", unit:GetName())
print("found by name:", world:FindFirstChild("DemoCreateUnit") == unit)

unit:Destroy() -- 销毁单位
print("after destroy:", world:FindFirstChild("DemoCreateUnit") == nil)
```

### GetUnitsByUnitType

按单位类型获取场景中所有匹配的 Unit。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `unitType` | `String` | 要查询的单位类型名称 |
| `exact` | `Bool` | 是否精确匹配；false 时同时返回继承子类型 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 匹配到的单位数组，无匹配时返回空数组 |

**示例**

```lua
local world = editor:GetService("World")

local unit = world:CreateUnit("WorldUnit", {})[1] -- 创建单位

local exact = world:GetUnitsByUnitType("WorldUnit", true) -- 精确匹配
local fuzzy = world:GetUnitsByUnitType("WorldUnit", false) -- 模糊匹配
print("exact:", #exact, "fuzzy:", #fuzzy)

local hit = false
for _, u in ipairs(exact) do
    if u == unit then
        hit = true
        break
    end
end
print("created in exact:", hit)

unit:Destroy() -- 销毁单位
```
