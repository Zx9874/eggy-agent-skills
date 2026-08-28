# DataStoreKeyBriefInfo

DataStore 键简要信息对象，由 ListKeysAsync 分页迭代产生。

## 概览

DataStore 键简要信息对象，包含键名、前置域与删除状态。 不可实例化，仅由 DataStore:ListKeysAsync 返回的分页器 DataStoreKeyBriefInfoPages 迭代产生。

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Scope` | `String` | `""` | 前置域（只读） |
| `Key` | `String` | `""` | 键名（只读） |
| `IsDeleted` | `Bool` | `false` | 是否已删除（只读） |
