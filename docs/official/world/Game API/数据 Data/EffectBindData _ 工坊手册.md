# EffectBindData

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Data` · 数据 Data |
| Realm | `common` |

[EffectBindData](https://u5-creator.s3.game.163.com/manual/se/game_api/data/EffectBindData.html) 用于描述 [EffectUnit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/EffectUnit.html) 与目标单位的绑定方式，包括宿主提供的目标单位 ID、挂点、偏移和跟随类型。

## 适用场景

当宿主系统或编辑器流程已经提供目标单位的公开数值 ID 时，构造绑定数据并赋给 EffectUnit.EffectBindData。

## 使用要点

调用 EffectBindData.New() 创建实例，写入宿主提供的 BindUnitId、BindSocket、BindOffset 与命名枚举 BindType，再赋给 EffectUnit.EffectBindData。

## 注意事项

BindUnitId 必须由宿主系统或编辑器流程提供；当前 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 公开 Meta 未声明 UnitId 属性，示例不得读取 target.UnitId。BindSocket 必须与目标资源真实挂点匹配。

## 代码示例

### 使用宿主提供的目标 ID 配置特效绑定

```lua
-- @runtime client
local function configureEffectBinding(effect, targetUnitId)
    if effect == nil or not effect:IsA("EffectUnit") or targetUnitId == nil then
        return
    end

    local bindData = EffectBindData.New()
    bindData.BindUnitId = targetUnitId  -- 由宿主系统或编辑器流程提供
    bindData.BindSocket = "Origin"
    bindData.BindOffset = Vector3.New(0, 2, 0)
    bindData.BindType = Enums.EffectBindType.ALL
    effect.EffectBindData = bindData
end
```

## 属性 (4)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `BindUnitId` | `Int` | `-1` | 特效绑定的目标单位的唯一标识符。 |
| `BindSocket` | `String` | `""` | 特效绑定的目标单位上的挂接点名称，例如 "Head"、"Spine" 等。 |
| `BindOffset` | [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html) | `Vector3.New(0, 0, 0)` | 特效绑定到目标单位时的位置偏移量，用于调整特效相对于绑定点的空间位置。 |
| `BindType` | [EffectBindType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EffectBindType.html) | `Enums.EffectBindType.ALL` | 特效与目标单位的绑定方式，决定特效跟随目标的位置、旋转或缩放。 |

## 关联类型

* [EffectBindType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/EffectBindType.html)
* [Vector3](https://u5-creator.s3.game.163.com/manual/se/game_api/data/Vector3.html)
