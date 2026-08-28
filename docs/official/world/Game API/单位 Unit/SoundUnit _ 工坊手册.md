# SoundUnit

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[SoundUnit]**（9 属性 / 8 函数 / 2 事件）

### 继承成员

1 个来源 / 4 属性 / 25 函数 / 6 事件

* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) 是场景中的空间音效单位，用于在指定位置播放、控制音频资源。支持设置音效资源、音量、播放速率、衰减距离等属性，并可通过 `Play`/`Stop` 控制播放，通过将 `Parent` 设为 `BasePart` 或 `Attachment` 让音效自动跟随移动对象。通过 `Played` 与 `Stopped` 事件可以监听播放状态变化。

## 适用场景

在游戏场景中创建背景音乐或空间音效，例如在特定位置播放循环环境音、跟随角色移动的脚步声、或一次性爆炸音效。

## 使用要点

通过 `world:CreateUnit("SoundUnit", config)` 创建实例，在 config 中设置 `SoundId` 指定音频资源，调用 `Play()` 开始播放。可通过 `SetVolume`、`SetSpeed` 等方法实时调整音量与播放速率，调用 `Stop()` 停止播放；不再使用时按 Unit 生命周期调用继承的 `Destroy()`。

## 注意事项

* **SoundId**：使用 Asset 协议字符串形式指定音频资源。支持以下两种协议：

  + `official://audio/{id}`：官方内置音频
  + `custom://{asset_id}`：地图作者自定义上传的音频资源

  创建时未指定 `SoundId` 则无音频可播放。
* **播放控制**：通过 `Play()` / `Stop()` 控制播放与停止，两者本质是修改 `Playing` 属性。也可在 `CreateUnit` config 中传入 `Playing = true`，让 SoundUnit 创建后立即播放。
* **Volume 与 Speed**：`Volume` 取值 0–100（0 静音，100 最大）；`Speed` 的正常速度为 1.0，实际可用范围以目标运行包和音频资源为准。
* **Duration 自动回收**：`Duration` > 0 时，播放到期后 SoundUnit 会自动销毁；`Duration = -1`（默认）表示永久。运行时调用 `SetDuration` 会重置内部计时器，从当前时刻起按新时长重新计时。
* **Parent 跟随模式**：当 `SoundUnit.Parent` 为 `BasePart` 或 `Attachment` 时，音效位置会自动跟随 Parent 的世界位置变化。此时调用 `SetPosition` 会被跳过（并输出一次控制台警告），需通过 Parent 本身控制位置。
* **SoundGroup 音组**：当 `SoundUnit.Parent` 为 [SoundGroup](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundGroup.html) 时，Parent 跟随不生效（音组不代表发声点），音量会被音组音量倍率调制（实际音量 = `SoundUnit.Volume × SoundGroup.Volume / 100`），位置由 SoundUnit 自身 `Position` 控制。
* **一次性音效**：对于短暂的一次性 3D 音效，推荐使用 [SoundService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/SoundService.html):Play3D，无需手动管理 SoundUnit 生命周期。

## 代码示例

### 创建并播放背景音乐

```lua
-- @runtime client
local world = game:GetService("World")

local bgm = world:CreateUnit("SoundUnit", {
    SoundId = "official://audio/10001",
    Looped = true,
    Volume = 80,
})

-- 先订阅再播放，避免错过快速触发的 Played 事件
bgm.Played:Once(function()
    print("背景音乐已开始播放")
end)
bgm:Play()
```

### 让 3D 音效跟随移动对象

```lua
-- @runtime client
local World = game:GetService("World")
local Task = game:GetService("Task")

-- 创建 WorldUnit（BasePart 派生类）作为跟随源
local part = World:CreateUnit("WorldUnit", {
    Position = Vector3.New(0, 2, 0),
    Name = "sound_host_part",
})

-- 将 Parent 设为 BasePart 后，SoundUnit 会自动跟随其世界位置
local sound = World:CreateUnit("SoundUnit", {
    SoundId = "official://audio/10001",
    SoundType = "3D",
    Volume = 100,
    FadeDistance = 30,
    Parent = part,
})
sound:Play()

-- 移动 Parent 时无需再调用 sound:SetPosition(...)
Task:Delay(1, function()
    part.Position = Vector3.New(10, 2, 0)
end)
```

## 属性 (9)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `SoundId` | `String` | `-` | 音效资源的 URI。 |
| `SoundType` | `String` | `3D` | 音效类型，如 2D 或 3D。 |
| `Speed` | `Float` | `1.0` | 音效的播放速率。 |
| `Volume` | `Float` | `100` | 音效的音量大小。 |
| `Duration` | `Float` | `-1` | 音效的持续时间（秒）。 |
| `CampRoleId` | `Int` | `-1` | 音效所属的阵营 ID。 |
| `FadeDistance` | `Float` | `-1` | 3D 音效的衰减距离。 |
| `Playing` | `Bool` | `false` | 是否在创建后自动开始播放。 |
| `Looped` | `Bool` | `false` | 是否循环播放音效。 |

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (2)

### Played

签名：`Played()` 触发：`local`

当 [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) 开始播放时触发此事件。

⚙ 播放开始时触发；该事件不表示音频已经播放完成。

> 示例代码

> 监听播放开始

```lua
-- @runtime client
local World = game:GetService("World")
local soundUnit = World:CreateUnit("SoundUnit", { SoundId = "official://audio/5147" })

soundUnit.Played:Once(function()
    print("音效开始播放")
end)
soundUnit:Play()
```

