# MapData

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[MapData]**（8 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[MapData](https://u5-creator.s3.game.163.com/manual/se/game_api/service/MapData.html) 是提供地图配置数据只读访问的全局服务，允许按分区名读取小节数据与字段，查询自定义地图键值，并获取单位与资产资源的配置表。它负责把编辑器里配置的地图数据在运行时交付给逻辑脚本，配合 HasSectionData 可先判断分区是否存在再安全读取。

## 适用场景

在客户端或服务端需要读取地图预设配置时，通过 game:GetService("MapData") 获取服务实例，再按 Section、字段、单位 ID 或资源 ID 查询只读数据。

## 使用要点

先通过 game:GetService("MapData") 获取服务实例，然后用 HasSectionData 判断分区是否存在，再调用 GetSectionData 或 GetSectionField 读取配置。需要单位或资产数据时使用 GetUnitData、GetAllUnitData、GetAssetData 与 GetAssetUnitData，自定义数据用 GetCustomMapData 按键读取。注意接口返回的表可能是 nil，读取前应做空值判断。

## 注意事项

[MapData](https://u5-creator.s3.game.163.com/manual/se/game_api/service/MapData.html) 提供地图配置数据的只读访问。GetSectionData/GetSectionField/GetCustomMapData 可能返回 nil；GetUnitData/GetAllUnitData/GetAssetData/GetAssetUnitData 返回单位或资源配置 table；HasSectionData 返回 Bool。读取结果前应按签名处理 nil，并避免修改返回数据后假定编辑器配置会被写回。

## 代码示例

### 读取地图配置并遍历单位数据

```lua
-- @runtime client
local MapData = game:GetService('MapData')

local sectionName = 'camera_data'
if MapData:HasSectionData(sectionName) then
    local section = MapData:GetSectionData(sectionName)
    print('camera_data:', tostring(section))
end

local count = 0
for unitId, data in pairs(MapData:GetAllUnitData() or {}) do
    count = count + 1
    print('unit:', unitId, data)
end
print('单位数据数量:', count)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (8)

### GetSectionData

签名：`GetSectionData(sectionName: String) -> Table | nil (Section 数据（Lua table），不存在时返回 nil)`

获取地图数据中指定名称的 Section 数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `sectionName` | `String` | Section 属性名（如 "camera\_data", "fog\_data", "camp\_data" 等） |

**返回值** `Table | nil` (Section 数据（Lua table），不存在时返回 nil)

> 示例代码

> 读取地图分区数据

```lua
-- @runtime client
local MapData = game:GetService('MapData')
local section = MapData:GetSectionData('spawn_points')  -- 返回 table
for k, v in pairs(section or {}) do
    print('spawn:', k, v)
end
```

### GetSectionField

签名：`GetSectionField(sectionName: String, fieldName: String) -> Any | nil (字段值，Section 或字段不存在时返回 nil)`

获取指定 Section 中某个字段的值。若 Section 或字段不存在则返回 nil。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `sectionName` | `String` | Section 属性名 |
| `fieldName` | `String` | 字段名 |

**返回值** `Any | nil` (字段值，Section 或字段不存在时返回 nil)

> 示例代码

> 获取 Section 中指定字段的值

```lua
-- @runtime client
-- 获取 MapData 服务实例
local mapData = game:GetService("MapData")

-- 指定 Section 名称和字段名
local sectionName = "service_data_data"
local fieldName = "LightingService"

-- 获取字段值
local fieldValue = mapData:GetSectionField(sectionName, fieldName)

-- 输出获取结果
if fieldValue ~= nil then
    print("字段值获取成功：" .. tostring(fieldValue))
else
    print("字段不存在或值为 nil")
end
```

### HasSectionData

签名：`HasSectionData(sectionName: String) -> Bool (Section 存在且有数据时返回 true)`

检查指定 Section 是否存在且有数据，返回布尔值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `sectionName` | `String` | Section 属性名 |

**返回值** `Bool` (Section 存在且有数据时返回 true)

> 示例代码

> 检查分区是否存在

```lua
-- @runtime client
local MapData = game:GetService('MapData')
local exists = MapData:HasSectionData('spawn_points')  -- 返回 Bool
print('spawn_points 存在:', exists)
```

### GetCustomMapData

签名：`GetCustomMapData(key: String) -> Any (用户自定义地图数据)`

根据键名获取用户自定义的地图数据，返回任意类型的数据。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 用户自定义地图数据的 key |

**返回值** `Any` (用户自定义地图数据)

> 示例代码

> 获取用户自定义地图数据

```lua
-- @runtime client
-- 获取 MapData 服务实例
local mapData = game:GetService("MapData")

-- 指定自定义数据的键
local customKey = "my_custom_setting"

-- 获取自定义地图数据
local customData = mapData:GetCustomMapData(customKey)

-- 输出获取结果
if customData then
    print("自定义数据获取成功，键：" .. customKey)
else
    print("未找到自定义数据，键：" .. customKey)
end
```

### GetUnitData

签名：`GetUnitData(unitId: Int) -> Table (单位数据)`

根据单位 ID 获取该单位的数据，返回一个 Lua table。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `unitId` | `Int` | 单位 ID |

**返回值** `Table` (单位数据)

> 示例代码

> 读取单位数据（并可容错处理缺失）

```lua
-- @runtime client
local mapData = game:GetService('MapData')
local unitId = 1
local ok, unitData = pcall(function()
    return mapData:GetUnitData(unitId)
end)
if ok and unitData then
    print('成功获取单位数据，ID：' .. tostring(unitId))
else
    print('未找到单位数据，ID：' .. tostring(unitId))
end
```

### GetAllUnitData

签名：`GetAllUnitData() -> Table (所有单位数据)`

获取地图中所有单位的数据，返回一个包含所有单位数据的 Lua table。

**返回值** `Table` (所有单位数据)

> 示例代码

> 读取所有单位数据

```lua
-- @runtime client
local MapData = game:GetService('MapData')
local allUnits = MapData:GetAllUnitData()  -- 返回 table
for unitId, data in pairs(allUnits or {}) do
    print('unit:', unitId, data)
end
```

### GetAssetData

签名：`GetAssetData(assetId: String) -> Table | nil (预设数据)`

根据预设资源 ID 获取对应的预设数据，返回一个 Lua table。若预设不存在则返回 nil。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `assetId` | `String` | 资产预设 ID |

**返回值** `Table | nil` (预设数据)

> 示例代码

> 读取业务传入的预设数据

```lua
-- @runtime client
local MapData = game:GetService('MapData')
local function readAssetData(assetId)
    if assetId == nil or assetId == '' then return nil end
    return MapData:GetAssetData(assetId)
end
-- 调用方应传入地图中真实存在的预设 assetId
```

### GetAssetUnitData

签名：`GetAssetUnitData(assetId: String, UnitTypes: String[]) -> Table (目标 UnitType 的数据列表)`

根据预设资源 ID 和单位类型列表，获取该预设下指定类型的所有单位数据，返回一个包含目标 UnitType 数据列表的 table。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `assetId` | `String` | 资产预设 ID |
| `UnitTypes` | `String[]` | 目标 UnitType 列表 |

**返回值** `Table` (目标 UnitType 的数据列表)

> 示例代码

> 读取业务预设中的指定单位数据

```lua
-- @runtime client
local MapData = game:GetService('MapData')
local function readAssetUnits(assetId, unitTypes)
    if assetId == nil or assetId == '' then return {} end
    return MapData:GetAssetUnitData(assetId, unitTypes)
end
-- 调用方应传入真实 assetId 与公开 Unit 类型名列表
```
