# 第 9 章：UI / EUI 与 CoreGui

安全定位 EUI 节点、更新 HUD，并处理 UI 就绪和连接清理。

## 你会学到什么

* UI 代码为什么主要写在 client。
* 如何通过 `PlayerGui.EuiManager` 取到 EUI 根节点，并用稳定 `Name` 查找编辑器 UI 节点。
* 如何更新文本、响应按钮点击、接收服务端 RemoteEvent。
* 动态创建 EUI 节点时坐标、图片 URI、节点命名的基本规则。
* 为什么 UI 模块要用 `Init()`，并同步写 testspec。

## UI 的职责边界

| 事情 | 放在哪一端 | 原因 |
| --- | --- | --- |
| 获取 EUI 节点、修改文本、显示/隐藏面板 | client | UI 属于本地表现 |
| 监听按钮点击、键盘输入 | client | 输入来自本地玩家 |
| 分数、奖励、存档、是否允许重置 | server | 权威状态不能相信客户端 |
| 把权威结果通知 UI | server → client RemoteEvent | 第 8 章的通信模式 |

一句话：**client 负责显示和请求，server 负责判定和回传结果。**

## 从 UI 编辑器到 Lua

建议在 UI 编辑器中给关键节点设置稳定 `Name`，并使用前缀：

| 节点类型 | 推荐前缀 | 示例 |
| --- | --- | --- |
| EUIButton | `btn_` | `btn_refresh` |
| EUITextLabel | `label_` | `label_point` |
| EUIImage | `img_` | `img_coin` |
| EUILayout / 面板 | `panel_` | `panel_hud` |
| 全屏遮罩 | `mask_` | `mask_pause` |
| LoadingBar | `bar_` | `bar_hp` |
| ProgressTimer | `ring_` | `ring_cd` |

保存 UI 后，再通过 `PlayerGui.EuiManager` 取到 EUI 根节点，用根节点的 `FindFirstChild(name, true)` 按稳定 `Name` 递归查找真实节点。本系列约定：**脚本一律按节点 Name 查找，不依赖导出编号**，这样改 UI、换导出顺序都不会影响代码。

## 获取 UI 节点

运行端：client  
 文件：`client/hud.lua`

```lua
local Players = game:GetService("Players")

local Hud = {}

local function GetEuiManager()
    if not Players then return nil end
    local localPlayer = Players.LocalPlayer
    if not localPlayer or not localPlayer.PlayerGui then
        return nil
    end
    return localPlayer.PlayerGui.EuiManager
end

-- 按稳定 Name 递归查找节点：root 是 EuiManager:GetRootNode()，true 表示递归子树
local function GetNode(name)
    local euiManager = GetEuiManager()
    if not euiManager then return nil end
    local rootNode = euiManager:GetRootNode()
    if not rootNode then return nil end
    return rootNode:FindFirstChild(name, true)
end

function Hud.Init()
    local labelPoint = GetNode("label_point")
    if labelPoint and labelPoint:IsA("EUITextLabel") then
        labelPoint.Text = "当前得分：0"
        return true
    else
        print("[SE Lua Guide][WARN] 没有找到 EUITextLabel: label_point")
        return false
    end
end

return Hud
```

运行端：client  
 文件：`client/main.lua`

```lua
local Hud = require("client.hud")
if not Hud.Init() then
    print("[SE Lua Guide][WARN] HUD 尚未就绪，请检查本地 PlayerGui 和节点 Name")
end
```

本系列的 UI 模块统一采用 `Init()` / `Destroy()` 生命周期：`require` 时只返回 table，不在文件顶层绑定事件或创建复杂界面。`Init()` 返回 false 表示当前 PlayerGui 或节点尚未就绪；调用方可以记录诊断并在合适的公开生命周期点重试，不能靠固定延迟猜加载完成。

## RemoteEvent 驱动 HUD

假设第 8 章的 `common/remote_events.lua` 中定义了：

```lua
return {
    RequestHudSnapshot = RemoteEvent.New("RequestHudSnapshot"),
    HudSnapshot = RemoteEvent.New("HudSnapshot"),
}
```

把 `Hud.Init()` 扩展为响应服务端消息和按钮点击：

