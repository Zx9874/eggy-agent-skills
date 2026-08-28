# TagService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[TagService]**（6 函数 / 2 事件）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[TagService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TagService.html) 是全局标签管理器，负责为 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 实例动态添加、移除和查询字符串标签。它支持按标签检索所有已标记的 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)，并能在标签变更时触发本地事件通知。

## 适用场景

常用于在游戏逻辑中为场景单元打上自定义标签，例如标记“敌人”、“可拾取”或“已激活”，然后通过标签快速筛选或批量操作相关单元。

## 使用要点

通过 game:GetService("TagService") 获取服务实例。使用 AddTag 和 RemoveTag 为 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 添加或移除标签，用 HasTag 检查标签是否存在，GetTags 获取单元的所有标签。GetAllTags 可列出全局已使用的标签，GetTagged 则返回拥有指定标签的所有 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)。

## 注意事项

[TagService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TagService.html) 的 AddTag/RemoveTag 当前以本端状态变更为主，跨客户端同步与事件广播语义需以运行包实测为准。当前运行包还存在客户端初始化完成后新增标签未进入 GetTagged 本地索引的反馈，无论标签由服务端还是客户端添加，都不要把客户端 GetTagged 结果视为完整动态注册表。若业务要求服务端改 Tag 后客户端稳定感知，建议同时通过 [RemoteEvent](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RemoteEvent.html)/RemoteFunction 发送显式同步消息，并由业务层维护对象集合。

## 代码示例

### 安全创建临时单位并验证标签

```lua
-- @runtime client
local TagService = game:GetService('TagService')
local World = game:GetService('World')
local unit = World:CreateUnit('WorldUnit', {})
if unit == nil then return end
TagService:AddTag(unit, 'DemoTag')
print('标签已添加:', TagService:HasTag(unit, 'DemoTag'))
unit:Destroy()
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (2)

### TagAdded

签名：`TagAdded(tag: String)` 触发：`local`

当任意 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 实例首次被添加某个标签时触发，提供被添加的标签字符串。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `tag` | `String` | 新增的标签 |

> 示例代码

> 监听标签首次出现

```lua
-- @runtime client
local TagService = game:GetService('TagService')
local World = game:GetService('World')
local unit = World:CreateUnit('WorldUnit', {})
if unit == nil then return end
local connection = TagService.TagAdded:Connect(function(tag) print('新标签:', tag) end)
TagService:AddTag(unit, 'DemoAddedTag')
connection:Disconnect()
unit:Destroy()
```

### TagRemoved

签名：`TagRemoved(tag: String)` 触发：`local`

当任意 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 实例的某个标签被完全移除时触发，提供被移除的标签字符串。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `tag` | `String` | 移除的标签 |

> 示例代码

> 监听标签完全移除

```lua
-- @runtime client
local TagService = game:GetService('TagService')
local World = game:GetService('World')
local unit = World:CreateUnit('WorldUnit', {})
if unit == nil then return end
TagService:AddTag(unit, 'DemoRemovedTag')
local connection = TagService.TagRemoved:Connect(function(tag) print('标签已移除:', tag) end)
TagService:RemoveTag(unit, 'DemoRemovedTag')
connection:Disconnect()
unit:Destroy()
```

## 函数 (6)

### AddTag

签名：`AddTag(unit: SpaceUnit, tag: String) -> void`

为指定的 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 实例添加一个标签。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `unit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 组件 |
| `tag` | `String` | 标签 |

**返回值** `void`

> 示例代码

> 为临时单位添加标签

```lua
-- @runtime client
local TagService = game:GetService('TagService')
local World = game:GetService('World')
local unit = World:CreateUnit('WorldUnit', {})
if unit == nil then return end
TagService:AddTag(unit, 'Enemy')
print('是否拥有 Enemy:', TagService:HasTag(unit, 'Enemy'))
unit:Destroy()
```

### RemoveTag

签名：`RemoveTag(unit: SpaceUnit, tag: String) -> void`

从指定 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 实例移除一个标签。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `unit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 组件 |
| `tag` | `String` | 标签 |

**返回值** `void`

> 示例代码

> 从临时单位移除标签

```lua
-- @runtime client
local TagService = game:GetService('TagService')
local World = game:GetService('World')
local unit = World:CreateUnit('WorldUnit', {})
if unit == nil then return end
TagService:AddTag(unit, 'Temporary')
TagService:RemoveTag(unit, 'Temporary')
print('移除后仍存在:', TagService:HasTag(unit, 'Temporary'))
unit:Destroy()
```

### HasTag

签名：`HasTag(unit: SpaceUnit, tag: String) -> Bool (是否拥有标签)`

判断指定 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 实例是否拥有某个标签。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `unit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 组件 |
| `tag` | `String` | 标签 |

**返回值** `Bool` (是否拥有标签)

> 示例代码

> 检查临时单位的标签

```lua
-- @runtime client
local TagService = game:GetService('TagService')
local World = game:GetService('World')
local unit = World:CreateUnit('WorldUnit', {})
if unit == nil then return end
TagService:AddTag(unit, 'Interactive')
print('是否可交互:', TagService:HasTag(unit, 'Interactive'))
unit:Destroy()
```

### GetTags

签名：`GetTags(unit: SpaceUnit) -> Array<String> (标签列表)`

获取指定 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 实例拥有的所有标签。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `unit` | [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) | 组件 |

**返回值** `Array<String>` (标签列表)

> 示例代码

> 读取临时单位的全部标签

```lua
-- @runtime client
local TagService = game:GetService('TagService')
local World = game:GetService('World')
local unit = World:CreateUnit('WorldUnit', {})
if unit == nil then return end
TagService:AddTag(unit, 'NPC')
for _, tag in ipairs(TagService:GetTags(unit)) do print('单位标签:', tag) end
unit:Destroy()
```

### GetAllTags

签名：`GetAllTags() -> Array<String> (标签列表)`

获取当前游戏中所有已存在的标签列表。

**返回值** `Array<String>` (标签列表)

> 示例代码

> 读取当前端已有的全部标签名

```lua
-- @runtime client
local TagService = game:GetService('TagService')
for _, tag in ipairs(TagService:GetAllTags()) do
    print('当前标签:', tag)
end
```

### GetTagged

签名：`GetTagged(tag: String) -> Array&lt;SpaceUnit&gt; (组件列表)`

获取拥有指定标签的所有 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html) 实例。

⚙ GetTagged 返回当前端已建立索引的标签快照。当前运行包实测客户端初始化完成后新增的标签对象可能不会进入该结果；关键业务应维护显式对象集合或通过 [RemoteEvent](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RemoteEvent.html)/RemoteFunction 同步，不能把 GetTagged 当作完整动态注册表。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `tag` | `String` | 标签 |

**返回值** Array<[SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)> (组件列表)

> 示例代码

> 读取当前端已有的标签快照

```lua
-- @runtime client
local TagService = game:GetService('TagService')
local taggedSnapshot = TagService:GetTagged('Enemy')
for _, unit in ipairs(taggedSnapshot) do
    print('当前索引中的对象:', unit.Name)
end
-- 动态新增对象请由业务层另行维护和同步，不要把该快照当作完整注册表
```
