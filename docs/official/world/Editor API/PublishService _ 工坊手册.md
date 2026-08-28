# PublishService

资产发布服务，提供本地文件与 mesh 的上传、批量发布、进度查询与自定义资产管理。

## Overview

编辑时资产发布服务，提供 PublishAsync / PublishSync（文件上传）、PublishMesh / PublishMeshSync（mesh 上传）、PublishAssetsBatch（批量发布），以及上传进度查询、错误查询与自定义资产管理。

**Get by:**

```lua
local service = editor:GetService("PublishService")
```

## Public

### PublishAsync

将本地文件上传为编辑器资产。支持图片（png / jpg / jpeg）、音频（mp3 / wav）、模型（fbx）三种类型，按文件后缀自动识别。上传完成后通过回调返回结果。

* 图片上传成功时返回值中的 `data` 字段包含宽高（`Width`、`Height`），音频和模型上传成功时 `data` 为空表
* FBX 上传会弹出模型导入对话框，同时只能上传一个 FBX；上一个完成后才可发起下一个

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `filePath` | `String` | 要上传的本地文件路径 |
| `info` | `Table` | 上传信息：Name（资源名称，可选）、Description（描述，可选）、Tags（标签数组，可选） |
| `callback` | `Function` | 上传完成回调：callback(success, result)，result 包含资源 ID、URI 等信息 |

**示例**

```lua
local service = editor:GetService("PublishService")
local info = { Name = "头像素材", Description = "PublishAsync 演示", Tags = { "avatar" } }

service:PublishAsync("D:/path/to/a.png", info, function(success, result) -- 异步上传图片
    if success then
        print("上传成功, AssetId:", result.AssetId, "Uri:", result.Uri)
    else
        print("上传失败:", result.Operation, result.ErrorCode, result.ErrorMessage)
    end
end)
```

### PublishSync

与 PublishAsync 功能相同，但同步等待上传完成后直接返回结果。支持图片、音频、模型三种类型，按文件后缀自动识别。

* 成功返回 `{ AssetId, Uri, data }`：仅图片的 `data` 含宽高
* 失败返回 `{ Operation, ErrorCode, ErrorMessage }`
* 超时时 ErrorCode 为 `-3`
* FBX 同时只能上传一个

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `filePath` | `String` | 要上传的本地文件路径 |
| `info` | `Table` | 上传信息：Name（资源名称，可选）、Description（描述，可选）、Tags（标签数组，可选） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Table` | 上传结果：成功返回资源 ID 与 URI；失败返回错误码与错误信息 |

**示例**

```lua
local service = editor:GetService("PublishService")
local info = { Name = "同步上传图", Tags = { "sync" } }

local result = service:PublishSync("D:/path/to/a.png", info) -- 同步上传图片
if not result.AssetId then
    print("上传失败:", result.ErrorCode, result.ErrorMessage)
    return
end
print("上传成功, AssetId:", result.AssetId, "Uri:", result.Uri)

local assets = service:ListCustomAssets(nil) or {}
local found = false
for _, asset in ipairs(assets) do
    if asset.name == info.Name then
        found = true
        print("列表中找到新资产:", asset.asset_id, asset.name)
    end
end
print("验证结果:", found and "已在列表中" or "未在列表中")
```

### GetPublishProgress

查询当前上传任务的进度

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Table` | 进度信息：{ Progress = number, StepName = string, IsPublishing = boolean } |

**示例**

```lua
local service = editor:GetService("PublishService")
local info = { Name = "查进度示例图", Tags = { "manual" } }

service:PublishAsync("D:/path/to/upload.png", info, function(success, result) -- 开始异步上传
    local progress = service:GetPublishProgress() -- 上传完成后再查一次
    print("上传结束: success=", success, "进度:", progress and progress.Progress, "发布中:", progress and progress.IsPublishing)
end)

local progress = service:GetPublishProgress() -- 上传中查询进度
print("上传中进度:", progress and progress.Progress, "步骤:", progress and progress.StepName, "发布中:", progress and progress.IsPublishing)
```

### GetLastPublishError

获取上次上传失败的错误信息

**返回值**

| 类型 | 说明 |
| --- | --- |
| `String` | 失败原因，无失败时返回空字符串 |

**示例**

```lua
local service = editor:GetService("PublishService")
local info = { Name = "查错误示例图", Tags = { "manual" } }

local result = service:PublishSync("D:/path/to/upload.png", info) -- 先上传一张图
if result.AssetId then
    print("上传成功, AssetId:", result.AssetId)
else
    print("上传失败:", result.ErrorCode, result.ErrorMessage)
end

local err = service:GetLastPublishError() -- 获取上次上传错误
if err == "" then
    print("上次上传无错误")
else
    print("上次上传错误:", err)
end
```

### PublishMesh

上传已导入编辑器的 mesh 资源。使用资源目录名定位，上传完成后通过回调返回结果。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `meshName` | `String` | 要上传的网格名称 |
| `info` | `Table` | 网格信息：Name（名称，可选）、Description（描述，可选）、Tags（标签数组，可选） |
| `callback` | `Function` | 上传完成回调：callback(success, result) |

**示例**

```lua
local service = editor:GetService("PublishService")
local info = { Name = "场景模型", Description = "PublishMesh 演示" }

service:PublishMesh("my_mesh", info, function(success, result) -- 异步上传 mesh
    if success then
        print("mesh 上传成功, AssetId:", result.AssetId, "Uri:", result.Uri)
    else
        print("mesh 上传失败:", result.Operation, result.ErrorCode, result.ErrorMessage)
    end
end)
```

### PublishMeshSync

与 PublishMesh 功能相同，但同步等待上传完成后直接返回结果。默认超时 60 秒。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `meshName` | `String` | 要上传的网格名称 |
| `info` | `Table` | 网格信息：Name（名称，可选，默认使用网格名）、Description（描述，可选）、Tags（标签数组，可选） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Table` | 上传结果：成功返回资源 ID 与 URI；失败返回错误码与错误信息 |

**示例**

```lua
local service = editor:GetService("PublishService")
local info = { Name = "同步模型" }

local result = service:PublishMeshSync("my_mesh", info) -- 同步上传 mesh
if result.AssetId then
    print("mesh 上传成功, AssetId:", result.AssetId, "Uri:", result.Uri)
else
    print("mesh 上传失败:", result.Operation, result.ErrorCode, result.ErrorMessage)
end
```

### PublishAssetsBatch

批量发布多种类型资产，同步返回与输入同序的结果列表。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `items` | `Array` | 上传项数组，每项包含 Type（资源类型）与本地路径或网格名，以及可选 Info |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Array` | 与输入同序的结果数组，每项包含是否成功与结果详情 |

**示例**

```lua
local service = editor:GetService("PublishService")

local items = {
    { Type = "image", LocalPath = "D:/Assets/a.png", Info = { Name = "图片1" } },
    { Type = "mesh", MeshName = "my_mesh", Info = { Name = "模型" } },
    { Type = "fbx", LocalPath = "D:/Assets/c.fbx", Info = { Name = "角色" } },
}

local results = service:PublishAssetsBatch(items) -- 批量上传
for i, r in ipairs(results) do
    if r.Success then
        print(i .. " 成功:", r.Result.AssetId, r.Result.Uri)
    else
        print(i .. " 失败:", r.Result.ErrorCode, r.Result.ErrorMessage)
    end
end
```
