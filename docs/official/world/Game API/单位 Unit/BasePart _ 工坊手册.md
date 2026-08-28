# BasePart

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
    - **[BasePart]**（23 属性 / 9 函数）
      * [PhysicsUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PhysicsUnit.html)（21 属性 / 15 函数 / 4 事件）
      * [RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html)（15 属性）
      * [SeatUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SeatUnit.html)（3 属性 / 1 事件）
      * [TriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/TriggerUnit.html)（8 属性 / 7 函数 / 4 事件）
        + [RenderTriggerUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderTriggerUnit.html)（16 属性）
      * [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)（29 属性 / 15 函数 / 6 事件）
        + [AnimatedUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimatedUnit.html)（3 函数）
        + [SpawnLocationUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpawnLocationUnit.html)（8 属性）

### 继承成员

2 个来源 / 7 属性 / 34 函数 / 6 事件

* 来自 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
  + 属性：[`Tags`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`EcaPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`Owner`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)
  + 函数：[`HasTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`AddTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`RemoveTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`GetPivot`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`PivotTo`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`ApplyPivotDelta`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`TranslateBy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`IsTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`FindTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html) 是三维场景中兼具物理碰撞与渲染表现的组件基类，[WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)、[PhysicsUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PhysicsUnit.html)、[RenderUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/RenderUnit.html) 等具体单位类型均继承自它。它统一了空间变换、渲染表现与装配体物理量等能力：既可通过 CFrame、Position、Rotation、Scale 控制摆放与姿态，也可通过 ModelAlpha、ModelVisible、CastShadow、ModelColor1 至 ModelColor4、SkinId 与自定义外观调整显示效果，还能读取装配体的线速度、角速度、质量与质心。同时提供网络模拟权判定与设置、焊接约束关系查询等管理接口。

## 适用场景

在场景中创建并操控物理单位的流程中最为常用，例如先用 World:CreateUnit 创建 [PhysicsUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PhysicsUnit.html)，再借助继承自 [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html) 的 CFrame、Position 与 ModelAlpha 等属性完成位置摆放和显示控制，或在多端联机时确认本端是否拥有该部件的模拟权限。

## 使用要点

通过子类实例（如 [WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html)）访问 [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html) 的属性和方法。ModelColor1~4 的公开类型是 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)，规范写法为 Color.New(r, g, b, a)，但实际染色还依赖资源 color mask；赋值后变白或无变化时不要反复改 RGBA，应先更换支持染色的资源。少数兼容资源只接受整数色值属于实现差异，不是稳定公开契约。服务端可用 GetNetworkOwner/SetNetworkOwner 管理物理网络所有权。父子层级本身已满足稳定跟随时不要叠加 [WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html)；确需显式焊接时，先解除 Parent，再建立约束并在目标运行包验证。

## 注意事项

[BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html) 不可直接创建，必须通过子类实例间接使用。网络所有者的查询与设置通常在服务端处理；客户端可用 IsNetworkOwnerSide 判断当前端是否拥有该部件的网络模拟权。修改 AssemblyLinearVelocity 等物理属性前需确保对象处于物理模拟激活状态。ModelColor1~ModelColor4 的类型在 Meta 中为 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)，但部分模型资源的染色区域受资源自身 color mask 支持情况影响；若赋值后统一变白或无变化，优先确认模型是否包含对应染色区域。当前版本中个别场景使用整数色值（如 tonumber("ff0000", 16)）更接近编辑器染色表现，脚本示例应标注资源依赖，避免承诺所有模型都可通过 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 直接染色。当前运行包还会为 [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html) 父子层级建立隐式刚性连接，该连接可能优先于显式 [WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html)；已处于父子关系的对象再创建焊接，或事后解除 Parent，不能保证原焊接自动接管。需要显式约束时应先解除父子层级，再创建并验证 [WeldConstraint](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WeldConstraint.html)。

## 代码示例

### 创建具体物理部件并读取物理状态

```lua
-- @runtime client
local World = game:GetService('World')
local part = World:CreateUnit('WorldUnit', {
    Position = Vector3.New(0, 5, 0),
    PhysicsActive = true,
})
print('当前线速度:', part.AssemblyLinearVelocity)
part:Destroy()
```

## 属性 (23)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `CFrame` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | `[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0]` | CFrame 属性描述物体在世界空间中的空间变换信息，同时包含位置与旋转两个部分。通过读取该属性可以获取物体当前的坐标与朝向，通过赋值可以设置物体的位置和旋转。 |
| `PivotOffset` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | `[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0]` | 轴心偏移属性，使用 CFrame 表示物体轴心相对其基准位置的偏移量。默认值为单位变换，即轴心与基准位置重合。该偏移会影响物体进行空间变换时所使用的轴心点。 |
| `Position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0.0, 0.0, 0.0]` | 部件在世界空间中的位置坐标。 |
| `Rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | `[0.0, 0.0, 0.0, 1.0]` | [BasePart](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePart.html) 的旋转属性，使用四元数表示部件的朝向。 |
| `Scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[1.0, 1.0, 1.0]` | 部件的缩放比例。 |
| `Size` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | Size 属性用于设置或获取单位的基础尺寸。该属性类型为 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)，表示单位在 X、Y、Z 三个轴方向上的大小，可通过赋值 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 值来调整单位在场景中的体积。 |
| `ModelAlpha` | `Float` | `1` | 模型的整体透明度，取值范围通常为 0 到 1。 |
| `ModelVisible` | `Bool` | `true` | 控制模型是否可见，隐藏后仍参与物理碰撞 |
| `CastShadow` | `Bool` | `true` | 控制部件是否投射阴影。 |
| `ModelColor1` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 染色区域 1 的颜色；实际效果依赖模型资源是否包含对应 color mask，部分资源可能忽略 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) 赋值或表现为白色。 |
| `ModelColor2` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 染色区域 2 的颜色；实际效果依赖模型资源是否包含对应 color mask。 |
| `ModelColor3` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 染色区域 3 的颜色；实际效果依赖模型资源是否包含对应 color mask。 |
| `ModelColor4` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 染色区域 4 的颜色；实际效果依赖模型资源是否包含对应 color mask。 |
| `SkinId` | `String` | `""` | 皮肤资源的 ID，用于改变部件的外观风格。 |
| `UseCustomAppearance` | `Bool` | `false` | 是否启用自定义外观。 |
| `CustomAppearanceId` | `String` | `""` | 自定义外观资源的 ID，用于替换部件的默认外观。 |
| `OcclusionType` | `Int` | `3 (不处理)` | 设置角色类单位被该部件遮挡时采用的规则。当摄像机与角色之间被本部件隔开时，引擎会依据此属性的取值决定如何处理遮挡，从而避免视野被完全阻挡。 |
| `AssemblyRootPriority` | `Int` | `0` | 装配根节点的优先级，用于确定装配体中的主控部件。 |
| `AssemblyLinearVelocity` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | 部件所属装配体的线速度。 |
| `AssemblyAngularVelocity` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | 部件所属装配体的角速度。 |
| `AssemblyMass` | `Float` | `0` | 整个装配体的总质量。 |
| `AssemblyCenterOfMass` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | 部件所属装配体的质心位置。 |
| `IsStaticOptimization` | `Bool` | `false` | 是否启用静态优化，用于提高静态部件的性能。 |

