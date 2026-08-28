# KeyCode

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Enum` · 枚举 Enum |
| Realm | `common` |

* **Inherit**: `Int`
* **继承链**: `Int` → KeyCode

[KeyCode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/KeyCode.html) 枚举定义了键盘、鼠标等输入设备的按键标识符，用于在输入事件中判断具体按下了哪个键。通过 Enums.KeyCode 命名空间引用成员，可配合 [UserInputService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/UserInputService.html) 的输入事件获取当前按键信息。

## 适用场景

在监听用户输入时，通过 [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html) 的 [KeyCode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/KeyCode.html) 属性与枚举值比较，实现特定按键的响应逻辑，例如检测空格键跳跃或鼠标左键点击。

## 使用要点

通过 [UserInputService](https://u5-creator.s3.game.163.com/manual/se/game_api/service/UserInputService.html) 的 InputBegan 等事件获取 [InputObject](https://u5-creator.s3.game.163.com/manual/se/game_api/data/InputObject.html)，然后访问其 [KeyCode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/KeyCode.html) 属性并与 Enums.KeyCode 成员比较。例如：if input.KeyCode == Enums.KeyCode.Space then ... end。

## 注意事项

[KeyCode](https://u5-creator.s3.game.163.com/manual/se/game_api/enum/KeyCode.html) 枚举值必须通过 Enums.KeyCode 前缀引用，禁止使用数字代替。不同设备可能支持不同的按键集合，实际可用按键取决于平台和输入设备。

## 枚举值

| 值 | 名称 | 说明 |
| --- | --- | --- |
| `1` | `MouseLeft` | 鼠标左键。 |
| `2` | `MouseRight` | 鼠标右键。 |
| `4` | `MouseMiddle` | 鼠标中键。 |
| `8` | `Backspace` | 退格键。 |
| `9` | `Tab` | Tab 制表键。 |
| `13` | `Return` | 回车键。 |
| `16` | `Shift` | 通用 Shift 修饰键。 |
| `160` | `LeftShift` | 左 Shift 键。 |
| `161` | `RightShift` | 右 Shift 键。 |
| `17` | `Ctrl` | 通用 Ctrl 修饰键。 |
| `162` | `LeftControl` | 左 Ctrl 键。 |
| `163` | `RightControl` | 右 Ctrl 键。 |
| `18` | `Alt` | 通用 Alt 修饰键。 |
| `164` | `LeftAlt` | 左 Alt 键。 |
| `165` | `RightAlt` | 右 Alt 键。 |
| `20` | `CapsLock` | 大小写锁定键。 |
| `27` | `Escape` | Esc 取消键。 |
| `32` | `Space` | 空格键。 |
| `33` | `PageUp` | 向上翻页键。 |
| `34` | `PageDown` | 向下翻页键。 |
| `35` | `End` | End 行尾键。 |
| `36` | `Home` | Home 行首键。 |
| `37` | `Left` | 左方向键。 |
| `38` | `Up` | 上方向键。 |
| `39` | `Right` | 右方向键。 |
| `40` | `Down` | 下方向键。 |
| `44` | `Print` | 截图/打印屏幕键。 |
| `45` | `Insert` | 插入键。 |
| `46` | `Delete` | 删除键。 |
| `187` | `Equals` | 主键盘等号或加号键。 |
| `189` | `Minus` | 主键盘减号或下划线键。 |
| `144` | `NumLock` | 数字小键盘锁定键。 |
| `96` | `KeypadZero` | 数字小键盘 0 键。 |
| `97` | `KeypadOne` | 数字小键盘 1 键。 |
| `98` | `KeypadTwo` | 数字小键盘 2 键。 |
| `99` | `KeypadThree` | 数字小键盘 3 键。 |
| `100` | `KeypadFour` | 数字小键盘 4 键。 |
| `101` | `KeypadFive` | 数字小键盘 5 键。 |
| `102` | `KeypadSix` | 数字小键盘 6 键。 |
| `103` | `KeypadSeven` | 数字小键盘 7 键。 |
| `104` | `KeypadEight` | 数字小键盘 8 键。 |
| `105` | `KeypadNine` | 数字小键盘 9 键。 |
| `106` | `KeypadMultiply` | 数字小键盘乘号键。 |
| `107` | `KeypadPlus` | 数字小键盘加号键。 |
| `109` | `KeypadMinus` | 数字小键盘减号键。 |
| `110` | `KeypadPeriod` | 数字小键盘小数点键。 |
| `111` | `KeypadDivide` | 数字小键盘除号键。 |
| `48` | `Zero` | 主键盘数字 0 键。 |
| `49` | `One` | 主键盘数字 1 键。 |
| `50` | `Two` | 主键盘数字 2 键。 |
| `51` | `Three` | 主键盘数字 3 键。 |
| `52` | `Four` | 主键盘数字 4 键。 |
| `53` | `Five` | 主键盘数字 5 键。 |
| `54` | `Six` | 主键盘数字 6 键。 |
| `55` | `Seven` | 主键盘数字 7 键。 |
| `56` | `Eight` | 主键盘数字 8 键。 |
| `57` | `Nine` | 主键盘数字 9 键。 |
| `65` | `A` | 字母 A 键。 |
| `66` | `B` | 字母 B 键。 |
| `67` | `C` | 字母 C 键。 |
| `68` | `D` | 字母 D 键。 |
| `69` | `E` | 字母 E 键。 |
| `70` | `F` | 字母 F 键。 |
| `71` | `G` | 字母 G 键。 |
| `72` | `H` | 字母 H 键。 |
| `73` | `I` | 字母 I 键。 |
| `74` | `J` | 字母 J 键。 |
| `75` | `K` | 字母 K 键。 |
| `76` | `L` | 字母 L 键。 |
| `77` | `M` | 字母 M 键。 |
| `78` | `N` | 字母 N 键。 |
| `79` | `O` | 字母 O 键。 |
| `80` | `P` | 字母 P 键。 |
| `81` | `Q` | 字母 Q 键。 |
| `82` | `R` | 字母 R 键。 |
| `83` | `S` | 字母 S 键。 |
| `84` | `T` | 字母 T 键。 |
| `85` | `U` | 字母 U 键。 |
| `86` | `V` | 字母 V 键。 |
| `87` | `W` | 字母 W 键。 |
| `88` | `X` | 字母 X 键。 |
| `89` | `Y` | 字母 Y 键。 |
| `90` | `Z` | 字母 Z 键。 |
| `112` | `F1` | 功能键 F1。 |
| `113` | `F2` | 功能键 F2。 |
| `114` | `F3` | 功能键 F3。 |
| `115` | `F4` | 功能键 F4。 |
| `116` | `F5` | 功能键 F5。 |
| `117` | `F6` | 功能键 F6。 |
| `118` | `F7` | 功能键 F7。 |
| `119` | `F8` | 功能键 F8。 |
| `120` | `F9` | 功能键 F9。 |
| `121` | `F10` | 功能键 F10。 |
| `122` | `F11` | 功能键 F11。 |
| `123` | `F12` | 功能键 F12。 |
