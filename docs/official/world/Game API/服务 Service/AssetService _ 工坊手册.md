# AssetService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[AssetService]**（5 函数 / 2 事件）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[AssetService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/AssetService.html) 负责统一管理游戏内各类资产的加载、预加载与状态追踪。它支持同步和异步两种方式加载数据资产或单位资产，并能在资产加载失败或成功时通过事件通知调用方。

## 适用场景

在需要动态加载预设、模型、图片等资产时，通过 [AssetService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/AssetService.html) 进行异步预加载或直接加载，常用于场景初始化或按需加载资源。

## 使用要点

通过 game:GetService("AssetService") 获取服务实例。使用 PreloadAsync 批量预加载资产 URI 列表；使用 LoadDataAssetAsync 异步加载数据资产并在回调中处理结果；使用 LoadUnitAssetAsync 异步加载单位资产并在回调中获取创建的 Unit 实例。

## 注意事项

资产 URI 使用公开 scheme：official://{type}/{id}（如 official://preset/20001、official://image/10000、official://audio/30001、official://mesh/40001、official://animation/50001、official://skin/60001）、map://{name}（地图资源）、custom://...（用户生产内容）、eggyasset://...（引擎纹理资源）、net://{url}（允许的网络资源）。official:// 省略 type 时默认 Preset。LoadDataAsset/LoadDataAssetAsync 只用于 Data 类资源（例如 official://skin/... 或 custom://...）；预制体和地图等 Unit 资源应使用 LoadUnitAsset/LoadUnitAssetAsync。LoadDataAssetAsync 的回调签名为 function(ok, dataInstance)，ok 为布尔表示成功，dataInstance 为加载到的数据实例。加载 preset 后必须确认根 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 已挂到 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html) 树下；若 LoadUnitAsset/LoadUnitAssetAsync 对某些 preset 失败，但同一 URI 可通过 World:CreateAsset 创建，可将 World:CreateAsset 作为官方 preset 的兼容兜底。

## 代码示例

### 监听资产加载失败事件

```lua
-- @runtime client
local assetService = game:GetService('AssetService')
assetService.AssetFetchFailed:Once(function(uri, errorMsg)
    print('资产加载失败:', uri, errorMsg)
end)
assetService:LoadDataAssetAsync('invalid://url', function(ok, dataInstance)
    if not ok then
        print('异步加载失败:', dataInstance)
    end
end)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (2)

### AssetFetchFailed

签名：`AssetFetchFailed(uri: String, errorMsg: String)` 触发：`local`

当资产加载失败时触发，返回失败的资产 URI 和错误信息。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `uri` | `String` | 失败的资产 URI |
| `errorMsg` | `String` | 错误描述 |

> 示例代码

> 监听资产加载失败事件

```lua
-- @runtime client
-- 获取 AssetService 服务实例
local assetService = game:GetService("AssetService")

-- 监听 AssetFetchFailed 事件，当任何资产加载失败时触发
assetService.AssetFetchFailed:Once(function(uri, errorMsg)
    -- 打印失败的资产 URI 和错误信息
    print("资产加载失败:", uri, "错误:", errorMsg)
end)

-- 使用无效 scheme 触发失败路径
assetService:LoadDataAssetAsync("invalid://url", function(ok, data)
    if not ok then
        print("异步加载回调也返回失败")
    end
end)
```

### AssetLoaded

签名：`AssetLoaded(uri: String, result: Any)` 触发：`local`

当资产加载成功时触发，返回加载完成的资产 URI 和加载结果。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `uri` | `String` | 加载的资产 URI |
| `result` | `Any` | 加载结果 |

> 示例代码

> 监听资产加载成功事件

```lua
-- @runtime client
-- 获取 AssetService 服务实例
local assetService = game:GetService("AssetService")

-- 监听 AssetLoaded 事件，当任何资产加载成功时触发
assetService.AssetLoaded:Once(function(uri, result)
    -- 打印加载成功的资产 URI 和结果类型
    print("资产加载成功:", uri, "结果类型:", type(result))
end)

