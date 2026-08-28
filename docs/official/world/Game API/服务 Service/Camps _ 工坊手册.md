# Camps

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[Camps]**（1 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[Camps](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Camps.html) 是阵营管理服务，负责提供当前地图中全部阵营的查询入口。通过它的 GetCamps 方法可以获取一个包含所有阵营的数组，再结合 [Camp](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Camp.html) 类型的 GetPlayers 方法即可读取每个阵营内的玩家成员，常用于阵营归属判断、队伍配置展示等服务器逻辑。

## 适用场景

典型场景是在服务端初始化阶段获取地图全部阵营列表，遍历每个阵营并读取其玩家成员，用于搭建以阵营为维度的对战规则或统计系统。

## 使用要点

先通过 game:GetService("Camps") 获取服务实例，再调用 GetCamps 得到阵营数组并使用 ipairs 遍历；对遍历得到的每个 [Camp](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Camp.html) 对象调用 GetPlayers，并使用 generic for 形式遍历其玩家集合。

## 注意事项

[Camps](https://u5-creator.s3.game.163.com/manual/se/game_api/service/Camps.html) 是阵营管理服务，当前公开方法只有 GetCamps。GetCamps() 返回 [Camp](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Camp.html) 数组，建议使用 ipairs 遍历，也可读取长度或按下标访问。Camp:GetPlayers() 返回迭代函数，应使用 generic for 遍历，不能对它使用 # 或 ipairs。

## 代码示例

### 遍历阵营并读取玩家列表

```lua
-- @runtime client
local camps = game:GetService("Camps")

for _, camp in ipairs(camps:GetCamps()) do
    local playerCount = 0
    for _ in camp:GetPlayers() do playerCount = playerCount + 1 end
    print("阵营玩家数:", playerCount)
end
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (1)

### GetCamps

签名：`GetCamps() -> Camp[] (当前地图中的阵营数组，可用 ipairs 遍历、# 取长度或按下标访问)`

获取当前地图中的所有阵营，返回 [Camp](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Camp.html) 数组。

**返回值** [Camp](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Camp.html)[] (当前地图中的阵营数组，可用 ipairs 遍历、# 取长度或按下标访问)

> 示例代码

> 遍历阵营数组

```lua
-- @runtime client
local camps = game:GetService("Camps")

for _, camp in ipairs(camps:GetCamps()) do
    local playerCount = 0
    for _ in camp:GetPlayers() do playerCount = playerCount + 1 end
    print("阵营玩家数:", playerCount)
end
```
