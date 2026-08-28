# AssetPermission

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → AssetPermission

[AssetPermission](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AssetPermission.html) 枚举表示从不可用、无访问权到拥有资产的权限等级。

## 适用场景

仅在某个公开 API 或项目契约明确声明 [AssetPermission](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AssetPermission.html) 时，用它表达或比较权限等级。

## 使用要点

通过 Enums.AssetPermission.None、NoAccess、UseView、Edit 或 Own 引用成员。当前公开 Surface 没有直接声明为 [AssetPermission](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AssetPermission.html) 的参数、属性或返回值。

## 注意事项

不要仅凭枚举名称推断 [AssetService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/AssetService.html)、预设链接或其他接口会返回或接受它；实际权限检查应以具体公开 API 的类型契约为准。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `None` | 权限不可用 |
| `1` | `NoAccess` | 无权访问 |
| `2` | `UseView` | 可使用和查看 |
| `3` | `Edit` | 可编辑和发布 |
| `4` | `Own` | 完全控制 |
