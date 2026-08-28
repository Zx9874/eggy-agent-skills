# UserInputService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `client` |

[UserInputService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/UserInputService.html) 负责捕获和处理客户端的所有用户输入，包括键盘、鼠标、触摸和手柄操作。它提供按键状态查询、鼠标位置获取、输入事件监听以及蛋仔专属动作按钮的回调，是交互逻辑的核心入口。

## 适用场景

在需要响应玩家操作时，通过该服务监听 InputBegan 等事件来驱动角色移动、跳跃或 UI 交互，也可直接查询按键状态实现持续输入检测。

## 使用要点

通过 game:GetService("UserInputService") 获取实例，使用 InputBegan 事件监听按键按下，或调用 IsKeyDown 判断按键是否按住。对于蛋仔专属操作，直接监听 ClickEggyJump 等事件即可响应跳跃、冲刺等动作。

## 注意事项

[UserInputService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/UserInputService.html) 的输入事件以当前客户端输入系统实际派发为准。蛋仔专属按钮优先监听 ClickEggyJump/ClickEggyLift/ClickEggyRoll/ClickEggyRush；通用键盘跳跃可通过 InputBegan + Enums.KeyCode.Space 处理。JumpRequest 在当前包中不保证触发，不应作为唯一跳跃入口。

## 代码示例

### 过滤已由 UI 处理的键盘输入

```lua
-- @runtime client
local UserInputService = game:GetService('UserInputService')
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode == Enums.KeyCode.Space then
        print('收到未被 UI 消费的空格输入')
    end
end)
```

## 事件 (17)

### InputBegan

签名：`InputBegan(inputObject: InputObject, gameProcessedEvent: Bool)` 触发：`local`

当用户开始输入时触发，包括键盘按键、鼠标按钮、触摸等。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `inputObject` | [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) | 输入对象 |
| `gameProcessedEvent` | `Bool` | 游戏是否已处理该事件 |

> 示例代码

> 监听键盘按下事件

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 监听 InputBegan 事件，当任意输入开始时触发
userInputService.InputBegan:Once(function(inputObject, gameProcessedEvent)
    -- 打印输入对象信息
    print("输入开始:", inputObject)
    -- 检查是否为键盘输入且未被 UI 处理
    if inputObject.UserInputType == Enums.UserInputType.Keyboard and not gameProcessedEvent then
        print("键盘按键按下:", inputObject.KeyCode)
    end
end)
```

### InputChanged

签名：`InputChanged(inputObject: InputObject, gameProcessedEvent: Bool)` 触发：`local`

当输入状态发生变化时触发，例如鼠标移动、触摸滑动或按键状态改变。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `inputObject` | [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) | 输入对象 |
| `gameProcessedEvent` | `Bool` | 游戏是否已处理该事件 |

> 示例代码

> 监听输入变化事件

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 监听 InputChanged 事件，当输入状态发生变化时触发
userInputService.InputChanged:Once(function(inputObject, gameProcessedEvent)
    -- 打印输入变化信息
    print("输入变化:", inputObject)
    -- 检查是否为鼠标移动且未被 UI 处理
    if inputObject.UserInputType == Enums.UserInputType.MouseMovement and not gameProcessedEvent then
        print("鼠标移动位置:", inputObject.Position)
    end
end)
```

### InputEnded

签名：`InputEnded(inputObject: InputObject, gameProcessedEvent: Bool)` 触发：`local`

当用户结束输入时触发，例如释放键盘按键、鼠标按钮或触摸结束。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `inputObject` | [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) | 输入对象 |
| `gameProcessedEvent` | `Bool` | 游戏是否已处理该事件 |

> 示例代码

