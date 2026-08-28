# MemoryStoreErrorCode

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `server` |

* **Inherit**: `Int`
* **继承链**: `Int` → MemoryStoreErrorCode

[MemoryStoreErrorCode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/MemoryStoreErrorCode.html) 枚举定义 MemoryStore 数据结构操作可能涉及的错误状态，例如未发布作品不可用、客户端非法访问、请求限流、容量超限、键不存在或更新条件不满足等。

## 适用场景

当 [MemoryStoreHashMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreHashMap.html)、[MemoryStoreSortedMap](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreSortedMap.html)、[MemoryStoreQueue](https://u5-creator.s3.game.163.com/manual/se/game_api/data/MemoryStoreQueue.html) 或业务封装明确提供错误码时，可用该枚举区分成功、参数错误、服务未就绪、限流、容量限制和条件失败等情况。

## 使用要点

通过 Enums.MemoryStoreErrorCode.Success、Enums.MemoryStoreErrorCode.RequestThrottled、Enums.MemoryStoreErrorCode.KeyNotExists 等形式引用成员，并与实际获得的 MemoryStore 错误码比较。

## 注意事项

[MemoryStoreService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/MemoryStoreService.html) 本身只负责 GetSortedMap、GetQueue、GetHashMap；SetAsync、GetAsync、ReadAsync、UpdateAsync 等读写方法属于返回的集合对象。普通公开签名不一定直接返回该枚举，只有接口或封装明确提供错误码时才比较 [MemoryStoreErrorCode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/MemoryStoreErrorCode.html)。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `Success` | 成功 |
| `101` | `LocalInternalError` | 本地内部错误 |
| `102` | `UnpublishedPlace` | 未发布的作品不能使用 MemoryStoreService |
| `103` | `InvalidClientAccess` | MemoryStoreService 必须从服务器调用 |
| `104` | `InvalidExpirationTime` | 过期时间必须在当前时间之后 |
| `105` | `LocalInvalidRequest` | 请求参数错误，无法序列化 |
| `106` | `InvalidSortKey` | 排序键必须是数字或字符串 |
| `107` | `TransformCallbackFailed` | 调用转换回调函数失败 |
| `108` | `RequestThrottled` | 请求被限流 |
| `109` | `UpdateRetryTimesLimit` | 更新冲突后，超过最大重试次数 |
| `999` | `LocalErrorEnd` | 本地错误码结束 |
| `1001` | `AccessDenied` | 未授权访问数据 |
| `1003` | `InternalError` | 远端服务内部错误 |
| `1004` | `InvalidRequest` | 请求参数错误 |
| `1005` | `ServiceNotReady` | 服务未就绪 |
| `1101` | `StoreMemoryOverLimit` | 超过数据结构级别内存大小限制 (100MB) |
| `1102` | `StoreItemsOverLimit` | 超过数据结构元素个数限制 (1M) |
| `1103` | `KeyValueSizeTooLarge` | 单个键值大小超过限制 (1MB) |
| `1104` | `KeySizeTooLarge` | 单个键大小超过限制 (128B) |
| `1105` | `SortKeySizeTooLarge` | 单个排序键大小超过限制 (128B) |
| `1200` | `StoreRequestsOverLimit` | 超过单个数据结构级别请求次数限制 |
| `1201` | `TotalRequestsOverLimit` | 超过总请求次数限制 |
| `1202` | `PartitionRequestsOverLimit` | 超过分区请求次数限制 |
| `1203` | `TotalMemoryOverLimit` | 超过总内存限制 |
| `1301` | `DataUpdateConflict` | 数据更新冲突 |
| `1302` | `NoItemFound` | 未找到指定元素 (Queue:ReadAsync 空队列) |
| `1303` | `KeyExists` | 键已存在 (NX 条件失败) |
| `1304` | `KeyNotExists` | 键不存在 (XX 条件失败) |
| `1305` | `MemoryStoreExists` | 数据结构已存在 (MSNX 条件失败) |
| `1306` | `MemoryStoreNotExists` | 数据结构不存在 (MSXX 条件失败) |
| `1307` | `VauleIsNotNumber` | 键值不是数字 (INCR 条件失败)；原文保留拼写 Vaule |
| `1308` | `RequestValueIsNotNumber` | 请求更新键值不是数字 (INCR 条件失败) |
| `1309` | `DataUpdateConditionDissatisfy` | 数据更新条件不满足 (GT/LT/LTE/GTE/LTT/LTET/GTT/GTET/EQT/NEQT) |
| `1310` | `DataUpdateVersionDissatisfy` | 数据更新版本不满足 (UpdateAsync CAS 版本冲突；DependPrevVersion 与当前版本不一致) |
