# HorizontalAlignmentType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → HorizontalAlignmentType

[HorizontalAlignmentType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/HorizontalAlignmentType.html) 枚举定义 [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 文本的左对齐、居中和右对齐方式。

## 适用场景

创建或配置 [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 时，将命名枚举成员赋给 HoriAlign 控制文本水平对齐。

## 使用要点

使用 Enums.HorizontalAlignmentType.ALIGN\_LEFT、ALIGN\_CENTER 或 ALIGN\_RIGHT 设置 TextUnit.HoriAlign。

## 注意事项

当前 TextUnit.HoriAlign 明确声明为 [HorizontalAlignmentType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/HorizontalAlignmentType.html)。EUI 文本控件的 TextHorizontalAlignment/SetTextHorizontalAlignment 在 Meta 中仍是 Int，默认值写作 Left；不要擅自把 EUI 接口等同于本枚举。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `ALIGN_LEFT` | 左对齐 |
| `1` | `ALIGN_CENTER` | 居中对齐 |
| `2` | `ALIGN_RIGHT` | 右对齐 |
