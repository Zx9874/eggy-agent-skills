# SubCustomAppearance

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[SubCustomAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/SubCustomAppearance.html) 描述 [CustomAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CustomAppearance.html) 中一个子模型的公开外观数据，包括模型与皮肤资源、染色区域、挂点、相对变换、材质、透明度和阴影设置。

## 适用场景

需要用多个模型部件组合运行时自定义外观时，为每个子模型分别创建一份数据，再放入 [CustomAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CustomAppearance.html) 的 SubAppearance 列表。

## 使用要点

调用 SubCustomAppearance.New(initData) 创建数据；Rotation 必须使用 [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)，Offset 和 Scale 使用 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)。创建后把实例放入传给 CustomAppearanceService:CreateCustomAppearance 的 SubAppearance 数组。

## 注意事项

该类型是可构造 Data，不是场景 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)，不能使用 World:CreateUnit 创建。资源 URI 必须来自项目实际可用资源，SocketName 必须匹配主模型挂点，ModelAlpha 取值为 0 到 1。

## 代码示例

### 创建子模型数据并用于运行时外观

```lua
-- @runtime client
local appearances = game:GetService("CustomAppearanceService")
-- 客户端创建的运行时外观仅本端可见；需全端同步时请在服务端执行
local sub = SubCustomAppearance.New({
    RenderMeshId = "official://mesh/59268",
    SkinId = "official://skin/10001",
    SocketName = "Head",
    Offset = Vector3.New(0, 0.15, 0),
    Rotation = Quaternion.FromEulerAngles(0, math.rad(15), 0),
    Scale = Vector3.New(1, 1, 1),
    ModelAlpha = 0.8,
    CastShadow = true,
})
local appearanceId = appearances:CreateCustomAppearance({
    Name = "AccessoryAppearance",
    MainModelVisible = false,
    SubAppearance = { sub },
})
print("运行时外观 ID:", appearanceId)
```

## 属性 (13)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `RenderMeshId` | `String` | `official://mesh/59268` | 子自定义外观使用的模型资源标识。 |
| `SkinId` | `String` | `""` | 子自定义外观使用的皮肤资源标识。 |
| `ModelColor1` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 子自定义外观模型的染色区域1颜色。 |
| `ModelColor2` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 子自定义外观模型的染色区域2颜色。 |
| `ModelColor3` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 子自定义外观模型的染色区域3颜色。 |
| `ModelColor4` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 子自定义外观模型的染色区域4颜色。 |
| `SocketName` | `String` | `""` | 子自定义外观挂载到角色或模型上的挂点名称。 |
| `Offset` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0.0, 0.0, 0.0]` | 子自定义外观相对挂点的位置偏移。 |
| `Rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | `[0.0, 0.0, 0.0, 1.0]` | 子自定义外观相对挂点的旋转。 |
| `Scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[1.0, 1.0, 1.0]` | 子自定义外观相对挂点的缩放。 |
| `MaterialParam` | [MaterialParam](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MaterialParam.html) | `-` | 子自定义外观使用的材质参数对象，用于调整外观部件的材质表现。 |
| `ModelAlpha` | `Float` | `1` | 子自定义外观整体模型的透明度。 |
| `CastShadow` | `Bool` | `true` | 控制该子自定义外观是否投射阴影。 |

## 关联类型

* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
* [MaterialParam](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MaterialParam.html)
* [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 函数 (1)

### New

签名：`New(initData?: Table) -> SubCustomAppearance`

创建子自定义外观数据对象。子自定义外观用于描述一个可挂接到角色或模型上的外观部件，包含模型资源、皮肤、染色、挂点、位置、旋转、缩放等配置。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `initData?` | `Table` | 初始属性表 |

**返回值** [SubCustomAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/SubCustomAppearance.html)

> 示例代码

> 构造一份子模型外观数据

```lua
-- @runtime client
local sub = SubCustomAppearance.New({
    RenderMeshId = "official://mesh/59268",
    Offset = Vector3.New(0, 0.15, 0),
    Rotation = Quaternion.FromEulerAngles(0, math.rad(15), 0),
    Scale = Vector3.New(1, 1, 1),
    ModelAlpha = 0.8,
})
print("子模型透明度:", sub.ModelAlpha)
```
