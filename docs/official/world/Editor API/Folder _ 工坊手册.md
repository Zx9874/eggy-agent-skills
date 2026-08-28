# Folder

文件夹。需先通过 PrefabService:CreatePrefab("Folder") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

通用容器单位，自身不携带任何属性和渲染表现，仅用于在场景层级树中组织和分组子 Unit 实例，便于逻辑归类和批量管理。

> 继承自 `Unit`；需先通过 `PrefabService:CreatePrefab("Folder")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位
