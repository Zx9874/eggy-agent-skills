# SkinUnit

皮肤组件。需先通过 PrefabService:CreatePrefab("SkinUnit") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

皮肤组件，作为数据覆盖层挂载在父单位下，用于覆盖父单位的皮肤渲染表现。通过SkinId指定皮肤资源，并支持通过ModelColor1-4自定义各染色区域颜色、通过MaterialParam覆盖材质参数。当SkinId生效时，父单位会使用SkinUnit携带的皮肤数据替代自身默认外观；属性变更或父子关系变化时会自动通知父单位刷新渲染。

> 继承自 `Unit`；需先通过 `PrefabService:CreatePrefab("SkinUnit")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位

## 属性

| 名称 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `SkinId` | `String` | - | 皮肤资源标识符，用于指定当前SkinUnit引用的皮肤资源。设置后会通过AssetService加载对应的皮肤数据（染色、材质等），并覆盖父单位的默认渲染外观。 |
| `ModelColor1` | `Color` | - | 模型第1染色区域的颜色覆盖值。仅当皮肤模型的color\_mask包含第1位（值为1）时生效，用于自定义该区域的渲染颜色。 |
| `ModelColor2` | `Color` | - | 模型第2染色区域的颜色覆盖值。仅当皮肤模型的color\_mask包含第2位（值为2）时生效，用于自定义该区域的渲染颜色。 |
| `ModelColor3` | `Color` | - | 模型第3染色区域的颜色覆盖值。仅当皮肤模型的color\_mask包含第3位（值为4）时生效，用于自定义该区域的渲染颜色。 |
| `ModelColor4` | `Color` | - | 模型第4染色区域的颜色覆盖值。仅当皮肤模型的color\_mask包含第4位（值为8）时生效，用于自定义该区域的渲染颜色。 |
| `MaterialParam` | `MaterialParam` | - | 皮肤的材质参数覆盖，用于修改模型的材质渲染属性（如金属度、粗糙度、自发光等）。设置后会覆盖父单位的默认材质表现。 |
