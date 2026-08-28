# ColorSequence

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

颜色序列用于定义随时间或进度变化的颜色渐变。它通过一组关键帧来插值生成中间颜色，常用于粒子效果、UI 动画或材质属性动态过渡。

## 适用场景

在需要颜色平滑过渡的场景中使用，例如设置特效的颜色变化、制作 UI 元素的渐变色动画，或为材质参数提供动态颜色值。

## 使用要点

通过 ColorSequence.New 构造实例，可传入单个 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) 创建纯色序列，或传入起始和结束 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) 创建两色渐变，最常用的是传入 [ColorSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequenceKeypoint.html) 数组实现多关键帧渐变。构造后通过 Keypoints 属性获取关键帧列表。

## 注意事项

ColorSequence.New 支持三种重载：(1) 单个 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)；(2) 起始 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) + 结束 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)；(3) [ColorSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequenceKeypoint.html) 数组。第三种最常用——把多个 [ColorSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequenceKeypoint.html) 放进数组传入。注意重载(2)的两个参数都是 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)，不是 [ColorSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequenceKeypoint.html)。

## 代码示例

### 用关键帧数组构造颜色序列

```lua
-- @runtime client
local colorSeq = ColorSequence.New({
    ColorSequenceKeypoint.New(0, Color3.New(1, 0, 0)),  -- 起始红色
    ColorSequenceKeypoint.New(1, Color3.New(0, 0, 1)),  -- 结束蓝色
})
print('关键帧数:', #colorSeq.Keypoints)
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Keypoints` | Array<[ColorSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequenceKeypoint.html)> | `-` | 获取 [ColorSequence](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequence.html) 中的关键帧列表，每个关键帧是一个 [ColorSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequenceKeypoint.html) 对象，包含时间点和对应的颜色值。 |

## 关联类型

* [ColorSequenceKeypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequenceKeypoint.html)

## 函数 (1)

### New

签名：`New(color: Any) -> ColorSequence`

创建一个新的 [ColorSequence](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequence.html) 实例。可以传入单个 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) 值来创建均匀颜色序列，也可以传入两个 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) 值来创建从第一个颜色渐变到第二个颜色的序列。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `color` | `Any` | 颜色或关键帧数组 |

**返回值** [ColorSequence](https://u5-creator.s3.game.163.com/manual/se/game_api/data/ColorSequence.html)

> 示例代码

> 用关键帧数组构造颜色序列

```lua
-- @runtime client
local colorSeq = ColorSequence.New({
    ColorSequenceKeypoint.New(0, Color3.New(1, 0, 0)),
    ColorSequenceKeypoint.New(1, Color3.New(0, 0, 1)),
})
print('关键帧数:', #colorSeq.Keypoints)
```
