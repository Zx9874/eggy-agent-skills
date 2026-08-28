# UDim2

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[UDim2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim2.html) 表示二维 UI 的位置或尺寸，由水平方向和垂直方向的比例值与像素偏移组合而成。

## 适用场景

在 UI 布局中，当需要同时指定元素的相对比例和绝对像素位置时使用，例如设置 [EUINodeBase](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUINodeBase.html) 的 Position 或 Size 属性。

## 使用要点

通过 UDim2.New(xScale, xOffset, yScale, yOffset) 或简写 [UDim2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim2.html)(...) 构造实例，传入 X 和 Y 方向的缩放与偏移值。也可使用 FromScale 或 FromOffset 快速创建仅含缩放或仅含偏移的尺寸。构造后赋值给 UI 节点的 Position 或 Size 属性。

## 注意事项

Width 和 Height 分别是 x 和 y 的别名，访问时效果相同。Lerp 方法可用于在两个 [UDim2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim2.html) 之间进行线性插值，实现平滑过渡。

## 代码示例

### 构造 UDim2 并读取分量

```lua
-- @runtime client
local pos = UDim2.New(0.5, -50, 0.3, 10)
print(string.format('x.Scale=%.2f x.Offset=%d', pos.x.Scale, pos.x.Offset))
print(string.format('y.Scale=%.2f y.Offset=%d', pos.y.Scale, pos.y.Offset))
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `x` | [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) | `-` | 获取或设置 X 轴的 [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) 值，包含 Scale 和 Offset 分量。 |
| `y` | [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) | `-` | 获取或设置 Y 轴的 [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) 值，包含 Scale 和 Offset 分量。 |
| `Width` | [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) | `-` | 获取或设置 X 轴的 [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) 值，是 x 属性的别名。 |
| `Height` | [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) | `-` | 获取或设置 Y 轴的 [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) 值，是 y 属性的别名。 |

## 关联类型

* [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html)

## 函数 (4)

### New

签名：`New(xScale: Float, xOffset: Int, yScale: Float, yOffset: Int) -> UDim2`

通过指定 X 和 Y 的 Scale 与 Offset 分量创建一个新的 [UDim2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim2.html) 实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `xScale` | `Float` | - |
| `xOffset` | `Int` | - |
| `yScale` | `Float` | - |
| `yOffset` | `Int` | - |

**返回值** [UDim2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim2.html)

> 示例代码

> 构造 UDim2 并读取分量

```lua
-- @runtime client
-- UDim2.New(scaleX, offsetX, scaleY, offsetY)
-- Scale 是相对父容器的比例，可小于 0 或大于 1；Offset 是像素偏移
local pos = UDim2.New(0.5, -50, 0.3, 10)

-- 读取 x 轴（水平）分量
print(string.format('x.Scale=%.2f x.Offset=%d', pos.x.Scale, pos.x.Offset))
-- 读取 y 轴（垂直）分量
print(string.format('y.Scale=%.2f y.Offset=%d', pos.y.Scale, pos.y.Offset))
-- Width 是 x 的别名，Height 是 y 的别名
print('Width == x:', pos.Width == pos.x)
```

### FromScale

签名：`FromScale(x: Float, y: Float) -> UDim2`

通过指定 X 和 Y 的相对比例创建一个 [UDim2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim2.html) 实例，其 Offset 分量均为 0。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `x` | `Float` | - |
| `y` | `Float` | - |

**返回值** [UDim2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim2.html)

> 示例代码

> 仅用 Scale 构造 UDim2

```lua
-- @runtime client
-- FromScale(scaleX, scaleY) — Offset 为 0
local center = UDim2.FromScale(0.5, 0.5)  -- 屏幕正中
print(string.format('居中: x.Scale=%.1f y.Scale=%.1f', center.x.Scale, center.y.Scale))
```

### FromOffset

签名：`FromOffset(x: Int, y: Int) -> UDim2`

通过指定 X 和 Y 的绝对像素偏移量创建一个 [UDim2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim2.html) 实例，其 Scale 分量均为 0。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `x` | `Int` | - |
| `y` | `Int` | - |

**返回值** [UDim2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim2.html)

> 示例代码

> 仅用 Offset 构造 UDim2

```lua
-- @runtime client
-- FromOffset(offsetX, offsetY) — Scale 为 0
local fixed = UDim2.FromOffset(100, 200)  -- 固定像素偏移
print(string.format('固定: x.Offset=%d y.Offset=%d', fixed.x.Offset, fixed.y.Offset))
```

### Lerp

签名：`Lerp(other: UDim2, alpha: Float) -> UDim2`

在当前 [UDim2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim2.html) 与另一个 [UDim2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim2.html) 之间按 alpha 进行线性插值，返回插值结果。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [UDim2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim2.html) | - |
| `alpha` | `Float` | - |

**返回值** [UDim2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim2.html)

> 示例代码

> 在两个 UDim2 之间插值

```lua
-- @runtime client
local start = UDim2.New(0, 0, 0, 0)
local target = UDim2.New(1, 0, 1, 0)
local alpha = 0.5
local lerped = start:Lerp(target, alpha)
print('x.Scale:', lerped.x.Scale, 'x.Offset:', lerped.x.Offset)
print('y.Scale:', lerped.y.Scale, 'y.Offset:', lerped.y.Offset)
```
