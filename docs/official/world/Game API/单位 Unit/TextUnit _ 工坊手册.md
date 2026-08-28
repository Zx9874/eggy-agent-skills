# TextUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[TextUnit]**（26 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

三维文字组件，用于在场景中显示可配置的立体文字。支持调整位置、旋转、缩放、字体、颜色、对齐方式以及超框滚动等丰富属性，可灵活定制文字外观与布局。

## 适用场景

在场景中创建并配置三维文字，例如显示玩家名称、提示信息或装饰性文本，通过设置内容、字体、颜色和布局属性实现多样化的视觉效果。

## 使用要点

通过 game:CreateUnit("TextUnit", config) 或 World:CreateUnit("TextUnit", config) 创建实例，然后直接读写属性如 Content、FontSize、TextColor 等来定制文字。可使用 Enums.HorizontalAlignmentType 和 Enums.VerticalAlignmentType 设置对齐，用 Enums.TextOverflowStrategy 控制超框行为。

## 注意事项

实例必须通过 CreateUnit 创建，不能使用 New 方法。属性修改会立即生效，无需额外刷新。超框滚动策略需配合 OverflowScrollSpeed 和 OverflowScrollSpacing 使用。

## 代码示例

### 创建 3D 文字并设置样式

```lua
-- @runtime client
local world = game:GetService("World")

local textUnit = world:CreateUnit("TextUnit", {
    Content = "欢迎来到关卡",
    Width = 6.0,
    Height = 2.0,
    FontName = Enums.TextFontType.HKXZYT_W9_GB,
    FontSize = 80,
    TextColor = Color.New(255, 230, 120, 255),
    OutlineColor = Color.New(0, 0, 0, 255),
    OutlineWidth = 2.0,
})

textUnit.GradientColorEnable = true
textUnit.GradientColors = {
    Color.New(255, 230, 120, 255),
    Color.New(255, 120, 80, 255),
}
print("文字内容:", textUnit.Content)
```

## 属性 (26)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0.0, 0.0, 0.0]` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 在世界空间中的位置，使用 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 表示三维坐标。 |
| `Rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | `[0.0, 0.0, 0.0, 1.0]` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 在世界空间中的旋转，使用 [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) 表示四元数旋转。 |
| `Width` | `Float` | `5.0` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 文字框的宽度。 |
| `Height` | `Float` | `5.0` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 文字框的高度。 |
| `Scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[1.0, 1.0, 1.0]` | 文本单元的整体缩放比例，使用 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 分别控制 X、Y、Z 三个轴向的缩放。 |
| `Content` | `String` | `""` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 显示的文本内容。 |
| `FontName` | [TextFontType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TextFontType.html) | `Enums.TextFontType.HKXZYT_W9_GB` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 使用的字体名称。 |
| `FontSize` | `Int` | `100` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 的字体大小。 |
| `Visible` | `Bool` | `true` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 是否可见。 |
| `HoriAlign` | [HorizontalAlignmentType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/HorizontalAlignmentType.html) | `Enums.HorizontalAlignmentType.ALIGN_LEFT` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 的水平对齐方式。 |
| `VertAlign` | [VerticalAlignmentType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/VerticalAlignmentType.html) | `Enums.VerticalAlignmentType.ALIGN_TOP` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 的垂直对齐方式。 |
| `LineWrap` | `Bool` | `true` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 是否自动换行。 |
| `OverflowStrategy` | [TextOverflowStrategy](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TextOverflowStrategy.html) | `Enums.TextOverflowStrategy.OVERFLOW_NONE` | 文本超出文字框时的处理策略。 |
| `OverflowScrollSpeed` | `Float` | `2.0` | 跑马灯滚动的速度。 |
| `OverflowScrollSpacing` | `Float` | `0` | 跑马灯滚动时的间距。 |
| `VerticalDirection` | `Bool` | `false` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 是否纵向显示文字。 |
| `ReverseDirection` | `Bool` | `false` | 纵向显示时是否从右到左排列文字。 |
| `LineSpacing` | `Float` | `0.0` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 的行间距。 |
| `TextSkew` | `Float` | `0.0` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 的文本倾斜角度。 |
| `GradientColorEnable` | `Bool` | `false` | 是否启用文本颜色渐变。 |
| `TextColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 文本的填充颜色。 |
| `GradientColors` | Array<[Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)> | `-` | 用于定义文本渐变颜色的颜色列表，配合 GradientColorEnable 属性使用。 |
| `GradientAngle` | `Float` | `0.0` | 文本颜色渐变的角度。 |
| `OutlineColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(0, 0, 0, 255)` | 文本描边的颜色。 |
| `OutlineWidth` | `Float` | `0.0` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 的描边宽度。 |
| `BindSocket` | `String` | `""` | [TextUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TextUnit.html) 绑定的挂点名称。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
* [HorizontalAlignmentType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/HorizontalAlignmentType.html)
* [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)
* [TextFontType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TextFontType.html)
* [TextOverflowStrategy](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TextOverflowStrategy.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
* [VerticalAlignmentType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/VerticalAlignmentType.html)
