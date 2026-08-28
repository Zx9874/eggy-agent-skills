# EggyAppearance

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

蛋形生物的外观数据，记录蛋仔从盲盒形象、染色配色到时装散件、配饰、脸型、表情、肤色与蛋皮等全套可换装信息，并提供运行时换装、挂接外观件、回收外观件以及显示头顶气泡与表情等表现能力。通过它可以在游戏过程中动态切换蛋仔的整体造型或局部装扮，是角色外观管理的核心入口。

## 适用场景

在角色编辑、商城试穿或局内换装玩法中，拿到玩家蛋仔的外观组件后，用设置脸型、肤色、蛋皮或时装散件的接口实时改变蛋仔形象，也可以挂接翅膀、背包等外观件并调整位置与旋转。

## 使用要点

实例不能直接构造，需要通过相关公开 API 的返回值获取。获取后先调用 SetAppearanceByAssetId 或 SetFashionPart、SetAccessoryId、SetFaceId、SetSkinColorId、SetEggShellId 等设置整体或局部外观；再用 BindAppearance 挂接额外的外观件并获得绑定标识，之后可用 UnbindAppearance 按标识拆除；需要头顶气泡提示时可调用 ShowBubbleMessage 显示、HideBubbleMessage 隐藏或 EnableBubbleMessage 开关该功能。

## 注意事项

[EggyAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EggyAppearance.html) 不能使用 New 或直接构造，必须从 [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html) 等公开对象获取。传入的预设、外观件和装扮 ID 必须来自项目实际可用资源；BindAppearance 成功后应保存返回的绑定 ID，供 UnbindAppearance 精确解绑或 ResetBindAppearance 整体清理。

## 代码示例

### 获取角色外观组件并显示气泡

```lua
-- @runtime client
local players = game:GetService("Players")
local player = players.LocalPlayer
if player == nil then return end
local character = player and player.Character
if character ~= nil and character.EggyAppearance ~= nil then
    local appearance = character.EggyAppearance
    appearance:ShowBubbleMessage("准备出发", 2.0, 20.0)
    appearance:SetFaceStatus(Enums.FaceStatus.Happy)
end
```

## 函数 (20)

### ShowBubbleMessage

签名：`ShowBubbleMessage(message: String, duration: Float, hideDistance: Float) -> void`

在角色头顶显示一段文字气泡消息。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `message` | `String` | 气泡消息 |
| `duration` | `Float` | 持续时间(可选) |
| `hideDistance` | `Float` | 隐藏距离(可选) |

**返回值** `void`

> 示例代码

> 显示头顶气泡消息

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    character.EggyAppearance:ShowBubbleMessage("跟我来", 2.0, 20.0)
end
```

### HideBubbleMessage

签名：`HideBubbleMessage() -> void`

隐藏当前正在显示的头顶气泡消息。

**返回值** `void`

> 示例代码

> 隐藏头顶气泡消息

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    character.EggyAppearance:HideBubbleMessage()
end
```

### SetAppearanceByAssetId

签名：`SetAppearanceByAssetId(assetId: String) -> void`

按生物预设整体切换角色的外观。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `assetId` | `String` | 生物预设ID |

**返回值** `void`

> 示例代码

> 切换整套蛋仔外观

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    character.EggyAppearance:SetAppearanceByAssetId("official://preset/9000602")
end
```

### ResetAppearance

签名：`ResetAppearance() -> void`

将角色外观重置为默认状态。

**返回值** `void`

> 示例代码

> 恢复默认外观

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    character.EggyAppearance:ResetAppearance()
end
```

### BindAppearance

签名：`BindAppearance(appearanceId: String, socket: SkeletalSocketType, offset: Vector3, rot: Quaternion, scale: Vector3) -> Int (绑定ID)`

