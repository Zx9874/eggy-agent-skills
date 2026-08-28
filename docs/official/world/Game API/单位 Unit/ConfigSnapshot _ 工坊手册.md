# ConfigSnapshot

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[ConfigSnapshot]**（1 属性 / 3 函数 / 1 事件）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[ConfigSnapshot](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ConfigSnapshot.html) 是由 [ConfigService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/ConfigService.html) 获取的不可变配置视图，可读取键值、监听单键变化，并在后台版本更新后主动刷新。

## 适用场景

服务端获取全局或玩家配置后，用快照驱动业务参数，并在 UpdateAvailable 到达时刷新到最新已发布版本。

## 使用要点

先通过服务端 ConfigService:GetConfigAsync() 或 GetConfigForPlayerAsync() 获取快照；使用 GetValue 读取键，使用 GetValueChangedSignal 监听值变化，收到 UpdateAvailable 后调用 Refresh。

## 注意事项

[ConfigSnapshot](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ConfigSnapshot.html) 不可自行构造；其获取入口 [ConfigService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/ConfigService.html) 的 realm 为 server，因此示例均在服务端运行。快照不会静默替换创建时的数据，需在 Outdated/UpdateAvailable 提示后显式 Refresh。

## 代码示例

### 读取配置并在版本更新时刷新

```lua
-- @runtime server
local Task = game:GetService('Task')
local ConfigService = game:GetService('ConfigService')
Task:Spawn(function()
    local snapshot = ConfigService:GetConfigAsync()
    print('配置值:', snapshot:GetValue('attack'))
    snapshot.UpdateAvailable:Once(function()
        snapshot:Refresh()
        print('配置已刷新:', snapshot:GetValue('attack'))
    end)
end)
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Outdated` | `Bool` | `false` | 表示当前快照是否已过期。当后端有新配置发布时，该属性变为 true。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (1)

### UpdateAvailable

签名：`UpdateAvailable()` 触发：`local`

当配置快照对应的后端配置版本发生变化时触发一次，通常表示当前持有的配置快照已过期，需要更新以获得最新配置内容。

> 示例代码

> 收到新版本后刷新快照

```lua
-- @runtime server
local Task = game:GetService('Task')
Task:Spawn(function()
    local snapshot = game:GetService('ConfigService'):GetConfigAsync()
    snapshot.UpdateAvailable:Once(function()
        snapshot:Refresh()
        print('已同步最新配置')
    end)
end)
```

## 函数 (3)

### GetValue

签名：`GetValue(key: String) -> Any (配置值)`

获取指定 key 的配置值。优先返回通过 SetTestingValue 设置的试玩覆盖值，否则返回快照锁定的值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 配置键名 |

**返回值** `Any` (配置值)

> 示例代码

> 读取配置项

```lua
-- @runtime server
local Task = game:GetService('Task')
Task:Spawn(function()
    local snapshot = game:GetService('ConfigService'):GetConfigAsync()
    local value = snapshot:GetValue('attack')
    print('attack:', value)
end)
```

### GetValueChangedSignal

签名：`GetValueChangedSignal(key: String) -> Signal (变更信号)`

获取或懒创建一个 [Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html) 对象，用于监听指定 key 的配置值变更。当 Refresh 检测到值变化，或 SetTestingValue/ClearTestingValue 影响该 key 时，信号会触发并传递新值和旧值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `key` | `String` | 配置键名 |

**返回值** [Signal](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Signal.html) (变更信号)

> 示例代码

> 监听配置项变化

```lua
-- @runtime server
local Task = game:GetService('Task')
Task:Spawn(function()
    local snapshot = game:GetService('ConfigService'):GetConfigAsync()
    snapshot:GetValueChangedSignal('attack'):Once(function(newValue, oldValue)
        print('attack 变化:', oldValue, '->', newValue)
    end)
end)
```

### Refresh

签名：`Refresh() -> void`

主动将快照同步到最新已发布的配置版本。完成后 Outdated 属性重置为 false。

**返回值** `void`

> 示例代码

> 刷新过期快照

```lua
-- @runtime server
local Task = game:GetService('Task')
Task:Spawn(function()
    local snapshot = game:GetService('ConfigService'):GetConfigAsync()
    if snapshot.Outdated then
        snapshot:Refresh()
    end
    print('快照是否过期:', snapshot.Outdated)
end)
```
