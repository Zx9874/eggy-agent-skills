# FindingPathUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
    - **[FindingPathUnit]**（1 属性 / 4 函数）

### 继承成员

2 个来源 / 7 属性 / 34 函数 / 6 事件

* 来自 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
  + 属性：[`Tags`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`EcaPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`Owner`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)
  + 函数：[`HasTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`AddTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`RemoveTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`GetPivot`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`PivotTo`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`ApplyPivotDelta`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`TranslateBy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`IsTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`FindTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

寻路路径单元用于按顺序维护一组路径点，公开 Meta 支持添加、删除以及发起路点/数量查询。

## 适用场景

当需要为角色或单位指定一条固定的移动路线时，通过创建寻路路径单元并添加一系列路点来定义路径，然后由寻路系统沿该路径移动。

## 使用要点

通过 World:CreateUnit 创建路径单位，按路线顺序调用 AddPoint 添加 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 世界坐标；RemovePoint 使用从 1 开始的索引删除指定路点。

## 注意事项

RemovePoint 的 index 是 1-based：1 表示第一个路点，2 表示第二个。AddPoint 返回新建的 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)，失败时为 nil；GetWaypoints 返回路点数组，每个元素是包含 Position 字段的 table；GetPointCount 返回 Int。

## 代码示例

### 创建路径并维护路点

```lua
-- @runtime client
local World = game:GetService("World")
local path = World:CreateUnit("FindingPathUnit", { Name = "PatrolRoute" })
local firstPoint = path:AddPoint(Vector3.New(0, 0, 0))
if firstPoint == nil then return end
path:AddPoint(Vector3.New(10, 0, 5))
path:AddPoint(Vector3.New(20, 0, 0))
-- RemovePoint 使用 1-based 索引；这里删除第二个路点
path:RemovePoint(2)
print("当前路点数:", path:GetPointCount())
for _, waypoint in ipairs(path:GetWaypoints()) do
    print("路点位置:", waypoint.Position)
end
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Name` | `String` | `寻路路径` | 寻路路径的名称标识，用于在场景中区分不同的寻路路径实例。 |

## 关联类型

* [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)

## 函数 (4)

### GetWaypoints

获取当前路径的路点列表；每个元素是包含 Position = [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 的 table。

⚙ 遍历返回数组时使用 waypoint.Position 读取路点世界坐标。

> 示例代码

> 读取全部路点位置

```lua
-- @runtime client
local function printWaypoints(path)
    if path == nil then return end
    for _, waypoint in ipairs(path:GetWaypoints()) do
        print(waypoint.Position)
    end
end
```

### AddPoint

签名：`AddPoint(position: Vector3) -> Attachment | nil (新创建的路点 Attachment，失败返回 nil)`

在寻路单元中添加一个路点，返回新创建的 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 实例。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 路点世界位置 |

**返回值** [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) | nil (新创建的路点 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html)，失败返回 nil)

> 示例代码

> 向路径末尾添加路点

```lua
-- @runtime client
local function appendWaypoint(path, position)
    if path == nil then return end
    local attachment = path:AddPoint(position)
    if attachment == nil then
        print("添加路点失败")
        return
    end
    print("新路点:", attachment.Name)
end
```

### RemovePoint

签名：`RemovePoint(index: Int) -> void`

根据索引移除一个路点。

⚙ index 从 1 开始；1 表示第一个路点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `index` | `Int` | 路点索引 |

**返回值** `void`

> 示例代码

> 按 1-based 索引删除路点

```lua
-- @runtime client
local function removeSecondPoint(path)
    if path == nil then return end
    path:RemovePoint(2)
end
```

### GetPointCount

签名：`GetPointCount() -> Int (路点数量)`

返回当前路径点数量。

⚙ 返回值类型为 Int，可用于遍历前检查路径是否为空。

**返回值** `Int` (路点数量)

> 示例代码

> 读取路径点数量

```lua
-- @runtime client
local function printPointCount(path)
    if path == nil then return end
    print("路径点数量:", path:GetPointCount())
end
```
