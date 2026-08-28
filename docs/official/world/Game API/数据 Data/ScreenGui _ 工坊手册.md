# ScreenGui

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `client` |

[ScreenGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ScreenGui.html) 是当前玩家本地屏幕 UI 的快捷控制对象，用于显示飘字、游戏结果、观战控件和个人/团队积分面板。

## 适用场景

客户端脚本需要给本地玩家显示提示、结算结果或积分面板时，通过 Players.LocalPlayer.PlayerGui.ScreenGui 获取实例后调用对应方法。

## 使用要点

[ScreenGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ScreenGui.html) 不可直接构造，应从 Players.LocalPlayer.PlayerGui.ScreenGui 获取实例；所有方法只影响当前客户端本地 UI。

## 注意事项

[ScreenGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ScreenGui.html) 不可直接构造，必须从 [PlayerGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PlayerGui.html) 属性获取。所有方法均为客户端本地调用，仅影响当前玩家的界面显示。积分面板的显示与隐藏需成对调用，避免界面残留。

## 代码示例

### 显示本地玩家提示

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui

screenGui:ShowTips('准备开始', 1.0)
```

## 函数 (14)

### ShowTips

签名：`ShowTips(msg: String, duration: Float) -> void`

在屏幕上显示一条飘字提示消息，持续指定时间后消失。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `msg` | `String` | 消息字符串 |
| `duration` | `Float` | 持续时间（秒），不传时默认 1.0 |

**返回值** `void`

> 示例代码

> 显示飘字提示

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
screenGui:ShowTips('获得道具', 1.0)
```

### ShowGameResult

签名：`ShowGameResult(result: Bool) -> void`

显示游戏结果面板，展示胜利或失败。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `result` | `Bool` | 游戏结果（胜负） |

**返回值** `void`

> 示例代码

> 显示游戏胜负结果

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
screenGui:ShowGameResult(true)
```

### ShowGameOverPanel

签名：`ShowGameOverPanel() -> void`

显示游戏结束面板。

**返回值** `void`

> 示例代码

> 显示游戏结束面板

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
screenGui:ShowGameOverPanel()
```

### SetSpectatorControlsHidden

签名：`SetSpectatorControlsHidden(hidden: Bool) -> void`

控制观战模式下是否隐藏角色操作控件（如复位、左摇杆、跳/翻滚/冲刺、技能等）。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `hidden` | `Bool` | true=隐藏（进入观战），false=恢复（退出观战） |

**返回值** `void`

> 示例代码

> 切换观战控件显示

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
screenGui:SetSpectatorControlsHidden(true)
```

### ShowPlayerScoreBoard

签名：`ShowPlayerScoreBoard(score: Int, targetScore: Int) -> void`

显示个人积分面板，展示当前积分与目标积分。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `score` | `Int` | 当前积分 |
| `targetScore` | `Int` | 目标积分（0=不显示目标） |

**返回值** `void`

> 示例代码

> 显示个人积分面板

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
screenGui:ShowPlayerScoreBoard(3, 10)
```

### UpdatePlayerScore

签名：`UpdatePlayerScore(score: Int) -> void`

更新已显示的个人积分面板中的积分值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `score` | `Int` | 当前积分 |

**返回值** `void`

> 示例代码

> 更新个人积分

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
screenGui:UpdatePlayerScore(4)
```

### HidePlayerScoreBoard

签名：`HidePlayerScoreBoard() -> void`

隐藏当前玩家的个人积分面板。

**返回值** `void`

> 示例代码

> 隐藏个人积分面板

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
screenGui:HidePlayerScoreBoard()
```

### ShowTeamScoreBoard

签名：`ShowTeamScoreBoard(campScores: Table) -> void`

显示团队积分面板，展示各阵营的积分。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `campScores` | `Table` | 阵营积分映射，键为阵营 ID（Int），值为积分（Int） |

**返回值** `void`

> 示例代码

> 显示团队积分面板

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
local campScores = { [1] = 3, [2] = 5 }
screenGui:ShowTeamScoreBoard(campScores)
```

### UpdateTeamScore

签名：`UpdateTeamScore(campScores: Table) -> void`

更新已显示的团队积分面板中的阵营积分（全量数据）。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `campScores` | `Table` | 阵营积分映射，键为阵营 ID（Int），值为积分（Int） |

**返回值** `void`

> 示例代码

> 更新团队积分

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
local campScores = { [1] = 4, [2] = 5 }
screenGui:UpdateTeamScore(campScores)
```

### SetTeamColor

签名：`SetTeamColor(campId: Int, color: Int) -> void`

设置指定阵营在积分面板中的显示颜色。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `campId` | `Int` | 阵营 ID |
| `color` | `Int` | 颜色值 (0xRRGGBB) |

**返回值** `void`

> 示例代码

> 设置团队颜色

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
screenGui:SetTeamColor(1, 0xFF0000)
```

### HideTeamScoreBoard

签名：`HideTeamScoreBoard() -> void`

隐藏团队积分面板。

**返回值** `void`

> 示例代码

> 隐藏团队积分面板

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
screenGui:HideTeamScoreBoard()
```

### TakeScreenshot

签名：`TakeScreenshot() -> String (截图保存路径)`

截取当前屏幕画面并保存为 PNG 图片文件，返回保存路径。

**返回值** `String` (截图保存路径)

> 示例代码

> 截取当前客户端屏幕

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
local path = screenGui:TakeScreenshot()
print('截图保存路径:', path)
```

### SimulateSwipe

签名：`SimulateSwipe(startPos: Vector2, endPos: Vector2, duration: Float) -> void`

模拟一次屏幕滑动操作，从起始位置滑动到结束位置，持续指定时长。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `startPos` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | 起始坐标 |
| `endPos` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | 结束坐标 |
| `duration` | `Float` | 滑动时长（秒），不传时默认 0.3 |

**返回值** `void`

> 示例代码

> 模拟一次屏幕滑动

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
screenGui:SimulateSwipe(Vector2.New(120, 320), Vector2.New(520, 320), 0.3)
```

### SimulateTap

签名：`SimulateTap(position: Vector2) -> void`

模拟一次屏幕点击操作，在指定位置触发点击事件。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `position` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | 坐标 |

**返回值** `void`

> 示例代码

> 模拟一次屏幕点击

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local screenGui = localPlayer.PlayerGui.ScreenGui
screenGui:SimulateTap(Vector2.New(320, 240))
```
