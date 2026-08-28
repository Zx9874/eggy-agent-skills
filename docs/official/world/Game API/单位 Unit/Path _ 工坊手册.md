# Path

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[Path]**（1 属性 / 6 函数 / 2 事件）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[Path](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Path.html) 对象用于保存一次寻路计算结果，提供路径点遍历、采样和射线检测等能力。通过 ComputeAsync 计算起点到终点的路径后，可读取 Status 判断是否成功，并用 GetWaypoints 获取路径点列表。不再使用时必须显式调用 Destroy 释放资源。

## 适用场景

典型场景是让单位沿导航网格移动：先通过 PathfindingService:CreatePath 创建 [Path](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Path.html) 实例，调用 ComputeAsync 计算路径，再遍历路径点驱动单位移动。

## 使用要点

通过 PathfindingService:CreatePath 获取 [Path](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Path.html) 实例。调用 ComputeAsync 传入起点和终点坐标，检查 Status 是否为 Success，然后使用 GetWaypoints 获取路径点数组，遍历每个 [PathWaypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PathWaypoint.html) 的 Position 属性驱动单位移动。

## 注意事项

ComputeAsync 当前是同步执行接口，不会挂起协程；仍必须先调用 ComputeAsync(start, dest)，等调用返回后再读取 Status 和 GetWaypoints。直接在 ComputeAsync 之前调用 GetWaypoints 会返回空数组。典型端到端流程：CreatePath → ComputeAsync(start, dest) → 检查 Status 是否为 Success → GetWaypoints 遍历每个 PathWaypoint.Position 驱动单位移动。若 HasNavMesh 为 false 或起终点不在导航网格上，Status 会返回失败且 GetWaypoints 为空。[Path](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Path.html) 不再使用时必须显式调用 Destroy() 释放。

## 代码示例

### 计算路径并读取路点

```lua
-- @runtime client
local pathfindingService = game:GetService("PathfindingService")
local path = pathfindingService:CreatePath({})
local startPos = Vector3.New(0, 0, 0)
local destPos = Vector3.New(20, 0, 20)

path:ComputeAsync(startPos, destPos)
if path.Status == Enums.PathStatus.Success then
    for index, waypoint in ipairs(path:GetWaypoints()) do
        print("路点", index, waypoint.Position)
    end
else
    print("寻路失败，状态:", path.Status)
end
path:Destroy()
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Status` | [PathStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PathStatus.html) | `Enums.PathStatus.NoPath` | 路径计算状态。初始值为 NoPath；ComputeAsync 成功后变为 Success，失败或无可达路径时为 NoPath。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [PathStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PathStatus.html)

## 事件 (2)

### Blocked

签名：`Blocked(segmentIndex: Int)` 触发：`local`

当路径上的某个路段被障碍物阻挡时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `segmentIndex` | `Int` | 被阻断的线段索引，1-based。 |

> 示例代码

> 事件示例

```lua
-- @runtime client
local function demo(path)
    if path ~= nil then
        path.Blocked:Once(function(segmentIndex)
            print("segmentIndex: " .. tostring(segmentIndex))
        end)
    end
end
```

### Unblocked

签名：`Unblocked(segmentIndex: Int)` 触发：`local`

当路径上之前被阻挡的路段恢复通行时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `segmentIndex` | `Int` | 恢复通行的线段索引，1-based。 |

> 示例代码

> 事件示例

```lua
-- @runtime client
local function demo(path)
    if path ~= nil then
        path.Unblocked:Once(function(segmentIndex)
            print("segmentIndex: " .. tostring(segmentIndex))
        end)
    end
end
```

## 函数 (6)

### ComputeAsync

签名：`ComputeAsync(start: Vector3, dest: Vector3) -> void`

根据起点和终点同步计算导航路径，并更新 Status 与路点列表；调用返回后再读取 GetWaypoints。

⚙ 当前版本直接同步返回，不需要额外包装为协程调用。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `start` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 寻路起点的世界坐标。 |
| `dest` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 寻路终点的世界坐标。 |

**返回值** `void`

