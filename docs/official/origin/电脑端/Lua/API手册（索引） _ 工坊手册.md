# API手册

### Ability

技能

### AbilityKey

技能编号

### AbilitySlot

技能槽位

### Achievement

自定义成就

### AnimKey

动画编号

### Archive

自定义存档

### ArchiveType

存档类型

### BattleShopKey

商店

### BindType

绑定类型

### Bool

布尔值

### BuffState

状态

### CameraBindMode

相机绑定模式

### CameraProjectionType

相机投影类型

### CameraPropertyType

相机属性预设

### CameraShakeType

屏幕震动类型

### Camp

阵营

### CampID

阵营ID

### Character

角色

### CharacterKey

角色编号

### CollisionLimitType

碰撞限制枚举

### Color

颜色

### Creature

生物

### CreatureKey

生物编号

### CustomTriggerSpace

触发区域

### CustomTriggerSpaceKey

触发区域编号

### DamageSchema

伤害方案

### DecorationKey

装饰物编号

### Dict

字典

### DirectionType

方向枚举

### E3DLayer

场景UI实例

### E3DLayerKey

场景UI预设

### EBagSlot

UI物品槽位节点

### EButton

UI按钮节点

### EEffectNode

UI动效节点

### EImage

UI图片节点

### EInputField

UI输入节点

### ELabel

UI文本节点

### ENode

UI节点

### EProgressbar

UI进度条节点

### ETypeMeta

None

### EmojiKey

气泡表情编号

### Equipment

物品

### EquipmentKey

物品编号

### EquipmentSlot

物品槽位

### EquipmentSlotType

物品槽位类型

### Fixed

定点数

### FontKey

字体key

### Function

函数

### ImageKey

图片编号

### Int

整型

### InteractBtnID

交互按钮编号

### InteractBtnType

交互按钮类型

### JointAssistantKey

关节预设编号

### LevelKey

关卡编号

### LifeEntity

生命体

### List

列表

### ListAIBasicCommand

AI基础命令类型列表

### ListStr

字符串列表

### ListUnitType

单位类型列表

### ListVector3

向量列表

### ModelSocket

部位

### Modifier

效果

### ModifierKey

效果编号

### MontageKey

剧情动画编号

### MoveMode

AI移动模式

### ObstacleKey

组件编号

### PaintArea

染色区域

### PathID

路径ID

### PathPointID

路点ID

### PatrolType

AI巡逻类型

### Point3

坐标点

### Quaternion

四元数

### Role

玩家

### RoleID

玩家ID

### SfxID

特效ID

### SfxKey

特效编号

### SkyBoxBackground

天空盒背景

### SkyBoxGradualType

天空盒渐变类型

### SoundID

音效ID

### SoundKey

音效编号

### Str

字符串

### Timer

计时器

### Timestamp

时间戳

### TriggerSpaceKey

逻辑体编号

### UgcCommodity

道具

### UgcGoods

商品

### Unit

单位

### UnitGroupKey

组件组编号

### UnitID

单位ID

### UnitKey

单位编号

### UnitType

单位类型

### ValueType

值类型

### Vector3

向量

### WindFieldShapeType

风场形状

## ENUM

### RigidBodyType 物理类型

STATIC 0 静态

KINEMATIC 1 运动学

DYNAMIC 2 受外力

### EquipmentSlotType 物品槽位类型

EQUIPPED 1 装配槽位

BACKPACK 2 背包槽位

### CampRelationType 阵营关系类型

ENEMY 1 敌方

FRIEND 2 友方

NEUTRAL 4 中立

### EquipmentType 物品类型

BASIC 0 基础物品

WEAPON 1 武器物品

### UnitType 单位类型

CREATURE 4 生物

CUSTOMTRIGGERSPACE 8 触发区域

CHARACTER 128 角色

OBSTACLE 256 组件

TRIGGERSPACE 512 逻辑体

DECORATION 1024 装饰物

EQUIPMENT 32768 物品

### TriggerSpaceEventType 触发区域类型

ENTER 1 进入

LEAVE 4 离开

### GameResult 游戏结局

LOSE 0 失败

WIN 1 胜利

GAMING 2 游戏中

### MoveMode AI移动模式

DIRECT 0 直线运动

PATHFIND 1 避障运动

### AIBasicCommand AI基础命令类型

JUMP 1 跳跃

ROLL 2 滚动

RUSH 3 前扑

LIFT 4 举起

ABILITY 5 使用道具/技能

MOVE 6 移动

### PatrolType AI巡逻类型

ONE\_WAY 0 一次性

LOOP 1 巡逻

BACK\_AND\_FORTH 2 往返

### BuffState 状态

BUFF\_FORBID\_JUMP 1 禁止跳跃

BUFF\_FORBID\_RUSH 2 禁止飞扑

BUFF\_FORBID\_LIFT 4 禁止抓举

BUFF\_FORBID\_ROLL 8 禁止滚动

BUFF\_FORBID\_MOVE 16 禁止移动

BUFF\_FORBID\_CONTROL 32 无法控制

BUFF\_SILENT 64 沉默

### CameraPropertyType 相机属性预设

TRACK\_MODE\_PITCH 0 追踪-俯仰角

TRACK\_MODE\_YAW 1 追踪-偏航角

BIND\_MODE\_OFFSET\_X 2 固定-X轴偏移

BIND\_MODE\_OFFSET\_Y 3 固定-Y轴偏移

BIND\_MODE\_OFFSET\_Z 4 固定-Z轴偏移

BIND\_MODE\_PITCH 5 固定-俯仰角

BIND\_MODE\_YAW 6 固定-偏航角

DIST 7 相机距离

FOV 8 视场角

PITCH\_MAX 9 最大俯仰角

PITCH\_MIN 10 最小俯仰角

OBSERVER\_HEIGHT 11 相机高度

HORIZONTAL\_OFFSET 12 水平偏移

PITCH 15 俯仰角

YAW 16 偏航角

OFFSET\_X 17 X轴偏移

OFFSET\_Y 18 Y轴偏移

OFFSET\_Z 19 Z轴偏移

ROLL 20 滚动角

### CameraBindMode 相机绑定模式

DEFAULT 0 DEFAULT

BIND 1 BIND

TRACK 2 TRACK

### WindFieldShapeType 风场形状

CONICAL 0 锥形

SECTOR 1 扇形

WAVE 2 波浪形

### ValueType 值类型

AIBasicCommand AIBasicCommand AI基础命令类型

Ability Ability 技能

AbilityIndex AbilityIndex 技能槽位(内部)

AbilityKey AbilityKey 技能编号

AbilityPointerType AbilityPointerType 技能指示器类型

AbilitySlot AbilitySlot 技能槽位

Achievement Achievement 自定义成就

Actor Actor Actor

AnimKey AnimKey 动画编号

Archive Archive 自定义存档

ArchiveType ArchiveType 存档类型

BattleShopKey BattleShopKey 商店

BindType BindType 绑定类型

Bool Bool 布尔值

BuffState BuffState 状态

CameraBindMode CameraBindMode 相机绑定模式

CameraProjectionType CameraProjectionType 相机投影类型

CameraPropertyType CameraPropertyType 相机属性预设

CameraShakeType CameraShakeType 屏幕震动类型

Camp Camp 阵营

CampID CampID 阵营ID

CampRelationType CampRelationType 阵营关系类型

Character Character 角色

CharacterID CharacterID 角色ID

CharacterKey CharacterKey 角色编号

CollisionLimitType CollisionLimitType 碰撞限制枚举

Color Color 颜色

ConfigTable ConfigTable 多维表

Creature Creature 生物

CreatureID CreatureID 生物ID

CreatureKey CreatureKey 生物编号

CustomTriggerSpace CustomTriggerSpace 触发区域

CustomTriggerSpaceID CustomTriggerSpaceID 触发区域ID

CustomTriggerSpaceKey CustomTriggerSpaceKey 触发区域编号

Damage Damage 伤害

DamageSchema DamageSchema 伤害方案

Decoration Decoration 装饰物

DecorationKey DecorationKey 装饰物编号

DirectionType DirectionType 方向枚举

E3DLayer E3DLayer 场景UI实例

E3DLayerKey E3DLayerKey 场景UI预设

EBagSlot EBagSlot UI物品槽位节点

EButton EButton UI按钮节点

ECanvas ECanvas UI画布节点

EEffectNode EEffectNode UI动效节点

EImage EImage UI图片节点

EInputField EInputField UI输入节点

ELabel ELabel UI文本节点

ENode ENode UI节点

EProgressbar EProgressbar UI进度条节点

EmojiKey EmojiKey 气泡表情编号

Equipment Equipment 物品

EquipmentID EquipmentID 物品ID

EquipmentKey EquipmentKey 物品编号

EquipmentSlot EquipmentSlot 物品槽位

EquipmentSlotType EquipmentSlotType 物品槽位类型

EquipmentType EquipmentType 物品类型

FaceExpressionKey FaceExpressionKey 面部表情编号

FashionKey FashionKey 时装编号

Fixed Fixed 定点数

FontKey FontKey 字体key

GameResult GameResult 游戏结局

ImageKey ImageKey 图片编号

Int Int 整型

InteractBtnID InteractBtnID 交互按钮编号

InteractBtnType InteractBtnType 交互按钮类型

JointAssistant JointAssistant 关节

JointAssistantKey JointAssistantKey 关节预设编号

JointAssistantType JointAssistantType 关节类型

LevelKey LevelKey 关卡编号

LifeEntity LifeEntity 生命体

LifeEntityKey LifeEntityKey 生命体编号

ListAIBasicCommand ListAIBasicCommand AI基础命令类型列表

ListAbility ListAbility 技能列表

ListAbilityIndex ListAbilityIndex 技能槽位(内部)列表

ListAbilityKey ListAbilityKey 技能编号列表

ListAbilityPointerType ListAbilityPointerType 技能指示器类型列表

ListAbilitySlot ListAbilitySlot 技能槽位列表

ListAchievement ListAchievement 自定义成就列表

ListActor ListActor Actor列表

ListAnimKey ListAnimKey 动画编号列表

ListArchive ListArchive 自定义存档列表

ListArchiveType ListArchiveType 存档类型列表

ListBattleShopKey ListBattleShopKey 商店列表

ListBindType ListBindType 绑定类型列表

ListBool ListBool 布尔值列表

ListBuffState ListBuffState 状态列表

ListCameraBindMode ListCameraBindMode 相机绑定模式列表

ListCameraProjectionType ListCameraProjectionType 相机投影类型列表

ListCameraPropertyType ListCameraPropertyType 相机属性预设列表

ListCameraShakeType ListCameraShakeType 屏幕震动类型列表

ListCamp ListCamp 阵营列表

ListCampID ListCampID 阵营ID列表

ListCampRelationType ListCampRelationType 阵营关系类型列表

ListCharacter ListCharacter 角色列表

ListCharacterID ListCharacterID 角色ID列表

ListCharacterKey ListCharacterKey 角色编号列表

ListCollisionLimitType ListCollisionLimitType 碰撞限制枚举列表

ListColor ListColor 颜色列表

ListConfigTable ListConfigTable 多维表列表

ListCreature ListCreature 生物列表

ListCreatureID ListCreatureID 生物ID列表

ListCreatureKey ListCreatureKey 生物编号列表

ListCustomTriggerSpace ListCustomTriggerSpace 触发区域列表

ListCustomTriggerSpaceID ListCustomTriggerSpaceID 触发区域ID列表

ListCustomTriggerSpaceKey ListCustomTriggerSpaceKey 触发区域编号列表

ListDamageSchema ListDamageSchema 伤害方案列表

ListDecoration ListDecoration 装饰物列表

ListDecorationKey ListDecorationKey 装饰物编号列表

ListDirectionType ListDirectionType 方向枚举列表

ListE3DLayer ListE3DLayer 场景UI实例列表

ListE3DLayerKey ListE3DLayerKey 场景UI预设列表

ListEBagSlot ListEBagSlot UI物品槽位节点列表

ListEButton ListEButton UI按钮节点列表

ListECanvas ListECanvas UI画布节点列表

ListEEffectNode ListEEffectNode UI动效节点列表

ListEImage ListEImage UI图片节点列表

ListEInputField ListEInputField UI输入节点列表

ListELabel ListELabel UI文本节点列表

ListENode ListENode UI节点列表

ListEProgressbar ListEProgressbar UI进度条节点列表

ListEmojiKey ListEmojiKey 气泡表情编号列表

ListEquipment ListEquipment 物品列表

ListEquipmentID ListEquipmentID 物品ID列表

ListEquipmentKey ListEquipmentKey 物品编号列表

ListEquipmentSlot ListEquipmentSlot 物品槽位列表

ListEquipmentSlotType ListEquipmentSlotType 物品槽位类型列表

ListEquipmentType ListEquipmentType 物品类型列表

ListFaceExpressionKey ListFaceExpressionKey 面部表情编号列表

ListFashionKey ListFashionKey 时装编号列表

ListFixed ListFixed 定点数列表

ListFontKey ListFontKey 字体key列表

ListGameResult ListGameResult 游戏结局列表

ListImageKey ListImageKey 图片编号列表

ListInt ListInt 整型列表

ListInteractBtnID ListInteractBtnID 交互按钮编号列表

ListInteractBtnType ListInteractBtnType 交互按钮类型列表

ListJointAssistant ListJointAssistant 关节列表

ListJointAssistantKey ListJointAssistantKey 关节预设编号列表

ListJointAssistantType ListJointAssistantType 关节类型列表

ListLevelKey ListLevelKey 关卡编号列表

ListLifeEntity ListLifeEntity 生命体列表

ListLifeEntityKey ListLifeEntityKey 生命体编号列表

ListModelSocket ListModelSocket 部位列表

ListModifier ListModifier 效果列表

ListModifierKey ListModifierKey 效果编号列表

ListMontageKey ListMontageKey 剧情动画编号列表

ListMoveMode ListMoveMode AI移动模式列表

ListObstacle ListObstacle 组件列表

ListObstacleID ListObstacleID 组件ID列表

ListObstacleKey ListObstacleKey 组件编号列表

ListPaintArea ListPaintArea 染色区域列表

ListPathID ListPathID 路径ID列表

ListPathPointID ListPathPointID 路点ID列表

ListPatrolType ListPatrolType AI巡逻类型列表

ListQuaternion ListQuaternion 四元数列表

ListRigidBodyType ListRigidBodyType 物理类型列表

ListRole ListRole 玩家列表

ListRoleID ListRoleID 玩家ID列表

ListSfxID ListSfxID 特效ID列表

ListSfxKey ListSfxKey 特效编号列表

ListSkyBoxBackground ListSkyBoxBackground 天空盒背景列表

ListSkyBoxGradualType ListSkyBoxGradualType 天空盒渐变类型列表

ListSoundID ListSoundID 音效ID列表

ListSoundKey ListSoundKey 音效编号列表

ListStr ListStr 字符串列表

ListTimer ListTimer 计时器列表

ListTimestamp ListTimestamp 时间戳列表

ListTrigger ListTrigger 触发器列表

ListTriggerSpace ListTriggerSpace 逻辑体列表

ListTriggerSpaceEventType ListTriggerSpaceEventType 触发区域类型列表

ListTriggerSpaceID ListTriggerSpaceID 逻辑体ID列表

ListTriggerSpaceKey ListTriggerSpaceKey 逻辑体编号列表

ListUgcCommodity ListUgcCommodity 道具列表

ListUgcGoods ListUgcGoods 商品列表

ListUnit ListUnit 单位列表

ListUnitGroup ListUnitGroup 物理组件组列表

ListUnitGroupKey ListUnitGroupKey 组件组编号列表

ListUnitID ListUnitID 单位ID列表

ListUnitKey ListUnitKey 单位编号列表

ListUnitType ListUnitType 单位类型列表

ListValueType ListValueType 值类型列表

ListVector3 ListVector3 向量列表

ListWindFieldShapeType ListWindFieldShapeType 风场形状列表

ModelSocket ModelSocket 部位

Modifier Modifier 效果

ModifierKey ModifierKey 效果编号

MontageKey MontageKey 剧情动画编号

MoveMode MoveMode AI移动模式

Obstacle Obstacle 组件

ObstacleID ObstacleID 组件ID

ObstacleKey ObstacleKey 组件编号

PaintArea PaintArea 染色区域

PathID PathID 路径ID

PathPointID PathPointID 路点ID

PatrolType PatrolType AI巡逻类型

Quaternion Quaternion 四元数

RigidBodyType RigidBodyType 物理类型

Role Role 玩家

RoleID RoleID 玩家ID

SfxID SfxID 特效ID

SfxKey SfxKey 特效编号

SkyBoxBackground SkyBoxBackground 天空盒背景

SkyBoxGradualType SkyBoxGradualType 天空盒渐变类型

SoundID SoundID 音效ID

SoundKey SoundKey 音效编号

Str Str 字符串

Timer Timer 计时器

Timestamp Timestamp 时间戳

Trigger Trigger 触发器

TriggerSpace TriggerSpace 逻辑体

TriggerSpaceEventType TriggerSpaceEventType 触发区域类型

TriggerSpaceID TriggerSpaceID 逻辑体ID

TriggerSpaceKey TriggerSpaceKey 逻辑体编号

UgcCommodity UgcCommodity 道具

UgcGoods UgcGoods 商品

Unit Unit 单位

UnitGroup UnitGroup 物理组件组

UnitGroupKey UnitGroupKey 组件组编号

UnitID UnitID 单位ID

UnitKey UnitKey 单位编号

UnitType UnitType 单位类型

ValueType ValueType 值类型

Vector3 Vector3 向量

WindFieldShapeType WindFieldShapeType 风场形状

### ArchiveType 存档类型

Bool Bool 布尔值

ConfigTable ConfigTable 多维表

Fixed Fixed 定点数

Int Int 整型

Str Str 字符串

Timestamp Timestamp 时间戳

### JointAssistantKey 关节预设编号

SPRING 3400000 SPRING

ROPE 3400001 ROPE

SLIDER 3400002 SLIDER

HINGE 3400003 HINGE

BALL\_SOCKET 3400004 BALL\_SOCKET

D6 3400005 D6

FIXED 3400006 FIXED

### BindType 绑定类型

BIND\_TYPE\_DEFAULT 0 BIND\_TYPE\_DEFAULT

BIND\_TYPE\_TRANSLATE 1 BIND\_TYPE\_TRANSLATE

BIND\_TYPE\_ROTATE 2 BIND\_TYPE\_ROTATE

BIND\_TYPE\_TRANSLATE\_ROTATE 3 BIND\_TYPE\_TRANSLATE\_ROTATE

BIND\_TYPE\_SCALE 4 BIND\_TYPE\_SCALE

BIND\_TYPE\_TRANSLATE\_SCALE 5 BIND\_TYPE\_TRANSLATE\_SCALE

BIND\_TYPE\_ROTATE\_SCALE 6 BIND\_TYPE\_ROTATE\_SCALE

BIND\_TYPE\_ALL 7 BIND\_TYPE\_ALL

### ModelSocket 部位

socket\_abdomen socket\_abdomen 腹部

socket\_belly socket\_belly 鱼腹

socket\_body socket\_body 身体

socket\_calf\_l socket\_calf\_l 左小腿

socket\_calf\_r socket\_calf\_r 右小腿

socket\_chest socket\_chest 胸部

socket\_claw\_l socket\_claw\_l 左钳

socket\_claw\_r socket\_claw\_r 右钳

socket\_eye\_l socket\_eye\_l 左眼

socket\_eye\_r socket\_eye\_r 右眼

socket\_fin\_back socket\_fin\_back 背后鳍

socket\_fin\_dorsal socket\_fin\_dorsal 背鳍

socket\_fin\_l socket\_fin\_l 左鳍

socket\_fin\_lb socket\_fin\_lb 左后鳍

socket\_fin\_r socket\_fin\_r 右鳍

socket\_fin\_rb socket\_fin\_rb 右后鳍

socket\_fin\_tail socket\_fin\_tail 尾鳍

socket\_fin\_ventral socket\_fin\_ventral 腹鳍

socket\_fin\_ventral\_l socket\_fin\_ventral\_l 左腹鳍

socket\_fin\_ventral\_r socket\_fin\_ventral\_r 右腹鳍

socket\_foot\_l socket\_foot\_l 左脚

socket\_foot\_lb socket\_foot\_lb 左后脚

socket\_foot\_lf socket\_foot\_lf 左前脚

socket\_foot\_lm socket\_foot\_lm 左中脚

socket\_foot\_r socket\_foot\_r 右脚

socket\_foot\_rb socket\_foot\_rb 右后脚

socket\_foot\_rf socket\_foot\_rf 右前脚

socket\_foot\_rm socket\_foot\_rm 右中脚

socket\_forearm\_l socket\_forearm\_l 左臂

socket\_forearm\_r socket\_forearm\_r 右臂

socket\_hand\_l socket\_hand\_l 左手

socket\_hand\_r socket\_hand\_r 右手

socket\_head socket\_head 头部

socket\_lowerarm\_l socket\_lowerarm\_l 左小臂

socket\_lowerarm\_r socket\_lowerarm\_r 右小臂

socket\_lowerlimb\_lb socket\_lowerlimb\_lb 左后下肢

socket\_lowerlimb\_lf socket\_lowerlimb\_lf 左前下肢

socket\_lowerlimb\_rb socket\_lowerlimb\_rb 右后下肢

socket\_lowerlimb\_rf socket\_lowerlimb\_rf 右前下肢

socket\_mouth socket\_mouth 鱼嘴

socket\_origin socket\_origin 底面中心点

socket\_tail socket\_tail 尾巴

socket\_tail\_end socket\_tail\_end 尾巴末端

socket\_thigh\_l socket\_thigh\_l 左大腿

socket\_thigh\_r socket\_thigh\_r 右大腿

socket\_torso\_b socket\_torso\_b 躯干后部

socket\_torso\_f socket\_torso\_f 躯干前部

socket\_upperarm\_l socket\_upperarm\_l 左大臂

socket\_upperarm\_r socket\_upperarm\_r 右大臂

socket\_upperlimb\_lb socket\_upperlimb\_lb 左后上肢

socket\_upperlimb\_lf socket\_upperlimb\_lf 左前上肢

socket\_upperlimb\_rb socket\_upperlimb\_rb 右后上肢

socket\_upperlimb\_rf socket\_upperlimb\_rf 右前上肢

socket\_weapon\_l socket\_weapon\_l 左手武器

socket\_weapon\_r socket\_weapon\_r 右手武器

### SkyBoxGradualType 天空盒渐变类型

NORMAL 0 无过渡

GRADUAL\_CHANGE 1 渐变

FAULT\_STYLE 2 故障风格

BURN\_STYLE 3 燃效效果

### CameraProjectionType 相机投影类型

PERSPECTIVE 0 透视

ORTHOGRAPHIC 1 正交

### ColorPaintAreaType 染色区域

AREA\_1 1 染色区域1

AREA\_2 2 染色区域2

AREA\_3 3 染色区域3

AREA\_4 4 染色区域4

### DirectionType 方向枚举

FORWARD 3 前

BACK 4 后

UP 5 上

DOWN 6 下

LEFT 7 左

RIGHT 8 右

### CollisionLimitType 碰撞限制枚举

SELF\_COUNT 1 自身触发次数

SELF\_INTERVAL 2 自身触发间隔

SAME\_UNIT\_COUNT 3 同目标触发次数

SAME\_UNIT\_INTERVAL 4 同目标触发间隔

## LuaAPI

### LuaAPI.call\_delay\_frame

延迟调用函数（按帧数）

LuaAPI.call\_delay\_frame(\_interval, \_callback)

参数 \_interval Int 间隔帧数 参数 \_callback Function 回调

### LuaAPI.call\_delay\_time

延迟调用函数（按时间）

LuaAPI.call\_delay\_time(\_interval, \_callback)

参数 \_interval Fixed 间隔时间（秒） 参数 \_callback Function 回调

### LuaAPI.dispatch\_flush

执行所有已添加并行任务

LuaAPI.dispatch\_flush()

### LuaAPI.dispatch\_init

初始化并行数

LuaAPI.dispatch\_init(\_count)

参数 \_count Int 并行数

### LuaAPI.dispatch\_queue

添加并行任务

LuaAPI.dispatch\_queue(\_i, \_name, \_args)

参数 \_i Int 线程ID 参数 \_name Str 函数名 参数 \_args Dict 参数

返回类型 Int 任务ID

### LuaAPI.enable\_developer\_mode

启用开发者模式

LuaAPI.enable\_developer\_mode()

返回类型 Bool 是否启用成功

### LuaAPI.enable\_error\_interruption\_mode

启用错误中断模式

LuaAPI.enable\_error\_interruption\_mode(\_enable)

参数 \_enable Bool 是否启用

### LuaAPI.get\_component\_list

获取子部件列表（慢）

LuaAPI.get\_component\_list(\_obj)

参数 \_obj Unit 单位

返回类型 ListStr 组件名称列表

