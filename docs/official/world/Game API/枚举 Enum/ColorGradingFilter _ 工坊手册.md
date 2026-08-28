# ColorGradingFilter

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → ColorGradingFilter

色彩分级滤镜枚举定义了可应用于 [ColorGradingEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ColorGradingEffect.html) 的预设色彩风格，如复古、黑白、冷暖色调等。通过设置 Filter 属性为枚举成员，可快速切换画面的整体色彩氛围，配合 FilterStrength 调整强度。

## 适用场景

在需要改变场景视觉风格时，将 [ColorGradingEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ColorGradingEffect.html) 的 Filter 属性设为枚举值，例如切换为 Sepia 实现怀旧效果，或使用 NightVision 模拟夜视仪。

## 使用要点

创建 [ColorGradingEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ColorGradingEffect.html)，将 Parent 设置为 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html)，再把 Filter 赋值为 Enums.ColorGradingFilter 的命名成员。

## 注意事项

Filter 只接受 Enums.ColorGradingFilter 命名成员；效果实例需挂载到 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 并启用。服务名必须保留 Service 后缀。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `None` | 无滤镜效果 |
| `1` | `SilentBlack` | 寂静黑 |
| `2` | `PureGray` | 纯净灰 |
| `3` | `RetroYellow` | 复古黄 |
| `4` | `ComicBlackAndWhite` | 黑白漫画 |
| `5` | `Woodcut` | 黑白版画 |
| `6` | `Posterize` | 大色块 |
| `7` | `MyriadBlooms` | 百花争艳 |
| `8` | `Vintage` | 古色古香 |
| `9` | `WarmSunshine` | 融融暖阳 |
| `10` | `Sepia` | 泛黄回忆 |
| `11` | `AutumnForest` | 层林尽染 |
| `12` | `LotusBlush` | 芙蓉如面 |
| `13` | `PowderRouge` | 粉黛胭脂 |
| `14` | `CoolSummer` | 清凉夏日 |
| `15` | `FrigidNorthland` | 凌冽北国 |
| `16` | `NightVision` | 夜视仪 |
| `17` | `MonoNegative` | 黑白底片 |
| `18` | `GreenNegative` | 绿色底片 |
| `19` | `RedNegative` | 红色底片 |
| `20` | `MonoRed` | 单色-红 |
| `21` | `MonoGreen` | 单色-绿 |
| `22` | `MonoBlue` | 单色-蓝 |
| `23` | `MonoYellow` | 单色-黄 |
