# CameraService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[CameraService]**（5 属性 / 6 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

负责全局摄像机管理的服务，提供当前展示相机与主控相机的访问，支持世界坐标与屏幕坐标、视口坐标的相互转换，并能将屏幕位置转换为射线，同时支持手动刷新相机以及触发摄像机震动。它还管理默认相机预设和跟随重置时的水平、俯仰朝向行为。

## 适用场景

常用于界面中将世界物体位置映射到屏幕坐标，或从屏幕点击生成射线进行拾取与交互，也可在特定玩法中通过镜头震动增强表现。

## 使用要点

先确认客户端已有可用的 MainCamera，再进行坐标转换或由屏幕点生成射线；射线检测还需同时确认目标对象的 PhysicsActive、CanQuery 与碰撞组配置。最新 Meta 已声明 [CameraShakeType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeType.html) 与 [CameraShakeCurve](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeCurve.html)，但当前运行包缺少对应枚举导出，不要在正式逻辑中调用 ShakeCamera。

## 注意事项

最新 Meta 已声明 ShakeCamera、[CameraShakeType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeType.html) 与 [CameraShakeCurve](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeCurve.html)；当前运行包实测 Enums.CameraShakeType 仍会报 module not found，这是运行时枚举导出未对齐 Meta，而不是公开契约缺少枚举。Meta 未给 ShakeCamera 单独标注 realm，当前运行包应按服务端调用路径验证；在枚举导出恢复前暂不可用，也不要用数字或字符串绕过枚举契约。Meta 约定 MainCamera 默认指向当前展示相机，但运行时相机尚未初始化时实测仍可能为 nil；无可用 MainCamera、目标点位于相机后方或相机状态未就绪时，WorldToScreenPoint/WorldToViewportPoint 可能返回零向量和 false。ScreenPointToRay 得到射线后仍需确认目标 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 已启用 PhysicsActive/CanQuery，且碰撞组过滤允许命中。

## 代码示例

### 屏幕坐标转射线并执行 Raycast 命中检测

```lua
-- @runtime client
-- 获取 CameraService 与 PhysicsService
local CameraService = game:GetService("CameraService")
local PhysicsService = game:GetService("PhysicsService")

-- 示例像素坐标（实际项目中应按当前屏幕分辨率计算）
local screenX = 640
local screenY = 360
local depth = 0.0

if CameraService.MainCamera == nil then
    print("MainCamera 尚未就绪，无法生成可靠射线")
    return
end

-- 屏幕坐标 → 世界射线
local ray = CameraService:ScreenPointToRay(screenX, screenY, depth)
print("射线起点:", ray.Origin, "方向:", ray.Direction)

-- 构造 Raycast 的方向向量：方向 * 最大距离
local direction = ray.Direction * 500

-- 执行 Raycast：目标还必须启用 CanQuery/PhysicsActive，碰撞组过滤也需允许命中
local hitResult = PhysicsService:Raycast(ray.Origin, direction)
if hitResult then
    print("命中位置:", hitResult.Position, "命中实例:", hitResult.Instance)
else
    print("未命中任何物体")
end
```

### 在 Heartbeat 循环中持续从相机方向发射射线

```lua
-- @runtime client
local CameraService = game:GetService("CameraService")
local PhysicsService = game:GetService("PhysicsService")
local RunService = game:GetService("RunService")
local frameCount = 0

-- 演示 300 帧后自动断开；正式准星逻辑应在对应页面退出时清理连接
local connection
connection = RunService.Heartbeat:Connect(function(deltaTime)
    frameCount = frameCount + 1
    -- 坐标转换和射线接口实际依赖 MainCamera
    if CameraService.MainCamera == nil then
        if frameCount >= 300 then connection:Disconnect() end
        return
    end

    local ray = CameraService:ScreenPointToRay(640, 360, 0.0)
    local direction = ray.Direction * 1000
    local hit = PhysicsService:Raycast(ray.Origin, direction)
    if hit then
        print("准星命中:", hit.Instance)
    end
    if frameCount >= 300 then
        connection:Disconnect()
    end
end)
```

## 属性 (5)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `LiveCamera` | [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) | `-` | 当前正在展示的相机实例，如果没有激活的相机则为空。 |
| `MainCamera` | [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html) | `-` | 主控相机，默认指向当前展示相机，可手动设置为其他相机以便标记和获取。 |
| `DefaultCameraPreset` | [DefaultCameraPresetType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DefaultCameraPresetType.html) | `-` | 默认相机预设，设置为其他预设时会在游戏初始化调整主控相机属性和功能。 |
| `ResetYaw` | `Bool` | `-` | 相机跟随重置时是否重置水平朝向(yaw)，默认true。 |
| `ResetPitch` | `Bool` | `-` | 相机跟随重置时是否重置俯仰角(pitch)，默认true。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html)
* [DefaultCameraPresetType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DefaultCameraPresetType.html)

## 函数 (6)

### WorldToScreenPoint

签名：`WorldToScreenPoint(worldPoint: Vector3) -> Vector3, Bool (屏幕坐标与是否位于屏幕范围内)`

