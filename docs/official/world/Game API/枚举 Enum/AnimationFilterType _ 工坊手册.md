# AnimationFilterType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `String`
* **继承链**: `String` → AnimationFilterType

[AnimationFilterType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/AnimationFilterType.html) 枚举用于限定动画影响的身体部位，可分别选择头部、躯干、左臂、右臂、左腿或右腿。

## 适用场景

播放只影响特定身体部位的动画时，将 AnimationTrack.FilterType 设置为对应的命名枚举成员。需要覆盖多个部位时，应按运行时支持的组合方式处理，不能把 Trunk 单独等同于整个上半身。

## 使用要点

通过 Enums.AnimationFilterType.Head、Trunk、LeftArm、RightArm、LeftLeg 或 RightLeg 引用成员，并赋值给 AnimationTrack.FilterType。

## 注意事项

每个成员只表示其名称对应的单个身体部位；选择左右肢体时需明确方向，不要凭成员名称外推未公开的 FullBody、UpperBody 或 LowerBody 成员。

## 枚举值

| 名称 | 说明 |
| --- | --- |
| `Head` | 头 |
| `Trunk` | 躯干 |
| `LeftArm` | 左手臂 |
| `RightArm` | 右手臂 |
| `LeftLeg` | 左腿 |
| `RightLeg` | 右腿 |