> 监听输入结束事件

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 监听 InputEnded 事件，当输入结束时触发
userInputService.InputEnded:Once(function(inputObject, gameProcessedEvent)
    -- 打印输入结束信息
    print("输入结束:", inputObject)
    -- 检查是否为键盘按键释放且未被 UI 处理
    if inputObject.UserInputType == Enums.UserInputType.Keyboard and not gameProcessedEvent then
        print("键盘按键释放:", inputObject.KeyCode)
    end
end)
```

### LastInputTypeChanged

签名：`LastInputTypeChanged(lastInputType: UserInputType)` 触发：`local`

当最后一次输入类型发生变化时触发，例如从键盘切换到触摸。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `lastInputType` | [UserInputType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputType.html) | 最后的输入类型 |

> 示例代码

> 监听最后输入类型变化

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 监听 LastInputTypeChanged 事件，当最后输入类型改变时触发
userInputService.LastInputTypeChanged:Once(function(lastInputType)
    -- 打印新的最后输入类型
    print("最后输入类型变为:", lastInputType)
    -- 根据输入类型切换 UI 提示
    if lastInputType == Enums.UserInputType.Keyboard then
        print("当前使用键盘输入")
    elseif lastInputType == Enums.UserInputType.Touch then
        print("当前使用触摸输入")
    end
end)
```

### TouchStarted

签名：`TouchStarted(touch: InputObject, gameProcessedEvent: Bool)` 触发：`local`

当触摸开始时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `touch` | [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) | 触摸输入对象 |
| `gameProcessedEvent` | `Bool` | 游戏是否已处理该事件 |

> 示例代码

> 监听触摸开始事件

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 监听 TouchStarted 事件，当触摸开始时触发
userInputService.TouchStarted:Once(function(touch, gameProcessedEvent)
    -- 打印触摸开始信息
    print("触摸开始:", touch)
    -- 获取触摸位置
    local position = touch.Position
    print("触摸位置:", position)
end)
```

### TouchMoved

签名：`TouchMoved(touch: InputObject, gameProcessedEvent: Bool)` 触发：`local`

当触摸位置移动时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `touch` | [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) | 触摸输入对象 |
| `gameProcessedEvent` | `Bool` | 游戏是否已处理该事件 |

> 示例代码

> 监听触摸移动事件

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 监听 TouchMoved 事件，当触摸点移动时触发
userInputService.TouchMoved:Once(function(touch, gameProcessedEvent)
    -- 打印触摸移动信息
    print("触摸移动:", touch)
    -- 获取触摸位置
    local position = touch.Position
    print("触摸位置:", position)
end)
```

### TouchEnded

签名：`TouchEnded(touch: InputObject, gameProcessedEvent: Bool)` 触发：`local`

当触摸结束时触发。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `touch` | [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) | 触摸输入对象 |
| `gameProcessedEvent` | `Bool` | 游戏是否已处理该事件 |

> 示例代码

> 监听触摸结束事件

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 监听 TouchEnded 事件，当触摸结束时触发
userInputService.TouchEnded:Once(function(touch, gameProcessedEvent)
    -- 打印触摸结束信息
    print("触摸结束:", touch)
    -- 获取触摸位置
    local position = touch.Position
    print("触摸结束位置:", position)
end)
```

### TouchTap

签名：`TouchTap(touchPositions: Table&lt;Vector2&gt;, gameProcessedEvent: Bool)` 触发：`local`

当轻击触摸发生时触发，提供触摸位置。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `touchPositions` | Table<[Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)> | 参与手势的所有手指屏幕坐标（Tap 永远是 1 个） |
| `gameProcessedEvent` | `Bool` | 游戏是否已处理该事件 |

> 示例代码

> 监听轻点事件

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 监听 TouchTap 事件，当轻点屏幕时触发
userInputService.TouchTap:Once(function(touchPositions, gameProcessedEvent)
    -- 打印轻点位置信息
    print("轻点位置数量:", #touchPositions)
    for i, pos in ipairs(touchPositions) do
        print("轻点位置", i, ":", pos)
    end
end)
```

### TouchPinch

签名：`TouchPinch(touchPositions: Table&lt;Vector2&gt;, scale: Float, velocity: Float, state: UserInputState, gameProcessedEvent: Bool)` 触发：`local`

