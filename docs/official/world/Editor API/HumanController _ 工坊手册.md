# HumanController

人形控制器。字段属性可直接读写。

## 概览

人形生物控制器：在通用生物控制器的基础上扩展人形特有的能力（攀爬、状态机、惯性等），通过 HumanUnit.Controller 获取使用。

> 继承自 `BaseController`；不可实例化，由接口返回

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `EvaluateStateMachine` | `Bool` | - | 是否启用内置状态机评估（移动、跳跃、下落等）。关闭后状态机副作用暂停，但脚本驱动 ChangeState 仍可用。 |
| `InertiaEnabled` | `Bool` | - | 是否启用引擎层惯性位移。设为 false 时，人物在 Move / MoveTo 停止后立即静止，不再因惯性继续向前滑动。 |
| `NameBarOffset` | `Float` | - | 名称标签在头顶上方的垂直偏移高度（米）。 |
