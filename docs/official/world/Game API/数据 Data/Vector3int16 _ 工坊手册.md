# Vector3int16

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

三维整数向量，使用 16 位整数存储 X、Y、Z 分量。常用于表示网格坐标、区块索引或离散空间位置，确保数值为整数且范围受限于 16 位。

## 适用场景

常用于表示体素坐标、区块索引或整数网格位置，例如作为 [Region3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Region3int16.html) 的 min/max 边界；其他 API 是否接收该类型以对应 Meta 签名为准。

## 使用要点

通过 Vector3int16.New(x, y, z) 或 [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html)(x, y, z) 创建实例；公开 Meta 未将 x、y、z 标记为只读，可直接读取或赋值。

## 注意事项

[Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html) 是 16 位整数三维向量。x、y、z 是公开可写属性；editable 等编辑器配置不代表 Lua 侧只读。

## 代码示例

### 构造 Vector3int16 并读写分量

```lua
-- @runtime client
local vec = Vector3int16.New(10, 20, 30)
print(string.format('x=%d y=%d z=%d', vec.x, vec.y, vec.z))

vec.x = vec.x + 1
vec.y = vec.y + 2
vec.z = vec.z + 3
print(string.format('updated: x=%d y=%d z=%d', vec.x, vec.y, vec.z))
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `x` | `Int` | `-` | [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html) 的 X 分量，整数类型。 |
| `y` | `Int` | `-` | [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html) 的 Y 分量，整数类型。 |
| `z` | `Int` | `-` | [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html) 的 Z 分量，整数类型。 |

## 函数 (1)

### New

签名：`New(x: Int, y: Int, z: Int) -> Vector3int16`

创建一个新的 [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html) 实例，使用三个整数分量 x、y、z 进行初始化。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `x` | `Int` | - |
| `y` | `Int` | - |
| `z` | `Int` | - |

**返回值** [Vector3int16](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3int16.html)

> 示例代码

> 构造 Vector3int16

```lua
-- @runtime client
local vec = Vector3int16.New(10, 20, 30)
print(string.format('x=%d y=%d z=%d', vec.x, vec.y, vec.z))
```