### Stopped

签名：`Stopped()` 触发：`local`

当 [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) 停止播放时触发此事件。

⚙ 播放停止时触发。若要捕获主动停止，应在调用 Stop 前建立订阅。

> 示例代码

> 监听播放停止

```lua
-- @runtime client
local World = game:GetService("World")
local soundUnit = World:CreateUnit("SoundUnit", { SoundId = "official://audio/5147" })

soundUnit.Stopped:Once(function()
    print("音效停止播放")
end)
soundUnit:Play()
soundUnit:Stop()
```

## 函数 (8)

### SetVolumeSpeed

签名：`SetVolumeSpeed(Volume: Int, Speed: Float) -> void`

同时设置音效的音量和播放速率。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `Volume` | `Int` | 音量 |
| `Speed` | `Float` | 速率 |

**返回值** `void`

> 示例代码

> 同时设置音量和速率

```lua
-- @runtime client
-- 创建 SoundUnit 并设置音频资源
local world = game:GetService("World")
local soundUnit = world:CreateUnit("SoundUnit", {
    SoundId = "official://audio/10001",
    Looped = false
})
-- 同时设置音量为 70，速率为 1.2 倍
soundUnit:SetVolumeSpeed(70, 1.2)
-- 播放音效
soundUnit:Play()
print("音量和速率已同时设置")
```

### SetSpeed

签名：`SetSpeed(Speed: Float) -> void`

设置音效的播放速率。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `Speed` | `Float` | 速率 |

**返回值** `void`

> 示例代码

> 设置播放速率

```lua
-- @runtime client
-- 创建 SoundUnit 并设置音频资源
local world = game:GetService("World")
local soundUnit = world:CreateUnit("SoundUnit", {
    SoundId = "official://audio/10001",
    Looped = false
})
-- 设置播放速率为 1.5 倍速
soundUnit:SetSpeed(1.5)
-- 播放音效
soundUnit:Play()
print("播放速率已设置为 1.5 倍")
```

### SetVolume

签名：`SetVolume(Volume: Int) -> void`

设置音效的播放音量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `Volume` | `Int` | 音量 |

**返回值** `void`

> 示例代码

> 设置音量

```lua
-- @runtime client
-- 创建 SoundUnit 并设置音频资源
local world = game:GetService("World")
local soundUnit = world:CreateUnit("SoundUnit", {
    SoundId = "official://audio/10001",
    Looped = false
})
-- 设置音量为 80
soundUnit:SetVolume(80)
-- 播放音效
soundUnit:Play()
print("音量已设置为 80")
```

### SetFadeDistance

签名：`SetFadeDistance(FadeDistance: Float) -> void`

设置 3D 声音的衰减距离，距离越远声音衰减越明显。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `FadeDistance` | `Float` | 3D 音效的衰减距离。 |

**返回值** `void`

> 示例代码

> 设置音效衰减距离

```lua
-- @runtime client
-- 创建 SoundUnit 并设置音频资源
local world = game:GetService("World")
local soundUnit = world:CreateUnit("SoundUnit", {
    SoundId = "official://audio/10001",
    Looped = false
})
-- 设置衰减距离为 50 单位
soundUnit:SetFadeDistance(50.0)
-- 播放音效
soundUnit:Play()
print("衰减距离已设置为 50")
```

### SetDuration

签名：`SetDuration(duration: Float) -> void`

设置 3D 音效的持续时间。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `duration` | `Float` | 时长 |

**返回值** `void`

> 示例代码

> 设置音效时长

```lua
-- @runtime client
-- 创建 SoundUnit 并设置音频资源
local world = game:GetService("World")
local soundUnit = world:CreateUnit("SoundUnit", {
    SoundId = "official://audio/10001",
    Looped = false
})
-- 设置播放时长为 5 秒
soundUnit:SetDuration(5.0)
-- 播放音效
soundUnit:Play()
print("音效时长已设置为 5 秒")
```

### SetPosition

签名：`SetPosition(position: Vector3) -> void`

设置 3D 音效在世界中的位置。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 位置 |

**返回值** `void`

> 示例代码

> 设置音效位置

```lua
-- @runtime client
-- 创建 SoundUnit 并设置音频资源
local world = game:GetService("World")
local soundUnit = world:CreateUnit("SoundUnit", {
    SoundId = "official://audio/10001",
    Looped = false
})
-- 设置音效位置为 (10, 5, 0)
local targetPos = Vector3.New(10, 5, 0)
soundUnit:SetPosition(targetPos)
-- 播放音效
soundUnit:Play()
print("音效位置已更新")
```

### Stop

签名：`Stop() -> void`

停止当前正在播放的音效。

**返回值** `void`

> 示例代码

> 停止播放音效

```lua
-- @runtime client
-- 创建 SoundUnit 并设置音频资源
local world = game:GetService("World")
local soundUnit = world:CreateUnit("SoundUnit", {
    SoundId = "official://audio/10001",
    Looped = false
})
-- 先播放音效
soundUnit:Play()
-- 停止播放
soundUnit:Stop()
print("音效已停止")
```

### Play

签名：`Play() -> void`

开始播放 [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) 关联的音效。

**返回值** `void`

> 示例代码

> 播放音效

```lua
-- @runtime client
-- 创建 SoundUnit 并设置音频资源
local world = game:GetService("World")
local soundUnit = world:CreateUnit("SoundUnit", {
    SoundId = "official://audio/10001",
    Looped = false
})
-- 调用 Play 开始播放
soundUnit:Play()
print("音效已开始播放")
```
