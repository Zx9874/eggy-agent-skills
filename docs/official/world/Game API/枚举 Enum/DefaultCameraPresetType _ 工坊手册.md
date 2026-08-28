# DefaultCameraPresetType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → DefaultCameraPresetType

[DefaultCameraPresetType](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/DefaultCameraPresetType.html) 枚举定义 CameraService.DefaultCameraPreset 可使用的默认相机预设。

## 适用场景

在游戏初始化阶段配置 CameraService.DefaultCameraPreset 时，使用该枚举选择第一人称、第三人称、横板视角或模型展示等默认相机模式。

## 使用要点

通过 game:GetService("CameraService") 获取 [CameraService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/CameraService.html)，然后将 CameraService.DefaultCameraPreset 设置为 Enums.DefaultCameraPresetType.THIRD\_PERSON 等枚举成员。

## 注意事项

该枚举对应 CameraService.DefaultCameraPreset 属性，用于在游戏初始化阶段选择默认相机预设。枚举值必须通过 Enums.DefaultCameraPresetType 命名空间访问，禁止使用数字代替。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `0` | `VOID` | 不做变更 |
| `1` | `FIRST_PERSON` | 第一人称 |
| `2` | `THIRD_PERSON` | 第三人称 |
| `3` | `SIDE_SCROLLING` | 横板游戏 |
| `4` | `STATIC_MODEL` | 模型展示 |
