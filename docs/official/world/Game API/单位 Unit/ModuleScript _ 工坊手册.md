# ModuleScript

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BaseScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html)（1 属性）
    - **[ModuleScript]**

### 继承成员

2 个来源 / 5 属性 / 25 函数 / 6 事件

* 来自 [BaseScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html)（1 属性）
  + 属性：[`SourceCode`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html#properties)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[ModuleScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModuleScript.html) 是可被其他脚本 require 的模块脚本 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)，继承 [BaseScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html) 的 SourceCode 字段，用于沉淀可复用 Lua 逻辑。

## 适用场景

当多段 [Script](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Script.html) 或 [LocalScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/LocalScript.html) 需要复用同一组函数、常量或配置表时，可把公共逻辑放入 [ModuleScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModuleScript.html)，再由调用方脚本 require。

## 使用要点

通过 game:CreateUnit("ModuleScript", config) 创建实例，设置 Name 与 SourceCode 后挂到 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html) 或约定目录。[ModuleScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModuleScript.html) 自身没有额外公开函数，脚本内容字段来自 [BaseScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html)。

## 代码示例

### 创建 ModuleScript 并写入模块代码

```lua
-- @runtime client
local World = game:GetService('World')

local moduleScript = game:CreateUnit('ModuleScript', {
    Name = 'SharedLogic',
    SourceCode = 'return { version = 1 }',
})
moduleScript.Parent = World
print('模块脚本源码:', moduleScript.SourceCode)
```

## 关联类型

* [BaseScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html)
