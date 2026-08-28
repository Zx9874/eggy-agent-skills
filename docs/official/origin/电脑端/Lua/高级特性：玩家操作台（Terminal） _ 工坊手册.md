# 高级特性：玩家操作台（Terminal）

> ⚠️ **玩家操作台目前是实验特性。** 当前仅开放了部分输入、相机和设备相关能力，接口与使用方式可能继续调整。后续版本将逐步开放更多输入与本地表现功能。
>
> ⚠️ `TerminalAPI` 面向精细输入、相机控制和设备适配等高级定制场景。使用时需要同时编写 `main_terminal.lua` 与 `main.lua`，并处理二者之间的数据传递，具有一定的使用门槛。如果内置事件已经能满足需求，可以直接跳过本章。

## 游戏世界线与玩家操作台

所有同局玩家共同参与同一条**游戏世界线**。角色、机关、分数、胜负和游戏规则都属于世界线，由 `main.lua` 处理。这也是默认的游戏开发入口。

和统一的游戏世界线所不一样的是，每位玩家都有一个独立的**操作台（Terminal）**。操作台连接着触摸屏、鼠标、手柄等输入设备，也包含用于观察游戏世界线的显示器。`main_terminal.lua` 是操作台脚本的入口，负责读取当前玩家的输入、相机和设备信息，以及呈现只影响当前玩家的本地反馈。

> ⚠️ `main_terminal.lua` 中**只能使用 `TerminalAPI`**，其他游戏 API（例如 `GameAPI`、`ActorAPI`）在该脚本中不可用。需要改变角色、机关、分数或游戏规则时，请使用 `TerminalAPI.call_game` 提交操作，再在 `main.lua` 中处理。

| 部分 | 脚本 | 主要作用 |
| --- | --- | --- |
| 游戏世界线 | `main.lua` | 处理角色、机关、分数和游戏规则 |
| 玩家操作台 | `main_terminal.lua` | 读取当前玩家的输入、相机和设备信息；处理本地表现 |

**游戏已经为常用操作内置了从玩家操作台向世界线提交操作的流程，以及根据世界线显示内容的功能。** 例如，玩家点击 UI 按钮或进行常规角色操作时，您可以直接在对应触发器的事件回调中收到结果。对于大多数地图功能，优先使用这些内置事件即可，**无需编写 `main_terminal.lua`**。

## 快速入门

下面用“玩家触摸屏幕后，把触摸位置提交到游戏世界线”演示最常见的用法。需要分别编辑操作台脚本 `main_terminal.lua` 和世界线脚本 `main.lua`。

先在 `main_terminal.lua` 中监听触摸，并将坐标打包成字符串后提交：

```lua
-- main_terminal.lua（玩家操作台）
TerminalAPI.set_touch_handler(
    function(device_x, device_y, ui_x, ui_y)
        local payload = string.pack("<ff", device_x, device_y)
        TerminalAPI.call_game("on_player_touch", payload)
    end,
    nil, -- 移动时不处理
    nil  -- 抬起时不处理
)
```

再在 `main.lua` 中定义同名函数，接收并解包数据：

```lua
-- main.lua（游戏世界线）
function on_player_touch(payload)
    local device_x, device_y = string.unpack("<ff", payload)
    print("玩家按下屏幕：", device_x, device_y)

    -- 在这里处理角色、机关、分数等正式游戏逻辑
end
```

`set_touch_handler` 的三个参数依次是“按下”“移动”“抬起”回调；不需要处理的回调传 `nil`。`call_game` 的第一个参数是 `main.lua` 中的函数名，第二个参数必须是字符串，因此复杂数据需要用 `string.pack` / `string.unpack` 自行序列化和反序列化。

这个流程可以概括为：**操作台读取当前玩家输入 → `call_game` 提交字符串数据 → 世界线同名函数处理正式游戏结果。**

## 核心概念

### 哪些情况下应使用TerminalAPI

| 示例需求 | 推荐方式 |
| --- | --- |
| 普通 UI 按钮点击 | 使用编辑器 UI 事件或对应触发器，不必用TerminalAPI |
| 常规角色操作 | 使用已有角色操作事件，不必用TerminalAPI |
| 精确区分触摸按下、移动、持续和抬起 | 使用TerminalAPI `set_touch_handler` |
| 根据相机方向选择目标或控制表现 | 使用相机相关 TerminalAPI |
| 根据设备信息调整本地表现 | 使用设备相关 TerminalAPI |

