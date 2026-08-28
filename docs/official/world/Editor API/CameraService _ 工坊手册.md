# CameraService

Camera 相机服务，提供编辑器视角属性的读取与设置。

## Overview

Camera 相机服务，提供编辑器视角属性（Fov、位置、角度等）的读取与设置。

**Get by:**

```lua
local service = editor:GetService("CameraService")
```

## Public

### GetCameraProperties

获取当前编辑器相机的属性映射。

**返回值**

| 类型 | 说明 |
| --- | --- |
| `Table` | 当前相机属性；无可用相机数据时返回空表。 |

**示例**

```lua
local service = editor:GetService("CameraService")

local props = service:GetCameraProperties() -- 读取当前相机属性
local oldFov = props["Fov"]
print("before Fov:", oldFov)
for name, value in pairs(props) do
    print("field:", name, value)
end

props["Fov"] = 60
service:SetCameraProperties(props) -- 写回修改后的属性

local after = service:GetCameraProperties() -- 读回验证
print("after set, Fov:", after["Fov"])

after["Fov"] = oldFov
service:SetCameraProperties(after) -- 恢复原 Fov
print("restored Fov:", service:GetCameraProperties()["Fov"])
```

### SetCameraProperties

批量设置当前编辑器相机属性。属性字段和值应来自当前版本 GetCameraProperties() 返回的映射。

**参数**

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `properties` | `Table` | 要更新的相机属性映射。 |

**示例**

```lua
local service = editor:GetService("CameraService")

local props = service:GetCameraProperties() -- 读取当前相机属性
local oldFov = props["Fov"]
print("before Fov:", oldFov)

props["Fov"] = 60
service:SetCameraProperties(props) -- 写回修改后的属性

local after = service:GetCameraProperties() -- 读回验证
print("after Fov:", after["Fov"])

after["Fov"] = oldFov
service:SetCameraProperties(after) -- 恢复原 Fov
print("restored Fov:", service:GetCameraProperties()["Fov"])
```
