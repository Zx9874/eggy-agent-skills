# CoreGuiType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → CoreGuiType

[CoreGuiType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CoreGuiType.html) 枚举定义了可控制显示或隐藏的核心界面控件类型，包括摇杆、跳跃按钮、冲刺按钮、翻滚按钮、举人按钮、战斗按钮、重置按钮、聊天按钮、表情按钮、玩家列表、生命值、背包、聊天框、顶部栏容器、退出菜单、控制栏和表情菜单。通过该枚举，开发者可以精确管理玩家界面上特定控件的可见性。

## 适用场景

常用于在游戏初始化或特定玩法阶段，通过 StarterGui:SetCoreGuiEnabled 方法禁用或启用某些核心控件，例如在投篮小游戏中隐藏跳跃和冲刺按钮。

## 使用要点

通过 Enums.CoreGuiType 引用具体控件，如 Enums.CoreGuiType.JumpButton，然后调用 StarterGui:SetCoreGuiEnabled 方法传入枚举值和布尔值来控制可见性。

## 注意事项

枚举值必须使用 Enums.CoreGuiType.All 格式，禁止使用数字代替。控件可见性设置后立即生效，但需确保在客户端调用。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `All` | 所有CoreGui元素 |
| `1` | `Joystick` | 摇杆控件 |
| `2` | `JumpButton` | 跳跃按钮 |
| `3` | `RollButton` | 滚动按钮 |
| `4` | `RushButton` | 前扑按钮 |
| `5` | `LiftButton` | 举起按钮 |
| `6` | `BattleButton` | 决战技按钮 |
| `7` | `ResetButton` | 复位按钮 |
| `8` | `CommunicateButton` | 沟通按钮 |
| `9` | `EmojiButton` | 表情按钮 |
| `100` | `PlayerList` | 玩家列表 |
| `101` | `Health` | 血条和生命值显示 |
| `102` | `Backpack` | 背包界面 |
| `103` | `Chat` | 聊天界面 |
| `104` | `TopbarContainer` | 右上角设置按钮 |
| `105` | `EscapeMenu` | Escape菜单 |
| `106` | `ControlBar` | 底部控制条（移动端） |
| `107` | `EmotesMenu` | 情感表达界面 |
