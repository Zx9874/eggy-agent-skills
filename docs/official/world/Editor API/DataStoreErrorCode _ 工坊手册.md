# DataStoreErrorCode

数据存储错误码枚举，用于错误信息中的 ErrorCode 字段。

## 概览

数据存储操作返回的错误码，用于错误信息中的 ErrorCode 字段判断失败原因。

> 继承自 `Int`；枚举类型

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
|  | `Success` | 成功 |
| `101` | `NamespaceEmpty` | 命名空间为空 |
| `102` | `NamespaceTooLong` | 命名空间超过50个字符 |
| `103` | `NamespaceCharsInvalid` | 命名空间只能包含字母、数字和下划线 |
| `104` | `DataStoreNameEmpty` | 数据存储集合名称为空 |
| `105` | `DataStoreNameTooLong` | 数据存储集合名称超过50个字符 |
| `106` | `DataStoreNameCharsInvalid` | 数据存储集合名称只能包含字母、数字和下划线 |
| `107` | `ScopeEmpty` | 范围名称为空 |
| `108` | `ScopeTooLong` | 范围名称超过50个字符 |
| `109` | `ScopeCharsInvalid` | 范围名称只能包含字母、数字和下划线 |
| `110` | `KeyEmpty` | 键名不能为空 |
| `111` | `KeyTooLong` | 键名超过50个字符 |
| `112` | `KeyCharsInvalid` | 键名只能包含字母、数字和下划线 |
| `113` | `KeyFormatInvalidWithScope` | AllScope模式下键名必须是scope/key格式 |
| `121` | `ValueNotAllowed` | 不合法的值数据, 无法完成json序列化 |
| `122` | `CantStoreValue` | 无法存储该值 |
| `123` | `ValueTooLarge` | 值数据序列化后超过限制 |
| `131` | `MaxValueInvalid` | MaxValue 必须是整数 |
| `132` | `MinValueInvalid` | MinValue 必须是整数 |
| `133` | `PageSizeGreater` | PageSize 超过上限, 必须在1-100内 |
| `134` | `PageSizeLesser` | PageSize 低于下限, 必须在1-100内 |
| `135` | `MinMaxOrderInvalid` | MinValue 必须小于 MaxValue |
| `141` | `MetaKeyEmpty` | 元数据键名不能为空 |
| `142` | `MetaKeyInvalid` | 元数据键名只能是字符串 |
| `143` | `MetaKeyLengthInvalid` | 元数据键名长度必须在1-50之间 |
| `144` | `MetaValueInvalid` | 元数据键值长度必须在0-250之间 |
| `145` | `MetaFormatInvalid` | 元数据格式错误, 必须是字典类型 |
| `146` | `MetaDataTooLarge` | 元数据总数据量超过限制 |
| `151` | `UserIdsSizeLimit` | 用户ID字节长度超限 |
| `152` | `UserIdsCountLimit` | 用户ID数量超限 |
| `153` | `UserIdsInvalid` | 用户ID格式错误, 必须是字符串 |
| `161` | `PrefixTooLong` | 前缀长度超过100个字符 |
| `162` | `PrefixInvalid` | 前缀格式错误, 必须是字符串 |
| `163` | `CursorTooLong` | 游标长度超过100个字符 |
| `164` | `CursorInvalid` | 游标格式错误, 必须是字符串 |
| `165` | `MinValueInvalid2` | minValue 如果指定必须是整数或浮点数 |
| `166` | `MaxValueInvalid2` | maxValue 如果指定必须是整数或浮点数 |
| `167` | `MinValueGreater` | minValue 必须小于 maxValue |
| `171` | `IncrementAmountInvalid` | 增量值必须是整数或浮点数 |
| `301` | `ReadThrottle` | 读取请求被丢弃, 单局游玩内吞吐量队列已满 |
| `302` | `WriteThrottle` | 写入请求被丢弃, 单局游玩内吞吐量队列已满 |
| `303` | `ListThrottle` | 列出请求被丢弃, 单局游玩内吞吐量队列已满 |
| `304` | `RemoveThrottle` | 删除请求被丢弃, 单局游玩内吞吐量队列已满 |
| `305` | `KeyReadThrottle` | 读取请求被丢弃, 存储服务侧单键名读取流量超限 |
| `306` | `KeyWriteThrottle` | 写入请求被丢弃, 存储服务侧单键名写入流量超限 |
| `311` | `NormalReadSpaceThrottle` | 读取请求被丢弃, 普通存储服务单服务器读速率超限制 |
| `312` | `NormalWriteSpaceThrottle` | 写入请求被丢弃, 普通存储服务单服务器写速率超限制 |
| `313` | `NormalListSpaceThrottle` | 列出请求被丢弃, 普通存储服务单服务器读速率超限制 |
| `314` | `NormalRemoveSpaceThrottle` | 删除请求被丢弃, 普通存储服务单服务器写速率超限制 |
| `321` | `OrderedReadSpaceThrottle` | 读取请求被丢弃, 有序存储服务单服务器读速率超限制 |
| `322` | `OrderedWriteSpaceThrottle` | 写入请求被丢弃, 有序存储服务单服务器写速率超限制 |
| `323` | `OrderedListSpaceThrottle` | 列出请求被丢弃, 有序存储服务单服务器读速率超限制 |
| `324` | `OrderedRemoveSpaceThrottle` | 删除请求被丢弃, 有序存储服务单服务器写速率超限制 |
| `331` | `NormalReadTotalThrottle` | 读取请求被丢弃, 普通存储服务所有服务器读速率超限制 |
| `332` | `NormalWriteTotalThrottle` | 写入请求被丢弃, 普通存储服务所有服务器写速率超限制 |
| `333` | `NormalListTotalThrottle` | 列出请求被丢弃, 普通存储服务所有服务器列出速率超限制 |
| `334` | `NormalRemoveTotalThrottle` | 删除请求被丢弃, 普通存储服务所有服务器删除速率超限制 |
| `341` | `OrderedReadTotalThrottle` | 读取请求被丢弃, 有序存储服务所有服务器读速率超限制 |
| `342` | `OrderedWriteTotalThrottle` | 写入请求被丢弃, 有序存储服务所有服务器写速率超限制 |
| `343` | `OrderedListTotalThrottle` | 列出请求被丢弃, 有序存储服务所有服务器列出速率超限制 |
| `344` | `OrderedRemoveTotalThrottle` | 删除请求被丢弃, 有序存储服务所有服务器删除速率超限制 |
| `401` | `DataStoreNotExist` | 数据存储集合不存在 |
| `402` | `DataStoreDeleted` | 数据存储集合已删除 |
| `403` | `OrderedDataStoreNotExist` | 有序数据存储集合不存在 |
| `404` | `OrderedDataStoreDeleted` | 有序数据存储集合已删除 |
| `411` | `OrderedDataStoreValueMustBeInt` | 有序数据存储集合的值必须是整数 |
| `412` | `DataStoreServiceNotReady` | 数据存储服务未准备好, 无法完成操作 |
| `413` | `DataStoreServiceError` | 数据存储服务内部错误, 无法完成操作 |
| `414` | `DataStoreServiceNotReach` | 数据存储服务未就绪, 无法完成操作 |
| `415` | `OperationNotSupported` | 不支持此操作 (例如 Ordered 类型调 Version API) |
| `501` | `KeyNotFound` | 键名不存在 |
| `502` | `KeyRemoved` | 键名已删除 |
| `503` | `DocInvalid` | 文档格式错误 |
| `504` | `VersionMismatch` | 版本不匹配, 期望版本与实际版本不一致 |
| `505` | `VersionInvalid` | 非法的版本 |
| `506` | `VersionNotFound` | 版本已过期或不存在 |