当双指捏合手势发生时触发，提供触摸位置、缩放比例和速度。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `touchPositions` | Table<[Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)> | 两根手指当前屏幕坐标 |
| `scale` | `Float` | 当前距离/初始距离，1.0=未变化 |
| `velocity` | `Float` | scale 的瞬时变化率（per 秒） |
| `state` | [UserInputState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputState.html) | 手势状态：Begin/Change/End/Cancel |
| `gameProcessedEvent` | `Bool` | 游戏是否已处理该事件 |

> 示例代码

> 监听双指缩放事件

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 监听 TouchPinch 事件，当双指缩放时触发
userInputService.TouchPinch:Once(function(touchPositions, scale, velocity, state, gameProcessedEvent)
    -- 打印缩放信息
    print("双指缩放 - 缩放比例:", scale, "速度:", velocity, "状态:", state)
    -- 根据缩放状态调整相机距离（示例）
    if state == Enums.UserInputState.Change then
        print("正在缩放，当前比例:", scale)
    end
end)
```

### TouchRotate

签名：`TouchRotate(touchPositions: Table&lt;Vector2&gt;, rotation: Float, velocity: Float, state: UserInputState, gameProcessedEvent: Bool)` 触发：`local`

当双指旋转手势发生时触发，提供触摸位置、旋转角度和速度。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `touchPositions` | Table<[Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html)> | 两根手指当前屏幕坐标 |
| `rotation` | `Float` | 相对初始角度的累计弧度（带符号，逆时针正） |
| `velocity` | `Float` | rotation 的瞬时变化率（rad/秒） |
| `state` | [UserInputState](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputState.html) | 手势状态：Begin/Change/End/Cancel |
| `gameProcessedEvent` | `Bool` | 游戏是否已处理该事件 |

> 示例代码

> 监听双指旋转事件

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 监听 TouchRotate 事件，当双指旋转时触发
userInputService.TouchRotate:Once(function(touchPositions, rotation, velocity, state, gameProcessedEvent)
    -- 打印旋转信息
    print("双指旋转 - 旋转角度:", rotation, "速度:", velocity, "状态:", state)
    -- 根据旋转状态调整相机角度（示例）
    if state == Enums.UserInputState.Change then
        print("正在旋转，当前角度:", rotation)
    end
end)
```

### JoystickStart

签名：`JoystickStart()` 触发：`local`

当虚拟摇杆操作开始时触发。

> 示例代码

> 监听摇杆开始事件

```lua
-- @runtime client
-- 获取 UserInputService 服务实例
local userInputService = game:GetService("UserInputService")

-- 监听摇杆开始事件
userInputService.JoystickStart:Once(function()
    print("摇杆操作开始")
end)
```

### JoystickMove

签名：`JoystickMove(x: Float, y: Float, length: Float)` 触发：`local`

当虚拟摇杆移动时触发，提供摇杆的 X、Y 偏移和长度。

| 回调参数 | 类型 | 说明 |
| --- | --- | --- |
| `x` | `Float` | x轴值 |
| `y` | `Float` | y轴值 |
| `length` | `Float` | 摇杆偏移长度 |

> 示例代码

> 监听摇杆移动事件

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 监听 JoystickMove 事件，当摇杆移动时触发
userInputService.JoystickMove:Once(function(x, y, length)
    -- 打印摇杆移动数据
    print("摇杆移动 - X:", x, "Y:", y, "长度:", length)
    -- 根据摇杆方向控制角色移动（示例）
    if length > 0.1 then
        print("摇杆方向:", x, y)
    end
end)
```

### JoystickEnd

签名：`JoystickEnd()` 触发：`local`

当虚拟摇杆操作结束时触发。

> 示例代码

> 监听摇杆结束事件

```lua
-- @runtime client
-- 获取 UserInputService 服务实例
local userInputService = game:GetService("UserInputService")

-- 监听摇杆结束事件
userInputService.JoystickEnd:Once(function()
    print("摇杆操作结束")
end)
```

### ClickEggyJump

签名：`ClickEggyJump()` 触发：`local`

当玩家点击蛋仔跳跃按钮时触发。

> 示例代码

> 监听蛋仔跳跃按钮点击

```lua
-- @runtime client
-- 获取 UserInputService 服务实例
local userInputService = game:GetService("UserInputService")

