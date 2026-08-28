# ModuleScript

模块脚本。需先通过 PrefabService:CreatePrefab("ModuleScript") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

模块脚本：可被其他脚本代码 require 的脚本模块。

> 继承自 `BaseScript`；需先通过 `PrefabService:CreatePrefab("ModuleScript")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位
