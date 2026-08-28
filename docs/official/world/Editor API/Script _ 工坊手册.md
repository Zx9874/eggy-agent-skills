# Script

服务端脚本。通过 World:CreateUnit("Script", {...}) 创建，字段属性可直接读写。

## 概览

服务端脚本：仅在服务器侧执行的脚本。

> 继承自 `BaseScript`；可通过 `World:CreateUnit("Script", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Icon` | `String` | - | 脚本图标资源路径，客户端运行时同步可见。 |
