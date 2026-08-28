# PathfindingService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[PathfindingService]**（2 属性 / 1 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

寻路服务，用于检测当前空间的导航网格状态并创建寻路代理。通过 HasNavMesh 和 HasDynamicNavMesh 属性可判断导航网格是否就绪，调用 CreatePath 可生成 [Path](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Path.html) 对象用于后续路径计算。

## 适用场景

在需要让角色或单位自动移动到目标点的场景中，通过 [PathfindingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PathfindingService.html) 创建 [Path](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Path.html)，计算路点序列后按顺序驱动单位移动，常用于 AI 移动、巡逻或玩家点击移动。

## 使用要点

先通过 game:GetService("PathfindingService") 获取服务实例，然后调用 CreatePath 并传入代理参数表（如 { AgentRadius = 2, AgentCanClimb = true }）创建 [Path](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Path.html) 对象。随后调用 path:ComputeAsync(startPos, endPos) 计算路径；该调用当前同步返回，完成后再通过 path.Status 判断结果，并使用 path:GetWaypoints() 获取路点列表。

## 注意事项

CreatePath(args) 接收一个参数表配置寻路代理行为，留空表 {} 表示用默认参数。当前公开 Meta 明确支持 AgentCanClimb、AgentRadius 与 Costs；未列出的键即使传入也不应作为稳定行为依赖。ComputeAsync 当前是同步执行接口，不会挂起协程；计算完成后通过 path.Status 判断结果，只有 Enums.PathStatus.Success 才有有效路点。计算前应确认 HasNavMesh/HasDynamicNavMesh 为真，否则返回的路点列表可能为空。

## 代码示例

### 端到端寻路：计算路径并遍历路点

```lua
-- @runtime client
local PathfindingService = game:GetService("PathfindingService")

-- 创建路径对象
local path = PathfindingService:CreatePath({
    AgentRadius = 2,
    AgentCanClimb = true,
})

-- ComputeAsync 当前同步返回；调用完成后再读取 Status / GetWaypoints
local startPos = Vector3.New(0, 0, 0)
local destPos = Vector3.New(100, 0, 50)
path:ComputeAsync(startPos, destPos)

-- 检查路径状态：必须为 Success 才有有效路点
if path.Status ~= Enums.PathStatus.Success then
    print("寻路失败，状态:", path.Status)
    return
end

-- 获取路点列表并逐个驱动移动
local waypoints = path:GetWaypoints()
for i, waypoint in ipairs(waypoints) do
    print(string.format("路点 %d: %s 动作: %s", i, tostring(waypoint.Position), tostring(waypoint.Action)))
    -- 这里接入你的移动逻辑，例如将单位移动到 waypoint.Position
end

-- 监听路径被动态障碍阻断的事件
path.Blocked:Connect(function(segmentIndex)
    print("路径线段被阻断:", segmentIndex)
end)
path.Unblocked:Connect(function(segmentIndex)
    print("路径线段恢复通行:", segmentIndex)
end)
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `HasNavMesh` | `Bool` | `-` | 当前空间是否存在有效的导航网格。 |
| `HasDynamicNavMesh` | `Bool` | `-` | 当前空间是否存在动态导航网格。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (1)

### CreatePath

签名：`CreatePath(args: Map) -> Path (新建的 Path 对象。)`

根据公开 args 参数表创建 [Path](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Path.html) 对象，后续可调用 Path:ComputeAsync 计算从起点到终点的路径。

⚙ 返回的 [Path](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Path.html) 对象初始状态尚未计算，必须调用 ComputeAsync 后再读取 Status 或 GetWaypoints。未在公开 Meta 中列出的 args 键不应写进示例或作为稳定行为依赖。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `args` | `Map` | 可选代理参数表，当前公开 Meta 确认 AgentRadius、AgentCanClimb 与 Costs。 |

**返回值** [Path](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Path.html) (新建的 [Path](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Path.html) 对象。)

> 示例代码

> 使用公开代理参数创建路径

```lua
-- @runtime client
local PathfindingService = game:GetService("PathfindingService")

local path = PathfindingService:CreatePath({
    AgentRadius = 2,
    AgentCanClimb = true,
})

print("创建路径对象，当前状态:", path.Status)
```
