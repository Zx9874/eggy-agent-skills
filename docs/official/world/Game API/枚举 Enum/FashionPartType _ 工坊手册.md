# FashionPartType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → FashionPartType

蛋仔散件时装的部位类型枚举，用于区分头部、上半身与下半身三个换装部位。它配合蛋仔外观接口实现按部位设置或读取时装，也用于按部位重置外观。

## 适用场景

在自定义蛋仔外观或实现换装功能时，通过该枚举值指定要操作的部位，例如单独更换头部配饰或清除下半身时装。

## 使用要点

直接使用 Enums.FashionPartType.Head、Enums.FashionPartType.Body 或 Enums.FashionPartType.Leg 获取对应枚举值，将其作为参数传入蛋仔外观的 SetFashionPart、GetFashionPart 等部位换装接口。避免使用数字字面量，以保证代码可读性。

## 注意事项

该枚举为只读常量，实例无需自行创建；引用时必须携带 Enums. 前缀。传入该枚举值的方法需在公开契约中确认对应的部位枚举含义，避免混淆头部与身体。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `1` | `Head` | Head |
| `2` | `Body` | Body |
| `3` | `Leg` | Leg |
