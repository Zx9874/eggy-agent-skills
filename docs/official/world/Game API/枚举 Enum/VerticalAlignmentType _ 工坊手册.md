# VerticalAlignmentType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → VerticalAlignmentType

[VerticalAlignmentType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/VerticalAlignmentType.html) 枚举定义 [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 文本的顶部、居中和底部对齐方式。

## 适用场景

创建或配置 [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 时，将命名枚举成员赋给 VertAlign 控制文本垂直对齐。

## 使用要点

使用 Enums.VerticalAlignmentType.ALIGN\_TOP、ALIGN\_MIDDLE 或 ALIGN\_BOTTOM 设置 TextUnit.VertAlign。

## 注意事项

当前 TextUnit.VertAlign 明确声明为 [VerticalAlignmentType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/VerticalAlignmentType.html)。EUI 文本控件的 TextVerticalAlignment/SetTextVerticalAlignment 在 Meta 中仍是 Int，默认值写作 Top；不要擅自把 EUI 接口等同于本枚举。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `ALIGN_TOP` | 顶部对齐 |
| `1` | `ALIGN_MIDDLE` | 中间对齐 |
| `2` | `ALIGN_BOTTOM` | 底部对齐 |
