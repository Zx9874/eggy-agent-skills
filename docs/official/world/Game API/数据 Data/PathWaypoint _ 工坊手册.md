# PathWaypoint

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

寻路路点表示寻路路径上的一个关键位置，包含世界坐标、到达时执行的动作以及自定义标签。它由寻路系统在计算路径后生成，用于指导单位沿路径移动并执行特定行为。

## 适用场景

在需要让单位沿计算出的路径移动时，通过 Path:GetWaypoints() 获取路点列表，遍历每个路点读取其位置和动作，控制单位依次前往。

## 使用要点

先通过 PathfindingService:CreatePath 创建路径，调用 path:ComputeAsync(startPosition, destination) 传入起点和终点；成功后用 path:GetWaypoints() 获取路点数组。

## 注意事项

[PathWaypoint](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PathWaypoint.html) 实例只能通过 Path:GetWaypoints() 等公开 API 获取，不可直接构造。路点顺序由寻路算法决定，修改路点属性不会影响已计算的路径。

## 代码示例

### 从成功计算的路径中读取路点

```lua
-- @runtime client
local path = game:GetService('PathfindingService'):CreatePath({})
path:ComputeAsync(Vector3.New(0, 0, 0), Vector3.New(20, 0, 20))
if path.Status == Enums.PathStatus.Success then
    for index, waypoint in ipairs(path:GetWaypoints()) do
        print(index, waypoint.Position, waypoint.Action, waypoint.Label)
    end
end
path:Destroy()
```

## 属性 (3)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 路点在世界空间中的三维坐标位置。 |
| `Action` | [PathWaypointAction](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PathWaypointAction.html) | `-` | 到达该路点时执行的动作类型，决定角色在该点的行为。 |
| `Label` | `String` | `-` | 路点的自定义标签，用于标识或分类路点。 |

## 关联类型

* [PathWaypointAction](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/PathWaypointAction.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
