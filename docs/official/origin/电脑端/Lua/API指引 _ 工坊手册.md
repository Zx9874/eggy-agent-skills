# API指引

本手册将 API 按功能系统进行划分，每个系统下再细分其相关的类型、枚举和 API，便于查阅和理解。

---

## 1. 单位与对象系统

### 相关类型

* `Unit`（单位）、`UnitID`、`UnitKey`、`UnitType`
* `LifeEntity`（生命体）、`Creature`（生物）、`Character`（角色）、`Obstacle`（组件）、`Equipment`（物品）、`Modifier`（效果）
* 相关列表类型如 `ListUnit`、`ListLifeEntity`、`ListCreature`、`ListCharacter`、`ListObstacle`、`ListEquipment`、`ListModifier` 等

### 相关枚举

* `UnitType` 单位类型
* `RigidBodyType` 物理类型
* `BuffState` 状态
* `EquipmentType` 物品类型
* `EquipmentSlotType` 物品槽位类型
* `MoveMode` AI移动模式
* `PatrolType` AI巡逻类型

### 主要API

* **单位创建与销毁**
  + `GameAPI.create_unit_with_scale(_u_key, _pos, _rotation, _scale)`：创建单位，支持自定义缩放。
  + `GameAPI.destroy_unit(_unit)`：销毁指定单位。
  + `GameAPI.create_creature`、`GameAPI.create_life_entity`、`GameAPI.create_obstacle`：分别创建生物、生命体、组件。
* **单位属性与状态**
  + `Unit.get_position()` / `Unit.set_position(_pos)`：获取/设置单位坐标。
  + `Unit.get_orientation()` / `Unit.set_orientation(_rot)`：获取/设置单位旋转。
  + `Unit.get_linear_velocity()` / `Unit.set_linear_velocity(_vel)`：获取/设置线速度。
  + `Unit.get_rigid_body_type()`：获取物理类型（静态/动力学/受力）。
  + `Unit.get_unit_type()`：获取单位类型（生物/角色/组件等）。
* **单位层级与子组件**
  + `Unit.add_child(_unit)`：添加子单位。
  + `Unit.get_children()`：获取所有子单位。
  + `LuaAPI.get_component_list(_obj)`：获取单位的子组件名称列表。
* **单位交互与物理**
  + `Unit.apply_force(_force)`：对单位施加力。
  + `Unit.apply_impact_force(_force, _max_speed, _force_lost_control, _lost_ctrl_time)`：施加冲击力并可设置击飞。
  + `Unit.enable_gravity()` / `Unit.disable_gravity()`：开启/关闭重力。
  + `Unit.enable_interact()` / `Unit.disable_interact()`：开启/关闭单位交互。
* **单位状态与属性管理**
  + `AttrComp.get_attr_by_type(_value_type, _key)`：获取单位属性。
  + `AttrComp.set_attr_by_type(_value_type, _key, _val)`：设置单位属性。
  + `BuffStateComp.add_state(_state_id)` / `BuffStateComp.remove_state(_state_id)`：添加/移除单位状态。
* **单位音效与特效**
  + `Unit.play_3d_sound(_sound_key, _duration, _volume)`：播放3D音效。
  + `Unit.play_emoji(_emoji_key)`：单位发送表情。
  + `Unit.show_bubble_msg(_show_msg, _show_time, _max_dis)`：显示气泡信息。

---

## 2. 技能与战斗系统

### 相关类型

* `Ability`（技能）、`AbilityKey`、`AbilitySlot`
* 技能相关列表类型如 `ListAbility`、`ListAbilityKey`、`ListAbilitySlot`

### 相关枚举

* `BuffState` 技能状态
* `AbilitySlot` 技能槽位

### 主要API

* **技能释放与管理**
  + `Ability.begin_cast(_dir_info, _target_point, _target_unit)`：开始释放技能。
  + `Ability.break_cast()` / `Ability.break_accumulate()`：打断技能施法/蓄力。
  + `Ability.enter_cd()`：技能进入冷却。
  + `Ability.is_in_cd()` / `Ability.is_in_charge()`：判断技能是否在冷却/充能中。
* **技能属性与信息**
  + `Ability.get_name()` / `Ability.get_desc()`：获取技能名称/描述。
  + `Ability.get_cd_time()` / `Ability.get_left_cd_time()`：获取技能冷却时间/剩余冷却时间。
  + `Ability.get_accumulate_ratio()`：获取蓄力百分比。
  + `Ability.get_owner()` / `Ability.get_owner_character()` / `Ability.get_owner_creature()`：获取技能拥有者。