### LuaAPI.get\_current\_unit

获取当前单位

LuaAPI.get\_current\_unit()

返回类型 Unit 当前单位

### LuaAPI.get\_dispatch\_count

获取并行数

LuaAPI.get\_dispatch\_count()

返回类型 Int 并行数

### LuaAPI.get\_global\_var

获取全局变量

LuaAPI.get\_global\_var(\_var\_name)

参数 \_var\_name Str 变量名

返回类型 ETypeMeta 变量

### LuaAPI.get\_unit\_id

获得单位的ID

LuaAPI.get\_unit\_id(\_unit)

参数 \_unit Unit 单位

返回类型 Int 单位ID

### LuaAPI.get\_value\_type

获取变量类型

LuaAPI.get\_value\_type(\_value)

参数 \_value ETypeMeta 变量

返回类型 Str 类型

### LuaAPI.global\_register\_custom\_event

注册全局自定义事件监听

LuaAPI.global\_register\_custom\_event(\_event\_name, \_callback)

参数 \_event\_name Str 自定义事件名 参数 \_callback Function 回调

返回类型 Int 注册ID

### LuaAPI.global\_register\_trigger\_event

注册全局触发器

LuaAPI.global\_register\_trigger\_event(\_event\_desc, \_callback)

参数 \_event\_desc List 事件名及注册参数 参数 \_callback Function 回调

返回类型 Int 注册ID

### LuaAPI.global\_send\_custom\_event

发送全局自定义事件

LuaAPI.global\_send\_custom\_event(\_event\_name, \_data)

参数 \_event\_name Str 自定义事件名 参数 \_data Dict 附带参数

### LuaAPI.global\_unregister\_custom\_event

注销全局自定义事件监听

LuaAPI.global\_unregister\_custom\_event(\_id)

参数 \_id Int 注册ID

### LuaAPI.global\_unregister\_trigger\_event

注销全局触发器

LuaAPI.global\_unregister\_trigger\_event(\_id)

参数 \_id Int 注册ID

### LuaAPI.has\_component

是否含有指定子部件

LuaAPI.has\_component(\_object, \_name)

参数 \_object Unit 单位 参数 \_name Str 组件名

返回类型 Bool 是否含有指定子组件

### LuaAPI.log

输出日志

LuaAPI.log(\_content)

参数 \_content Str 日志内容

### LuaAPI.query\_ui\_node

查询UI单位（慢）

LuaAPI.query\_ui\_node(\_name)

参数 \_name Str 名字

返回类型 ENode UI名称

### LuaAPI.query\_ui\_nodes

批量查询UI单位（慢）

LuaAPI.query\_ui\_nodes(\_name\_list)

参数 \_name\_list ListStr 名字列表

返回类型 ListENode UI名称列表

### LuaAPI.query\_unit

查询组件单位（慢）

LuaAPI.query\_unit(\_name)

参数 \_name Str 名字

返回类型 Unit 组件

### LuaAPI.query\_units

批量查询单位（按名称）

LuaAPI.query\_units(\_name\_list)

参数 \_name\_list ListStr 名字列表

返回类型 ListUnit 组件列表

### LuaAPI.query\_units\_by\_type

批量查询单位（按类型、预设）

LuaAPI.query\_units\_by\_type(\_unit\_type, \_unit\_eid)

参数 \_unit\_type UnitType 单位类型 参数 \_unit\_eid Int 预设ID

返回类型 ListUnit 组件

### LuaAPI.rand

生成随机数

LuaAPI.rand()

返回类型 Int 随机数

### LuaAPI.set\_deadloop\_check\_enabled

启用死循环检测

LuaAPI.set\_deadloop\_check\_enabled(\_enable, \_max\_instruction\_count)

参数 \_enable Bool 启用 参数 \_max\_instruction\_count Int 最大指令数限制

返回类型 Bool 是否启用成功

### LuaAPI.set\_tick\_handler

设置Tick回调

LuaAPI.set\_tick\_handler(\_pre\_handler, \_post\_handler)

参数 \_pre\_handler Function 帧前回调 参数 \_post\_handler Function 帧后回调

### LuaAPI.unit\_register\_creation\_handler

注册单位创建回调

LuaAPI.unit\_register\_creation\_handler(\_unit\_type, \_unit\_eid, \_callback)

参数 \_unit\_type UnitType 单位类型 参数 \_unit\_eid Int 预设ID 参数 \_callback Function 回调

### LuaAPI.unit\_register\_custom\_event

注册单位自定义事件监听

LuaAPI.unit\_register\_custom\_event(\_unit, \_event\_name, \_callback)

参数 \_unit Unit 单位 参数 \_event\_name Str 自定义事件名 参数 \_callback Function 回调

返回类型 Int 注册ID

### LuaAPI.unit\_register\_trigger\_event

注册单位触发器

LuaAPI.unit\_register\_trigger\_event(\_unit, \_event\_desc, \_callback)

参数 \_unit Unit 单位 参数 \_event\_desc List 事件名及注册参数 参数 \_callback Function 回调

返回类型 Int 触发器ID

### LuaAPI.unit\_send\_custom\_event

发送单位自定义事件

LuaAPI.unit\_send\_custom\_event(\_unit, \_event\_name, \_data)

参数 \_unit Unit 单位 参数 \_event\_name Str 自定义事件名 参数 \_data Dict 附带参数

### LuaAPI.unit\_unregister\_creation\_handler

注销单位创建回调

LuaAPI.unit\_unregister\_creation\_handler(\_unit\_type, \_unit\_eid)

参数 \_unit\_type UnitType 单位类型 参数 \_unit\_eid Int 预设ID

### LuaAPI.unit\_unregister\_custom\_event

注销单位自定义事件监听

LuaAPI.unit\_unregister\_custom\_event(\_unit, \_id)

参数 \_unit Unit 单位 参数 \_id Int 注册ID

### LuaAPI.unit\_unregister\_trigger\_event

注销单位触发器

LuaAPI.unit\_unregister\_trigger\_event(\_unit, \_id)

参数 \_unit Unit 单位 参数 \_id Int 注册ID

## GlobalAPI

### GlobalAPI.add\_kill\_broadcast

添加击杀播报

GlobalAPI.add\_kill\_broadcast(\_kill\_char, \_dead\_char, \_duration)

参数 \_kill\_char Character 击杀角色 参数 \_dead\_char Character 死亡角色 参数 \_duration Fixed 持续时间

### GlobalAPI.debug

Debug窗口打印日志

GlobalAPI.debug(\_content)

参数 \_content Str 内容

### GlobalAPI.destroy\_sfx

销毁特效

GlobalAPI.destroy\_sfx(\_sfx\_id, \_fade\_out)

参数 \_sfx\_id SfxID 特效ID 参数 \_fade\_out Bool 是否淡出

### GlobalAPI.error

Debug窗口打印错误日志

GlobalAPI.error(\_content)

参数 \_content Str 内容

### GlobalAPI.get\_vector\_projection

获取向量投影

GlobalAPI.get\_vector\_projection(\_vec, \_direction)

参数 \_vec Vector3 向量 参数 \_direction Vector3 投影方向

返回类型 Vector3 投影后向量

### GlobalAPI.is\_none

判断对象是否为空

GlobalAPI.is\_none(\_obj)

参数 \_obj Unit 对象

返回类型 Bool 是否为空

### GlobalAPI.is\_not\_none

判断对象是否为空

GlobalAPI.is\_not\_none(\_obj)

参数 \_obj Unit 对象

返回类型 Bool 是否不为空

### GlobalAPI.mute\_sfx\_sound

去除特效的音效

GlobalAPI.mute\_sfx\_sound(\_sfx\_id)

参数 \_sfx\_id SfxID 特效ID

### GlobalAPI.set\_direct\_light

修改直接光参数

GlobalAPI.set\_direct\_light(\_param\_dict, \_duration)

参数 \_param\_dict Dict 切换参数 参数 \_duration Fixed 持续时间

### GlobalAPI.set\_render\_color

改变色彩滤镜

GlobalAPI.set\_render\_color(\_hue, \_brightness, \_saturation, \_contrast, \_amount, \_mid\_tones, \_mid\_tones\_power, \_shadows, \_shadows\_power, \_highlight, \_highlight\_power, \_duration)

参数 \_hue Fixed 色相 参数 \_brightness Fixed 明度 参数 \_saturation Fixed 饱和度 参数 \_contrast Fixed 对比度 参数 \_amount Fixed 整体偏色程度 参数 \_mid\_tones Color 中灰偏色 参数 \_mid\_tones\_power Fixed 中灰偏色程度 参数 \_shadows Color 暗部偏色 参数 \_shadows\_power Fixed 暗部偏色程度 参数 \_highlight Color 亮部偏色 参数 \_highlight\_power Fixed 亮部偏色程度 参数 \_duration Fixed 变换时长

### GlobalAPI.set\_sfx\_orientation

设置特效旋转

GlobalAPI.set\_sfx\_orientation(\_sfx\_id, \_orientation)

参数 \_sfx\_id SfxID 特效ID 参数 \_orientation Quaternion 旋转

### GlobalAPI.set\_sfx\_position

设置特效坐标

GlobalAPI.set\_sfx\_position(\_sfx\_id, \_pos)

参数 \_sfx\_id SfxID 特效ID 参数 \_pos Vector3 位置

### GlobalAPI.set\_sfx\_rate

设置特效播放速率

GlobalAPI.set\_sfx\_rate(\_sfx\_id, \_rate)

参数 \_sfx\_id SfxID 特效ID 参数 \_rate Fixed 播放速率

### GlobalAPI.set\_sfx\_scale

设置特效缩放

GlobalAPI.set\_sfx\_scale(\_sfx\_id, \_scale)

参数 \_sfx\_id SfxID 特效ID 参数 \_scale Vector3 缩放

### GlobalAPI.set\_sfx\_visible

设置特效是否可见

GlobalAPI.set\_sfx\_visible(\_sfx\_id, \_visible)

参数 \_sfx\_id SfxID 特效ID 参数 \_visible Bool 是否可见

### GlobalAPI.set\_skybox\_texture

改变天空盒贴图

GlobalAPI.set\_skybox\_texture(\_texture\_key, \_change\_type, \_duration)

参数 \_texture\_key SkyBoxBackground 天空盒背景 参数 \_change\_type SkyBoxGradualType 切换方式 参数 \_duration Fixed 持续时间

### GlobalAPI.set\_skyfog

改变天空雾效

GlobalAPI.set\_skyfog(\_param\_dict, \_duration)

参数 \_param\_dict Dict 切换参数 参数 \_duration Fixed 变换时长

### GlobalAPI.show\_message\_marquee

跑马灯信息

GlobalAPI.show\_message\_marquee(\_content)

参数 \_content Str 字符串

### GlobalAPI.show\_tips

游戏内飘字信息

GlobalAPI.show\_tips(\_content, \_duration)

参数 \_content Str 字符串 参数 \_duration Fixed 时长

### GlobalAPI.str\_contains

是否含有子字符串

GlobalAPI.str\_contains(\_str1, \_str2)

参数 \_str1 Str 父字符串 参数 \_str2 Str 子字符串

返回类型 Bool 布尔值

### GlobalAPI.str\_to\_color

字符串转颜色

GlobalAPI.str\_to\_color(\_color\_str)

参数 \_color\_str Str 字符串

返回类型 Color 颜色

### GlobalAPI.warning

Debug窗口打印警告日志

GlobalAPI.warning(\_content)

参数 \_content Str 内容

## GameAPI

### GameAPI.ability\_prefab\_get\_desc

获取技能预设描述

GameAPI.ability\_prefab\_get\_desc(\_ability\_id)

参数 \_ability\_id AbilityKey 技能编号

返回类型 Str 技能描述

### GameAPI.ability\_prefab\_get\_name

获取技能预设名称

GameAPI.ability\_prefab\_get\_name(\_ability\_id)

参数 \_ability\_id AbilityKey 技能编号

返回类型 Str 技能名称

### GameAPI.ability\_prefab\_get\_prop\_by\_type

获取技能预设的属性

GameAPI.ability\_prefab\_get\_prop\_by\_type(\_value\_type, \_key, \_prop)

参数 \_value\_type ValueType 值类型 参数 \_key AbilityKey 技能编号 参数 \_prop Str 名称

返回类型 ETypeMeta 属性值

### GameAPI.ability\_prefab\_has\_kv

技能预设是否存在自定义值

GameAPI.ability\_prefab\_has\_kv(\_ability\_key, \_prop)

参数 \_ability\_key AbilityKey 技能编号 参数 \_prop Str 名称

返回类型 Bool 是否存在

### GameAPI.add\_pathpoint

新增路点

GameAPI.add\_pathpoint(\_path\_id, \_index, \_point\_id)

参数 \_path\_id PathID 路径 参数 \_index Int 路点索引 参数 \_point\_id PathPointID 路点

### GameAPI.create\_constant\_wind\_field

创建一个固定风场单位

GameAPI.create\_constant\_wind\_field(\_pos, \_wind\_type, \_wind\_range, \_duration)

参数 \_pos Point3 位置 参数 \_wind\_type WindFieldShapeType 形状 参数 \_wind\_range Fixed 范围 参数 \_duration Fixed 持续时间

### GameAPI.create\_creature\_fixed\_scale

创建一个生物

GameAPI.create\_creature\_fixed\_scale(\_u\_key, \_pos, \_rotation, \_scale\_ratio, \_role)

参数 \_u\_key UnitKey 单位编号 参数 \_pos Point3 位置 参数 \_rotation Quaternion 旋转 参数 \_scale\_ratio Fixed 缩放大小 参数 \_role Role 所属玩家

返回类型 Creature 创建出的生物

### GameAPI.create\_customtriggerspace

创建一个触发区域

GameAPI.create\_customtriggerspace(\_u\_key, \_pos, \_rotation, \_scale, \_role)

参数 \_u\_key CustomTriggerSpaceKey 触发区域编号 参数 \_pos Vector3 位置 参数 \_rotation Quaternion 旋转 参数 \_scale Vector3 缩放 参数 \_role Role 所属玩家

返回类型 CustomTriggerSpace 创建出的触发区域

### GameAPI.create\_decoration

创建一个装饰物

GameAPI.create\_decoration(\_u\_key, \_pos, \_rotation, \_scale, \_parent)

参数 \_u\_key DecorationKey 单位编号 参数 \_pos Vector3 位置 参数 \_rotation Quaternion 旋转 参数 \_scale Vector3 缩放 参数 \_parent Unit 绑定对象

返回类型 Decoration 创建的装饰物

### GameAPI.create\_equipment

创建物品到坐标点

GameAPI.create\_equipment(\_equipment\_eid, \_pos)

参数 \_equipment\_eid EquipmentKey 物品编号 参数 \_pos Point3 位置

返回类型 Equipment 物品

### GameAPI.create\_joint\_assistant

创建关节助手

GameAPI.create\_joint\_assistant(\_unit\_key, \_unit1, \_unit2)

参数 \_unit\_key JointAssistantKey 关节助手类型 参数 \_unit1 Unit 连接主体 参数 \_unit2 Unit 连接目标

返回类型 JointAssistant 创建出的关节助手

### GameAPI.create\_life\_entity

创建一个生命体

GameAPI.create\_life\_entity(\_unit\_key, \_pos, \_rotation, \_scale\_ratio, \_role)

参数 \_unit\_key UnitKey 单位编号 参数 \_pos Point3 位置 参数 \_rotation Quaternion 旋转 参数 \_scale\_ratio Fixed 缩放大小 参数 \_role Role 所属玩家

返回类型 LifeEntity 创建出的生命体

### GameAPI.create\_obstacle

创建一个组件

GameAPI.create\_obstacle(\_u\_key, \_pos, \_rotation, \_scale, \_role)

参数 \_u\_key UnitKey 组件编号 参数 \_pos Vector3 位置 参数 \_rotation Quaternion 旋转 参数 \_scale Vector3 缩放 参数 \_role Role 所属玩家

返回类型 Obstacle 创建的组件

### GameAPI.create\_scene\_ui\_at\_point

创建场景界面到坐标点

GameAPI.create\_scene\_ui\_at\_point(\_layer\_key, \_pos, \_duration)

参数 \_layer\_key E3DLayerKey 场景界面预设编号 参数 \_pos Point3 坐标点 参数 \_duration Fixed 持续事件

返回类型 E3DLayer 场景界面

### GameAPI.create\_sfx\_with\_socket

播放特效并绑定

GameAPI.create\_sfx\_with\_socket(\_sfx\_key, \_unit, \_socket\_name, \_scale, \_duration, \_bind\_type)

参数 \_sfx\_key SfxKey 特效编号 参数 \_unit Unit 起点单位 参数 \_socket\_name ModelSocket 起点节点 参数 \_scale Fixed 缩放 参数 \_duration Fixed 持续时间 参数 \_bind\_type BindType 绑定方式

返回类型 SfxID 特效ID

### GameAPI.create\_sfx\_with\_socket\_offset

播放特效并绑定

GameAPI.create\_sfx\_with\_socket\_offset(\_sfx\_key, \_unit, \_socket\_name, \_offset, \_rot, \_scale, \_duration, \_bind\_type)

参数 \_sfx\_key SfxKey 特效编号 参数 \_unit Unit 起点单位 参数 \_socket\_name ModelSocket 起点节点 参数 \_offset Vector3 偏移 参数 \_rot Quaternion 旋转 参数 \_scale Fixed 缩放 参数 \_duration Fixed 持续时间 参数 \_bind\_type BindType 绑定方式

返回类型 SfxID 特效ID

### GameAPI.create\_triggerspace

创建一个逻辑体

GameAPI.create\_triggerspace(\_u\_key, \_pos, \_rotation, \_scale, \_role)

参数 \_u\_key TriggerSpaceKey 逻辑体编号 参数 \_pos Vector3 位置 参数 \_rotation Quaternion 旋转 参数 \_scale Vector3 缩放 参数 \_role Role 所属玩家

返回类型 TriggerSpace 创建的逻辑体

### GameAPI.create\_unit\_group

创建一个组件组

GameAPI.create\_unit\_group(\_unit\_group\_id, \_pos, \_root\_quaternion, \_role)

参数 \_unit\_group\_id UnitGroupKey 单位编号 参数 \_pos Point3 位置 参数 \_root\_quaternion Quaternion 旋转 参数 \_role Role 所属玩家

返回类型 UnitGroup 创建出的单位

### GameAPI.create\_unit\_with\_scale

创建缩放单位

GameAPI.create\_unit\_with\_scale(\_u\_key, \_pos, \_rotation, \_scale)

参数 \_u\_key UnitKey 单位编号 参数 \_pos Point3 位置 参数 \_rotation Quaternion 旋转 参数 \_scale Vector3 缩放

返回类型 Unit 创建出的单位

### GameAPI.creature\_prefab\_get\_kv\_by\_type

获取生物预设的自定义值

GameAPI.creature\_prefab\_get\_kv\_by\_type(\_value\_type, \_key, \_prop)

参数 \_value\_type ValueType 值类型 参数 \_key CreatureKey 生物编号 参数 \_prop Str 名称

返回类型 ETypeMeta 自定义值

### GameAPI.creature\_prefab\_get\_prop\_by\_type

获取生物预设的属性

GameAPI.creature\_prefab\_get\_prop\_by\_type(\_value\_type, \_key, \_prop)

参数 \_value\_type ValueType 值类型 参数 \_key CreatureKey 生物编号 参数 \_prop Str 名称

返回类型 ETypeMeta 属性值

### GameAPI.creature\_prefab\_has\_kv

生物预设是否存在自定义值

GameAPI.creature\_prefab\_has\_kv(\_unit\_key, \_prop)

参数 \_unit\_key CreatureKey 生物编号 参数 \_prop Str 名称

返回类型 Bool 是否存在

### GameAPI.customtriggerspace\_prefab\_get\_kv\_by\_type

获取触发区域预设的自定义值

GameAPI.customtriggerspace\_prefab\_get\_kv\_by\_type(\_value\_type, \_key, \_prop)

参数 \_value\_type ValueType 值类型 参数 \_key CustomTriggerSpaceKey 逻辑体编号 参数 \_prop Str 名称

返回类型 ETypeMeta 自定义值

### GameAPI.customtriggerspace\_prefab\_get\_prop\_by\_type

获取触发区域预设的属性

GameAPI.customtriggerspace\_prefab\_get\_prop\_by\_type(\_value\_type, \_key, \_prop)

参数 \_value\_type ValueType 值类型 参数 \_key CustomTriggerSpaceKey 逻辑体编号 参数 \_prop Str 名称

返回类型 ETypeMeta 属性值

### GameAPI.customtriggerspace\_prefab\_has\_kv

触发区域预设是否存在自定义值

GameAPI.customtriggerspace\_prefab\_has\_kv(\_key, \_prop)

参数 \_key CustomTriggerSpaceKey 触发区域编号 参数 \_prop Str 名称

返回类型 Bool 是否存在

### GameAPI.deal\_damage

造成伤害

GameAPI.deal\_damage(\_dst, \_dmg, \_src, \_schema, \_data)

参数 \_dst LifeEntity 目标单位 参数 \_dmg Fixed 伤害 参数 \_src Unit 伤害来源 参数 \_schema DamageSchema 伤害类型 参数 \_data Dict 参数

### GameAPI.destroy\_scene\_ui

销毁场景界面

GameAPI.destroy\_scene\_ui(\_layer)

参数 \_layer E3DLayer 场景界面

### GameAPI.destroy\_unit

删除单位

GameAPI.destroy\_unit(\_unit)

参数 \_unit Unit 单位

### GameAPI.destroy\_unit\_with\_children

销毁单位

GameAPI.destroy\_unit\_with\_children(\_unit, \_destroy\_children)

参数 \_unit Unit 单位 参数 \_destroy\_children Bool 是否销毁子组件

### GameAPI.enable\_collision\_between\_unit\_and\_prefab

设置单位与预设是否能发生碰撞

GameAPI.enable\_collision\_between\_unit\_and\_prefab(\_unit, \_unit\_eid, \_enable)

参数 \_unit Unit 单位 参数 \_unit\_eid UnitKey 单位编号 参数 \_enable Bool 是否碰撞

### GameAPI.enable\_collision\_between\_units

设置两个单位是否能碰撞

GameAPI.enable\_collision\_between\_units(\_unit\_1, \_unit\_2, \_enable)

参数 \_unit\_1 Unit 单位1 参数 \_unit\_2 Unit 单位2 参数 \_enable Bool 是否碰撞

### GameAPI.equipment\_prefab\_has\_kv

物品预设是否存在自定义值

GameAPI.equipment\_prefab\_has\_kv(\_equipment\_key, \_prop)

参数 \_equipment\_key EquipmentKey 物品编号 参数 \_prop Str 名称

返回类型 Bool 是否存在

### GameAPI.game\_end

游戏结束

GameAPI.game\_end()

### GameAPI.get\_achievement\_target

获取成就目标进度

GameAPI.get\_achievement\_target(\_event\_id)

参数 \_event\_id Achievement 成就

返回类型 Int 成就进度

### GameAPI.get\_all\_camps

获取所有阵营

GameAPI.get\_all\_camps()

返回类型 ListCamp 阵营列表

### GameAPI.get\_all\_equipment\_keys\_in\_shop

获取物品商店中的所有物品编号

GameAPI.get\_all\_equipment\_keys\_in\_shop(\_battle\_shop\_key)

参数 \_battle\_shop\_key BattleShopKey 物品商店编号

返回类型 ListEquipmentKey 物品编号列表

### GameAPI.get\_all\_online\_roles

获取所有在线玩家

GameAPI.get\_all\_online\_roles()

返回类型 ListRole 玩家列表

### GameAPI.get\_all\_roles

获取所有玩家

GameAPI.get\_all\_roles()

返回类型 ListRole 玩家

### GameAPI.get\_all\_valid\_roles

获取游戏中所有有效玩家

GameAPI.get\_all\_valid\_roles()

返回类型 ListRole 玩家列表

### GameAPI.get\_camp

获取阵营

GameAPI.get\_camp(\_camp\_id)

参数 \_camp\_id CampID 阵营ID

返回类型 Camp 阵营

### GameAPI.get\_camp\_relation

获取阵营关系

GameAPI.get\_camp\_relation(\_camp1, \_camp2)

参数 \_camp1 Camp 阵营 参数 \_camp2 Camp 阵营

返回类型 CampRelationType 阵营关系

### GameAPI.get\_characters\_in\_aabb

获取矩形区域内的角色

GameAPI.get\_characters\_in\_aabb(\_center, \_length, \_height, \_width)

参数 \_center Point3 中心点 参数 \_length Fixed 长 参数 \_height Fixed 高 参数 \_width Fixed 宽

返回类型 ListCharacter 角色列表

### GameAPI.get\_characters\_in\_cylinder

获取圆柱区域内的角色

GameAPI.get\_characters\_in\_cylinder(\_bottom\_center, \_radius, \_height)

