# WeldConstraint

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[WeldConstraint]**（4 属性 / 1 函数）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html) 用于描述多个对象之间的刚性连接；当前公开脚本契约只适合操作编辑器中已完成绑定的实例。

## 适用场景

适合查找和控制编辑器中已完成对象绑定的焊接约束；脚本侧应自行保留业务对象引用。一个 [WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html) 可采用一个根对象连接多个子对象的一连多结构。

## 使用要点

优先在编辑器中完成焊接配置，再由脚本按名称查找该 [WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html) 并读取或启停。参与焊接的物理对象应保持非 Static；同一对象不要加入多份 [WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html)。销毁旧约束后不要在同一调度时机立即为同一组对象重建，应等待旧关系完成清理并再次确认目标状态。

## 注意事项

当前公开 Meta 未提供脚本动态配置焊接端点的完整链路，也没有通过内部标识反查对象的公开接口；应保留 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 引用或建立按业务名称维护的注册表。当前运行包的焊接规则是：Static 物理对象不能参与 [WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html)；同一个 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 最多属于一份 [WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html)，但一份约束可以用一个根对象连接多个子对象。旧约束销毁与底层物理关系清理并非同一时刻完成，同一组对象在同一调度时机立即重建可能不生效；应拆分销毁与重建时机，并在目标运行包确认旧关系已解除。

## 代码示例

### 读取编辑器预配置的焊接关系

```lua
-- @runtime server
local World = game:GetService("World")

local weld = World:FindFirstChild("MyWeldConstraint", true)
local root = World:FindFirstChild("WeldRoot", true)
local child = World:FindFirstChild("WeldChild", true)
if weld == nil or root == nil or child == nil then
    print("请先在编辑器中配置焊接关系，并用名称保存对象引用")
    return
end
print("焊接约束:", weld.Name, "根对象:", root.Name, "子对象:", child.Name)
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Enabled` | `Bool` | `true` | 布尔值，表示作者对该焊缝约束的启用意图。默认值为 true，即默认启用；设为 false 可禁用该约束。 |
| `Active` | `Bool` | `false` | 只读布尔值，表示当前焊缝约束是否处于生效状态。该属性用于查询约束的实际生效情况，不可由作者直接修改。 |
| `ConnectUnitList` | Array<[BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html)> | `[]` | 焊接约束连接的单元列表，仅在服务端创建 [WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html) 时作为创建参数传入，用于指定该焊接约束需要连接的一组单元。 |
| `ExpectRootUnit` | [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html) | `-` | 焊接约束装配体期望的根单元，仅在服务端创建 [WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html) 时作为创建参数传入，用于指定装配体中的基准单元。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html)

## 函数 (1)

### GetRootUnit

签名：`GetRootUnit() -> BasePart`

获取焊接约束对应的装配体根单元。焊接约束可将多个单元连接为一个装配体，根单元是装配体中的基准单元，通常在服务端创建 [WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html) 时通过 ExpectRootUnit 参数指定。

**返回值** [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html)

> 示例代码

> 创建焊接装配后获取根单元

```lua
-- @runtime server
local world = game:GetService("World")

-- 创建两个可焊接的物理单元（Dynamic 类型才可参与装配）
local rootUnit = world:CreateUnit("WorldUnit", {
    Name = "WeldRoot",
    BodyType = Enums.BodyType.Dynamic,
})
local childUnit = world:CreateUnit("WorldUnit", {
    Name = "WeldChild",
    BodyType = Enums.BodyType.Dynamic,
})

-- 创建焊接约束并声明期望根单元与连接单元
local weld = world:CreateUnit("WeldConstraint", {
    Name = "DemoWeld",
    ExpectRootUnit = rootUnit,
    ConnectUnitList = { rootUnit, childUnit },
})

-- 获取焊接装配体的根单元并输出名称
local actualRoot = weld:GetRootUnit()
if actualRoot then
    print("焊接根单元:", actualRoot.Name)
else
    print("当前焊接约束没有有效的根单元")
end
```
