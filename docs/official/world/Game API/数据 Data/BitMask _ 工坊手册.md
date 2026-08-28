# BitMask

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[BitMask](https://u5-creator.s3.game.163.com/manual/se/game_api/data/BitMask.html) 是用于表示一组布尔标志的位掩码数据类型。

## 适用场景

常用于碰撞过滤、能力开关或多选标志位配置，需要读取一个位掩码值中某个开关状态的场景。

## 使用要点

[BitMask](https://u5-creator.s3.game.163.com/manual/se/game_api/data/BitMask.html) 当前 Meta 标记 creatable=false，不应在作者示例中自行构造；拿到公开 API 返回或回调提供的 [BitMask](https://u5-creator.s3.game.163.com/manual/se/game_api/data/BitMask.html) 后，调用 GetBit(bitIndex) 读取指定位置的布尔状态。

## 注意事项

[BitMask](https://u5-creator.s3.game.163.com/manual/se/game_api/data/BitMask.html) 是位掩码数据结构，通过整数位紧凑存储一组布尔标志。当前公开契约只暴露 GetBit(bitIndex) 读取能力，不暴露作者侧构造入口；bitIndex 从 1 开始（范围 1-64），返回 Bool。

## 代码示例

### 数据示例

```lua
-- @runtime client
local bitMask  -- bitMask 无法直接构造，需通过 API 获取
if bitMask ~= nil then  -- 实例由调用方提供
    local bitIndex = 1  -- Int
    local result = bitMask:GetBit(bitIndex)  -- 返回 Bool
    if result then
        print("调用结果为 true")
    else
        print("调用结果为 false")
    end
end
```

## 函数 (1)

### GetBit

签名：`GetBit(bitIndex: Int) -> Bool (指定位置是否置位。)`

读取指定 bitIndex 位置是否置位。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `bitIndex` | `Int` | 要检查的位序号，从 1 开始，范围 1-64。 |

**返回值** `Bool` (指定位置是否置位。)

> 示例代码

> 调用示例

```lua
-- @runtime client
local bitMask  -- bitMask 无法直接构造，需通过 API 获取
if bitMask ~= nil then  -- 实例由调用方提供
    local bitIndex = 1  -- Int
    local result = bitMask:GetBit(bitIndex)  -- 返回 Bool
    if result then
        print("调用结果为 true")
    else
        print("调用结果为 false")
    end
end
```