在指定骨骼挂点上挂接一个外观件，并返回绑定ID。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `appearanceId` | `String` | 外观ID |
| `socket` | [SkeletalSocketType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/SkeletalSocketType.html) | 绑定点 |
| `offset` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 位置偏移 |
| `rot` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | 旋转 |
| `scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 缩放 |

**返回值** `Int` (绑定ID)

> 示例代码

> 挂接一个外观件

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    local bindId = character.EggyAppearance:BindAppearance(
        "official://preset/101123",
        Enums.SkeletalSocketType.Head,
        Vector3.New(0, 0.2, 0),
        Quaternion.New(0, 0, 0, 1),
        Vector3.New(1, 1, 1)
    )
    print("外观挂接 ID:", bindId)
end
```

### UnbindAppearance

签名：`UnbindAppearance(bindId: Int) -> Bool (是否成功)`

解除指定绑定ID对应的外观件挂接。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `bindId` | `Int` | 绑定ID |

**返回值** `Bool` (是否成功)

> 示例代码

> 移除指定外观挂接

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    local bindId = character.EggyAppearance:BindAppearance(
        "official://preset/101123",
        Enums.SkeletalSocketType.Head,
        Vector3.New(0, 0.2, 0),
        Quaternion.New(0, 0, 0, 1),
        Vector3.New(1, 1, 1)
    )
    character.EggyAppearance:UnbindAppearance(bindId)
end
```

### ResetBindAppearance

签名：`ResetBindAppearance() -> void`

解除所有通过 BindAppearance 挂接的外观件。

**返回值** `void`

> 示例代码

> 移除所有挂接外观件

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    character.EggyAppearance:ResetBindAppearance()
end
```

### SetFashionPart

签名：`SetFashionPart(partId: Int) -> void`

为蛋仔设置指定时装部位的外观，传入部位 ID 即可更换对应部位的时装样式。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `partId` | `Int` | 时装部位ID |

**返回值** `void`

> 示例代码

> 使用项目提供的时装部位 ID

```lua
-- @runtime client
local function setFashionPart(partId)
    local players = game:GetService("Players")
    local character = players.LocalPlayer and players.LocalPlayer.Character
    if character == nil or character.EggyAppearance == nil then
        return false
    end
    character.EggyAppearance:SetFashionPart(partId)
    return true
end
```

### GetFashionPart

签名：`GetFashionPart(partType: FashionPartType) -> Int (时装散件ID)`

获取角色蛋指定身体部位的时装散件ID。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `partType` | [FashionPartType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/FashionPartType.html) | 时装部位 |

**返回值** `Int` (时装散件ID)

> 示例代码

> 读取头部时装散件 ID

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    local partId = character.EggyAppearance:GetFashionPart(Enums.FashionPartType.Head)
    print("头部时装散件 ID:", partId)
end
```

### SetAccessoryId

签名：`SetAccessoryId(accessoryId: Int) -> void`

为蛋仔设置指定的时装配饰，传入配饰 ID 即可更换当前佩戴的配饰外观。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `accessoryId` | `Int` | 配饰ID |

**返回值** `void`

> 示例代码

> 使用项目提供的配饰 ID

```lua
-- @runtime client
local function setAccessory(accessoryId)
    local players = game:GetService("Players")
    local character = players.LocalPlayer and players.LocalPlayer.Character
    if character == nil or character.EggyAppearance == nil then
        return false
    end
    character.EggyAppearance:SetAccessoryId(accessoryId)
    return true
end
```

### GetAccessoryId

签名：`GetAccessoryId(bindPos: AccessoryBindType) -> Int (配饰ID)`

获取角色蛋在指定挂点位置装配的配饰ID。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `bindPos` | [AccessoryBindType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AccessoryBindType.html) | 配饰挂点 |

**返回值** `Int` (配饰ID)

> 示例代码

> 读取头部配饰 ID

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    local accessoryId = character.EggyAppearance:GetAccessoryId(Enums.AccessoryBindType.Head)
    print("头部配饰 ID:", accessoryId)
end
```

### SetFaceId

签名：`SetFaceId(faceId: Int) -> void`

为蛋仔设置静态脸型外观，传入脸型编号即可切换当前脸部样式。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `faceId` | `Int` | 面部表情编号 |

**返回值** `void`

> 示例代码

> 使用项目提供的脸型 ID

