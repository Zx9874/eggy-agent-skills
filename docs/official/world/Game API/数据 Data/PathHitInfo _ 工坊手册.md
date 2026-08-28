# PathHitInfo

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

寻路射线检测结果，用于描述一条射线与导航网格的碰撞信息。它记录了射线的起点、终点、是否命中、命中点的插值参数以及命中点的世界坐标。

## 适用场景

在使用 [Path](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Path.html) 的 Raycast 方法进行寻路射线检测时，通过返回值获取 [PathHitInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PathHitInfo.html) 实例，进而判断射线是否与导航网格相交并获取碰撞点位置。

## 使用要点

通过 Path:Raycast(startPosition, endPosition) 获取 [PathHitInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PathHitInfo.html)；第二个参数是射线终点坐标，不是方向向量。读取 IsHit 后，仅在命中时使用 HitPosition 和 HitT。

## 注意事项

[PathHitInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PathHitInfo.html) 不可直接构造，必须通过 Path:Raycast 等公开 API 获取。未命中时 HitPosition 为 nil，HitT 无意义。

## 代码示例

### 从导航网格射线检测结果读取命中信息

```lua
-- @runtime client
local path = game:GetService('PathfindingService'):CreatePath({})
local startPosition = Vector3.New(0, 2, 0)
local endPosition = Vector3.New(20, 2, 0)
local hit = path:Raycast(startPosition, endPosition)
if hit.IsHit then
    print('命中位置和插值参数:', hit.HitPosition, hit.HitT)
end
path:Destroy()
```

## 属性 (5)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `StartPosition` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 射线检测的起点坐标，表示射线发射的起始位置。 |
| `EndPosition` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 射线检测的终点坐标，表示射线从起点到终点的方向与长度。 |
| `IsHit` | `Bool` | `-` | 指示射线是否与导航网格发生碰撞。 |
| `HitT` | `Float` | `-` | 碰撞点在射线上的插值参数，范围 0 到 1，表示从起点到终点的比例。 |
| `HitPosition` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 射线与导航网格相交位置的世界坐标；未命中时为 nil。 |

## 关联类型

* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
