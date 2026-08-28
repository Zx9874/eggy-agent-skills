# OverlapParams

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[OverlapParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OverlapParams.html) 是 [PhysicsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PhysicsService.html) 空间查询（GetPartBoundsInBox、GetPartBoundsInRadius、GetPartsInPart）的过滤参数，用于精确控制查询返回的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 集合。它允许按实例白名单或黑名单过滤、按已配置的碰撞组过滤，并限制最大返回数量，从而让空间检测更聚焦于目标对象。

## 适用场景

常用于需要筛选特定单位进行范围检测的场景，例如只检测指定队伍的单位，或排除某些装饰物，避免查询结果被无关 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 干扰。

## 使用要点

先调用 OverlapParams.New() 创建过滤参数实例，再设置 FilterType 为 Enums.RaycastFilterType.Include 或 Exclude，并将 FilterDescendantsInstances 指定为要包含或排除的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 列表；如需碰撞组过滤，可设置 CollisionGroup 字段。最后将实例作为参数传入 PhysicsService:GetPartBoundsInBox、GetPartBoundsInRadius 或 GetPartsInPart 即可生效。

## 注意事项

[OverlapParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OverlapParams.html) 是 [PhysicsService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/PhysicsService.html) 空间重叠查询的过滤参数。使用时先用 OverlapParams.New() 构造，再按需设置 FilterType、FilterDescendantsInstances、CollisionGroup、MaxParts；FilterType 使用 Enums.RaycastFilterType.Include/Exclude。CollisionGroup 是用于按已配置碰撞关系过滤的组名，不是只按 WorldUnit.CollisionGroup 字符串同名匹配；最终结果同时受目标 WorldUnit.CollisionGroup、碰撞关系配置和实例过滤影响。不设置（nil，Meta 默认值）表示不启用碰撞组过滤。

## 代码示例

### 创建 OverlapParams 并传入空间查询

```lua
-- @runtime client
local PhysicsService = game:GetService('PhysicsService')
local World = game:GetService('World')
local targetUnit = World:CreateUnit('WorldUnit', { Position = Vector3.New(0, 0, 0) })
local params = OverlapParams.New()
params.FilterType = Enums.RaycastFilterType.Include
params.FilterDescendantsInstances = { targetUnit }
params.MaxParts = 10
local units = PhysicsService:GetPartBoundsInRadius(Vector3.New(0, 0, 0), 20, params)
print('命中数量:', #units)
targetUnit:Destroy()
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `FilterType` | [RaycastFilterType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/RaycastFilterType.html) | `Enums.RaycastFilterType.Exclude` | 过滤模式：Exclude 排除列表中的实例，Include 仅检测列表中的实例。 |
| `FilterDescendantsInstances` | Array<[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)> | `[]` | 物理查询（如射线、区块、球形、形状检测）中用于过滤的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 实例列表。该属性与 FilterType 配合使用，决定查询结果是仅包含列表中的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)，还是排除列表中的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)。 |
| `CollisionGroup` | `String` | `-` | 用于按已配置碰撞关系过滤的碰撞组名称，不是只按 WorldUnit.CollisionGroup 字符串同名匹配；不设置（nil，Meta 默认值）表示不启用碰撞组过滤。 |
| `MaxParts` | `Int` | `0` | 限制区域查询返回的最大实例数量。 |

## 函数 (1)

### New

签名：`New() -> OverlapParams`

创建空间重叠查询过滤参数，供 GetPartBoundsInBox、GetPartBoundsInRadius 和 GetPartsInPart 使用；射线与形状投射应使用 [RaycastParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RaycastParams.html)。

**返回值** [OverlapParams](https://u5-creator.s3.game.163.com/manual/se/game_api/data/OverlapParams.html)

> 示例代码

> 构造重叠查询过滤参数

```lua
-- @runtime client
local params = OverlapParams.New()
params.FilterType = Enums.RaycastFilterType.Exclude
params.FilterDescendantsInstances = {}
params.MaxParts = 10
-- 仅在项目已配置相应碰撞组关系时再设置 CollisionGroup
print("OverlapParams 构造完成，MaxParts =", params.MaxParts)
```
