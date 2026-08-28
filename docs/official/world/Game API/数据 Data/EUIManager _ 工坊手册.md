# EUIManager

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[EUIManager](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUIManager.html) 是当前玩家 [PlayerGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PlayerGui.html) 上的 UI 管理器，用于读取设备分辨率、获取 UI 根节点、查询 EUI 节点，以及创建包 UI 模块和场景 UI 节点。

## 适用场景

客户端 UI 脚本需要根据屏幕尺寸布局界面、管理当前玩家 UI 树，或创建挂接到场景单位的 UI 标记时使用。

## 使用要点

在客户端通过 Players.LocalPlayer.PlayerGui.EuiManager 获取实例；再调用 GetDeviceResolution、GetRootNode、GetNodesByType 或场景 UI 创建接口。

## 注意事项

[EUIManager](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUIManager.html) 是玩家 UI 树上的 UI 管理器，需从当前玩家的 PlayerGui.EuiManager 获取，不能通过 GetService 获取 [EUIManager](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUIManager.html)，也不能直接构造。普通 EUI 子节点通过 World:CreateUnit 创建时，必须把 Parent 设置为 EUIManager:GetRootNode()；已存在节点可通过 GetRootNode、GetNodesByType、FindFirstChild 查询，场景 UI 节点则使用 [EUIManager](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUIManager.html) 的公开创建接口。

## 代码示例

### 获取当前玩家的 EUIManager

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local euiManager = localPlayer.PlayerGui.EuiManager

local resolution = euiManager:GetDeviceResolution()
print('屏幕尺寸:', resolution.x, resolution.y)
```

## 函数 (9)

### GetDeviceResolution

签名：`GetDeviceResolution() -> Vector2 (屏幕分辨率)`

获取当前设备的屏幕分辨率。

**返回值** [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) (屏幕分辨率)

> 示例代码

> 读取屏幕分辨率

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local euiManager = localPlayer.PlayerGui.EuiManager
local resolution = euiManager:GetDeviceResolution()
print(resolution.x, resolution.y)
```

### GetRootNode

签名：`GetRootNode() -> EUIRootNode (根节点)`

获取 UI 的根节点。

**返回值** [EUIRootNode](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUIRootNode.html) (根节点)

> 示例代码

> 获取 UI 根节点

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local euiManager = localPlayer.PlayerGui.EuiManager
local rootNode = euiManager:GetRootNode()
print(rootNode.Name)
```

### GetNodesByType

签名：`GetNodesByType(unitType: String) -> Array&lt;EUINodeBase&gt; (匹配节点列表)`

根据指定的 UnitType 字符串获取所有匹配的节点，并以数组形式返回匹配节点列表。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `unitType` | `String` | 单元类型(如 "EUIButton") |

**返回值** Array<[EUINodeBase](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUINodeBase.html)> (匹配节点列表)

> 示例代码

> 查询指定类型节点

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local euiManager = localPlayer.PlayerGui.EuiManager
local labels = euiManager:GetNodesByType('EUITextLabel')
print('文本节点数量:', #labels)
```

### CreatePackageUIModuleNode

签名：`CreatePackageUIModuleNode(packageName: String, uiModule: String) -> EUINodeBase (根节点(模块未注册时返回 nil))`

根据传入的 package 名称和 UI 模块名称，创建对应的 package UI 模块节点，并返回该模块的根节点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `packageName` | `String` | 包名 |
| `uiModule` | `String` | UI 模块名 |

**返回值** [EUINodeBase](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUINodeBase.html) (根节点(模块未注册时返回 nil))

> 示例代码

> 创建包 UI 模块节点

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local euiManager = localPlayer.PlayerGui.EuiManager
local node = euiManager:CreatePackageUIModuleNode('MainPackage', 'InventoryPanel')
if node ~= nil then
    print('创建包 UI:', node.Name)
end
```

### GetAllPackageNodes

签名：`GetAllPackageNodes(packageName: String, uiModule: String) -> Array&lt;EUINodeBase&gt; (节点列表)`

获取指定 package 中指定 UI 模块的所有节点，并以数组形式返回节点列表。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `packageName` | `String` | 包名 |
| `uiModule` | `String` | UI 模块名 |

**返回值** Array<[EUINodeBase](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUINodeBase.html)> (节点列表)

> 示例代码

> 获取包 UI 模块节点

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local euiManager = localPlayer.PlayerGui.EuiManager
local nodes = euiManager:GetAllPackageNodes('MainPackage', 'InventoryPanel')
print('包 UI 节点数量:', nodes and #nodes or 0)
```

