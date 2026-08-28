# AssetService

AssetService 资产服务，提供预加载资源与自定义资产管理。原预设管理能力已迁移至 PrefabService。

## Overview

AssetService 为资产服务，提供预加载资源清单与自定义资产（导入/导出/查询）管理。原预设相关能力（创建、删除、复制、属性读写、导入导出等）已迁移至 PrefabService，请通过 `editor:GetService("PrefabService")` 获取预设服务；AssetService 上的旧预设接口仍保留可用，但已标记迁移，后续版本将移除。

**Get by:**

```lua
local service = editor:GetService("AssetService")
```

## Public

### AddPreloadAsset

将资源加入预加载清单，进入玩法前会提前加载该资源，减少游戏中的加载等待。支持 custom://（自定义资源）与 official://（官方资源）两种 URI

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `uri` | `String` | 完整资源 URI（custom://xxx / official://mesh/9833） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否添加成功 |

**示例**

```lua
local asset = editor:GetService("AssetService")
local uri = "custom://0ggZCDgBO4bSTrG8d"

local ok = asset:AddPreloadAsset(uri) -- 添加预加载资源
print("add result:", ok)

local list = asset:GetPreloadAssetList() -- 查询清单验证已加入
local found = false
for _, item in ipairs(list) do
    if item == uri then
        found = true
        break
    end
end
print("in preload list:", found)

asset:RemovePreloadAsset(uri) -- 移除资源，恢复原清单
print("after remove, list count:", #asset:GetPreloadAssetList())
```

### RemovePreloadAsset

将资源从预加载清单中移除，移除后进入玩法时不再提前加载该资源

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `uri` | `String` | 完整资源 URI（custom://xxx / official://mesh/9833） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否移除成功 |

**示例**

```lua
local asset = editor:GetService("AssetService")
local uri = "custom://0ggZCDgBO4bSTrG8d"

asset:AddPreloadAsset(uri) -- 先加入清单
print("before remove, list count:", #asset:GetPreloadAssetList())

local ok = asset:RemovePreloadAsset(uri) -- 移除预加载资源
print("remove result:", ok)

local list = asset:GetPreloadAssetList() -- 查询清单验证已移除
local found = false
for _, item in ipairs(list) do
    if item == uri then
        found = true
        break
    end
end
print("still in list:", found)
```

### GetPreloadAssetList

获取当前已配置的预加载资源清单

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 当前预加载资源清单（资源 URI 数组） |

**示例**

```lua
local asset = editor:GetService("AssetService")
local uri = "custom://0ggZCDgBO4bSTrG8d"

local list = asset:GetPreloadAssetList() -- 获取预加载资源清单
print("preload count:", #list)
for _, item in ipairs(list) do
    print("  -", item)
end

asset:AddPreloadAsset(uri) -- 添加资源
list = asset:GetPreloadAssetList() -- 回查清单
print("after add, count:", #list)

asset:RemovePreloadAsset(uri) -- 移除恢复原清单
print("after remove, count:", #asset:GetPreloadAssetList())
```

### ExportCustomAsset

导出自定义资产元数据到 JSON 文件（用于在地图间转移自定义资源）

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `assetId` | `String` | 要导出的自定义资产 ID |
| `exportPath` | `String` | 导出文件路径 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 是否导出成功 |

**示例**

```lua
local service = editor:GetService("AssetService")
local exportPath = "D:/path/to/export.json"

local ok = service:ExportCustomAsset("asset_12345", exportPath) -- 导出资产元数据
print("导出结果:", ok)

local assetId = service:ImportCustomAsset(exportPath) -- 导回验证
if assetId == "" then
    print("导回失败")
else
    print("导回成功, 资产ID:", assetId)
end
```

### ImportCustomAsset

从 JSON 文件导入自定义资产元数据

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `jsonPath` | `String` | 要导入的 JSON 文件路径 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `String` | 资源ID（失败返回空串） |

**示例**

```lua
local service = editor:GetService("AssetService")

local assetId = service:ImportCustomAsset("D:/path/to/export.json") -- 导入资产元数据
print("导入成功, 资产ID:", assetId)

local assets = service:ListCustomAssets(nil) or {}
local found = false
for _, asset in ipairs(assets) do
    if asset.asset_id == assetId then
        found = true
        print("列表中找到导入资产:", asset.name, asset.asset_type)
    end
end
print("验证结果:", found and "已在列表中" or "未在列表中")
```

### ListCustomAssets

列出自定义资产元数据

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `assetType` | `String` | 资产类型过滤（如 picture/audio/texture）；nil 时返回全部 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 自定义资产列表，每项包含资产 ID、类型、名称等信息 |

**示例**

```lua
local service = editor:GetService("AssetService")
local info = { Name = "列表示例资产", Tags = { "manual" } }

local result = service:PublishSync("D:/path/to/upload.png", info) -- 先上传一个资产
if not result.AssetId then
    print("上传失败:", result.ErrorCode, result.ErrorMessage)
    return
end
print("上传成功, AssetId:", result.AssetId)

local assets = service:ListCustomAssets(nil) or {} -- 列出全部自定义资产
local found = false
for _, asset in ipairs(assets) do
    if asset.name == info.Name then
        found = true
        print("列表中找到:", asset.asset_id, asset.asset_type, asset.name)
    end
end
print("验证结果:", found and "已在列表中" or "未在列表中")
```
