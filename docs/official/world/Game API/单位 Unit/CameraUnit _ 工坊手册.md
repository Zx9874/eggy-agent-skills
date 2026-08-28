# CameraUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
    - **[CameraUnit]**（22 属性 / 2 函数 / 1 事件）

### 继承成员

2 个来源 / 7 属性 / 34 函数 / 6 事件

* 来自 [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)（3 属性 / 9 函数）
  + 属性：[`Tags`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`EcaPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)、[`Owner`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#properties)
  + 函数：[`HasTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`AddTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`RemoveTag`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`GetPivot`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`PivotTo`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`ApplyPivotDelta`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`TranslateBy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`IsTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)、[`FindTopLevel`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html#functions)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

相机单位是负责玩家视角渲染与控制的场景实例，支持通过位置、朝向、俯仰偏航滚转角度、视场角、投影模式与裁剪范围等手段精细调节画面，还能设定跟随目标与额外关注目标来驱动预设视角行为，并提供遮挡检测与相机移动重置等操作能力。

## 适用场景

常用于镜头演出、传送后视角重置、剧情特写或需要临时接管相机控制权（如切换为脚本模式后直接改写相机坐标矩阵）的场景。

## 使用要点

通过 game:GetService('World').CurrentCamera 获取当前活跃相机。设置 BehaviourType、Position、Rotation、Focus 等公开属性控制视角，调用 GetPartsObscuringTarget 检查目标点之间的遮挡。

## 注意事项

[CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) 是 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html) 自带的相机实例，必须通过 game:GetService('World').CurrentCamera 获取，不能用 World:CreateUnit('CameraUnit', {}) 创建（运行时会失败）。要切换活跃相机：1) 设置 Priority 大于当前活跃相机（数值越大优先级越高）；2) 确保 CameraService.MainCamera 已指向该实例或依赖自动选择逻辑。CameraService.LiveCamera（只读）始终指向当前实际渲染的相机，调试视角问题时优先看 LiveCamera 而非 MainCamera。Focus 在当前运行时表示相机关注点位置，按 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 使用。2026-08-11 当前编辑器运行时的 CurrentCamera 未提供 Meta 声明的 AfterUpdateState 信号，使用前必须判空。

## 代码示例

### 获取当前相机并检查遮挡

```lua
-- @runtime client
local World = game:GetService('World')
local camera = World.CurrentCamera
if camera == nil then return end

local ok, obscuringParts = pcall(function()
    return camera:GetPartsObscuringTarget({ Vector3.New(0, 5, 20) }, {})
end)
obscuringParts = ok and obscuringParts or {}
for _, part in ipairs(obscuringParts) do
    print('遮挡单位:', part.Name)
end
```

## 属性 (22)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 相机当前位置，预设行为下会按参照更新此状态。 |
| `Rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | `-` | 相机当前的朝向，以四元数表示。在预设行为下，该值会根据追踪目标或脚本控制自动更新。 |
| `Pitch` | `Float` | `-` | 相机的俯仰角，单位为度，用于控制视角的上下角度，参考世界坐标系的上方向。 |
| `Yaw` | `Float` | `-` | 相机的偏航角，单位为度，用于控制视角的左右方向。 |
| `Roll` | `Float` | `-` | 相机的滚转角，单位为度，沿前后方向旋转，使画面倾斜。 |
| `TrackingUnit` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | `-` | 标记当前相机跟随的目标单位，供相机行为逻辑参考。 |
| `ExtraSubject` | [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | `-` | 相机的额外关注目标，默认为空；非空时，预设的相机行为会参考该目标来调整朝向状态。 |
| `FieldOfView` | `Float` | `-` | 相机的垂直视场角，单位为度。 |
| `FieldOfViewMode` | [FieldOfViewMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/FieldOfViewMode.html) | `-` | 相机视场角模式，使用 Enums.FieldOfViewMode.Vertical、Enums.FieldOfViewMode.Diagonal 或 Enums.FieldOfViewMode.MaxAxis。 |
| `ProjectionType` | [CameraProjection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraProjection.html) | `-` | 相机的投影模式。 |
| `NearPlaneZ` | `Float` | `-` | 近裁剪平面距离。 |
| `ViewportSize` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | `-` | 视口尺寸，以像素为单位。 |
| `Focus` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | 相机关注点位置。当前运行时按 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 位置值读写，不是 CFrame。 |
| `CFrame` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | `-` | 相机的坐标矩阵，包含位置与旋转信息，用于表示相机在世界空间中的完整姿态。 |
| `Priority` | `Float` | `-` | 相机的展示优先级。全局最高优先级的相机会操作实际的渲染相机。 |
| `IsActive` | `Bool` | `-` | 相机是否处于激活状态。 |
| `ClippingRange` | [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) | `-` | 相机裁剪平面范围，X 分量为近裁剪面距离，Y 分量为远裁剪面距离。 |
| `Distance` | `Float` | `-` | 相机与跟随目标之间的距离。 |
| `ScriptableBehaviour` | `Table` | `-` | 相机的脚本行为，允许自定义相机更新逻辑。 |
| `Mode` | [CameraMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraMode.html) | `-` | 相机的行为模式，使用 Eggy 原生模式。 |
| `CameraType` | [CameraType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraType.html) | `-` | 相机类型，该属性会自动映射到 Mode 属性。 |
| `DevCameraOcclusionMode` | [DevCameraOcclusionMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DevCameraOcclusionMode.html) | `-` | 相机遮挡处理模式，使用 Enums.DevCameraOcclusionMode.Zoom、Enums.DevCameraOcclusionMode.Invisicam 或 Enums.DevCameraOcclusionMode.EggyHybrid。 |

## 关联类型

* [SpaceUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SpaceUnit.html)
* [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)
* [CameraMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraMode.html)
* [CameraProjection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraProjection.html)
* [CameraType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraType.html)
* [DevCameraOcclusionMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DevCameraOcclusionMode.html)
* [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)
* [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 事件 (1)

### AfterUpdateState

签名：`AfterUpdateState(delta: Float)` 触发：`local`

相机状态更新后触发的事件，每帧调用一次，参数 delta 表示自上一帧以来的时间间隔（秒）。

⚙ 公开 Meta 声明该事件，但当前编辑器运行时的 CurrentCamera 上该信号为 nil；运行包补齐前只能做兼容性判空。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `delta` | `Float` | 帧间隔时间 |

> 示例代码

> 兼容性监听相机更新事件

```lua
-- @runtime client
local camera = game:GetService('World').CurrentCamera
if camera == nil then return end
local signal = camera.AfterUpdateState
if signal == nil then
    print('当前运行时暂未提供 CameraUnit.AfterUpdateState')
    return
end
signal:Once(function(delta)
    print('相机更新完成，帧间隔:', delta)
end)
```

## 函数 (2)

### GetPartsObscuringTarget

签名：`GetPartsObscuringTarget(castPoints: Array, ignoreList: Array) -> Array&lt;Unit&gt; (遮挡视线的单位列表)`

获取遮挡相机视线的单位列表。传入检测点数组与忽略单位数组，返回从检测点到相机之间会遮挡视线的单位列表。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `castPoints` | `Array` | 射线检测目标点列表 |
| `ignoreList` | `Array` | 忽略的单位列表 |

**返回值** Array<[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)> (遮挡视线的单位列表)

> 示例代码

> 读取目标点前的遮挡单位

```lua
-- @runtime client
local camera = game:GetService('World').CurrentCamera
if camera == nil then return end
local ok, obscuringParts = pcall(function()
    return camera:GetPartsObscuringTarget({ Vector3.New(0, 5, 20) }, {})
end)
obscuringParts = ok and obscuringParts or {}
for _, part in ipairs(obscuringParts) do
    print('遮挡单位:', part.Name)
end
```

### ResetMovement

签名：`ResetMovement() -> void`

重置相机的移动状态。

**返回值** `void`

> 示例代码

> 重置相机移动状态

```lua
-- @runtime client
-- 获取当前相机实例
local world = game:GetService("World")
local camera = world.CurrentCamera
if camera == nil then return end

-- 重置相机移动状态（例如在脚本控制相机后恢复默认行为）
camera:ResetMovement()
print("相机移动状态已重置")
```
