# PrefabService

通过 `editor:GetService(\"PrefabService\")` 获取。提供预设（Prefab）管理：从场景单位创建预设、删除预设、属性读写、导入导出。

## Overview

通过 `editor:GetService("PrefabService")` 获取。提供预设（Prefab）管理：从场景单位创建预设、删除预设、属性读写、导入导出。

**Get by:**

```lua
local service = editor:GetService("PrefabService")
```

## Public

### CreatePrefabFromUnit

将场景中的单位（含子单位树）保存为预设，适用于在场景中拼接好的单位结构（如 WorldUnit 下挂 ScriptUnit），保存后可复用 World:CreateAsset 重新放置。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `unitId` | `Int` | 场景单位 ID |
| `folderKey` | `String` | 目标文件夹 Key（可选） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `String` | 新建预设 ID（失败返回 nil） |

**示例**

```lua
local prefab = editor:GetService("PrefabService")
local world = editor:GetService("World")

local parentIds = world:CreateUnit("WorldUnit", { Position = { 0, 0, 0 } }) -- 创建父单位
local parent = parentIds[1]
if parent then
    local childIds = world:CreateUnit("WorldUnit", { Position = { 0, 1, 0 } }) -- 创建子单位
    local child = childIds[1]
    if child then
        child:SetParent(parent) -- 挂到父单位下，组成单位树
    end
    local prefabId = prefab:CreatePrefabFromUnit(parent) -- 保存为预设
    print("prefab created:", prefabId)
    if prefabId then
        prefab:RemovePrefab({ prefabId }) -- 清理预设
    end
    if child then child:Destroy() end
    parent:Destroy() -- 清理场景单位
end
```

### RemovePrefab

删除指定 Package 下的预设。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefabIdList` | `Array` | 要删除的预设 ID 列表 |
| `packageId` | `String` | 预设所在包 ID；不传时自动定位 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 操作成功返回 true，失败返回 false |

**示例**

```lua
local asset = editor:GetService("PrefabService")

