# Script

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BaseScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html)（1 属性）
    - **[Script]**

### 继承成员

2 个来源 / 5 属性 / 25 函数 / 6 事件

* 来自 [BaseScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html)（1 属性）
  + 属性：[`SourceCode`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html#properties)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[Script](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Script.html) 是服务端脚本 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)，继承 [BaseScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html) 的 SourceCode 字段，用于承载只在服务器侧执行的 Lua 逻辑。

## 适用场景

当需要在场景中创建或检查服务端脚本对象时，可通过 game:CreateUnit("Script", config) 创建后挂到 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html) 或其他合适父节点；客户端脚本应使用 [LocalScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/LocalScript.html)，复用模块逻辑应使用 [ModuleScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModuleScript.html)。

## 使用要点

创建 [Script](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Script.html) 后设置 SourceCode，再把 Parent 挂到 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html) 等运行层级。[Script](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Script.html) 自身不提供额外函数，常用操作来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)/[BaseScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html) 继承成员。

## 代码示例

### 创建服务端 Script 并挂到 World

```lua
-- @runtime server
local World = game:GetService('World')

local scriptUnit = game:CreateUnit('Script', {
    Name = 'ServerHello',
    SourceCode = "print('hello from server script')",
})
scriptUnit.Parent = World
print('脚本源码:', scriptUnit.SourceCode)
```

## 关联类型

* [BaseScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html)