参数 \_bottom\_center Point3 底部中心 参数 \_radius Fixed 半径 参数 \_height Fixed 高度

返回类型 ListCharacter 角色列表

### GameAPI.get\_characters\_in\_sphere

获取圆形区域内的角色

GameAPI.get\_characters\_in\_sphere(\_center, \_radius)

参数 \_center Point3 中心点 参数 \_radius Fixed 半径

返回类型 ListCharacter 角色列表

### GameAPI.get\_creatures\_by\_key

获取指定编号的逻辑体列表

GameAPI.get\_creatures\_by\_key(\_creature\_key)

参数 \_creature\_key CreatureKey 生物编号

返回类型 ListCreature 生物列表

### GameAPI.get\_creatures\_in\_aabb

获取矩形区域内的生物

GameAPI.get\_creatures\_in\_aabb(\_center, \_length, \_height, \_width)

参数 \_center Point3 中心点 参数 \_length Fixed 长 参数 \_height Fixed 高 参数 \_width Fixed 宽

返回类型 ListCreature 角色列表

### GameAPI.get\_creatures\_in\_annulus

获取圆环区域内的生物

GameAPI.get\_creatures\_in\_annulus(\_center, \_radius1, \_radius2, \_height)

参数 \_center Point3 中心点 参数 \_radius1 Fixed 内径 参数 \_radius2 Fixed 外径 参数 \_height Fixed 高度

返回类型 ListCreature 生物列表

### GameAPI.get\_creatures\_in\_cylinder

获取圆柱区域内的生物

GameAPI.get\_creatures\_in\_cylinder(\_bottom\_center, \_radius, \_height)

参数 \_bottom\_center Point3 底部中心 参数 \_radius Fixed 半径 参数 \_height Fixed 高度

返回类型 ListCreature 生物列表

### GameAPI.get\_creatures\_in\_sector

获取扇形区域内的生物

GameAPI.get\_creatures\_in\_sector(\_center, \_face\_dir, \_central\_angle, \_radius, \_height)

参数 \_center Point3 起始点 参数 \_face\_dir Fixed 角度朝向 参数 \_central\_angle Fixed 广角 参数 \_radius Fixed 半径 参数 \_height Fixed 高度

返回类型 ListCreature 生物列表

### GameAPI.get\_creatures\_in\_sphere

获取圆形区域内的生物

GameAPI.get\_creatures\_in\_sphere(\_center, \_radius)

参数 \_center Point3 中心点 参数 \_radius Fixed 半径

返回类型 ListCreature 生物列表

### GameAPI.get\_customtriggerspaces\_by\_key

获取指定预设的触发区域列表

GameAPI.get\_customtriggerspaces\_by\_key(\_key)

参数 \_key CustomTriggerSpaceKey 触发区域编号

返回类型 ListCustomTriggerSpace 触发区域列表

### GameAPI.get\_customtriggerspaces\_in\_raycast

获取射线检测到的触发区域列表

GameAPI.get\_customtriggerspaces\_in\_raycast(\_start\_pos, \_end\_pos)

参数 \_start\_pos Point3 起始点 参数 \_end\_pos Point3 终点

返回类型 ListCustomTriggerSpace 触发区域列表

### GameAPI.get\_day

获取时间戳转化后的日期数

GameAPI.get\_day(\_timestamp)

参数 \_timestamp Timestamp 时间戳

返回类型 Int 日

### GameAPI.get\_env\_time

获取环境时间

GameAPI.get\_env\_time()

返回类型 Fixed 当前环境时刻

### GameAPI.get\_env\_time\_ratio

获取环境时间流逝速率

GameAPI.get\_env\_time\_ratio()

返回类型 Fixed 流逝速率

### GameAPI.get\_env\_time\_running\_enabled

获取环境时间是否自动流逝

GameAPI.get\_env\_time\_running\_enabled()

返回类型 Bool 是否自动流逝

### GameAPI.get\_eui\_child\_by\_index

根据索引获取UI节点的子UI节点

GameAPI.get\_eui\_child\_by\_index(\_node, \_index)

参数 \_node ENode UI节点 参数 \_index Int 索引

返回类型 ENode 子UI节点

### GameAPI.get\_eui\_child\_by\_name

根据名字获取UI节点的子UI节点

GameAPI.get\_eui\_child\_by\_name(\_node, \_name)

参数 \_node ENode UI节点 参数 \_name Str 名字

返回类型 ENode 子UI节点

### GameAPI.get\_eui\_children

获取UI节点的所有子UI节点

GameAPI.get\_eui\_children(\_node)

参数 \_node ENode UI节点

返回类型 ListENode 子UI节点列表

### GameAPI.get\_eui\_children\_count

获取UI节点的子UI节点数量

GameAPI.get\_eui\_children\_count(\_node)

参数 \_node ENode UI节点

返回类型 Int 数量

### GameAPI.get\_eui\_node\_at\_scene\_ui

获取场景界面中的控件

GameAPI.get\_eui\_node\_at\_scene\_ui(\_layer, \_node\_id)

参数 \_layer E3DLayer 场景界面 参数 \_node\_id ENode 界面节点

返回类型 ENode 场景界面节点

### GameAPI.get\_first\_customtriggerspace\_in\_raycast

获取射线检测到的触发区域

GameAPI.get\_first\_customtriggerspace\_in\_raycast(\_start\_pos, \_end\_pos)

参数 \_start\_pos Point3 起始点 参数 \_end\_pos Point3 终点

返回类型 CustomTriggerSpace 触发区域

### GameAPI.get\_goods\_list

获取付费商品信息列表

GameAPI.get\_goods\_list()

返回类型 List 商品列表

### GameAPI.get\_hour

获取时间戳转化后的小时数

GameAPI.get\_hour(\_timestamp)

参数 \_timestamp Timestamp 时间戳

返回类型 Int 时

### GameAPI.get\_joint\_assistants

获取组件上的所有关节

GameAPI.get\_joint\_assistants(\_unit)

参数 \_unit Unit 目标单位

返回类型 ListJointAssistant 关节列表

### GameAPI.get\_lifeentities\_in\_aabb

获取矩形区域内的生命体

GameAPI.get\_lifeentities\_in\_aabb(\_center, \_length, \_height, \_width)

参数 \_center Point3 中心点 参数 \_length Fixed 长 参数 \_height Fixed 高 参数 \_width Fixed 宽

返回类型 ListLifeEntity 生命体列表

### GameAPI.get\_lifeentities\_in\_cylinder

获取圆柱区域内的生命体

GameAPI.get\_lifeentities\_in\_cylinder(\_bottom\_center, \_radius, \_height)

参数 \_bottom\_center Point3 底部中心 参数 \_radius Fixed 半径 参数 \_height Fixed 高度

返回类型 ListLifeEntity 生命体列表

### GameAPI.get\_lifeentities\_in\_sphere

获取圆形区域内的生命体

GameAPI.get\_lifeentities\_in\_sphere(\_center, \_radius)

参数 \_center Point3 中心点 参数 \_radius Fixed 半径

返回类型 ListLifeEntity 生命体列表

### GameAPI.get\_map\_characters

获取所有地图角色

GameAPI.get\_map\_characters()

返回类型 ListCharacter 角色列表

### GameAPI.get\_map\_rating\_score

获取地图当前评分

GameAPI.get\_map\_rating\_score()

返回类型 Fixed 当前评分

### GameAPI.get\_minute

获取时间戳转化后的分钟数

GameAPI.get\_minute(\_timestamp)

参数 \_timestamp Timestamp 时间戳

返回类型 Int 分

### GameAPI.get\_montage\_duration

获取动画时长

GameAPI.get\_montage\_duration(\_montage\_id)

参数 \_montage\_id MontageKey 剧情动画编号

返回类型 Fixed 时长

### GameAPI.get\_month

获取时间戳转化后的月份数

GameAPI.get\_month(\_timestamp)

参数 \_timestamp Timestamp 时间戳

返回类型 Int 月

### GameAPI.get\_obstacle\_by\_raycast

获取射线检测到的组件

GameAPI.get\_obstacle\_by\_raycast(\_start\_pos, \_end\_pos)

参数 \_start\_pos Point3 起始点 参数 \_end\_pos Point3 终点

返回类型 Obstacle 组件

### GameAPI.get\_obstacles\_by\_key

获取指定编号的组件列表

GameAPI.get\_obstacles\_by\_key(\_key)

参数 \_key ObstacleKey 组件编号

返回类型 ListObstacle 组件列表

### GameAPI.get\_obstacles\_by\_raycast

获取射线检测到的组件列表

GameAPI.get\_obstacles\_by\_raycast(\_start\_pos, \_end\_pos)

参数 \_start\_pos Point3 起始点 参数 \_end\_pos Point3 终点

返回类型 ListObstacle 组件列表

### GameAPI.get\_obstacles\_in\_aabb

获取矩形区域内的组件

GameAPI.get\_obstacles\_in\_aabb(\_center, \_length, \_height, \_width)

参数 \_center Point3 中心点 参数 \_length Fixed 长 参数 \_height Fixed 高 参数 \_width Fixed 宽

返回类型 ListObstacle 角色列表

### GameAPI.get\_obstacles\_in\_annulus

获取圆环区域内的组件

GameAPI.get\_obstacles\_in\_annulus(\_center, \_radius1, \_radius2, \_height)

参数 \_center Point3 中心点 参数 \_radius1 Fixed 内径 参数 \_radius2 Fixed 外径 参数 \_height Fixed 高度

返回类型 ListObstacle 组件列表

### GameAPI.get\_obstacles\_in\_cylinder

获取圆柱区域内的组件

GameAPI.get\_obstacles\_in\_cylinder(\_bottom\_center, \_radius, \_height)

参数 \_bottom\_center Point3 底部中心 参数 \_radius Fixed 半径 参数 \_height Fixed 高度

返回类型 ListObstacle 组件列表

### GameAPI.get\_obstacles\_in\_sector

获取扇形区域内的组件

GameAPI.get\_obstacles\_in\_sector(\_center, \_face\_dir, \_central\_angle, \_radius, \_height)

参数 \_center Point3 起始点 参数 \_face\_dir Fixed 角度朝向 参数 \_central\_angle Fixed 广角 参数 \_radius Fixed 半径 参数 \_height Fixed 高度

返回类型 ListObstacle 组件列表

### GameAPI.get\_obstacles\_in\_sphere

获取圆形区域内的组件

GameAPI.get\_obstacles\_in\_sphere(\_center, \_radius)

参数 \_center Point3 中心点 参数 \_radius Fixed 半径

返回类型 ListObstacle 组件列表

### GameAPI.get\_pathpoint\_by\_id

获取路点坐标

GameAPI.get\_pathpoint\_by\_id(\_point\_id)

参数 \_point\_id PathPointID 路点

返回类型 Point3 坐标

### GameAPI.get\_pathpoint\_by\_index

获取路径中的路点向量

GameAPI.get\_pathpoint\_by\_index(\_path\_id, \_index)

参数 \_path\_id PathID 路径 参数 \_index Int 路点索引

返回类型 Vector3 向量

### GameAPI.get\_role

玩家ID获取玩家

GameAPI.get\_role(\_role\_id)

参数 \_role\_id RoleID 玩家ID

返回类型 Role 玩家

### GameAPI.get\_role\_friendship\_value

获取玩家亲密度

GameAPI.get\_role\_friendship\_value(\_role\_1, \_role\_2)

参数 \_role\_1 Role 玩家1 参数 \_role\_2 Role 玩家2

返回类型 Int 亲密度

### GameAPI.get\_second

获取时间戳转化后的秒数

GameAPI.get\_second(\_timestamp)

参数 \_timestamp Timestamp 时间戳

返回类型 Int 秒

### GameAPI.get\_timestamp

获取当前时间戳

GameAPI.get\_timestamp()

返回类型 Timestamp 时间戳

### GameAPI.get\_timestamp\_by\_time

获取时间戳

GameAPI.get\_timestamp\_by\_time(\_year, \_month, \_day, \_hour, \_minute, \_second)

参数 \_year Int 年 参数 \_month Int 月 参数 \_day Int 日 参数 \_hour Int 时 参数 \_minute Int 分 参数 \_second Int 秒

返回类型 Timestamp 时间戳

### GameAPI.get\_timestamp\_diff

获取时间戳秒差

GameAPI.get\_timestamp\_diff(\_timestamp\_1, \_timestamp\_2)

参数 \_timestamp\_1 Timestamp 时间戳1 参数 \_timestamp\_2 Timestamp 时间戳2

返回类型 Int 秒差

### GameAPI.get\_triggerspaces\_by\_key

获取指定编号的逻辑体列表

GameAPI.get\_triggerspaces\_by\_key(\_key)

参数 \_key TriggerSpaceKey 逻辑体编号

返回类型 ListTriggerSpace 逻辑体列表

### GameAPI.get\_unit

获取单位

GameAPI.get\_unit(\_unit\_id)

参数 \_unit\_id UnitID 单位ID

返回类型 Unit 单位

### GameAPI.get\_unit\_id\_by\_name

获取单位ID

GameAPI.get\_unit\_id\_by\_name(\_name)

参数 \_name Str 单位名称

返回类型 UnitID 单位ID

### GameAPI.get\_vector3s\_from\_path

获取路径向量数组

GameAPI.get\_vector3s\_from\_path(\_path\_id)

参数 \_path\_id PathID 路径

返回类型 ListVector3 向量数组

### GameAPI.get\_weekday

获取时间戳转化后的星期数

GameAPI.get\_weekday(\_timestamp)

参数 \_timestamp Timestamp 时间戳

返回类型 Int 星期

### GameAPI.get\_year

获取时间戳转化后的年数

GameAPI.get\_year(\_timestamp)

参数 \_timestamp Timestamp 时间戳

返回类型 Int 年

### GameAPI.has\_global\_kv

是否有全局变量

GameAPI.has\_global\_kv(\_var\_name)

参数 \_var\_name Str 变量名称

返回类型 Bool 是否含有全局变量

### GameAPI.is\_archives\_enabled

是否开启存档

GameAPI.is\_archives\_enabled()

返回类型 Bool 是否开启

### GameAPI.is\_point\_in\_customtriggerspace

坐标点是否在触发区域内

GameAPI.is\_point\_in\_customtriggerspace(\_point, \_custom\_trigger\_space)

参数 \_point Point3 坐标点 参数 \_custom\_trigger\_space CustomTriggerSpace 触发区域

返回类型 Bool 布尔

### GameAPI.load\_level

跳转关卡

GameAPI.load\_level(\_level\_key)

参数 \_level\_key LevelKey 关卡编号

### GameAPI.modifier\_prefab\_get\_desc

获取效果预设描述

GameAPI.modifier\_prefab\_get\_desc(\_modifier\_key)

参数 \_modifier\_key ModifierKey 效果编号

返回类型 Str 效果描述

### GameAPI.modifier\_prefab\_get\_name

获取效果预设名称

GameAPI.modifier\_prefab\_get\_name(\_modifier\_key)

参数 \_modifier\_key ModifierKey 效果编号

返回类型 Str 效果名称

### GameAPI.modifier\_prefab\_get\_prop\_by\_type

获取效果预设的属性

GameAPI.modifier\_prefab\_get\_prop\_by\_type(\_value\_type, \_key, \_prop)

参数 \_value\_type ValueType 值类型 参数 \_key ModifierKey 效果编号 参数 \_prop Str 名称

返回类型 ETypeMeta 属性值

### GameAPI.modifier\_prefab\_has\_kv

效果预设是否存在自定义值

GameAPI.modifier\_prefab\_has\_kv(\_modifier\_key, \_prop)

参数 \_modifier\_key ModifierKey 效果编号 参数 \_prop Str 名称

返回类型 Bool 是否存在

### GameAPI.obstacle\_prefab\_get\_kv\_by\_type

获取组件预设的自定义值

GameAPI.obstacle\_prefab\_get\_kv\_by\_type(\_value\_type, \_key, \_prop)

参数 \_value\_type ValueType 值类型 参数 \_key ObstacleKey 组件编号 参数 \_prop Str 名称

返回类型 ETypeMeta 自定义值

### GameAPI.obstacle\_prefab\_get\_prop\_by\_type

获取组件预设的属性

GameAPI.obstacle\_prefab\_get\_prop\_by\_type(\_value\_type, \_key, \_prop)

参数 \_value\_type ValueType 值类型 参数 \_key ObstacleKey 组件编号 参数 \_prop Str 名称

返回类型 ETypeMeta 属性值

### GameAPI.obstacle\_prefab\_has\_kv

组件预设是否存在自定义值

GameAPI.obstacle\_prefab\_has\_kv(\_key, \_prop)

参数 \_key ObstacleKey 组件编号 参数 \_prop Str 名称

返回类型 Bool 是否存在

### GameAPI.play\_3d\_sound

单位开始播放3d音效

GameAPI.play\_3d\_sound(\_position, \_sound\_key, \_duration, \_volume)

参数 \_position Point3 发声位置 参数 \_sound\_key SoundKey 声音编号 参数 \_duration Fixed 持续时间 参数 \_volume Fixed 音量

返回类型 SoundID 音效ID

### GameAPI.play\_sfx\_by\_key

播放特效

GameAPI.play\_sfx\_by\_key(\_sfx\_key, \_pos, \_rot, \_scale, \_duration, \_rate, \_with\_sound)

参数 \_sfx\_key SfxKey 特效编号 参数 \_pos Point3 位置 参数 \_rot Quaternion 旋转 参数 \_scale Fixed 缩放 参数 \_duration Fixed 持续时间 参数 \_rate Fixed 播放速率 参数 \_with\_sound Bool 是否播放音效

返回类型 SfxID 特效ID

### GameAPI.random\_color

获取随机颜色

GameAPI.random\_color()

返回类型 Color 颜色

### GameAPI.random\_int

随机整数

GameAPI.random\_int(\_min\_value, \_max\_value)

参数 \_min\_value Int 最小值 参数 \_max\_value Int 最大值

返回类型 Int 整数

### GameAPI.raycast\_unit

查询射线检测到的单位碰撞信息

GameAPI.raycast\_unit(\_start\_pos, \_end\_pos, \_include\_unit\_types, \_raycast\_handler)

参数 \_start\_pos Point3 起始点 参数 \_end\_pos Point3 终点 参数 \_include\_unit\_types ListUnitType 包含的单位类型 参数 \_raycast\_handler Function 碰撞回调

### GameAPI.remove\_pathpoint

删除路点

GameAPI.remove\_pathpoint(\_path\_id, \_index)

参数 \_path\_id PathID 路径 参数 \_index Int 路点索引

### GameAPI.set\_env\_time

设置环境时间

GameAPI.set\_env\_time(\_target\_time, \_duration, \_direction)

参数 \_target\_time Fixed 目标时刻 参数 \_duration Fixed 过渡时间 参数 \_direction Bool 是否正向

### GameAPI.set\_env\_time\_ratio

设置环境时间流逝速度

GameAPI.set\_env\_time\_ratio(\_time\_ratio)

参数 \_time\_ratio Fixed 流逝速度

### GameAPI.set\_env\_time\_running\_enabled

设置环境时间是否自动流逝

GameAPI.set\_env\_time\_running\_enabled(\_enabled)

参数 \_enabled Bool 是否自动流逝

### GameAPI.set\_equipment\_max\_stock\_count

设置物品商店物品最大库存

GameAPI.set\_equipment\_max\_stock\_count(\_battle\_shop\_key, \_equipment\_key, \_max\_stock\_count)

参数 \_battle\_shop\_key BattleShopKey 物品商店编号 参数 \_equipment\_key EquipmentKey 物品编号 参数 \_max\_stock\_count Int 最大库存

### GameAPI.set\_equipment\_remaining\_stock\_count

设置物品商店物品剩余库存

GameAPI.set\_equipment\_remaining\_stock\_count(\_battle\_shop\_key, \_equipment\_key, \_cur\_stock\_count)

参数 \_battle\_shop\_key BattleShopKey 物品商店编号 参数 \_equipment\_key EquipmentKey 物品编号 参数 \_cur\_stock\_count Int 剩余库存

### GameAPI.set\_global\_wind\_enabled

设置全局风场开关

GameAPI.set\_global\_wind\_enabled(\_bool\_value)

参数 \_bool\_value Bool 是否开启

### GameAPI.set\_global\_wind\_force

设置全局风场方向力

GameAPI.set\_global\_wind\_force(\_x\_value, \_y\_value)

参数 \_x\_value Fixed X方向力 参数 \_y\_value Fixed Y方向力

### GameAPI.set\_global\_wind\_frequency

设置全局风场频率

GameAPI.set\_global\_wind\_frequency(\_fixed\_value)

参数 \_fixed\_value Fixed 频率

### GameAPI.set\_life\_entity\_survival\_scene\_boundary

设置生命体存活场景边界大小

GameAPI.set\_life\_entity\_survival\_scene\_boundary(\_x, \_y, \_z)

参数 \_x Fixed 矩形边界长度 参数 \_y Fixed 矩形边界高度 参数 \_z Fixed 矩形边界宽度

### GameAPI.set\_scene\_ui\_position

设置场景界面位置

GameAPI.set\_scene\_ui\_position(\_role, \_layer, \_position)

参数 \_role Role 玩家 参数 \_layer E3DLayer 场景界面 参数 \_position Point3 坐标点

### GameAPI.set\_scene\_ui\_visible

设置场景界面的显隐

GameAPI.set\_scene\_ui\_visible(\_layer, \_role, \_visible)

参数 \_layer E3DLayer 场景界面 参数 \_role Role 玩家 参数 \_visible Bool 显隐

### GameAPI.set\_unit\_survival\_scene\_boundary

设置组件存活场景边界大小

GameAPI.set\_unit\_survival\_scene\_boundary(\_x, \_y, \_z)

参数 \_x Fixed 矩形边界长度 参数 \_y Fixed 矩形边界高度 参数 \_z Fixed 矩形边界宽度

### GameAPI.stop\_sound

停止播放音效

GameAPI.stop\_sound(\_assigned\_id)

参数 \_assigned\_id SoundID 音效ID

### GameAPI.triggerspace\_prefab\_get\_kv\_by\_type

获取逻辑体预设的自定义值

GameAPI.triggerspace\_prefab\_get\_kv\_by\_type(\_value\_type, \_key, \_prop)

参数 \_value\_type ValueType 值类型 参数 \_key TriggerSpaceKey 逻辑体编号 参数 \_prop Str 名称

返回类型 ETypeMeta 自定义值

### GameAPI.triggerspace\_prefab\_get\_prop\_by\_type

获取逻辑体预设的属性

GameAPI.triggerspace\_prefab\_get\_prop\_by\_type(\_value\_type, \_key, \_prop)

参数 \_value\_type ValueType 值类型 参数 \_key TriggerSpaceKey 逻辑体编号 参数 \_prop Str 名称

返回类型 ETypeMeta 属性值

### GameAPI.triggerspace\_prefab\_has\_kv

逻辑体预设是否存在自定义值

GameAPI.triggerspace\_prefab\_has\_kv(\_key, \_prop)

参数 \_key TriggerSpaceKey 逻辑体编号 参数 \_prop Str 名称

返回类型 Bool 是否存在

## 单位API

### Ability.add\_state\_to\_target

技能给单位添加状态

Ability.add\_state\_to\_target(\_unit, \_state\_id)

参数 \_unit Unit 对象 参数 \_state\_id BuffState 状态

### Ability.begin\_cast

技能开始释放

Ability.begin\_cast(\_dir\_info, \_target\_point, \_target\_unit)

参数 \_dir\_info Vector3 方向 参数 \_target\_point Point3 坐标点 参数 \_target\_unit Unit 目标单位

### Ability.break\_accumulate

打断蓄力

Ability.break\_accumulate()

### Ability.break\_cast

打断技能施法

Ability.break\_cast()

### Ability.change\_affect\_radius

修改技能作用半径

Ability.change\_affect\_radius(\_delta\_affect\_radius)

参数 \_delta\_affect\_radius Fixed 修改技能作用半径

### Ability.change\_affect\_width

修改技能作用宽度

Ability.change\_affect\_width(\_delta\_affect\_width)

参数 \_delta\_affect\_width Fixed 修改技能作用宽度

### Ability.change\_max\_release\_distance

修改技能施法距离

Ability.change\_max\_release\_distance(\_delta\_level)

参数 \_delta\_level Fixed 修改技能施法距离

### Ability.downgrade\_ability\_level

降级技能等级

Ability.downgrade\_ability\_level(\_delta\_level)

参数 \_delta\_level Int 降低的技能等级

### Ability.enter\_cd

技能激活冷却

Ability.enter\_cd()

### Ability.get\_ability\_level

获取技能的等级

Ability.get\_ability\_level()

返回类型 Int 技能等级

### Ability.get\_ability\_max\_level

获取技能的最大等级

Ability.get\_ability\_max\_level()

返回类型 Int 技能最大等级

### Ability.get\_ability\_slot

获取技能所在槽位

Ability.get\_ability\_slot()

返回类型 AbilitySlot 技能槽位

