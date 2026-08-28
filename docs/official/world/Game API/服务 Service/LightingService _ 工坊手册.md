# LightingService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[LightingService]**（8 属性）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

光照服务，负责管理场景中的环境光与主光源。它提供环境光颜色与强度、主光源颜色与强度及朝向的调节能力，并支持电影色调映射、阴影淡化与反射立方体贴图配置，用于统一和营造场景的光照氛围。

## 适用场景

在实现昼夜变化、氛围切换或光照效果调试时使用。通过 game:GetService("LightingService") 获取服务后，按节奏动态修改环境光颜色、主光源朝向、电影色调映射和阴影淡化等属性，即可在运行期实时改变场景光照。

## 使用要点

先通过 game:GetService("LightingService") 获取服务实例，然后直接对其属性赋值即可生效。环境光与主光源颜色需用 Color.New(r, g, b, a) 构造，例如 lighting.AmbientColor = Color.New(255, 229, 178, 255)；主光源朝向需用 Vector3.New(x, y, z) 构造，例如 lighting.Orientation = Vector3.New(90, -45, 0)。之后可继续调整 lighting.FilmicTonemapEnabled、lighting.ShadowFade 与 lighting.Intensity 等属性来改变整体光照效果。

## 注意事项

[LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 的颜色属性（AmbientColor/Color）类型为 Color（RGBA，0-255 范围），必须用 Color.New(r, g, b, a) 构造，不能用 Color3.New(r, g, b)（[Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html) 是 RGB 0-1 范围的另一种类型）。例如暖黄色环境光应写 Color.New(255, 229, 178, 255)，不是 Color3.New(1.0, 0.9, 0.7)。Orientation 属性类型为 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)（欧拉角，角度制），必须用 Vector3.New(x, y, z) 赋值，不能用 [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)。

## 代码示例

### 设置环境光与主光颜色（Color 类型）

```lua
-- @runtime client
local LightingService = game:GetService('LightingService')
-- Color.New(r, g, b, a) 用 0-255 RGBA 范围
LightingService.AmbientColor = Color.New(255, 229, 178, 255)  -- 暖黄色环境光
LightingService.Color = Color.New(255, 255, 255, 255)  -- 白色主光
```

### 调整光源方向与阴影淡出

```lua
-- @runtime client
local LightingService = game:GetService('LightingService')
-- Orientation 是 Vector3 类型（欧拉角，角度制），不是 CFrame
LightingService.Orientation = Vector3.New(45, -30, 0)  -- 东南方向斜射
LightingService.ShadowFade = 0.5  -- 真实运行示例使用 0.0、0.5、1.0 调节淡化程度
```

## 属性 (8)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `AmbientColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(104, 104, 104, 255)` | 环境光颜色，影响场景中非直接光照区域的亮度和色调。 |
| `AmbientIntensity` | `Float` | `1.0` | 环境光强度，控制环境光对场景的照亮程度。 |
| `Color` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(225, 225, 225, 255)` | 主光源颜色，决定场景中直接光照的颜色。 |
| `Intensity` | `Float` | `2.0` | 主光源强度，控制主方向光的亮度。 |
| `Orientation` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[45, -45, 0]` | 主光源朝向，以欧拉角（角度制）表示光源的旋转方向。 |
| `FilmicTonemapEnabled` | `Bool` | `false` | 是否启用电影色调映射，开启后可获得更具电影感的画面效果。 |
| `ShadowFade` | `Float` | `0.0` | 阴影淡化系数，控制阴影随距离淡出的程度。 |
| `EnvironmentMap` | `String` | `official://cube/28` | [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 的 EnvironmentMap 属性，类型为字符串，用于指定环境反射所采用的立方体贴图资源标识。该属性可通过 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 服务实例直接读写。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