```lua
local Players = game:GetService("Players")
local World = game:GetService("World")
local RunService = game:GetService("RunService")
local RemoteEvents = require("common.remote_events")

local Hud = {}
local labelPoint
local labelTime
local btnRefresh
local gameEndTime = -1
local nextUpdateTime = 0
local connections = {}

local function GetEuiManager()
    if not Players then return nil end
    local localPlayer = Players.LocalPlayer
    if not localPlayer or not localPlayer.PlayerGui then return nil end
    return localPlayer.PlayerGui.EuiManager
end

local function GetNode(name)
    local euiManager = GetEuiManager()
    if not euiManager then return nil end
    local rootNode = euiManager:GetRootNode()
    if not rootNode then return nil end
    return rootNode:FindFirstChild(name, true)
end

local function SetLabelText(node, nodeName, text)
    if not node or not node:IsA("EUITextLabel") then
        print("[SE Lua Guide][WARN] 没有找到 EUITextLabel:", nodeName)
        return false
    end
    node.Text = text
    return true
end

local function AddConnection(connection)
    connections[#connections + 1] = connection
end

local function RequestHudSnapshot(reason)
    RemoteEvents.RequestHudSnapshot:FireServer({
        kind = "hud_snapshot",
        reason = reason,
    })
end

local function BindEvents()
    AddConnection(RemoteEvents.HudSnapshot.OnClientEvent:Connect(function(snapshot)
        if type(snapshot) ~= "table"
            or type(snapshot.score) ~= "number"
            or type(snapshot.phase) ~= "string"
            or type(snapshot.endTime) ~= "number"
            or type(snapshot.serverTime) ~= "number" then
            print("[SE Lua Guide][WARN] 收到非法 HUD 快照")
            return
        end

        SetLabelText(labelPoint, "label_point", "当前得分：" .. tostring(snapshot.score))
        if snapshot.phase == "playing" then
            gameEndTime = snapshot.endTime
        else
            gameEndTime = -1
            SetLabelText(labelTime, "label_time", "等待开始")
        end
    end))

    if btnRefresh and btnRefresh:IsA("EUIButton") then
        AddConnection(btnRefresh.OnClicked:Connect(function()
            -- 按钮只请求刷新权威快照，不直接修改分数或回合状态。
            RequestHudSnapshot("button_refresh")
        end))
    else
        print("[SE Lua Guide][WARN] 没有找到 EUIButton: btn_refresh")
    end

    AddConnection(RunService.Heartbeat:Connect(function()
        if gameEndTime < 0 or not labelTime then return end
        local now = World:GetServerTime()
        if now < nextUpdateTime then return end
        nextUpdateTime = now + 1
        SetLabelText(
            labelTime,
            "label_time",
            "倒计时：" .. math.max(0, math.ceil(gameEndTime - now))
        )
    end))
end

function Hud.Destroy()
    for _, connection in ipairs(connections) do
        connection:Disconnect()
    end
    connections = {}
    labelPoint = nil
    labelTime = nil
    btnRefresh = nil
    gameEndTime = -1
end

function Hud.Init()
    Hud.Destroy()  -- 重复初始化前先清理，避免重复监听。

    if not Players or not World or not RunService then
        print("[SE Lua Guide][ERROR] HUD 所需服务获取失败")
        return false
    end

    labelPoint = GetNode("label_point")
    labelTime = GetNode("label_time")
    btnRefresh = GetNode("btn_refresh")

    local pointReady = SetLabelText(labelPoint, "label_point", "当前得分：0")
    local timeReady = SetLabelText(labelTime, "label_time", "等待开始")
    if not pointReady or not timeReady then
        Hud.Destroy()
        return false
    end

    BindEvents()
    RequestHudSnapshot("hud_ready")
    return true
end

function Hud.Destroy()
    -- 当前最小版本尚未建立持续连接；扩展版会在这里统一断开。
end

return Hud
```

注意：按钮点击只发送只读 HUD 快照请求，不直接修改分数或回合。任何会改变权威状态的按钮，都必须另行设计服务端业务校验。

## 动态创建 UI 的最小规则

多数新手先用 UI 编辑器创建节点即可。需要运行时创建节点时，通过 `World:CreateUnit` 创建对应 EUI 节点类型（`EUILayout`、`EUITextLabel`、`EUIImage`、`EUIButton` 等），并把它挂到 EUI 根节点下：

