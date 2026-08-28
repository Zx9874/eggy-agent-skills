# UDim

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) 表示一维 UI 尺寸，由比例分量和像素偏移分量组成。它常用于定义界面元素的宽度或高度，允许同时按父容器比例和固定像素值来灵活布局。

## 适用场景

在设置 UI 元素的尺寸或位置时，使用 [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) 可以混合相对比例与绝对像素值，例如让一个按钮宽度占父容器的一半并额外偏移 10 像素。

## 使用要点

通过 UDim.New(scale, offset) 或简写 [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html)(scale, offset) 创建实例，然后访问其 Scale 和 Offset 属性。可将 [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) 实例赋值给 UI 节点的尺寸或位置相关属性。

## 注意事项

[UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) 实例通过 UDim.New(scale, offset) 或 [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html)(scale, offset) 构造。Scale 表示相对比例，Offset 表示像素偏移，两者共同决定最终尺寸。

## 代码示例

### 构造 UDim 并读取分量

```lua
-- @runtime client
local size = UDim.New(0.5, 20)
print(string.format('Scale=%.2f Offset=%d', size.Scale, size.Offset))
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Scale` | `Float` | `-` | [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) 的比例分量，表示相对于父容器尺寸的比例。 |
| `Offset` | `Int` | `-` | [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) 的偏移分量，以像素为单位。 |

## 函数 (1)

### New

签名：`New(scale: Float, offset: Int) -> UDim`

创建一个新的 [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html) 实例，同时指定其 Scale（比例）和 Offset（偏移）值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `scale` | `Float` | - |
| `offset` | `Int` | - |

**返回值** [UDim](https://u5-creator.s3.game.163.com/manual/se/game_api/data/UDim.html)

> 示例代码

> 构造 UDim

```lua
-- @runtime client
local size = UDim.New(0.5, 20)
print(string.format('Scale=%.2f Offset=%d', size.Scale, size.Offset))
```
