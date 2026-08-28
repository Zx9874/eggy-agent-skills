# CustomDataService

CustomData 地图自定义数据服务，提供键值对形式的数据存取与删除。 通过 GetService 获取。

## Overview

CustomData 地图自定义数据服务，提供键值对形式的地图数据存取与删除。

**Get by:**

```lua
local service = editor:GetService("CustomDataService")
```

## Public

### GetCustomMapData

获取地图自定义数据

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 数据键名 |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Any` | 键对应的数据值；不存在时返回 nil |

**示例**

```lua
local service = editor:GetService("CustomDataService")
local key = "demo_get_key"

service:SetCustomMapData(key, { level = 10, coins = 100 }) -- 先写入已知数据
local data = service:GetCustomMapData(key) -- 读回并打印字段
print("level:", data and data.level, "coins:", data and data.coins)

service:RemoveCustomMapData(key) -- 清理数据
print("after remove:", service:GetCustomMapData(key))
```

### SetCustomMapData

设置地图自定义数据

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 数据键名 |
| `data` | `Any` | 要写入的数据（任意类型） |

**示例**

```lua
local service = editor:GetService("CustomDataService")
local key = "demo_set_key"

service:SetCustomMapData(key, { name = "tutorial", level = 10, stars = 3 }) -- 写入结构化数据
local data = service:GetCustomMapData(key) -- 读回验证
if data then
    for field, value in pairs(data) do
        print("field:", field, value)
    end
end

service:RemoveCustomMapData(key) -- 清理数据
print("after remove:", service:GetCustomMapData(key))
```

### RemoveCustomMapData

删除地图自定义数据

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 数据键名 |

**示例**

```lua
local service = editor:GetService("CustomDataService")
local key = "demo_remove_key"

service:SetCustomMapData(key, "to_be_removed") -- 写入数据
print("before remove:", service:GetCustomMapData(key))

service:RemoveCustomMapData(key) -- 删除数据
print("after remove:", service:GetCustomMapData(key)) -- 读回验证已删除
```