-- 使用 Data 类资源触发成功路径
assetService:LoadDataAssetAsync("official://skin/60001", function(ok, data)
    if ok then
        print("异步加载回调也返回成功")
    end
end)
```

## 函数 (5)

### PreloadAsync

签名：`PreloadAsync(uriList: Array, callback: Function) -> void`

批量预加载指定的资产 URI 列表，所有资产加载完成后通过回调函数通知。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `uriList` | `Array` | 资产 URI 列表 |
| `callback` | `Function` | 每个资产完成时回调 function(uri: String, status: String) |

**返回值** `void`

> 示例代码

> 批量预加载资产

```lua
-- @runtime client
-- 获取 AssetService 服务实例
local assetService = game:GetService("AssetService")

-- 定义要预加载的资产 URI 列表
local uriList = {
    "official://preset/10001",
    "official://image/10000",
    "official://audio/30001"
}

-- 批量预加载，每个资产完成时回调打印状态
assetService:PreloadAsync(uriList, function(uri, status)
    print("预加载完成:", uri, "状态:", status)
end)
```

### LoadDataAsset

签名：`LoadDataAsset(uri: String) -> Any | nil (数据实例，失败返回 nil)`

同步加载指定 URI 的 data 类型资产，并返回加载结果；加载失败时返回 nil。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `uri` | `String` | 资产 URI |

**返回值** `Any | nil` (数据实例，失败返回 nil)

> 示例代码

> 同步加载 Data 资产

```lua
-- @runtime client
local assetService = game:GetService('AssetService')
-- skin 属于 Data 类资源；预制体应改用 LoadUnitAsset
local loadedData = assetService:LoadDataAsset('official://skin/60001')
print('加载的资产数据:', loadedData)
```

### LoadDataAssetAsync

签名：`LoadDataAssetAsync(uri: String, callback: Function) -> void`

异步加载指定 URI 的 data 类型资产，加载完成后通过回调函数返回结果。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `uri` | `String` | 资产 URI |
| `callback` | `Function` | 完成回调 function(ok: Bool, dataInstance: table?) |

**返回值** `void`

> 示例代码

> 异步加载 Data 资产

```lua
-- @runtime client
local assetService = game:GetService('AssetService')
assetService:LoadDataAssetAsync('official://skin/60001', function(ok, data)
    if ok then
        print("异步加载成功，数据类型:", type(data))
    else
        print("异步加载失败")
    end
end)
```

### LoadUnitAsset

签名：`LoadUnitAsset(uri: String) -> Array&lt;Unit&gt; (创建出的 Unit 数组（根在索引 1，失败返回空表）)`

同步加载指定 URI 的资产，创建并返回 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 实例数组；加载后需自行设置根 Unit 的 `Parent` 等属性。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `uri` | `String` | 资产 URI（如 official://preset/{id}、map://xxx） |

**返回值** Array<[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)> (创建出的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 数组（根在索引 1，失败返回空表）)

> 示例代码

> 同步加载 Unit 资产并创建实例

```lua
-- @runtime client
local assetService = game:GetService('AssetService')
local World = game:GetService('World')

-- official://preset/{id} 会创建 Unit 实例数组；根 Unit 默认游离
local units = assetService:LoadUnitAsset('official://preset/20001')
local rootUnit = units[1]
if rootUnit ~= nil then
    rootUnit.Parent = World
    print('加载的根 Unit:', rootUnit.Name)
end
```

### LoadUnitAssetAsync

签名：`LoadUnitAssetAsync(uri: String, callback: Function) -> void`

异步加载指定 URI 的资产，加载完成后通过回调函数返回创建的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 实例数组；加载后需自行设置根 Unit 的 `Parent` 等属性。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `uri` | `String` | 资产 URI |
| `callback` | `Function` | 完成回调 function(ok: Bool, units: [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)[]) |

**返回值** `void`

> 示例代码

> 异步加载 Unit 资产

```lua
-- @runtime client
-- 获取 AssetService 服务实例
local assetService = game:GetService("AssetService")
local World = game:GetService("World")

-- 异步加载一个官方预设 Unit 资产，并在回调中处理创建的 Unit 数组
assetService:LoadUnitAssetAsync("official://preset/10001", function(ok, units)
    if ok and units and #units > 0 then
        local rootUnit = units[1]
        rootUnit.Parent = World
        print("异步加载 Unit 成功，根 Unit 名称:", rootUnit.Name)
    else
        print("异步加载 Unit 失败")
    end
end)
```
