# AnimatedUnit

可播放动画的组件。通过 World:CreateUnit("AnimatedUnit", {...}) 创建，字段属性可直接读写。

## 概览

可播放动画的组件：为挂载的单位提供模型动画播放能力，通过 PlayAnimation / StopAnimation 控制动画，GetAnimationState 获取当前播放状态。

> 继承自 `WorldUnit`；可通过 `World:CreateUnit("AnimatedUnit", {...})` 创建
