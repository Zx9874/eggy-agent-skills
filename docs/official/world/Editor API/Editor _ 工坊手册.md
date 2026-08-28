# Editor

编辑器顶层对象，通过全局变量 editor 访问，提供服务获取、试玩控制、日志与插件管理。

## Overview

编辑器顶层对象，通过全局变量 `editor` 访问。负责服务管理（GetService）、试玩控制（RunGame / StopGame）、游戏代码执行与日志输出。

## Public API

### GetService

按名称获取编辑器服务实例，服务不存在时返回 nil

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `serviceName` | `String` | 服务名（如 "World"） |

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Any` | 对应的服务实例；服务不存在时返回 nil |

**示例**

```lua
local world = editor:GetService("World") -- 获取 World 服务
local task = editor:GetService("TaskService")
print("services ready:", world ~= nil, task ~= nil)

local units = world:GetDescendants()
print("scene units count:", #units)
```

### RunGame

开始编辑器试玩

**示例**

```lua
local task = editor:GetService("TaskService")
editor:RunGame() -- 开始试玩
print("[manual] 已请求开始试玩，请在编辑器观察")

task:Delay(2, function()
    editor:ExecuteGameCode("print('run from demo')")
    print("[manual] 已在游戏运行时执行代码，请观察试玩日志")

    task:Delay(2, function()
        editor:StopGame()
        print("[manual] 已请求停止试玩，请在编辑器确认")
    end)
end)
```

### StopGame

停止编辑器试玩

**示例**

```lua
local task = editor:GetService("TaskService")
editor:RunGame()
print("[manual] 已请求开始试玩，请在编辑器观察")

task:Delay(3, function()
    editor:StopGame() -- 停止试玩
    print("[manual] 已请求停止试玩，请在编辑器确认已退出试玩状态")
end)
```

### SaveMap

保存当前地图（同步 Lua 源码到地图包并持久化地图数据到磁盘）。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 保存接口不可用时返回 false |

**示例**

```lua
local world = editor:GetService("World")

local units = world:CreateUnit("WorldUnit", {})
print("map dirty before save:", editor:IsMapDirty())

local ok = editor:SaveMap() -- 保存地图
print("save map result:", ok, "dirty after save:", editor:IsMapDirty())

units[1]:Destroy()
editor:SaveMap()
```

### IsMapDirty

判断当前地图是否有未保存的修改；保存成功后自动变为 false。可用于修改场景前先检查是否需要保存的闭环。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Bool` | 有未保存修改返回 true |

**示例**

```lua
local world = editor:GetService("World")

print("map dirty initial:", editor:IsMapDirty()) -- 查询地图是否脏
local units = world:CreateUnit("WorldUnit", {})
print("map dirty after change:", editor:IsMapDirty())

editor:SaveMap()
print("map dirty after save:", editor:IsMapDirty())

units[1]:Destroy()
editor:SaveMap()
```

### ExecuteGameCode

在游戏运行时动态执行一段 Lua 代码

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `code` | `String` | 要执行的 Lua 代码 |

**示例**

```lua
local task = editor:GetService("TaskService")
editor:RunGame()

task:Delay(1, function()
    editor:ExecuteGameCode("print('execute from demo')") -- 运行时执行代码
    print("[manual] 已在游戏运行时执行代码，请观察试玩日志")
end)

task:Delay(3, function()
    editor:StopGame()
    print("[manual] 已请求停止试玩")
end)
```

### GetLog

获取编辑器日志内容

**返回值**

| 类型 | 说明 |
| --- | --- |
| `String` | 编辑器日志文本 |

**示例**

```lua
local markerA = "demo_marker_a"
local markerB = "demo_marker_b"

editor:Log(markerA)
editor:Log(markerB)

local log = editor:GetLog() or "" -- 获取编辑器日志
print("log length:", #log)
print("contains A:", string.find(log, markerA) ~= nil)
print("contains B:", string.find(log, markerB) ~= nil)
```

### Log

向编辑器日志输出内容

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `content` | `String` | 要输出的日志内容 |

**示例**

```lua
local marker = "demo_log_marker"
editor:Log(marker) -- 写入日志
print("已写入日志:", marker)

local log = editor:GetLog() or ""
print("log length:", #log)
print("contains marker:", string.find(log, marker) ~= nil)
```
