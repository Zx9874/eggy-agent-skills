# PlayerGui

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[PlayerGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PlayerGui.html) 是当前玩家的客户端 UI 入口，提供 [EUIManager](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUIManager.html) 和 ScreenGui 两个常用 UI 控制对象。

## 适用场景

在客户端脚本中，通过 Players.LocalPlayer.PlayerGui 获取当前玩家的 UI 入口，再访问 EuiManager 查找或管理 EUI 节点，或通过 ScreenGui 显示飘字、结算面板等界面效果。

## 使用要点

[PlayerGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PlayerGui.html) 不可直接构造，应从 Players.LocalPlayer.PlayerGui 获取实例；再通过公开的 EuiManager 和 ScreenGui 属性进入对应 UI API。

## 注意事项

[PlayerGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PlayerGui.html) 不可直接构造，必须从 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 实例的 [PlayerGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PlayerGui.html) 属性获取。ScreenGui 和 EuiManager 均为只读属性，由引擎自动管理生命周期。

## 代码示例

### 获取当前玩家 UI 入口

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local playerGui = localPlayer.PlayerGui

local euiManager = playerGui.EuiManager
local screenGui = playerGui.ScreenGui
print('UI 管理器:', euiManager)
screenGui:ShowTips('欢迎回来', 1.0)
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `EuiManager` | [EUIManager](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUIManager.html) | `-` | 获取该玩家的 EUI 管理器实例，用于访问设备分辨率、根节点、创建 UI 节点等界面管理功能。 |
| `ScreenGui` | [ScreenGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ScreenGui.html) | `-` | 获取玩家屏幕 Gui 实例，用于控制飘字提示、游戏结果面板、游戏结束面板、观战控件显隐、个人积分面板、团队积分面板等 UI 的显示与更新。 |

## 关联类型

* [EUIManager](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUIManager.html)
* [ScreenGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ScreenGui.html)