### Ability.get\_accumulate\_ratio

获取技能蓄力百分比

Ability.get\_accumulate\_ratio()

返回类型 Fixed 技能蓄力百分比

### Ability.get\_affect\_character\_list

获取技能可以作用的角色列表

Ability.get\_affect\_character\_list(\_height, \_use\_fixed\_release\_point)

参数 \_height Fixed 高度差 参数 \_use\_fixed\_release\_point Bool 施法点是否固定

返回类型 ListCharacter 可以影响的角色列表

### Ability.get\_affect\_creature\_list

获取技能可以作用的生物列表

Ability.get\_affect\_creature\_list(\_height, \_use\_fixed\_release\_point)

参数 \_height Fixed 高度差 参数 \_use\_fixed\_release\_point Bool 施法点是否固定

返回类型 ListCreature 可以影响的生物列表

### Ability.get\_affect\_lifeentity\_list

获取技能可以作用的生命体列表

Ability.get\_affect\_lifeentity\_list(\_height, \_use\_fixed\_release\_point)

参数 \_height Fixed 高度差 参数 \_use\_fixed\_release\_point Bool 施法点是否固定

返回类型 ListLifeEntity 可以影响的生命体列表

### Ability.get\_affect\_obstacle\_list

获取技能可以作用的组件列表

Ability.get\_affect\_obstacle\_list(\_height, \_use\_fixed\_release\_point)

参数 \_height Fixed 高度差 参数 \_use\_fixed\_release\_point Bool 施法点是否固定

返回类型 ListObstacle 可以影响的组件列表

### Ability.get\_affect\_radius

获取技能的作用半径

Ability.get\_affect\_radius()

返回类型 Fixed 施法距离

### Ability.get\_affect\_width

获取技能的作用宽度

Ability.get\_affect\_width()

返回类型 Fixed 施法距离

### Ability.get\_cd\_time

获取技能冷却时间

Ability.get\_cd\_time()

返回类型 Fixed 技能冷却时间

### Ability.get\_charge\_time

获取技能充能时间

Ability.get\_charge\_time()

返回类型 Fixed 充能时间

### Ability.get\_cur\_release\_num

获取技能当前使用次数

Ability.get\_cur\_release\_num()

返回类型 Int 使用次数

### Ability.get\_desc

获取技能描述

Ability.get\_desc()

返回类型 Str 技能描述

### Ability.get\_key

获取技能编号

Ability.get\_key()

返回类型 AbilityKey 技能编号

### Ability.get\_left\_cd\_time

获取技能剩余冷却时间

Ability.get\_left\_cd\_time()

返回类型 Fixed 剩余冷却时间

### Ability.get\_left\_charge\_time

获取技能剩余充能时间

Ability.get\_left\_charge\_time()

返回类型 Fixed 剩余充能时间

### Ability.get\_lock\_target

获取技能锁定目标

Ability.get\_lock\_target()

返回类型 LifeEntity 获取技能锁定目标

### Ability.get\_lock\_target\_char

获取技能锁定角色

Ability.get\_lock\_target\_char()

返回类型 Character 角色

### Ability.get\_lock\_target\_creature

获取技能锁定生物

Ability.get\_lock\_target\_creature()

返回类型 Creature 生物

### Ability.get\_max\_release\_distance

获取技能的施法距离

Ability.get\_max\_release\_distance()

返回类型 Fixed 施法距离

### Ability.get\_max\_release\_num

获取技能最大使用次数

Ability.get\_max\_release\_num()

返回类型 Int 最大使用次数

### Ability.get\_name

获取技能名称

Ability.get\_name()

返回类型 Str 技能名称

### Ability.get\_owner

获取技能拥有者

Ability.get\_owner()

返回类型 LifeEntity 技能拥有者

### Ability.get\_owner\_character

获取技能拥有角色

Ability.get\_owner\_character()

返回类型 Unit 角色

### Ability.get\_owner\_creature

获取技能拥有生物

Ability.get\_owner\_creature()

返回类型 Unit 生物

### Ability.get\_owner\_equipment

获取拥有技能的物品

Ability.get\_owner\_equipment()

返回类型 Equipment 技能拥有者

### Ability.get\_pointer\_type

获取技能指示器类型

Ability.get\_pointer\_type()

返回类型 AbilityPointerType 指示器类型

### Ability.get\_release\_direction

获取技能释放方向

Ability.get\_release\_direction()

返回类型 Vector3 方向

### Ability.get\_release\_direction\_list

获取技能复数释放方向

Ability.get\_release\_direction\_list()

返回类型 ListVector3 方向

### Ability.get\_release\_point

获取技能释放坐标点

Ability.get\_release\_point()

返回类型 Point3 坐标点

### Ability.get\_release\_point\_list

获取技能复数释放坐标点

Ability.get\_release\_point\_list()

返回类型 ListPoint3 坐标点

### Ability.is\_in\_cd

技能是否在冷却中

Ability.is\_in\_cd()

返回类型 Bool 剩余冷却时间

### Ability.is\_in\_charge

技能是否在充能中

Ability.is\_in\_charge()

返回类型 Bool 剩余冷却时间

### Ability.play\_countdown\_ui

播放倒计时ui效果

Ability.play\_countdown\_ui(\_time)

参数 \_time Fixed 持续时间

### Ability.remove\_state\_to\_target

技能给单位移除状态

Ability.remove\_state\_to\_target(\_unit, \_state\_id)

参数 \_unit Unit 对象 参数 \_state\_id BuffState 状态

### Ability.set\_ability\_level

设置技能等级

Ability.set\_ability\_level(\_new\_level)

参数 \_new\_level Int 技能等级

### Ability.set\_ability\_max\_level

设置技能最大等级

Ability.set\_ability\_max\_level(\_new\_max\_level)

参数 \_new\_max\_level Int 技能最大等级

### Ability.set\_affect\_radius

设置技能的作用半径

Ability.set\_affect\_radius(\_new\_affect\_radius)

参数 \_new\_affect\_radius Fixed 作用半径

### Ability.set\_affect\_width

设置技能的作用宽度

Ability.set\_affect\_width(\_new\_affect\_width)

参数 \_new\_affect\_width Fixed 作用宽度

### Ability.set\_cur\_release\_num

设置技能当前使用次数

Ability.set\_cur\_release\_num(\_release\_num)

参数 \_release\_num Int 使用次数

### Ability.set\_left\_cd\_time

设置技能剩余冷却

Ability.set\_left\_cd\_time(\_cd\_time)

参数 \_cd\_time Fixed 冷却时间

### Ability.set\_left\_charge\_time

设置技能剩余充能

Ability.set\_left\_charge\_time(\_cd\_time)

参数 \_cd\_time Fixed 充能时间

### Ability.set\_max\_release\_distance

设置技能的施法距离

Ability.set\_max\_release\_distance(\_new\_max\_release\_distance)

参数 \_new\_max\_release\_distance Fixed 施法距离

### Ability.set\_max\_release\_num

设置技能最大使用次数

Ability.set\_max\_release\_num(\_release\_num\_max)

参数 \_release\_num\_max Int 最大使用次数

### Ability.upgrade\_ability\_level

增加技能等级

Ability.upgrade\_ability\_level(\_delta\_level)

参数 \_delta\_level Int 增加的技能等级

### AbilityComp.add\_ability\_to\_slot

添加向技能槽位添加UGC技能能

AbilityComp.add\_ability\_to\_slot(\_ability\_index, \_ability\_id, \_kv\_args, \_kv\_types)

参数 \_ability\_index AbilitySlot 技能槽位 参数 \_ability\_id AbilityKey 技能编号 参数 \_kv\_args Dict 自定义参数值 参数 \_kv\_types Dict 自定义参数类型

返回类型 Ability 添加上的技能

### AbilityComp.add\_prop\_ability

添加道具技能

AbilityComp.add\_prop\_ability(\_ability\_id, \_kv\_args, \_kv\_types)

参数 \_ability\_id AbilityKey 技能编号 参数 \_kv\_args Dict 自定义参数值 参数 \_kv\_types Dict 自定义参数类型

返回类型 Ability 添加上的技能

### AbilityComp.break\_ability\_accumulate

打断技能蓄力

AbilityComp.break\_ability\_accumulate()

### AbilityComp.cast\_ability\_by\_ability\_slot\_and\_direction

控制角色对目标方向释放指定槽位技能

AbilityComp.cast\_ability\_by\_ability\_slot\_and\_direction(\_direction, \_ability\_slot, \_duration)

参数 \_direction Vector3 方向 参数 \_ability\_slot AbilitySlot 技能槽位 参数 \_duration Fixed 时间

### AbilityComp.cast\_ability\_by\_ability\_slot\_and\_position

控制角色对目标坐标释放指定槽位技能

AbilityComp.cast\_ability\_by\_ability\_slot\_and\_position(\_position, \_ability\_slot, \_duration)

参数 \_position Point3 坐标 参数 \_ability\_slot AbilitySlot 技能槽位 参数 \_duration Fixed 时间

### AbilityComp.cast\_ability\_by\_ability\_slot\_and\_target

控制角色对目标单位释放指定槽位技能

AbilityComp.cast\_ability\_by\_ability\_slot\_and\_target(\_target, \_ability\_slot, \_duration)

参数 \_target LifeEntity 目标 参数 \_ability\_slot AbilitySlot 技能槽位 参数 \_duration Fixed 时间

### AbilityComp.cast\_ability\_by\_direction

控制角色对指定方向执行释放指定预设技能

AbilityComp.cast\_ability\_by\_direction(\_ability\_key, \_duration, \_direction, \_ability\_slot)

参数 \_ability\_key AbilityKey 技能编号 参数 \_duration Fixed 时间 参数 \_direction Vector3 方向 参数 \_ability\_slot AbilitySlot 技能槽位

### AbilityComp.cast\_ability\_by\_position

控制角色对指定坐标执行释放预设技能

AbilityComp.cast\_ability\_by\_position(\_ability\_key, \_duration, \_position, \_ability\_slot)

参数 \_ability\_key AbilityKey 技能编号 参数 \_duration Fixed 时间 参数 \_position Point3 坐标 参数 \_ability\_slot AbilitySlot 技能槽位

### AbilityComp.cast\_ability\_by\_target

控制角色对指定目标执行释放指定预设技能

AbilityComp.cast\_ability\_by\_target(\_ability\_key, \_duration, \_target, \_ability\_slot)

参数 \_ability\_key AbilityKey 技能编号 参数 \_duration Fixed 时间 参数 \_target LifeEntity 目标 参数 \_ability\_slot AbilitySlot 技能槽位

### AbilityComp.destroy\_ability

销毁技能

AbilityComp.destroy\_ability(\_ability)

参数 \_ability Ability 技能对象

返回类型 Bool 是否成功移除

### AbilityComp.get\_abilities

获取单位所有技能

AbilityComp.get\_abilities()

返回类型 ListAbility 技能对象

### AbilityComp.get\_ability\_by\_slot

获取对应槽位技能

AbilityComp.get\_ability\_by\_slot(\_ability\_slot)

参数 \_ability\_slot AbilitySlot 技能槽位

返回类型 Ability 技能对象

### AbilityComp.get\_ability\_list

获取单位所有技能

AbilityComp.get\_ability\_list()

返回类型 ListAbility 技能列表

### AbilityComp.get\_prop\_ability

获取道具技能

AbilityComp.get\_prop\_ability()

返回类型 Ability 技能对象

### AbilityComp.interrupt\_ability

打断技能施法

AbilityComp.interrupt\_ability()

### AbilityComp.remove\_ability

移除槽位上的技能

AbilityComp.remove\_ability(\_ability\_slot)

参数 \_ability\_slot AbilitySlot 技能槽位

返回类型 Bool 是否成功移除

### AbilityComp.remove\_ability\_by\_key

根据技能编号移除技能

AbilityComp.remove\_ability\_by\_key(\_ability\_key)

参数 \_ability\_key AbilityKey 技能编号

返回类型 Bool 是否成功移除

### AbilityComp.remove\_prop\_ability

移除道具技能

AbilityComp.remove\_prop\_ability()

返回类型 Bool 是否成功移除

### AbilityComp.reset\_ability\_cd

重置指定槽位技能CD

AbilityComp.reset\_ability\_cd(\_ability\_index)

参数 \_ability\_index AbilitySlot 技能槽位

### AbilityComp.set\_ability\_enabled\_on\_vehicle

设置是否能在载具上使用用技能

AbilityComp.set\_ability\_enabled\_on\_vehicle(\_enable)

参数 \_enable Bool 是否能用技能

### AbilityComp.set\_ability\_to\_slot

替换技能槽位(UGC槽位)

AbilityComp.set\_ability\_to\_slot(\_ability, \_ability\_index)

参数 \_ability Ability 技能对象 参数 \_ability\_index AbilitySlot 技能槽位

返回类型 Ability 被替换的旧技能

### Actor.get\_id

获取单位ID

Actor.get\_id()

返回类型 UnitID 单位ID

### AttrComp.change\_attr\_bonus\_fixed

改变属性的额外固定值(复杂模式)

AttrComp.change\_attr\_bonus\_fixed(\_key, \_value)

参数 \_key Str 属性名 参数 \_value Fixed 额外固定值

### AttrComp.change\_attr\_ratio\_fixed

改变属性的倍率值(复杂模式)

AttrComp.change\_attr\_ratio\_fixed(\_key, \_value)

参数 \_key Str 属性名 参数 \_value Fixed 倍率值

### AttrComp.change\_attr\_raw\_fixed

改变属性的基础值(复杂模式)

AttrComp.change\_attr\_raw\_fixed(\_key, \_value)

参数 \_key Str 属性名 参数 \_value Fixed 基础值

### AttrComp.get\_attr\_base\_extra\_fixed

获取属性的基础加成值(复杂模式)

AttrComp.get\_attr\_base\_extra\_fixed(\_key)

参数 \_key Str 属性名

返回类型 Fixed 基础加成值

### AttrComp.get\_attr\_bonus\_fixed

获取属性的额外固定值(复杂模式)

AttrComp.get\_attr\_bonus\_fixed(\_key)

参数 \_key Str 属性名

返回类型 Fixed 额外固定值

### AttrComp.get\_attr\_by\_type

获取属性

AttrComp.get\_attr\_by\_type(\_value\_type, \_key)

参数 \_value\_type ValueType 值类型 参数 \_key Str 属性名

返回类型 ETypeMeta 属性值

### AttrComp.get\_attr\_ratio\_fixed

获取属性的倍率值(复杂模式)

AttrComp.get\_attr\_ratio\_fixed(\_key)

参数 \_key Str 属性名

返回类型 Fixed 倍率值

### AttrComp.get\_attr\_raw\_fixed

获取属性的基础值(复杂模式)

AttrComp.get\_attr\_raw\_fixed(\_key)

参数 \_key Str 属性名

返回类型 Fixed 基础值

### AttrComp.set\_attr\_bonus\_fixed

设置属性的额外固定值(复杂模式)

AttrComp.set\_attr\_bonus\_fixed(\_key, \_value)

参数 \_key Str 属性名 参数 \_value Fixed 额外固定值

### AttrComp.set\_attr\_by\_type

设置属性

AttrComp.set\_attr\_by\_type(\_value\_type, \_key, \_val)

参数 \_value\_type ValueType 值类型 参数 \_key Str 属性名 参数 \_val ETypeMeta 属性值

### AttrComp.set\_attr\_ratio\_fixed

设置属性的倍率值(复杂模式)

AttrComp.set\_attr\_ratio\_fixed(\_key, \_value)

参数 \_key Str 属性名 参数 \_value Fixed 倍率值

### AttrComp.set\_attr\_raw\_fixed

设置属性的基础值(复杂模式)

AttrComp.set\_attr\_raw\_fixed(\_key, \_value)

参数 \_key Str 属性名 参数 \_value Fixed 基础值

### BuffStateComp.add\_state

添加状态

BuffStateComp.add\_state(\_state\_id)

参数 \_state\_id BuffState 状态

### BuffStateComp.clear\_state

清除状态

BuffStateComp.clear\_state(\_state\_id)

参数 \_state\_id BuffState 状态

### BuffStateComp.get\_state\_count

获取限制状态计数

BuffStateComp.get\_state\_count(\_state\_id)

参数 \_state\_id BuffState 状态

返回类型 Int 状态计数

### BuffStateComp.get\_state\_list

获取所有限制状态

BuffStateComp.get\_state\_list()

返回类型 ListBuffState 状态列表

### BuffStateComp.remove\_state

移除状态

BuffStateComp.remove\_state(\_state\_id)

参数 \_state\_id BuffState 状态

### Camp.change\_camp\_score

改变阵营积分

Camp.change\_camp\_score(\_add\_score)

参数 \_add\_score Int 变化积分

### Camp.get\_camp\_score

获取阵营积分

Camp.get\_camp\_score()

返回类型 Int 积分

### Camp.get\_name

获取阵营名称

Camp.get\_name()

返回类型 Str 名称

### Camp.get\_roles

获取阵营内玩家列表

Camp.get\_roles()

返回类型 ListRole 玩家列表

### Camp.set\_camp\_score

设置阵营积分

Camp.set\_camp\_score(\_score)

参数 \_score Int 积分

### Character.fling\_rush

命令角色前扑

Character.fling\_rush()

### Character.get\_ability\_point

获取技能点

Character.get\_ability\_point()

返回类型 Int 技能点

### Character.get\_ctrl\_role

获取控制角色的玩家

Character.get\_ctrl\_role()

返回类型 Role 玩家

### Character.increase\_ability\_point

增加技能点

Character.increase\_ability\_point(\_increase)

参数 \_increase Int 技能点

### Character.lift

命令角色抓举

Character.lift()

### Character.reset\_target\_socket\_model

还原角色指定外观部位变化

Character.reset\_target\_socket\_model(\_model\_socket)

参数 \_model\_socket ModelSocket 外观部位

### Character.set\_aim\_move\_enabled

开关角色靶向移动

Character.set\_aim\_move\_enabled(\_enable)

参数 \_enable Bool 开关

### Character.set\_character\_prefab

改变角色预设

Character.set\_character\_prefab(\_c\_key, \_reset\_prop, \_reset\_trigger\_system, \_reset\_model)

参数 \_c\_key CharacterKey 角色预设 参数 \_reset\_prop Bool 重置属性 参数 \_reset\_trigger\_system Bool 重置蛋码 参数 \_reset\_model Bool 重置外观

### Character.set\_voice\_enabled

设置角色配音是否生效

Character.set\_voice\_enabled(\_enabled)

参数 \_enabled Bool 是否启用

### Character.start\_move\_to\_pos

命令角色移动到坐标点

Character.start\_move\_to\_pos(\_target\_pos, \_duration)

参数 \_target\_pos Point3 坐标点 参数 \_duration Fixed 持续时间

### CharacterComp.get\_scale\_ratio

获取缩放倍率

CharacterComp.get\_scale\_ratio()

返回类型 Fixed 缩放倍率

### CharacterComp.is\_forced\_moving

是否正在强制位移

CharacterComp.is\_forced\_moving()

返回类型 Bool 布尔

### CharacterComp.start\_forced\_move

开始强制位移

CharacterComp.start\_forced\_move(\_vel, \_duration, \_enable\_phy)

参数 \_vel Vector3 移动速度 参数 \_duration Fixed 持续时间 参数 \_enable\_phy Bool 是否保留物理

### CharacterComp.stop\_forced\_move

退出当前强制位移

CharacterComp.stop\_forced\_move()

### Creature.force\_start\_move

命令生物移动

Creature.force\_start\_move(\_direction, \_t)

参数 \_direction Vector3 方向 参数 \_t Fixed 时间

### Creature.force\_stop\_move

命令生物停止移动

Creature.force\_stop\_move()

### Creature.reset\_target\_socket\_model

还原生物指定外观部位变化

Creature.reset\_target\_socket\_model(\_model\_socket)

参数 \_model\_socket ModelSocket 外观部位

### Creature.set\_draggable

设置生物是否可拖动

Creature.set\_draggable(\_enable)

参数 \_enable Bool 是否可拖动

### Creature.set\_name

设置生物的显示名称

Creature.set\_name(\_name)

参数 \_name Str 显示名称

### Creature.set\_name\_visible

设置生物是否显示名称

Creature.set\_name\_visible(\_visible)

参数 \_visible Bool 是否显示名称

### Creature.set\_touchable

设置生物是否可点击

Creature.set\_touchable(\_enable)

参数 \_enable Bool 是否可点击

### CustomTriggerSpace.random\_point

获取触发区域内的随机坐标

CustomTriggerSpace.random\_point()

返回类型 Vector3 坐标

### DisplayComp.bind\_model

添加绑定模型

DisplayComp.bind\_model(\_model\_id, \_socket, \_offset, \_rot, \_scale)

参数 \_model\_id UnitKey 单位编号 参数 \_socket ModelSocket 挂点 参数 \_offset Point3 偏移 参数 \_rot Quaternion 旋转 参数 \_scale Vector3 缩放

返回类型 Str 绑定ID

### DisplayComp.play\_body\_anim\_by\_id

播放全身动画

DisplayComp.play\_body\_anim\_by\_id(\_anim\_id, \_start\_time, \_play\_time, \_is\_loop)

参数 \_anim\_id AnimKey 动画编号 参数 \_start\_time Fixed 开始时间 参数 \_play\_time Fixed 持续时间 参数 \_is\_loop Bool 是否循环

### DisplayComp.play\_upper\_anim\_by\_id

播放上半身动画

DisplayComp.play\_upper\_anim\_by\_id(\_anim\_id, \_start\_time, \_play\_time, \_is\_loop)

参数 \_anim\_id AnimKey 动画编号 参数 \_start\_time Fixed 开始时间 参数 \_play\_time Fixed 持续时间 参数 \_is\_loop Bool 是否循环

### DisplayComp.set\_anim\_rate

设置播放速率

DisplayComp.set\_anim\_rate(\_anim\_rate)

参数 \_anim\_rate Fixed 播放速率

### DisplayComp.stop\_anim

停止播放动画

DisplayComp.stop\_anim()

### DisplayComp.stop\_play\_body\_anim

停止播放全身动画

DisplayComp.stop\_play\_body\_anim()

### DisplayComp.stop\_play\_body\_anim\_by\_id

停止播放全身动画）

DisplayComp.stop\_play\_body\_anim\_by\_id(\_anim\_id)

参数 \_anim\_id AnimKey 动画编号

### DisplayComp.stop\_play\_upper\_anim

停止播放上半身动画

DisplayComp.stop\_play\_upper\_anim()

### DisplayComp.stop\_play\_upper\_anim\_by\_id

停止播放上半身动画

DisplayComp.stop\_play\_upper\_anim\_by\_id(\_anim\_id)

参数 \_anim\_id AnimKey 动画编号

### DisplayComp.unbind\_model

移除绑定模型

DisplayComp.unbind\_model(\_bind\_id)

参数 \_bind\_id Str 绑定ID

### Equipment.can\_drop

获取物品能否丢弃

Equipment.can\_drop()

返回类型 Bool 能否丢弃

### Equipment.change\_current\_stack\_size

增加/减少物品当前堆叠数

Equipment.change\_current\_stack\_size(\_num)

参数 \_num Int 堆叠数

### Equipment.change\_max\_stack\_size

增加/减少物品最大堆叠数

Equipment.change\_max\_stack\_size(\_num)

参数 \_num Int 堆叠数

### Equipment.destroy\_equipment

删除物品

Equipment.destroy\_equipment()

### Equipment.drop

物品被丢弃

Equipment.drop()

### Equipment.get\_current\_stack\_num

获取物品当前堆叠层数

Equipment.get\_current\_stack\_num()

返回类型 Int 当前堆叠层数

### Equipment.get\_desc

获取物品描述

Equipment.get\_desc()

返回类型 Str 物品描述

### Equipment.get\_equipment\_slot

获取物品所在槽位

Equipment.get\_equipment\_slot()

返回类型 EquipmentSlot 槽位

### Equipment.get\_equipment\_type

获取物品的物品类型

Equipment.get\_equipment\_type()

返回类型 EquipmentType 物品类型

### Equipment.get\_key

获取物品的物品编号

Equipment.get\_key()

返回类型 EquipmentKey 物品编号

### Equipment.get\_max\_stack\_num

获取物品最大堆叠层数

Equipment.get\_max\_stack\_num()

返回类型 Int 最大堆叠层数

### Equipment.get\_name

获取物品名称

Equipment.get\_name()

返回类型 Str 物品名称

### Equipment.get\_owner\_character

获取持有物品的角色

Equipment.get\_owner\_character()

返回类型 Character 角色

### Equipment.get\_owner\_creature

获取持有物品的生物

Equipment.get\_owner\_creature()

返回类型 Creature 生物

### Equipment.get\_position

获取物品位置

Equipment.get\_position()

返回类型 Point3 物品位置

### Equipment.get\_price

获取物品的抵押价格

Equipment.get\_price(\_res\_type)

参数 \_res\_type Str 货币类型

