# FileMesh

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[FileMesh]**（5 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

文件网格用于在现有渲染单元上挂载自定义网格和纹理，通过指定网格资产、纹理资产、缩放、偏移和顶点颜色来改变模型外观。它本身不参与物理模拟，仅作为视觉表现层附加到父级渲染或空间单元上。

## 适用场景

当需要为场景中的某个部件或角色替换或叠加自定义模型外观时，创建文件网格并挂载到目标单元下，常用于装备展示、皮肤替换或动态装饰。

## 使用要点

通过 World:CreateUnit("FileMesh", config) 创建实例，设置 MeshId 和 TextureId 为 official://mesh/... 和 official://skin/... 格式的资产 URI，然后将其 Parent 属性指向目标渲染单元。可选调整 Scale、Offset 和 VertexColor 来微调显示效果。

## 注意事项

[FileMesh](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/FileMesh.html) 通过 World:CreateUnit("FileMesh", config) 创建，再挂到已有渲染/空间 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 下。MeshId 使用 official://mesh/...，TextureId 使用 official://skin/...；Scale 和 Offset 使用 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)，VertexColor 按公开类型使用 Color.New(r,g,b,a)。

## 代码示例

### 创建 FileMesh 并设置网格外观

```lua
-- @runtime client
local world = game:GetService("World")

-- 创建一个可作为父级的渲染对象
local parentPart = world:CreateUnit("RenderUnit", {
    Name = "MeshParent",
    RenderMeshId = "official://mesh/59268",
    Position = Vector3.New(0, 0, 0),
})

local fileMesh = world:CreateUnit("FileMesh", {
    Name = "MyFileMesh",
})
fileMesh.Parent = parentPart
fileMesh.MeshId = "official://mesh/90003"
fileMesh.TextureId = "official://skin/110"
fileMesh.Scale = Vector3.New(4, 4, 4)
fileMesh.Offset = Vector3.New(0, 1, 0)
fileMesh.VertexColor = Color.New(255, 0, 0, 255)
```

## 属性 (5)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `MeshId` | `String` | `""` | 设置或获取 [FileMesh](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/FileMesh.html) 使用的网格资源标识符。 |
| `TextureId` | `String` | `""` | 设置或获取 [FileMesh](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/FileMesh.html) 使用的纹理资源标识符。 |
| `Scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[1, 1, 1]` | 控制 [FileMesh](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/FileMesh.html) 在三个轴向上的缩放比例。 |
| `Offset` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0, 0, 0]` | 控制 [FileMesh](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/FileMesh.html) 相对于其父级 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 的位置偏移量。 |
| `VertexColor` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 设置 [FileMesh](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/FileMesh.html) 所有顶点的统一颜色，影响网格的最终渲染色调。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
