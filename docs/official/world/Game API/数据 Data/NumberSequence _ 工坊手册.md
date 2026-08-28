# NumberSequence

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[NumberSequence](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequence.html) 表示一段随归一化时间变化的数值曲线，可用单个常量值或关键帧数组构造，并通过 Keypoints 读取生成的关键帧。

## 适用场景

在需要定义数值随时间变化的曲线时使用，例如设置粒子系统的生命周期大小变化或动画中的透明度渐变。

## 使用要点

使用 NumberSequence.New(value) 创建数值序列；value 可传单个常量值，或由 [NumberSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequenceKeypoint.html) 组成的数组。也可写成等价的 [NumberSequence](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequence.html)(value) 简写。

## 注意事项

Keypoints 是构造后得到的关键帧数组；修改曲线时重新创建 [NumberSequence](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequence.html) 实例。公开 Meta 仅声明 value 单参数形态，文档和示例不扩展未声明的多参数重载。

## 代码示例

### 构造数值序列并读取关键帧

```lua
-- @runtime client
local sequence = NumberSequence.New({
    NumberSequenceKeypoint.New(0, 0.2),
    NumberSequenceKeypoint.New(1, 0.8),
})
for index, keypoint in ipairs(sequence.Keypoints) do
    print(index, keypoint.Time, keypoint.Value, keypoint.Envelope)
end
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Keypoints` | Array<[NumberSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequenceKeypoint.html)> | `-` | [NumberSequence](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequence.html) 中包含的关键帧列表，每个关键帧是一个 [NumberSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequenceKeypoint.html) 对象，定义了特定时间点的数值和可选包络。 |

## 关联类型

* [NumberSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequenceKeypoint.html)

## 函数 (1)

### New

签名：`New(value: Any) -> NumberSequence`

创建一个新的 [NumberSequence](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequence.html) 实例，用于描述数值随时间变化的序列。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `value` | `Any` | 单个常量值，或由 [NumberSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequenceKeypoint.html) 组成的关键帧数组。 |

**返回值** [NumberSequence](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberSequence.html)

> 示例代码

> 用关键帧构造数值序列

```lua
-- @runtime client
local sequence = NumberSequence.New({
    NumberSequenceKeypoint.New(0, 0.2),
    NumberSequenceKeypoint.New(1, 0.8),
})
print('关键帧数量:', #sequence.Keypoints)
```
