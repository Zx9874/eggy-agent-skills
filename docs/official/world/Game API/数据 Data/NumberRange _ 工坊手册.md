# NumberRange

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[NumberRange](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberRange.html) 表示一个由最小值和最大值构成的数值区间，用于限定范围或进行边界检查。通过 NumberRange.New(min, max) 或简写 [NumberRange](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberRange.html)(min, max) 创建实例，可读取 Min 和 Max 属性获取区间端点。

## 适用场景

常用于需要指定数值上下限的场景，例如随机数生成范围、属性值合法区间校验或配置参数的有效边界定义。

## 使用要点

使用 NumberRange.New(1, 10) 或 [NumberRange](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberRange.html)(1, 10) 构造区间对象，然后通过 r.Min 和 r.Max 访问端点值。构造时若最小值大于最大值会触发错误。

## 注意事项

[NumberRange](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberRange.html) 是数值范围对象，通过 NumberRange.New(min, max) 构造。示例代码必须自包含：禁止使用未声明的 player/character/unit 场景变量获取实例。

## 代码示例

### 构造数值范围并读取边界

```lua
-- @runtime client
-- 使用简写形式构造 NumberRange，表示 1 到 10 的闭区间
local range = NumberRange(1, 10)

-- 读取最小值和最大值
local minValue = range.Min  -- 1
local maxValue = range.Max  -- 10

-- 打印验证
print("范围: [" .. minValue .. ", " .. maxValue .. "]")

-- 也可使用 New 方法构造，效果相同
local range2 = NumberRange.New(5, 15)
print("第二个范围: [" .. range2.Min .. ", " .. range2.Max .. "]")
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Min` | `Float` | `-` | 区间的最小值。 |
| `Max` | `Float` | `-` | 区间的最大值。 |

## 函数 (1)

### New

签名：`New(min: Float, max: Float) -> NumberRange`

创建一个新的 [NumberRange](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberRange.html) 实例，表示一个数值区间。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `min` | `Float` | - |
| `max` | `Float` | - |

**返回值** [NumberRange](https://u5-creator.s3.game.163.com/manual/se/game_api/data/NumberRange.html)

> 示例代码

> 构造 NumberRange

```lua
-- @runtime client
local range = NumberRange.New(1, 10)
print(string.format('Min=%.1f Max=%.1f', range.Min, range.Max))
```