将世界坐标转换为屏幕坐标。Lua 返回值第一项为 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 屏幕坐标，第二项为 Bool isOnScreen，表示该点是否位于屏幕范围内。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `worldPoint` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界坐标 |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html), Bool (屏幕坐标与是否位于屏幕范围内)

> 示例代码

> 世界坐标转换为屏幕坐标并判断可见性

```lua
-- @runtime client
local cameraService = game:GetService("CameraService")

if cameraService.MainCamera == nil then
    print("MainCamera 尚未就绪")
    return
end
local worldPoint = Vector3.New(0, 5, 0)
local screenPoint, isOnScreen = cameraService:WorldToScreenPoint(worldPoint)
print("屏幕坐标:", screenPoint, "是否在屏幕内:", isOnScreen)
```

### WorldToViewportPoint

签名：`WorldToViewportPoint(worldPoint: Vector3) -> Vector3, Bool (视口坐标与是否位于视口范围内)`

将世界坐标转换为视口坐标（不包含 GUI inset）。Lua 返回值第一项为 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 视口坐标，第二项为 Bool isInViewport，表示该点是否位于视口范围内。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `worldPoint` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界坐标 |

**返回值** [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html), Bool (视口坐标与是否位于视口范围内)

> 示例代码

> 世界坐标转换为视口坐标并判断可见性

```lua
-- @runtime client
local cameraService = game:GetService("CameraService")

if cameraService.MainCamera == nil then
    print("MainCamera 尚未就绪")
    return
end
local worldPoint = Vector3.New(0, 5, 0)
local viewportPoint, isInViewport = cameraService:WorldToViewportPoint(worldPoint)
print("视口坐标:", viewportPoint, "是否在视口内:", isInViewport)
```

### ScreenPointToRay

签名：`ScreenPointToRay(x: Float, y: Float, depth?: Float) -> Ray (世界射线)`

将屏幕坐标转换为世界空间中的射线，可用于实现点击拾取或射线检测。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `x` | `Float` | 屏幕X坐标（像素） |
| `y` | `Float` | 屏幕Y坐标（像素） |
| `depth?` | `Float` | 射线起点深度，默认 0 |

**返回值** [Ray](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Ray.html) (世界射线)

> 示例代码

> 屏幕坐标转世界射线

```lua
-- @runtime client
local cameraService = game:GetService('CameraService')
if cameraService.MainCamera == nil then
    print('MainCamera 尚未就绪')
    return
end
local ray = cameraService:ScreenPointToRay(640, 360, 0)
print('射线原点:', ray.Origin, '方向:', ray.Direction)
```

### ViewportPointToRay

签名：`ViewportPointToRay(x: Float, y: Float, depth?: Float) -> Ray (世界射线)`

将视口坐标转换为世界空间中的射线，可用于从视口位置进行射线检测。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `x` | `Float` | 视口X坐标 ([0, 1]) |
| `y` | `Float` | 视口Y坐标 ([0, 1]) |
| `depth?` | `Float` | 射线起点深度，默认 0 |

**返回值** [Ray](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Ray.html) (世界射线)

> 示例代码

> 视口坐标转世界射线

```lua
-- @runtime client
local cameraService = game:GetService('CameraService')
if cameraService.MainCamera == nil then
    print('MainCamera 尚未就绪')
    return
end
local ray = cameraService:ViewportPointToRay(0.5, 0.5, 0)
print('射线原点:', ray.Origin, '方向:', ray.Direction)
```

### ManualRefresh

签名：`ManualRefresh() -> void`

手动刷新相机，用于属性变更后需要立刻生效展示的功能。

**返回值** `void`

> 示例代码

> 手动刷新相机

```lua
-- @runtime client
-- 获取 CameraService 服务实例
local cameraService = game:GetService("CameraService")

-- 调用 ManualRefresh 手动刷新相机，使属性变更立即生效
cameraService:ManualRefresh()

-- 输出确认调用完成
print("CameraService:ManualRefresh 已调用")
```

### ShakeCamera

签名：`ShakeCamera(player: Player, shakeType: CameraShakeType, maxAmplitude: Float, shakeTime: Float, shakeCurve: CameraShakeCurve) -> void`

设置玩家屏幕震动，通过指定震动类型、最大振幅、持续时间和震动曲线来控制屏幕震动的表现效果。

⚙ 最新 Meta 已声明 [CameraShakeType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeType.html) 与 [CameraShakeCurve](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeCurve.html)，但当前运行包没有正确导出 Enums.CameraShakeType，直接访问会报 module not found；在运行时枚举导出与 Meta 对齐前请勿调用 ShakeCamera。不要用数字或字符串绕过公开枚举契约。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `player` | [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) | 玩家 |
| `shakeType` | [CameraShakeType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeType.html) | 震动类型 |
| `maxAmplitude` | `Float` | 震动最大幅度 |
| `shakeTime` | `Float` | 震动时间 |
| `shakeCurve` | [CameraShakeCurve](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeCurve.html) | 震动曲线 |

**返回值** `void`

> 示例代码

> 当前版本暂不可调用 ShakeCamera

```lua
-- @runtime server
-- Meta 已声明 CameraShakeType；当前运行包仍缺少对应枚举导出
print("ShakeCamera 当前版本暂不可用")
```
