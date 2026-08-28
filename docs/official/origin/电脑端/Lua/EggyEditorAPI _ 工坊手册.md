# EggyEditorAPI

## CLASS

## LuaAPI

## GlobalAPI

## GameAPI

## 单位API

### EditorAPI.create\_obstacle

**描述**: 在场景中创建组件

```lua
EditorAPI.create_obstacle(_unit_key, _pos)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_unit_key` | `ObstacleKey` | 组件编号 |
| `_pos` | `Point3` | 坐标 |

#### 返回值

* **类型**: `UnitID`
* **说明**: 组件ID

### EditorAPI.create\_unit\_group

**描述**: 在场景中创建组件组

```lua
EditorAPI.create_unit_group(_group_key, _pos)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_group_key` | `UnitGroupKey` | 组件组编号 |
| `_pos` | `Point3` | 坐标 |

#### 返回值

* **类型**: `UnitID`
* **说明**: 组件组ID

### EditorAPI.destroy\_obstacle

**描述**: 删除场景中的组件

```lua
EditorAPI.destroy_obstacle(_unit_id)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_unit_id` | `UnitID` | 组件ID |

### EditorAPI.game\_execute

**描述**: 执行游戏指令

```lua
EditorAPI.game_execute(_content)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_content` | `Str` | 代码 |

### EditorAPI.get\_all\_scene\_unit\_data

**描述**: 获取场景中所有组件的数据

```lua
EditorAPI.get_all_scene_unit_data()
```

#### 返回值

* **类型**: `Dict`
* **说明**: 组件列表

### EditorAPI.get\_all\_unit\_ids

**描述**: 获取所有单位

```lua
EditorAPI.get_all_unit_ids()
```

#### 返回值

* **类型**: `ListUnit`
* **说明**: 单位列表

### EditorAPI.get\_first\_unit\_key\_by\_prefab\_name

**描述**: 根据名称获取单位编号

```lua
EditorAPI.get_first_unit_key_by_prefab_name(_prefab_name, _table_key)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_prefab_name` | `Str` | 单位名称 |
| `_table_key` | `Str` | 单位类型 |

#### 返回值

* **类型**: `UnitKey`
* **说明**: 单位编号

### EditorAPI.get\_scene\_unit\_data

**描述**: 获取场景中指定ID的组件的数据

```lua
EditorAPI.get_scene_unit_data(_uid)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_uid` | `Int` | 组件ID |

#### 返回值

* **类型**: `Dict`
* **说明**: 组件数据

### EditorAPI.get\_selected\_unit\_ids

**描述**: 获取当前被选中单位

```lua
EditorAPI.get_selected_unit_ids()
```

#### 返回值

* **类型**: `ListUnit`
* **说明**: 单位列表

### EditorAPI.get\_unit\_attr

**描述**: 获取单位属性

```lua
EditorAPI.get_unit_attr(_unit_id, _attr_key)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_unit_id` | `UnitID` | 单位ID |
| `_attr_key` | `Str` | 属性名 |

#### 返回值

* **类型**: `ETypeMeta`
* **说明**: 单位列表

### EditorAPI.get\_unit\_kv

**描述**: 获取单位自定义属性

```lua
EditorAPI.get_unit_kv(_unit_id, _attr_key)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_unit_id` | `UnitID` | 单位ID |
| `_attr_key` | `Str` | 属性名 |

#### 返回值

* **类型**: `ETypeMeta`
* **说明**: 属性值

### EditorAPI.input\_ability\_prefab

**描述**: 导入技能预设数据

```lua
EditorAPI.input_ability_prefab(_path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_path` | `Str` | 文件路径 |

### EditorAPI.input\_char\_prefab

**描述**: 导入蛋仔角色预设数据

```lua
EditorAPI.input_char_prefab(_path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_path` | `Str` | 文件路径 |

### EditorAPI.input\_creature\_prefab

**描述**: 导入生物预设数据

```lua
EditorAPI.input_creature_prefab(_path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_path` | `Str` | 文件路径 |

### EditorAPI.input\_decoration\_prefab

**描述**: 导入装饰物预设数据

```lua
EditorAPI.input_decoration_prefab(_path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_path` | `Str` | 文件路径 |

### EditorAPI.input\_equipment\_prefab

**描述**: 导入物品预设数据

```lua
EditorAPI.input_equipment_prefab(_path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_path` | `Str` | 文件路径 |

### EditorAPI.input\_group\_prefab

**描述**: 导入组件组预设数据

```lua
EditorAPI.input_group_prefab(_path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_path` | `Str` | 文件路径 |

### EditorAPI.input\_modifier\_prefab

**描述**: 导入效果预设数据

```lua
EditorAPI.input_modifier_prefab(_path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_path` | `Str` | 文件路径 |

### EditorAPI.input\_trigger\_prefab

**描述**: 导入逻辑体预设数据

```lua
EditorAPI.input_trigger_prefab(_path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_path` | `Str` | 文件路径 |

### EditorAPI.input\_unit\_prefab

**描述**: 导入组件预设数据

```lua
EditorAPI.input_unit_prefab(_path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_path` | `Str` | 文件路径 |

### EditorAPI.input\_virtual\_point\_prefab