```lua
-- @runtime client
local function setFace(faceId)
    local players = game:GetService("Players")
    local character = players.LocalPlayer and players.LocalPlayer.Character
    if character == nil or character.EggyAppearance == nil then
        return false
    end
    character.EggyAppearance:SetFaceId(faceId)
    return true
end
```

### GetFaceId

签名：`GetFaceId() -> Int (面部表情编号)`

获取角色蛋当前的静态脸型编号。

**返回值** `Int` (面部表情编号)

> 示例代码

> 读取静态脸型 ID

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    local faceId = character.EggyAppearance:GetFaceId()
    print("静态脸型 ID:", faceId)
end
```

### SetFaceStatus

签名：`SetFaceStatus(faceStatus: FaceStatus) -> void`

切换角色的动态表情。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `faceStatus` | [FaceStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/FaceStatus.html) | 动态表情编号 |

**返回值** `void`

> 示例代码

> 切换角色表情

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    character.EggyAppearance:SetFaceStatus(Enums.FaceStatus.Happy)
end
```

### GetFaceStatus

签名：`GetFaceStatus() -> FaceStatus (动态表情)`

获取角色蛋当前的动态表情状态。

**返回值** [FaceStatus](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/FaceStatus.html) (动态表情)

> 示例代码

> 读取动态表情状态

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    local faceStatus = character.EggyAppearance:GetFaceStatus()
    print("动态表情状态:", faceStatus)
end
```

### SetSkinColorId

签名：`SetSkinColorId(skinColorId: Int) -> void`

为蛋仔设置肤色外观，传入肤色 ID 即可调整蛋仔当前的肤色样式。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `skinColorId` | `Int` | 肤色ID |

**返回值** `void`

> 示例代码

> 使用项目提供的肤色 ID

```lua
-- @runtime client
local function setSkinColor(skinColorId)
    local players = game:GetService("Players")
    local character = players.LocalPlayer and players.LocalPlayer.Character
    if character == nil or character.EggyAppearance == nil then
        return false
    end
    character.EggyAppearance:SetSkinColorId(skinColorId)
    return true
end
```

### GetSkinColorId

签名：`GetSkinColorId() -> Int (肤色ID)`

获取角色蛋当前的肤色ID。

**返回值** `Int` (肤色ID)

> 示例代码

> 读取肤色 ID

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    local skinColorId = character.EggyAppearance:GetSkinColorId()
    print("肤色 ID:", skinColorId)
end
```

### SetEggShellId

签名：`SetEggShellId(eggShellId: Int) -> void`

为蛋仔设置指定的蛋皮外观，传入蛋皮 ID 即可更换蛋仔的蛋皮样式。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `eggShellId` | `Int` | 蛋皮ID |

**返回值** `void`

> 示例代码

> 使用项目提供的蛋皮 ID

```lua
-- @runtime client
local function setEggShell(eggShellId)
    local players = game:GetService("Players")
    local character = players.LocalPlayer and players.LocalPlayer.Character
    if character == nil or character.EggyAppearance == nil then
        return false
    end
    character.EggyAppearance:SetEggShellId(eggShellId)
    return true
end
```

### GetEggShellId

签名：`GetEggShellId() -> Int (蛋皮ID)`

获取角色蛋当前使用的蛋皮ID。

**返回值** `Int` (蛋皮ID)

> 示例代码

> 读取蛋皮 ID

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    local eggShellId = character.EggyAppearance:GetEggShellId()
    print("蛋皮 ID:", eggShellId)
end
```

### EnableBubbleMessage

签名：`EnableBubbleMessage(enable: Bool) -> void`

设置是否启用头顶气泡消息功能。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `enable` | `Bool` | 是否启用 |

**返回值** `void`

> 示例代码

> 启用头顶气泡消息

```lua
-- @runtime client
local players = game:GetService("Players")
local character = players.LocalPlayer and players.LocalPlayer.Character
if character ~= nil and character.EggyAppearance ~= nil then
    character.EggyAppearance:EnableBubbleMessage(true)
end
```
