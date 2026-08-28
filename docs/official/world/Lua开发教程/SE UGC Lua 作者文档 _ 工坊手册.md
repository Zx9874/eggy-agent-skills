# SE UGC Lua 作者文档

面向新晋作者的 SE UGC Lua 系列教程。

面向用过蛋仔编辑器、有简单 Lua 基础的新晋作者。本目录是最终正文的 Markdown 交付版，只包含作者学习所需的章节。

## 发布与兼容性

开始学习前请先阅读[发布说明、适用版本与证据范围](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/release-status.html)。该页记录本次 Meta/Editor 基线、四级验证口径、平台副作用限制、反馈模板和内容使用边界。

* [下载完整 Capstone Lua 工程](https://u5-creator.s3.game.163.com/manual/downloads/se-ugc-lua-capstone.zip)
* 教程与 API 页面冲突时，以目标版本的正式 API 页面和 Meta 为准，并停止复制冲突片段。
* “已编译”不等于“行为已验证”；各章期望效果仍需在自己的测试地图验收。

## 阅读路径

* 先读第 0-11 章，完成脚本工程、碰撞、计分、UI 和存储闭环。
* 再按项目需要阅读第 12-22 章，覆盖物理、角色、资产、Manager、平台服务、QA 和 Capstone。
* 本目录只包含最终章节正文，适合离线阅读、二次排版或导入其他 Markdown 阅读工具。

## 代码块阅读约定

教程里的代码块分三类阅读：

* 标题写成具体路径的代码块，例如 `server/main.lua`、`client/hud.lua`，表示建议放入该文件的完整示例或主体代码。
* 没有文件路径标题的代码块，多数是局部片段，用来说明某个 API、判断条件或错误写法，不一定能单独复制运行。
* `data/*.lua`、`testspec_*.md`、`evidence/*` 这类代码块是配置、测试说明或验收记录模板，不是运行时脚本。

复制代码时先看代码块上方的小标题和上下文：完整文件按目录放置，局部片段合并到当前章节已有示例里，配置和证据模板则放到对应目录中维护。

## 最终文档目录

| 章 | 标题 |
| --- | --- |
| 00 | [第 0 章：从可视化编辑器到状态同步 Lua 开发](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/00-from-editor-to-se-lua.html) |
| 01 | [第 1 章：脚本工程、目录结构与运行入口](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/01-project-setup-and-entrypoints.html) |
| 02 | [第 2 章：编辑器对象、属性、坐标与枚举在 Lua 中的表达](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/02-objects-properties-coordinates-enums.html) |
| 03 | [第 3 章：统一世界、双端模型与逻辑帧](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/03-world-client-server-loop.html) |
| 04 | [第 4 章：Game 与 Services](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/04-game-and-services.html) |
| 05 | [第 5 章：Unit 与场景树](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/05-world-unit-scene-tree.html) |
| 06 | [第 6 章：事件、Timer 与 Task](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/06-events-task-timer.html) |
| 07 | [第 7 章：Players、输入与角色](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/07-players-input-character.html) |
| 08 | [第 8 章：客户端与服务端通信](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/08-client-server-remote-event.html) |
| 09 | [第 9 章：UI / EUI 与 CoreGui](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/09-ui-eui-coregui.html) |
| 10 | [第 10 章：数据脚本、配置与资产 URI](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/10-data-config-assets.html) |
| 11 | [第 11 章：数据存储与排行榜](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/11-datastore-ranking.html) |
| 12 | [第 12 章：物理、碰撞、Raycast、约束与运动器](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/12-physics-raycast-constraints.html) |
| 13 | [第 13 章：角色系统——EggyUnit、HumanUnit 与外观](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/13-character-system.html) |
| 14 | [第 14 章：角色控制与动画——Controller 与 Animator](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/14-character-controller-animation.html) |
| 15 | [第 15 章：相机系统——CameraService 与 CameraUnit](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/15-camera-system.html) |
| 16 | [第 16 章：音效、特效与场景渲染](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/16-sound-effect-rendering.html) |
| 17 | [第 17 章：资产加载——用 preset 创建模型](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/17-asset-loading.html) |
| 18 | [第 18 章：自定义资产系统](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/18-custom-asset-system.html) |
| 19 | [第 19 章：可复用系统——Manager、生命周期与依赖边界](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/19-reusable-systems-managers.html) |
| 20 | [第 20 章：平台服务：聊天、跨服、社交、商业化、埋点](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/20-platform-services.html) |
| 21 | [第 21 章：测试、调试、日志与 QA](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/21-testing-debugging-qa.html) |
| 22 | [第 22 章：Capstone 综合项目](https://u5-creator.s3.game.163.com/manual/docs/manual/tutorials/se-ugc-lua/22-capstone-projects.html) |
