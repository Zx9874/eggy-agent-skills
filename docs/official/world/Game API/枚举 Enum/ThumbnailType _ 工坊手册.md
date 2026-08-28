# ThumbnailType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → ThumbnailType

[ThumbnailType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ThumbnailType.html) 枚举定义 Players:GetUserThumbnailAsync 可请求的头像缩略图类型。

## 适用场景

在玩家列表、聊天头像或个人信息面板中请求头像图片时，将该枚举作为 thumbnailType 参数传给 Players:GetUserThumbnailAsync。

## 使用要点

调用 Players:GetUserThumbnailAsync(tostring(player.UserId), Enums.ThumbnailType.HeadShot, Enums.ThumbnailSize.Size150x150) 获取指定类型和尺寸的头像缩略图。

## 注意事项

当前枚举值为 HeadShot=1、AvatarBust=2、AvatarThumbnail=3。[ThumbnailType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ThumbnailType.html) 负责头像类型，[ThumbnailSize](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ThumbnailSize.html) 负责图片尺寸。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `1` | `HeadShot` | 头部特写（与 AvatarBust / AvatarThumbnail 首期行为等价） |
| `2` | `AvatarBust` | 半身像（与 HeadShot / AvatarThumbnail 首期行为等价） |
| `3` | `AvatarThumbnail` | 全身头像（与 HeadShot / AvatarBust 首期行为等价） |
