# 第 10 章：数据脚本、配置与资产 URI

把常量和资源 URI 放入 data 配置，建立清晰、可维护的模块依赖。

## 你会学到什么

* `data/` 目录适合放什么，不适合放什么。
* 如何用配置表集中管理道具、分数、资源 URI。
* `official://`、`custom://` 与不同资源字段的对应关系。
* 如何给配置表加一层轻量校验，尽早发现拼写和类型错误。

## data/ 目录的定位

默认生成的 Lua 工程通常先只有 `client/`、`server/`、`common/`。`data/` 有两种常见来源：

* 在蛋仔 VS Code 插件中点击**导出数据**，生成或更新 `data/UINodes.lua`、`data/Prefab.lua` 等编辑器导出表。
* 你手动创建 `data/items.lua`、`data/round_config.lua` 等项目配置表。

无论是哪种来源，`data/` 放的都应该是静态配置：道具表、常量表、关卡参数、资源 URI 映射、UI 节点名映射。它可以被 `client` 和 `server` 读取，但自己不应该依赖任何运行端逻辑。

依赖方向保持成：

```text
client -> common / data
server -> common / data
common -> data
data   -> 无运行时依赖
```

这条规则很重要：`data/items.lua` 不应该 `game:GetService(...)`，不应该创建 Unit，不应该监听事件，也不应该 `require("server.xxx")` 或 `require("client.xxx")`。它只返回一份普通 Lua table。

## 最小示例：道具配置表

运行端：data  
 文件：`data/items.lua`

```lua
return {
    Coin = {
        DisplayName = "金币",
        Score = 1,
        EffectUnitName = "CoinEffect",
    },
    Gem = {
        DisplayName = "宝石",
        Score = 5,
        EffectUnitName = "GemEffect",
    },
}
```

`EffectUnitName` 是项目自己的配置键，保存编辑器中已配置 EffectUnit 的对象名。当前 Meta 没有提供可编辑的 Lua 侧特效资源选择字段，因此 Lua 不写入特效资源 ID，只通过公开的对象树查询接口找到并控制编辑器对象。

## 读取配置

运行端：server  
 文件：`server/main.lua`

```lua
local Items = require("data.items")

for key, item in pairs(Items) do
    print("[SE Lua Guide] 道具:", key, item.DisplayName, item.Score, item.EffectUnitName)
end

local coin = Items.Coin
if coin then
    print("[SE Lua Guide] 金币分数:", coin.Score)
end
```

`require` 路径要写完整目录前缀：`require("data.items")`。不要写成 `require("items")`，否则多人协作或目录变复杂后很容易加载错。

## 资源引用与字段

资源 URI 不只是“一个值”。它要和使用它的字段对应起来。

| 引用格式 | 常见用途 | 常见字段 |
| --- | --- | --- |
| `official://preset/103489` | 官方模型 / 组合 Unit 预设；`103489` 是本教程配置使用的示例 | `AssetService:LoadUnitAsset` / `LoadUnitAssetAsync` 的第一个参数 |
| `official://mesh/59268` | 官方网格资源 | `WorldUnit.RenderMeshId` / `PhysicsMeshId`、`RenderUnit.RenderMeshId` |
| `official://image/10066` | 官方 UI 图片 | `EUIImage.Image`、`EUIButton.NormalImage` / `PressImage` / `DisableImage` |
| `custom://...` | 用户生产内容 | 仅在目标公开 API 明确接受该 scheme 时使用 |

表中的数字 ID 只用于说明 URI 形态，不代表所有项目都应使用同一资源。在编辑器中右键你实际选择的资源，选择复制引用 ID，即可得到对应 URI。新手阶段建议把这些 URI 全部集中在 `data/` 配置里，业务代码只读取配置，不到处硬编码。

`official://audio/...`、`official://animation/...` 也是 AssetService 文档列出的公开 scheme，但具体应该交给哪个播放 API，要到音效和动画章节按该成员签名确认。本章不把“URI scheme 存在”推导成任意对象都有对应可写字段。

特效是当前教程的受控用法：先在编辑器中完成 EffectUnit 的资源配置并设置稳定名称，Lua 配置表只保存这个对象名或公开路径。不要因为看见别的资源使用 URI，就猜测 EffectUnit 也有可由教程写入的资源选择字段。

> UI 图片也使用字符串 URI：EUI 节点的图片字段（`Image`、`NormalImage`、`PressImage` 等）写成 `official://image/...` 字符串，不是裸数字。第 9 章已把 UI 节点和图片 URI 的规则单独讲过。

## 配置只声明，加载由对应章节负责

第 10 章只负责把资源 URI 管好；真正“创建模型”“播放特效”“加载自定义资产”属于运行时代码。

* 播放特效：读取 `EffectUnitName`，定位编辑器中已配置的 `EffectUnit`，再调用公开播放控制接口。
* 创建完整模型：读取 `PresetUri`，优先用 `AssetService:LoadUnitAsset` 或 `LoadUnitAssetAsync`。
* 创建单个网格 Unit：读取 `RenderMeshId`，写入 `WorldUnit.RenderMeshId`。

如果一个道具既要播放特效，又要生成模型，可以这样扩展配置：

