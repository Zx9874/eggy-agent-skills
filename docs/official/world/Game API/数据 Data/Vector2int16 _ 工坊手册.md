# Vector2int16

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[Vector2int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2int16.html) 表示由两个 16 位整数构成的二维向量，常用于网格坐标、区块索引或离散位置表示。它提供简洁的 x、y 分量读写，并支持通过 New 方法快速构造实例。

## 适用场景

用于需要 16 位整数精度的二维离散坐标或网格索引；具体可传入哪些 API 以对应 API 的 Meta 签名为准。[Region3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3int16.html) 的边界类型是 [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html)，不是 [Vector2int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2int16.html)。

## 使用要点

通过 Vector2int16.New(x, y) 或 [Vector2int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2int16.html)(x, y) 创建实例；公开 Meta 未将 x、y 标记为只读，可直接读取或赋值。

## 注意事项

[Vector2int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2int16.html) 是 16 位整数二维向量。x、y 是公开可写属性；editable 等编辑器配置不代表 Lua 侧只读。

## 代码示例

### 构造 Vector2int16 并读写分量

```lua
-- @runtime client
local vec = Vector2int16.New(3, 5)
print(string.format('x=%d y=%d', vec.x, vec.y))

vec.x = vec.x + 1
vec.y = vec.y + 2
print(string.format('updated: x=%d y=%d', vec.x, vec.y))
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `x` | `Int` | `-` | [Vector2int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2int16.html) 的 X 分量，整数类型。 |
| `y` | `Int` | `-` | [Vector2int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2int16.html) 的 Y 分量，整数类型。 |

## 函数 (1)

### New

签名：`New(x: Int, y: Int) -> Vector2int16`

构造一个新的 [Vector2int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2int16.html) 实例，使用指定的 x 和 y 整数分量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `x` | `Int` | - |
| `y` | `Int` | - |

**返回值** [Vector2int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2int16.html)

> 示例代码

> 构造 Vector2int16

```lua
-- @runtime client
local vec = Vector2int16.New(3, 5)
print(string.format('x=%d y=%d', vec.x, vec.y))
```