返回类型 Int 卖价

### Equipment.get\_slot\_type

获取物品所在槽位类型

Equipment.get\_slot\_type()

返回类型 EquipmentSlotType 槽位类型

### Equipment.get\_unit

获取物品单位

Equipment.get\_unit()

返回类型 Obstacle 物品单位

### Equipment.has\_owner

物品是否被持有

Equipment.has\_owner()

返回类型 Bool 是否被持有

### Equipment.is\_auto\_picking

获取物品是否自动拾取

Equipment.is\_auto\_picking()

返回类型 Bool 是否自动拾取

### Equipment.is\_auto\_using

获取物品是否自动使用

Equipment.is\_auto\_using()

返回类型 Bool 是否自动使用

### Equipment.move\_to\_slot

移动物品到指定槽位

Equipment.move\_to\_slot(\_slot\_type, \_slot)

参数 \_slot\_type EquipmentSlotType 槽位类型 参数 \_slot Int 槽位

### Equipment.set\_auto\_aim\_enabled

设置枪械自动瞄准

Equipment.set\_auto\_aim\_enabled(\_is\_auto\_aim)

参数 \_is\_auto\_aim Bool 是否自动瞄准

### Equipment.set\_auto\_fire\_enabled

设置枪械自动开火

Equipment.set\_auto\_fire\_enabled(\_is\_auto\_fire)

参数 \_is\_auto\_fire Bool 是否自动开火

### Equipment.set\_charge\_cost\_free

设置物品充能无消耗

Equipment.set\_charge\_cost\_free(\_is\_free)

参数 \_is\_free Bool 是否无消耗

### Equipment.set\_current\_stack\_num

设置物品当前堆叠数

Equipment.set\_current\_stack\_num(\_num)

参数 \_num Int 堆叠数

### Equipment.set\_desc

设置物品的描述

Equipment.set\_desc(\_desc)

参数 \_desc Str 描述

### Equipment.set\_droppable

设置物品能否丢弃

Equipment.set\_droppable(\_droppable)

参数 \_droppable Bool 能否丢弃

### Equipment.set\_icon

设置物品的图标

Equipment.set\_icon(\_icon\_key)

参数 \_icon\_key ImageKey 图标

### Equipment.set\_max\_stack\_num

设置物品最大堆叠数

Equipment.set\_max\_stack\_num(\_num)

参数 \_num Int 堆叠数

### Equipment.set\_name

设置物品的名称

Equipment.set\_name(\_name)

参数 \_name Str 名称

### Equipment.set\_price

设置物品的抵押价格

Equipment.set\_price(\_res\_type, \_price)

参数 \_res\_type Str 货币类型 参数 \_price Int 卖价

### Equipment.set\_saleable

设置物品能否出售

Equipment.set\_saleable(\_saleable)

参数 \_saleable Bool 能否出售

### Equipment.set\_usable

设置物品能否使用

Equipment.set\_usable(\_usable)

参数 \_usable Bool 能否使用

### Equipment.start\_charge

使物品开始充能

Equipment.start\_charge()

### EquipmentComp.clear\_selected\_equipment\_slot

清除单位物品格选中状态

EquipmentComp.clear\_selected\_equipment\_slot()

### EquipmentComp.consume\_equipment

消耗物品

EquipmentComp.consume\_equipment(\_equipment\_key, \_consume\_num)

参数 \_equipment\_key EquipmentKey 物品编号 参数 \_consume\_num Int 消耗数量

### EquipmentComp.create\_equipment\_to\_slot

创建物品到指定类型槽位

EquipmentComp.create\_equipment\_to\_slot(\_key, \_slot\_type)

参数 \_key EquipmentKey 物品编号 参数 \_slot\_type EquipmentSlotType 槽位类型

返回类型 Equipment 创建的物品

### EquipmentComp.get\_equipment\_by\_slot

获取身上的物品

EquipmentComp.get\_equipment\_by\_slot(\_slot\_type, \_slot\_index)

参数 \_slot\_type EquipmentSlotType 槽位类型 参数 \_slot\_index Int 槽位索引

返回类型 Equipment 物品

### EquipmentComp.get\_equipment\_list

获取角色/生物持有的物品预设列表

EquipmentComp.get\_equipment\_list(\_equipment\_key, \_exclude\_equipped, \_exclude\_bag)

参数 \_equipment\_key EquipmentKey 物品类型 参数 \_exclude\_equipped Bool 不搜索物品栏 参数 \_exclude\_bag Bool 不搜索背包栏

返回类型 ListEquipment 物品列表

### EquipmentComp.get\_equipment\_list\_by\_slot\_type

获取持有的物品列表

EquipmentComp.get\_equipment\_list\_by\_slot\_type(\_slot\_type)

参数 \_slot\_type EquipmentSlotType 槽位类型

返回类型 ListEquipment 物品

### EquipmentComp.get\_equipment\_max\_count

获取最大可持有的物品数量

EquipmentComp.get\_equipment\_max\_count(\_slot\_type)

参数 \_slot\_type EquipmentSlotType 槽位类型

返回类型 Int 数量

### EquipmentComp.get\_selected\_equipment

获取当前选中的物品

EquipmentComp.get\_selected\_equipment()

返回类型 Equipment 物品

### EquipmentComp.select\_equipment\_slot

设置单位选中物品格

EquipmentComp.select\_equipment\_slot(\_slot\_type, \_slot\_index)

参数 \_slot\_type EquipmentSlotType 槽位类型 参数 \_slot\_index Int 槽位索引

### EquipmentComp.set\_equipment\_max\_count

修改最大可持有的物品数量

EquipmentComp.set\_equipment\_max\_count(\_slot\_type, \_slot\_num)

参数 \_slot\_type EquipmentSlotType 槽位类型 参数 \_slot\_num Int 数量

### ExprDeviceComp.disable\_expr\_device\_by\_name

通过名称禁用表现器

ExprDeviceComp.disable\_expr\_device\_by\_name(\_name)

参数 \_name Str 名称

### ExprDeviceComp.enable\_expr\_device\_by\_name

通过名称激活表现器

ExprDeviceComp.enable\_expr\_device\_by\_name(\_name)

参数 \_name Str 名称

### ItemBox.add\_ability

添加道具箱刷新技能

ItemBox.add\_ability(\_ability\_key, \_weight)

参数 \_ability\_key AbilityKey 技能编号 参数 \_weight Int 权重

### ItemBox.add\_equipment

添加物品箱刷新预设

ItemBox.add\_equipment(\_key, \_weight)

参数 \_key EquipmentKey 物品编号 参数 \_weight Int 权重

### ItemBox.remove\_ability

移除道具箱刷新技能

ItemBox.remove\_ability(\_ability\_key)

参数 \_ability\_key AbilityKey 技能编号

### ItemBox.remove\_equipment

移除物品箱刷新预设

ItemBox.remove\_equipment(\_key)

参数 \_key EquipmentKey 物品编号

### JointAssistantComp.get\_joint\_assistant\_primary\_obstacle

获取关节组件主体

JointAssistantComp.get\_joint\_assistant\_primary\_obstacle()

返回类型 Character 关节组件主体

### JointAssistantComp.get\_joint\_assistant\_target\_obstacle

获取关节组件目标

JointAssistantComp.get\_joint\_assistant\_target\_obstacle()

返回类型 Character 关节组件目标

### JointAssistantComp.get\_joint\_assistant\_type

获取关节组件类型

JointAssistantComp.get\_joint\_assistant\_type()

返回类型 JointAssistantType 关节类型

### JointAssistantComp.set\_joint\_assistant\_enabled

设置关节组件的启用状态

JointAssistantComp.set\_joint\_assistant\_enabled(\_enable)

参数 \_enable Bool 开关

### JointAssistantComp.set\_joint\_assistant\_visible

设置关节组件可见性

JointAssistantComp.set\_joint\_assistant\_visible(\_visible)

参数 \_visible Bool 可见性

### JumpComp.get\_multi\_jump\_remaining\_cooldown

获取多段跳剩余冷却

JumpComp.get\_multi\_jump\_remaining\_cooldown()

返回类型 Fixed 冷却时间

### JumpComp.is\_on\_ground

是否位于地面

JumpComp.is\_on\_ground()

返回类型 Bool 是否位于地面

### JumpComp.set\_multi\_jump\_remaining\_cooldown

设置多段跳剩余冷却

JumpComp.set\_multi\_jump\_remaining\_cooldown(\_cd)

参数 \_cd Fixed 冷却时间

### KVBase.add\_tag

添加标签

KVBase.add\_tag(\_tag)

参数 \_tag Str 标签

### KVBase.clear\_kv

清空自定义值

KVBase.clear\_kv()

### KVBase.clear\_tag

清空标签

KVBase.clear\_tag()

### KVBase.get\_kv\_by\_type

获取自定义值

KVBase.get\_kv\_by\_type(\_value\_type, \_key)

参数 \_value\_type ValueType 值类型 参数 \_key Str 名称

返回类型 ETypeMeta 自定义值

### KVBase.has\_kv

是否有自定义值

KVBase.has\_kv(\_key)

参数 \_key Str 名称

返回类型 Bool 是否有自定义值

### KVBase.has\_tag

是否含有标签

KVBase.has\_tag(\_tag)

参数 \_tag Str 标签名

返回类型 Bool 是否有标签

### KVBase.remove\_kv

移除自定义值

KVBase.remove\_kv(\_key)

参数 \_key Str 名称

### KVBase.remove\_tag

移除标签

KVBase.remove\_tag(\_tag)

参数 \_tag Str 标签

### KVBase.set\_kv\_by\_type

设置自定义值

KVBase.set\_kv\_by\_type(\_value\_type, \_key, \_val)

参数 \_value\_type ValueType 值类型 参数 \_key Str 名称 参数 \_val ETypeMeta 自定义值

### LevelComp.gain\_exp

获得经验

LevelComp.gain\_exp(\_killed\_exp)

参数 \_killed\_exp Fixed 经验值

### LevelComp.get\_exp

获取当前经验值

LevelComp.get\_exp()

返回类型 Fixed 经验值

### LevelComp.get\_killed\_exp

获取击杀经验点

LevelComp.get\_killed\_exp()

返回类型 Fixed 击杀经验值

### LevelComp.get\_level

获得当前等级

LevelComp.get\_level()

返回类型 Int 当前等级

### LevelComp.level\_up

升级

LevelComp.level\_up()

### LevelComp.set\_killed\_exp

设置击杀经验点

LevelComp.set\_killed\_exp(\_killed\_exp)

参数 \_killed\_exp Fixed 击杀经验值

### LifeComp.can\_reborn

生物是否可以复活

LifeComp.can\_reborn()

返回类型 Bool 是否可以复活

### LifeComp.change\_hp

改变健康值

LifeComp.change\_hp(\_value)

参数 \_value Fixed 改变健康值

### LifeComp.die

使生物死亡

LifeComp.die(\_dmg\_unit)

参数 \_dmg\_unit Unit 伤害来源

### LifeComp.get\_hp

获取健康值

LifeComp.get\_hp()

返回类型 Fixed 健康值

### LifeComp.get\_hp\_max

获取最大健康值

LifeComp.get\_hp\_max()

返回类型 Fixed 最大健康值

### LifeComp.get\_life

获取当前命数

LifeComp.get\_life()

返回类型 Int 当前命数

### LifeComp.get\_life\_max

获取最大命数

LifeComp.get\_life\_max()

返回类型 Int 当前命数

### LifeComp.is\_die\_status

是否处于死亡状态

LifeComp.is\_die\_status()

返回类型 Bool 处于死亡

### LifeComp.is\_infinite\_reborn

是否无限复活

LifeComp.is\_infinite\_reborn()

返回类型 Bool 是否无限复活

### LifeComp.reborn

使生物复活

LifeComp.reborn(\_immediate)

参数 \_immediate Bool 立即复活

### LifeComp.set\_auto\_reborn\_enabled

设置自动复活

LifeComp.set\_auto\_reborn\_enabled(\_auto\_reborn)

参数 \_auto\_reborn Bool 是否自动复活

### LifeComp.set\_hp\_max

设置最大健康值

LifeComp.set\_hp\_max(\_value)

参数 \_value Fixed 最大健康值

### LifeComp.set\_infinite\_reborn\_enabled

设置无限复活

LifeComp.set\_infinite\_reborn\_enabled(\_enable\_reborn)

参数 \_enable\_reborn Bool 是否无限复活

### LifeComp.set\_life\_count

改变当前命数

LifeComp.set\_life\_count(\_value)

参数 \_value Int 当前命数

### LifeComp.set\_life\_max

改变最大命数

LifeComp.set\_life\_max(\_value)

参数 \_value Int 最大命数

### LifeComp.set\_reborn\_in\_place

设置是否原地复活

LifeComp.set\_reborn\_in\_place(\_reborn\_in\_place, \_reset\_camera)

参数 \_reborn\_in\_place Bool 是否原地复活 参数 \_reset\_camera Bool 是否重置相机

### LifeComp.set\_reborn\_time

设置复活时间

LifeComp.set\_reborn\_time(\_reborn\_time)

参数 \_reborn\_time Fixed 复活时间

### LifeEntity.ai\_command\_alert

控制AI执行警戒命令

LifeEntity.ai\_command\_alert(\_tagert\_pos, \_target\_dir, \_dalay\_time, \_reject\_time, \_move\_mode)

参数 \_tagert\_pos Vector3 目标 参数 \_target\_dir Vector3 朝向 参数 \_dalay\_time Fixed 延迟 参数 \_reject\_time Fixed 厌恶时间 参数 \_move\_mode MoveMode 移动方式

### LifeEntity.ai\_command\_chase\_with\_ability

控制AI执行追击行为(技能)

LifeEntity.ai\_command\_chase\_with\_ability(\_target, \_chase\_range, \_reject\_time, \_action\_distance, \_ability\_key, \_move\_mode, \_action\_count)

参数 \_target LifeEntity 目标 参数 \_chase\_range Fixed 追击范围 参数 \_reject\_time Fixed 厌恶时间 参数 \_action\_distance Fixed 反应距离 参数 \_ability\_key AbilityKey 反应行为 参数 \_move\_mode MoveMode 移动方式 参数 \_action\_count Int 追击次数

### LifeEntity.ai\_command\_chase\_with\_action

控制AI执行追击行为(命令)

LifeEntity.ai\_command\_chase\_with\_action(\_target, \_chase\_range, \_reject\_time, \_action\_distance, \_action\_mode, \_move\_mode, \_action\_count)

参数 \_target LifeEntity 目标 参数 \_chase\_range Fixed 追击范围 参数 \_reject\_time Fixed 厌恶时间 参数 \_action\_distance Fixed 反应距离 参数 \_action\_mode AIBasicCommand 反应行为 参数 \_move\_mode MoveMode 移动方式 参数 \_action\_count Int 追击次数

### LifeEntity.ai\_command\_chase\_with\_equipment

控制AI执行追击行为(物品)

LifeEntity.ai\_command\_chase\_with\_equipment(\_target, \_chase\_range, \_reject\_time, \_action\_distance, \_equipment\_key, \_move\_mode, \_action\_count)

参数 \_target LifeEntity 目标 参数 \_chase\_range Fixed 追击范围 参数 \_reject\_time Fixed 厌恶时间 参数 \_action\_distance Fixed 反应距离 参数 \_equipment\_key EquipmentKey 反应行为 参数 \_move\_mode MoveMode 移动方式 参数 \_action\_count Int 追击次数

### LifeEntity.ai\_command\_follow

控制AI执行跟随命令

LifeEntity.ai\_command\_follow(\_target\_unit, \_follow\_dis, \_tolerate\_dis, \_reject\_time, \_move\_mode)

参数 \_target\_unit Character 目标 参数 \_follow\_dis Fixed 距离 参数 \_tolerate\_dis Fixed 容忍距离 参数 \_reject\_time Fixed 厌恶时间 参数 \_move\_mode MoveMode 移动方式

### LifeEntity.ai\_command\_imitate

控制AI执行模仿命令

LifeEntity.ai\_command\_imitate(\_target\_unit, \_delay, \_disable\_actions)

参数 \_target\_unit Character 目标 参数 \_delay Fixed 延迟 参数 \_disable\_actions ListAIBasicCommand 屏蔽操作

### LifeEntity.ai\_command\_jump

控制AI跳跃

LifeEntity.ai\_command\_jump()

### LifeEntity.ai\_command\_lift

控制AI举起/扔下/投掷

LifeEntity.ai\_command\_lift()

### LifeEntity.ai\_command\_patrol

控制AI执行巡逻命令

LifeEntity.ai\_command\_patrol(\_waypoint, \_reject\_time, \_round\_mode, \_move\_mode)

参数 \_waypoint ListVector3 路径 参数 \_reject\_time Fixed 厌恶时间 参数 \_round\_mode PatrolType 往返模式 参数 \_move\_mode MoveMode 移动方式

### LifeEntity.ai\_command\_pick\_up\_equipment

控制AI拾取物品

LifeEntity.ai\_command\_pick\_up\_equipment(\_target\_equipment, \_move\_mode, \_reject\_time)

参数 \_target\_equipment Equipment 拾取物品 参数 \_move\_mode MoveMode 移动方式 参数 \_reject\_time Fixed 厌恶时间

### LifeEntity.ai\_command\_roll

控制AI滚动

LifeEntity.ai\_command\_roll()

### LifeEntity.ai\_command\_rush

控制AI前扑

LifeEntity.ai\_command\_rush()

### LifeEntity.ai\_command\_start\_move

控制AI单位移动

LifeEntity.ai\_command\_start\_move(\_direction, \_t)

参数 \_direction Vector3 方向 参数 \_t Fixed 时间

### LifeEntity.ai\_command\_start\_move\_high\_priority

控制AI执行高优先级寻路命令

LifeEntity.ai\_command\_start\_move\_high\_priority(\_target\_position, \_duration, \_threshold)

参数 \_target\_position ListVector3 坐标 参数 \_duration Fixed 持续时间 参数 \_threshold Fixed 距离阈值

### LifeEntity.ai\_command\_stop\_move

控制AI单位停止移动

LifeEntity.ai\_command\_stop\_move(\_duration)

参数 \_duration Fixed 时间

### LifeEntity.get\_direction

获取朝向

LifeEntity.get\_direction()

返回类型 Vector3 方向

### LifeEntity.get\_hard\_punch\_threshold

获取生命体大力击倒阈值

LifeEntity.get\_hard\_punch\_threshold()

### LifeEntity.get\_hpbar\_scale\_x

获取生命体血条宽度缩放

LifeEntity.get\_hpbar\_scale\_x()

返回类型 Fixed 宽度缩放

### LifeEntity.get\_hpbar\_scale\_y

获取生命体血条高度缩放

LifeEntity.get\_hpbar\_scale\_y()

返回类型 Fixed 高度缩放

### LifeEntity.get\_lifted\_lifeentity

获取指定生命体当前抓举的生命体

LifeEntity.get\_lifted\_lifeentity()

返回类型 LifeEntity 被抓举的生命体

### LifeEntity.get\_lifted\_obstacle

获取指定生命体当前抓举的组件

LifeEntity.get\_lifted\_obstacle()

返回类型 Obstacle 被抓举的组件

### LifeEntity.get\_owner

获取生命体控制玩家

LifeEntity.get\_owner()

返回类型 Role 控制玩家

### LifeEntity.get\_punch\_threshold

获取生命体击倒阈值

LifeEntity.get\_punch\_threshold()

### LifeEntity.is\_draggable

获取生命体是否可拖动

LifeEntity.is\_draggable()

返回类型 Bool 可拖动

### LifeEntity.is\_ghost\_mode

生命体是否进入魂蛋模式

LifeEntity.is\_ghost\_mode()

返回类型 Bool 是否处于魂蛋模式

### LifeEntity.is\_jumping

生命体是否在跳跃中

LifeEntity.is\_jumping()

返回类型 Bool 是否在跳跃中

### LifeEntity.is\_moving

生命体是否在移动中

LifeEntity.is\_moving()

返回类型 Bool 是否在移动中

### LifeEntity.is\_rushing

生命体是否在飞扑中

LifeEntity.is\_rushing()

返回类型 Bool 是否在飞扑中

### LifeEntity.is\_touchable

获取生命体是否可点击

LifeEntity.is\_touchable()

返回类型 Bool 可点击

### LifeEntity.jump

命令角色跳跃

LifeEntity.jump()

### LifeEntity.play\_face\_expression

播放面部表情

LifeEntity.play\_face\_expression(\_emoji\_key, \_show\_time)

参数 \_emoji\_key EmojiKey 表情 参数 \_show\_time Fixed 持续时间

### LifeEntity.reset\_model

还原模型变化

LifeEntity.reset\_model()

### LifeEntity.set\_ai\_move\_threshold

设置寻路阈值

LifeEntity.set\_ai\_move\_threshold(\_threshold)

参数 \_threshold Fixed 距离

### LifeEntity.set\_direction

设置朝向

LifeEntity.set\_direction(\_face\_dir)

参数 \_face\_dir Vector3 方向

### LifeEntity.set\_hard\_punch\_threshold

设置生命体大力击倒阈值

LifeEntity.set\_hard\_punch\_threshold(\_punch\_threshold)

参数 \_punch\_threshold Fixed 击倒阈值

### LifeEntity.set\_hpbar\_scale

设置生命体血条缩放

LifeEntity.set\_hpbar\_scale(\_hpbar\_scale\_x, \_hpbar\_scale\_y)

参数 \_hpbar\_scale\_x Fixed 宽度缩放 参数 \_hpbar\_scale\_y Fixed 高度缩放

### LifeEntity.set\_mass\_bar\_visible

设置质量条是否显示

LifeEntity.set\_mass\_bar\_visible(\_visible)

参数 \_visible Bool 是否显示

### LifeEntity.set\_model\_by\_character

根据角色设置模型

LifeEntity.set\_model\_by\_character(\_character, \_include\_ugc\_model, \_inherit\_scale, \_inherit\_capsule\_size)

参数 \_character Character 角色 参数 \_include\_ugc\_model Bool 是否包含自定义形象 参数 \_inherit\_scale Bool 是否继承缩放 参数 \_inherit\_capsule\_size Bool 是否继承胶囊体尺寸

### LifeEntity.set\_model\_by\_creature

根据生物设置模型

LifeEntity.set\_model\_by\_creature(\_creature, \_include\_custom\_model, \_inherit\_scale, \_inherit\_capsule\_size)

参数 \_creature Creature 生物 参数 \_include\_custom\_model Bool 是否包含自定义形象 参数 \_inherit\_scale Bool 是否继承缩放 参数 \_inherit\_capsule\_size Bool 是否继承胶囊体尺寸

### LifeEntity.set\_model\_by\_creature\_key

根据生物预设设置模型

LifeEntity.set\_model\_by\_creature\_key(\_creature\_key, \_include\_custom\_model, \_inherit\_scale, \_inherit\_capsule\_size)

参数 \_creature\_key CreatureKey 生物编号 参数 \_include\_custom\_model Bool 是否包含自定义形象 参数 \_inherit\_scale Bool 是否继承缩放 参数 \_inherit\_capsule\_size Bool 是否继承胶囊体

### LifeEntity.set\_punch\_threshold

设置生命体击倒阈值

LifeEntity.set\_punch\_threshold(\_punch\_threshold)

参数 \_punch\_threshold Fixed 击倒阈值

### LifeEntity.set\_search\_enemy\_focus\_target

设置搜敌集火目标

LifeEntity.set\_search\_enemy\_focus\_target(\_target)

参数 \_target LifeEntity 目标

### LifeEntity.set\_search\_enemy\_priority\_value\_by\_tag

设置搜敌优先级值by标签

LifeEntity.set\_search\_enemy\_priority\_value\_by\_tag(\_tag, \_priority)

参数 \_tag Str 标签 参数 \_priority Int 优先级

### LifeEntity.set\_search\_enemy\_priority\_value\_by\_unit

设置搜敌优先级值by单位实体

LifeEntity.set\_search\_enemy\_priority\_value\_by\_unit(\_unit, \_priority)

参数 \_unit LifeEntity 单位实体 参数 \_priority Int 优先级

### LifeEntity.set\_search\_enemy\_priority\_value\_by\_unit\_key

设置搜敌优先级值by预设编号

LifeEntity.set\_search\_enemy\_priority\_value\_by\_unit\_key(\_unit\_key, \_priority)

参数 \_unit\_key CreatureKey 预设编号 参数 \_priority Int 优先级

### LifeEntity.set\_search\_enemy\_priority\_value\_by\_unit\_type

设置搜敌优先级值by单位类型

LifeEntity.set\_search\_enemy\_priority\_value\_by\_unit\_type(\_unit\_prefab\_type, \_priority)

参数 \_unit\_prefab\_type UnitType 单位类型 参数 \_priority Int 优先级

### LifeEntity.start\_ai

激活AI

LifeEntity.start\_ai()

### LifeEntity.start\_move\_by\_direction

命令生命体移动

