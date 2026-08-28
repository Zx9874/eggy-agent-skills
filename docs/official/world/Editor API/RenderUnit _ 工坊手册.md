# RenderUnit

装饰组件。可通过 World:CreateUnit("RenderUnit", {...}) 创建，字段属性可直接读写。

## 概览

RenderUnit是一种可创建的3D空间组件，具备渲染表现能力。常用于场景中需要模型展示的装饰物件。

> 继承自 `SpaceUnit`；可通过 `World:CreateUnit("RenderUnit", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `RenderMeshId` | `String` | - | 模型的资源路径，用于指定渲染使用的网格资源 |
| `ModelAlpha` | `Float` | - | 控制模型的整体透明度，0 为完全透明，1 为完全不透明 |
| `ModelVisible` | `Bool` | - | 控制模型是否可见，隐藏后仍参与物理碰撞 |
| `CastShadow` | `Bool` | - | 控制模型是否向场景投射阴影 |
| `TransparentRenderBias` | `Int` | - | 控制半透明物体的渲染层级偏置，值越小越先渲染。仅影响半透明物体，不透明物体不受此偏置影响。取值范围 [-15, 16]，超出会被截断到边界。注意：仅当遮挡规则(OcclusionType)为 组件半透明/镜头前推/玩家虚影 时生效；为 不处理 时本偏置不生效 |
| `ModelBindParent` | `Bool` | - | 启用后，当父节点为 WorldUnit、RenderUnit、TriggerUnit、PhysicsUnit 等支持父子带动的场景单位时，当前模型渲染表现将跟随父节点的变换自动同步。运行时可通过脚本设置 .ModelBindParent = true/false 动态切换该行为。 |
| `ModelColor1` | `Color` | - | 染色区域1 |
| `ModelColor2` | `Color` | - | 染色区域2 |
| `ModelColor3` | `Color` | - | 染色区域3 |
| `ModelColor4` | `Color` | - | 染色区域4 |
| `SkinId` | `String` | - | 模型使用的皮肤资源ID，用于切换模型外观 |
| `UseCustomAppearance` | `Bool` | - | 启用后使用自定义外观替代默认模型渲染 |
| `CustomAppearanceId` | `String` | - | 自定义外观的资源ID，启用自定义外观后生效 |
| `OcclusionType` | `Int` | - | 当模型遮挡住摄像机与玩家之间的视线时的处理策略 |
