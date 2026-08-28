# EffectService

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[EffectService]**（1 函数）

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

特效服务是全局客户端服务，负责在本地播放特效，核心能力是通过 PlayLocalEffect 在指定位置、朝向和缩放下生成特效，并支持设置持续时间、循环播放与异步加载方式。它的特效资源由官方特效路径或用户自定义资源标识符引用，播放结果仅作用于当前客户端。

## 适用场景

适用于需要在客户端本地呈现即时特效反馈的场景，例如技能命中反馈、交互提示等需要低延迟呈现的玩法表现。

## 使用要点

先通过 game:GetService("EffectService") 获取服务实例，并检查是否成功，因为部分运行环境下服务可能尚未导出；随后构造目标位置的 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)、朝向的 [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) 与缩放的 [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)，再调用 PlayLocalEffect 并传入以 official://effect/ 或 custom:// 开头的特效标识，即可在本地播放。

## 注意事项

最新 Meta 已公开 [EffectService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/EffectService.html)，但 2026-08-12 当前编辑器运行包中 game:GetService("EffectService") 仍返回 nil；这是运行时服务导出尚未对齐 Meta。示例会先检查服务是否可用，服务未导出时安全退出。服务可用后，PlayLocalEffect 的 effectId 只接受 official://effect/{path} 或 custom://{asset\_id}，不接受裸数字、裸路径、official://preset/... 或其他 scheme。返回的 EffectHandle 当前只作为引用，公开契约没有 Stop、Destroy 或属性控制方法；不要编造句柄控制 API。

## 代码示例

### 播放本地特效

```lua
-- @runtime client
local effectService = game:GetService('EffectService')
if effectService == nil then
    print('EffectService 当前运行包尚未导出')
    return
end
local effectId = 'official://effect/2039'
local position = Vector3.New(0, 3, 0)
local rotation = Quaternion.Identity()
local scale = Vector3.New(1, 1, 1)
local handle = effectService:PlayLocalEffect(effectId, position, rotation, scale, 2.0, false, false)
print('特效句柄:', handle)
```

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)

## 函数 (1)

### PlayLocalEffect

签名：`PlayLocalEffect(effectId: String, position: Vector3, rotation: Quaternion, scale: Vector3, keepTime?: Float, loop?: Bool, isAsync?: Bool) -> Any (EffectHandle（特效句柄引用）)`

播放本地特效，在客户端本地播放一个特效，仅对当前玩家可见。调用时需要提供特效 ID、位置、旋转和缩放参数。

⚙ 该接口仅在客户端生效；调用前需确认当前运行包已导出 [EffectService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/EffectService.html)。effectId 必须使用 official://effect/{path} 或 custom://{asset\_id}。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `effectId` | `String` | 特效资源 URI（仅 official://effect/{path} 或 custom://{asset\_id}） |
| `position` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 世界坐标位置（默认 0,0,0） |
| `rotation` | [Quaternion](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Quaternion.html) | 旋转（默认单位四元数） |
| `scale` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | 缩放（默认 1,1,1） |
| `keepTime?` | `Float` | 自动销毁延时秒（默认 -1 不自动销毁） |
| `loop?` | `Bool` | 是否循环（默认 false） |
| `isAsync?` | `Bool` | 是否异步加载（默认 false 同步，true 时不阻塞主线程） |

**返回值** `Any` (EffectHandle（特效句柄引用）)

> 示例代码

> 播放本地特效

```lua
-- @runtime client
local effectService = game:GetService('EffectService')
if effectService == nil then
    print('EffectService 当前运行包尚未导出')
    return
end
local handle = effectService:PlayLocalEffect(
    'official://effect/2039',
    Vector3.New(0, 3, 0),
    Quaternion.Identity(),
    Vector3.New(1, 1, 1),
    2.0,
    false,
    false
)
print('特效句柄:', handle)
```
