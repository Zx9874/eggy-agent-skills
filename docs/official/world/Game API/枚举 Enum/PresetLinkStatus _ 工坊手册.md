# PresetLinkStatus

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → PresetLinkStatus

预设链接状态枚举用于表示预设资源链接的同步状态，帮助判断本地预设是否与源资源保持一致。它提供了四种状态：已是最新、本地已修改、有新版本可用、以及同时存在本地修改和新版本。

## 适用场景

仅在某个公开 API 或项目契约明确声明 [PresetLinkStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PresetLinkStatus.html) 时，用命名枚举成员判断预设同步状态。

## 使用要点

通过 Enums.PresetLinkStatus.UpToDate、Changed、NewVersionAvailable 或 ChangedAndNewVersion 引用成员。当前公开 Surface 没有直接声明为 [PresetLinkStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PresetLinkStatus.html) 的属性、参数或返回值。

## 注意事项

[PresetLink](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PresetLink.html) 类型当前只公开 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 继承成员，没有 Status 属性；不要假设可从 [PresetLink](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PresetLink.html) 读取该枚举。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `UpToDate` | 已是最新版本 |
| `1` | `Changed` | 本地有修改 |
| `2` | `NewVersionAvailable` | 有新版本可用 |
| `3` | `ChangedAndNewVersion` | 本地修改且有新版本 |
