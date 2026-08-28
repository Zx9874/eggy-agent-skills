# StarterGui

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[StarterGui]**（4 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[StarterGui](https://u5-creator.s3.game.163.com/manual/se/game_api/service/StarterGui.html) 是管理核心 UI 界面显示与交互的全局服务，负责控制官方内置 UI 元素的启用状态，并提供对通用核心 UI 参数的读写能力。通过该服务，开发者可以按需隐藏或显示摇杆、跳跃按钮等控件，也能通过字符串键存取自定义 UI 配置。

## 适用场景

在需要临时禁用部分官方操作按钮（如投篮小游戏中隐藏跳跃和冲刺键）或查询某个核心 UI 当前是否可见时，通过 game:GetService("StarterGui") 获取服务实例并调用 SetCoreGuiEnabled 或 GetCoreGuiEnabled。

## 使用要点

先通过 game:GetService("StarterGui") 获取服务实例，然后调用 SetCoreGuiEnabled 并传入 Enums.CoreGuiType 枚举值（如 Enums.CoreGuiType.JumpButton）和布尔值来控制指定 UI 的显隐；使用 GetCoreGuiEnabled 查询当前状态。若需存取通用核心 UI 参数，可调用 SetCore 或 GetCore 并传入字符串键。

## 注意事项

SetCore 沿用通用核心 UI 字符串键接口，部分通知/弹窗能力在当前版本未实装，调用可能静默失败。SetCoreGuiEnabled 接收具体 [CoreGuiType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CoreGuiType.html) 枚举（如 Enums.CoreGuiType.All/Enums.CoreGuiType.Backpack）和 Bool enabled，不要直接传字符串或数字。若需自定义 UI 提示，建议改用 [EUIManager](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EUIManager.html) 创建控件而非依赖 SetCore 通知。

## 代码示例

### 控制核心 UI 元素的显示与隐藏

```lua
-- @runtime client
-- 获取 StarterGui 服务，用于控制核心 UI 的启用状态
local starterGui = game:GetService("StarterGui")

-- 隐藏跳跃按钮，适合需要自定义跳跃逻辑的场景
starterGui:SetCoreGuiEnabled(Enums.CoreGuiType.JumpButton, false)

-- 隐藏冲刺按钮，避免玩家在特定玩法中误触
starterGui:SetCoreGuiEnabled(Enums.CoreGuiType.RushButton, false)

-- 查询背包按钮的当前状态，确认是否已启用
local backpackEnabled = starterGui:GetCoreGuiEnabled(Enums.CoreGuiType.Backpack)
if backpackEnabled ~= nil then
    print("背包按钮状态: " .. tostring(backpackEnabled))
end

-- 查询所有核心 UI 的启用状态（All 类型返回整体状态）
local allEnabled = starterGui:GetCoreGuiEnabled(Enums.CoreGuiType.All)
if allEnabled ~= nil then
    print("所有核心 UI 状态: " .. tostring(allEnabled))
end
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (4)

### SetCoreGuiEnabled

签名：`SetCoreGuiEnabled(coreGuiType: CoreGuiType, enabled: Bool) -> void`

启用或禁用指定的 CoreGui 元素。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `coreGuiType` | [CoreGuiType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CoreGuiType.html) | CoreGui类型 |
| `enabled` | `Bool` | 是否启用 |

**返回值** `void`

> 示例代码

> 按枚举显隐核心 UI 元素

```lua
-- @runtime client
local StarterGui = game:GetService('StarterGui')
-- 必须传具体 Enums.CoreGuiType 成员，不能传字符串或数字
StarterGui:SetCoreGuiEnabled(Enums.CoreGuiType.Backpack, false)  -- 隐藏背包
StarterGui:SetCoreGuiEnabled(Enums.CoreGuiType.All, true)        -- 显示全部
```

### GetCoreGuiEnabled

签名：`GetCoreGuiEnabled(coreGuiType: CoreGuiType) -> Bool (是否启用)`

查询指定 CoreGui 元素的启用状态。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `coreGuiType` | [CoreGuiType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/CoreGuiType.html) | CoreGui类型 |

**返回值** `Bool` (是否启用)

> 示例代码

> 设置并查询背包按钮的启用状态

```lua
-- @runtime client
-- 获取 StarterGui 服务实例
local starterGui = game:GetService("StarterGui")

-- 先禁用背包按钮
starterGui:SetCoreGuiEnabled(Enums.CoreGuiType.Backpack, false)

-- 查询背包按钮当前是否启用
local isBackpackEnabled = starterGui:GetCoreGuiEnabled(Enums.CoreGuiType.Backpack)

-- 输出查询结果，应为 false
print("背包按钮启用状态:", isBackpackEnabled)
```

### SetCore

签名：`SetCore(parameterName: String, value: Any) -> void`

设置自定义 Core UI 参数，供后续 GetCore 读取。

⚙ 当前公开 Meta 未枚举稳定可用的 parameterName；不要在示例中编造 TopbarEnabled 等键名。部分通知/弹窗键在当前版本可能静默失败。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `parameterName` | `String` | 参数名称 |
| `value` | `Any` | 参数值 |

**返回值** `void`

> 示例代码

> 仅使用运行时已公开的参数名

```lua
-- @runtime client
print('SetCore 的可用 parameterName 尚未在公开 Meta 中枚举，请勿编造键名')
```

### GetCore

签名：`GetCore(parameterName: String) -> Any (参数值)`

获取通过 SetCore 设置的自定义 Core UI 参数值。

⚙ parameterName 必须与运行时已公开并支持的 SetCore 键一致；当前公开 Meta 未提供可安全演示的键名。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `parameterName` | `String` | 参数名称 |

**返回值** `Any` (参数值)

> 示例代码

> 避免读取未公开的参数名

```lua
-- @runtime client
print('GetCore 的可用 parameterName 尚未在公开 Meta 中枚举，请勿编造键名')
```
