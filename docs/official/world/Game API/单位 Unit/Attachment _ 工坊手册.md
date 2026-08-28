# Attachment

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[Attachment]**（10 属性 / 1 函数）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 是依附于父级单位的局部坐标锚点，用于在单位上标记挂点或基准位置。它同时提供局部变换属性（如 Position、Rotation、CFrame）与对应的世界空间属性（WorldPosition、WorldRotation、WorldCFrame），两者会根据父级的世界变换自动换算。还可以通过 Axis 与 SecondaryAxis 定义方向轴，并通过 GetConstraints 查询挂载在当前锚点上的约束。

## 适用场景

在需要为角色、载具或场景物体定义挂点或锚点，供约束连接、特效定位或逻辑追踪时，使用 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 作为统一的定位基准。

## 使用要点

通过 game:CreateUnit("Attachment", config) 或 World:CreateUnit("Attachment", config) 创建实例，并挂载到目标单位下。随后可读写 Position、Rotation 设置局部偏移与朝向，或读取 WorldPosition、WorldCFrame 获取世界坐标；调用 GetConstraints 可查询当前锚点上挂载的约束列表。

## 注意事项

[Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 通过 game:CreateUnit("Attachment", config) 创建，不使用 New 构造。Position 是相对 Parent 的局部 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 偏移，Rotation/Orientation 也是局部旋转；需要世界坐标时读取 WorldPosition/WorldCFrame。当前编辑器属性面板可能把 Position 标成“世界坐标”，该标签与 Lua 契约不一致，应以 API 的局部/世界双属性语义为准。若要按欧拉角设置朝向，先用 Quaternion.FromEulerAngles(...) 构造四元数。新建实例若未挂到具体 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 上，世界坐标会与原点重合（0,0,0）。GetConstraints 返回当前 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 上挂载的所有约束列表。

## 代码示例

### 挂载 Attachment 并对比局部与世界位置

```lua
-- @runtime client
local World = game:GetService('World')
local parent = World:CreateUnit('WorldUnit', { Position = Vector3.New(10, 0, 0) })
local attachment = World:CreateUnit('Attachment', {
    Parent = parent,
    Position = Vector3.New(0, 1, 0),
    Rotation = Quaternion.FromEulerAngles(0, math.rad(45), 0),
})
print('局部位置 Position:', attachment.Position)
print('世界位置 WorldPosition:', attachment.WorldPosition)
```

## 属性 (10)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `[0.0, 0.0, 0.0]` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 在父级空间下的局部位置。 |
| `Rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | `[0.0, 0.0, 0.0, 1.0]` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 的局部旋转，以四元数表示。 |
| `Orientation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | `-` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 的局部朝向，以四元数表示。 |
| `CFrame` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | `-` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 的局部 CFrame，表示附件相对其父单位的局部位置与朝向。 |
| `WorldPosition` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 在世界空间下的位置。 |
| `WorldRotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | `-` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 的世界空间旋转，以四元数表示。 |
| `WorldCFrame` | [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html) | `-` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 的世界 CFrame，表示附件在世界坐标系中的位置与朝向。 |
| `Axis` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 的主轴方向，以局部空间下的单位向量表示。 |
| `SecondaryAxis` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `-` | [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 的副轴方向，以局部空间下的单位向量表示。 |
| `Visible` | `Bool` | `true` | 控制 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 在编辑器中是否可见。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [CFrame](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CFrame.html)
* [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)

## 函数 (1)

### GetConstraints

签名：`GetConstraints() -> Array&lt;Unit&gt; (引用当前 Attachment 的约束单位数组副本。)`

获取引用当前 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 的约束单位数组副本，数组中包含所有与该附件关联的约束单位。

**返回值** Array<[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)> (引用当前 [Attachment](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Attachment.html) 的约束单位数组副本。)

> 示例代码

> 读取锚点引用的约束

```lua
-- @runtime client
local World = game:GetService('World')
local attachment = World:FindFirstChild('MyAttachment', true)
if attachment == nil or not attachment:IsA('Attachment') then
    print('请先在编辑器中准备已连接约束的 Attachment')
    return
end
for _, linkedConstraint in ipairs(attachment:GetConstraints()) do
    print('约束名称:', linkedConstraint.Name)
end
```
