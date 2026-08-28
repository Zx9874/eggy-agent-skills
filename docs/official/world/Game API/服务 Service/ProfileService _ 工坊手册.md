# ProfileService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[ProfileService]**（3 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[ProfileService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/ProfileService.html) 提供 Print、Warn 与 Error 三种级别的运行时日志输出，用于记录诊断信息。

## 适用场景

脚本需要按普通、警告或错误级别输出运行状态，便于在控制台定位问题时使用。

## 使用要点

通过 game:GetService("ProfileService") 获取服务，并把待记录的值传给 Print、Warn 或 Error。

## 注意事项

当前公开契约只保证三个日志方法及其 Any 类型参数；未声明性能采样、日志持久化、字符串转换规则或仅限开发环境等额外行为。不要把控制台输出作为业务状态或错误恢复机制。

## 代码示例

### 基础日志输出

```lua
-- @runtime client
-- 获取 ProfileService 服务实例
local profileService = game:GetService("ProfileService")

-- 使用 Print 输出普通信息
profileService:Print("玩家进入游戏区域")

-- 使用 Warn 输出警告信息
profileService:Warn("网络延迟较高，请检查连接")

-- 使用 Error 输出错误信息
profileService:Error("无法加载资源 official://preset/10001")

print("日志输出完成")
```

### 带变量拼接的日志输出

```lua
-- @runtime client
-- 获取 ProfileService 服务实例
local profileService = game:GetService("ProfileService")

-- 模拟一些运行时数据
local playerCount = 12
local maxPlayers = 20

-- 使用 Print 输出拼接后的信息
profileService:Print("当前在线人数: " .. tostring(playerCount) .. "/" .. tostring(maxPlayers))

-- 当人数接近上限时发出警告
if playerCount >= maxPlayers * 0.8 then
    profileService:Warn("服务器即将满员，当前人数: " .. tostring(playerCount))
end

-- 模拟一个错误场景
local success, err = pcall(function()
    error("模拟内部错误")
end)
if not success then
    profileService:Error("操作失败: " .. tostring(err))
end

print("条件日志输出完成")
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (3)

### Print

签名：`Print(msg: Any) -> void`

输出一条普通级别的日志消息。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `msg` | `Any` | 消息内容 |

**返回值** `void`

> 示例代码

> 输出普通日志

```lua
-- @runtime client
-- 获取 ProfileService 服务实例
local profileService = game:GetService("ProfileService")
-- 调用 Print 方法输出普通信息
profileService:Print("玩家进入游戏，ID: 12345")
-- 验证服务实例可用
print("ProfileService 实例获取成功:", profileService)
```

### Warn

签名：`Warn(msg: Any) -> void`

输出一条警告级别的日志消息。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `msg` | `Any` | 消息内容 |

**返回值** `void`

> 示例代码

> 输出警告日志

```lua
-- @runtime client
-- 获取 ProfileService 服务实例
local profileService = game:GetService("ProfileService")
-- 调用 Warn 方法输出警告信息
profileService:Warn("内存使用率超过 80%，请注意性能")
-- 验证服务实例可用
print("ProfileService 实例获取成功:", profileService)
```

### Error

签名：`Error(msg: Any) -> void`

输出一条错误级别的日志消息。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `msg` | `Any` | 消息内容 |

**返回值** `void`

> 示例代码

> 输出错误日志

```lua
-- @runtime client
-- 获取 ProfileService 服务实例
local profileService = game:GetService("ProfileService")
-- 调用 Error 方法输出错误信息
profileService:Error("发生了一个严重错误：网络连接超时")
-- 验证服务实例可用
print("ProfileService 实例获取成功:", profileService)
```