-- 监听蛋仔跳跃按钮点击事件
userInputService.ClickEggyJump:Once(function()
    print("蛋仔跳跃按钮被点击")
end)
```

### ClickEggyRush

签名：`ClickEggyRush()` 触发：`local`

当玩家点击蛋仔冲刺按钮时触发。

> 示例代码

> 监听蛋仔冲刺按钮点击

```lua
-- @runtime client
-- 获取 UserInputService 服务实例
local userInputService = game:GetService("UserInputService")

-- 监听蛋仔冲刺按钮点击事件
userInputService.ClickEggyRush:Once(function()
    print("蛋仔冲刺按钮被点击")
end)
```

### ClickEggyRoll

签名：`ClickEggyRoll()` 触发：`local`

当玩家点击蛋仔滚动按钮时触发。

> 示例代码

> 监听蛋仔滚动按钮点击

```lua
-- @runtime client
-- 获取 UserInputService 服务实例
local userInputService = game:GetService("UserInputService")

-- 监听蛋仔滚动按钮点击事件
userInputService.ClickEggyRoll:Once(function()
    print("蛋仔滚动按钮被点击")
end)
```

### ClickEggyLift

签名：`ClickEggyLift()` 触发：`local`

当玩家点击蛋仔举起按钮时触发。

> 示例代码

> 监听蛋仔举起按钮点击

```lua
-- @runtime client
-- 获取 UserInputService 服务实例
local userInputService = game:GetService("UserInputService")

-- 监听蛋仔举起按钮点击事件
userInputService.ClickEggyLift:Once(function()
    print("蛋仔举起按钮被点击")
end)
```

## 函数 (15)

### IsKeyDown

签名：`IsKeyDown(keyCode: KeyCode) -> Bool (是否正在被按下)`

检查某个键盘按键是否正在被按下。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `keyCode` | [KeyCode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/KeyCode.html) | 键盘按键代码 |

**返回值** `Bool` (是否正在被按下)

> 示例代码

> 检查按键是否按下

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 检查空格键是否正在被按下
local isSpaceDown = userInputService:IsKeyDown(Enums.KeyCode.Space)
print("空格键是否按下:", isSpaceDown)
-- 检查 W 键是否正在被按下
local isWDown = userInputService:IsKeyDown(Enums.KeyCode.W)
print("W 键是否按下:", isWDown)
```

### IsMouseButtonPressed

签名：`IsMouseButtonPressed(userInputType: UserInputType) -> Bool (是否正在被按下)`

检查某个鼠标按钮是否正在被按下。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `userInputType` | [UserInputType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputType.html) | 用户输入类型 |

**返回值** `Bool` (是否正在被按下)

> 示例代码

> 检查鼠标按键是否按下

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 检查鼠标左键是否正在被按下
local isLeftPressed = userInputService:IsMouseButtonPressed(Enums.UserInputType.MouseButton1)
print("鼠标左键是否按下:", isLeftPressed)
-- 检查鼠标右键是否正在被按下
local isRightPressed = userInputService:IsMouseButtonPressed(Enums.UserInputType.MouseButton2)
print("鼠标右键是否按下:", isRightPressed)
```

### GetKeysPressed

签名：`GetKeysPressed() -> Array&lt;InputObject&gt; (按下的键对应的 InputObject 数组（顺序无保证）)`

获取所有当前正在被按下的键盘按键的 [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 列表。

**返回值** Array<[InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html)> (按下的键对应的 [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 数组（顺序无保证）)

> 示例代码

> 获取当前按下的键盘按键列表

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 获取当前所有按下的键盘按键
local keysPressed = userInputService:GetKeysPressed()
-- 打印按键数量
print("当前按下按键数量:", #keysPressed)
-- 遍历并打印每个按键的 KeyCode
for i, inputObject in ipairs(keysPressed) do
    print("按键", i, ":", inputObject.KeyCode)
end
```

### GetMouseButtonsPressed

签名：`GetMouseButtonsPressed() -> Array&lt;InputObject&gt; (按下的鼠标按键对应的 InputObject 数组（顺序无保证）)`

