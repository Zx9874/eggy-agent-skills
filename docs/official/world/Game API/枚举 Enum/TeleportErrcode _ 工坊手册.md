# TeleportErrcode

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → TeleportErrcode

[TeleportErrcode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TeleportErrcode.html) 枚举定义传送初始化失败或传送结果通知中可能出现的错误码，用于区分成功、失败、地图不存在、服务器已满、权限不足、请求过频、超时等状态。

## 适用场景

监听 TeleportService.TeleportInitFailed 事件时，可从 teleportResult 参数获得该枚举值，并据此提示玩家、记录日志或决定是否重试。

## 使用要点

在 TeleportInitFailed 回调中将 teleportResult 与 Enums.TeleportErrcode.SUCCESS、Enums.TeleportErrcode.GAME\_FULL、Enums.TeleportErrcode.TIMEOUT 等成员比较。

## 注意事项

TeleportService:TeleportAsync 的公开返回值是 [TeleportAsyncResult](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TeleportAsyncResult.html)，不直接声明返回 [TeleportErrcode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TeleportErrcode.html)；错误码主要来自 TeleportInitFailed 事件参数或明确提供错误码的业务封装。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `SUCCESS` | 成功 |
| `1` | `FAILURE` | 失败 |
| `2` | `GAME_NOT_FOUND` | 找不到实例 |
| `3` | `GAME_END` | 实例已经结束 |
| `4` | `GAME_FULL` | 实例玩家已满 |
| `5` | `UNAUTHORIZED` | 未授权的行为 |
| `6` | `FLOODED` | 过于频繁的请求 |
| `7` | `IS_TELEPORTING` | 已经在传送中 |
| `8` | `NOT_IMPLEMENTED` | 未实现的行为 |
| `9` | `TIMEOUT` | 超时 |
| `10` | `ACCESS_DENIED` | 访问权限不匹配 |
