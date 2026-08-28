# 第 7 章：Players、输入与角色

获取玩家与角色、处理输入和阵营信息，并兼容不同运行包的集合形态。

## 你会学到什么

* 玩家加入和离开事件。
* LocalPlayer 和 Character 的关系。
* 如何监听键盘、鼠标输入。
* 阵营列表与成员变化监听。

## Players 服务

`Players` 是玩家管理服务，提供玩家列表、玩家事件和查找功能。

| API | 说明 | 运行端 |
| --- | --- | --- |
| `Players.PlayerAdded` | 玩家加入事件 | 双端；权威处理推荐 server |
| `Players.PlayerRemoving` | 玩家离开事件 | 双端；权威处理推荐 server |
| `Players.LocalPlayer` | 本地玩家 | client |
| `Players:GetPlayers()` | 获取所有玩家列表 | 双端 |
| `Players:GetPlayerByUserId(userId)` | 按字符串玩家编号查找玩家 | 双端 |
| `Players:GetPlayerFromCharacter(char)` | 通过角色反查玩家 | 双端 |

两个查询函数在目标玩家不存在、离线或角色无法归属到玩家时会返回 nil，使用返回值前要先判空。

本章先讲 Player 与输入的基础。角色系统本身会在第 13、14 章展开；这里你只需要记住：

* `Player` 是玩家账号/连接对象，有字符串玩家编号 `UserId`、`GetName()`、`CharacterAdded` 等。
* `Character` 是玩家在场景里的角色 Unit，碰撞、位置、动画发生在 Character 上。
* server 负责玩家列表、阵营、得分、反查角色。
* client 负责 `LocalPlayer`、键盘鼠标触屏输入和本地表现。

## 最小示例：玩家加入欢迎

运行端：server  
 文件：`server/main.lua`

```lua
local Players = game:GetService("Players")

if not Players then
    print("[SE Lua Guide][ERROR] Players 服务获取失败")
    return
end

-- 玩家加入时触发
Players.PlayerAdded:Connect(function(player)
    print("[SE Lua Guide] 玩家加入:", player:GetName(), "UserId:", player.UserId)
    print("[SE Lua Guide] 欢迎加入:", player:GetName())
end)

-- 玩家离开时触发
Players.PlayerRemoving:Connect(function(player)
    print("[SE Lua Guide] 玩家离开:", player:GetName())
end)
```

## 进阶：遍历所有玩家

```lua
local Players = game:GetService("Players")

if not Players then
    print("[SE Lua Guide][ERROR] Players 服务获取失败")
    return
end

local allPlayers = Players:GetPlayers()
print("[SE Lua Guide] 当前在线人数:", #allPlayers)
for _, player in ipairs(allPlayers) do
    print("  -", player:GetName(), player.UserId)
end
```

## UserInputService：监听输入

运行端：client  
 文件：`client/main.lua`

```lua
local UserInputService = game:GetService("UserInputService")

if not UserInputService then
    print("[SE Lua Guide][ERROR] UserInputService 获取失败")
    return
end

-- 按键按下时触发
UserInputService.InputBegan:Connect(function(inputObject, gameProcessedEvent)
    -- gameProcessedEvent 为 true 表示输入被引擎处理（如聊天框打开时），跳过
    if gameProcessedEvent then return end

    -- 判断是否按了键盘 B 键
    if inputObject.UserInputType == Enums.UserInputType.Keyboard
        and inputObject.KeyCode == Enums.KeyCode.B then
        print("[SE Lua Guide] 玩家按下了 B 键")
    end
end)

-- 按键松开时触发
UserInputService.InputEnded:Connect(function(inputObject, gameProcessedEvent)
    if gameProcessedEvent then return end
    if inputObject.UserInputType == Enums.UserInputType.Keyboard then
        print("[SE Lua Guide] 松开了键:", inputObject.KeyCode)
    end
end)
```

如果只是检查某个键当前是否按下，也可以用轮询式接口：

```lua
local UserInputService = game:GetService("UserInputService")

if not UserInputService then
    print("[SE Lua Guide][ERROR] UserInputService 获取失败")
    return
end

if UserInputService:IsKeyDown(Enums.KeyCode.B) then
    print("[SE Lua Guide] B 键正在按下")
end
```

事件适合“按下瞬间触发技能”；轮询适合“持续按住移动/蓄力”。

## InputObject 结构

| 属性 | 说明 |
| --- | --- |
| `UserInputType` | 输入类型（Keyboard、MouseButton、Touch 等） |
| `KeyCode` | 按键码（仅键盘输入时有效） |
| `Position` | 输入位置（鼠标/触屏） |
| `Delta` | 位置变化量 |

## 进阶：通过角色反查玩家

在碰撞事件中，`otherUnit` 的公开类型只是泛 `Unit`。只有确认它确实是 `EggyUnit` 后，才能把它传给 `GetPlayerFromCharacter`：

```lua
local Players = game:GetService("Players")

if not Players then
    print("[SE Lua Guide][ERROR] Players 服务获取失败")
    return
end

local function GetPlayerFromCollisionUnit(otherUnit)
    if not otherUnit or not otherUnit:IsA("EggyUnit") then
        return nil
    end
    return Players:GetPlayerFromCharacter(otherUnit)
end

-- 在 OnCollisionEnter 回调里调用：
-- local player = GetPlayerFromCollisionUnit(otherUnit)
```

这个帮助函数宁可在无法证明类型时返回 `nil`，也不猜“碰到角色的某个子对象就一定等于 Character”。调用方仍要对返回的 Player 判空。

