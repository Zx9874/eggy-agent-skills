# BaseScript

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[BaseScript]**（1 属性）
    - [LocalScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/LocalScript.html)
    - [ModuleScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModuleScript.html)
    - [Script](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Script.html)

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[BaseScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html) 是 [Script](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Script.html)、[LocalScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/LocalScript.html) 与 [ModuleScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModuleScript.html) 的抽象基类，公开脚本源代码文本。SourceCode 可在创建具体脚本子类时作为 config 字段提供。

## 适用场景

在创建 [Script](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Script.html)、[LocalScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/LocalScript.html) 或 [ModuleScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModuleScript.html) 等具体脚本实例时，通过 config 参数传入 SourceCode 来初始化脚本内容，或通过读取 SourceCode 属性获取已加载脚本的源代码。

## 使用要点

通过 game:CreateUnit("Script"/"LocalScript"/"ModuleScript", config) 创建具体脚本，并在 config 中提供 SourceCode；创建后可读取 SourceCode。

## 注意事项

[BaseScript](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BaseScript.html) 本身不可直接创建。当前公开契约只声明 SourceCode；不要访问未进入 Meta 的编译校验字段，也不要把已创建实例上的 SourceCode 当作常规可写属性。

## 代码示例

### 创建具体脚本并读取源代码

```lua
-- @runtime client
local scriptUnit = game:CreateUnit('LocalScript', {
    Name = 'ClientHello',
    SourceCode = "print('hello from client script')",
})
print('脚本源码:', scriptUnit.SourceCode)
scriptUnit:Destroy()
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `SourceCode` | `String` | `""` | 脚本的源代码字符串，可读写。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
