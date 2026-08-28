# LinkEffectUnit

连线特效。通过 World:CreateUnit("LinkEffectUnit", {...}) 创建，字段属性可直接读写。

## 概览

连线特效：在两个位置之间播放连线特效，终点可指定坐标或绑定到某个单位。

> 继承自 `EffectUnit`；可通过 `World:CreateUnit("LinkEffectUnit", {...})` 创建

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `UseEndBindUnit` | `Bool` | - | 是否将连线终点绑定到指定单位（绑定后跟随单位移动）。 |
| `EndBindUnit` | `Unit` | - | 终点绑定的单位，仅当 UseEndBindUnit 开启时生效，可用场景单位选择器指定。 |
