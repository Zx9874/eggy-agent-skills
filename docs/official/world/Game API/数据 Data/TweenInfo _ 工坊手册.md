# TweenInfo

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html) 是补间动画的配置对象，用于定义动画的持续时间、缓动风格、重复次数等参数。它通过 [TweenService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/TweenService.html) 创建补间时传入，控制动画的播放行为。

## 适用场景

在需要平滑过渡界面元素或三维物体的位置、大小、透明度等属性时，使用 [TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html) 配置动画效果，例如制作按钮点击缩放或角色移动动画。

## 使用要点

通过 TweenInfo.New(duration, easingStyle, easingDirection, repeatCount, reverses, delayTime) 或等价的 [TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html)(...) 简写构造，再传给 TweenService:Create。easingStyle 与 easingDirection 必须使用命名枚举成员。

## 注意事项

[TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html) 是动画配置对象，支持 TweenInfo.New(...) 与 [TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html)(...) 两种等价构造。示例代码必须自包含：所有变量必须声明后使用，禁止引用未声明的 tween/animation 等变量。

## 代码示例

### 构造 TweenInfo 并读取属性

```lua
-- @runtime client
-- 使用 TweenInfo.New 构造动画配置对象，并读取各属性值
local duration = 2.0  -- 动画时长（秒）
local easingStyle = Enums.EasingStyle.Bounce  -- 缓动风格
local easingDirection = Enums.EasingDirection.InOut  -- 缓动方向
local repeatCount = 3  -- 重复次数
local reverses = true  -- 是否反向播放
local delayTime = 0.5  -- 延迟时间（秒）

local info = TweenInfo.New(duration, easingStyle, easingDirection, repeatCount, reverses, delayTime)

-- 读取并打印各属性值
print("Duration:", info.Duration)
print("EasingStyle:", info.EasingStyle)
print("EasingDirection:", info.EasingDirection)
print("RepeatCount:", info.RepeatCount)
print("Reverses:", info.Reverses)
print("DelayTime:", info.DelayTime)
```

## 属性 (6)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Duration` | `Float` | `1.0` | 补间动画的持续时间，单位为秒。 |
| `EasingStyle` | [EasingStyle](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingStyle.html) | `Enums.EasingStyle.Linear` | 补间动画的缓动风格，决定动画的速度曲线。 |
| `EasingDirection` | [EasingDirection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingDirection.html) | `Enums.EasingDirection.Out` | 补间动画的缓动方向，决定缓动函数的作用阶段。 |
| `RepeatCount` | `Int` | `0` | 补间动画的重复次数。0 表示播放一次，-1 表示无限循环。 |
| `Reverses` | `Bool` | `false` | 是否在每次重复时反向播放补间动画。 |
| `DelayTime` | `Float` | `0` | 补间动画开始前的延迟时间，单位为秒。 |

## 关联类型

* [EasingDirection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingDirection.html)
* [EasingStyle](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingStyle.html)

## 函数 (1)

### New

签名：`New(duration: Float, easingStyle?: EasingStyle, easingDirection?: EasingDirection, repeatCount?: Int, reverses?: Bool, delayTime?: Float) -> TweenInfo (TweenInfo 对象)`

创建一个新的 [TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html) 对象，用于定义补间动画的播放参数。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `duration` | `Float` | 持续时间 |
| `easingStyle?` | [EasingStyle](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingStyle.html) | 缓动风格，使用 Enums.EasingStyle 的命名成员。 |
| `easingDirection?` | [EasingDirection](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EasingDirection.html) | 缓动方向，使用 Enums.EasingDirection 的命名成员。 |
| `repeatCount?` | `Int` | 重复次数, 默认 0 (0=一次, -1=无限) |
| `reverses?` | `Bool` | 反向播放, 默认 false |
| `delayTime?` | `Float` | 延迟时间, 默认 0 |

**返回值** [TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html) ([TweenInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/TweenInfo.html) 对象)

> 示例代码

> 构造 TweenInfo

```lua
-- @runtime client
local info = TweenInfo.New(
    0.5,                         -- 持续时间(秒)
    Enums.EasingStyle.Quad,      -- 缓动风格
    Enums.EasingDirection.InOut  -- 缓动方向
)
print(string.format('时长=%.2f 风格=%s 方向=%s',
    info.Duration, tostring(info.EasingStyle), tostring(info.EasingDirection)))
```
