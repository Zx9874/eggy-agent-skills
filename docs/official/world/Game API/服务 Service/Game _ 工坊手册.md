# Game

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[Game]**（5 函数 / 1 事件）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[Game](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Game.html) 是全局唯一的游戏根节点，继承自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)，可通过全局变量 game 直接访问。它统一管理所有服务对象，支持通过 GetService 获取任意服务、通过 CreateUnit 创建新单位，并提供游戏加载状态查询、关闭前回调注册与剪贴板写入等能力。

## 适用场景

典型场景是在游戏入口脚本中通过 game:GetService("World") 等调用获取各服务引用，或使用 game:CreateUnit 创建需要挂载到世界中的单位。同时可监听 game.Loaded 事件来确认游戏加载完成时机。

## 使用要点

[Game](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Game.html) 已由全局变量 game 提供，无需额外获取。一般先监听 game.Loaded 事件处理加载完成后的逻辑，随后通过 game:GetService 获取各类服务，或调用 game:CreateUnit 创建单位并指定 Parent 到 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)、[PlayerGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PlayerGui.html) 等容器。若需在退出时清理资源，可调用 game:BindToClose 注册回调。

## 注意事项

[Game](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Game.html) 是全局对象树的根节点，全局变量 game 即为 [Game](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Game.html) 实例，无需通过 GetService 获取。通过 game:GetService("ServiceName") 可获取各类全局服务实例。CreateUnit 用于创建场景或 UI 单位，通常需显式设置 Parent 到 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html)、[PlayerGui](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PlayerGui.html) 或已有容器；EUI 控件创建仍属于 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 创建流程，[EUIManager](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUIManager.html) 只负责管理/查找/挂载既有 UI 节点。UnitId 为系统保留键，传入会被忽略。

## 代码示例

### 通过 game 获取服务并创建单位

```lua
-- @runtime client
-- game 是全局根对象，直接使用即可（不要 local game = game:GetService("Game")）
local World = game:GetService("World")

-- 创建一个 WorldUnit 并设置 Parent
local worldUnit = game:CreateUnit("WorldUnit", { Parent = World })
if worldUnit ~= nil then
    print('已创建 WorldUnit:', worldUnit)
end

-- 获取其他服务
local Players = game:GetService("Players")
print('Players 服务:', Players)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 事件 (1)

### Loaded

签名：`Loaded()` 触发：`local`

客户端初始单位与属性加载完成时触发的事件。

> 示例代码

> 监听客户端加载完成事件

```lua
-- @runtime client
-- 获取 Game 实例（全局变量 game 即为 Game 实例）

local connection = game.Loaded:Once(function()
    print("客户端加载完成，可以安全访问场景单位和服务")
    -- 加载完成后执行后续逻辑，例如获取 World 服务
    local world = game:GetService("World")
    if world then
        print("成功获取 World 服务")
    end
end)
-- 注意：Once 会在触发后自动断开，无需手动 Disconnect
```

## 函数 (5)

### GetService

签名：`GetService(serviceName: String) -> Unit | nil (对应的服务实例对象)`

按公开服务名称获取全局服务实例。

⚙ 示例和文档中不要使用 CollectionService；需要给 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 打标签、查找标签对象或监听标签变化时使用 [TagService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TagService.html)。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `serviceName` | `String` | 要获取的公开服务名称，如 "World"、"Players"、"PhysicsService"、"TagService"、"RunService" 等。 |

**返回值** [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | nil (对应的服务实例对象)

> 示例代码

> 获取音效服务并播放 2D 音效

```lua
-- @runtime client
local soundService = game:GetService('SoundService')
local soundUnit = soundService:Play2D(
    'official://audio/10001',
    80,
    1.0,
    false,
    false,
    3.0
)
print('创建的 SoundUnit:', soundUnit)
```

### CreateUnit

签名：`CreateUnit(unitType: String, values: Table) -> Unit | nil (新创建的单位实例，创建失败时返回 nil)`

在游戏根对象上创建指定类型的单位（[Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)）实例。单位是游戏世界中的实体对象，支持属性配置与父子层级管理，创建后可挂载到 [World](https://u5-creator.s3.game.163.com/manual/se/game_api/service/World.html) 节点下参与场景渲染与物理模拟。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `unitType` | `String` | 要创建的单位类型名称，如 "WorldUnit"、"ModelUnit"、"EffectUnit" 等 |
| `values` | `Table` | 初始化属性键值表。可填写的属性键来自对应 unitType 的 API 文档（即该类型及其继承链上声明的属性），例如 { Name = "box", Position = Vector3.New(0, 10, 0), Parent = world }。注意：UnitId 为系统保留键，传入会被忽略；本方法不会自动设置 Parent，需显式指定。具体支持哪些属性以该单位类型 API 文档中列出的属性为准。 |

**返回值** [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) | nil (新创建的单位实例，创建失败时返回 nil)

> 示例代码

> 通过全局 game 创建单位

```lua
-- @runtime client
local World = game:GetService('World')
local unit = game:CreateUnit('WorldUnit', {
    Name = 'MyUnit',
    Position = Vector3.New(10, 0, 0),
    Parent = World,
})
if unit ~= nil then
    print('单位创建成功:', unit.Name)
end
```

### IsLoaded

签名：`IsLoaded() -> Bool (是否已完成初始加载)`

判断客户端是否已完成初始加载。在加载完成后，游戏场景和资源才可安全访问。

**返回值** `Bool` (是否已完成初始加载)

> 示例代码

> 检查客户端是否加载完成

```lua
-- @runtime client
-- 获取 Game 实例

local loaded = game:IsLoaded()

if loaded then
    print("客户端已加载完成")
else
    print("客户端尚未加载完成")
end
```

### BindToClose

签名：`BindToClose(callback: Function) -> void`

注册一个回调函数，该函数会在服务器即将关闭时被调用。可用于在服务器关闭前执行清理工作，例如保存数据或通知玩家。

⚙ BindToClose 仅用于服务端关闭流程。callback 可接收关闭原因，但 CloseReason 枚举尚未进入当前公开 Surface；可用 tostring(closeReason) 记录诊断，不要比较自行猜测的枚举成员。服务器最多等待约 30 秒完成关闭回调。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `callback` | `Function` | 如果绑定的函数接受一个参数，则传递Enum.CloseReason，指定服务器关闭的原因。 |

**返回值** `void`

> 示例代码

> 在服务端注册关闭回调

```lua
-- @runtime server
game:BindToClose(function(closeReason)
    print('服务器即将关闭，原因:', tostring(closeReason))
    -- 在关闭等待窗口内完成必要的保存与清理
end)
```

### SetClipboardText

签名：`SetClipboardText(text: String) -> void`

将指定文本内容复制到系统剪贴板，方便玩家粘贴使用。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `text` | `String` | 要复制到剪切板的字符串。 |

**返回值** `void`

> 示例代码

> 调用 SetClipboardText

```lua
-- @runtime client

local text = "示例文本"  -- String
game:SetClipboardText(text)
print("已调用 SetClipboardText", text)
```