### 为什么操作要提交到世界线

每位玩家的操作台收到的信息可能不同，例如触摸位置、相机方向、设备帧率和屏幕分辨率。操作台可以立即播放震动等只影响当前玩家的本地反馈；但如果操作需要改变角色、机关、分数或游戏规则，就必须提交到共同的游戏世界线。

如果各个操作台用自己的本地信息直接改变游戏世界，不同玩家可能得到不同结果，造成“世界线分叉”。将操作提交到世界线后，再由世界线产生正式结果，可以确保所有玩家共同参与同一个游戏世界线。

```text
玩家输入 ──────────────────────────────┐
   ↓                                  │
玩家操作台（main_terminal.lua）        │
   │                                  │
   │ TerminalAPI.call_game(...)       │
   ↓                                  │
游戏世界线（main.lua）                 │
   │                                  │
   └─（可选）LuaAPI.call_terminal(...) ─┘
      向所有玩家的操作台注入操作信号
```

通常流程到 `call_game` 提交世界线后即可结束。只有当世界线需要主动要求各玩家操作台执行本地表现或操作时，才需要使用可选的 `call_terminal` 流程。

### 操作台与世界线通信

#### 操作台向世界线提交操作：`TerminalAPI.call_game`

`TerminalAPI.call_game(name, payload)` 将当前操作台中的本地操作提交到世界线：

* `name`：`main.lua` 中接收调用的全局函数名。
* `payload`：一个**字符串**。复杂数据需要由您自行序列化和反序列化，推荐使用 `string.pack` / `string.unpack`。

```lua
-- main_terminal.lua：序列化后提交
local payload = string.pack("<ff", x, y)
TerminalAPI.call_game("on_terminal_input", payload)
```

```lua
-- main.lua：同名函数接收并反序列化
function on_terminal_input(payload)
    local x, y = string.unpack("<ff", payload)
end
```

> ⚠️ \*\*`call_game` 有流量限制：任意连续 600 个显示更新周期内，最多提交 60KB。超过限制后，新的 `call_game` 请求会被直接丢弃。\*\*建议按平均每个显示更新周期不超过 100 字节进行设计，仅在状态发生有效变化时提交，并使用 `string.pack` 紧凑打包数据。

#### 世界线通知操作台（可选）：`LuaAPI.call_terminal`

`LuaAPI.call_terminal(name, args)` 向**所有玩家的操作台**注入一次操作信号：

* `name`：`main_terminal.lua` 中接收调用的全局函数名。
* `args`：一个 **table**。目标函数会收到这个 table 作为**唯一参数**，不会自动展开。需要在函数内自行取用其中的字段。

> ⚠️ `args` 只能传递简单表、字符串和数学类型（数字等），**不能传递单位**。

## 案例实战

### 案例一：触摸点选并提交到世界线

下面展示一个触摸点选案例。每张地图可使用一个 `main_terminal.lua`（操作台）与 `main.lua`（游戏世界线）配合：

```lua
-- main_terminal.lua（玩家操作台）
TerminalAPI.set_touch_handler(
    function(device_x, device_y, ui_x, ui_y) -- 按下
        -- 设备坐标可直接用于生成世界射线
        local origin = TerminalAPI.device_to_world_origin(device_x, device_y)
        local direction = TerminalAPI.device_to_world_direction(device_x, device_y)

        -- 操作台先把射线数据打包，再提交到游戏世界线
        TerminalAPI.call_game("on_touch_down", string.pack("<ffffff",
            origin.x, origin.y, origin.z,
            direction.x, direction.y, direction.z))
    end,
    nil, -- 移动
    nil  -- 抬起
)
```

```lua
-- main.lua（游戏世界线）
function on_touch_down(data)
    local ox, oy, oz, dx, dy, dz = string.unpack("<ffffff", data)
    local origin = math.Vector3(ox, oy, oz)
    local direction = math.Vector3(dx, dy, dz)

    -- 在这里处理射线检测、选中单位、触发机关等正式游戏结果
end
```

操作流程如下：

```text
玩家触摸操作台
   ↓
main_terminal.lua 读取触摸位置
   ↓
TerminalAPI.call_game(...) 将操作提交到世界线
   ↓
main.lua 处理操作，角色、机关或规则产生正式变化
   ↓
操作台显示器观察世界线产生的结果
```

### 案例二：同步当前玩家的相机方向

