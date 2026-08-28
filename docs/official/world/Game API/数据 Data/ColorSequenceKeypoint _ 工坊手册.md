# ColorSequenceKeypoint

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

颜色序列关键帧用于定义颜色渐变序列中某一时刻的颜色值。它由时间位置和对应的颜色组成，是构建 [ColorSequence](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequence.html) 的基础元素。

## 适用场景

在需要创建颜色渐变效果时，通过 [ColorSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequenceKeypoint.html) 指定关键时间点的颜色，再将这些关键帧组合成 [ColorSequence](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequence.html) 用于粒子特效、UI 动画或材质颜色变化。

## 使用要点

使用 ColorSequenceKeypoint.New(time, color) 或简写 [ColorSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequenceKeypoint.html)(time, color) 创建实例，其中 time 为 0 到 1 的浮点数，color 为 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) 对象。然后将多个关键帧按时间升序放入表，传递给 ColorSequence.New 构造完整渐变序列。

## 注意事项

Time 取值范围 0~1，且序列内关键帧应按时间升序排列。属性创建后只读，不可通过 keypoint.Time=... 或 keypoint.Value=... 修改；如需变更请重新构造实例。

## 代码示例

### 构造 ColorSequenceKeypoint 并读取属性

```lua
-- @runtime client
-- 构造一个 ColorSequenceKeypoint 实例，时间点 0.5，颜色为红色
local keypoint = ColorSequenceKeypoint(0.5, Color3(1, 0, 0))
-- 读取时间属性
local time = keypoint.Time
-- 读取颜色属性
local color = keypoint.Value
-- 打印属性值以验证构造结果
print(string.format("时间: %.2f, 颜色: (%.2f, %.2f, %.2f)", time, color.r, color.g, color.b))
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Time` | `Float` | `-` | 关键帧所在的时间点，取值范围通常为 0 到 1，表示在颜色序列中的相对位置。 |
| `Value` | [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) | `-` | 关键帧的颜色值，类型为 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)。 |

## 关联类型

* [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)

## 函数 (1)

### New

签名：`New(time: Float, color: Color3) -> ColorSequenceKeypoint`

创建一个新的 [ColorSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequenceKeypoint.html) 实例，用于定义颜色序列中的一个关键帧。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `time` | `Float` | - |
| `color` | [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) | - |

**返回值** [ColorSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequenceKeypoint.html)

> 示例代码

> 构造颜色序列关键点

```lua
-- @runtime client
local kp = ColorSequenceKeypoint.New(0.5, Color3.New(1, 0, 0))
print(string.format('Time=%.2f', kp.Time))
```
