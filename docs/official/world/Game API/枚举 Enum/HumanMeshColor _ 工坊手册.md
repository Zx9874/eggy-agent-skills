# HumanMeshColor

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `String`
* **继承链**: `String` → HumanMeshColor

[HumanMeshColor](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/HumanMeshColor.html) 枚举标识人形模型或蒙皮的染色区域，公开成员 COLOR1 至 COLOR4 分别对应四个材质染色槽。

## 适用场景

调用 HumanUnit:SetMeshColor 或 SetModelColor 时，用该枚举选择要修改的染色区域。

## 使用要点

通过 Enums.HumanMeshColor.COLOR1 等成员传入 colorKey 参数，并使用 Color.New(...) 构造 color 参数。

## 注意事项

SetMeshColor/SetModelColor 的 color 参数类型是 [Color](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color.html)，不是 [Color3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Color3.html)；枚举成员必须通过 Enums.HumanMeshColor 前缀引用。

## 枚举值

| 名称 | 说明 |
| --- | --- |
| `COLOR1` | 区域1 |
| `COLOR2` | 区域2 |
| `COLOR3` | 区域3 |
| `COLOR4` | 区域4 |
