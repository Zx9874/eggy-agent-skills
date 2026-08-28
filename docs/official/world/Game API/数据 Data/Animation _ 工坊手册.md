# Animation

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[Animation](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Animation.html) 用于封装动画资源的标识信息，将动画名称与资源 URI 绑定在一起。它作为动画数据的轻量载体，供 [Animator](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Animator.html) 加载动画时使用。

## 适用场景

在需要播放角色或物件动画时，先用 Animation.New 创建动画对象，再通过 Animator:LoadAnimation 加载并获取 [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html) 进行播放控制。

## 使用要点

通过 Animation.New("奔跑", "official://animation/100001") 构造实例，传入动画名称和资源 URI。然后将该实例传递给 Animator:LoadAnimation 方法，即可获得可播放的 [AnimationTrack](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/AnimationTrack.html)。

## 注意事项

AnimationId 使用 official://animation/{id} 格式（如 official://animation/100001）。可通过 Animation.New(name, animationId) 或 [Animation](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Animation.html)(name, animationId) 构造实例，示例统一使用 Animation.New(...)。

## 代码示例

### 创建动画引用

```lua
-- @runtime client
local animation = Animation.New('示例动画', 'official://animation/100001')
print('动画名称:', animation.Name)
print('动画 ID:', animation.AnimationId)
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Name` | `String` | `-` | 动画的显示名称，通常为解析后的简短名称。 |
| `AnimationId` | `String` | `-` | 动画资源的唯一标识符，采用 资源 URI 格式。 |

## 函数 (1)

### New

签名：`New(Name: String, AnimationId: String) -> Animation`

创建一个新的 [Animation](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Animation.html) 实例，用于定义动画资源及其名称。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `Name` | `String` | 动画显示名称 |
| `AnimationId` | `String` | 动画资源标识，资源 URI 格式 |

**返回值** [Animation](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Animation.html)

> 示例代码

> 创建动画引用

```lua
-- @runtime client
local animation = Animation.New('示例动画', 'official://animation/100001')
print('动画名称:', animation.Name)
print('动画 ID:', animation.AnimationId)
```