* **技能槽位与增删**
  + `AbilityComp.add_ability_to_slot(_ability_index, _ability_id, _kv_args, _kv_types)`：向槽位添加技能。
  + `AbilityComp.remove_ability(_ability_slot)` / `AbilityComp.remove_ability_by_key(_ability_key)`：移除技能。
  + `AbilityComp.get_abilities()`：获取单位所有技能。
* **技能与单位状态交互**
  + `Ability.add_state_to_target(_unit, _state_id)` / `Ability.remove_state_to_target(_unit, _state_id)`：技能为单位添加/移除状态。
  + `Ability.play_countdown_ui(_time)`：播放技能倒计时UI。

---

## 3. 触发与事件系统

### 相关类型

* `TriggerSpace`（逻辑体）、`CustomTriggerSpace`（自定义触发区域）、`TriggerSpaceKey`、`CustomTriggerSpaceKey`
* 相关列表类型如 `ListTriggerSpace`、`ListCustomTriggerSpace`

### 相关枚举

* `TriggerSpaceEventType` 触发区域类型

### 主要API

* **触发器注册与事件分发**
  + `LuaAPI.global_register_trigger_event(_event_desc, _callback)`：注册全局触发器。
  + `LuaAPI.unit_register_trigger_event(_unit, _event_desc, _callback)`：注册单位触发器。
  + `LuaAPI.global_send_custom_event(_event_name, _data)` / `LuaAPI.unit_send_custom_event(_unit, _event_name, _data)`：发送全局/单位自定义事件。
  + `LuaAPI.global_unregister_trigger_event(_id)` / `LuaAPI.unit_unregister_trigger_event(_unit, _id)`：注销触发器。
* **触发区域与逻辑体管理**
  + `GameAPI.create_triggerspace(_u_key, _pos, _rotation, _scale, _role)`：创建逻辑体。
  + `GameAPI.create_customtriggerspace(_u_key, _pos, _rotation, _scale, _role)`：创建自定义触发区域。
  + `CustomTriggerSpace.random_point()`：获取触发区域内的随机坐标。
* **事件类型**
  + 包含技能、单位、组件、生命体、物品、角色、全局等多种事件（如 `ABILITY_CAST_BEGIN`、`ANY_OBSTACLE_CREATE`、`SPEC_LIFEENTITY_DIE` 等），支持自定义事件和UI事件。

---

## 4. UI与交互系统

### 相关类型

* `EButton`、`EImage`、`ELabel`、`ENode`、`EProgressbar` 等 UI 节点类型
* 相关列表类型如 `ListEButton`、`ListEImage`、`ListELabel`、`ListENode`、`ListEProgressbar`

### 主要API

* **UI节点查询与操作**
  + `LuaAPI.query_ui_node(_name)` / `LuaAPI.query_ui_nodes(_name_list)`：查询单个/批量UI节点。
  + `Role.set_button_text(_button, _text)`：设置按钮文本。
  + `Role.set_label_color(_label, _color, _transition_time)`：设置文本颜色。
  + `Role.set_node_visible(_node, _visible)` / `Role.set_ui_opacity(_node, _opacity)`：设置节点可见性/透明度。
  + `Role.set_progressbar_current(_progress_bar, _current)` / `Role.set_progressbar_max(_progress_bar, _max)`：设置进度条进度。
* **UI交互与反馈**
  + `Role.show_tips(_content, _duration)`：显示飘字提示。
  + `Role.set_node_touch_enabled(_node, _touch_enabled)`：设置节点交互开关。
  + `Role.show_goods_purchase_panel(_raw_goods_id, _show_time)`：显示商品购买界面。

---

## 5. 场景与相机系统

### 相关类型

* `CameraBindMode`、`CameraPropertyType`、`SkyBoxBackground`、`SkyBoxGradualType`、`Color`、`Vector3`、`Point3`、`Quaternion`

### 相关枚举

* `CameraBindMode` 相机绑定模式
* `CameraPropertyType` 相机属性预设
* `SkyBoxGradualType` 天空盒渐变类型

### 主要API

* **相机控制**
  + `GlobalAPI.set_camera_bind_mode(_role, _mode)`：设置相机绑定模式。
  + `GlobalAPI.set_camera_follow_unit(_role, _unit, _follow_rotation)`：相机跟随单位。
  + `GlobalAPI.set_camera_property(_role, _property, _value)`：设置相机属性（如距离、视场角、俯仰角等）。
  + `Role.reset_camera(_reset_angle, _reset_bind, _reset_point, _reset_prop_pitch)`：重置相机。