**描述**: 导入路径点预设数据

```lua
EditorAPI.input_virtual_point_prefab(_path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_path` | `Str` | 文件路径 |

### EditorAPI.log

**描述**: 输出日志

```lua
EditorAPI.log(_content)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_content` | `Str` | 日志内容 |

### EditorAPI.output\_ability\_prefab

**描述**: 导出技能预设数据

```lua
EditorAPI.output_ability_prefab(_eid, _path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_eid` | `Int` | 预设ID |
| `_path` | `Str` | 文件路径 |

### EditorAPI.output\_char\_prefab

**描述**: 导出蛋仔角色预设数据

```lua
EditorAPI.output_char_prefab(_eid, _path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_eid` | `Int` | 预设ID |
| `_path` | `Str` | 文件路径 |

### EditorAPI.output\_creature\_prefab

**描述**: 导出生物预设数据

```lua
EditorAPI.output_creature_prefab(_eid, _path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_eid` | `Int` | 预设ID |
| `_path` | `Str` | 文件路径 |

### EditorAPI.output\_decoration\_prefab

**描述**: 导出装饰物预设数据

```lua
EditorAPI.output_decoration_prefab(_eid, _path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_eid` | `Int` | 预设ID |
| `_path` | `Str` | 文件路径 |

### EditorAPI.output\_equipment\_prefab

**描述**: 导出物品预设数据

```lua
EditorAPI.output_equipment_prefab(_eid, _path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_eid` | `Int` | 预设ID |
| `_path` | `Str` | 文件路径 |

### EditorAPI.output\_group\_prefab

**描述**: 导出组件组预设数据

```lua
EditorAPI.output_group_prefab(_eid, _path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_eid` | `Int` | 预设ID |
| `_path` | `Str` | 文件路径 |

### EditorAPI.output\_modifier\_prefab

**描述**: 导出效果预设数据

```lua
EditorAPI.output_modifier_prefab(_eid, _path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_eid` | `Int` | 预设ID |
| `_path` | `Str` | 文件路径 |

### EditorAPI.output\_trigger\_prefab

**描述**: 导出逻辑体预设数据

```lua
EditorAPI.output_trigger_prefab(_eid, _path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_eid` | `Int` | 预设ID |
| `_path` | `Str` | 文件路径 |

### EditorAPI.output\_unit\_prefab

**描述**: 导出组件预设数据

```lua
EditorAPI.output_unit_prefab(_eid, _path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_eid` | `Int` | 预设ID |
| `_path` | `Str` | 文件路径 |

### EditorAPI.output\_virtual\_point\_prefab

**描述**: 导出路径点预设数据

```lua
EditorAPI.output_virtual_point_prefab(_eid, _path)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_eid` | `Int` | 预设ID |
| `_path` | `Str` | 文件路径 |

### EditorAPI.query\_scene\_units

**描述**: 查询场景中的单位

```lua
EditorAPI.query_scene_units(_pattern, _reg_math)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_pattern` | `Str` | 名称 |
| `_reg_math` | `Bool` | 启用正则匹配 |

#### 返回值

* **类型**: `List`
* **说明**: 单位信息列表

### EditorAPI.query\_unit\_ids

**描述**: 查询场景中的单位

```lua
EditorAPI.query_unit_ids(_pattern, _reg_math)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_pattern` | `Str` | 名称 |
| `_reg_math` | `Bool` | 启用正则匹配 |

#### 返回值

* **类型**: `List`
* **说明**: 单位信息列表

### EditorAPI.random

**描述**: 生成随机数

```lua
EditorAPI.random(_a, _b)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_a` | `Fixed` | 随机范围开始 |
| `_b` | `Fixed` | 随机范围结束 |

#### 返回值

* **类型**: `Fixed`
* **说明**: 随机结果

### EditorAPI.require

**描述**: 加载脚本模块

```lua
EditorAPI.require(_name)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_name` | `Str` | 模块名 |

### EditorAPI.set\_menu\_dialog

**描述**: 设置菜单对话框

```lua
EditorAPI.set_menu_dialog(_name, _config)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_name` | `Str` | 入口名称 |
| `_config` | `Dict` | 配置描述表 |

### EditorAPI.set\_unit\_attr

**描述**: 设置单位属性

```lua
EditorAPI.set_unit_attr(_unit_id, _attr_key, _attr_value)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_unit_id` | `UnitID` | 单位ID |
| `_attr_key` | `Str` | 属性名 |
| `_attr_value` | `ETypeMeta` | 属性值 |

### EditorAPI.set\_unit\_kv

**描述**: 设置单位自定义属性

```lua
EditorAPI.set_unit_kv(_unit_id, _attr_key, _attr_type, _attr_value)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_unit_id` | `UnitID` | 单位ID |
| `_attr_key` | `Str` | 属性名 |
| `_attr_type` | `ValueType` | 属性类型 |
| `_attr_value` | `ETypeMeta` | 属性值 |

### EditorAPI.unit\_add\_child

**描述**: 添加子单位

```lua
EditorAPI.unit_add_child(_parent_uid, _child_uid)
```

#### 参数列表:

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `_parent_uid` | `UnitID` | 父单位ID |
| `_child_uid` | `UnitID` | 子单位ID |
