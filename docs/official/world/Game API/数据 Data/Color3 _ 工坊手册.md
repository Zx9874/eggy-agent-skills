# Color3

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) 是 0 到 1 浮点分量的 RGB 颜色值，支持 RGB/HSV/十六进制构造、颜色空间转换和线性插值。

## 适用场景

当前公开 Surface 明确在 [ColorSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequenceKeypoint.html) 中使用 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)；也可在脚本内部进行 RGB 颜色计算与插值。UI、模型和材质字段若声明为 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)，应使用 0 到 255 的 RGBA [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)，而不是 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)。

## 使用要点

通过 Color3.New(r, g, b)、[Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)(r, g, b)、FromRGB、FromHSV 或 FromHex 创建值；只把它传给 Meta 明确声明 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) 的成员，不要替代 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 类型属性。

## 注意事项

[Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) 实例通过 Color3.New(r, g, b)、[Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)(r, g, b) 或 FromRGB/FromHSV/FromHex 等公开构造/工厂方法获取；r、g、b 分量通常为 0 到 1 的浮点数，FromRGB 接受 0 到 255 的整数。

## 代码示例

### 构造 Color3 并读取分量

```lua
-- @runtime client
local red = Color3.New(1.0, 0.0, 0.0)
-- 读取并打印各分量值
print(string.format("红色分量: r=%.2f, g=%.2f, b=%.2f", red.r, red.g, red.b))
-- 使用简写构造一个蓝色
local blue = Color3(0.0, 0.0, 1.0)
print(string.format("蓝色分量: r=%.2f, g=%.2f, b=%.2f", blue.r, blue.g, blue.b))
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `r` | `Float` | `-` | 颜色的红色分量，取值范围 0 到 1。 |
| `g` | `Float` | `-` | 颜色的绿色分量，取值范围 0 到 1。 |
| `b` | `Float` | `-` | 颜色的蓝色分量，取值范围 0 到 1。 |

## 函数 (7)

### New

签名：`New(r: Float, g: Float, b: Float) -> Color3`

使用 0-1 范围的浮点数 RGB 值创建 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) 实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `r` | `Float` | - |
| `g` | `Float` | - |
| `b` | `Float` | - |

**返回值** [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)

> 示例代码

> 用 RGB 分量构造 Color3

```lua
-- @runtime client
local c = Color3.New(1, 0, 0)  -- 红色（分量范围 0~1）
print(string.format('RGB: %.1f, %.1f, %.1f', c.r, c.g, c.b))
```

### FromRGB

签名：`FromRGB(r: Int, g: Int, b: Int) -> Color3`

根据 0-255 整数 RGB 值创建 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) 实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `r` | `Int` | - |
| `g` | `Int` | - |
| `b` | `Int` | - |

**返回值** [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)

> 示例代码

> 用 0~255 整数 RGB 构造 Color3

```lua
-- @runtime client
local c = Color3.FromRGB(255, 128, 0)  -- 橙色
print(string.format('从 RGB(255,128,0) 构造: r=%.3f g=%.3f b=%.3f', c.r, c.g, c.b))
```

### FromHSV

签名：`FromHSV(h: Float, s: Float, v: Float) -> Color3`

根据色相、饱和度、明度创建 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) 实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `h` | `Float` | 色相 [0, 1] |
| `s` | `Float` | 饱和度 [0, 1] |
| `v` | `Float` | 明度 [0, 1] |

**返回值** [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)

> 示例代码

> 用 HSV 构造 Color3

```lua
-- @runtime client
local c = Color3.FromHSV(0.5, 1.0, 1.0)  -- H=0.5(青色) S=1 V=1
print(string.format('从 HSV 构造: r=%.3f g=%.3f b=%.3f', c.r, c.g, c.b))
```

### FromHex

签名：`FromHex(hex: String) -> Color3`

根据十六进制颜色字符串创建 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) 实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `hex` | `String` | - |

**返回值** [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)

> 示例代码

> 用十六进制颜色码构造 Color3

```lua
-- @runtime client
local c = Color3.FromHex('FF8800')  -- 橙色
print(string.format('从 #FF8800 构造: r=%.3f g=%.3f b=%.3f', c.r, c.g, c.b))
```

### Lerp

签名：`Lerp(other: Color3, alpha: Float) -> Color3`

在当前颜色与目标颜色之间进行线性插值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `other` | [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) | - |
| `alpha` | `Float` | - |

**返回值** [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)

> 示例代码

> 在两个颜色之间进行线性插值

```lua
-- @runtime client
-- 创建起始颜色（红色）和目标颜色（蓝色）
local startColor = Color3(1, 0, 0)
local endColor = Color3(0, 0, 1)
-- 在两者之间进行 50% 的插值
local midColor = startColor:Lerp(endColor, 0.5)
-- 打印插值结果
print("R:", midColor.r, "G:", midColor.g, "B:", midColor.b)
```

### ToHSV

签名：`ToHSV() -> Float, Float, Float (依次返回色相 h、饱和度 s 和明度 v。)`

将当前颜色转换为 HSV 表示，返回色相、饱和度、明度三个值。

**返回值** `Float, Float, Float` (依次返回色相 h、饱和度 s 和明度 v。)

> 示例代码

> 转换为 HSV 分量

```lua
-- @runtime client
local color = Color3.FromRGB(255, 0, 0)
local h, s, v = color:ToHSV()
print('HSV:', h, s, v)
```

### ToHex

签名：`ToHex() -> String`

将当前颜色转换为 6 位大写十六进制字符串（不含 # 前缀）。

**返回值** `String`

> 示例代码

> 将颜色转换为十六进制字符串

```lua
-- @runtime client
-- 创建一个颜色
local color = Color3(1, 0.5, 0)
-- 转换为十六进制字符串（不含 # 前缀）
local hex = color:ToHex()
-- 打印结果
print("Hex:", hex)
```
