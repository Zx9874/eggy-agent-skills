# TeleportState

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → TeleportState

传送状态枚举描述了玩家在跨服务器传送过程中所处的各个阶段。它覆盖了从发起请求到最终完成或失败的完整生命周期，帮助开发者在不同阶段执行对应的逻辑处理。

## 适用场景

在监听玩家传送事件时，通过判断传送状态来更新界面提示或控制游戏流程，例如在传送开始时禁用操作、在失败时弹出错误信息。

## 使用要点

通过 Enums.TeleportState.RequestedFromServer 等形式引用具体状态值。在 Player.OnTeleport 事件的回调中，根据传入的 teleportState 参数与枚举值进行比较，以执行相应分支逻辑。

## 注意事项

该枚举的值由传送系统内部产生，开发者无法自行构造。在比较状态时，应始终使用 Enums.TeleportState 前缀，避免直接使用数字或字符串。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `RequestedFromServer` | 服务器请求客户端进行传送 |
| `1` | `Started` | 客户端已开始尝试传送 |
| `2` | `WaitingForServer` | 客户端正在等待服务器对传送请求的响应 |
| `3` | `Failed` | 传送失败 |
| `4` | `InProgress` | 传送当前正在进行中。玩家通常会断开连接并在此之后传送到目的地 |
| `5` | `Finish` | 传送完成 |