### CreateSceneNodeAtPosition

签名：`CreateSceneNodeAtPosition(position: Vector3, nodeInfo?: Any) -> EUISceneNode (场景 UI 节点)`

在指定的世界坐标位置创建一个场景 UI 节点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界坐标 |
| `nodeInfo?` | `Any` | 节点信息 |

**返回值** [EUISceneNode](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUISceneNode.html) (场景 UI 节点)

> 示例代码

> 在世界坐标创建场景 UI

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local euiManager = localPlayer.PlayerGui.EuiManager
local position = Vector3.New(0, 3, 0)
local nodeInfo = {}
local sceneNode = euiManager:CreateSceneNodeAtPosition(position, nodeInfo)
print(sceneNode)
```

### CreateSceneUIByPrefabKeyAtPosition

签名：`CreateSceneUIByPrefabKeyAtPosition(prefabKey: Int, position: Vector3) -> EUISceneNode (场景 UI 根节点)`

根据预设 ID 在指定世界坐标位置创建场景 UI。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefabKey` | `Int` | 预设 key |
| `position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界坐标 |

**返回值** [EUISceneNode](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUISceneNode.html) (场景 UI 根节点)

> 示例代码

> 用预设创建场景 UI

```lua
-- @runtime client
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local euiManager = localPlayer.PlayerGui.EuiManager
local prefabKey = 10001
local position = Vector3.New(0, 3, 0)
local sceneNode = euiManager:CreateSceneUIByPrefabKeyAtPosition(prefabKey, position)
print(sceneNode)
```

### CreateSceneNodeAttachUnit

签名：`CreateSceneNodeAttachUnit(Unit: Unit, Socket: String, Offset: Vector3, InheritVisible: Bool, nodeInfo?: Any) -> EUISceneNode (场景 UI 节点)`

创建一个新的场景 UI 节点，并将其挂接到指定单位的指定骨骼挂点上，同时可设置相对偏移量以及是否继承单位的可见性。返回创建好的场景 UI 节点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `Unit` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 挂接单位 |
| `Socket` | `String` | 挂点名 |
| `Offset` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 偏移 |
| `InheritVisible` | `Bool` | 跟随单位可见性 |
| `nodeInfo?` | `Any` | 节点信息 |

**返回值** [EUISceneNode](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUISceneNode.html) (场景 UI 节点)

> 示例代码

> 把场景 UI 挂接到已有单位

```lua
-- @runtime client
local Players = game:GetService('Players')
local World = game:GetService('World')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local euiManager = localPlayer.PlayerGui.EuiManager
local targetUnit = World:FindFirstChild('BillboardAnchor', true)
if targetUnit ~= nil then
    local nodeInfo = {}
    local sceneNode = euiManager:CreateSceneNodeAttachUnit(targetUnit, 'Head', Vector3.New(0, 1, 0), true, nodeInfo)
    print(sceneNode)
end
```

### CreateSceneUIByPrefabKeyAttachUnit

签名：`CreateSceneUIByPrefabKeyAttachUnit(prefabKey: Int, Unit: Unit, Socket: String, Offset: Vector3, InheritVisible: Bool) -> EUISceneNode (场景 UI 根节点)`

根据预设资源 Key 创建一套场景 UI，并将其挂接到指定单位的指定骨骼挂点上，同时可设置相对偏移量以及是否继承单位的可见性。返回创建好的场景 UI 根节点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `prefabKey` | `Int` | 预设 key |
| `Unit` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 挂接单位 |
| `Socket` | `String` | 挂点名 |
| `Offset` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 偏移 |
| `InheritVisible` | `Bool` | 跟随单位可见性 |

**返回值** [EUISceneNode](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUISceneNode.html) (场景 UI 根节点)

> 示例代码

> 用预设创建并挂接场景 UI

```lua
-- @runtime client
local Players = game:GetService('Players')
local World = game:GetService('World')
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local euiManager = localPlayer.PlayerGui.EuiManager
local targetUnit = World:FindFirstChild('BillboardAnchor', true)
if targetUnit ~= nil then
    local sceneNode = euiManager:CreateSceneUIByPrefabKeyAttachUnit(10001, targetUnit, 'Head', Vector3.New(0, 1, 0), true)
    print(sceneNode)
end
```
