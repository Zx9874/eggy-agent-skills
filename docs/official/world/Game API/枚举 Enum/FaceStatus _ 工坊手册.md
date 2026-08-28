# FaceStatus

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `String`
* **继承链**: `String` → FaceStatus

[FaceStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/FaceStatus.html) 枚举定义蛋仔角色可播放的动态表情状态，包含开心、伤心、生气、思考、震惊、大笑、说话等常见表情。

## 适用场景

在需要根据玩法状态切换蛋仔表情时，将该枚举传给 EggyAppearance:SetFaceStatus，例如玩家完成任务后切换为 Enums.FaceStatus.Happy。

## 使用要点

通过 EggyUnit.EggyAppearance 获取外观组件，然后调用 eggyUnit.EggyAppearance:SetFaceStatus(Enums.FaceStatus.Happy) 设置当前动态表情。

## 注意事项

枚举值必须通过 Enums.FaceStatus 命名空间访问。设置表情前需确保蛋仔单位已加载，并且 [EggyAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EggyAppearance.html) 外观组件可用。

## 枚举值

| 名称 | 说明 |
| --- | --- |
| `Bad` | 阴险 |
| `Happy` | 开心 |
| `SpecialIdle` | 专属待机 |
| `Sad` | 伤心 |
| `Angry` | 生气 |
| `Think` | 思考 |
| `Shock` | 震惊 |
| `Confuse` | 疑惑 |
| `Afraid` | 害怕 |
| `Laugh` | 大笑 |
| `Disgusted` | 厌恶 |
| `Expect` | 期待 |
| `Idle` | 待机 |
| `Jump` | 跳跃 |
| `Struggle` | 飞扑 |
| `Speak` | 说话 |