LifeEntity.start\_move\_by\_direction(\_direction, \_duration)

参数 \_direction Vector3 移动方向 参数 \_duration Fixed 持续时间

### LifeEntity.start\_move\_to\_pos\_with\_threshold

命令生命体移动到坐标点

LifeEntity.start\_move\_to\_pos\_with\_threshold(\_target\_pos, \_duration, \_threshold)

参数 \_target\_pos Point3 目标点 参数 \_duration Fixed 持续时间 参数 \_threshold Fixed 容错距离

### LifeEntity.stop\_ai

暂停AI

LifeEntity.stop\_ai()

### LifeEntity.swap\_equipment\_slot

交换物品槽位

LifeEntity.swap\_equipment\_slot(\_equipment, \_slot\_type, \_slot)

参数 \_equipment Equipment 物品 参数 \_slot\_type EquipmentSlotType 槽位类型 参数 \_slot EquipmentSlot 槽位

### LifeEntity.try\_exit\_vehicle

生命体尝试下载具

LifeEntity.try\_exit\_vehicle()

### LiftComp.get\_lift\_cooldown

获取举起冷却时间

LiftComp.get\_lift\_cooldown()

返回类型 Fixed 定点数

### LiftComp.get\_lift\_remaining\_cooldown

获取举起剩余冷却时间

LiftComp.get\_lift\_remaining\_cooldown()

返回类型 Fixed 定点数

### LiftComp.is\_lift\_status

是否处于抓举状态

LiftComp.is\_lift\_status()

返回类型 Bool 抓举

### LiftComp.lift\_unit

举起单位

LiftComp.lift\_unit(\_unit)

参数 \_unit Unit 被抓举单位

### LiftComp.set\_lift\_cooldown

设置举起冷却时间

LiftComp.set\_lift\_cooldown(\_cd\_time)

参数 \_cd\_time Fixed 时间

### LiftComp.set\_lift\_remaining\_cooldown

设置举起剩余冷却时间

LiftComp.set\_lift\_remaining\_cooldown(\_time)

参数 \_time Fixed 时间

### LiftedComp.is\_lifted\_enabled

获取是否可抓举

LiftedComp.is\_lifted\_enabled()

返回类型 Bool 是否可抓举

### LiftedComp.is\_lifted\_status

是否处于被抓举

LiftedComp.is\_lifted\_status()

返回类型 Bool 被抓举

### LiftedComp.set\_custom\_thrown\_force

设置自定义投掷力量

LiftedComp.set\_custom\_thrown\_force(\_force)

参数 \_force Fixed 力量

### LiftedComp.set\_custom\_thrown\_force\_enabled

设置是否自定义投掷力量

LiftedComp.set\_custom\_thrown\_force\_enabled(\_enable)

参数 \_enable Bool 是否自定义

### LiftedComp.set\_lifted\_enabled

设置是否可抓举

LiftedComp.set\_lifted\_enabled(\_enable)

参数 \_enable Bool 是否可被抓举

### Modifier.add\_duration

增加效果的持续时间

Modifier.add\_duration(\_add\_time)

参数 \_add\_time Fixed 增加时间

### Modifier.add\_stack\_count

增加效果层数

Modifier.add\_stack\_count(\_stack\_count\_add)

参数 \_stack\_count\_add Int 层数

### Modifier.get\_desc

获取效果描述

Modifier.get\_desc()

返回类型 Str 效果描述

### Modifier.get\_key

获得效果编号

Modifier.get\_key()

返回类型 ModifierKey 效果编号

### Modifier.get\_max\_stack\_count

获取效果的最大层数

Modifier.get\_max\_stack\_count()

返回类型 Str 层数

### Modifier.get\_name

获取效果名称

Modifier.get\_name()

返回类型 Str 效果名称

### Modifier.get\_owner\_ability

获取所属技能

Modifier.get\_owner\_ability()

返回类型 Ability 所属技能

### Modifier.get\_owner\_character

获取效果携带角色

Modifier.get\_owner\_character()

返回类型 Character 角色

### Modifier.get\_owner\_creature

获取效果携带生物

Modifier.get\_owner\_creature()

返回类型 Creature 生物

### Modifier.get\_owner\_life\_entity

获取携带效果的生命体

Modifier.get\_owner\_life\_entity()

返回类型 LifeEntity 生命体

### Modifier.get\_owner\_unit

获取效果携带者

Modifier.get\_owner\_unit()

返回类型 Unit 效果携带者

### Modifier.get\_releaser\_unit

获取效果释放者

Modifier.get\_releaser\_unit()

返回类型 Unit 效果释放者

### Modifier.get\_remain\_duration

获取效果剩余持续时间

Modifier.get\_remain\_duration()

返回类型 Fixed 剩余持续时间

### Modifier.get\_stack\_count

获取效果当前层数

Modifier.get\_stack\_count()

返回类型 Str 层数

### Modifier.set\_remain\_duration

设置效果剩余时间

Modifier.set\_remain\_duration(\_remain\_duration)

参数 \_remain\_duration Fixed 剩余持续时间

### Modifier.set\_stack\_count

设置效果层数

Modifier.set\_stack\_count(\_stack\_count\_add)

参数 \_stack\_count\_add Int 层数

### ModifierComp.add\_modifier

添加效果

ModifierComp.add\_modifier(\_modifier\_id)

参数 \_modifier\_id ModifierKey 效果编号

返回类型 Modifier 是否添加成功

### ModifierComp.add\_modifier\_by\_key

添加效果

ModifierComp.add\_modifier\_by\_key(\_modifier\_id, \_params\_dict)

参数 \_modifier\_id ModifierKey 效果编号 参数 \_params\_dict Dict 额外参数

返回类型 Modifier 效果对象

### ModifierComp.destroy\_modifier

销毁效果

ModifierComp.destroy\_modifier(\_modifier)

参数 \_modifier Modifier 效果对象

### ModifierComp.get\_modifier\_by\_modifier\_key

获取单位效果

ModifierComp.get\_modifier\_by\_modifier\_key(\_modifier\_id)

参数 \_modifier\_id ModifierKey 效果ID

返回类型 Modifier 效果对象

### ModifierComp.get\_modifiers

获取单位所有效果

ModifierComp.get\_modifiers()

返回类型 ListModifier 效果

### ModifierComp.has\_modifier\_by\_key

是否拥有指定编号的效果

ModifierComp.has\_modifier\_by\_key(\_modifier\_key)

参数 \_modifier\_key ModifierKey 效果编号

返回类型 Bool 是否拥有

### ModifierComp.remove\_modifier\_by\_key

移除效果

ModifierComp.remove\_modifier\_by\_key(\_modifier\_id)

参数 \_modifier\_id ModifierKey 效果编号

### MoveStatusComp.is\_fling\_status

是否滚动

MoveStatusComp.is\_fling\_status()

返回类型 Bool 布尔

### MoveStatusComp.is\_lost\_control\_status

是否失控

MoveStatusComp.is\_lost\_control\_status()

返回类型 Bool 布尔

### MoveStatusComp.start\_face\_lock\_target

开始锁定面向目标

MoveStatusComp.start\_face\_lock\_target(\_target\_unit, \_time)

参数 \_target\_unit Unit 锁定对象 参数 \_time Fixed 持续时间

### MoveStatusComp.stop\_face\_lock\_target

结束锁定面向目标

MoveStatusComp.stop\_face\_lock\_target()

### Obstacle.get\_billboard\_font\_size

获取公告板文本字体大小

Obstacle.get\_billboard\_font\_size()

返回类型 Int 公告板字体大小

### Obstacle.get\_billboard\_text

获取公告板文本内容

Obstacle.get\_billboard\_text()

返回类型 Str 公告板内容

### Obstacle.get\_bound\_equipment

返回绑定的物品

Obstacle.get\_bound\_equipment()

返回类型 Equipment 物品

### Obstacle.get\_chess\_rank

获取牌数(对象只能为麻将/扑克)

Obstacle.get\_chess\_rank()

返回类型 Int 牌数

### Obstacle.is\_draggable

获取组件是否可拖动

Obstacle.is\_draggable()

返回类型 Bool 是否可拖动

### Obstacle.is\_touchable

获取组件是否可点击

Obstacle.is\_touchable()

返回类型 Bool 是否可点击

### Obstacle.reset\_collision\_limit

重置组件碰撞限制

Obstacle.reset\_collision\_limit(\_limit\_type)

参数 \_limit\_type CollisionLimitType 碰撞限制类型

### Obstacle.set\_billboard\_font\_size

设置公告板文本字体大小

Obstacle.set\_billboard\_font\_size(\_font\_size)

参数 \_font\_size Int 字体大小

### Obstacle.set\_billboard\_text

设置公告板文本内容

Obstacle.set\_billboard\_text(\_content)

参数 \_content Str 文本内容

### Obstacle.set\_billboard\_text\_color

设置公告板文本颜色

Obstacle.set\_billboard\_text\_color(\_color, \_gradient\_color\_1, \_gradient\_color\_2, \_gradient\_color\_3, \_gradient\_color\_4)

参数 \_color Color 文本颜色 参数 \_gradient\_color\_1 Color 渐变色1 参数 \_gradient\_color\_2 Color 渐变色2 参数 \_gradient\_color\_3 Color 渐变色3 参数 \_gradient\_color\_4 Color 渐变色4

### Obstacle.set\_collision\_count\_limit

设置组件碰撞次数限制

Obstacle.set\_collision\_count\_limit(\_limit\_type, \_value)

参数 \_limit\_type CollisionLimitType 碰撞限制类型 参数 \_value Int 值

### Obstacle.set\_collision\_interval\_limit

设置组件碰撞间隔限制

Obstacle.set\_collision\_interval\_limit(\_limit\_type, \_value)

参数 \_limit\_type CollisionLimitType 碰撞限制类型 参数 \_value Fixed 值

### Obstacle.set\_draggable

设置组件是否可拖动

Obstacle.set\_draggable(\_enabled)

参数 \_enabled Bool 是否可拖动

### Obstacle.set\_ranklist\_score

设置场景排行榜分数

Obstacle.set\_ranklist\_score(\_role, \_score)

参数 \_role Role 玩家 参数 \_score Int 分数

### OwnerComp.change\_owner

修改所属玩家

OwnerComp.change\_owner(\_role)

参数 \_role Role 所属玩家

### OwnerComp.get\_owner\_role

获取所属玩家

OwnerComp.get\_owner\_role()

返回类型 Role 所属玩家

### Role.add\_achievement\_progress

增加成就进度

Role.add\_achievement\_progress(\_event\_id, \_add\_count)

参数 \_event\_id Achievement 成就 参数 \_add\_count Int 成就进度

### Role.add\_score

增加玩家积分

Role.add\_score(\_add\_score)

参数 \_add\_score Int 积分

### Role.consume\_commodity

消耗玩家指定数量道具

Role.consume\_commodity(\_commodity\_id, \_num)

参数 \_commodity\_id UgcCommodity 道具 参数 \_num Int 数量

### Role.disable\_unit\_fresnel

关闭单位菲尼尔效果

Role.disable\_unit\_fresnel(\_unit)

参数 \_unit Unit 单位

### Role.disable\_unit\_mask

关闭单位蒙版

Role.disable\_unit\_mask(\_unit)

参数 \_unit Unit 单位

### Role.disable\_unit\_outline

关闭单位描边

Role.disable\_unit\_outline(\_unit)

参数 \_unit Unit 单位

### Role.enter\_watch\_mode

玩家进入观战

Role.enter\_watch\_mode(\_camp\_limit, \_exit\_visible)

参数 \_camp\_limit Bool 是否限制阵营观战 参数 \_exit\_visible Bool 是否支持手动退出

### Role.exit\_watch\_mode

玩家退出观战

Role.exit\_watch\_mode()

### Role.game\_lose\_and\_show\_result\_panel

玩家游戏失败并显示失败界面

Role.game\_lose\_and\_show\_result\_panel()

### Role.game\_win\_and\_show\_result\_panel

玩家游戏胜利并显示胜利界面

Role.game\_win\_and\_show\_result\_panel()

### Role.get\_achievement\_progress

获取成就进度

Role.get\_achievement\_progress(\_event\_id)

参数 \_event\_id Achievement 成就

返回类型 Int 成就进度

### Role.get\_archive\_by\_type

获取存档值

Role.get\_archive\_by\_type(\_archive\_type, \_key)

参数 \_archive\_type ArchiveType 存档类型 参数 \_key Archive 存档

返回类型 ETypeMeta 存档值

### Role.get\_camera\_direction

获取玩家相机的朝向(需要开启玩家相机旋转同步)

Role.get\_camera\_direction()

返回类型 Vector3 相机朝向

### Role.get\_camera\_rotation

获取玩家相机的旋转(需要开启玩家相机旋转同步)

Role.get\_camera\_rotation()

返回类型 Quaternion 相机旋转

### Role.get\_camp

获取玩家阵营

Role.get\_camp()

返回类型 Camp 阵营

### Role.get\_commodity\_count

玩家拥有道具数量

Role.get\_commodity\_count(\_commodity\_id)

参数 \_commodity\_id UgcCommodity 道具

返回类型 Int 拥有道具数量

### Role.get\_ctrl\_unit

获取控制单位

Role.get\_ctrl\_unit()

返回类型 Character 单位

### Role.get\_game\_result

获取玩家游戏结果

Role.get\_game\_result()

返回类型 GameResult 游戏结局

### Role.get\_name

获取玩家昵称

Role.get\_name()

返回类型 Str 名字

### Role.get\_roleid

获取玩家ID

Role.get\_roleid()

返回类型 RoleID 玩家ID

### Role.get\_score

获取玩家积分

Role.get\_score()

返回类型 Int 积分

### Role.get\_voice\_volume

获取语音音量

Role.get\_voice\_volume()

返回类型 Fixed 语音音量

### Role.has\_commodity

玩家是否拥有道具

Role.has\_commodity(\_commodity\_id)

参数 \_commodity\_id UgcCommodity 道具

返回类型 Bool 是否拥有道具

### Role.has\_saved\_archive

玩家是否记录过存档

Role.has\_saved\_archive()

返回类型 Bool 是否记录过存档

### Role.is\_achievement\_completed

成就是否完成

Role.is\_achievement\_completed(\_event\_id)

参数 \_event\_id Achievement 成就

返回类型 Bool 是否完成

### Role.is\_gallery\_vip

是否是乐园会员

Role.is\_gallery\_vip()

返回类型 Bool 是否是乐园会员

### Role.is\_lost

玩家是否失败

Role.is\_lost()

返回类型 Bool 玩家是否失败

### Role.is\_map\_favorited

是否收藏本地图

Role.is\_map\_favorited()

返回类型 Bool 是否收藏

### Role.is\_map\_liked

是否点赞本地图

Role.is\_map\_liked()

返回类型 Bool 是否点赞

### Role.is\_online

玩家是否在线

Role.is\_online()

返回类型 Bool 是否在线

### Role.is\_pass\_premium\_vip

是否是派对手册进阶会员

Role.is\_pass\_premium\_vip()

返回类型 Bool 是否是派对手册进阶会员

### Role.is\_subscribed\_map\_author

玩家是否订阅地图作者

Role.is\_subscribed\_map\_author()

返回类型 Bool 是否订阅

### Role.is\_watch\_mode

玩家进入观战

Role.is\_watch\_mode()

返回类型 Bool 是否处于观战模式

### Role.is\_won

玩家是否胜利

Role.is\_won()

返回类型 Bool 玩家是否胜利

### Role.lose

玩家游戏失败

Role.lose()

### Role.pause\_camera\_motor

暂停玩家相机运动

Role.pause\_camera\_motor()

### Role.play\_2d\_sound\_with\_params

玩家播放2D音效

Role.play\_2d\_sound\_with\_params(\_event\_id, \_duration, \_volume, \_speed)

参数 \_event\_id SoundID 音效ID 参数 \_duration Fixed 持续时间 参数 \_volume Fixed 音量 参数 \_speed Fixed 播放速度

返回类型 SoundID 音效ID

### Role.play\_advertisement\_with\_event

播放广告

Role.play\_advertisement\_with\_event(\_success\_event, \_fail\_event, \_ad\_tag, \_success\_data, \_fail\_data)

参数 \_success\_event Str 成功事件 参数 \_fail\_event Str 失败事件 参数 \_ad\_tag Str 广告标签 参数 \_success\_data Dict 成功附带参数 参数 \_fail\_data Dict 失败附带参数

### Role.play\_montage

播放指定剧情动画

Role.play\_montage(\_montage\_key, \_start\_time, \_play\_to\_end, \_play\_time)

参数 \_montage\_key MontageKey 剧情动画编号 参数 \_start\_time Fixed 起始时间 参数 \_play\_to\_end Bool 是否播完 参数 \_play\_time Fixed 播放时长

### Role.play\_screen\_sfx

播放屏幕特效

Role.play\_screen\_sfx(\_sfx\_key, \_duration, \_rate)

参数 \_sfx\_key SfxKey 特效编号 参数 \_duration Fixed 持续时间 参数 \_rate Fixed 播放速率

返回类型 SfxID 特效ID

### Role.play\_ui\_effect

播放界面动效

Role.play\_ui\_effect(\_effect\_node)

参数 \_effect\_node EEffectNode UI动效

### Role.reset\_camera

重置玩家相机

Role.reset\_camera(\_reset\_angle, \_reset\_bind, \_reset\_point, \_reset\_prop\_pitch)

参数 \_reset\_angle Bool 重置相机角度 参数 \_reset\_bind Bool 重置相机模式 参数 \_reset\_point Bool 重置相机相对于焦点的位置 参数 \_reset\_prop\_pitch Bool 重置俯仰角范围

### Role.resume\_camera\_motor

恢复玩家相机运动

Role.resume\_camera\_motor()

### Role.send\_track\_data\_change

发送埋点数据变化

Role.send\_track\_data\_change(\_track\_data\_key, \_change\_num)

参数 \_track\_data\_key Str 埋点key 参数 \_change\_num Int 数据变化

### Role.send\_ui\_custom\_event

发送UI自定义消息

Role.send\_ui\_custom\_event(\_event\_name, \_data)

参数 \_event\_name Str 自定义事件名 参数 \_data Dict 附带参数

### Role.set\_achievement\_progress

设置成就进度

Role.set\_achievement\_progress(\_event\_id, \_count)

参数 \_event\_id Achievement 成就 参数 \_count Int 成就进度

### Role.set\_archive\_by\_type

设置存档值

Role.set\_archive\_by\_type(\_archive\_type, \_key, \_val)

参数 \_archive\_type ArchiveType 存档类型 参数 \_key Archive 存档 参数 \_val ETypeMeta 存档值

### Role.set\_archive\_point

设置存档点坐标

Role.set\_archive\_point(\_position, \_priority, \_direction)

参数 \_position Point3 坐标 参数 \_priority Int 复活优先级 参数 \_direction Vector3 朝向

### Role.set\_bagslot\_related\_lifeentity

设置物品格关联生命体

Role.set\_bagslot\_related\_lifeentity(\_bag\_slot, \_life\_entity)

参数 \_bag\_slot EBagSlot UI物品格 参数 \_life\_entity LifeEntity 生命体

### Role.set\_battle\_shop\_visible

设置玩家商店显示

Role.set\_battle\_shop\_visible(\_battle\_shop\_id, \_visible)

参数 \_battle\_shop\_id BattleShopKey 商店 参数 \_visible Bool 显示/隐藏

### Role.set\_blind\_corner

玩家设置暗角

Role.set\_blind\_corner(\_enable, \_strength, \_color)

参数 \_enable Bool 启用 参数 \_strength Fixed 强度 参数 \_color Color 颜色

### Role.set\_button\_enabled

设置按钮控件的状态

Role.set\_button\_enabled(\_button, \_enabled)

参数 \_button EButton UI按钮 参数 \_enabled Bool 状态

### Role.set\_button\_font\_size

设置UI按钮节点文字字号

Role.set\_button\_font\_size(\_key, \_font\_size)

参数 \_key EButton UI按钮节点 参数 \_font\_size Fixed 字号

### Role.set\_button\_normal\_image

设置UI按钮节点常态图片

Role.set\_button\_normal\_image(\_button, \_image\_key)

参数 \_button EButton UI按钮节点 参数 \_image\_key ImageKey 图片

### Role.set\_button\_pressed\_image

设置UI按钮节点按下图片

Role.set\_button\_pressed\_image(\_button, \_image\_key)

参数 \_button EButton UI按钮节点 参数 \_image\_key ImageKey 图片

### Role.set\_button\_text

设置UI按钮节点文本

Role.set\_button\_text(\_button, \_text)

参数 \_button EButton UI按钮节点 参数 \_text Str 文本

### Role.set\_button\_text\_color

设置UI按钮节点文字颜色

Role.set\_button\_text\_color(\_button, \_text\_color)

参数 \_button EButton UI按钮节点 参数 \_text\_color Color 颜色

### Role.set\_camera\_bind\_mode

设置玩家相机的模式

Role.set\_camera\_bind\_mode(\_mode)

参数 \_mode CameraBindMode 模式

### Role.set\_camera\_draggable

设置玩家相机是否可拖动

Role.set\_camera\_draggable(\_draggable)

参数 \_draggable Bool 可拖动

### Role.set\_camera\_gyroscope\_control\_enabled

设置玩家陀螺仪控制镜头

Role.set\_camera\_gyroscope\_control\_enabled(\_is\_control)

参数 \_is\_control Bool 陀螺仪控制

### Role.set\_camera\_lock\_position

设置玩家相机的绑定坐标

Role.set\_camera\_lock\_position(\_pos)

参数 \_pos Point3 点

### Role.set\_camera\_projection\_type

设置玩家相机的投影类型

Role.set\_camera\_projection\_type(\_projection\_type)

参数 \_projection\_type CameraProjectionType 投影类型

### Role.set\_camera\_property

设置玩家相机的属性

Role.set\_camera\_property(\_property, \_value)

参数 \_property CameraPropertyType 属性 参数 \_value Fixed 值

### Role.set\_camera\_rotation\_by\_direction

设置玩家相机面向指定朝向

Role.set\_camera\_rotation\_by\_direction(\_target\_dir, \_duration)

参数 \_target\_dir Vector3 目标方向 参数 \_duration Fixed 用时

### Role.set\_camera\_rotation\_sync\_enabled

设置是否开启玩家相机旋转同步

Role.set\_camera\_rotation\_sync\_enabled(\_enabled)

参数 \_enabled Bool 是否同步

### Role.set\_goods\_panel\_visible

设置付费道具商店可见性

Role.set\_goods\_panel\_visible(\_visible)

参数 \_visible Bool 可见性

### Role.set\_gyroscope\_control\_unit

设置玩家陀螺仪控制组件

Role.set\_gyroscope\_control\_unit(\_is\_control, \_unit)

参数 \_is\_control Bool 是否由陀螺仪控制 参数 \_unit Unit 单位

### Role.set\_gyroscope\_sync\_enabled

设置监听陀螺仪信息

Role.set\_gyroscope\_sync\_enabled(\_enabled)

参数 \_enabled Bool 是否监听

### Role.set\_image\_color

设置UI图片颜色

Role.set\_image\_color(\_image, \_image\_color, \_transition\_time)

参数 \_image EImage UI图片节点 参数 \_image\_color Color 颜色 参数 \_transition\_time Fixed 变化时间

### Role.set\_image\_texture\_by\_key\_with\_auto\_resize

设置UI图片节点图片

Role.set\_image\_texture\_by\_key\_with\_auto\_resize(\_image, \_image\_key, \_reset\_size)

参数 \_image EImage UI图片节点 参数 \_image\_key ImageKey 图片 参数 \_reset\_size Bool 是否重置大小

### Role.set\_image\_texture\_with\_auto\_resize

设置UI图片节点图片

Role.set\_image\_texture\_with\_auto\_resize(\_image, \_image\_path, \_reset\_size)

参数 \_image EImage UI图片节点 参数 \_image\_path Str 图片 参数 \_reset\_size Bool 是否重置大小

### Role.set\_input\_field\_text

设置UI输入节点文本

Role.set\_input\_field\_text(\_input\_field, \_text)

参数 \_input\_field EInputField UI输入节点 参数 \_text Str 文本

### Role.set\_label\_background\_color

设置UI文本节点背景颜色

Role.set\_label\_background\_color(\_label, \_color, \_transition\_time)

参数 \_label ELabel UI文本节点 参数 \_color Color 颜色 参数 \_transition\_time Fixed 变化时间

### Role.set\_label\_background\_opacity

设置UI文本节点背景不透明度

Role.set\_label\_background\_opacity(\_label, \_opacity, \_transition\_time)

参数 \_label ELabel UI文本节点 参数 \_opacity Fixed 不透明度 参数 \_transition\_time Fixed 变化时间

### Role.set\_label\_color

设置UI文本节点的字体颜色

Role.set\_label\_color(\_label, \_color, \_transition\_time)

参数 \_label ELabel UI文本节点 参数 \_color Color 颜色 参数 \_transition\_time Fixed 变化时间

