# 蛋仔 Agent 技能包

这是一个面向蛋仔地图作者和蛋仔辅助工具开发者的可复用 Agent（代理）技能包。公开仓库是唯一源码；安装到项目后的 `.agents/skills` 或 `.zcode/skills` 只是运行副本。

## 解决什么问题

- 让代理按当前任务加载必要技能，而不是每次把整套手册塞进上下文。
- 把原点版、世界版和辅助工具分成独立任务域，避免把一套编辑器的规则套到另一套。
- 在写 Lua（脚本）前先查接口，在修改外部导出前保护名称和参数契约。
- 用一张地图一套需求、计划、资产、总览和开发日志，减少跨会话重新解释。
- 为安装、升级、停用和恢复保存状态与备份，不覆盖用户自己的文档和规则。

## 技能档案

技能和档案的完整清单见 [`skill-catalog.json`](skill-catalog.json)。当前包包含地图开发、辅助工具、封面、文档转换和质量检查等不同用途；安装器会按任务域选择，不以固定数量判断完整性。

| 档案 | 默认用途 |
|---|---|
| `map-origin` | 原点版地图核心开发 |
| `map-world` | 世界版地图核心开发 |
| `tooling` | 蛋仔编辑器插件、命令行、转换器和技能工具 |
| `common` | 地图与工具都能使用的极简实现和接口研究 |
| `*-optional` | 封面、节点改名、模型操作、文档整理等按需能力 |

`eggy-ponytail`（极简开发）同时服务地图和工具；普通工具项目不会因此加载地图运行规则。

## 安装

把仓库地址交给 Agent（代理）：

> 帮我安装这个蛋仔 Agent 技能包：`https://github.com/Zx9874/eggy-agent-skills`

默认是项目级安装。地图安装时代理只需要确认总工作区、地图工程和单人或多人；辅助工具安装时不询问地图。全局安装必须由用户明确提出，不能被默认流程偷偷修改。

OpenCode（开放代码代理）和 Codex（代码代理）使用项目 `.agents/skills`；ZCode（智谱代码代理）使用 `.zcode/skills`。安装后请用代理打开总工作区，并在新会话中使用技能。

## 官方手册镜像

仓库同时公开收录原点版和世界版官方手册的 Markdown（标记语言）快照，入口在 [`docs/official/README.md`](docs/official/README.md)。当前快照于 2026-08-27 抓取，版本登记为 8.28；世界版手册已经是公开可访问资料，不再按白名单或受限资料处理。

手册镜像只用于按需检索，不属于安装技能。安装器和发布压缩包会明确排除 `docs/official`，避免把数百篇手册复制到每个项目并占用代理上下文。

## 公开边界

仓库公开收录的官方手册镜像仅位于 `docs/official`，不包含私人地图、未公开或需要授权的资料、官方工程、官方自动生成工作区、原始私人知识库、真实资产编号、个人路径、模型密钥或外部模型配置。手册镜像不等于可靠结论；未经证据支持的接口、数值上限和编辑器行为只能留在当前项目的待查证区，不能冒充公共结论。

## 本地验证

维护者可在 Windows PowerShell 5.1（Windows 脚本环境）中运行：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\generate-release-manifest.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-release.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tests\release-smoke.ps1
```

测试只使用系统临时目录，不读取真实地图，也不启动编辑器。公开推送前先审查差异、版本和隐私扫描结果。
