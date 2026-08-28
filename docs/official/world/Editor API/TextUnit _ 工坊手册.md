# TextUnit

3D文字组件。通过 World:CreateUnit("TextUnit", {...}) 创建，字段属性可直接读写。

## 概览

3D 文字组件：在场景中展示一段 3D 文字，可配置内容、字体、颜色、对齐、换行、超框滚动、渐变与描边等。

> 继承自 `Unit`；可通过 `World:CreateUnit("TextUnit", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Position` | `Vector3` | - | 文字在场景中的位置。 |
| `Rotation` | `Quaternion` | - | 文字的旋转（四元数）。 |
| `Width` | `Float` | - | 文字框宽度。 |
| `Height` | `Float` | - | 文字框高度。 |
| `Scale` | `Vector3` | - | 文字的缩放。 |
| `Content` | `String` | - | 要展示的文字内容。 |
| `FontName` | `TextFontType` | - | 文字使用的字体。 |
| `FontSize` | `Int` | - | 文字字号。 |
| `Visible` | `Bool` | - | 文字是否可见。 |
| `HoriAlign` | `HorizontalAlignmentType` | - | 文字的水平对齐方式。 |
| `VertAlign` | `VerticalAlignmentType` | - | 文字的垂直对齐方式。 |
| `LineWrap` | `Bool` | - | 文字超出宽度时是否自动换行。 |
| `OverflowStrategy` | `TextOverflowStrategy` | - | 文本超出文字框时的处理策略。 |
| `OverflowScrollSpeed` | `Float` | - | 超框跑马灯滚动速度。取值范围 [-5.0, 5.0]。 |
| `OverflowScrollSpacing` | `Float` | - | 超框跑马灯滚动间距。取值范围 [0.0, 3.0]。 |
| `VerticalDirection` | `Bool` | - | 文字是否纵向排列显示。 |
| `ReverseDirection` | `Bool` | - | 纵向排列时是否从右到左显示。 |
| `LineSpacing` | `Float` | - | 多行文字的行间距。取值范围 [0.0, 2.0]。 |
| `TextSkew` | `Float` | - | 文本倾斜角度（度）。取值范围 [-45.0, 45.0]。 |
| `GradientColorEnable` | `Bool` | - | 是否使用渐变色文字。 |
| `TextColor` | `Color` | - | 文本颜色（未开启渐变时生效）。 |
| `GradientColors` | `Array` | - | 渐变色的颜色列表（开启渐变后生效）。 |
| `GradientAngle` | `Float` | - | 渐变方向角度（度）。取值范围 [0.0, 180.0]。 |
| `OutlineColor` | `Color` | - | 文字描边颜色。 |
| `OutlineWidth` | `Float` | - | 文字描边宽度。取值范围 [0.0, 7.0]。 |
| `BindSocket` | `String` | - | 文字绑定的骨骼挂点名称。 |
