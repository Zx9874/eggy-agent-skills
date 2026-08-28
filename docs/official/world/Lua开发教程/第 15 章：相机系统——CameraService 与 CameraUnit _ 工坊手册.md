# 第 15 章：相机系统——CameraService 与 CameraUnit

读取活跃相机、完成坐标转换与准星射线，并区分相机配置和渲染状态。

## 你会学到什么

* `CameraService` 和 `CameraUnit` 的分工。
* 如何获取当前相机，以及什么时候才需要创建自定义相机。
* 如何把世界坐标转换成屏幕坐标，用 UI 标记场景目标。
* 如何从屏幕点生成射线，配合 Raycast 做准星/点击拾取。
* 如何理解相机震动的公开契约与行为验证边界。

## 先分清两个概念

相机系统最容易混淆的是“服务”和“相机实例”：

| 名称 | 你可以把它理解成 | 常见用途 |
| --- | --- | --- |
| `CameraService` | 全局相机管理器 | 坐标转换、屏幕/视口射线、当前相机引用、相机震动 |
| `CameraUnit` | 场景里的相机实例 | 位置、旋转、FOV、跟随目标、遮挡检测、每帧相机状态 |

新手最常用的是 `CameraService` 的坐标转换和 `World.CurrentCamera` 的当前相机信息。只有做过场、脚本相机、相机跟随策略时，才需要深入 `CameraUnit` 的行为模式。

## 获取当前相机

当你只是读取玩家当前看到的画面时，不需要新建相机：从 `World.CurrentCamera` 获取当前相机，或从 `CameraService.LiveCamera` 查看当前实际渲染的相机。当前 Meta 允许创建 `CameraUnit`；创建能力留给过场、多相机切换等明确需求，不能再写成“CameraUnit 不可创建”。

运行端：client

```lua
local World = game:GetService("World")
local CameraService = game:GetService("CameraService")
if not World or not CameraService then return end

local camera = World.CurrentCamera
if not camera then
    print("[SE Lua Guide] 当前还没有可用相机")
    return
end

print("[SE Lua Guide] 当前相机:", camera.Name)
local liveCamera = CameraService.LiveCamera
print("[SE Lua Guide] 实际渲染相机:", liveCamera and liveCamera.Name or "尚未就绪")
print("[SE Lua Guide] 相机 FOV:", camera.FieldOfView)
```

`CameraService.MainCamera` 是可手动设置的主控相机引用，初始化完成后默认指向当前展示相机；在初始化窗口仍应允许它暂时为 nil。调试“此刻实际渲染什么”时，优先看 `LiveCamera` 或 `World.CurrentCamera`。

## 世界坐标转屏幕坐标

把 3D 世界坐标转成屏幕坐标，常用于“目标头顶图标”“任务点箭头”“敌人标记”。`WorldToScreenPoint` / `WorldToViewportPoint` 都需要当前有活跃相机；没有相机时，结果可能是零向量。

运行端：client

```lua
local CameraService = game:GetService("CameraService")
if not CameraService or not CameraService.LiveCamera then
    print("[SE Lua Guide][WARN] 当前没有活跃相机。")
    return
end

local targetPos = Vector3(10, 5, 20)
local screenPos, isOnScreen = CameraService:WorldToScreenPoint(targetPos)
local viewportPos, isInViewport = CameraService:WorldToViewportPoint(targetPos)

print("[SE Lua Guide] 屏幕坐标:", screenPos, "屏幕内:", isOnScreen)
print("[SE Lua Guide] 视口坐标:", viewportPos, "视口内:", isInViewport)
```

坐标转换有两个细节：

| 问题 | 说明 |
| --- | --- |
| 返回值是什么 | 返回 `Vector3` 和一个布尔值；X/Y 是屏幕或视口坐标，Z 表示深度，布尔值表示是否在屏幕/视口内。 |
| 什么时候会不可靠 | 当前没有活跃相机、目标在相机后方、目标离裁剪面太近或太远时。 |

做 UI 标记时，不要只判断“有没有返回值”，还要结合深度和项目实际效果处理屏幕外目标。例如目标在背后时，可以隐藏标记或把箭头吸附到屏幕边缘。

