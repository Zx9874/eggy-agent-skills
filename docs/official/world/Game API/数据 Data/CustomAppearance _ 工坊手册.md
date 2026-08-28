# CustomAppearance

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[CustomAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CustomAppearance.html) 是由主模型和若干 [SubCustomAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/SubCustomAppearance.html) 子模型组成的可复用外观数据，记录模型资源、皮肤、染色区域、材质、透明度、阴影、旋转与缩放等公开配置。

## 适用场景

编辑器中可通过「合并外观」或自定义外观管理面板维护资源；运行时可把字段对齐的外观数据交给 [CustomAppearanceService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/CustomAppearanceService.html) 创建临时外观，再把返回的 ID 应用到支持自定义外观的单位。

## 使用要点

Lua 不能直接构造 [CustomAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CustomAppearance.html)。运行时先准备字段对齐的数据表并调用 CustomAppearanceService:CreateCustomAppearance(data)，再将直接返回的 ID 字符串写入单位 CustomAppearanceId，同时启用 UseCustomAppearance。

## 注意事项

Id 由系统生成且只读。编辑器保存的外观资源更新后，引用它的组件会随资源更新；[CustomAppearanceService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/CustomAppearanceService.html) 创建的运行时外观只增不改不删，需变更时应使用新数据重新创建并替换单位上的 CustomAppearanceId。

## 属性 (15)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Id` | `String` | `""` | 系统生成的自定义外观 ID，只读；运行时创建的 ID 形如 runtime://appearance/<int>。 |
| `Name` | `String` | `node` | 外观名称。 |
| `RenderMeshId` | `String` | `official://mesh/59268` | 主模型使用的 Mesh 资源 URI。 |
| `SkinId` | `String` | `""` | 主模型应用的皮肤资源 URI；为空时不设置皮肤。 |
| `ModelColor1` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 主模型染色区域 1 的颜色；仅当模型支持该染色区域时生效。 |
| `ModelColor2` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 主模型染色区域 2 的颜色；仅当模型支持该染色区域时生效。 |
| `ModelColor3` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 主模型染色区域 3 的颜色；仅当模型支持该染色区域时生效。 |
| `ModelColor4` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 主模型染色区域 4 的颜色；仅当模型支持该染色区域时生效。 |
| `MaterialParam` | [MaterialParam](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MaterialParam.html) | `-` | 主模型的材质参数，用于调整模型的材质表现。 |
| `ModelAlpha` | `Float` | `1` | 主模型透明度，取值 0（完全透明）到 1（不透明）。 |
| `MainModelVisible` | `Bool` | `true` | 是否显示主模型；关闭后仅显示 SubAppearance 中的子模型。 |
| `CastShadow` | `Bool` | `true` | 主模型是否投射阴影。 |
| `Rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | `[0.0, 0.0, 0.0, 1.0]` | 外观整体的旋转四元数。 |
| `Scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[1.0, 1.0, 1.0]` | 外观整体的三轴缩放。 |
| `SubAppearance` | Array<[SubCustomAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/SubCustomAppearance.html)> | `[]` | 子模型列表；每个元素是一份 [SubCustomAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/SubCustomAppearance.html) 子外观数据。 |

## 关联类型

* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
* [MaterialParam](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MaterialParam.html)
* [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)
* [SubCustomAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/SubCustomAppearance.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
