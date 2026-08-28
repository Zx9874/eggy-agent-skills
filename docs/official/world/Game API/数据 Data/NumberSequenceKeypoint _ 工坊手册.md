# NumberSequenceKeypoint

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

数值序列关键帧用于定义数值序列中的一个关键点，包含时间位置、数值和包络三个参数。它通常与 [NumberSequence](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequence.html) 配合使用，通过多个关键帧来描述数值随时间变化的曲线。

## 适用场景

在需要创建随时间变化的数值曲线时使用，例如粒子效果的尺寸或透明度渐变，通过组合多个关键帧来定义完整的动画曲线。

## 使用要点

通过 NumberSequenceKeypoint.New(time, value, envelope?) 或等价简写创建关键帧；将多个关键帧按时间顺序组成数组，再把数组传给 NumberSequence.New 构造数值序列。

## 注意事项

Time 参数表示关键帧在序列中的时间位置，Value 为对应数值，Envelope 控制曲线在该点的平滑程度。关键帧必须按时间顺序排列，否则可能导致曲线异常。

## 代码示例

### 构造并读取数值序列关键点

```lua
-- @runtime client
-- Time(0~1), Value, Envelope(可选)
local keypoint = NumberSequenceKeypoint.New(0.5, 1.0, 0.2)
print('Time:', keypoint.Time)
print('Value:', keypoint.Value)
print('Envelope:', keypoint.Envelope)
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Time` | `Float` | `-` | 关键帧在数字序列中的时间位置，取值范围通常为 0 到 1。 |
| `Value` | `Float` | `-` | 关键帧在对应时间点上的数值。 |
| `Envelope` | `Float` | `-` | 关键帧的包络值，影响该关键帧两侧数值过渡的平滑程度。 |

## 函数 (1)

### New

签名：`New(time: Float, value: Float, envelope?: Float) -> NumberSequenceKeypoint`

创建一个新的 [NumberSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequenceKeypoint.html) 实例，用于定义数字序列中的一个关键帧。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `time` | `Float` | - |
| `value` | `Float` | - |
| `envelope?` | `Float` | 可选包络值；省略时使用运行时默认值。 |

**返回值** [NumberSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequenceKeypoint.html)

> 示例代码

> 构造数值序列关键点

```lua
-- @runtime client
-- Time(0~1), Value, Envelope(可选)
local kp = NumberSequenceKeypoint.New(0.5, 1.0)
print(string.format('Time=%.2f Value=%.2f', kp.Time, kp.Value))
```