获取所有当前正在被按下的鼠标按键的 [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 列表。

**返回值** Array<[InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html)> (按下的鼠标按键对应的 [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 数组（顺序无保证）)

> 示例代码

> 获取当前按下的鼠标按键列表

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 获取当前所有按下的鼠标按键
local mouseButtonsPressed = userInputService:GetMouseButtonsPressed()
-- 打印鼠标按键数量
print("当前按下鼠标按键数量:", #mouseButtonsPressed)
-- 遍历并打印每个按键的 UserInputType
for i, inputObject in ipairs(mouseButtonsPressed) do
    print("鼠标按键", i, ":", inputObject.UserInputType)
end
```

### GetMouseLocation

签名：`GetMouseLocation() -> Vector2 (鼠标位置)`

获取当前鼠标在屏幕上的位置。

**返回值** [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) (鼠标位置)

> 示例代码

> 获取鼠标位置

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 获取当前鼠标位置
local mouseLocation = userInputService:GetMouseLocation()
-- 打印鼠标位置
print("鼠标位置:", mouseLocation)
-- 使用鼠标位置进行 UI 交互（示例）
print("鼠标 X:", mouseLocation.x, "Y:", mouseLocation.y)
```

### GetMouseDelta

签名：`GetMouseDelta() -> Vector2 (当前帧鼠标位移；未锁定时为 (0, 0))`

获取当前帧累计的鼠标位移。

**返回值** [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) (当前帧鼠标位移；未锁定时为 (0, 0))

> 示例代码

> 获取当前帧鼠标位移

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 获取当前帧累计的鼠标位移
local mouseDelta = userInputService:GetMouseDelta()
-- 打印鼠标位移
print("鼠标位移:", mouseDelta)
-- 使用鼠标位移控制相机旋转（示例）
if mouseDelta.x ~= 0 or mouseDelta.y ~= 0 then
    print("鼠标移动了:", mouseDelta.x, mouseDelta.y)
end
```

### TouchEnabled

签名：`TouchEnabled() -> Bool (是否支持触摸)`

检查当前设备是否支持触摸输入。

**返回值** `Bool` (是否支持触摸)

> 示例代码

> 检查是否支持触摸输入

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 检查当前设备是否支持触摸输入
local touchEnabled = userInputService:TouchEnabled()
print("是否支持触摸输入:", touchEnabled)
-- 根据触摸支持情况调整 UI（示例）
if touchEnabled then
    print("当前设备支持触摸，显示虚拟摇杆")
else
    print("当前设备不支持触摸，显示键盘提示")
end
```

### GetStringForKeyCode

签名：`GetStringForKeyCode(keyCode: KeyCode) -> String (可输入字符或空字符串，永不返回 nil)`

返回指定 [KeyCode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/KeyCode.html) 对应的可输入字符（基于 QWERTY 布局）。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `keyCode` | [KeyCode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/KeyCode.html) | [KeyCode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/KeyCode.html) 整数值（直接传 KeyCode.W 等枚举即可） |

**返回值** `String` (可输入字符或空字符串，永不返回 nil)

> 示例代码

> 获取按键对应的字符

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 获取空格键对应的字符
local spaceChar = userInputService:GetStringForKeyCode(Enums.KeyCode.Space)
print("空格键对应字符:", spaceChar)
-- 获取 A 键对应的字符
local aChar = userInputService:GetStringForKeyCode(Enums.KeyCode.A)
print("A 键对应字符:", aChar)
```

### GetMouseDeltaSensitivity

签名：`GetMouseDeltaSensitivity() -> Float (鼠标灵敏度)`

获取当前鼠标灵敏度设置。

**返回值** `Float` (鼠标灵敏度)

> 示例代码

> 获取鼠标灵敏度

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 获取当前鼠标灵敏度
local sensitivity = userInputService:GetMouseDeltaSensitivity()
-- 打印鼠标灵敏度
print("当前鼠标灵敏度:", sensitivity)
```

### SetMouseDeltaSensitivity

签名：`SetMouseDeltaSensitivity(sensitivity: Float) -> void`

设置鼠标灵敏度。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `sensitivity` | `Float` | 鼠标灵敏度 |

**返回值** `void`

> 示例代码

> 设置鼠标灵敏度

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 设置鼠标灵敏度为 0.5
userInputService:SetMouseDeltaSensitivity(0.5)
-- 验证设置后的灵敏度
local sensitivity = userInputService:GetMouseDeltaSensitivity()
print("设置后的鼠标灵敏度:", sensitivity)
```

### SetTouchMovementMode

签名：`SetTouchMovementMode(mode: DevTouchMovementMode) -> void`

设置触屏移动模式。

⚙ 使用 Enums.DevTouchMovementMode.UserChoice/Thumbstick/FixedThumbstick/DynamicThumbstick/Scriptable，禁止直接传数字。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `mode` | [DevTouchMovementMode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DevTouchMovementMode.html) | 触屏移动模式，使用 Enums.DevTouchMovementMode 的具体成员。 |

**返回值** `void`

> 示例代码

> 使用枚举设置触屏移动模式

```lua
-- @runtime client
local UserInputService = game:GetService('UserInputService')
local mode = Enums.DevTouchMovementMode.Thumbstick
UserInputService:SetTouchMovementMode(mode)
print('触屏移动模式已更新:', tostring(mode))
```

### GetJoystickMoveVector

签名：`GetJoystickMoveVector() -> Vector2 (当前虚拟摇杆的移动方向向量)`

获取当前虚拟摇杆的移动方向向量。

**返回值** [Vector2](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector2.html) (当前虚拟摇杆的移动方向向量)

> 示例代码

> 获取摇杆移动方向向量

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 获取当前摇杆移动方向向量
local moveVector = userInputService:GetJoystickMoveVector()
-- 打印摇杆方向向量
print("摇杆方向向量:", moveVector)
-- 使用方向向量控制移动（示例）
if moveVector.Magnitude > 0 then
    print("摇杆正在移动，方向:", moveVector.x, moveVector.y)
end
```

### GetJoystickMoveLength

签名：`GetJoystickMoveLength() -> Float (当前虚拟摇杆的偏移长度)`

获取当前虚拟摇杆的偏移长度。

**返回值** `Float` (当前虚拟摇杆的偏移长度)

> 示例代码

> 获取摇杆偏移长度

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 获取当前摇杆偏移长度
local joystickLength = userInputService:GetJoystickMoveLength()
print("摇杆偏移长度:", joystickLength)
-- 根据偏移长度判断摇杆是否被推动
if joystickLength > 0 then
    print("摇杆正在被推动")
end
```

### GetLastInputType

签名：`GetLastInputType() -> UserInputType (最后输入类型)`

获取最后一次输入的类型。

**返回值** [UserInputType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputType.html) (最后输入类型)

> 示例代码

> 获取最后输入类型

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 获取最后输入类型
local lastInputType = userInputService:GetLastInputType()
print("最后输入类型:", lastInputType)
-- 根据最后输入类型显示不同提示
if lastInputType == Enums.UserInputType.Keyboard then
    print("最后使用键盘输入")
elseif lastInputType == Enums.UserInputType.Touch then
    print("最后使用触摸输入")
end
```

### GetStringForInputType

签名：`GetStringForInputType(inputType: UserInputType) -> String (名字描述)`

获取输入类型的字符串描述。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `inputType` | [UserInputType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/UserInputType.html) | 输入类型 |

**返回值** `String` (名字描述)

> 示例代码

> 获取输入类型的描述字符串

```lua
-- @runtime client
-- 获取 UserInputService 服务
local userInputService = game:GetService("UserInputService")

-- 获取键盘输入类型的描述
local keyboardDesc = userInputService:GetStringForInputType(Enums.UserInputType.Keyboard)
print("键盘输入类型描述:", keyboardDesc)
-- 获取触摸输入类型的描述
local touchDesc = userInputService:GetStringForInputType(Enums.UserInputType.Touch)
print("触摸输入类型描述:", touchDesc)
```