## 关联类型

* [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)
* [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
* [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 函数 (9)

### IsNetworkOwnerSide

签名：`IsNetworkOwnerSide() -> Bool`

判断当前执行端是否为该部件的网络物理拥有者。

**返回值** `Bool`

> 示例代码

> 调用示例

```lua
-- @runtime client
local function demo(basePart)
    if basePart ~= nil then
        local result = basePart:IsNetworkOwnerSide()  -- 返回 Bool
        if result then
            print("调用结果为 true")
        else
            print("调用结果为 false")
        end
    end
end
```

### GetNetworkOwner

签名：`GetNetworkOwner() -> Player`

获取当前部件的物理网络拥有者，返回负责该部件物理模拟与控制的玩家对象。

⚙ 在服务端读取当前网络所有者；没有明确所有者时可能返回 nil。

**返回值** [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)

> 示例代码

> 服务端读取网络所有者

```lua
-- @runtime server
local World = game:GetService('World')
local part = World:CreateUnit('WorldUnit', {
    Position = Vector3.New(0, 5, 0),
    PhysicsActive = true,
})

local owner = part:GetNetworkOwner()
if owner ~= nil then
    print('网络所有者:', owner:GetName())
else
    print('当前没有指定网络所有者')
end
part:Destroy()
```

### SetNetworkOwner

签名：`SetNetworkOwner(player: Player) -> void`

设置当前部件的物理网络拥有者为指定玩家，将该部件的物理模拟与控制权移交给该客户端。

⚙ 在服务端把物理部件的网络所有权交给指定 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 要转移权限的玩家对象 |

**返回值** `void`

> 示例代码

> 服务端设置网络所有者

```lua
-- @runtime server
local Players = game:GetService('Players')
local World = game:GetService('World')

local player = Players:GetPlayers()[1]
if player ~= nil then
    local part = World:CreateUnit('WorldUnit', {
        Position = Vector3.New(0, 5, 0),
        PhysicsActive = true,
    })
    part:SetNetworkOwner(player)
    print('已设置网络所有者:', player:GetName())
    part:Destroy()
end
```

### IsWeldConstraintRoot

签名：`IsWeldConstraintRoot() -> Bool`

判断部件是否为焊接约束的根单位。

**返回值** `Bool`

> 示例代码

> 调用示例

```lua
-- @runtime client
local function demo(basePart)
    if basePart ~= nil then
        local result = basePart:IsWeldConstraintRoot()  -- 返回 Bool
        if result then
            print("调用结果为 true")
        else
            print("调用结果为 false")
        end
    end
end
```

### IsWeldConstraintChild

签名：`IsWeldConstraintChild() -> Bool`

判断部件是否为焊接约束的子单位。

**返回值** `Bool`

> 示例代码

> 调用示例

```lua
-- @runtime client
local function demo(basePart)
    if basePart ~= nil then
        local result = basePart:IsWeldConstraintChild()  -- 返回 Bool
        if result then
            print("调用结果为 true")
        else
            print("调用结果为 false")
        end
    end
end
```

### GetWeldConstraintRootId

签名：`GetWeldConstraintRootId() -> Int`

获取焊接约束中根单位的 ID。

**返回值** `Int`

> 示例代码

> 调用示例

```lua
-- @runtime client
local function demo(basePart)
    if basePart ~= nil then
        local result = basePart:GetWeldConstraintRootId()  -- 返回 Int
        if result ~= nil then
            print(result)
            if result ~= 0 then
                print("结果非零")
            end
        end
    end
end
```

### GetWeldConstraintId

签名：`GetWeldConstraintId() -> Int`

获取部件所属焊接约束的 ID。

**返回值** `Int`

> 示例代码

> 调用示例

```lua
-- @runtime client
local function demo(basePart)
    if basePart ~= nil then
        local result = basePart:GetWeldConstraintId()  -- 返回 Int
        if result ~= nil then
            print(result)
            if result ~= 0 then
                print("结果非零")
            end
        end
    end
end
```

### GetConnectedUnits

签名：`GetConnectedUnits() -> Map`

获取与当前部件通过约束组件建立连接关系的所有单位。该方法无需传入参数，返回一个以整数为键、[WorldUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/WorldUnit.html) 为值的映射表，映射表中的每个值代表一个与当前部件存在约束连接关系的单位实例。

**返回值** `Map`

> 示例代码

> 调用 GetConnectedUnits

```lua
-- @runtime client
local function demo(basePart)
    if basePart ~= nil then
        local result = basePart:GetConnectedUnits()  -- 返回 Map
        if result ~= nil then
            for key, item in pairs(result) do
                print(key, item)
            end
        end
    end
end
```

### SyncRenderToPhysics

签名：`SyncRenderToPhysics() -> void`

强制将本地渲染位置同步到最新的物理位置。

⚙ 最新 Meta 已公开 SyncRenderToPhysics，且未声明额外前置条件或单独 realm；当前运行包在客户端调用会触发运行时内部错误。在运行时实现与 Meta 对齐前请勿调用。

**返回值** `void`

> 示例代码

> 当前版本的接口可用性说明

```lua
-- @runtime client
local World = game:GetService('World')
local part = World:FindFirstChild('PhysicsPart', true)
if part ~= nil then
    print('已找到物理部件；当前运行包请勿调用 SyncRenderToPhysics')
end
```
