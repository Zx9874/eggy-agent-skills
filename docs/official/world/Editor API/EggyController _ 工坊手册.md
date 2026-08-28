# EggyController

蛋形控制器。字段属性可直接读写。

## 概览

蛋形生物控制器：在通用生物控制器的基础上扩展蛋仔特有的玩法表现，包括抓举、前扑、翻滚以及质量条等能力，通过 EggyUnit.Controller 获取使用。

> 继承自 `BaseController`；不可实例化，由接口返回

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `LiftedEnabled` | `Bool` | - | 该单位是否可以被其他单位抓举。 |
| `PunchThreshold` | `Float` | - | 受到击打后进入失控状态的阈值。 |
