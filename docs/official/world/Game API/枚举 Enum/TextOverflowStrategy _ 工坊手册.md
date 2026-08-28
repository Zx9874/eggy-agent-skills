# TextOverflowStrategy

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → TextOverflowStrategy

[TextOverflowStrategy](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TextOverflowStrategy.html) 枚举定义了文本内容超出显示区域时的三种处理策略。它允许开发者选择不处理溢出、直接截断超出部分，或启用跑马灯滚动效果来完整展示长文本。该枚举通常与 [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 的 OverflowStrategy 属性配合使用，以控制文本的溢出行为。

## 适用场景

在创建 [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 并设置其内容后，当文本长度可能超过显示区域时，通过设置 OverflowStrategy 属性为 [TextOverflowStrategy](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TextOverflowStrategy.html) 的某个枚举值来决定溢出处理方式。例如，在聊天框或公告板中，使用 OVERFLOW\_SCROLL 让长消息自动滚动显示。

## 使用要点

通过 Enums.TextOverflowStrategy 引用枚举值，如 Enums.TextOverflowStrategy.OVERFLOW\_SCROLL。创建 [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 后，直接将其赋值给 [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 的 OverflowStrategy 属性。若使用 OVERFLOW\_SCROLL，还可进一步调整 OverflowScrollSpeed 和 OverflowScrollSpacing 属性来控制滚动效果。

## 注意事项

[TextOverflowStrategy](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TextOverflowStrategy.html) 控制文本超出显示区域时的处理方式。枚举值：OVERFLOW\_NONE(0)=不处理溢出（文本超出区域正常显示）；OVERFLOW\_CUTOFF(1)=截断（超出部分直接裁切不显示）；OVERFLOW\_SCROLL(2)=跑马灯滚动（文本横向滚动显示完整内容，配合 OverflowScrollSpeed/OverflowScrollSpacing 控制滚动速度与间距）。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `OVERFLOW_NONE` | 溢出 |
| `1` | `OVERFLOW_CUTOFF` | 截断 |
| `2` | `OVERFLOW_SCROLL` | 跑马 |