## 屏幕点或视口点转射线

准星拾取、点击物体、射击检测通常分两步：

```text
屏幕像素 -> CameraService:ScreenPointToRay()
归一化视口点 -> CameraService:ViewportPointToRay()
射线 -> PhysicsService:Raycast()
```

注意 Raycast 的第二个参数是“方向 × 距离”，不是终点坐标。这一点和第 12 章保持一致。

运行端：client

```lua
local CameraService = game:GetService("CameraService")
local PhysicsService = game:GetService("PhysicsService")
if not CameraService or not PhysicsService or not CameraService.LiveCamera then return end

-- ViewportPointToRay 使用 [0, 1] 归一化坐标；(0.5, 0.5) 是视口中心。
local ray = CameraService:ViewportPointToRay(0.5, 0.5, 0)
local maxDistance = 500
local result = PhysicsService:Raycast(ray.Origin, ray.Direction * maxDistance)

if result then
    local hitUnit = result.Instance
    print("[SE Lua Guide] 准星命中:", hitUnit and hitUnit.Name or "未知对象")
    print("[SE Lua Guide] 命中位置:", result.Position)
else
    print("[SE Lua Guide] 准星没有命中")
end
```

如果要每帧检测准星命中，需要节流输出日志，并在不再使用时断开 `Heartbeat` 连接。不要每帧打印完整命中信息，否则日志会很快被刷满。

## CameraUnit 能做什么

当前相机是 `CameraUnit`，可以读取相机状态，也可以使用它的专门能力。

```lua
local World = game:GetService("World")
if not World then return end

local camera = World.CurrentCamera
if camera and camera:IsA("CameraUnit") then
    print("[SE Lua Guide] 相机位置:", camera.Position)
    print("[SE Lua Guide] 相机朝向:", camera.Rotation)
    print("[SE Lua Guide] 相机模式:", camera.CameraType)
end
```

常用字段：

| 字段 | 用途 |
| --- | --- |
| `Position` / `Rotation` | 当前相机位置和朝向。 |
| `FieldOfView` | 视野宽窄。数值越大，看得越广，透视感越强。 |
| `TrackingUnit` / `ExtraSubject` | 相机跟随目标与额外关注目标。 |
| `Priority` | 多相机切换时的展示优先级，数值越大越容易接管画面。 |
| `DevCameraOcclusionMode` | 相机被遮挡时的处理策略。 |
| `AfterUpdateState` | 相机状态更新后的本地事件。 |

更进阶的脚本相机需要理解 `ScriptableBehaviour`、`Mode`、`CameraType`、`Priority` 和相机切换。本系列只要求你先会读当前相机、做坐标转换和拾取检测；这些字段的组合行为必须按具体模式单独验证，不能靠字段名猜测。

## 遮挡检测

`CameraUnit:GetPartsObscuringTarget(castPoints, ignoreList)` 可以检查相机到若干目标点之间是否有遮挡物，适合做“角色被墙挡住时半透明”“目标被遮挡时隐藏标记”等表现。

```lua
local World = game:GetService("World")
local Players = game:GetService("Players")
if not World or not Players then return end

local camera = World.CurrentCamera
local player = Players.LocalPlayer
if not player then return end

local character = player.Character

if camera and camera:IsA("CameraUnit") and character and character:IsA("EggyUnit") then
    local targetPos = character:GetPosition()
    local obscuredUnits = camera:GetPartsObscuringTarget({ targetPos }, { character })

    for _, unit in ipairs(obscuredUnits) do
        print("[SE Lua Guide] 遮挡相机的对象:", unit.Name)
    end
end
```

## 相机震动

当前实时 Meta/API 已公开 `ShakeCamera` 方法及其 player、shakeType、maxAmplitude、shakeTime、shakeCurve 参数，也公开了 `Enums.CameraShakeType.FRONT_AND_BACK / UP_AND_DOWN / ROTATE` 与 `Enums.CameraShakeCurve.SINE / NOISE`。