> 示例代码

> 计算路径并检查状态

```lua
-- @runtime client
local path = game:GetService('PathfindingService'):CreatePath({})
path:ComputeAsync(Vector3.New(0, 0, 0), Vector3.New(20, 0, 20))
print('寻路状态:', path.Status)
path:Destroy()
```

### GetWaypoints

签名：`GetWaypoints() -> Array&lt;PathWaypoint&gt; (PathWaypoint 数组副本。)`

获取当前计算出的路径点列表。

**返回值** Array<[PathWaypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PathWaypoint.html)> ([PathWaypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PathWaypoint.html) 数组副本。)

> 示例代码

> 计算后遍历路径点

```lua
-- @runtime client
local path = game:GetService('PathfindingService'):CreatePath({})
path:ComputeAsync(Vector3.New(0, 0, 0), Vector3.New(20, 0, 20))
if path.Status == Enums.PathStatus.Success then
    for index, waypoint in ipairs(path:GetWaypoints()) do
        print('路点', index, waypoint.Position)
    end
end
path:Destroy()
```

### SamplePosition

签名：`SamplePosition(sourcePosition: Vector3, maxDistance: Float, areaMask: Int) -> Vector3 (最近的导航网格坐标；采样失败时返回 nil。)`

在导航网格上查找距离给定位置最近的有效点。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `sourcePosition` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 采样查询的世界坐标。 |
| `maxDistance` | `Float` | 从源坐标开始搜索的最大半径。 |
| `areaMask` | `Int` | 用于限制可采样区域的掩码。此参数暂未使用 |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) (最近的导航网格坐标；采样失败时返回 nil。)

> 示例代码

> 在导航网格上采样最近位置

```lua
-- @runtime client
local path = game:GetService('PathfindingService'):CreatePath({})
local sampled = path:SamplePosition(Vector3.New(0, 2, 0), 10, 0)
if sampled ~= nil then print('采样位置:', sampled) end
path:Destroy()
```

### Raycast

签名：`Raycast(startPosition: Vector3, endPosition: Vector3) -> PathHitInfo (导航网格射线检测结果对象。)`

在导航网格上进行射线检测，判断两点之间是否存在可通行的直线路径。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `startPosition` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 射线起点的世界坐标。 |
| `endPosition` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 射线终点的世界坐标。 |

**返回值** [PathHitInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PathHitInfo.html) (导航网格射线检测结果对象。)

> 示例代码

> 执行导航网格射线检测

```lua
-- @runtime client
local path = game:GetService('PathfindingService'):CreatePath({})
local hit = path:Raycast(Vector3.New(0, 2, 0), Vector3.New(20, 2, 0))
if hit ~= nil then print('是否命中:', hit.IsHit, '位置:', hit.HitPosition) end
path:Destroy()
```

### SetAreaCost

签名：`SetAreaCost(area_index: String, cost: Float) -> void`

设置指定区域索引的寻路代价值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `area_index` | `String` | 导航区域或 Link/Modifier 的 Label。 |
| `cost` | `Float` | 该区域的寻路代价值。 |

**返回值** `void`

> 示例代码

> 设置并读取指定区域的寻路代价

```lua
-- @runtime client
local path = game:GetService("PathfindingService"):CreatePath({})
local areaIndex = "default"
local cost = 2.0

path:SetAreaCost(areaIndex, cost)
local currentValue = path:GetAreaCost(areaIndex)
print("当前区域代价:", currentValue)
path:Destroy()
```

### GetAreaCost

签名：`GetAreaCost(area_index: String) -> Float (区域寻路代价值。)`

获取指定区域索引的寻路代价值。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `area_index` | `String` | 导航区域或 Link/Modifier 的 Label。 |

**返回值** `Float` (区域寻路代价值。)

> 示例代码

> 读取指定区域的寻路代价

```lua
-- @runtime client
local path = game:GetService("PathfindingService"):CreatePath({})
local areaIndex = "default"
local currentValue = path:GetAreaCost(areaIndex)
print("当前区域代价:", currentValue)
path:Destroy()
```
