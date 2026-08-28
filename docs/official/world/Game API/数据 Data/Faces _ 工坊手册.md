# Faces

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[Faces](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Faces.html) 是面集合数据类型，用于用面名称字符串选择 Right、Top、Back、Left、Bottom、Front 六个方向中的一个或多个面。

## 适用场景

用于在脚本内部组合并检查一组面标记；当前公开 Surface 没有把 [Faces](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Faces.html) 声明为网格编辑、碰撞过滤或效果配置 API 的参数，具体消费入口应以对应 Meta 签名为准。

## 使用要点

通过 Faces.New(...) 构造实例，参数是面名称字符串可变参数，不是六个布尔值。构造后 Right/Top/Back/Left/Bottom/Front 属性为 Bool，表示对应面是否被选中。

## 注意事项

Faces.New(...) 接收面名称字符串，例如 Faces.New("Right", "Top")；不要把 Right/Top 等 Bool 属性写成字符串。属性只表示是否选中某个面，不能存放颜色、材质或面名称。

## 代码示例

### 用面名称构造 Faces 并读取布尔属性

```lua
-- @runtime client
local faces = Faces.New("Right", "Top")
if faces.Right then
    print("选中了 Right 面")
end
if faces.Top then
    print("选中了 Top 面")
end
print("Front 是否选中:", faces.Front)
```

## 属性 (6)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Right` | `Bool` | `-` | 表示右面是否启用。 |
| `Top` | `Bool` | `-` | 表示顶面是否启用。 |
| `Back` | `Bool` | `-` | 表示背面是否启用。 |
| `Left` | `Bool` | `-` | 表示左面是否启用。 |
| `Bottom` | `Bool` | `-` | 表示底面是否启用。 |
| `Front` | `Bool` | `-` | 表示正面是否启用。 |

## 函数 (1)

### New

签名：`New(...: String) -> Faces`

创建一个新的 [Faces](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Faces.html) 对象，用于表示一组面名称。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `...` | `String` | 面名称（可变参数） |

**返回值** [Faces](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Faces.html)

> 示例代码

> 选择多个面

```lua
-- @runtime client
local faces = Faces.New("Right", "Top", "Front")
print("Right:", faces.Right)
print("Top:", faces.Top)
print("Front:", faces.Front)
```
