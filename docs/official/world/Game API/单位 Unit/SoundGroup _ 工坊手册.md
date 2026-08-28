# SoundGroup

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[SoundGroup]**（1 属性）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[SoundGroup](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundGroup.html) 是音效分组容器，通过 Volume 统一控制挂在该组下的 [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) 音量。

## 适用场景

用于把背景音乐、环境音或音效分组管理。将 [SoundGroup](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundGroup.html) 挂到 [SoundService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/SoundService.html)，再把 SoundUnit.Parent 设为该 [SoundGroup](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundGroup.html)，即可统一调节组内音量。

## 使用要点

通过 World:CreateUnit("SoundGroup", { Volume = 100 }) 创建音组并挂到 [SoundService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/SoundService.html)；Volume 使用 0-100 音量值。创建 [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) 后设置 SoundId，再把 SoundUnit.Parent 设为音组并调用 Play()。

## 注意事项

[SoundGroup](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundGroup.html) 本身不播放声音，只影响作为子节点挂入的 [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html)。Volume 与 SoundUnit.Volume 统一使用 0-100 音量值；例如 50 表示把组音量调到一半。

## 代码示例

### 创建音组并播放组内音效

```lua
-- @runtime client
local World = game:GetService("World")
local SoundService = game:GetService("SoundService")

local soundGroup = World:CreateUnit("SoundGroup", {
    Volume = 100,
    Parent = SoundService,
})

local soundUnit = World:CreateUnit("SoundUnit", {
    SoundId = "official://audio/5147",
    Parent = soundGroup,
})
soundUnit:Play()

soundGroup.Volume = 50
print("音组音量:", soundGroup.Volume)
```

## 属性 (1)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Volume` | `Float` | `100.0` | 音组的全局音量，影响该音组下所有 [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) 的最终输出音量。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
