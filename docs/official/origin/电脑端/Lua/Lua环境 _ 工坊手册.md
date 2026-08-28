# Lua环境

## 概述

蛋仔游戏逻辑运行在安全沙盒(SandBox)中,限制了部分Lua功能以确保安全性和多人游戏状态一致性。

## 主要变更

### 1. 库的变更

#### 移除的库

* io
* os
* package
* debug

#### 重新实现的库

* math (详见下文)

#### 支持的全局变量/函数

* \_VERSION
* error
* assert
* ipairs
* pairs
* next
* pcall
* tostring
* type
* xpcall
* select
* require（仅限加载script目录下的其他lua模块）
* setmetatable（不可使用\_\_mode和\_\_gc域）
* getmetatable（但是仅可获取table的metatable）
* traceback（等价于debug.traceback）
* print

### 2. 语法变更

* 不支持字符串和数字类型间的隐式转换
* 表的键只能是数字或字符串
* 使用dict()创建支持其他类型键的字典

```lua
local map = dict()
local key = {}
map:set(key, 1234)
assert(map:get(key) == 1234)

for _, kv in ipairs(map:keyvalues()) do
   print("K: " .. tostring(kv[1]) .. "V: " .. tostring(kv[2]))
end

-- 使用keys()和values()方法获取键和值列表
```

## 开发者模式

在PC编辑器内试玩时可开启开发者模式,解除部分限制:

```lua
local success = LuaAPI.enable_developer_mode()
```

### 开发者模式特性

* 内置LuaSocket库
* 解除表键类型限制
* 允许使用io库
* 允许使用debug库（包含原生debug库的功能，并额外提供了若干性能评估API）

#### 开发者模式下的debug库

| API | 说明 |
| --- | --- |
| `debug.start_memory_record()` | 开始记录Lua内存分配栈，**会增加内存占用** |
| `debug.start_profile()` | 开始记录Lua执行栈耗时 |
| `debug.end_profile()` | 结束记录Lua执行栈耗时 |
| `debug.dump_profile_stacks(filename)` | 将执行栈与内存分配栈导出为HTML报告 |

其中后4个API用于地图运行时的性能评估（火焰图、内存分配栈分析等），具体使用方式请参考 [性能评估](https://u5-creator.s3.game.163.com/manual/pc_md/lua/lua_profile.html) 章节。

**特别注意，开发者模式只能在PC编辑器内试玩时开启！在手机版蛋仔编辑器，以及发布后的地图内都是无效的。您开发的游戏逻辑不能依赖这个模式中的功能!**

## math库

蛋仔的math库与标准Lua有显著差异,主要支持整数(integer)和定点数(Fixed)。

### 数值范围

* 定点数: -2147483647.0 ~ 2147483647.0
* 注意: 整数转定点数可能溢出

### 常量

| 名称 | 值 |
| --- | --- |
| math.pi | 圆周率 |
| math.e | 自然对数常数 |

### 主要函数

| 函数 | 功能 | 注意事项 |
| --- | --- | --- |
| math.tointeger(var) | 转换为整数 | 向下取整 |
| math.tofixed(var) | 转换为定点数 |  |
| math.sin/cos/tan(x) | 三角函数 | 输入为弧度 |
| math.asin/acos/atan(v) | 反三角函数 | 返回弧度 |
| math.log/log2/log10(x) | 对数函数 |  |
| math.exp/exp2(x) | 指数函数 |  |
| math.round/ceil/floor/trunc(x) | 取整函数 |  |
| math.clamp(x, min, max) | 值限制在指定范围 |  |

### 类型math.Vector3

这个类型用于表示游戏中的三维定点数向量，下表中假设vec是一个已经存在的math.Vector3实例：

| 函数/属性签名 | 参数 | 返回值 | 功能 |
| --- | --- | --- | --- |
| math.Vector3(x : Fixed, y : Fixed, z : Fixed) : math.Vector3 | x/y/z: 坐标 | 向量实例 | 构造一个向量实例 |
| vec.x | 属性，无需调用 | 获取到的分量 | 获取向量的x分量 |
| vec.y | 属性，无需调用 | 获取到的分量 | 获取向量的y分量 |
| vec.z | 属性，无需调用 | 获取到的分量 | 获取向量的z分量 |
| vec:yaw | 属性，无需调用，只读 | yaw值 | 获取向量朝向的yaw值 |
| vec:pitch | 属性，无需调用，只读 | pitch值 | 获取向量朝向的pitch值 |
| vec:length() : Fixed | 无 | 向量长度（定点数） | 计算向量的长度 |
| vec:dot(other\_vec : math.Vector3) : Fixed | 另一个向量 | 向量点积（定点数） | 计算两个向量的点积 |
| vec:cross(other\_vec : math.Vector3) : math.Vector3 | 另一个向量 | 向量叉积（向量） | 计算两个向量的叉积 |
| vec:normalize() : Fixed | 无 | 单位化前的向量长度（定点数） | 将向量单位化 |
| +-\*/ |  |  | 常规的加减乘除 |

### 类型math.Quaternion

这个类型为四元数，用于表示游戏中的旋转，下表中假设rot是一个已经存在的math.Quaternion实例：

| 函数/属性签名 | 参数 | 返回值 | 功能 |
| --- | --- | --- | --- |
| math.Quaternion(pitch, yaw, roll) : math.Quaternion | pitch/yaw/roll: 欧拉角 | 四元数实例 | 使用欧拉角构造一个四元数实例 |
| math.Quaternion(x, y, z, w) : math.Quaternion | x/y/z/w: 四元数分量 | 四元数实例 | 使用分量构造一个四元数实例 |
| rot:inverse() | 无 | 无 | 求逆 |
| rot:slerp(other\_rot : math.Quaternion, t : Fixed) : math.Quaternion | other\_rot: 另一个四元数；t: 插值参数 | 插值后的旋转值 | 球面插值 |
| rot.x | 属性，无需调用 | 获取到的分量 | 获取四元数的x分量 |
| rot.y | 属性，无需调用 | 获取到的分量 | 获取四元数的y分量 |
| rot.z | 属性，无需调用 | 获取到的分量 | 获取四元数的z分量 |
| rot.w | 属性，无需调用 | 获取到的分量 | 获取四元数的w分量 |
| rot.yaw | 属性，无需调用，只读 | yaw值 | 获取四元数的yaw值 |
| rot.pitch | 属性，无需调用，只读 | pitch值 | 获取四元数的pitch值 |
| rot.roll | 属性，无需调用，只读 | roll值 | 获取四元数的roll值 |
| +-\* |  |  | 常规的加减乘 |

> **注意: 由于历史原因，在2025.10.30维护前的游戏版本中，Lua中math库默认欧拉角的旋转顺序为：pitch->yaw->roll（即XYZ顺序），而编辑器内显示的角度为roll->pitch->yaw（即ZXY顺序）。为了避免不同顺序引起的混乱，我们将于2025.10.30维护后，将Lua中math库的默认欧拉角旋转顺序调整至与编辑器内一致。此次更改只影响维护后新创建的地图，您无需修改已经创建或发布的地图。但是如果需要将旧地图的代码迁移到新地图，请留意此处的更改。**
