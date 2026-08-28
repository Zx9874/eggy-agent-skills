# TableMajorAxis

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → TableMajorAxis

[TableMajorAxis](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/TableMajorAxis.html) 枚举用于指定表格布局的主轴方向，决定子元素按行优先还是列优先排列。它直接影响 [EUITableLayout](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUITableLayout.html) 等 UI 组件的自动布局行为。

## 适用场景

在配置 [EUITableLayout](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUITableLayout.html) 的 MajorAxis 属性时，通过该枚举选择行优先或列优先的排列方式，以控制 UI 元素的填充顺序。

## 使用要点

通过 Enums.TableMajorAxis.RowMajor 或 Enums.TableMajorAxis.ColumnMajor 引用枚举值，然后将其赋值给 [EUITableLayout](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUITableLayout.html) 的 MajorAxis 属性。

## 注意事项

该枚举仅作为属性值使用，无法直接创建实例。RowMajor 表示先填满一行再换行，ColumnMajor 表示先填满一列再换列。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `RowMajor` | 直接子节点代表行，行内子节点代表单元格 |
| `1` | `ColumnMajor` | 直接子节点代表列，列内子节点代表单元格 |