相机在场景加载时需要准备，可能迟于操作台脚本启动。`get_main_camera()` 暂时可能返回 `nil`，因此每次使用相机前都应重新获取并检查。

下面使用 `set_tick_handler` 驱动检查：

```lua
-- main_terminal.lua
local last_direction = math.Vector3(0, 1, 0)

TerminalAPI.set_tick_handler(function(dt)
    local camera = TerminalAPI.get_main_camera()
    if camera == nil then
        return -- 相机尚未准备好，本次跳过
    end

    local direction = camera.get_direction()

    -- 相机方向变化足够明显时才提交，避免频繁发送相同数据
    if math.abs(direction:dot(last_direction)) < 0.999 then
        last_direction = direction
        TerminalAPI.call_game("on_camera_changed",
            string.pack("<fff", direction.x, direction.y, direction.z))
    end
end, nil)
```

```lua
-- main.lua
function on_camera_changed(data)
    local x, y, z = string.unpack("<fff", data)
    local direction = math.Vector3(x, y, z)

    -- 在这里根据当前玩家的相机方向处理正式游戏逻辑
end
```

### 案例三：设备坐标与 UI 坐标

触摸回调会同时提供设备坐标与 UI 坐标：

```lua
TerminalAPI.set_touch_handler(function(device_x, device_y, ui_x, ui_y)
    print("device=(" .. tostring(device_x) .. ", " .. tostring(device_y) .. ")")
    print("ui=(" .. tostring(ui_x) .. ", " .. tostring(ui_y) .. ")")

    -- 两套坐标也可以相互转换
    local ui_position = TerminalAPI.convert_device_to_ui(device_x, device_y)
    local device_position = TerminalAPI.convert_ui_to_device(ui_x, ui_y)
end, nil, nil)
```

* 设备坐标用于 `device_to_world_origin`、`device_to_world_direction` 等接口。
* UI 坐标用于对齐 UI 布局。
* 不同设备的分辨率比例可能不同，请使用转换 API，不要硬编码比例。

### 案例四：定时读取帧率

操作台可以使用显示更新回调读取当前设备帧率。不要每个周期都打印或提交数据，可以按时间间隔采样：

```lua
local sample_interval = math.Fixed(2)
local sample_timer = math.Fixed(0)

TerminalAPI.set_tick_handler(function(dt)
    sample_timer = sample_timer + dt
    if sample_timer >= sample_interval then
        sample_timer = math.Fixed(0)
        print("FPS = " .. tostring(TerminalAPI.get_fps()))
    end
end, nil)
```

## 常用能力

| 能力 | API | 说明 |
| --- | --- | --- |
| 操作台输入 | `set_touch_handler` / `get_touch_state` | 读取按下、移动和抬起操作 |
| 显示器坐标转换 | `device_to_world_origin` / `device_to_world_direction` / `world_to_device` | 射线起点/方向、3D 点投影到显示器 |
| 相机观察 | `get_main_camera` | 按需获取当前玩家的观察视角，使用前检查 `nil` |
| 操作台设备 | `get_fps` / `vibrate` / `get_device_orientation` / `get_network_type` | 帧率、震动、横竖屏和网络信息 |
| 定时与更新 | `set_tick_handler` / `create_timer` | 显示更新回调与定时器 |
| 提交操作 | `call_game` | 操作台 → 游戏世界线 |

## 坐标系

操作台触摸与显示器坐标转换涉及两套坐标系，不要混用：

|  | 设备坐标（device） | UI 坐标（ui） |
| --- | --- | --- |
| 原点 | 左上，y 向下 | 左下，y 向上 |
| 单位 | 真实像素 | 设计分辨率 |
| 用途 | `device_to_world_*` / `world_to_device` / `get_touch_position_device` | UI 布局对齐 / `get_touch_position_ui` |

转换用 `convert_device_to_ui` / `convert_ui_to_device`。两套比例随设备 DPI 变化，不要硬编码。

## 注意事项

> ⚠️ 操作台中读取的信息属于当前玩家。需要改变角色、机关或游戏规则时，必须使用 `call_game` 提交到世界线。

> ⚠️ 相机在场景加载时需要准备，`get_main_camera()` 可能暂时返回 `nil`。每次使用相机前都应重新获取并检查，不能长期缓存相机引用。

> ℹ️ `set_tick_handler` / `set_touch_handler` 各自只能注册一个回调，重复设置会覆盖，传 `nil` 清除。

完整 API 列表与签名见 TerminalAPI 文档。
