# SoundService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[SoundService]**（5 函数 / 1 事件）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

声音服务是全局音频管理接口，负责播放二维、三维和本地音效，并支持音量分组控制。通过该服务可以创建并返回 [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) 实例，进而对播放中的音频进行实时调节。

## 适用场景

在需要播放背景音乐、环境音效或角色交互音效时，通过 game:GetService("SoundService") 获取服务实例，调用 Play2D 或 Play3D 等方法触发音频播放。

## 使用要点

先通过 game:GetService("SoundService") 获取服务实例，然后使用 Play2D 播放全局音效，或使用 Play3D 在指定位置播放空间音效。播放后会返回 [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) 对象，可通过该对象调整音量、速度等属性。

## 注意事项

[SoundService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/SoundService.html) 的 Play2D/Play3D 会创建并返回 [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html)；当前 Meta 已声明该返回契约，可继续通过返回实例控制 Playing、Volume、Speed 等公开属性。

## 代码示例

### 监听音组音量变化事件

```lua
-- @runtime client
-- 获取 SoundService 服务实例
local soundService = game:GetService("SoundService")

-- 监听 GroupVolumeChanged 事件，当任意音组音量改变时触发
soundService.GroupVolumeChanged:Once(function(name, volume)
    -- name: 音组名称（字符串）
    -- volume: 新的音量值（0~100）
    print("音组 " .. name .. " 音量已更改为: " .. volume)
end)

-- 示例：设置一个音组音量，触发上述事件
soundService:SetGroupVolume("BGM", 80)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (1)

### GroupVolumeChanged

签名：`GroupVolumeChanged(name: String, volume: Float)` 触发：`local`

当某个音组的音量发生变化时触发，携带音组名称和新的音量值。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 音组名称 |
| `volume` | `Float` | 新音量值（0~100） |

> 示例代码

> 监听音组音量变化

```lua
-- @runtime client
-- 获取 SoundService 服务实例
local soundService = game:GetService("SoundService")

-- 监听 GroupVolumeChanged 事件，当任意音组音量改变时触发
soundService.GroupVolumeChanged:Once(function(name, volume)
    -- 打印变化的音组名称和当前音量
    print("音组名称: " .. name .. ", 当前音量: " .. volume)
end)
```

## 函数 (5)

### Play2D

签名：`Play2D(soundId: String, volume: Float, speed: Float, playerOrCampRoleId: Bool, campRoleId: Bool, duration: Float) -> SoundUnit (本次播放创建的 SoundUnit 实例)`

播放一个 2D 音效，可指定音量、播放速率和持续时间。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `soundId` | `String` | 声音ID |
| `volume` | `Float` | 音量 |
| `speed` | `Float` | 速率 |
| `playerOrCampRoleId` | `Bool` | 额外播放范围开关，常规 2D 播放传 false；不要传 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 对象。 |
| `campRoleId` | `Bool` | 额外阵营范围开关，常规 2D 播放传 false；不要传阵营 ID 数字。 |
| `duration` | `Float` | 播放时长 |

**返回值** [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) (本次播放创建的 [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) 实例)

> 示例代码

> 播放 2D 音效并取得实例

```lua
-- @runtime client
local soundService = game:GetService('SoundService')
local soundUnit = soundService:Play2D('official://audio/10001', 80, 1.0, false, false, 3)
soundUnit.Volume = 60
print('2D 音效实例:', soundUnit)
```

### Play3D

签名：`Play3D(soundId: String, position: Vector3, duration: Float, volume: Float, speed: Float, player: Bool) -> SoundUnit (本次播放创建的 SoundUnit 实例)`

在指定位置播放一个 3D 音效，可指定持续时间、音量和播放速率。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `soundId` | `String` | 声音 ID |
| `position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 声音位置（[Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) 或同结构） |
| `duration` | `Float` | 播放时长 |
| `volume` | `Float` | 音量 0~100 |
| `speed` | `Float` | 速率 0~1 |
| `player` | `Bool` | 额外播放范围开关，常规 3D 播放传 false；不要传 [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html) 对象。 |

**返回值** [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) (本次播放创建的 [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) 实例)

> 示例代码

> 在世界位置播放 3D 音效

```lua
-- @runtime client
local soundService = game:GetService('SoundService')
local position = Vector3.New(0, 10, 0)
local soundUnit = soundService:Play3D('official://audio/10001', position, 5, 80, 1.0, false)
soundUnit.Playing = true
print('3D 音效实例:', soundUnit)
```

### PlayLocalSound

签名：`PlayLocalSound(soundId: String, volume: Float, speed: Float) -> void`

在本地客户端一次性播放 2D 音效，不创建 [SoundUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/SoundUnit.html) 实例，性能开销最小。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `soundId` | `String` | 声音资源 URI（official://audio/{id} 或 custom://{asset\_id}） |
| `volume` | `Float` | 音量 0~100 |
| `speed` | `Float` | 速率 0~1 |

**返回值** `void`

> 示例代码

> 在本地播放一次性 2D 音效

```lua
-- @runtime client
local soundService = game:GetService('SoundService')
local soundId = 'official://audio/10001'
local volume = 80
local speed = 1.0
soundService:PlayLocalSound(soundId, volume, speed)
```

### SetGroupVolume

签名：`SetGroupVolume(name: String, volume: Float) -> void`

设置指定音组的音量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 音组名称 |
| `volume` | `Float` | 音量（0~100） |

**返回值** `void`

> 示例代码

> 设置音组音量

```lua
-- @runtime client
-- 获取 SoundService 服务实例
local soundService = game:GetService("SoundService")

-- 设置名为 "BGM" 的音组音量为 50
soundService:SetGroupVolume("BGM", 50)

-- 验证音量是否设置成功
local currentVolume = soundService:GetGroupVolume("BGM")
print("BGM 音组当前音量: " .. currentVolume)
```

### GetGroupVolume

签名：`GetGroupVolume(name: String) -> Float (音量（0~100），音组不存在返回 100)`

获取指定音组的当前音量。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | `String` | 音组名称 |

**返回值** `Float` (音量（0~100），音组不存在返回 100)

> 示例代码

> 获取音组音量

```lua
-- @runtime client
-- 获取 SoundService 服务实例
local soundService = game:GetService("SoundService")

-- 获取名为 "SFX" 的音组音量
local volume = soundService:GetGroupVolume("SFX")

-- 输出获取到的音量值
print("SFX 音组音量: " .. volume)
```
