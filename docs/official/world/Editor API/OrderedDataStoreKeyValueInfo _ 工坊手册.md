# OrderedDataStoreKeyValueInfo

有序数据存储键值对信息对象，仅由 GetSortedAsync 分页迭代产生。

## 概览

有序数据存储键值对信息对象，包含键名、值、前置域与更新时间。 不可实例化，仅由 OrderedDataStore:GetSortedAsync 返回的分页器 OrderedDataStoreKeyValueInfoPages 迭代产生。

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Scope` | `String` | `""` | 前置域（只读） |
| `Key` | `String` | `""` | 键名（只读） |
| `Value` | `Int` | `0` | 值 (整数)（只读） |
| `UpdatedTime` | `Int` | `0` | 更新时间 (毫秒时间戳)（只读） |
