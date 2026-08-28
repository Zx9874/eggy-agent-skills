# VibrationService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[VibrationService]**（1 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

设备震动服务，用于向指定玩家发送震动反馈指令。通过服务端调用可控制目标玩家设备产生震动，支持自定义震动类型、次数与间隔，实现伤害受击、操作反馈等场景的触感提示。

## 适用场景

典型场景是在玩家受到伤害、完成关键操作或触发特殊事件时，由服务端向对应玩家设备发送震动，增强游戏沉浸感。

## 使用要点

首先通过 game:GetService("VibrationService") 获取服务实例；然后在服务端调用 StartVibration，传入目标 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 以及震动类型、次数和间隔参数即可触发玩家设备震动。

## 注意事项

StartVibration 应在服务端调用，传入目标 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)；客户端震动由内部事件转发到目标玩家设备，设备不支持震动时可能无效果。

## 代码示例

### 玩家加入时触发设备震动

```lua
-- @runtime server
local Players = game:GetService("Players")
local VibrationService = game:GetService("VibrationService")

Players.PlayerAdded:Connect(function(player)
    VibrationService:StartVibration(player, 0, 2, 0.5)
end)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (1)

### StartVibration

签名：`StartVibration(player: Player, vibrateType: Int, vibrateCount: Int, vibrateInterval: Float) -> void`

开始手机震动。为指定玩家触发手机震动，调用时需要提供震动类型、震动次数和震动间隔参数。

⚙ 调用环境：服务端。第一个参数必须是目标 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)，vibrateType 为震动模式，vibrateCount 为次数，vibrateInterval 为两次震动之间的间隔秒数。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `vibrateType` | `Int` | 震动模式 |
| `vibrateCount` | `Int` | 震动次数 |
| `vibrateInterval` | `Float` | 震动间隔 |

**返回值** `void`

> 示例代码

> 服务端向指定玩家发送震动反馈

```lua
-- @runtime server
local VibrationService = game:GetService("VibrationService")

local function notifyHit(player)
    VibrationService:StartVibration(player, 0, 2, 0.25)
end
```
