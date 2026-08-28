# FieldOfViewMode

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → FieldOfViewMode

[FieldOfViewMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/FieldOfViewMode.html) 枚举定义了摄像机视场角的计算基准，决定视野范围以哪个轴向为准。它提供 Vertical、Diagonal 和 MaxAxis 三种模式，用于控制画面中可见区域的宽窄。

## 适用场景

在配置 [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) 的 [FieldOfViewMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/FieldOfViewMode.html) 属性时使用，例如需要根据屏幕宽高比调整视野，或实现特定透视效果时切换计算方式。

## 使用要点

通过 Enums.FieldOfViewMode.Vertical 等形式引用枚举值，然后赋值给 [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) 的 [FieldOfViewMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/FieldOfViewMode.html) 属性。例如：cameraUnit.FieldOfViewMode = Enums.FieldOfViewMode.Vertical。

## 注意事项

该枚举仅用于 [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) 的 [FieldOfViewMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/FieldOfViewMode.html) 属性，不能用于其他类型。修改该值会立即影响摄像机的视野计算，无需额外刷新。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Vertical` | Vertical |
| `1` | `Diagonal` | Diagonal |
| `2` | `MaxAxis` | MaxAxis |
