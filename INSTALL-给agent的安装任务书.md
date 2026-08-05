# 给 Agent 的安装任务书

> 目标：用户回答三个问题后，由脚本完成双版本工具包安装或登记新地图。你负责核对输入和结果，不负责自行合并文件。

## 一、安装前确认

向用户确认：

- 总工作区目录，例如 `<总工作区根>`。
- 当前地图工程，例如 `<总工作区根>\LuaSource_地图名`。
- `Single`（单人）或 `Multiplayer`（多人）。

检查地图工程存在且位于总工作区内。脚本会交叉检查原点版或世界版标记；冲突或无法识别时必须停止。

## 二、确认安装包

本任务书所在目录就是安装包根目录。检查以下文件存在：

```text
VERSION
release-manifest.json
scripts\install-eggy-agent.ps1
scripts\validate-release.ps1
skills\eggy-lua-coding\SKILL.md
```

先执行候选包验证：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "<安装包根>\scripts\validate-release.ps1" -PackageRoot "<安装包根>"
```

验证失败时停止并逐字汇报错误，不修改发布清单或技能来强行通过。

## 三、执行安装

单人地图：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "<安装包根>\scripts\install-eggy-agent.ps1" -WorkspaceRoot "<总工作区根>" -ProjectPath "<地图工程>" -PlayerMode Single
```

多人地图把最后一个参数改为：

```text
-PlayerMode Multiplayer
```

安装器会完成：

- 校验发布清单和全部受管文件指纹。
- 识别原点版或世界版，阻止版本标记冲突、工作区外路径和旧技能重复加载。
- 检查地图是否为独立版本仓库；没有仓库时建立本地基线，基线不代表玩法正确。
- 备份即将修改的文件。
- 把十一项共享技能安装到总工作区的 `.agents\skills`（通用代理技能目录）；后续地图不会重复复制。
- 把脚本、模板、发布清单和安装状态放入 `.eggy-agent`（工具包状态目录）。
- 在总工作区与地图规则文件中只维护带标记的公共区块。
- 只创建缺失的玩法需求、开发计划、资产清单、项目说明和开发日志。

同一总工作区新增其他地图时，再用新地图路径运行一次同一安装命令。脚本只登记地图和创建该地图缺失的项目文档。

## 四、验收

逐项检查：

- 安装结果明确写成功和版本号。
- `.agents\skills` 中正好有十一项 `eggy-`（蛋仔）技能。
- `.eggy-agent\install-state.json`（安装状态）存在。
- 总工作区和地图的 `AGENTS.md`（代理规则）都含完整的受管起止标记。
- 每张地图只有一份玩法需求、开发计划、资产清单、项目说明和开发日志；已有文档没有被覆盖。
- 地图版本仓库根目录就是地图工程目录，已有用户改动没有被丢弃。
- 安装器给出了准确恢复命令和备份位置。

任何一项不满足都不能告诉用户“装好了”。

## 五、向用户汇报

只用大白话说明：

1. 装了哪些东西，各自保护什么。
2. 当前版本和备份位置。
3. 版本基线只是恢复点，不代表地图功能正确。
4. 用代理打开总工作区，不要只打开地图子目录；关闭当前会话并新建会话。
5. 新建会话后先从一个很小的功能开始，并让用户亲自试玩确认效果。
