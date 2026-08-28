# TextFontType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `String`
* **继承链**: `String` → TextFontType

[TextFontType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TextFontType.html) 枚举定义了文本组件可用的字体样式，包含黑体、圆体、标宋、魏碑等多种中文字体。通过设置 [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 的 FontName 属性或 [EUITextLabel](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUITextLabel.html)/[EUIRichTextLabel](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUIRichTextLabel.html)/[EUIInputField](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUIInputField.html) 的 Font 属性，可以切换文本的显示字体。

## 适用场景

在创建或修改 [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 时，通过将 FontName 属性赋值为 Enums.TextFontType 的某个成员，来改变文本的字体外观。

## 使用要点

直接使用 Enums.TextFontType.YUANTI\_BOLD 这样的形式引用字体枚举值，然后将其赋值给 [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 的 FontName 属性。注意：[TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 用 FontName，而 [EUITextLabel](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUITextLabel.html)/[EUIRichTextLabel](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUIRichTextLabel.html)/[EUIInputField](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUIInputField.html) 用 Font，属性名不同。

## 注意事项

枚举值必须通过 Enums.TextFontType 命名空间访问，不能使用数字或字符串代替。注意属性名差异：TextUnit.FontName vs EUITextLabel.Font（[EUITextLabel](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUITextLabel.html) 没有 FontName 属性）。字体效果受客户端环境支持影响，实际显示可能因平台而异。

## 枚举值

| 名称 | 说明 |
| --- | --- |
| `HKXZYT_W9_GB` | 综艺体 |
| `YUANTI_BOLD` | 粗圆体 |
| `YUANTI_REGULAR` | 细圆体 |
| `BIAOTISONG_W9` | 宋体 |
| `WEIBEI_W7` | 魏碑体 |
| `FZLONGKSXSJW` | 行书 |
| `SHANGSHOUZHUIGUANG` | 手写体 |
