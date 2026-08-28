# Axes

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[Axes](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Axes.html) 是由名称字符串构造的轴/面布尔集合，可读取 x、y、z 与 Top、Bottom、Left、Right、Front、Back 是否启用。

## 适用场景

用于在脚本内部组合并检查一组轴或面标记；当前公开 Surface 没有把 [Axes](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Axes.html) 声明为物理约束、碰撞过滤或角色移动 API 的参数，具体消费入口应以对应 Meta 签名为准。

## 使用要点

通过 Axes.New("Left", "Right") 或 [Axes](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Axes.html)("Left", "Right") 创建值，再读取 x/y/z 或具体面属性。不要把它与 [AxisType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AxisType.html) 枚举或其他 API 的数值轴参数混用。

## 注意事项

可使用 Axes.New(...) 构造，也可使用等价简写 [Axes](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Axes.html)(...)；传入需要启用的轴名称字符串（如 "Left"、"Right"、"Top" 等）。基础轴 x/y/z 为 Bool，当对应方向的面被启用时为 true。例如同时启用 Left 和 Right（都是 X 轴派生），x 为 true；只启用 Left，x 仍为 true。

## 代码示例

### 构造 Axes 并读取轴状态

```lua
-- @runtime client
-- 构造一个 Axes 实例，启用 Left 和 Right 方向
local axes = Axes("Left", "Right")
-- 读取基础轴状态：x 轴被启用（因为 Left/Right 属于 X 轴方向）
print("x 轴启用:", axes.x)   -- true
print("y 轴启用:", axes.y)   -- false
print("z 轴启用:", axes.z)   -- false
-- 读取具体面状态
print("Left 面启用:", axes.Left)   -- true
print("Right 面启用:", axes.Right) -- true
print("Top 面启用:", axes.Top)     -- false
```

## 属性 (9)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `x` | `Bool` | `-` | 表示 X 轴是否启用。 |
| `y` | `Bool` | `-` | 表示 Y 轴是否启用。 |
| `z` | `Bool` | `-` | 表示 Z 轴是否启用。 |
| `Top` | `Bool` | `-` | 表示顶面（Y 轴正方向）是否启用。 |
| `Bottom` | `Bool` | `-` | 表示底面（Y 轴负方向）是否启用。 |
| `Left` | `Bool` | `-` | 表示左面（X 轴负方向）是否启用。 |
| `Right` | `Bool` | `-` | 表示右面（X 轴正方向）是否启用。 |
| `Front` | `Bool` | `-` | 表示前面（Z 轴正方向）是否启用。 |
| `Back` | `Bool` | `-` | 表示后面（Z 轴负方向）是否启用。 |

## 函数 (1)

### New

签名：`New(...: String) -> Axes`

创建一个新的 [Axes](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Axes.html) 对象，通过传入轴名称字符串来指定哪些轴被选中。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `...` | `String` | 轴名称（可变参数） |

**返回值** [Axes](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Axes.html)

> 示例代码

> 构造 Axes 并读取各轴布尔值

```lua
-- @runtime client
-- 通过 Axes.New 创建实例，传入需要启用的轴名称
local axes = Axes.New("Left", "Right", "Top")

-- 派生面：返回 true/false（Bool 类型）
print("Left:", axes.Left)     -- true
print("Right:", axes.Right)   -- true
print("Top:", axes.Top)       -- true
print("Bottom:", axes.Bottom) -- false（未启用）

-- 基础轴 x/y/z 也是 Bool：Left+Right 都启用 → x=true；Top 启用 → y=true
print("x:", axes.x)           -- true（X 轴方向有面启用）
print("y:", axes.y)           -- true（Y 轴方向有面启用）
print("z:", axes.z)           -- false（Z 轴方向无面启用）
```
