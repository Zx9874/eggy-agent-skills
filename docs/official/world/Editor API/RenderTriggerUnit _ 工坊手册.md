# RenderTriggerUnit

触发区域。通过 World:CreateUnit("RenderTriggerUnit", {...}) 创建，字段属性可直接读写。

## 概览

触发区域：带渲染模型的触发区域，当其他单位进入/离开时触发事件，模型可配置透明度、可见性、染色、皮肤与遮挡规则。

> 继承自 `TriggerUnit`；可通过 `World:CreateUnit("RenderTriggerUnit", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `RenderMeshId` | `String` | - | 渲染使用的网格资源路径。 |
| `ModelAlpha` | `Float` | - | 模型整体透明度，0 为完全透明，1 为完全不透明。取值范围 [0, 1]。 |
| `ModelVisible` | `Bool` | - | 模型是否可见，隐藏后仍参与物理碰撞。 |
| `CastShadow` | `Bool` | - | 模型是否向场景投射阴影。 |
| `ModelBindParent` | `Bool` | - | 启用后，当父节点为 WorldUnit、RenderUnit、TriggerUnit、PhysicsUnit 等支持父子带动的单位时，模型渲染表现跟随父节点变换自动同步。 |
| `PhysicsMeshId` | `String` | - | 物理网格资源路径。缺省时默认使用 RenderMeshId 作为物理资源。 |
| `ModelColor1` | `Color` | - | 染色区域 1 的颜色。 |
| `ModelColor2` | `Color` | - | 染色区域 2 的颜色。 |
| `ModelColor3` | `Color` | - | 染色区域 3 的颜色。 |
| `ModelColor4` | `Color` | - | 染色区域 4 的颜色。 |
| `SkinId` | `String` | - | 模型使用的皮肤资源路径。 |
| `UseCustomAppearance` | `Bool` | - | 是否使用自定义外观替代默认模型渲染。 |
| `CustomAppearanceId` | `String` | - | 自定义外观的资源 ID（启用自定义外观后生效）。 |
| `OcclusionType` | `Int` | - | 模型遮挡住摄像机与玩家之间的视线时的处理策略：0=组件半透明，1=镜头前推，2=玩家虚影，3=不处理，4=镜头前推（无玩家虚影）。 |