### Role.set\_label\_font

设置UI文本节点字体

Role.set\_label\_font(\_label, \_font\_key)

参数 \_label ELabel UI文本节点 参数 \_font\_key FontKey 字体key

### Role.set\_label\_font\_size

设置UI文本节点的字体大小

Role.set\_label\_font\_size(\_label, \_font\_size, \_transition\_time)

参数 \_label ELabel UI文本节点 参数 \_font\_size Int 字号 参数 \_transition\_time Fixed 变化时间

### Role.set\_label\_outline\_color

设置UI文本节点的描边颜色

Role.set\_label\_outline\_color(\_label, \_color)

参数 \_label ELabel UI文本节点 参数 \_color Color 描边颜色

### Role.set\_label\_outline\_enabled

设置UI文本节点的描边是否开启

Role.set\_label\_outline\_enabled(\_label, \_enable)

参数 \_label ELabel UI文本节点 参数 \_enable Bool 是否开启描边

### Role.set\_label\_outline\_opacity

设置UI文本节点的描边不透明度

Role.set\_label\_outline\_opacity(\_label, \_opacity)

参数 \_label ELabel UI文本节点 参数 \_opacity Fixed 描边不透明度

### Role.set\_label\_outline\_width

设置UI文本节点的描边大小

Role.set\_label\_outline\_width(\_label, \_width)

参数 \_label ELabel UI文本节点 参数 \_width Fixed 描边大小

### Role.set\_label\_shadow\_color

设置UI文本节点的阴影颜色

Role.set\_label\_shadow\_color(\_label, \_color)

参数 \_label ELabel UI文本节点 参数 \_color Color 阴影颜色

### Role.set\_label\_shadow\_enabled

设置UI文本节点的阴影是否开启

Role.set\_label\_shadow\_enabled(\_label, \_enable)

参数 \_label ELabel UI文本节点 参数 \_enable Bool 是否开启阴影

### Role.set\_label\_shadow\_x\_offset

设置UI文本节点的阴影x偏移

Role.set\_label\_shadow\_x\_offset(\_label, \_offset)

参数 \_label ELabel UI文本节点 参数 \_offset Fixed x方向偏移

### Role.set\_label\_shadow\_y\_offset

设置UI文本节点的阴影y偏移

Role.set\_label\_shadow\_y\_offset(\_label, \_offset)

参数 \_label ELabel UI文本节点 参数 \_offset Fixed y方向偏移

### Role.set\_label\_text

设置UI文本节点的文本

Role.set\_label\_text(\_label, \_text)

参数 \_label ELabel UI文本节点 参数 \_text Str 文本

### Role.set\_name\_visible

设置玩家昵称可见性

Role.set\_name\_visible(\_visible)

参数 \_visible Bool 是否可见

### Role.set\_node\_touch\_enabled

设置UI节点交互开关

Role.set\_node\_touch\_enabled(\_node, \_touch\_enabled)

参数 \_node ENode UI节点 参数 \_touch\_enabled Bool 交互开关

### Role.set\_node\_visible

设置UI节点可见性

Role.set\_node\_visible(\_node, \_visible)

参数 \_node ENode UI节点 参数 \_visible Bool 可见性

### Role.set\_progressbar\_current

设置UI进度条节点进度

Role.set\_progressbar\_current(\_progress\_bar, \_current)

参数 \_progress\_bar EProgressbar UI进度条节点 参数 \_current Int 进度

### Role.set\_progressbar\_max

设置UI进度条节点最大进度

Role.set\_progressbar\_max(\_progress\_bar, \_max)

参数 \_progress\_bar EProgressbar UI进度条节点 参数 \_max Int 最大进度

### Role.set\_progressbar\_min

设置UI进度条最小进度

Role.set\_progressbar\_min(\_key, \_min)

参数 \_key EProgressbar 进度条节点 参数 \_min Int 最小进度

### Role.set\_progressbar\_transition

设置UI进度条节点过渡

Role.set\_progressbar\_transition(\_progress\_bar, \_current, \_transition\_time)

参数 \_progress\_bar EProgressbar UI进度条节点 参数 \_current Int 进度 参数 \_transition\_time Fixed 过渡时间

### Role.set\_role\_ctrl\_enabled

设置玩家控制开启/关闭

Role.set\_role\_ctrl\_enabled(\_enable)

参数 \_enable Bool 开启/关闭

### Role.set\_score

设置玩家积分

Role.set\_score(\_score)

参数 \_score Int 积分

### Role.set\_ui\_opacity

设置UI节点不透明度

Role.set\_ui\_opacity(\_node, \_opacity)

参数 \_node ENode UI节点 参数 \_opacity Fixed 不透明度

### Role.set\_unit\_fresnel

设置单位菲尼尔效果

Role.set\_unit\_fresnel(\_unit, \_fresnel\_scale, \_color, \_intensity)

参数 \_unit Unit 单位 参数 \_fresnel\_scale Fixed 菲尼尔系数 参数 \_color Color 颜色 参数 \_intensity Int 强度

### Role.set\_unit\_fresnel\_gradual

设置单位菲尼尔效果

Role.set\_unit\_fresnel\_gradual(\_unit, \_fresnel\_scale, \_color, \_intensity, \_duration)

参数 \_unit Unit 单位 参数 \_fresnel\_scale Fixed 菲尼尔系数 参数 \_color Color 颜色 参数 \_intensity Int 强度 参数 \_duration Fixed 用时

### Role.set\_unit\_mask

设置单位蒙版

Role.set\_unit\_mask(\_unit, \_color)

参数 \_unit Unit 单位 参数 \_color Color 颜色

### Role.set\_unit\_outline

设置单位描边

Role.set\_unit\_outline(\_unit, \_width, \_color)

参数 \_unit Unit 单位 参数 \_width Int 粗细 参数 \_color Color 颜色

### Role.set\_unit\_see\_through\_enabled

设置单位穿透显示

Role.set\_unit\_see\_through\_enabled(\_unit, \_enabled)

参数 \_unit Unit 单位 参数 \_enabled Bool 是否穿透显示

### Role.set\_unit\_visible

设置单位对玩家可见性

Role.set\_unit\_visible(\_unit, \_is\_visible)

参数 \_unit Unit 单位 参数 \_is\_visible Bool 是否显示

### Role.set\_voice\_volume\_sync\_enabled

设置是否开启语音音量同步

Role.set\_voice\_volume\_sync\_enabled(\_enabled)

参数 \_enabled Bool 是否同步

### Role.shake\_camera

设置玩家屏幕震动

Role.shake\_camera(\_shake\_type, \_shake\_max\_amplitude, \_shake\_time, \_shake\_source, \_shake\_frequency, \_shake\_time\_decay, \_shake\_effect\_scope, \_shake\_undamped\_scope, \_shake\_distance\_decay)

参数 \_shake\_type CameraShakeType 震动方向 参数 \_shake\_max\_amplitude Fixed 震幅 参数 \_shake\_time Fixed 震动时间 参数 \_shake\_source Unit 震源 参数 \_shake\_frequency Fixed 频率 参数 \_shake\_time\_decay Fixed 时间衰减 参数 \_shake\_effect\_scope Fixed 生效范围 参数 \_shake\_undamped\_scope Fixed 不衰减范围 参数 \_shake\_distance\_decay Fixed 距离衰减

### Role.show\_bag\_panel

设置玩家的背包界面显隐

Role.show\_bag\_panel(\_visible)

参数 \_visible Bool 是否显示

### Role.show\_goods\_purchase\_panel

玩家显示指定商品购买界面

Role.show\_goods\_purchase\_panel(\_raw\_goods\_id, \_show\_time)

参数 \_raw\_goods\_id UgcGoods 商品 参数 \_show\_time Fixed 显示时间

### Role.show\_like\_panel

显示点赞界面

Role.show\_like\_panel()

### Role.show\_tips

玩家显示飘字信息

Role.show\_tips(\_content, \_duration)

参数 \_content Str 字符串 参数 \_duration Fixed 时长

### Role.show\_ultimate\_ability\_panel

显示玩家决战技选择界面

Role.show\_ultimate\_ability\_panel(\_keep\_time)

参数 \_keep\_time Int 时间

### Role.skip\_current\_montage

跳过剧情动画

Role.skip\_current\_montage(\_has\_black\_screen)

参数 \_has\_black\_screen Bool 是否有跳过黑幕

### Role.start\_level\_vote

发起进入关卡投票

Role.start\_level\_vote(\_level\_key)

参数 \_level\_key LevelKey 关卡编号

### Role.start\_vibration

开始手机震动

Role.start\_vibration(\_vibrate\_type, \_vibrate\_count, \_vibrate\_interval)

参数 \_vibrate\_type Int 震动模式 参数 \_vibrate\_count Int 震动次数 参数 \_vibrate\_interval Fixed 震动间隔

### Role.stop\_2d\_sound

对指定单位停止2D声音

Role.stop\_2d\_sound(\_sound\_instance\_id)

参数 \_sound\_instance\_id SoundID 音效ID

### Role.stop\_camera\_motor

停止玩家相机运动

Role.stop\_camera\_motor()

### Role.stop\_ui\_effect

停止界面动效

Role.stop\_ui\_effect(\_effect\_node)

参数 \_effect\_node EEffectNode UI动效

### Role.unbind\_label\_text

UI文本节点解除属性

Role.unbind\_label\_text(\_label)

参数 \_label ELabel UI文本节点

### Role.unbind\_progressbar\_current

为UI进度条节点当前进度解绑属性

Role.unbind\_progressbar\_current(\_progress\_bar)

参数 \_progress\_bar EProgressbar UI进度条节点

### Role.unbind\_progressbar\_max

UI进度条节点最大进度解绑属性

Role.unbind\_progressbar\_max(\_progress\_bar)

参数 \_progress\_bar EProgressbar UI进度条节点

### Role.win

玩家胜利

Role.win()

### RollComp.get\_roll\_cooldown

获取滚动冷却时间

RollComp.get\_roll\_cooldown()

返回类型 Fixed 冷却时间

### RollComp.get\_roll\_remaining\_cooldown

获取滚动剩余冷却时间

RollComp.get\_roll\_remaining\_cooldown()

返回类型 Fixed 剩余冷却时间

### RollComp.set\_roll\_cooldown

设置滚动冷却时间

RollComp.set\_roll\_cooldown(\_time)

参数 \_time Fixed 时间

### RollComp.set\_roll\_remaining\_cooldown

设置滚动剩余冷却时间

RollComp.set\_roll\_remaining\_cooldown(\_remaining\_time)

参数 \_remaining\_time Fixed 剩余冷却时间

### RushComp.get\_rush\_cooldown

获取飞扑冷却时间

RushComp.get\_rush\_cooldown()

返回类型 Fixed 冷却时间

### RushComp.get\_rush\_remaining\_cooldown

获取飞扑剩余冷却时间

RushComp.get\_rush\_remaining\_cooldown()

返回类型 Fixed 剩余冷却时间

### RushComp.set\_rush\_cooldown

设置飞扑冷却时间

RushComp.set\_rush\_cooldown(\_time)

参数 \_time Fixed 时间

### RushComp.set\_rush\_remaining\_cooldown

设置飞扑剩余冷却时间

RushComp.set\_rush\_remaining\_cooldown(\_time)

参数 \_time Fixed 时间

### SceneUI.create\_scene\_ui\_bind\_unit

创建场景界面绑定到单位

SceneUI.create\_scene\_ui\_bind\_unit(\_layer\_key, \_socket\_name, \_offset\_pos, \_duration, \_bind\_event, \_inherit\_visible)

参数 \_layer\_key E3DLayerKey 场景界面预设编号 参数 \_socket\_name ModelSocket 绑定位置 参数 \_offset\_pos Point3 偏移位置 参数 \_duration Fixed 持续时间 参数 \_bind\_event Bool 事件是否指向绑定者 参数 \_inherit\_visible Bool 是否跟随组件显隐

返回类型 E3DLayer 场景界面

### TriggerSpace.get\_virtual\_light\_brightness

获取光源亮度

TriggerSpace.get\_virtual\_light\_brightness()

返回类型 Fixed 亮度

### TriggerSpace.set\_virtual\_light\_brightness

设置光源亮度

TriggerSpace.set\_virtual\_light\_brightness(\_brightness)

参数 \_brightness Fixed 亮度

### TriggerSystem.has\_timer

判断计时器是否存在

TriggerSystem.has\_timer(\_timer)

参数 \_timer Timer 计时器

返回类型 Bool 是否存在

### Unit.add\_child

添加子单位

Unit.add\_child(\_unit)

参数 \_unit Unit 子单位

### Unit.add\_circle\_motor

添加圆周运动

Unit.add\_circle\_motor(\_vel, \_time, \_is\_local)

参数 \_vel Vector3 角速度 参数 \_time Fixed 时间 参数 \_is\_local Bool 是否局部空间

返回类型 Int 索引

### Unit.add\_linear\_motor

添加直线运动

Unit.add\_linear\_motor(\_vel, \_time, \_is\_local)

参数 \_vel Vector3 线速度 参数 \_time Fixed 时间 参数 \_is\_local Bool 是否局部空间

返回类型 Int 索引

### Unit.add\_surround\_motor

添加环绕运动

Unit.add\_surround\_motor(\_follow\_target, \_ang\_vel, \_time, \_follow\_rotate)

参数 \_follow\_target Unit 环绕目标 参数 \_ang\_vel Vector3 角速度 参数 \_time Fixed 时间 参数 \_follow\_rotate Bool 是否跟随旋转

### Unit.apply\_force

施加力

Unit.apply\_force(\_force)

参数 \_force Vector3 力

### Unit.apply\_impact\_force

施加冲击力

Unit.apply\_impact\_force(\_force, \_max\_speed, \_force\_lost\_control, \_lost\_ctrl\_time)

参数 \_force Vector3 力 参数 \_max\_speed Fixed 击飞最大速度 参数 \_force\_lost\_control Bool 是否击飞 参数 \_lost\_ctrl\_time Fixed 击飞失控时间

### Unit.disable\_gravity

关闭重力影响

Unit.disable\_gravity()

### Unit.disable\_interact

禁用单位互动

Unit.disable\_interact()

### Unit.disable\_motor

禁用运动器

Unit.disable\_motor(\_index)

参数 \_index Int 索引

### Unit.enable\_gravity

开启重力影响

Unit.enable\_gravity()

### Unit.enable\_interact

激活单位互动

Unit.enable\_interact()

### Unit.enable\_motor

激活运动器

Unit.enable\_motor(\_index)

参数 \_index Int 索引

### Unit.get\_angular\_velocity

获取单位角速度

Unit.get\_angular\_velocity()

返回类型 Vector3 角速度

### Unit.get\_camp

获取单位所属阵营

Unit.get\_camp()

返回类型 Camp 阵营

### Unit.get\_camp\_id

获取单位所属阵营id

Unit.get\_camp\_id()

返回类型 CampID 阵营ID

### Unit.get\_child\_by\_name

根据单位编号获取子组件

Unit.get\_child\_by\_name(\_name)

参数 \_name Str 子单位名称

返回类型 Unit 单位

### Unit.get\_child\_customtriggerspaces

获得所有子触发区域单位

Unit.get\_child\_customtriggerspaces()

返回类型 ListCustomTriggerSpace 触发区域列表

### Unit.get\_child\_obstacles

获得所有子物理组件单位

Unit.get\_child\_obstacles()

返回类型 ListObstacle 组件列表

### Unit.get\_children

获得所有子单位

Unit.get\_children()

返回类型 ListUnit 单位列表

### Unit.get\_key

获取单位编号

Unit.get\_key()

返回类型 UnitKey 单位编号

### Unit.get\_linear\_velocity

获取单位线速度

Unit.get\_linear\_velocity()

返回类型 Vector3 线速度

### Unit.get\_local\_direction

获取单位本地坐标系下的方向

Unit.get\_local\_direction(\_direction\_type)

参数 \_direction\_type DirectionType 方向

返回类型 Vector3 向量

### Unit.get\_local\_offset\_position

获取单位局部偏移位置

Unit.get\_local\_offset\_position(\_offset)

参数 \_offset Vector3 偏移向量

返回类型 Point3 偏移位置

### Unit.get\_local\_quaternion

获取单位本地坐标系下的旋转角

Unit.get\_local\_quaternion(\_direction\_type)

参数 \_direction\_type DirectionType 方向

返回类型 Quaternion Quaternion

### Unit.get\_name

获取单位名称

Unit.get\_name()

返回类型 Str 名称

### Unit.get\_orientation

获得单位旋转

Unit.get\_orientation()

返回类型 Quaternion 旋转

### Unit.get\_parent

获取父单位

Unit.get\_parent()

返回类型 Unit 单位

### Unit.get\_position

获取单位坐标

Unit.get\_position()

返回类型 Vector3 坐标

### Unit.get\_rigid\_body\_type

获取受力类型

Unit.get\_rigid\_body\_type()

返回类型 RigidBodyType 受力类型

### Unit.get\_role

获取单位所属玩家

Unit.get\_role()

返回类型 Role 所属玩家

### Unit.get\_role\_id

获取单位所属玩家ID

Unit.get\_role\_id()

返回类型 RoleID 玩家ID

### Unit.get\_scale

获得单位缩放

Unit.get\_scale()

返回类型 Vector3 缩放

### Unit.get\_unit\_type

获取单位类型

Unit.get\_unit\_type()

返回类型 UnitType 单位类型

### Unit.hide\_bubble\_msg

关闭气泡信息

Unit.hide\_bubble\_msg()

### Unit.is\_character

是否为角色

Unit.is\_character()

返回类型 Bool 单位

### Unit.is\_creature

是否为生物

Unit.is\_creature()

返回类型 Bool 单位

### Unit.is\_dynamic

组件是否为受力物体

Unit.is\_dynamic()

返回类型 Bool 是否为受力物体

### Unit.is\_dynamic\_body

是受力物体

Unit.is\_dynamic\_body()

返回类型 Bool 受力物体

### Unit.is\_in\_customtriggerspace

单位是否在触发区域内

Unit.is\_in\_customtriggerspace(\_custom\_trigger\_space, \_consider\_mask)

参数 \_custom\_trigger\_space CustomTriggerSpace 触发区域 参数 \_consider\_mask Bool 考虑掩码

返回类型 Bool 布尔

### Unit.is\_kinematic\_body

是动力学物体

Unit.is\_kinematic\_body()

返回类型 Bool 动力学物体

### Unit.is\_model\_visible

单位模型是否可见

Unit.is\_model\_visible()

返回类型 Bool 是否隐藏

### Unit.is\_physics\_active

单位物理是否生效

Unit.is\_physics\_active()

返回类型 Bool 是否物理生效

### Unit.is\_static\_body

是静态物体

Unit.is\_static\_body()

返回类型 Bool 静态物体

### Unit.is\_valid\_ability\_target

判断单位是否满足作为技能释放目标的条件

Unit.is\_valid\_ability\_target(\_ability)

参数 \_ability Ability 对应技能

返回类型 Bool 目标是否满足条件

### Unit.play\_3d\_sound

单位开始播放3d音效

Unit.play\_3d\_sound(\_sound\_key, \_duration, \_volume)

参数 \_sound\_key SoundKey 声音编号 参数 \_duration Fixed 持续时间 参数 \_volume Fixed 音量

返回类型 SoundID 音效ID

### Unit.play\_emoji

单位发送表情

Unit.play\_emoji(\_emoji\_key)

参数 \_emoji\_key EmojiKey 表情编号

### Unit.play\_emoji\_with\_offset

发送气泡表情

Unit.play\_emoji\_with\_offset(\_emoji\_key, \_show\_time, \_offset)

参数 \_emoji\_key EmojiKey 表情 参数 \_show\_time Fixed 持续时间 参数 \_offset Vector3 偏移

### Unit.play\_sound\_with\_dis\_and\_attenuation

单位开始播放声音

Unit.play\_sound\_with\_dis\_and\_attenuation(\_event\_id, \_vis\_dis, \_sound\_attenuation\_curve)

参数 \_event\_id SoundKey 声音编号 参数 \_vis\_dis Fixed 音效传播距离 参数 \_sound\_attenuation\_curve Str 衰减曲线

返回类型 SoundID 音效ID

### Unit.remove\_from\_parent

从父节点移除

Unit.remove\_from\_parent()

### Unit.remove\_surround\_motor

停止环绕运动

Unit.remove\_surround\_motor()

### Unit.set\_acc\_motor\_init\_velocity

设置加速运动初速度并重置

Unit.set\_acc\_motor\_init\_velocity(\_index, \_init\_vel)

参数 \_index Int 索引 参数 \_init\_vel Vector3 初速度

### Unit.set\_angular\_velocity

改变单位角速度

Unit.set\_angular\_velocity(\_vel)

参数 \_vel Vector3 角速度

### Unit.set\_linear\_motor\_velocity

设置直线运动速度

Unit.set\_linear\_motor\_velocity(\_index, \_vel, \_is\_local)

参数 \_index Int 索引 参数 \_vel Vector3 线速度 参数 \_is\_local Bool 是否局部空间

### Unit.set\_linear\_velocity

改变单位线速度

Unit.set\_linear\_velocity(\_vel)

参数 \_vel Vector3 线速度

### Unit.set\_mirror\_reflect\_enabled

开关镜面反射

Unit.set\_mirror\_reflect\_enabled(\_enable)

参数 \_enable Bool 是否启用

### Unit.set\_model\_visible

设置单位模型是否可见

Unit.set\_model\_visible(\_v)

参数 \_v Bool 是否可见

### Unit.set\_orientation

设置单位旋转

Unit.set\_orientation(\_rot)

参数 \_rot Quaternion 旋转

### Unit.set\_paint\_area\_color

改变组件颜色

Unit.set\_paint\_area\_color(\_paint\_area, \_color)

参数 \_paint\_area PaintArea 染色区域 参数 \_color Color 颜色

### Unit.set\_physics\_active

设置单位物理是否生效

Unit.set\_physics\_active(\_is\_active)

参数 \_is\_active Bool 是否生效

### Unit.set\_position

重置单位坐标

Unit.set\_position(\_pos)

参数 \_pos Vector3 坐标

### Unit.set\_world\_scale

设置单位世界空间下的缩放

Unit.set\_world\_scale(\_scale)

参数 \_scale Vector3 缩放

### Unit.show\_bubble\_msg

发送气泡信息

Unit.show\_bubble\_msg(\_show\_msg, \_show\_time, \_max\_dis, \_offset)

参数 \_show\_msg Str 气泡信息 参数 \_show\_time Fixed 持续时间 参数 \_max\_dis Fixed 隐藏距离 参数 \_offset Vector3 偏移

### Unit.stop\_sound

单位停止播放声音

Unit.stop\_sound(\_lres\_id)

参数 \_lres\_id SoundID 音效ID

### UnitInteractVolumeComp.get\_interact\_id

获取单位互动按钮ID

UnitInteractVolumeComp.get\_interact\_id(\_interact\_index, \_interact\_btn\_type)

参数 \_interact\_index Int 互动索引 参数 \_interact\_btn\_type InteractBtnType 互动按钮类型

返回类型 InteractBtnID 互动按钮ID

### UnitInteractVolumeComp.set\_interact\_button\_icon

设置单位互动按钮图标

UnitInteractVolumeComp.set\_interact\_button\_icon(\_interact\_id, \_icon)

参数 \_interact\_id InteractBtnID 互动按钮ID 参数 \_icon ImageKey 互动按钮图标

### UnitInteractVolumeComp.set\_interact\_button\_text

设置单位互动按钮文本

UnitInteractVolumeComp.set\_interact\_button\_text(\_interact\_id, \_text)

参数 \_interact\_id InteractBtnID 互动按钮ID 参数 \_text Str 互动按钮文本

### UnitInteractVolumeComp.set\_interact\_button\_text\_by\_index

设置单位互动按钮文本

UnitInteractVolumeComp.set\_interact\_button\_text\_by\_index(\_interact\_index, \_text)

参数 \_interact\_index Int 互动索引 参数 \_text Str 互动按钮文本

### UnitInteractVolumeComp.set\_interact\_enabled

设置单位互动是否启用

UnitInteractVolumeComp.set\_interact\_enabled(\_enable)

参数 \_enable Bool 是否启用

### UnitInteractVolumeComp.set\_interact\_enabled\_by\_index

设置单位互动是否启用(索引)

UnitInteractVolumeComp.set\_interact\_enabled\_by\_index(\_interact\_index, \_enable)

参数 \_interact\_index Int 互动索引 参数 \_enable Bool 是否启用

### VehicleComp.reset

载具复位

VehicleComp.reset()

### VehicleComp.start\_move\_by\_direction

使载具往某个方向移动一段时间

VehicleComp.start\_move\_by\_direction(\_direction, \_duration)

参数 \_direction Vector3 方向 参数 \_duration Fixed 持续时间

### VehicleComp.stop\_move

使载具停止移动

VehicleComp.stop\_move()

