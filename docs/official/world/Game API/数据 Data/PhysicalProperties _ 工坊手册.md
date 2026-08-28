# PhysicalProperties

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[PhysicalProperties](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PhysicalProperties.html) 描述物理材质的密度、摩擦、弹性及其混合权重，用于配置物体碰撞和接触时的物理表现。

## 适用场景

当需要让某个物体更重、更滑或更有弹性时，创建 [PhysicalProperties](https://u5-creator.s3.game.163.com/manual/se/game_api/data/PhysicalProperties.html) 后赋给物理单位的 CustomPhysicalProperties 等材质属性。

## 使用要点

公开 Meta 声明 PhysicalProperties.New 支持三个参数（density、friction、elasticity）和五参数重载；但 2026-08-11 当前编辑器运行时实测位置参数均被拒绝，只接受 PhysicalProperties.New({ Density = 0.5, Friction = 0.3, Elasticity = 0.2 }) 的 table 参数形式。为保证示例可运行，当前统一使用 table 形式。

## 注意事项

构造参数存在 Meta 与当前运行时漂移：文档签名保留公开 Meta 的三个参数/五参数重载，示例采用已实测可运行的 table 兼容形式。各数值的公开范围以 Meta 为准：Density 为 0.0001~100，Friction 为 0~100000，Elasticity 为 0~1，FrictionWeight 与 ElasticityWeight 为 0~100。

## 代码示例

### 构造物理材质属性

```lua
-- @runtime client
local props = PhysicalProperties.New({ Density = 0.5, Friction = 0.3, Elasticity = 0.2, FrictionWeight = 1.0, ElasticityWeight = 1.0 })
print('密度:', props.Density)
print('摩擦:', props.Friction)
print('弹性:', props.Elasticity)
```

## 属性 (5)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Density` | `Float` | `1.0` | 密度，单位为 kg/stud³；Meta 取值范围为 0.0001~100。 |
| `Friction` | `Float` | `0.3` | 摩擦系数；Meta 取值范围为 0~100000。 |
| `Elasticity` | `Float` | `0` | 弹性或恢复系数；Meta 取值范围为 0~1。 |
| `FrictionWeight` | `Float` | `1.0` | 摩擦混合权重；Meta 取值范围为 0~100。 |
| `ElasticityWeight` | `Float` | `1.0` | 弹性混合权重；Meta 取值范围为 0~100。 |