```lua
local Players = game:GetService("Players")
local World = game:GetService("World")

if not Players or not World then
    print("[SE Lua Guide][ERROR] Players 或 World 服务获取失败")
    return
end

local localPlayer = Players.LocalPlayer
if not localPlayer then
    print("[SE Lua Guide][WARN] LocalPlayer 尚未就绪")
    return
end

local playerGui = localPlayer.PlayerGui
if not playerGui then
    print("[SE Lua Guide][WARN] PlayerGui 尚未就绪")
    return
end

local euiManager = playerGui.EuiManager
if not euiManager then
    print("[SE Lua Guide][WARN] 本地 EUIManager 尚未就绪")
    return
end

local rootNode = euiManager:GetRootNode()
if not rootNode then
    print("[SE Lua Guide][WARN] EUI 根节点尚未就绪")
    return
end

local resolution = euiManager:GetDeviceResolution()
local sw, sh = resolution.x, resolution.y

-- 创建一个面板：Parent 指向 EUI 根节点，使其进入节点树
local panel = World:CreateUnit("EUILayout", {
    Name = "panel_runtime_tip",
    Parent = rootNode,
    Position = Vector2.New(sw / 2, sh / 2),
    Size = Vector2.New(500, 120),
    Visible = true,
})

if not panel or not panel:IsA("EUILayout") then
    print("[SE Lua Guide][ERROR] EUI 面板创建失败")
    return
end

-- 在面板下创建文本节点：Parent 指向 panel
local label = World:CreateUnit("EUITextLabel", {
    Name = "label_runtime_tip",
    Parent = panel,
    Position = Vector2.New(250, 60),
    Size = Vector2.New(460, 80),
    Text = "运行时提示",
})

if not label or not label:IsA("EUITextLabel") then
    print("[SE Lua Guide][ERROR] EUI 文本节点创建失败")
end
```

关键点：

* 动态创建节点统一走 `World:CreateUnit(节点类型, {...})`，第一个参数是 EUI 节点类型名（`EUILayout`/`EUITextLabel`/`EUIImage`/`EUIButton` 等）。
* 客户端 EUIManager 入口是 `Players.LocalPlayer.PlayerGui.EuiManager`，不是 `game:GetService("EUIManager")`，也不是 `StarterGui.EuiManager`。
* 新节点的 `Parent` 必须指向 EUI 根节点或其子节点，否则不会进入节点树、不会被渲染。
* `Anchor` 的公开默认值是 `(0.5, 0.5)`；`Position` 与 `Anchor` 共同决定节点相对父节点的对齐位置。不同布局下先在编辑器预览，不在代码里假设未经公开说明的屏幕原点语义。
* 获取屏幕尺寸用 `euiManager:GetDeviceResolution()`，不要硬编码 1920/1080。
* `Position`、`Size` 用 `Vector2.New(...)` 或 `Vector2(...)`，不要用 table。
* 图片属性如 `Image`、`NormalImage`、`PressImage` 是字符串资源 URI（如 `"official://image/10066"`），不是裸数字。
* 读取公开属性直接访问 `node.Position`、`node.Size`、`node.Visible`、`node.Opacity`，不要凭命名习惯发明未公开 getter。

## CoreGui 与 StarterGui

`StarterGui` 不是客户端获取 EUIManager 的入口。它主要用于 CoreGui 显隐等系统 UI 控制：

> 兼容性提示：部分运行包可能在 `client/main.lua` 入口首帧尚未准备好 CoreGui。只有在目标版本实际复现首帧调用不生效时，才使用 `Task:Delay(1, function() ... end)` 延后重试，并记录运行包版本；固定延迟 1 秒不是 Meta 保证，也不是所有项目的必需步骤。

```lua
local StarterGui = game:GetService("StarterGui")
if StarterGui then
    local wasEnabled = StarterGui:GetCoreGuiEnabled(Enums.CoreGuiType.All)
    StarterGui:SetCoreGuiEnabled(Enums.CoreGuiType.All, false)
    -- 功能结束时恢复进入前的状态，避免永久影响系统 UI。
    StarterGui:SetCoreGuiEnabled(Enums.CoreGuiType.All, wasEnabled)
else
    print("[SE Lua Guide][ERROR] StarterGui 服务获取失败")
end
```

普通玩法 HUD 优先通过 `PlayerGui.EuiManager` 操作。服务端代理 UI 和 CoreGui 是进阶主题，第一轮只需要知道不要混用入口。

## testspec：让 UI 可测试

只要章节或项目中新增一个可交互 UI 模块，就同步写测试规格：

文件：`test/testspec_hud.md`

