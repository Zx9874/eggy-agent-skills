# BakeMode

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → BakeMode

[BakeMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/BakeMode.html) 是寻路烘焙模式枚举，用于控制 [PathfindingModifier](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PathfindingModifier.html) 对导航网格烘焙的参与方式。它提供 Auto、Force、Ignore、Disable 四种模式，便于按区域决定是否自动烘焙、强制烘焙、忽略或禁用导航烘焙。

## 适用场景

在配置 [PathfindingModifier](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/PathfindingModifier.html) 时，通过 [BakeMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/BakeMode.html) 指定该区域如何参与寻路导航网格构建，例如强制某个区域参与烘焙，或让临时/装饰区域忽略烘焙。

## 使用要点

通过 Enums.BakeMode.Auto、Enums.BakeMode.Force、Enums.BakeMode.Ignore、Enums.BakeMode.Disable 等形式引用枚举成员，并赋值给 PathfindingModifier.BakeMode。

## 注意事项

[BakeMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/BakeMode.html) 只描述寻路/导航网格烘焙策略，不是光照烘焙设置。Auto 在动态 NavMesh 更新启用时允许静态与动力学物体参与烘焙，否则仅静态物体参与；Force 强制参与；Ignore 将物体视为不存在；Disable 会生成不可走区域，且物体上表面不生成 Mesh。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Auto` | 自动选择参与策略：动态 NavMesh 更新启用时静态与动力学物体都参与，否则仅静态物体参与。 |
| `1` | `Force` | 强制物体参与导航网格烘焙。 |
| `2` | `Ignore` | 烘焙时忽略该物体，将其视为不存在。 |
| `3` | `Disable` | 在物体处生成不可走区域，并且上表面不生成 Mesh。 |
