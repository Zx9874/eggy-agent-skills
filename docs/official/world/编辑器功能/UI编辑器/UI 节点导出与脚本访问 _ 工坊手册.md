# UI 节点导出与脚本访问

UI 编辑器中创建的控件，需要先**导出 UI 节点数据**生成索引表，脚本才能通过控件名称定位到对应实例并进行操作。

本文涵盖：

1. UI 节点数据的导出流程
2. 客户端脚本如何获取 UI 控件
3. 按钮等控件的交互事件处理
4. 客户端与服务端通过 `RemoteEvent` 通信

## 导出 UI 节点数据

UI 编辑器中创建的控件保存在编辑器工程里，脚本要访问这些控件需要先把节点数据导出为脚本可读的索引表。

### 导出步骤

1. 打开脚本工程（VSCode），点击左侧的【插件】侧边栏。
2. 选择【导出数据】。

   ![](https://u5-creator.s3.game.163.com/manual/assets/30.BgYwEfLH.png)
3. 导出成功后，在【浏览】侧边栏可以看到工程里新增了一个 `data` 文件夹，其中的 `UINodes.lua` 就是导出的 UI 资源索引表。

   ![](https://u5-creator.s3.game.163.com/manual/assets/31.CEnFz8Ad.png)

### 导出表的内容

`data/UINodes.lua` 文件的内容是一个 LUA 表，键为 UI 编辑器中控件的名称，值为该控件的资源 id。例如：

```lua
return {
    LabelTime = "<id1>",
    LabelPoint = "<id2>",
    BtnReset = "<id3>",
}
```

WARNING

* UI 编辑器中**控件名称必须唯一**，重名会导致导出表冲突或脚本定位失败。
* UI 编辑器内修改控件名称、新增 / 删除控件后，需要**重新导出**才能在脚本里看到最新数据。

## 在客户端定位 UI 控件

UI 控件的访问只能在客户端（`client/main.lua` 或 `client/` 下的脚本）进行。

### 关键服务与对象

#### Players

`Players` 服务管理所有连接到当前服务器的玩家对象，提供玩家查找、用户信息查询（性别和头像缩略图）以及聊天样式设置等能力。

**API 参考**：`Players`

#### LocalPlayer

`Players.LocalPlayer` 仅在客户端有值，并且是当前客户端的玩家实例。服务端读到的是 `nil`。

**API 参考**：`Player`

#### EuiManager

UI 控件实例统一由 `Players.LocalPlayer.PlayerGui.EuiManager` 管理。通过 `EuiManager:GetNodeByID(id)` 即可拿到控件实例。

**API 参考**：`EUIManager`

### 通用获取代码

在 `client/main.lua` 中编写访问 UI 控件的工具函数：

```lua
local Players = game:GetService("Players")
local UINodes = require("data.UINodes") -- 获取 UI 资源索引表

-- 获取 EUI 管理器
local function GetEUI()
    local lp = Players.LocalPlayer
    if not lp then return nil end
    return lp.PlayerGui.EuiManager
end

-- 根据控件名取出资源 id，再通过 EuiManager 获取实例
local function GetNodeByID(id)
    if not id then return nil end
    local euiMgr = GetEUI()
    if not euiMgr then return nil end
    return euiMgr:GetNodeByID(id)
end

-- 获取已导出的 UI 控件实例
local LabelTime = GetNodeByID(UINodes["LabelTime"])
local LabelPoint = GetNodeByID(UINodes["LabelPoint"])
print("[ShaoTest] 找到文本框对象:", LabelTime, LabelPoint)
```

运行游戏后在输出窗看到对应日志，即表示关联成功。

![](https://u5-creator.s3.game.163.com/manual/assets/32.DJBDK346.png)

WARNING

`Players.LocalPlayer` 在客户端启动初期可能为 `nil`，所以上述 `GetEUI` 加了空值判断；如果在 `client/main.lua` 顶层立即调用 `GetNodeByID`，部分设备可能因加载未完成而返回 `nil`，建议在事件回调或 `Task:Wait` 后再访问。

## 按钮交互

### 监听点击事件

`EUIButton` 实例提供 `OnClicked` 事件，玩家点击按钮时触发。

```lua
local BtnReset = GetNodeByID(UINodes["BtnReset"])
BtnReset.OnClicked:Connect(function()
    -- 这里写按钮点击后的客户端逻辑
end)
```

按钮控件的创建方式与可配置属性见 [UI 编辑器基础 - 按钮 EUIButton](https://u5-creator.s3.game.163.com/manual/se/ui_editor/basics.html#按钮-euibutton)。

### 修改控件属性

通过设置控件实例的属性可以动态修改 UI 显示，例如修改文本框内容：

```lua
LabelTime.Text = "倒计时: 60"
LabelPoint.Text = "当前得分：0"
```

各控件的可写属性详见 [UI 编辑器基础 - 控件类型](https://u5-creator.s3.game.163.com/manual/se/ui_editor/basics.html#控件类型) 或对应 API 文档。

## 客户端 / 服务端通信（RemoteEvent）

UI 控件只能在客户端访问，但游戏的核心逻辑（玩家数据、玩法状态等）通常在服务端运行。当 UI 操作需要触发服务端行为（例如点击按钮重置球体）时，需要通过 `RemoteEvent` 通信。

### RemoteEvent 简介

`RemoteEvent` 是用于客户端与服务端之间双向通信的全局机制，支持：

* **服务端 → 客户端**：服务端可以向所有玩家或指定玩家发送消息。
* **客户端 → 服务端**：客户端可以将玩家的输入操作上报给服务端。

事件信号：

| 信号 | 触发端 | 说明 |
| --- | --- | --- |
| `OnClientEvent` | 客户端 | 收到服务端发来的消息 |
| `OnServerEvent` | 服务端 | 收到客户端发来的消息（带 player 参数） |

发送方法：

| 方法 | 调用端 | 说明 |
| --- | --- | --- |
| `:FireServer(...)` | 客户端调用 | 把消息发到服务端 |
| `:FireClient(player, ...)` | 服务端调用 | 把消息发到指定玩家客户端 |
| `:FireAllClients(...)` | 服务端调用 | 把消息发到所有客户端 |

WARNING

`RemoteEvent` 通过 `game:CreateRemoteEvent("eventId")` 创建实例。客户端和服务端使用相同的 `eventId` 创建返回的是各自独立的实例对象，它们都会响应对应端同名实例发出的事件通知。

**API 参考**：`RemoteEvent`

### 示例：点击按钮重置球体

下面以"点击 UI 重置按钮 → 服务端重置球体位置"为例，展示完整通信流程。

**客户端**（`client/main.lua`）：

```lua
local BtnReset = GetNodeByID(UINodes["BtnReset"])
local gameResetRE = game:CreateRemoteEvent("GameReset")

BtnReset.OnClicked:Connect(function()
    gameResetRE:FireServer() -- 把按钮点击事件转发给服务端
end)
```

**服务端**（`server/main.lua`）：

```lua
local gameResetRE = game:CreateRemoteEvent("GameReset")

gameResetRE.OnServerEvent:Connect(function(player)
    -- player 参数是触发的玩家实例
    ResetBall() -- 调用服务端的重置逻辑
end)
```