* **场景与光照**
  + `GlobalAPI.set_skybox_texture(_texture_id, _change_type, _duration)`：切换天空盒。
  + `GlobalAPI.set_direct_light(_param_dict, _duration)`：设置场景光照参数。
  + `GameAPI.set_life_entity_survival_scene_boundary(_x, _y, _z)` / `GameAPI.set_unit_survival_scene_boundary(_x, _y, _z)`：设置单位/生命体的场景边界。

---

## 6. 音效与特效系统

### 相关类型

* `SfxID`、`SfxKey`、`SoundID`、`SoundKey`

### 主要API

* **特效播放与管理**
  + `GameAPI.play_sfx_by_key(_sfx_key, _pos, _rot, _scale, _duration, _rate, _with_sound)`：播放特效。
  + `GlobalAPI.bind_sfx_to_unit(_sfx_id, _unit, _socket_name, _pos, _bind_type)`：将特效绑定到单位。
  + `GlobalAPI.set_sfx_position(_sfx_id, _pos)` / `GlobalAPI.set_sfx_orientation(_sfx_id, _orientation)`：设置特效位置/旋转。
  + `GlobalAPI.set_sfx_visible(_sfx_id, _visible)`：设置特效可见性。
  + `GlobalAPI.destroy_sfx(_sfx_id, _fade_out)`：销毁特效。
* **音效播放与管理**
  + `GameAPI.play_3d_sound(_position, _sound_key, _duration, _volume)`：播放3D音效。
  + `GameAPI.stop_sound(_assigned_id)` / `Unit.stop_sound(_lres_id)`：停止音效。

---

## 7. 存档与成就系统

### 相关类型

* `Archive`、`ArchiveType`、`Achievement`

### 主要API

* **存档管理**
  + `Role.get_archive_by_type(_archive_type, _key)` / `Role.set_archive_by_type(_archive_type, _key, _val)`：获取/设置存档值。
* **成就管理**
  + `Role.get_achievement_progress(_event_id)` / `Role.set_achievement_progress(_event_id, _count)`：获取/设置成就进度。
  + `Role.add_achievement_progress(_event_id, _add_count)`：增加成就进度。
  + `Role.is_achievement_completed(_event_id)`：判断成就是否完成。

---

## 8. 通用与工具API

### 相关类型

* `Dict`、`List`、`Str`、`Int`、`Bool`、`Fixed`、`Timer`、`Timestamp`

### 主要API

* **日志与调试**
  + `LuaAPI.log(_content)` / `GlobalAPI.debug(_content)` / `GlobalAPI.error(_content)` / `GlobalAPI.warning(_content)`：日志输出。
* **随机数与模块**
  + `LuaAPI.rand()` / `GameAPI.random_int(_min_value, _max_value)` / `GameAPI.random_color()`：生成随机数/颜色。
  + `LuaAPI.require(_name)`：加载脚本模块。
* **全局变量与时间**
  + `LuaAPI.get_global_var(_var_name)` / `GameAPI.has_global_kv(_var_name)`：获取/判断全局变量。
  + `GameAPI.get_day(_timestamp)`、`GameAPI.get_hour(_timestamp)`、`GameAPI.get_year(_timestamp)` 等：时间戳转日期/时间。

---

## 9. 事件（EVENT）

### 主要事件类型

* **技能事件**：如 `ABILITY_BULLET_HIT`、`ABILITY_CAST_BEGIN`、`ABILITY_UPGRADE` 等，涵盖技能释放、冷却、升级、命中等。
* **单位/组件/生命体/物品/角色相关事件**：如 `SPEC_LIFEENTITY_CREATE`、`SPEC_OBSTACLE_CREATE`、`SPEC_EQUIPMENT_ENTER_CHAR_SLOT` 等，涵盖对象的创建、销毁、交互、移动、复活等。
* **全局与自定义事件**：如 `GAME_END`、`GAME_INIT`、`CUSTOM_EVENT`、`UI_CUSTOM_EVENT`，支持自定义扩展。
* **计时器与周期性事件**：如 `TIMEOUT`、`REPEAT_TIMEOUT`，用于定时与周期性逻辑。

---

> 如需某一功能系统下的详细API说明，可进一步指定系统名称。
