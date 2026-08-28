# PathStatus

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → PathStatus

路径计算状态枚举，用于表示寻路请求的最终结果。包含成功和无路径两种状态，帮助开发者判断路径是否有效。

## 适用场景

在调用 Path:ComputeAsync 后检查返回的状态值，决定后续移动逻辑。

## 使用要点

通过 Enums.PathStatus.Success 或 Enums.PathStatus.NoPath 引用枚举值。通常与 [Path](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Path.html) 实例的 Status 属性比较，例如 if path.Status == Enums.PathStatus.Success then ... end。

## 注意事项

Path.Status 的 Meta 初始值是 Enums.PathStatus.NoPath；ComputeAsync 成功后更新为 Enums.PathStatus.Success，失败或无可达路径时保持 Enums.PathStatus.NoPath。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Success` | 路径计算成功 |
| `5` | `NoPath` | 无法找到路径 |