## 进阶：等待角色加载

玩家加入时角色可能还没加载完成。可以监听 `CharacterAdded` 事件：

```lua
local Players = game:GetService("Players")

if not Players then
    print("[SE Lua Guide][ERROR] Players 服务获取失败")
    return
end

local function OnCharacterReady(player, character)
    print("[SE Lua Guide] 玩家", player:GetName(), "的角色已就绪:", character)
end

local boundPlayers = {}
local characterConnections = {}

local function BindPlayer(player)
    if boundPlayers[player] then return end
    boundPlayers[player] = true

    local lastCharacter = nil
    local function HandleCharacter(character)
        -- 先监听、后读取快照时，两条路径可能看到同一个角色；用引用去重。
        if not character or character == lastCharacter then return end
        lastCharacter = character
        OnCharacterReady(player, character)
    end

    -- 先建立监听，避免在读取当前 Character 的瞬间漏掉重生事件。
    characterConnections[player] = player.CharacterAdded:Connect(HandleCharacter)
    HandleCharacter(player.Character)
end

-- 先监听未来加入，再补脚本启动前已经在线的玩家。
Players.PlayerAdded:Connect(BindPlayer)
for _, player in ipairs(Players:GetPlayers()) do
    BindPlayer(player)
end

Players.PlayerRemoving:Connect(function(player)
    local connection = characterConnections[player]
    if connection then
        connection:Disconnect()
        characterConnections[player] = nil
    end
    boundPlayers[player] = nil
end)
```

`CharacterAdded` 只报告连接建立之后发生的加载或重生，因此必须同时读取已有 `player.Character`。上面的顺序是“先监听、再读快照、按角色引用去重”，既避免漏事件，也避免同一角色处理两次；玩家离开时还会断开角色连接。第 13 章会继续封装这套生命周期。

## 阵营信息

运行端：server

```lua
local Camps = game:GetService("Camps")

if not Camps then
    print("[SE Lua Guide][ERROR] Camps 服务获取失败")
    return
end

-- 当前 Meta 把两个返回值都声明为 Array；部分仍在使用的运行包中，
-- Camp:GetPlayers() 可能返回 generic-for 迭代函数。统一收集成数组后再计数。
local function ToArray(values)
    if type(values) == "table" then
        return values
    end

    local result = {}
    if type(values) == "function" then
        for _, value in values do
            result[#result + 1] = value
        end
    end
    return result
end

for _, camp in ipairs(Camps:GetCamps()) do
    local campPlayers = ToArray(camp:GetPlayers())
    print("[SE Lua Guide] 当前阵营玩家数:", #campPlayers)

    camp.PlayerAdded:Connect(function(player)
        print("[SE Lua Guide] 玩家加入阵营:", player:GetName())
    end)
end
```

当前公开 Camps / Camp API 只提供阵营数组、成员集合和成员增减事件；阵营分配和出生点查询没有公开成员，不要调用历史代码里的 `AssignCamp` 或 `GetCampSpawnPoint`。Meta 已把 `Camp:GetPlayers()` 声明为数组，但 2026-08-23 的目标 SE 运行包仍实测返回迭代函数，所以示例保留双形态归一化。升级运行包后可以继续使用这段兼容写法，不要据此把 Meta 改回迭代器。

## 常见错误

### 错误：在服务端使用 LocalPlayer

`LocalPlayer` 只在客户端有意义。服务端应通过 `PlayerAdded` 事件或 `GetPlayerByUserId` 获取玩家。

### 错误：把输入逻辑写在 server

键盘、鼠标等输入属于客户端。涉及玩法判定的结果再通过 RemoteEvent 交给 server。

### 错误：PlayerAdded 时立刻操作 Character

玩家加入时角色可能还没加载完成，固定等待若干秒也不能证明它已就绪。应先处理已有 `player.Character`，再监听 `player.CharacterAdded`。

### 错误：把 Player 当成 Character

`Player.UserId` 和 `player:GetName()` 在 Player 上；位置、碰撞、动画在 Character 上。碰撞事件只给泛 `Unit`，必须先用 `IsA("EggyUnit")` 证明类型，再调用 `Players:GetPlayerFromCharacter(otherUnit)`，并对结果判空。

## 练习任务

1. 玩家加入时打印欢迎信息，并验证离开事件也能正常记录。
2. 客户端按下 B 键时打印日志。
3. 服务端遍历所有阵营，打印当前成员数量并监听玩家加入事件。

## 本章验收标准

* [ ] 我知道 PlayerAdded/PlayerRemoving 的用法。
* [ ] 我知道 LocalPlayer 只在客户端可用。
* [ ] 我能用 UserInputService 监听按键输入。
* [ ] 我知道输入逻辑应放在 client。
* [ ] 我知道 Player 和 Character 不是同一个对象。

## 本章产物

* 一个 server 玩家生命周期脚本：玩家加入、角色加载、阵营成员变化日志都能打印。
* 一个 client 输入脚本：按键触发本地日志或提示，不直接修改权威分数。
* 一张 Player / Character 对照表，标出身份字段、位置/碰撞字段和反查方式。

## 本章 API 对照

* [Players](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Players.html)
* [Player](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Player.html)
* [UserInputService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/UserInputService.html)
* [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html)
* [EggyUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EggyUnit.html)
* [Camps](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Camps.html)
* [Camp](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Camp.html)

## 下一章预告

你掌握了玩家和输入。下一章是连接双端的关键：用 RemoteEvent 让客户端请求加分、服务端校验后回传结果。
