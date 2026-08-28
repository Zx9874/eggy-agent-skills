# UI 编辑器基础

UI 编辑器用于在 SE 编辑器中编排游戏画面 UI（计时器、积分板、按钮、提示文本等），所有 UI 控件都以 `EUI` 前缀类名存在，可以在脚本中通过 `EUIManager` 进行访问与控制。

## 入口

UI 编辑器可通过编辑器顶部中央的【界面】按钮进入。

![](https://u5-creator.s3.game.163.com/manual/assets/24.DF4yIdDT.png)

进入后界面分为三个主要区域：

* **左侧控件库**：可拖拽的控件类型列表。
* **中央画布**：UI 排版与预览区。
* **右侧属性面板**：选中控件后展示其可编辑属性。

## 控件类型

| 控件类型 | 脚本类名 | 用途 | 主要属性 |
| --- | --- | --- | --- |
| 布局容器 | `EUILayout` | 嵌套排版容器，用于组织子控件、做对齐与分组，**自身无背景色** | — |
| 按钮 | `EUIButton` | 可点击按钮，自带常规 / 按下 / 禁用三态 | `NormalImage`、`PressImage`、`DisableImage`；事件 `OnClicked` / `OnTouchBegan` / `OnTouchEnded` / `OnTouchMoved` |
| 图片 | `EUIImage` | 静态图片 / 图标 | `Image`（必须为 Int 资源 ID） |
| 文本标签 | `EUITextLabel` | 显示静态或动态文本 | `Text`、字体、字号、颜色、对齐方式、描边 |
| 富文本标签 | `EUIRichTextLabel` | 支持富文本标签解析、自动换行、跑马灯 | 富文本标签清单待补 |
| 输入框 | `EUIInputField` | 接收玩家文本输入 | 默认文本、提示文本、长度上限等待补 |
| 列表视图 | `EUIListView` | 滚动列表容器，常用于商品列表、排行榜 | 方向、滚动条、单元格模板等待补 |
| 线性进度条 | `EUILoadingBar` | 线性进度显示，常用于血条 / 加载条 | 最小值 / 最大值 / 当前值 / 朝向 |
| 圆形进度 | `EUIProgressTimer` | 扇形 / 圆形进度显示，常用于技能 CD | 起始角 / 进度方向 / 贴图模式 |
| 蒙版裁剪 | `EUIClippingNode` | 非矩形蒙版，可自定义裁剪形状 | — |
| 粒子特效 | `EUIEffect` | UI 层粒子特效（点击反馈、命中特效等） | — |
| 世界空间 UI | `EUISceneNode` | 绑定到 3D 世界坐标的 UI 节点（血条头顶飘字等） | — |

WARNING

* **图片属性**（`Image` / `NormalImage` / `BackgroundImage` 等）必须为 `Int`（资源 ID），传入字符串或 `nil` 会导致 hit-test 失效，按钮 / 触摸事件失效。
* **`EUIInputField` 没有快捷创建方法** `CreateInputField`。如需通过脚本动态创建，必须使用通用方法 `euiManager:CreateEUINode("EUIInputField", ...)`。
* **`EUILayout` 自身没有背景色**，需要带背景色的容器请用 `EUIImage` 代替。

各控件的详细属性、方法、事件签名将随 Game API 文档发布后同步补充。

## 通用属性

所有 UI 控件继承自 `EUINodeBase`，共享一组通用属性：

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| Name | String | 控件名（用于脚本定位、ECA 事件绑定） |
| NodeID | String | 节点唯一 ID（导出时生成） |
| Position | Vector2 | 位置（默认锚点 0.5，0.5，指向节点中心点） |
| Size | Vector2 | 控件宽高 |
| Anchor | Vector2 | 锚点，默认 (0.5, 0.5) |
| Visible | Bool | 是否显示 |
| Opacity | Float | 不透明度 0~1 |
| Rotation | Float | 旋转角度 |
| TouchEnabled | Bool | 是否响应触摸 |
| SwallowTouchEnabled | Bool | 是否阻止触摸事件穿透 |
| LocalZOrder | Int | 同级控件的层级排序 |

## 坐标系与定位

UI 坐标系：

* **坐标原点在屏幕左下角**，X 轴向右为正，Y 轴向上为正。
* 默认锚点 `(0.5, 0.5)`，`Position` 指向控件**中心点**坐标。
* 子控件的 `Position` 相对**父控件左下角原点**计算（不是父中心）。

常见定位：

| 场景 | 写法 |
| --- | --- |
| 屏幕居中 | `Position = (sw/2, sh/2)` |
| 全屏铺满 | `Position = (sw/2, sh/2)`, `Size = (sw, sh)` |
| 子控件在父容器居中 | `Position = (parentW/2, parentH/2)` |
| 子控件与父容器完全重叠 | `Anchor = (0,0)`、`Position = (0,0)`、`Size = (parentW, parentH)` |

WARNING

* 不要把 `Position = (0, 0)` 当成"居中"。在默认锚点下，节点中心会落在屏幕左下角，只有节点的右上四分之一可见。
* 不要硬编码 `1920` / `1080`。屏幕分辨率应通过 `euiManager:GetDeviceResolution()` 动态获取。

## 编辑器中的操作流程

下面以"计时器 + 积分板 + 重置按钮"为例展示创建 UI 的流程：

第一步，从控件库拖拽一个文本标签到画布。

![](https://u5-creator.s3.game.163.com/manual/assets/25.C7B8N1ke.png)

第二步，修改文本框名称（例如 `LabelTime`），调整位置、字体和大小。

![](https://u5-creator.s3.game.163.com/manual/assets/26.SEzeNWrW.png)

第三步，修改配色与描边。

![](https://u5-creator.s3.game.163.com/manual/assets/27.3jvj18e2.png)

第四步，重复以上步骤再创建一个 `LabelPoint` 文本标签作为积分板。

![](https://u5-creator.s3.game.163.com/manual/assets/28.DI_YqUVK.png)

第五步，再添加一个 `BtnReset` 按钮。

![](https://u5-creator.s3.game.163.com/manual/assets/33.CjPMYxW3.png)

第六步，点保存后退出 UI 编辑界面。

![](https://u5-creator.s3.game.163.com/manual/assets/29.C2gFE9ls.png)

## 后续

* 控件创建好后，需要 [导出 UI 节点数据](https://u5-creator.s3.game.163.com/manual/se/ui_editor/lua_integration.html#导出-ui-节点数据) 才能在脚本中通过名称访问。
* 脚本访问 UI 控件、按钮交互、客户端 / 服务端通信请参考 [UI 节点导出与脚本访问](https://u5-creator.s3.game.163.com/manual/se/ui_editor/lua_integration.html)。
