# Rect

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[Rect](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Rect.html) 表示二维平面上的轴对齐矩形区域，由最小角点和最大角点定义边界，并提供 Width、Height 读取区域尺寸。

## 适用场景

用于 UI 布局、二维区域配置或需要传递矩形边界的接口参数。

## 使用要点

使用 Rect.New(minX, minY, maxX, maxY) 或 [Rect](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Rect.html)(minX, minY, maxX, maxY) 构造；通过 Min、Max、Width、Height 读取边界和尺寸。

## 注意事项

矩形实例必须通过 New 方法或简写形式构造，不能直接修改 Min 或 Max 来改变矩形，需要重新创建新实例。Width 和 Height 为只读属性，由 Min 和 Max 计算得出。

## 代码示例

### 构造矩形并读取边界

```lua
-- @runtime client
local rect = Rect.New(10, 20, 100, 80)
print('Min:', rect.Min, 'Max:', rect.Max)
print('Width:', rect.Width, 'Height:', rect.Height)
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Min` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | `-` | 矩形的左上角坐标，类型为 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)。 |
| `Max` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | `-` | 矩形的右下角坐标，类型为 [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)。 |
| `Width` | `Float` | `-` | 矩形的宽度，即右下角 X 坐标与左上角 X 坐标的差值。 |
| `Height` | `Float` | `-` | 矩形的高度，即右下角 Y 坐标与左上角 Y 坐标的差值。 |

## 关联类型

* [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)

## 函数 (1)

### New

签名：`New(minX: Float, minY: Float, maxX: Float, maxY: Float) -> Rect`

创建一个新的 [Rect](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Rect.html) 实例，通过指定左上角和右下角的坐标来定义矩形区域。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `minX` | `Float` | - |
| `minY` | `Float` | - |
| `maxX` | `Float` | - |
| `maxY` | `Float` | - |

**返回值** [Rect](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Rect.html)

> 示例代码

> 构造矩形区域

```lua
-- @runtime client
local r = Rect.New(0, 0, 100, 100)  -- Min=(0,0) Max=(100,100)
print(string.format('Min: %s, Max: %s', tostring(r.Min), tostring(r.Max)))
```