但最后一份可用的 Game Runtime 行为证据仍显示访问配套枚举会报 `module not found`；本轮又因专用地图存在用户代码差异，不能在 client/server 试玩态安全复测。因此在得到新的行为通过证据前，完整调用链暂不可用，本章不提供可复制的震动调用。这个阻断也不允许用裸数字或字符串绕过。

## 表现层归属

相机通常是表现层，但不等于所有相机代码都放在 client。

| 需求 | 推荐运行端 | 原因 |
| --- | --- | --- |
| 本地准星检测、UI 标记 | client | 只影响本地画面，响应要快。 |
| 玩家受击震动 | server 决定结果，完整调用链需实测 | 当前契约已公开，运行行为仍需在干净试玩环境验证。 |
| 过场镜头 | 视情况 | 单人本地过场可 client；多人共同事件由 server 统一触发。 |
| 玩法命中判定 | server | client 的射线可用于预览，最终结果要由 server 校验。 |

## 常见错误

### 错误：为了读取当前画面重复创建 CameraUnit

CameraUnit 当前允许创建，但读取当前画面不需要新建对象。先从 `World.CurrentCamera` 或 `CameraService.LiveCamera` 获取；只有明确设计自定义过场或多相机切换时才创建，并负责激活、优先级和恢复。

### 错误：把 Raycast 第二个参数当终点

`PhysicsService:Raycast(origin, direction, raycastParams)` 的 `direction` 是方向向量乘最大距离；第三个过滤参数按 Meta 可省略。射线检测应写 `ray.Direction * 500`，不是 `ray.Origin + ray.Direction * 500`。

### 错误：把屏幕像素和归一化视口坐标混用

`ScreenPointToRay(x, y)` 的 x/y 是屏幕像素；`ViewportPointToRay(x, y)` 的 x/y 才是 `[0, 1]` 归一化视口坐标。视口中心用 `ViewportPointToRay(0.5, 0.5, 0)`，不能把相同参数直接传给 ScreenPointToRay。

### 错误：用数字绕过相机震动枚举

公开枚举是调用契约的一部分。即使目标运行包出现导出问题，也应停止调用并记录版本证据，不能把枚举值改成裸数字或字符串规避错误。

### 错误：每帧打印相机和命中信息

调试时可以临时打印，但 Heartbeat 中必须节流，否则日志会淹没真正的问题。

## 练习任务

1. 读取 `World.CurrentCamera`，打印相机位置、FOV 和 `CameraService.LiveCamera`。
2. 把场景中一个目标的世界坐标转换为屏幕坐标，设计一个 UI 标记。
3. 用 `ViewportPointToRay` + `PhysicsService:Raycast` 实现视口中心准星拾取。
4. 为相机射线示例补充活跃相机未就绪与未命中的保护分支。

## 本章验收标准

* [ ] 我知道 `CameraService` 与 `CameraUnit` 的区别。
* [ ] 我知道当前相机应从 `World.CurrentCamera` / `CameraService.LiveCamera` 获取。
* [ ] 我能用 `WorldToScreenPoint` 做 3D 目标标记。
* [ ] 我能区分 `ScreenPointToRay` 的像素坐标与 `ViewportPointToRay` 的归一化坐标。
* [ ] 我能用视口射线配合 Raycast 做拾取检测。
* [ ] 我知道 `ShakeCamera` 当前已公开，但本轮尚无干净试玩态行为证据，也不会使用裸数字绕过枚举。

## 本章产物

* 一个准星拾取或 3D 目标标记示例，能打印命中对象和屏幕坐标。
* 一段带相机就绪检查与未命中处理的射线检测代码。
* 一张相机表现分工表，区分本地画面、共同事件和玩法判定。

## 本章 API 对照

* [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)
* [CameraService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/CameraService.html)
* [CameraUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/CameraUnit.html)
* [Ray](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Ray.html)
* [CameraShakeType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeType.html)
* [CameraShakeCurve](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CameraShakeCurve.html)

## 下一章预告

3C（角色、控制、相机）学完后，下一章进入更完整的表现层：音效、特效、光照、天空和后处理。
