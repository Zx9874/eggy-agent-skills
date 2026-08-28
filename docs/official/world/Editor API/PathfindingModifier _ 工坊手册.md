# PathfindingModifier

寻路修饰器。需先通过 PrefabService:CreatePrefab("PathfindingModifier") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

PathfindingModifier 用于标记 Parent 物理体在导航网格中的区域、穿越性和烘焙策略。编辑器预摆并已参与烘焙的修饰器不受动态 NavMesh 开关影响；仅运行时创建、销毁、修改 Parent 或修改 Label、PassThrough、BakeMode 时，需要 PathfindingService.HasDynamicNavMesh 为 true 才会触发 tile 重烘焙并动态影响导航网格。

> 继承自 `Unit`；需先通过 `PrefabService:CreatePrefab("PathfindingModifier")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Label` | `String` | - | 动态 NavMesh 开启时，用于标记 Parent 物理体烘焙出的导航区域；可配合 CreatePath 的 Costs 或 Path:SetAreaCost 设置代价。未开启时运行时修改不会更新导航网格。 |
| `PassThrough` | `Bool` | - | 控制 Parent 物理体对应的导航区域是否可穿越。动态 NavMesh 开启时修改会触发 Parent 覆盖 tile 重烘焙；未开启时运行时修改不会更新导航网格。 |
| `BakeMode` | `BakeMode` | - | 决定 Parent 物理体如何参与运行时导航网格重烘焙。动态 NavMesh 开启时修改会触发 Parent 覆盖 tile 重烘焙；未开启时运行时修改不会更新导航网格。 |
