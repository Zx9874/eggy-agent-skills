# WorldRoot

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

WorldRoot，继承自 [ModelUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html)（4 属性 / 1 函数）。

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
    - [ModelUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html)（4 属性 / 1 函数）
      * **[WorldRoot]**
        + [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)（1 属性 / 4 函数）

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

处理物理模拟和3D空间查询的基类，预期为任何用于处理3D空间查询和模拟的实例提供API，例如[World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)

## 多态说明

该类型本身是公开抽象父类型，文档中可能会作为函数参数或返回值类型出现；实际运行时通常会传入或返回它的公开子类型，使用时请结合真实对象类型和返回内容做判断。

## 关联类型

* [ModelUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ModelUnit.html)
