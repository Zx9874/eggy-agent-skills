# World

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
    - [ModelUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html)（4 属性 / 1 函数）
      * [WorldRoot](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldRoot.html)
        + **[World]**（1 属性 / 4 函数）

### 继承成员

3 个来源 / 11 属性 / 35 函数 / 6 事件

* 来自 [ModelUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html)（4 属性 / 1 函数）
  + 属性：[`PrimaryPart`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html#properties)、[`WorldPivot`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html#properties)、[`Position`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html#properties)、[`Rotation`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html#properties)
  + 函数：[`MoveTo`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html#functions)
* 来自 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
  + 属性：[`Tags`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`EcaPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`Owner`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)
  + 函数：[`HasTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`AddTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`RemoveTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`GetPivot`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`PivotTo`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`ApplyPivotDelta`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`TranslateBy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`IsTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`FindTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html) 是承载整个 3D 世界的核心服务，所有需要参与渲染与物理模拟的单位（如 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)、[ModelUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html)、[EffectUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EffectUnit.html)）都必须挂载到 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html) 层级下才会被激活。它负责创建单位、加载资源、提供服务器时间，并允许监听世界级别的自定义事件，同时通过 CurrentCamera 暴露当前相机对象。

## 适用场景

在客户端或服务端需要创建并挂载场景单位、加载预设资源、读取服务器时间或获取自定义事件信号时，通过 game:GetService("World") 获取世界根容器。

## 使用要点

先获取 local world = game:GetService("World")，再调用 world:CreateUnit(unitType, values)。World:CreateUnit 与全局 game:CreateUnit 的 Parent 规则不同，不要混写 receiver。

## 注意事项

World:CreateUnit 在 values 省略 Parent 时会把新单位默认挂载到当前 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)；若需要挂到其他容器，应显式传入 Parent。全局 game:CreateUnit 不会自动设置 Parent，使用时通常需显式指定。单位从 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html) 树移除后会停止渲染和物理模拟，重新挂载后可恢复。

## 代码示例

### 创建临时单位并读取服务器时间

```lua
-- @runtime client
local world = game:GetService('World')
local unit = world:CreateUnit('WorldUnit', {
    Name = 'TemporaryWorldUnit',
    Position = Vector3.New(0, 5, 0),
})
if unit ~= nil then print('单位创建成功:', unit.Name) end
print('当前服务器时间:', world:GetServerTime())
if unit ~= nil then unit:Destroy() end
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `CurrentCamera` | [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) | `-` | 当前激活的相机实例。 |

## 关联类型

* [WorldRoot](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldRoot.html)
* [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html)

## 函数 (4)

### CreateUnit

签名：`CreateUnit(unitType: String, values: Table) -> Unit (新创建的单位实例)`

根据指定的单位类型和初始化配置，在场景中创建一个新的单位实例，并返回该实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `unitType` | `String` | 要创建的单位类型名称，如 "WorldUnit"、"ModelUnit"、"EffectUnit" 等 |
| `values` | `Table` | 初始化属性键值表。省略 Parent 时默认挂载到当前 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)；若需挂到其他容器，应显式传入 Parent。可填写字段以目标 unitType 及其继承链的公开属性为准。 |

**返回值** [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) (新创建的单位实例)

> 示例代码

> 创建并清理临时世界单位

```lua
-- @runtime client
local world = game:GetService('World')
local unit = world:CreateUnit('WorldUnit', { Name = 'TemporaryUnit' })
if unit ~= nil then
    print('已创建:', unit.Name)
    unit:Destroy()
end
```

### CreateAsset

签名：`CreateAsset(assetId: String) -> Array&lt;Unit&gt; (Units)`

根据传入的资源 ID 加载对应的资源，并返回由该资源生成的一组单位实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `assetId` | `String` | 资产预设ID |

**返回值** Array<[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)> (Units)

> 示例代码

> 加载预设并清理本次创建的单位

```lua
-- @runtime client
local world = game:GetService('World')
local function loadAndInspectAsset(assetId)
    if assetId == nil or assetId == '' then return end
    local units = world:CreateAsset(assetId)
    print('加载单位数量:', units and #units or 0)
    for _, unit in ipairs(units or {}) do
        unit:Destroy()
    end
end
-- 调用方把项目配置中的真实预设资源 ID 传给 loadAndInspectAsset
```

### GetServerTime

签名：`GetServerTime() -> Float (服务器时间，单位为秒)`

获取当前服务器时间，单位为秒。

**返回值** `Float` (服务器时间，单位为秒)

> 示例代码

> 获取服务器时间并输出

```lua
-- @runtime client
-- 获取 World 服务实例
local world = game:GetService("World")

-- 获取当前服务器时间（秒）
local serverTime = world:GetServerTime()

-- 输出服务器时间
print("当前服务器时间:", serverTime, "秒")
```

### GetCustomEventSignal

签名：`GetCustomEventSignal(eventName: String) -> Signal (自定义事件信号)`

获取一个全局自定义事件的信号对象，用于监听或触发跨脚本通信。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eventName` | `String` | 自定义事件名 |

**返回值** [Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html) (自定义事件信号)

> 示例代码

> 获取自定义事件信号并监听（判空保护）

```lua
-- @runtime client
local world = game:GetService('World')
local signal = world:GetCustomEventSignal('MyCustomEvent')
if signal == nil then
    print('自定义事件不存在，请先确认事件名已注册')
    return
end
signal:Connect(function(data)
    print('收到自定义事件，数据:', tostring(data))
end)
print('已开始监听 MyCustomEvent 事件')
```
