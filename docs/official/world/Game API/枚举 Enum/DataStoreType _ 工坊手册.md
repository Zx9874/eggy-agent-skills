# DataStoreType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → DataStoreType

[DataStoreType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DataStoreType.html) 枚举用于标识数据存储集合类型，包括普通数据存储、有序数据存储和全局数据存储。

## 适用场景

在读取 DataStoreService:ListDataStoresAsync 或 ListOrderedDataStoresAsync 返回的 [DataStoreInfo](https://u5-creator.s3.game.163.com/manual/se/game_api/data/DataStoreInfo.html) 时，可通过 DataStoreInfo.DataStoreType 判断当前条目的存储类别。

## 使用要点

通过 Enums.DataStoreType.Normal、Enums.DataStoreType.Ordered、Enums.DataStoreType.Global 引用枚举成员，用于与 DataStoreInfo.DataStoreType 等已有字段比较。

## 注意事项

ListDataStoresAsync/ListOrderedDataStoresAsync 的公开签名不接收 [DataStoreType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DataStoreType.html) 参数；不要把该枚举当作列表接口的过滤参数传入。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `1` | `Normal` | 普通数据存储 |
| `2` | `Ordered` | 有序数据存储 |
| `3` | `Global` | 全局数据存储 |
