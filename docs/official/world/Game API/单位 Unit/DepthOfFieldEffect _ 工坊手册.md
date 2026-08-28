# DepthOfFieldEffect

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Unit` · 单位 Unit |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)（1 属性）
    - **[DepthOfFieldEffect]**（2 属性）

### 继承成员

2 个来源 / 5 属性 / 25 函数 / 6 事件

* 来自 [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)（1 属性）
  + 属性：[`Enabled`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html#properties)
* 来自 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + 属性：[`AssetId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Name`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Desc`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)、[`Parent`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#properties)
  + 函数：[`ClearAllChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDescendants`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsAncestorOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsDescendantOf`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestor`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstAncestorOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChild`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildWhichIsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFirstChildOfClass`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`HasChildren`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildCount`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetChildAtIndex`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`SetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttribute`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAllProps`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Clone`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`IsA`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`Destroy`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetPropertyChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetAttributeChangedSignal`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`FindFromPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetFullPath`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)、[`GetDebugId`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#functions)
  + 事件：[`ChildAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`ChildRemoved`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantAdded`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`DescendantRemoving`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`AncestryChanged`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)、[`Destroying`](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html#events)

[DepthOfFieldEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/DepthOfFieldEffect.html) 是控制场景景深效果的后处理单元，通过 FocusDistance 和 MaxBlurSize 调整对焦距离与最大模糊半径；启用后需挂载到 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 才能生效。

## 适用场景

常用于需要突出特定距离物体的场景，例如在过场动画或特写镜头中，通过设置 FocusDistance 和 MaxBlurSize 使背景或前景产生模糊，增强视觉层次感。

## 使用要点

通过 game:CreateUnit("DepthOfFieldEffect", { Enabled = true }) 创建实例，将 Parent 设置为 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html)，再设置 FocusDistance 和 MaxBlurSize 调整景深效果。

## 注意事项

实例必须挂载到 [LightingService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/LightingService.html) 下才能参与后处理（与 [BloomEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BloomEffect.html)、[ColorGradingEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/ColorGradingEffect.html) 一致）。正式服务名必须保留 Service 后缀。

## 代码示例

### 创建 DepthOfFieldEffect 并挂载到光照服务

```lua
-- @runtime client
local Lighting = game:GetService('LightingService')
local depthOfFieldEffect = game:CreateUnit('DepthOfFieldEffect', {
    Enabled = true,
})
depthOfFieldEffect.Parent = Lighting
print('后处理已启用:', depthOfFieldEffect.Enabled)
```

## 属性 (2)

| Name | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `FocusDistance` | `Float` | `0.0` | 控制景深效果的对焦距离，即清晰成像的平面到摄像机的距离。 |
| `MaxBlurSize` | `Float` | `0.0` | 控制景深效果的最大模糊半径，数值越大，远离对焦平面的区域越模糊。 |

## 关联类型

* [BasePostEffect](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/BasePostEffect.html)
