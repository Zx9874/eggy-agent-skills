# SkinUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[SkinUnit]**（6 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[SkinUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SkinUnit.html) 是挂在目标单位下的外观覆盖组件，可用 SkinId、四组染色颜色和 MaterialParam 描述要应用的皮肤外观。

## 适用场景

用于给角色或模型单位挂载皮肤资源、分区染色或材质参数覆盖。

## 使用要点

通过 game:CreateUnit("SkinUnit", config) 创建实例，设置 SkinId、ModelColor1~ModelColor4 或 MaterialParam 后，将 SkinUnit.Parent 设为要覆盖外观的目标单位。

## 注意事项

[SkinUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SkinUnit.html) 需要作为子对象挂到目标单位下；SkinId 和染色/材质字段应使用目标运行包可访问的资源与参数，并在目标端确认最终外观。不要依赖未在公开 Meta 中声明的刷新时机或内部实现细节。

## 代码示例

### 创建 SkinUnit 并挂到目标单位

```lua
-- @runtime client
local world = game:GetService("World")

local target = world:CreateUnit("WorldUnit", {
    Name = "SkinTarget",
})

local skin = world:CreateUnit("SkinUnit", {
    SkinId = "official://skin/60001",
    ModelColor1 = Color.New(255, 255, 255, 255),
    ModelColor2 = Color.New(255, 220, 180, 255),
    Parent = target,
})

print("皮肤覆盖已挂载:", skin.Parent == target)
```

## 属性 (6)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `SkinId` | `String` | `""` | 皮肤单元的皮肤资源 ID。 |
| `ModelColor1` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 皮肤染色区域1的颜色，用于控制模型上第一个可染色区域的颜色。 |
| `ModelColor2` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 皮肤染色区域2的颜色，用于控制模型上第二个可染色区域的颜色。 |
| `ModelColor3` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 皮肤染色区域3的颜色，用于控制模型上第三个可染色区域的颜色。 |
| `ModelColor4` | [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html) | `Color.New(255, 255, 255, 255)` | 皮肤染色区域4的颜色，用于控制模型上第四个可染色区域的颜色。 |
| `MaterialParam` | [MaterialParam](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MaterialParam.html) | `-` | [SkinUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SkinUnit.html) 的材质参数属性，用于控制皮肤单元在渲染时使用的材质效果。该属性的值为一个 MaterialParam 对象，可通过 MaterialParam.New() 创建或由其他 API 返回。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
* [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)
* [MaterialParam](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MaterialParam.html)
