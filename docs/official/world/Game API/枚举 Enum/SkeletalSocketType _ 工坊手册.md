# SkeletalSocketType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `String`
* **继承链**: `String` → SkeletalSocketType

[SkeletalSocketType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/SkeletalSocketType.html) 枚举定义蛋仔外观挂接可用的标准骨骼挂点，如 Head、Spine、LHand、RHand 等。

## 适用场景

在给蛋仔角色挂接外观件时，将该枚举传给 EggyAppearance:BindAppearance 的 socket 参数，指定外观件绑定到头部、身体或手脚等位置。

## 使用要点

通过 EggyUnit.EggyAppearance 获取外观组件，然后调用 EggyAppearance:BindAppearance(appearanceId, Enums.SkeletalSocketType.Head, offset, rot, scale)。

## 注意事项

枚举值必须通过 Enums.SkeletalSocketType 命名空间访问。场景 UI 或特效绑定接口若签名要求字符串挂点名，应按对应接口文档传入字符串。

## 枚举值

| 名称 | 说明 |
| --- | --- |
| `Head` | 头部 |
| `Spine` | 身体 |
| `Origin` | 底面中心 |
| `LWeapon` | 左手武器 |
| `RWeapon` | 右手武器 |
| `LFoot` | 左脚 |
| `RFoot` | 右脚 |
| `LHand` | 左手 |
| `RHand` | 右手 |
| `LForearm` | 左臂 |
| `RForearm` | 右臂 |
