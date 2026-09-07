# 给 Agent 的升级任务书

升级使用新版仓库作为来源，不能把新版文件直接覆盖到用户工作区，也不能覆盖用户的玩法需求、开发计划、资产清单、项目 README 或开发日志。

## 准备

1. 把新版仓库放到新的临时目录。
2. 读取新版 `VERSION`（版本号）和 `release-manifest.json`（发布清单）。
3. 运行新版 `scripts/validate-release.ps1`；失败立即停止。
4. 确认地图外的总工作区存在 `.eggy-agent/install-state.json`（工作区安装状态）；不要把 `WorkspaceRoot` 指向单张地图。旧状态若在地图里，先报告错误安装的位置并确认迁移，不在原地继续升级或自动删除。使用 ZCode（智谱代码代理）或全局状态时，按状态文件选择对应宿主，不要猜。

## 执行

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "<新版包>\scripts\update-eggy-agent.ps1" `
  -WorkspaceRoot "<总工作区根>" `
  -PackageRoot "<新版包>"
```

升级器会从安装状态恢复已选技能和任务域，而不是无条件安装全部技能；技能处于停用状态时继续停用。若受管文件、规则区块或登记地图版本被改过、缺失或损坏，先列出冲突并停止，不静默覆盖。

## 不会修改

- 地图玩法需求、开发计划、资产清单、项目 README 和开发日志。
- `AGENTS.md` 受管标记之外的用户内容。
- 地图代码、资产和官方生成文件。
- 普通工具项目的地图规则。

模板变化只写入 `.eggy-agent/template-upgrade-report.md`，供代理按需比较。只有版本或受管文件确实发生变化时升级才建立一次备份；无变化时直接返回。需要回退时使用输出的恢复命令：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "<工作区>\.eggy-agent\scripts\restore-eggy-agent.ps1" -WorkspaceRoot "<工作区>" -BackupPath "<备份目录>"
```

升级后请新建会话，让宿主重新发现新版技能；已经加载旧内容的会话不会热替换。
