# DataStoreInfo

DataStore 集合信息对象，由 ListDataStoresAsync / ListOrderedDataStoresAsync 分页迭代产生。

## 概览

DataStore 集合信息对象，包含集合名称、类型、创建/更新时间、键数量与数据大小等信息。 不可实例化，仅由 DataStoreService:ListDataStoresAsync 返回的分页器 DataStoreInfoPages 迭代产生。

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `DataStoreName` | `String` | `""` | 集合名称（只读） |
| `DataStoreType` | `Int` | `1` | 集合类型 (1=普通, 2=有序)（只读） |
| `CreatedTime` | `Int` | `0` | 创建时间 (毫秒时间戳)（只读） |
| `UpdatedTime` | `Int` | `0` | 更新时间 (毫秒时间戳)（只读） |
| `KeyCount` | `Int` | `0` | 键数量（只读） |
| `Size` | `Int` | `0` | 数据大小 (字节)（只读） |
| `IsDeleted` | `Bool` | `false` | 是否已删除（只读） |
