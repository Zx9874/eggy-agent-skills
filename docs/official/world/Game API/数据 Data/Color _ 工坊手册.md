# Color

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 是 RGBA 颜色类型，用于表示带透明度的颜色值。它提供红、绿、蓝、不透明度四个分量，并支持颜色插值、分量极值比较等运算。

## 适用场景

常用于设置 UI 元素的颜色属性（如文本颜色、描边颜色、阴影颜色）或光照服务的环境色，通过 Color.New 构造颜色实例后赋值给对应属性。

## 使用要点

通过 Color.New(r, g, b, a) 或简写 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)(r, g, b, a) 创建颜色实例，四个参数均为 0~255 的整数。然后可将实例赋值给 UI 组件的颜色属性，或调用 Intrp、Min、Max 等方法进行颜色运算。

## 注意事项

[Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 是 RGBA 颜色类型，四个分量统一取 0~255 整数（与 SDK ColorUtils.IsValidRGB 一致）：红色=Color.New(255,0,0,255)，半透明绿=Color.New(0,255,0,128)。类型名是 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 不是 ColorType。Color.New 必须传 4 个参数 Color.New(r, g, b, a)，缺省 alpha 会报错或被识别为无效构造。与 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)（RGB 三分量）区分：[LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 的 AmbientColor/[Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 等属性接收 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)，UI 的部分颜色属性可能接收 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)，使用前看清属性类型。

## 代码示例

### 构造 Color 并读写 RGBA 分量

```lua
-- @runtime client
-- 使用 Color.New 构造一个不透明的红色
local red = Color.New(255, 0, 0, 255)
-- 读取各分量并打印
print(string.format("红色: r=%d, g=%d, b=%d, a=%d", red.r, red.g, red.b, red.a))
-- 修改 alpha 分量实现半透明效果
red.a = 128
print(string.format("半透明红色: r=%d, g=%d, b=%d, a=%d", red.r, red.g, red.b, red.a))
-- 使用简写构造一个半透明绿色
local green = Color(0, 255, 0, 128)
print(string.format("半透明绿色: r=%d, g=%d, b=%d, a=%d", green.r, green.g, green.b, green.a))
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `r` | `Float` | `-` | 颜色的红色分量，取值范围为 0 到 255。 |
| `g` | `Float` | `-` | 颜色的绿色分量，取值范围为 0 到 255。 |
| `b` | `Float` | `-` | 颜色的蓝色分量，取值范围为 0 到 255。 |
| `a` | `Float` | `-` | 颜色的不透明度分量，取值范围为 0 到 255。 |

## 函数 (5)

### New

签名：`New(r: Float, g: Float, b: Float, a: Float) -> Color`

创建一个新的 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 实例，指定红、绿、蓝和透明度分量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `r` | `Float` | - |
| `g` | `Float` | - |
| `b` | `Float` | - |
| `a` | `Float` | - |

**返回值** [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)

> 示例代码

> 用 RGBA 构造 Color（必须 4 参数，0-255）

```lua
-- @runtime client
local c = Color.New(255, 0, 0, 255)  -- 不透明红色（必须 4 参数，0-255）
print(string.format('r=%d g=%d b=%d a=%d', c.r, c.g, c.b, c.a))
-- 插值两个颜色
local green = Color.New(0, 255, 0, 255)
local mid = Color.Intrp(c, green, 0.5)
print('中间色:', tostring(mid))
```

### Intrp

签名：`Intrp(lhs: Color, rhs: Color, u: Float) -> Color`

在两个颜色之间进行线性插值，返回插值后的新颜色。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `lhs` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | - |
| `rhs` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | - |
| `u` | `Float` | 插值因子 [0, 1] |

**返回值** [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)

> 示例代码

> 线性插值两个颜色

```lua
-- @runtime client
-- 构造两个颜色
local red = Color(255, 0, 0, 255)   -- 不透明红色
local blue = Color(0, 0, 255, 255)  -- 不透明蓝色
-- 在红色和蓝色之间进行 50% 插值，得到紫色
local purple = Color.Intrp(red, blue, 0.5)
print("插值结果 R:", purple.r, "G:", purple.g, "B:", purple.b, "A:", purple.a)
```

### Step

签名：`Step(lhs: Color, rhs: Color) -> Color`

逐分量进行阶跃比较，若 lhs 分量大于等于 rhs 分量则返回 1，否则返回 0，结果仍为 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 类型。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `lhs` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | - |
| `rhs` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | - |

**返回值** [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)

> 示例代码

> 逐分量阶跃比较

```lua
-- @runtime client
-- 构造两个颜色
local color1 = Color(100, 200, 50, 255)
local color2 = Color(150, 100, 200, 128)
local stepColor = Color.Step(color1, color2)
print("阶跃结果 R:", stepColor.r, "G:", stepColor.g, "B:", stepColor.b, "A:", stepColor.a)
```

### Min

签名：`Min(lhs: Color, rhs: Color) -> Color`

逐分量比较两个颜色，返回每个分量取最小值的新颜色。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `lhs` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | - |
| `rhs` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | - |

**返回值** [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)

> 示例代码

> 逐分量取最小值

```lua
-- @runtime client
-- 构造两个颜色
local color1 = Color(100, 200, 50, 255)
local color2 = Color(150, 100, 200, 128)
-- 逐分量取最小值
local minColor = Color.Min(color1, color2)
print("最小值颜色 R:", minColor.r, "G:", minColor.g, "B:", minColor.b, "A:", minColor.a)
```

### Max

签名：`Max(lhs: Color, rhs: Color) -> Color`

逐分量比较两个颜色，返回每个分量取最大值的新颜色。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `lhs` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | - |
| `rhs` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | - |

**返回值** [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)

> 示例代码

> 逐分量取最大值

```lua
-- @runtime client
-- 构造两个颜色
local color1 = Color(100, 200, 50, 255)
local color2 = Color(150, 100, 200, 128)
-- 逐分量取最大值
local maxColor = Color.Max(color1, color2)
print("最大值颜色 R:", maxColor.r, "G:", maxColor.g, "B:", maxColor.b, "A:", maxColor.a)
```
