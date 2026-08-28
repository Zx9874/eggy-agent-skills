# Tool

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BackpackItem](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BackpackItem.html)（1 属性）
    - **[Tool]**（4 属性 / 2 函数 / 4 事件）

### 继承成员

2 个来源 / 5 属性 / 25 函数 / 6 事件

* 来自 [BackpackItem](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BackpackItem.html)（1 属性）
  + 属性：[`Icon`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BackpackItem.html#properties)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

工具单位，代表玩家可装备、使用和丢弃的物品。它提供激活与停用方法，并通过事件通知装备、卸下、激活和停用等状态变化。

## 适用场景

用于实现游戏中的可交互道具，例如武器、药水或特殊技能道具，玩家拾取后装备并使用。

## 使用要点

服务端先通过 game:GetService("World") 获取 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)，再用 World:CreateUnit("Tool", config) 创建并持有工具实例。客户端需要响应本地装备或激活事件时，应从 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html) 查找宿主已创建的 [Tool](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tool.html)，不要在监听示例里重新创建。

## 注意事项

[Tool](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tool.html)、[Backpack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Backpack.html)、[BackpackItem](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BackpackItem.html) 当前是逻辑容器/事件模型，不自带可见模型、背包 UI、拾取流程或官方预设资源。当前 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 公开 Meta 未声明 [Backpack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Backpack.html) 属性，禁止使用 player.Backpack；作者应明确创建并持有业务 [Backpack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Backpack.html)，或按目标运行包已经验证的宿主关系管理 [Tool](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Tool.html)。当前版本没有统一装备接口。Activate() 只触发工具激活语义，不会自动产生视觉效果。

## 代码示例

### 服务端创建业务物品容器并触发工具

```lua
-- @runtime server
local World = game:GetService("World")

local backpack = World:CreateUnit("Backpack", { Name = "QuestItems" })
local tool = World:CreateUnit("Tool", {
    Name = "MagicWand",
    RequiresHandle = false,
    Enabled = true,
    ToolTip = "魔法棒",
    Parent = backpack,
})

tool.Activated:Once(function()
    print("工具被激活:", tool.Name)
end)
tool:Activate()
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `RequiresHandle` | `Bool` | `true` | 控制工具是否需要 Handle 部件才能装备。 |
| `CanBeDropped` | `Bool` | `true` | 控制工具是否可以被丢弃。 |
| `Enabled` | `Bool` | `true` | 控制工具是否可用。 |
| `ToolTip` | `String` | `""` | 设置工具的提示文本。 |

## 关联类型

* [BackpackItem](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BackpackItem.html)

## 事件 (4)

### Equipped

签名：`Equipped()` 触发：`local`

当工具被装备到角色身上时触发此事件。

> 示例代码

> 监听宿主系统发出的装备事件

```lua
-- @runtime client
local tool = game:GetService("World"):FindFirstChild("MyTool", true)
if tool ~= nil and tool:IsA("Tool") then
    tool.Equipped:Once(function()
        print("工具已装备")
    end)
end
```

### Unequipped

签名：`Unequipped()` 触发：`local`

当工具从角色身上卸下时触发此事件。

> 示例代码

> 监听宿主系统发出的卸下事件

```lua
-- @runtime client
local tool = game:GetService("World"):FindFirstChild("MyTool", true)
if tool ~= nil and tool:IsA("Tool") then
    tool.Unequipped:Once(function()
        print("工具已卸下")
    end)
end
```

### Activated

签名：`Activated()` 触发：`local`

当工具被激活时触发此事件。

> 示例代码

> 监听宿主系统发出的激活事件

```lua
-- @runtime client
local tool = game:GetService("World"):FindFirstChild("MyTool", true)
if tool ~= nil and tool:IsA("Tool") then
    tool.Activated:Once(function()
        print("工具已激活")
    end)
end
```

### Deactivated

签名：`Deactivated()` 触发：`local`

当工具被停用时触发此事件。

> 示例代码

> 监听宿主系统发出的停用事件

```lua
-- @runtime client
local tool = game:GetService("World"):FindFirstChild("MyTool", true)
if tool ~= nil and tool:IsA("Tool") then
    tool.Deactivated:Once(function()
        print("工具已停用")
    end)
end
```

## 函数 (2)

### Activate

签名：`Activate() -> void`

激活工具，使其进入可用状态。

**返回值** `void`

> 示例代码

> 创建工具并触发激活语义

```lua
-- @runtime server
local World = game:GetService("World")
local tool = World:CreateUnit("Tool", { Name = "MyTool", Enabled = true })
tool:Activate()
print("工具已激活:", tool.Name)
```

### Deactivate

签名：`Deactivate() -> void`

停用工具，使其进入不可用状态。

**返回值** `void`

> 示例代码

> 停用已创建的工具

```lua
-- @runtime server
local World = game:GetService("World")
local tool = World:CreateUnit("Tool", { Name = "MyTool", Enabled = true })
tool:Activate()
tool:Deactivate()
print("工具已停用:", tool.Name)
```
