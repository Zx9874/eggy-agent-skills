# ThumbnailSize

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → ThumbnailSize

[ThumbnailSize](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/ThumbnailSize.html) 枚举表示 Players:GetUserThumbnailAsync 的名义头像尺寸规格，成员名覆盖 48x48 至 720x720。

## 适用场景

请求玩家头像时，根据 UI 展示区域选择一个命名尺寸成员传给 Players:GetUserThumbnailAsync。

## 使用要点

通过 Enums.ThumbnailSize.Size150x150 等命名成员传参，不要直接传像素数字。

## 注意事项

尺寸成员用于表达请求规格；当前运行时不保证返回图像已按该尺寸裁剪，调用方应由 UI 容器负责缩放，也不要据此推断网络数据量或加载时间一定不同。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `48` | `Size48x48` | 48x48 像素 |
| `50` | `Size50x50` | 50x50 像素 |
| `60` | `Size60x60` | 60x60 像素 |
| `75` | `Size75x75` | 75x75 像素 |
| `100` | `Size100x100` | 100x100 像素 |
| `150` | `Size150x150` | 150x150 像素（默认） |
| `180` | `Size180x180` | 180x180 像素 |
| `352` | `Size352x352` | 352x352 像素 |
| `420` | `Size420x420` | 420x420 像素 |
| `720` | `Size720x720` | 720x720 像素 |
