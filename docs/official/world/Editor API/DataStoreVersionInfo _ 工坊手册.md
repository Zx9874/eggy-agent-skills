# DataStoreVersionInfo

DataStore 版本信息对象，由 ListVersionsAsync 分页迭代产生。

## 概览

DataStore 版本信息对象，包含版本号、创建时间与删除状态。 不可实例化，仅由 DataStore:ListVersionsAsync 返回的分页器 DataStoreVersionInfoPages 迭代产生。

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `CreatedTime` | `Int` | `0` | 版本创建时间 (毫秒时间戳)（只读） |
| `Version` | `String` | `""` | 版本号（只读） |
| `IsDeleted` | `Bool` | `false` | 是否已删除（只读） |