```lua
return {
    Coin = {
        DisplayName = "金币",
        Score = 1,
        EffectUnitName = "CoinEffect",
        PresetUri = "official://preset/103489",
    },
}
```

不要在 `data/items.lua` 里直接调用 `AssetService:LoadUnitAsset`。配置表只说明“用哪个资源”，不执行“如何创建”。

## 进阶：给配置加轻量校验

配置表的错误通常很小：字段拼错、分数写成字符串、URI 少了前缀。但这些小错误会在运行时变成很难读的错误日志。可以在服务端启动时先校验一次。

```lua
local Items = require("data.items")

local function StartsWith(text, prefix)
    return type(text) == "string" and string.sub(text, 1, #prefix) == prefix
end

local function ValidateItemConfig()
    for key, item in pairs(Items) do
        assert(type(item.DisplayName) == "string", key .. ".DisplayName 必须是 string")
        assert(type(item.Score) == "number", key .. ".Score 必须是 number")
        assert(type(item.EffectUnitName) == "string" and item.EffectUnitName ~= "",
            key .. ".EffectUnitName 必须是非空对象名")
        if item.PresetUri ~= nil then
            assert(StartsWith(item.PresetUri, "official://preset/") or StartsWith(item.PresetUri, "map://"),
                key .. ".PresetUri 必须是已确认的 Unit 资产 URI")
        end
    end
end

ValidateItemConfig()
```

校验只在启动时跑一次，不要在每次拾取道具时重复跑。

## 从配置驱动特效播放

运行端：server

```lua
local Items = require("data.items")
local World = game:GetService("World")
local Task = game:GetService("Task")

local ItemEffects = {}

function ItemEffects.Play(itemKey, position)
    if not World or not Task then
        print("[SE Lua Guide][ERROR] World 或 Task 服务获取失败")
        return false
    end

    local item = Items[itemKey]
    if not item then
        print("[SE Lua Guide][WARN] 未找到道具配置:", itemKey)
        return false
    end

    local effect = World:FindFirstChild(item.EffectUnitName, true)
    if not effect or not effect:IsA("EffectUnit") then
        print("[SE Lua Guide][WARN] 未找到已配置的特效对象:", item.EffectUnitName)
        return false
    end

    effect:SetPosition(position)
    effect:SetDuration(1)
    effect:SetVisible(true)
    Task:Delay(1, function()
        -- Duration 的自动回收行为取决于资源，业务侧显式隐藏更稳定。
        effect:SetVisible(false)
    end)
    print("[SE Lua Guide] 播放", item.DisplayName, "特效")
    return true
end

return ItemEffects
```

这里的重点不是特效 API，而是“代码不再猜测未公开资源字段”。以后美术替换特效资源时，在编辑器中更新同名对象；只有对象名变化时才修改配置表。

## 常见错误

### 错误：在 data 中写运行时逻辑

`data/` 不调用 Service、不创建 Unit、不监听事件。它只返回静态 table。

### 错误：把项目配置键当成引擎属性

`EffectUnitName` 只是本教程的项目配置键，用来查找对象，不代表引擎存在同名属性。真正写入引擎对象时，只能使用 Meta 公开的字段，例如 `RenderMeshId`。

### 错误：资源 URI 散落在各处

动画 URI、preset URI、mesh URI 等作者可见资源引用应集中到配置表，方便替换、校验和审查；由编辑器管理的 EffectUnit 资源则保留在编辑器配置中。

### 错误：把 preset 当成 mesh

`official://preset/...` 用 `AssetService:LoadUnitAsset` 或 `LoadUnitAssetAsync` 加载；`official://mesh/...` 才写给 `RenderMeshId`。两者不是同一种资源。

### 错误：require 路径不带目录前缀

错误写法是省略目录的 `require("items")`；本教程统一写成 `require("data.items")`。

## 练习任务

1. 给配置表新增一个道具，定义 `DisplayName`、`Score`、`EffectUnitName`。
2. 把第 6 章示例里的特效对象名改成从配置表读取。
3. 给配置表新增 `PresetUri` 字段，并在第 17 章的资产加载示例中读取它。

## 本章验收标准

* [ ] 我知道 `data/` 只放静态配置，不写运行时逻辑。
* [ ] 我能用 `require("data.xxx")` 读取配置表。
* [ ] 我知道 preset / mesh 等公开资源 URI 应写到对应字段；EffectUnit 的资源选择当前由编辑器配置。
* [ ] 我知道资源 URI 应集中到配置表，并能写简单校验。

## 本章产物

* 一个 `data/items.lua` 或 `data/round_config.lua` 配置表。
* 一段启动校验日志，能指出缺失字段、错误 URI scheme、错误 `EffectUnitName` 类型或空配置。
* 一次从配置读取对象名并交给运行时代码使用的改造，例如让第 6 章通过 `EffectUnitName` 查找特效对象。

## 本章 API 对照

* [AssetService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/AssetService.html)
* [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)
* [EffectUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EffectUnit.html)

## 下一章预告

配置驱动写好了。下一章我们将把单局分数扩展为长期保存：用 DataStore 保存最高分，用 OrderedDataStore 做排行榜。
