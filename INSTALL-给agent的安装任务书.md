# 给 Agent 的安装任务书

## 目标

把本仓库的技能按当前宿主和任务域安装到项目，不把官方手册、私人资料或地图运行文件复制进公开包。公开包是源码，项目目录中的技能是安装结果。

## 安装前

1. 读取 `START-HERE.md` 和 `skill-catalog.json`。
2. 在安装包根目录运行发布校验：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "<安装包根>\scripts\validate-release.ps1" -PackageRoot "<安装包根>"
```

3. 校验失败时原样报告问题并停止，不手工改清单、删文件或跳过校验。

## 地图安装

单人地图把 `PlayerMode` 设为 `Single`，多人地图设为 `Multiplayer`：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "<安装包根>\scripts\install-eggy-agent.ps1" `
  -WorkspaceRoot "<总工作区根>" `
  -ProjectPath "<地图工程>" `
  -PlayerMode Single `
  -Agent Auto `
  -Scope Project `
  -Profile Auto
```

`Profile Auto` 会依据工程版本选择 `map-origin`（原点版）或 `map-world`（世界版）。两种版本不能混用规则。需要可选技能时才添加 `-IncludeOptional`。

## 辅助工具安装

当前工作区是编辑器插件、命令行封装、转换器、文档工具或技能源码时，不传地图路径，不加载地图规则：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "<安装包根>\scripts\install-eggy-agent.ps1" `
  -WorkspaceRoot "<工具项目根>" `
  -Agent Auto `
  -Scope Project `
  -Profile tooling
```

需要编辑器操作、节点改名、预设处理、文档转换等能力时，再明确添加 `-IncludeOptional`。

## 全局安装

全局范围必须由用户明确要求。执行前再次确认宿主和要安装的档案：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "<安装包根>\scripts\install-eggy-agent.ps1" `
  -WorkspaceRoot "<当前工作区>" `
  -Agent Codex `
  -Scope Global `
  -Profile tooling
```

全局安装不会登记地图，也不会写地图规则和项目文档。
全局技能启停只切换全局技能，不接受 `IncludeRules`；工作区和地图规则只能在项目范围内按需切换。

## 安装器会做什么

- 校验来源文件指纹，动态读取技能清单，不依赖固定技能数量。
- 按宿主写入 `.agents/skills` 或 `.zcode/skills`，支持重复安装和同一工作区多张地图登记。
- 地图首次安装时检查独立 Git 仓库，并在缺失时建立当前状态基线。
- 只在地图缺失时创建一份需求文档、开发计划、资产清单、项目 README 和开发日志。
- 只维护 `AGENTS.md` 中带 `EGGY-AGENT` 标记的公共区块，区块外用户内容不覆盖。
- 记录安装状态、选定档案、宿主、版本、备份和已登记地图。

## 验收

确认输出包含版本、宿主、档案、技能目录、状态路径和备份位置。确认用户已有文档没有被覆盖，官方生成目录没有被写入，地图规则明确标出原点版或世界版。安装完成后打开总工作区并新建会话；当前旧会话已读到的技能不会自动卸载。