local ids = asset:GetAllPrefabIds() -- 获取全部预设 ID
print("before count:", #ids)

local newId = asset:CreatePrefab("WorldUnit") -- 先创建预设
asset:RemovePrefab({ newId }) -- 删除该预设
print("removed:", newId)

local after = asset:GetAllPrefabIds() -- 查询列表验证数量减少
print("after count:", #after)
```

### GetPrefabEditableProperties

获取单位类型的可编辑属性列表，用于查询预设支持读写哪些属性。返回每项含 key（属性键）、title（显示名）、type、default 等。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `UnitType` | `Any` | 单位类型（如 WorldUnit） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 属性元数据列表，每项 {key, title, type, default, description} |

**示例**

```lua
local prefab = editor:GetService("PrefabService")

local attrs = prefab:GetPrefabEditableProperties("WorldUnit") -- 查询可编辑属性
for _, attr in ipairs(attrs) do
    print(attr.key, attr.title, attr.type) -- 打印属性键与显示名
end
```

### GetPrefabValue

读取预设属性值，不存在时返回默认值。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefabId` | `String` | 预设 ID |
| `attrKey` | `String` | 属性名 |
| `default` | `Any` | 属性不存在时返回的默认值 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Any` | 属性值 |

**示例**

```lua
local asset = editor:GetService("PrefabService")

local newId = asset:CreatePrefab("WorldUnit") -- 先创建预设
local name = asset:GetPrefabValue(newId, "Name", "未命名") -- 读取预设名称
print("asset name:", name)
print("no-such-attr default:", asset:GetPrefabValue(newId, "NoSuchAttr", "默认值"))

asset:ChangePrefabValue(newId, { { key = "Name", value = "DemoAsset" } }) -- 修改名称
print("after change:", asset:GetPrefabValue(newId, "Name", "未命名"))

asset:ChangePrefabValue(newId, { { key = "Name", value = name } }) -- 恢复原名
print("after restore:", asset:GetPrefabValue(newId, "Name", "未命名"))

asset:RemovePrefab({ newId }) -- 清理
```

### ChangePrefabValue

修改预设属性。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefabId` | `String` | 预设 ID |
| `changeDataList` | `Array` | 要修改的属性列表，每项包含属性名和值 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 操作成功返回 true，失败返回 false |

**示例**

```lua
local assetService = editor:GetService("PrefabService")

local attrs = assetService:GetPrefabEditableProperties("WorldUnit") -- 查询可编辑属性
-- 打印结果示例（key | title | type）：
--   RenderMeshId | 模型资源ID | String
--   BodyType     | 物理类型   | Int
--   Position     | 位置       | Vector3
--   Scale        | 缩放       | Vector3
--   Name         | 名称       | String
--   Desc         | 描述       | String

local newId = assetService:CreatePrefab("WorldUnit") -- 先创建预设
assetService:ChangePrefabValue(newId, { { "Name", "改名预设" } }) -- 修改名称属性
local cur = assetService:GetPrefabValue(newId, "Name") -- 读回验证
print("Name:", cur)

assetService:RemovePrefab({ newId }) -- 清理
```

### GetAllPrefabIds

获取当前所有预设的 ID 列表（编辑器内预设，不含开发者上传的自定义资产）

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 当前所有预设的 ID 列表 |

**示例**

```lua
local asset = editor:GetService("PrefabService")

local ids = asset:GetAllPrefabIds() -- 获取全部资产 ID
print("asset count:", #ids)

local showCount = #ids
if showCount > 3 then
    showCount = 3
end
for i = 1, showCount do
    print("  -", ids[i])
end
```

### ApplyPrefabToInstances

预设编辑完成后调用，将预设数据同步到场景中所有使用该预设的实例（属性级同步，缺失的子单位自动补建）。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefabId` | `String` | 预设 ID |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否已执行同步 |

**示例**

```lua
local prefab = editor:GetService("PrefabService")
local world = editor:GetService("World")

local prefabId = prefab:CreatePrefab("WorldUnit") -- 先创建预设
local units = world:CreateAsset(prefabId, Vector3.New(0, 0, 0)) -- 场景放置实例
if units and #units > 0 then
    prefab:ChangePrefabValue(prefabId, { { "Name", "同步名称" } }) -- 修改预设
    local ok = prefab:ApplyPrefabToInstances(prefabId) -- 应用到场景所有实例
    print("applied:", ok)
    units[1]:Destroy() -- 清理实例
end
prefab:RemovePrefab({ prefabId }) -- 清理预设
```

### ExportPrefab

将预设导出为二进制文件（.bin，msgpack 打包的序列化数据）。导出的文件可拷贝到其他地图，通过 ImportPrefab / ImportPrefabs 导入。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefabId` | `String` | 要导出的预设 ID |
| `path` | `String` | 导出文件路径（如 D:/chair.bin） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否导出成功 |

**示例**

```lua
local asset = editor:GetService("PrefabService")

local ids = asset:GetAllPrefabIds() -- 获取全部资产 ID
local path = "D:/preset_export.bin"
local ok = asset:ExportPrefab(ids[1], path) -- 导出第一个资产到指定路径
print("export:", ok, path)
```

### ImportPrefab

从二进制文件导入预设到当前地图。若导入的预设 ID 与当前地图已有预设冲突，会自动生成新 ID，不会覆盖已有预设。缺省导入到自定义文件夹。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `path` | `String` | 要导入的 .bin 文件路径 |
| `packageId` | `String` | 目标包 ID，缺省进自定义文件夹所在包 |
| `folderKey` | `String` | 目标文件夹 Key，缺省进自定义文件夹 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `String` | 导入后的预设 ID，失败返回空串 |

**示例**

```lua
local asset = editor:GetService("PrefabService")

local newId = asset:ImportPrefab("D:/preset_export.bin") -- 从文件导入预设
print("imported asset:", newId)

local ids = asset:GetAllPrefabIds() -- 读回列表验证已导入
local found = false
for _, id in ipairs(ids) do
    if id == newId then
        found = true
        break
    end
end
print("imported in list:", found)
```

### ExportPrefabs

批量导出预设到目录，每个预设一个 .bin 文件（文件名 = 预设 ID 转义）。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefabIdList` | `Array` | 要导出的预设 ID 列表 |
| `dirPath` | `String` | 导出目标目录 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 成功导出的文件路径列表 |

**示例**

```lua
local asset = editor:GetService("PrefabService")

local ids = asset:GetAllPrefabIds() -- 获取全部资产 ID
local exportIds = { ids[1] }
if #ids > 1 then
    table.insert(exportIds, ids[2])
end

local paths = asset:ExportPrefabs(exportIds, "D:/presets") -- 批量导出到目录
print("exported files:", #paths)
for _, p in ipairs(paths) do
    print("  -", p)
end
```

### ImportPrefabs

从目录扫描所有 .bin 文件逐个导入预设，返回导入的新预设 ID 列表。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `dirPath` | `String` | 包含 .bin 文件的目录路径 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 导入成功的新预设 ID 列表 |

**示例**

```lua
local asset = editor:GetService("PrefabService")

local newIds = asset:ImportPrefabs("D:/presets") -- 从目录批量导入
print("imported count:", #newIds)
for _, id in ipairs(newIds) do
    print("  -", id)
end

local ids = asset:GetAllPrefabIds() -- 读回列表查看总数
print("total assets now:", #ids)
```