```markdown
## 一、模块信息

| 字段 | 值 |
|---|---|
| 模块路径 | `client.hud` |
| 入口方法 | `Hud.Init()` |
| 挂载根节点 | UI 编辑器导出的 HUD 节点 |

## 二、节点清单

| Name | 类型 | 父节点 Name | 初始可见性 | 说明 |
|---|---|---|---|---|
| `label_point` | EUITextLabel | `(root)` | true | 显示当前得分 |
| `label_time` | EUITextLabel | `(root)` | true | 显示倒计时 |
| `btn_refresh` | EUIButton | `(root)` | true | 请求刷新权威 HUD 快照 |

## 三、交互逻辑

### 功能组：快照刷新请求

| 字段 | 内容 |
|---|---|
| 触发方式 | 点击 |
| 触发节点 | `btn_refresh` |
| 效果描述 | 客户端发送只读 `RequestHudSnapshot` 请求，服务端回传权威 HUD 快照 |

## 四、关键常量

| 常量名 | 值 | 用途 |
|---|---|---|
| HUD_REFRESH_INTERVAL | 1 | 倒计时文本每秒刷新 |

## 五、设计意图

HUD 用于显示分数和倒计时，并把刷新按钮点击转换为只读的服务端快照请求。
```

testspec 不替代测试，但它能让后续 QA 明确“要找哪些节点、点哪里、期待什么变化”。

## 常见错误

### 错误：在服务端操作 EUI 节点

EUI 节点访问属于客户端。服务端只负责通过 RemoteEvent 通知客户端显示什么。

### 错误：UI 节点没设稳定 Name

关键节点必须设置稳定 Name，并尽量使用 `btn_`、`label_`、`panel_` 等前缀。否则脚本和测试都很难定位。

### 错误：把图片资源写成裸数字

把 `NormalImage` 写成裸数字 `10066` 是错误的。EUI 图片属性需要字符串资源 URI，例如 `NormalImage = "official://image/10066"`。

### 错误：隐藏节点只设 Opacity = 0

`Opacity` 是不透明度，0 只是透明，节点仍可能参与计算。需要隐藏时用 `node:SetVisible(false)` 或 `node.Visible = false`。

### 错误：require 时直接创建 UI

`client/hud.lua` 顶层不要直接创建节点或绑定事件。导出 `Init()`，由 `client/main.lua` 显式调用。

## 练习任务

1. 在 UI 编辑器中创建 `label_point`、`label_time`、`btn_refresh`，并确保它们的 `Name` 与代码一致。保存 UI。
2. 编写 `client/hud.lua`，在 `Hud.Init()` 中获取节点并设置初始文本。
3. 接入第 8 章的 `RemoteEvents.HudSnapshot`，让服务端回传快照后更新分数和倒计时。
4. 为 HUD 写一份 `test/testspec_hud.md`。

## 本章验收标准

* [ ] 我知道 UI 代码主要放在 client。
* [ ] 我能通过 `PlayerGui.EuiManager:GetRootNode()` + `FindFirstChild(name, true)` 获取编辑器节点。
* [ ] 我知道 EUI 坐标、图片 URI、属性直读的关键规则。
* [ ] 我能用 RemoteEvent 驱动 UI 更新，而不是让客户端决定权威状态。
* [ ] 我知道可交互 UI 需要同步 testspec。

## 本章产物

* `client/hud.lua`：通过 `Players.LocalPlayer.PlayerGui.EuiManager` 获取 UI 节点并更新文本。
* `test/testspec_hud.md`：记录 HUD 节点、交互和截图验收标准。
* 一份截图记录：证明分数和倒计时可读、无遮挡、低分辨率下不裁切。

这些产物会在第 22 章变成 Capstone HUD。真实发布前至少补一张 HUD 截图，并保存到 `evidence/screenshots/`。

## 本章 API 对照

* [EUIManager](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUIManager.html)
* [PlayerGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PlayerGui.html)
* [EUINodeBase](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUINodeBase.html)
* [EUITextLabel](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUITextLabel.html)
* [EUIButton](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUIButton.html)
* [StarterGui](https://u5-creator.s3.game.163.com/manual/se/game_api/service/StarterGui.html)
* [RemoteEvent](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RemoteEvent.html)

## 下一章预告

UI 能显示了。下一章我们将学习 `data/` 目录：把资源 URI、道具配置和 UI 节点映射集中管理，让代码更容易维护。
