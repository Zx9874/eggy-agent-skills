# CustomAppearanceService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[CustomAppearanceService]**（1 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[CustomAppearanceService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/CustomAppearanceService.html) 是运行时自定义外观管理服务，用外观数据创建运行时自定义外观，并返回可写入单位 CustomAppearanceId 的 ID 字符串。

## 适用场景

需要在脚本中组合模型、皮肤、染色或材质并动态应用到单位时，通过该服务创建运行时外观；希望所有玩家看到同一结果时在服务端创建，只需本地预览时可在客户端创建。

## 使用要点

通过 game:GetService("CustomAppearanceService") 获取服务，调用 CreateCustomAppearance(data) 取得 ID 字符串；应用到单位时先设置 UseCustomAppearance=true，再把该 ID 写入 CustomAppearanceId。

## 注意事项

服务端创建的外观会同步到所有客户端，客户端创建的外观仅本端可见。运行时外观 ID 形如 runtime://appearance/<int>；注册结果只增不改不删，需调整内容时应传入新数据重新创建并替换旧 ID。

## 代码示例

### 创建并应用运行时自定义外观

```lua
-- @runtime client
local world = game:GetService("World")
local appearances = game:GetService("CustomAppearanceService")
-- 客户端创建的运行时外观仅本端可见；需全端同步时请在服务端执行同一流程

local appearanceId = appearances:CreateCustomAppearance({
    Name = "TrainingAppearance",
    RenderMeshId = "official://mesh/59268",
    ModelColor1 = Color.New(255, 200, 120, 255),
})
local eggy = world:CreateUnit("EggyUnit", { Position = Vector3.New(0, 0, 0) })
if appearanceId ~= nil and appearanceId ~= "" and eggy ~= nil then
    eggy.UseCustomAppearance = true
    eggy.CustomAppearanceId = appearanceId
end
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (1)

### CreateCustomAppearance

签名：`CreateCustomAppearance(data: CustomAppearance) -> String (自定义外观对象ID)`

根据传入的 [CustomAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CustomAppearance.html) 字段数据创建运行时外观，并直接返回系统生成的外观 ID 字符串。

⚙ 服务端创建会同步到所有客户端，客户端创建仅本端可见；已创建外观不可原地修改或删除，变更时重新创建。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `data` | [CustomAppearance](https://u5-creator.s3.game.163.com/manual/se/game_api/data/CustomAppearance.html) | 外观数据 |

**返回值** `String` (自定义外观对象ID)

> 示例代码

> 创建并应用运行时自定义外观

```lua
-- @runtime client
local world = game:GetService("World")
local appearances = game:GetService("CustomAppearanceService")
-- 客户端创建的运行时外观仅本端可见；需全端同步时请在服务端执行同一流程
local appearanceId = appearances:CreateCustomAppearance({
    Name = "TrainingAppearance",
    RenderMeshId = "official://mesh/59268",
})
local eggy = world:CreateUnit("EggyUnit", { Position = Vector3.New(0, 0, 0) })
if appearanceId ~= nil and appearanceId ~= "" and eggy ~= nil then
    eggy.UseCustomAppearance = true
    eggy.CustomAppearanceId = appearanceId
end
```