## EVENT

### ABILITY\_BULLET\_HIT

子弹命中

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者 事件携带参数 target\_unit Unit 目标对象 事件携带参数 dmg Fixed 伤害值

### ABILITY\_SWITCH\_IN

技能切入

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者 事件携带参数 switch\_out\_ability Ability 切换前的技能

### ABILITY\_SWITCH\_OUT

技能切出

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者 事件携带参数 switch\_in\_ability Ability 切换后的技能

### ABILITY\_ACCUMULATE\_BEGIN

技能蓄力阶段开始

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者

### ABILITY\_ACCUMULATE\_INTERRUPT

技能蓄力阶段被打断

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者

### ABILITY\_ACCUMULATE\_END

技能蓄力阶段结束

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者

### ABILITY\_CAST\_BEGIN

技能施法阶段开始

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者

### ABILITY\_CAST\_BREAK

技能施法阶段被打断

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者

### ABILITY\_CAST\_END

技能施法阶段结束

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者

### ABILITY\_CD\_END

技能冷却完成

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者

### ABILITY\_CHARGE\_END

技能充能完成

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者

### ABILITY\_DOWNGRADE

技能降级

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能

### ABILITY\_REMOVE

失去技能

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者

### ABILITY\_ADD

获得技能

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者

### ABILITY\_UPGRADE

技能升级

事件主体 Ability 技能

事件携带参数 ability Ability 触发技能 事件携带参数 unit Unit 技能拥有者

### ANY\_CAMP\_SCORE\_UPDATE

阵营积分变化

事件主体 Global 全局触发器

事件携带参数 camp Camp 触发阵营 事件携带参数 old\_camp\_score Int 得分前积分 事件携带参数 new\_camp\_score Int 得分后积分

### ANY\_CUSTOMTRIGGERSPACE\_CREATE

任意触发区域创建

事件主体 Global 全局触发器

事件携带参数 unit CustomTriggerSpace 被创建的触发区域

### ANY\_CUSTOMTRIGGERSPACE\_DESTROY

任意触发区域销毁

事件主体 Global 全局触发器

事件携带参数 unit CustomTriggerSpace 被销毁的触发区域

### ANY\_EQUIPMENT\_CHANGE\_SLOT

任意物品位置发生变化

事件主体 Global 全局触发器

事件携带参数 equipment Equipment 触发事件的物品 事件携带参数 owner LifeEntity 持有者 事件携带参数 old\_slot\_type EquipmentSlotType 旧槽位类型 事件携带参数 old\_index Int 旧槽位索引 事件携带参数 new\_slot\_type EquipmentSlotType 新槽位类型 事件携带参数 new\_index Int 新槽位索引

### ANY\_EQUIPMENT\_TRIGGER\_SPACE

任意物品进出区域事件

事件主体 Global 全局触发器

注册参数 trigger\_event\_type TriggerSpaceEventType 触发类型 注册参数 customtriggerspace\_id CustomTriggerSpaceID 触发区域ID

事件携带参数 event\_unit Equipment 触发物品 事件携带参数 event\_unit\_id EquipmentID TRIGGER\_EQUIPMENT\_ID 事件携带参数 trigger\_event\_type TriggerSpaceEventType 触发类型 事件携带参数 trigger\_zone\_id CustomTriggerSpaceID 触发区域ID 事件携带参数 trigger\_zone CustomTriggerSpace 事件触发区域

### ANY\_LIFEENTITY\_TRIGGER\_SPACE

任意生命体进出区域事件

事件主体 Global 全局触发器

注册参数 trigger\_event\_type TriggerSpaceEventType 触发类型 注册参数 trigger\_zone\_id CustomTriggerSpaceID 触发区域ID

事件携带参数 event\_unit LifeEntity 触发角色/生物 事件携带参数 event\_unit\_id UnitID 触发角色/生物ID 事件携带参数 trigger\_event\_type TriggerSpaceEventType 触发类型 事件携带参数 trigger\_zone\_id CustomTriggerSpaceID 触发区域ID 事件携带参数 trigger\_zone CustomTriggerSpace 事件触发区域

### ANY\_OBSTACLE\_CREATE

任意组件创建

事件主体 Global 全局触发器

事件携带参数 unit Obstacle 被创建的组件

### ANY\_OBSTACLE\_DESTROY

任意组件销毁

事件主体 Global 全局触发器

事件携带参数 unit Obstacle 被销毁的组件

### ANY\_OBSTACLE\_LIFTED\_BEGAN

任意组件被举起

事件主体 Global 全局触发器

事件携带参数 lift\_unit Unit 抓举者 事件携带参数 lifted\_unit Obstacle 被抓举者

### ANY\_OBSTACLE\_LIFTED\_ENDED

任意组件被放下

事件主体 Global 全局触发器

事件携带参数 lift\_unit Unit 抓举者 事件携带参数 lifted\_unit Obstacle 被抓举者

### ANY\_OBSTACLE\_TRIGGER\_SPACE

任意组件进出触发区域

事件主体 Global 全局触发器

注册参数 trigger\_event\_type TriggerSpaceEventType 触发类型 注册参数 trigger\_zone\_id CustomTriggerSpaceID 触发区域ID

事件携带参数 event\_unit Obstacle 触发组件 事件携带参数 event\_unit\_id ObstacleID 触发组件ID 事件携带参数 trigger\_event\_type TriggerSpaceEventType 触发类型 事件携带参数 trigger\_zone\_id CustomTriggerSpaceID 触发区域ID 事件携带参数 trigger\_zone CustomTriggerSpace 事件触发区域

### ANY\_ROLE\_SCORE\_UPDATE

玩家积分变化

事件主体 Global 全局触发器

事件携带参数 role Role 触发玩家 事件携带参数 old\_role\_score Int 得分前积分 事件携带参数 new\_role\_score Int 得分后积分

### ANY\_TRIGGERSPACE\_CREATE

任意逻辑体创建

事件主体 Global 全局触发器

事件携带参数 unit TriggerSpace 被创建的逻辑体

### ANY\_TRIGGERSPACE\_DESTROY

任意逻辑体销毁

事件主体 Global 全局触发器

事件携带参数 unit TriggerSpace 被销毁的逻辑体

### CUSTOM\_EVENT

自定义事件

事件主体 Default 多类型

注册参数 name Str 自定义事件

### ENV\_TIME\_REACHED

环境时间到达指定时刻

事件主体 Global 全局触发器

注册参数 target\_time Fixed TARGET\_MAP\_TIME

### GAME\_END

游戏结束

事件主体 Global 全局触发器

### GAME\_INIT

游戏初始化

事件主体 Global 全局触发器

### LEVEL\_BEGIN

进入关卡

事件主体 Default 多类型

事件携带参数 level\_key LevelKey 当前关卡

### LEVEL\_END

离开关卡

事件主体 Default 多类型

事件携带参数 level\_key LevelKey 当前关卡

### MODIFIER\_OBTAIN

获得效果

事件主体 Modifier 效果

事件携带参数 from\_unit\_id UnitID 效果来源ID 事件携带参数 modifier Modifier 触发效果 事件携带参数 unit Unit 效果拥有者

### MODIFIER\_REOBTAIN

覆盖效果

事件主体 Modifier 效果

事件携带参数 modifier Modifier 触发效果 事件携带参数 unit Unit 效果拥有者

### MODIFIER\_STACK\_COUNT\_CHANGE

效果层数变化

事件主体 Modifier 效果

事件携带参数 stack\_count\_change Int 变化层数 事件携带参数 modifier Modifier 触发效果 事件携带参数 unit Unit 效果拥有者

### ON\_MONTAGE\_BEGIN

剧情动画开始播放事件

事件主体 Default 多类型

事件携带参数 play\_role Role 触发角色 事件携带参数 montage\_id MontageKey 触发的剧情动画

### ON\_MONTAGE\_END

剧情动画结束播放事件

事件主体 Default 多类型

事件携带参数 play\_role Role 触发角色 事件携带参数 montage\_id MontageKey 触发的剧情动画

### ON\_PLAYER\_TAKE\_PHOTO

玩家拍照

事件主体 Global 全局触发器

事件携带参数 role Role 触发玩家

### REPEAT\_TIMEOUT

周期性计时器超时

事件主体 Default 多类型

注册参数 delay Fixed 延时

### ON\_SKY\_ENV\_CHANGE

天空环境变化

事件主体 Global 全局触发器

### SPEC\_CHARACTER\_SELECT\_EQUIPMENT\_SLOT

指定角色选中物品格

事件主体 Character 角色

注册参数 event\_unit Character 触发角色 注册参数 slot\_type EquipmentSlotType 物品格类型 注册参数 slot\_index Int EQUIPMENT\_SLOT\_INDEX

事件携带参数 event\_unit Character 触发角色

### SPEC\_LIFEENTITY\_INTERACTED

指定生物互动按钮被按下

事件主体 Creature 生物

事件携带参数 interact\_lifeentity LifeEntity 互动触发者 事件携带参数 interact\_unit Creature 互动目标 事件携带参数 interact\_id InteractBtnID 互动按钮

### SPEC\_CUSTOMTRIGGERSPACE\_DESTROY

指定触发区域销毁

事件主体 CustomTriggerSpace 触发区域

### SPEC\_EQUIPMENT\_CHANGE\_SLOT

指定物品位置发生变化

事件主体 Equipment 物品

事件携带参数 equipment Equipment 当前物品 事件携带参数 owner LifeEntity 持有者 事件携带参数 old\_slot\_type EquipmentSlotType 旧槽位类型 事件携带参数 old\_index Int 旧槽位索引 事件携带参数 new\_slot\_type EquipmentSlotType 新槽位类型 事件携带参数 new\_index Int 新槽位索引

### SPEC\_EQUIPMENT\_DESTROY

指定物品销毁事件

事件主体 Equipment 物品

事件携带参数 equipment Equipment 当前物品

### SPEC\_EQUIPMENT\_ENTER\_CHAR\_SLOT

指定物品进入角色栏位

事件主体 Equipment 物品

注册参数 equipment Equipment 当前物品 注册参数 slot\_type EquipmentSlotType 物品格类型

事件携带参数 equipment Equipment 当前物品 事件携带参数 slot\_type EquipmentSlotType 物品格类型 事件携带参数 owner Character 触发事件的角色

### SPEC\_EQUIPMENT\_LEAVE\_CHAR\_SLOT

指定物品离开角色栏位

事件主体 Equipment 物品

注册参数 equipment Equipment 当前物品 注册参数 slot\_type EquipmentSlotType 物品格类型

事件携带参数 equipment Equipment 当前物品 事件携带参数 slot\_type EquipmentSlotType 物品格类型 事件携带参数 owner Character 触发事件的角色

### SPEC\_EQUIPMENT\_LOST

指定物品被失去

事件主体 Equipment 物品

事件携带参数 equipment Equipment 当前物品 事件携带参数 owner LifeEntity 持有者 事件携带参数 slot\_type EquipmentSlotType 物品槽位类型 事件携带参数 slot\_index Int 物品槽位索引

### SPEC\_EQUIPMENT\_OBTAIN

指定物品被获得

事件主体 Equipment 物品

事件携带参数 equipment Equipment 当前物品 事件携带参数 owner LifeEntity 持有者 事件携带参数 count Int 获得数量

### SPEC\_EQUIPMENT\_SELECT

指定物品被选中

事件主体 Equipment 物品

事件携带参数 equipment Equipment 当前物品

### SPEC\_EQUIPMENT\_STACK\_NUM\_CHANGE

指定物品堆叠层数变化

事件主体 Equipment 物品

事件携带参数 equipment Equipment 当前物品 事件携带参数 variation Int 变化层数

### SPEC\_EQUIPMENT\_SWAP\_SLOT

指定物品发生位置交换

事件主体 Equipment 物品

事件携带参数 equipment Equipment 当前物品

### SPEC\_EQUIPMENT\_UNSELECT

指定物品被取消选中

事件主体 Equipment 物品

事件携带参数 equipment Equipment 当前物品

### SPEC\_EQUIPMENT\_USE

指定物品被使用

事件主体 Equipment 物品

事件携带参数 equipment Equipment 当前物品

### SPEC\_EQUIPMENT\_USE\_BEFORE

指定物品被使用前

事件主体 Equipment 物品

事件携带参数 equipment Equipment 当前物品 事件携带参数 equipment\_user LifeEntity 使用物品的角色/生物

### SPEC\_LIFEENTITY\_ABILITY\_DOWNGRADE

指定生命体技能降级

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 技能拥有者 事件携带参数 ability Ability 触发技能

### SPEC\_LIFEENTITY\_ABILITY\_OBTAIN

指定生命体获得技能

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 技能拥有者 事件携带参数 ability Ability 触发技能

### SPEC\_LIFEENTITY\_ABILITY\_REMOVE

指定生命体失去技能

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 技能拥有者 事件携带参数 ability Ability 触发技能

### SPEC\_LIFEENTITY\_ABILITY\_UPGRADE

指定生命体技能升级

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 技能拥有者 事件携带参数 ability Ability 触发技能

### SPEC\_LIFEENTITY\_CONTACT\_BEGIN

指定生命体发生碰撞开始

事件主体 LifeEntity 生命体

事件携带参数 unit1 LifeEntity 碰撞者 事件携带参数 unit2 Unit 被碰撞者

### SPEC\_LIFEENTITY\_CONTACT\_END

指定生命体发生碰撞结束

事件主体 LifeEntity 生命体

事件携带参数 unit1 LifeEntity 碰撞者 事件携带参数 unit2 Unit 被碰撞者

### SPEC\_LIFEENTITY\_DEFEAT

指定生命体击败其他生命体

事件主体 LifeEntity 生命体

事件携带参数 dmg\_unit LifeEntity 伤害来源 事件携带参数 die\_unit LifeEntity 被击败者

### SPEC\_LIFEENTITY\_DESTROY

指定生命体被销毁

事件主体 LifeEntity 生命体

### SPEC\_LIFEENTITY\_DIE

指定生命体被击败

事件主体 LifeEntity 生命体

事件携带参数 die\_unit LifeEntity 被击败者 事件携带参数 dmg\_unit LifeEntity 伤害来源

### SPEC\_LIFEENTITY\_DIE\_BEFORE

指定生命体被击败前

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 被击败者 事件携带参数 dmg\_unit Unit 伤害来源

### SPEC\_LIFEENTITY\_DMGED\_AFTER

指定生命体受到伤害后

事件主体 LifeEntity 生命体

事件携带参数 \_dmg\_schema DamageSchema DAMAGE\_TYPE 事件携带参数 \_src Unit 伤害来源 事件携带参数 \_dst LifeEntity 伤害目标 事件携带参数 \_dmg Damage DAMAGE\_OBJ

### SPEC\_LIFEENTITY\_DMGED\_BEFORE

指定生命体受到伤害前

事件主体 LifeEntity 生命体

事件携带参数 \_dmg\_schema DamageSchema DAMAGE\_TYPE 事件携带参数 \_src Unit 伤害来源 事件携带参数 \_dst LifeEntity 伤害目标 事件携带参数 \_dmg Damage DAMAGE\_OBJ

### SPEC\_LIFEENTITY\_DMG\_AFTER

指定生命体造成伤害后

事件主体 LifeEntity 生命体

事件携带参数 \_dmg\_schema DamageSchema DAMAGE\_TYPE 事件携带参数 \_src LifeEntity 伤害来源 事件携带参数 \_dst LifeEntity 伤害目标 事件携带参数 \_dmg Damage DAMAGE\_OBJ

### SPEC\_LIFEENTITY\_DMG\_BEFORE

指定生命体造成伤害前

事件主体 LifeEntity 生命体

事件携带参数 \_dmg\_schema DamageSchema DAMAGE\_TYPE 事件携带参数 \_src LifeEntity 伤害来源 事件携带参数 \_dst LifeEntity 伤害目标 事件携带参数 \_dmg Damage DAMAGE\_OBJ

### SPEC\_LIFEENTITY\_ENTER\_VEHICLE

指定生命体上载具

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 触发角色/生物

### SPEC\_LIFEENTITY\_EQUIPMENT\_SLOT\_CHANGE

指定生命体持有物品槽位发生变化

事件主体 LifeEntity 生命体

事件携带参数 equipment Equipment 触发物品 事件携带参数 old\_slot\_type EquipmentSlotType 旧槽位类型 事件携带参数 old\_index Int 旧槽位索引 事件携带参数 new\_slot\_type EquipmentSlotType 新槽位类型 事件携带参数 new\_index Int 新槽位索引

### SPEC\_LIFEENTITY\_EXIT\_VEHICLE

指定生命体下载具

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 触发角色/生物

### SPEC\_LIFEENTITY\_GAIN\_EXP

生命体获得经验

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 获得者 事件携带参数 exp Fixed 经验值

### SPEC\_LIFEENTITY\_GET\_ITEMBOX

指定生命体获得道具箱

事件主体 LifeEntity 生命体

事件携带参数 life\_entity LifeEntity 获得道具的角色/生物

### SPEC\_LIFEENTITY\_JUMP

指定生命体跳跃

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 跳跃者

### SPEC\_LIFEENTITY\_LEVEL\_UP

生命体升级

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 获得者 事件携带参数 level Int 当前等级 事件携带参数 ori\_level Int 升级前等级

### SPEC\_LIFEENTITY\_LIFTED\_BEGIN

指定生命体被其他单位举起

事件主体 LifeEntity 生命体

事件携带参数 lift\_unit Unit 抓举者 事件携带参数 lifted\_unit LifeEntity 被抓举者

### SPEC\_LIFEENTITY\_LIFTED\_END

指定生命体被其他单位放下

事件主体 LifeEntity 生命体

事件携带参数 lift\_unit Unit 抓举者 事件携带参数 lifted\_unit LifeEntity 被抓举者

### SPEC\_LIFEENTITY\_LIFT\_BEGIN

指定生命体举起其他单位

事件主体 LifeEntity 生命体

事件携带参数 lift\_unit LifeEntity 抓举者 事件携带参数 lifted\_unit Unit 被抓举者

### SPEC\_LIFEENTITY\_LIFT\_END

指定生命体放下其他单位

事件主体 LifeEntity 生命体

事件携带参数 lift\_unit LifeEntity 抓举者 事件携带参数 lifted\_unit Unit 被抓举者

### SPEC\_LIFEENTITY\_MOVE\_BEGIN

指定生命体移动开始

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 获得者

### SPEC\_LIFEENTITY\_MOVE\_END

指定生命体移动结束

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 获得者

### SPEC\_LIFEENTITY\_REBORN

指定生命体复活

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 复活者

### SPEC\_LIFEENTITY\_RELEASE\_ABILITY

指定生命体释放技能

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 触发角色/生物 事件携带参数 ability Ability 触发技能

### SPEC\_LIFEENTITY\_ROLL\_BEGIN

指定生命体滚动开始

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 滚动者

### SPEC\_LIFEENTITY\_ROLL\_END

指定生命体滚动结束

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 滚动者

### SPEC\_LIFEENTITY\_RUSH

指定生命体前扑

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 前扑者 事件携带参数 dir Vector3 前扑方向

### SPEC\_LIFEENTITY\_START\_LIFT

指定生命体抓举

事件主体 LifeEntity 生命体

事件携带参数 unit LifeEntity 抓举者 事件携带参数 dir Vector3 抓举方向

### MODIFIER\_LOSS

失去效果

事件主体 Modifier 效果

事件携带参数 modifier Modifier 触发效果 事件携带参数 unit Unit 效果拥有者

### SPEC\_OBSTACLE\_CONTACT\_BEGIN

指定组件发生碰撞开始

事件主体 Obstacle 组件

事件携带参数 unit1 Obstacle 碰撞者 事件携带参数 unit2 Unit 被碰撞者 事件携带参数 contact\_pos Vector3 碰撞位置

### SPEC\_OBSTACLE\_CONTACT\_END

指定组件发生碰撞结束

事件主体 Obstacle 组件

事件携带参数 unit1 Obstacle 碰撞者 事件携带参数 unit2 Unit 被碰撞者

### SPEC\_OBSTACLE\_DESTROY

指定组件销毁

事件主体 Obstacle 组件

### SPEC\_OBSTACLE\_INTERACTED

指定组件互动按钮被按下

事件主体 Obstacle 组件

事件携带参数 interact\_lifeentity LifeEntity 互动触发者 事件携带参数 interact\_unit Obstacle 互动目标 事件携带参数 interact\_id InteractBtnID 互动按钮

### SPEC\_OBSTACLE\_LIFTED\_BEGIN

指定组件被举起

事件主体 Obstacle 组件

事件携带参数 lift\_unit Unit 抓举者 事件携带参数 lifted\_unit Obstacle 被抓举者

### SPEC\_OBSTACLE\_LIFTED\_END

指定组件被放下

事件主体 Obstacle 组件

事件携带参数 lift\_unit Unit 抓举者 事件携带参数 lifted\_unit Obstacle 被抓举者

### SPEC\_OBSTACLE\_ON\_DAMAGED

指定组件受到伤害

事件主体 Obstacle 组件

事件携带参数 src Unit 伤害来源 事件携带参数 src\_ability Ability 来源技能 事件携带参数 damage Fixed 伤害值

### SPEC\_OBSTACLE\_TOUCH\_BEGIN

指定组件被点击开始

事件主体 Obstacle 组件

事件携带参数 touch\_unit Role 点击玩家 事件携带参数 touched\_unit Obstacle 被点击的物体 事件携带参数 touch\_pos Vector3 点击位置

### SPEC\_OBSTACLE\_TOUCH\_END

指定组件被点击结束

事件主体 Obstacle 组件

事件携带参数 touch\_unit Role 点击玩家 事件携带参数 touched\_unit Obstacle 被点击的物体 事件携带参数 touch\_pos Vector3 松开位置

### SPEC\_ROLE\_ACHIEVEMENT\_COMPLETE

指定玩家完成自定义成就

事件主体 Global 全局触发器

注册参数 role RoleID 目标玩家

事件携带参数 role Role 目标玩家 事件携带参数 achieve\_id Achievement TARGET\_ACHIEVE

### SPEC\_ROLE\_ACHIEVEMENT\_REWARD\_GAIN

指定玩家领取成就奖励

事件主体 Global 全局触发器

注册参数 role RoleID 目标玩家 注册参数 achievement Achievement TARGET\_ACHIEVE

事件携带参数 role Role 目标玩家 事件携带参数 achieve\_id Achievement TARGET\_ACHIEVE

### SPEC\_ROLE\_CAMP\_CHANGE

指定玩家阵营发生变化

事件主体 Global 全局触发器

注册参数 role RoleID 目标玩家

事件携带参数 role Role 目标玩家 事件携带参数 camp\_before\_change Camp 变化前的阵营 事件携带参数 camp\_after\_change Camp 变化后的阵营

### SPEC\_ROLE\_EXIT\_GAME

指定玩家离开游戏

事件主体 Global 全局触发器

注册参数 role Role 目标玩家

事件携带参数 role Role 目标玩家

### SPEC\_ROLE\_GAME\_LOSE

指定玩家游戏失败

事件主体 Global 全局触发器

注册参数 role RoleID 目标玩家

事件携带参数 role Role 目标玩家

### SPEC\_ROLE\_GAME\_WIN

指定玩家游戏胜利

事件主体 Global 全局触发器

注册参数 role RoleID 目标玩家

事件携带参数 role Role 目标玩家

### SPEC\_ROLE\_PLAY\_ADVERTISEMENT\_FAILURE

指定玩家播放广告失败

事件主体 Global 全局触发器

注册参数 role Role 目标玩家 注册参数 ad\_tag Str ADVERTISEMENT\_TAG

### SPEC\_ROLE\_PLAY\_ADVERTISEMENT\_SUCCESS

指定玩家播放广告成功

事件主体 Global 全局触发器

注册参数 role Role 目标玩家 注册参数 ad\_tag Str ADVERTISEMENT\_TAG

### SPEC\_ROLE\_PURCHASE\_GOODS

指定玩家成功购买商品

事件主体 Global 全局触发器

注册参数 role Role 目标玩家

事件携带参数 role Role 目标玩家 事件携带参数 goods\_id UgcGoods TARGET\_GOODS

### SPEC\_ROLE\_VOICE\_VOLUME\_CHANGE

语音音量变化事件

事件主体 Default 多类型

注册参数 role Role 目标玩家

事件携带参数 voice\_volume Fixed 当前的音量

### SPEC\_TRIGGERSPACE\_DESTROY

指定逻辑体销毁

事件主体 TriggerSpace 逻辑体

### TIMEOUT

计时器超时

事件主体 Default 多类型

注册参数 delay Fixed DELAY\_TIME

### UI\_CUSTOM\_EVENT

UI自定义事件(附带玩家)

事件主体 Default 多类型

注册参数 name Str 自定义事件

事件携带参数 role\_id RoleID 触发事件的玩家ID 事件携带参数 role Role 触发事件的玩家 事件携带参数 eui\_node\_id ENode 触发事件的界面控件
