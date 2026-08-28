# AccessoryBindType

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → AccessoryBindType

该枚举表示蛋仔配饰的挂接部位，用于确定配饰佩戴在蛋仔身上的具体位置，涵盖头部、腰部和背部三种挂点。在装扮相关逻辑中，通过该枚举可以统一描述配饰的佩戴位置，并据此进行展示或挂载处理。

## 适用场景

在设置或读取蛋仔配饰时，需要指定配饰应挂在哪个部位，此时使用该枚举作为参数传递，例如将配饰绑定到头部或背部。

## 使用要点

无需实例化，直接使用 Enums.AccessoryBindType.Head、Enums.AccessoryBindType.Waist 或 Enums.AccessoryBindType.Back 即可获取对应的枚举值。该值可作为配饰相关函数调用的参数，或在条件判断中与接口返回的绑定部位进行比较。

## 注意事项

引用枚举值时必须保留 Enums. 前缀，不能使用数字代替。该枚举只包含 Head、Waist、Back 三个成员，不应臆造其他部位。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `1` | `Head` | 头部 |
| `2` | `Waist` | 腰部 |
| `3` | `Back` | 背部 |
