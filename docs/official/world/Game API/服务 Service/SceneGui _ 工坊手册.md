# SceneGui

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[SceneGui]**（1 属性 / 2 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

场景用户界面管理服务，负责将界面元素挂载到三维世界坐标中，使 UI 能与地图场景和单位相结合。通过该服务可创建固定在指定位置的场景节点，也可创建绑定到具体单位的跟随节点，并提供访问场景 EUI 管理器的入口，便于统一管理场景内的界面节点。

## 适用场景

适用于在三维世界中展示信息面板、名称标签或交互提示等界面内容的玩法，当界面需要跟随单位移动或锚定在世界坐标时使用。

## 使用要点

先通过 game:GetService("SceneGui") 获取服务实例，再根据需求调用 CreateSceneNodeAtPosition 传入世界坐标位置，或调用 CreateSceneNodeAttachUnit 传入目标单位、挂点名称、偏移量与继承可见性参数来创建场景节点。创建完成后向返回的节点添加可见的 EUI 子控件并设置可见属性，即可在场景中显示。

## 注意事项

CreateSceneNodeAtPosition/CreateSceneNodeAttachUnit 创建的 SceneNode 是 UI 容器节点，本身没有可见外观——必须向其添加 EUI 控件子节点（如 [EUITextLabel](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUITextLabel.html)/[EUIImage](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUIImage.html)）并设置可见属性后才会显示。创建后若屏幕上看不到表现，请检查：1) 父 SceneNode 是否 Visible=true；2) 是否已添加可见子控件；3) 子控件的 Position/Size 是否在屏幕范围内。

## 代码示例

### 创建场景 UI 节点并安全附着到角色

```lua
-- @runtime client
local World = game:GetService("World")
local SceneGui = game:GetService('SceneGui')
local Players = game:GetService('Players')
local localPlayerRef = Players.LocalPlayer
if localPlayerRef == nil then return end
local rootNode = localPlayerRef.PlayerGui.EuiManager:GetRootNode()

local nodeInfo = {}
local worldNode = SceneGui:CreateSceneNodeAtPosition(Vector3.New(0, 5, 0), nodeInfo)
if worldNode ~= nil then
    worldNode.Visible = true
    local worldLabel = World:CreateUnit("EUITextLabel", { Parent = rootNode })
    if worldLabel ~= nil then
        worldLabel.Parent = worldNode
        worldLabel.Text = '世界坐标提示'
        worldLabel.FontSize = 24
    end
    print('世界坐标场景 UI 路径:', worldNode:GetFullPath())
end

local localPlayer = Players.LocalPlayer
local character = localPlayer ~= nil and localPlayer.Character or nil
if character ~= nil then
    local attachedNode = SceneGui:CreateSceneNodeAttachUnit(
        character, 'Head', Vector3.New(0, 2, 0), true, nodeInfo)
    if attachedNode ~= nil then
        attachedNode.Visible = true
        local attachedLabel = World:CreateUnit("EUITextLabel", { Parent = rootNode })
        if attachedLabel ~= nil then
            attachedLabel.Parent = attachedNode
            attachedLabel.Text = '角色头顶提示'
            attachedLabel.FontSize = 24
        end
        print('角色挂载场景 UI 路径:', attachedNode:GetFullPath())
    end
else
    print('本地玩家角色尚未创建，跳过角色挂载示例')
end
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `EuiManager` | [EUIManager](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUIManager.html) | `-` | 获取 [SceneGui](https://u5-creator.s3.game.163.com/manual/se/game_api/service/SceneGui.html) 关联的 EUI 管理器实例。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [EUIManager](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUIManager.html)

## 函数 (2)

### CreateSceneNodeAtPosition

签名：`CreateSceneNodeAtPosition(position: Vector3, nodeInfo?: Table) -> EUISceneNode (创建的场景 UI 节点；调用前需确保 EuiManager 可用)`

在指定的世界坐标位置创建一个场景 UI 节点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 3D世界坐标位置 |
| `nodeInfo?` | `Table` | 可选的节点配置信息 |

**返回值** [EUISceneNode](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUISceneNode.html) (创建的场景 UI 节点；调用前需确保 EuiManager 可用)

> 示例代码

> 在世界坐标创建场景 UI 节点

```lua
-- @runtime client
local Players = game:GetService("Players")
local World = game:GetService("World")
local localPlayer = Players.LocalPlayer
if localPlayer == nil then return end
local rootNode = localPlayer.PlayerGui.EuiManager:GetRootNode()
local sceneGui = game:GetService('SceneGui')
local nodeInfo = {}
local worldPos = Vector3.New(0, 5, 0)

local sceneNode = sceneGui:CreateSceneNodeAtPosition(worldPos, nodeInfo)
if sceneNode ~= nil then
    sceneNode.Visible = true
    local label = World:CreateUnit("EUITextLabel", { Parent = rootNode })
    if label ~= nil then
        label.Parent = sceneNode
        label.Text = '场景提示'
        label.FontSize = 24
    end
    print('场景 UI 路径:', sceneNode:GetFullPath())
end
```

### CreateSceneNodeAttachUnit

签名：`CreateSceneNodeAttachUnit(Unit: Unit, Socket: String, Offset: Vector3, InheritVisible: Bool, nodeInfo?: Table) -> EUISceneNode (创建的场景 UI 节点；调用前需确保 EuiManager 可用)`

在指定单位上创建一个场景 UI 节点，并将节点绑定到该单位的指定挂点，使 UI 元素跟随单位移动和旋转。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `Unit` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | 挂接单位 |
| `Socket` | `String` | 挂点名称 |
| `Offset` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 相对挂点的偏移 |
| `InheritVisible` | `Bool` | 是否跟随单位可见性 |
| `nodeInfo?` | `Table` | 可选的节点配置信息 |

**返回值** [EUISceneNode](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EUISceneNode.html) (创建的场景 UI 节点；调用前需确保 EuiManager 可用)

> 示例代码

> 把场景 UI 节点挂到角色头顶

```lua
-- @runtime client
local Players = game:GetService("Players")
local World = game:GetService("World")
local localPlayerRef = Players.LocalPlayer
if localPlayerRef == nil then return end
local rootNode = localPlayerRef.PlayerGui.EuiManager:GetRootNode()
local sceneGui = game:GetService('SceneGui')
local players = game:GetService('Players')
local localPlayer = players.LocalPlayer
local targetUnit = localPlayer ~= nil and localPlayer.Character or nil

if targetUnit ~= nil then
    local nodeInfo = {}
    local sceneNode = sceneGui:CreateSceneNodeAttachUnit(targetUnit, 'Head', Vector3.New(0, 2, 0), true, nodeInfo)
    if sceneNode ~= nil then
        sceneNode.Visible = true
        local label = World:CreateUnit("EUITextLabel", { Parent = rootNode })
        if label ~= nil then
            label.Parent = sceneNode
            label.Text = '角色头顶提示'
            label.FontSize = 24
        end
        print('已挂接场景 UI 路径:', sceneNode:GetFullPath())
    end
end
```
