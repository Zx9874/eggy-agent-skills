# FindingPathUnit

寻路路径。需先通过 PrefabService:CreatePrefab("FindingPathUnit") 创建预设，再通过 World:CreateAsset(预设ID) 创建单位，字段属性可直接读写。

## 概览

寻路路径：在场景中标记一条寻路路径，通过路点（GetWaypoints / AddPoint / RemovePoint / GetPointCount）定义路径走向。

> 继承自 `SpaceUnit`；需先通过 `PrefabService:CreatePrefab("FindingPathUnit")` 创建预设，再通过 `World:CreateAsset(预设ID)` 创建单位
