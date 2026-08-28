# EUITouchInfo

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[EUITouchInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUITouchInfo.html) 用于封装触摸交互过程中的位置信息，记录触摸开始、移动和结束时的屏幕坐标。它通常由 UI 触摸事件回调提供，帮助开发者追踪单次触摸的完整轨迹。

## 适用场景

在 UI 元素的触摸事件处理中，通过回调参数获取 [EUITouchInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUITouchInfo.html) 实例，读取触摸各阶段的位置以响应拖拽、点击或手势操作。

## 使用要点

通过 [EUINodeBase](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUINodeBase.html) 的 OnTouchBegan、OnTouchMoved、OnTouchEnded 事件回调获取 [EUITouchInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUITouchInfo.html) 实例，然后访问其 BeganPosition、MovedPosition、EndedPosition 属性获取对应阶段的触摸位置。

## 注意事项

[EUITouchInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUITouchInfo.html) 不可直接构造，只能从触摸事件回调中获取。TouchID 用于区分多点触摸场景下的不同触摸点。

## 代码示例

### 在触摸回调中读取触点信息

```lua
-- @runtime client
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer == nil then return end
local euiManager = localPlayer.PlayerGui.EuiManager
local rootNode = euiManager:GetRootNode()

rootNode.TouchEnabled = true
rootNode.OnTouchMoved:Once(function(touchInfo, player)
    print("触点:", touchInfo.TouchID)
    print("移动到:", touchInfo.MovedPosition.x, touchInfo.MovedPosition.y)
end)
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `BeganPosition` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | `-` | 触摸开始时的屏幕位置，以 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) 表示。 |
| `MovedPosition` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | `-` | 触摸移动过程中的屏幕位置，以 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) 表示。 |
| `EndedPosition` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | `-` | 触摸结束时的屏幕位置，以 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) 表示。 |
| `TouchID` | `Int` | `-` | 触摸点的唯一标识符，用于区分多点触摸。 |

## 关联类型

* [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)
