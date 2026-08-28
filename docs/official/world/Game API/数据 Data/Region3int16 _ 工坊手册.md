# Region3int16

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[Region3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3int16.html) 表示由两个 [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html) 角点界定的整数网格三维区域。

## 适用场景

用于需要传递整数坐标区域的场景数据或网格范围配置；具体可传入哪些 API 以对应 API 的 Meta 签名为准。

## 使用要点

先构造 min/max 两个 [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html)，再用 Region3int16.New(min, max) 或 [Region3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3int16.html)(min, max) 创建区域；通过 Min、Max 读取边界。

## 注意事项

[Region3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3int16.html) 由 New(min: [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html), max: [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html)) 构造，min/max 必须是 [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html) 类型，不能传入空字符串。

## 代码示例

### 构造整数网格区域并读取边界

```lua
-- @runtime client
local min = Vector3int16.New(0, 0, 0)
local max = Vector3int16.New(10, 10, 10)
local region = Region3int16.New(min, max)
print(region.Min, region.Max)
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Min` | [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html) | `-` | [Region3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3int16.html) 的最小角，表示区域在三维空间中的最小坐标。 |
| `Max` | [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html) | `-` | [Region3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3int16.html) 的最大角，表示区域在三维空间中的最大坐标。 |

## 关联类型

* [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html)

## 函数 (1)

### New

签名：`New(min: Vector3int16, max: Vector3int16) -> Region3int16`

创建一个新的 [Region3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3int16.html) 实例，使用指定的最小角和最大角。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `min` | [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html) | - |
| `max` | [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html) | - |

**返回值** [Region3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3int16.html)

> 示例代码

> 构造 3D 整数区域

```lua
-- @runtime client
local min = Vector3int16.New(0, 0, 0)
local max = Vector3int16.New(100, 50, 100)
local region = Region3int16.New(min, max)
```
