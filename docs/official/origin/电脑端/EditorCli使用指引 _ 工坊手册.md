# editor-cli 使用指引

> 面向游戏开发者的命令行工具，用于与运行中的编辑器实例交互：状态查询、地图管理、试玩控制、日志分析、远程执行 Lua、代码同步、截图与文档搜索。

---

## 目录

* [简介](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#简介)
* [命令速查表](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#命令速查表)
* [前置准备](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#前置准备)
  + [1. 开启编辑器端口](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#_1-开启编辑器端口)
  + [2. 快速上手：打开终端，输入第一条命令](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#_2-快速上手-打开终端-输入第一条命令)
  + [3. 多编辑器实例](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#_3-多编辑器实例)
* [全局选项](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#全局选项)
* [命令详解](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#命令详解)
  + [status — 查看编辑器状态](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#status-—-查看编辑器状态)
  + [editor-instances — 管理编辑器实例](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#editor-instances-—-管理编辑器实例)
  + [map — 地图管理](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#map-—-地图管理)
  + [play — 试玩控制](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#play-—-试玩控制)
  + [exec — 执行 Lua 代码](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#exec-—-执行-lua-代码)
  + [code — 本地代码与编辑器同步](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#code-—-本地代码与编辑器同步)
  + [log — 日志查看与分析](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#log-—-日志查看与分析)
  + [screenshot — 截图](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#screenshot-—-截图)
  + [docs search — 搜索文档与 API 知识](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#docs-search-—-搜索文档与-api-知识)
* [旧命令迁移对照](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#旧命令迁移对照)
* [编辑时 API（Idle 状态）](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#编辑时-api-idle-状态)
* [调试时 API（Playing 状态）](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#调试时-api-playing-状态)
* [引号规则](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#引号规则)
* [如何读取 exec 的执行结果](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#如何读取-exec-的执行结果)
* [常见问题](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#常见问题)

---

## 简介

editor-cli 是一个命令行工具，让你在终端里就能操控编辑器。主要能力：

* **查看状态和日志**：确认编辑器是否在线、拉取报错日志、按关键字过滤、生成结构化错误报告
* **地图与试玩控制**：列出/打开地图、开始/停止/重启试玩
* **远程执行 Lua 代码**：在编辑器、服务器或客户端上下文运行脚本，实现场景搭建、UI 编辑、玩家操控等操作
* **代码同步**：把编辑器里的脚本工程映射到本地目录，支持 diff / push / pull / validate 的完整工作流
* **截图与文档搜索**：远程截取编辑器/游戏画面，搜索官方文档与 API 知识库
* **配合 AI 实现自动化**：editor-cli 可以给 AI 调用，通过编写 Skill，让 AI 通过 editor-cli 自动完成场景生成、批量修改、调试等重复性工作

---

## 命令速查表

| 命令 | 用途 | 典型场景 |
| --- | --- | --- |
| `status` | 查看编辑器/地图/试玩整体状态 | 确认编辑器是否在线、是否在试玩中 |
| `editor-instances list` | 列出所有运行中的编辑器实例 | 多开编辑器时确认要连哪个 |
| `editor-instances use <id>` | 切换默认编辑器实例 | 固定连接某个实例 |
| `map list` | 列出地图（本地/草稿/已发布） | 查找地图名、map\_key |
| `map current` | 查看当前打开的地图 | 确认编辑器打开了哪张图 |
| `map open <name>` | 打开地图 | 脚本化切换地图 |
| `play start` / `stop` / `restart` | 开始/停止/重启试玩 | 一键调试，无需点编辑器按钮 |
| `exec <code>` | 远程执行 Lua 代码 | 热修数据、动态调试、查询运行时状态 |
| `code init` | 绑定本地目录与地图的代码映射 | 每个工作区执行一次 |
| `code diff` | 三方对比本地与编辑器代码差异 | 推送前先审阅变更 |
| `code push` / `pull` | 推送/拉取代码 | 本地 ↔ 编辑器双向同步 |
| `code validate` | 校验本地 Lua 代码 | 提交前做语法/结构检查 |
| `log tail` | 查看最近日志 | 替代旧版 `logs` / `watch` |
| `log grep <regex>` | 按正则过滤日志 | 定位关键字报错 |
| `log trace` | 生成某次试玩的结构化错误报告 | 崩溃/报错归因 |
| `log latest` | 查看最近一次试玩的原始日志 | 复盘上一局 |
| `screenshot <editor|game>` | 截取编辑器/游戏画面 | 远程确认画面状态 |
| `docs search <query>` | 搜索官方文档与 API 知识 | 查"如何创建 Unit"这类问题 |

---

## 前置准备

editor-cli 通过与编辑器通信实现操控编辑器。使用前需要：

1. 启动编辑器并开启 editor-cli
2. 打开终端连接验证

---

### 1. 开启编辑器端口

首先，确保编辑器已启动，并在编辑器中启用 editor-cli。

> **注：** 新版 editor-cli 会自动发现编辑器注册的连接信息（编辑器启动时写入实例注册表），**不再需要手动指定 `--host` / `--port`**。

---

### 2. 快速上手：打开终端，输入第一条命令

编辑器端口开启后，就可以用命令行工具与编辑器通信了。如果你之前没用过命令行，跟着下面几步走就行。

#### 2.1 打开 PowerShell

按键盘上的 `Win + R`，输入 `powershell`，然后回车。你会看到一个蓝底或黑底的窗口，这就是命令行终端。

你也可以用 `cmd`（命令提示符），操作方式一样。本文以 PowerShell 为例。

#### 2.2 进入工具所在目录

`editor-cli.exe` 是一个独立的可执行文件，你需要先让终端"进入"它所在的文件夹。

默认 `editor-cli.exe` 在 `~/.eggitor/cli` 目录（~/代表当前用户目录）下：

```powershell
# 进入目录
cd ~/.eggitor/cli
```

输入后回车，终端的当前路径就会变成 `~/.eggitor/cli`。你可以用以下命令确认：

```powershell
# 查看当前所在目录
pwd

# 查看当前目录下有哪些文件（应该能看到 editor-cli.exe）
dir
```

#### 2.3 验证连接

现在输入第一条命令，检查是否能连上编辑器：

```powershell
.\editor-cli.exe status
```

> **注意：** 在 PowerShell 中运行当前目录下的 exe，需要在文件名前加 `.\`。如果是在 cmd 中，直接输入 `editor-cli.exe status` 即可。

如果看到类似以下输出，说明连接成功，可以继续使用后续命令了：

```
Editor Status:
  running          True
  edit_mode        True
  in_game_runtime  False
  map_name         AISkillMap
  map_id           69f2f39d293aeb4c48ab43ca
  editor_state     idle
  editor_mode      se
  log_file         D:\u5\ed2_code\season\client\logs\editor_38564.log
```

如果连接失败，请检查：

* 编辑器是否已启动
* editor-cli 功能是否已在编辑器中开启
* 是否同时开了多个编辑器实例（见 [多编辑器实例](https://u5-creator.s3.game.163.com/manual/pc_md/editor_cli.html#_3-多编辑器实例)）

#### 2.4 命令格式说明

所有命令都遵循以下格式：

```
editor-cli.exe [命令] [选项]
```

* **命令**（如 `status`、`log tail`、`play start`）决定你要做什么
* **选项**（如 `--lines`、`--json`、`--timeout`）跟在命令后面

举个例子：

```powershell
# 查看最近 20 条 error 级日志
.\editor-cli.exe log tail --lines 20 --level error

# 以 JSON 格式输出状态（便于脚本解析）
.\editor-cli.exe status --json
```

每个命令都可以加 `-h` 查看帮助：

```powershell
.\editor-cli.exe -h
.\editor-cli.exe log tail -h
```

#### 2.5 小技巧

| 技巧 | 说明 |
| --- | --- |
| `Tab` 键自动补全 | 输入文件名前几个字母后按 Tab，会自动补全 |
| `↑` 方向键 | 调出上一条输入过的命令，不用重复敲 |
| `Ctrl + C` | 终止正在运行的命令 |
| 右键粘贴 | 在 PowerShell 中，选中文本后按右键即可粘贴 |

---

### 3. 多编辑器实例

同时运行多个编辑器时，editor-cli 默认连接"默认实例"。可以用以下命令查看和切换：

```powershell
# 列出所有运行中的实例（含 pid、http 端口、地图名）
.\editor-cli.exe editor-instances list

# 切换默认实例（id 可以是 地图名 / pid / http 端口）
.\editor-cli.exe editor-instances use AISkillMap
.\editor-cli.exe editor-instances use 38564
```

也可以对单条命令临时指定实例，不改变默认：

```powershell
.\editor-cli.exe status --editor-instance AISkillMap
.\editor-cli.exe log tail --editor-instance 19857
```

---

## 全局选项

以下选项对所有命令生效：

| 选项 | 说明 |
| --- | --- |
| `--timeout <秒>` | 请求超时时间，默认 5 秒。大地图加载、试玩启动等慢操作可适当调大 |
| `--json` | 输出原始 JSON，便于脚本解析 |
| `--editor-instance <id>` | 临时指定编辑器实例（地图名 / pid / http 端口），默认连默认实例 |
| `-h`, `--help` | 查看帮助 |

---

## 命令详解

### status — 查看编辑器状态

**作用：** 检查编辑器是否在线、当前地图、是否处于试玩中。这是最常用的"探活"命令。

**调试场景：**

* 不确定编辑器是否卡死时，快速确认
* 脚本/自动化流程中作为健康检查
* 通过 `editor_state` 字段轮询试玩状态（`idle` / `playing` 等）

**基本用法：**

```powershell
editor-cli.exe status
```

**输出示例：**

```
Editor Status:
  running          True
  edit_mode        False
  in_game_runtime  True
  map_name         AISkillMap
  map_id           69f2f39d293aeb4c48ab43ca
  editor_state     playing
  editor_mode      se
  play_session     77389d5
  log_file         D:\u5\ed2_code\season\client\logs\editor_38564.log
```

**获取 JSON 格式（便于脚本解析）：**

```powershell
editor-cli.exe status --json
```

---

### editor-instances — 管理编辑器实例

**作用：** 列出、切换编辑器实例。多开编辑器时使用。

```powershell
# 列出所有实例
editor-cli.exe editor-instances list

# 交互式选择实例，打印建议的连接命令
editor-cli.exe editor-instances list --select

# 切换默认实例（id 支持 地图名 / pid / http 端口）
editor-cli.exe editor-instances use <id>
```

**输出示例：**

```
Editor instances:
  [0] AISkillMap  (pid=38564, http=19857, alive)
  [1] TestMap     (pid=41200, http=19859, alive)
```

---

### map — 地图管理

**作用：** 列出、查看、打开地图（本地 / 草稿 / 已发布）。

```powershell
# 列出所有地图（local / draft / published / all，默认 all）
editor-cli.exe map list

# 按类型和关键字过滤
editor-cli.exe map list --type local --keyword 赛车

# 交互式选择地图，打印建议的打开命令
editor-cli.exe map list --select

# 查看当前打开的地图
editor-cli.exe map current

# 打开地图（按名称搜索，唯一匹配则直接打开）
editor-cli.exe map open AISkillMap

# 按云端 map_key 打开（草稿 / 已发布）
editor-cli.exe map open --key <map_key> --type draft
```

> **注：** 未登录编辑器时，草稿/已发布地图不可见，`map list` 会提示 `login_required`。

---

### play — 试玩控制

**作用：** 开始、停止、重启试玩，无需在编辑器里点按钮。

```powershell
# 开始试玩（运行当前地图）
editor-cli.exe play start

# 停止试玩
editor-cli.exe play stop

# 重启试玩
editor-cli.exe play restart
```

**输出示例：**

```
Playtest started (mode=se, session=47d358a).
```

开始试玩后，编辑器会经过 `entering` → `map-loading` → `playing` 的过渡。可以用 `status` 命令轮询，等 `editor_state` 变为 `playing` 后再执行游戏内操作。`play start` 返回的 `session` id 可用于 `log trace` / `log latest` / `log grep` 的 `--play-session` 参数。

---

### exec — 执行 Lua 代码

**作用：** 远程在编辑器环境中执行 Lua 代码。这是最强大的调试命令，可以在编辑时操作场景和 UI，也可以在调试时操控游戏内玩家。

**基本用法：**

```powershell
# 执行并直接返回结果（Lua 代码里写 return 即可拿到返回值）
.\editor-cli.exe exec "return 1 + 1"
# 输出：2

.\editor-cli.exe exec "print('hello')"
# 输出：hello
```

**指定执行上下文（世界编辑器 / SE 模式）：**

```powershell
# 在编辑器上下文执行（默认）
.\editor-cli.exe exec "return 1+1"

# 在服务器上下文执行（试玩中的服务端逻辑）
.\editor-cli.exe exec "return 'server ok'" --context server

# 在客户端上下文执行（试玩中的客户端逻辑）
.\editor-cli.exe exec "return 'client ok'" --context client
```

可选上下文：`editor`（默认）、`server`、`client`。`server` / `client` 仅在试玩进行中可用。

**错误处理：** Lua 语法错误或运行时错误会输出完整堆栈信息，并以非零退出码结束，便于脚本判断失败：

```
Execution failed: execute:1: boom
execute:1: in chunk
...
```

**调试场景：**

* **开启/关闭试玩**：见 `play` 命令，也可用 `EditorAPI.run_game()`
* **查询场景数据**：获取场景中所有单位、选中单位、单位属性
* **操控游戏内玩家**：瞬移、移动、跳跃、广播自定义事件
* **搭建场景**：批量创建组件、设置缩放和旋转
* **编辑 UI**：创建文本/按钮/图片节点、修改属性
* ……

> deprecated 说明：旧版 `eval` 命令仍可用，等同于 `exec`，新脚本请使用 `exec`。

---

### code — 本地代码与编辑器同步

**作用：** 把地图的脚本工程映射到本地目录，用你喜欢的编辑器写代码，再同步回编辑器。支持三方对比（本地 / 上次同步基线 / 编辑器侧），冲突可检测、可审阅。

#### code init — 初始化映射（每个工作区执行一次）

```powershell
# 绑定到编辑器当前打开的地图
editor-cli.exe code init

# 显式指定本地地图目录
editor-cli.exe code init --map D:/u5/all_maps/3001000_复道行空

# 按地图 ID / 名称解析
editor-cli.exe code init --map-id 3001000
editor-cli.exe code init --map-name 复道行空

# 覆盖冲突的已有工作区文件
editor-cli.exe code init --force
```

* 需要编辑器在线并打开目标地图（仅在线模式）。
* 地图没有脚本时会生成默认 `main.lua` 脚手架，并导出 API 桩文件（EggyAPI / EggyEditorAPI / DebugTools），方便本地 IDE 补全。
* 映射信息写入工作区的 `.editorcli/code-state.json`。
* 可用 `--workspace <目录>` 指定工作区，默认为当前目录。

#### code diff — 查看差异（只读，随时安全）

```powershell
# 三方对比：本地 vs 上次同步基线 vs 编辑器侧
editor-cli.exe code diff

# 附带 unified diff 内容（大 diff 自动落到 artifact 文件）
editor-cli.exe code diff --show-diff
```

每个文件会被分类为 created / updated / deleted / unchanged / conflicted。**冲突是数据不是失败**，退出码仍为 0。

#### code push — 推送本地代码到编辑器

```powershell
# 先演练，只看计划不写任何东西（强烈建议）
editor-cli.exe code push --dry-run --show-diff

# 实际推送
editor-cli.exe code push

# 允许删除编辑器侧文件（本地已删的文件）——需要同时加 --yes 确认
editor-cli.exe code push --delete --yes

# 覆盖"双侧都改过"的冲突
editor-cli.exe code push --force
```

* 地图关闭时：原子写入散图目录，编辑器需重启后生效（`restart_required`）。
* 地图打开时：走在线通道写入并热重载，立即生效。
* 安全机制：双侧都修改的冲突会中止整批推送；涉及删除必须 `--delete` + `--yes`。

#### code pull — 拉取编辑器代码到本地

```powershell
# 先演练
editor-cli.exe code pull --dry-run

# 实际拉取
editor-cli.exe code pull

# 覆盖本地冲突文件
editor-cli.exe code pull --force

# 确认删除本地文件（编辑器侧已删的文件）
editor-cli.exe code pull --yes
```

本地有冲突修改时会以 `CODE_SYNC_CONFLICT` 中止，除非加 `--force`。

#### code validate — 校验本地代码（纯本地，无需编辑器）

```powershell
# 校验语法结构、UTF-8 编码、世界编辑器/原点编辑器目录布局
editor-cli.exe code validate

# 严格模式：额外校验同步集的虚拟路径合法性
editor-cli.exe code validate --strict
```

> 说明：这是轻量级结构检查（块/字符串/注释配对），不是完整语法解析。发现问题时以非零退出码结束，适合接入 CI。

---

### log — 日志查看与分析

新版日志命令基于日志文件（默认取编辑器状态中的 `log_file`，也可用 `--log-path` 指定），不再依赖内存缓冲区。`--json` 输出附带日志路径来源、窗口完整性、增量游标等机器字段，便于脚本做增量读取与轮转检测。

#### log tail — 查看最近日志

```powershell
# 最近 100 行（默认）
editor-cli.exe log tail

# 最近 20 行
editor-cli.exe log tail --lines 20

# 按级别过滤：error | warn | info | debug
editor-cli.exe log tail --level error

# 按来源过滤：client | server | editor
editor-cli.exe log tail --source server

# 指定日志文件 / 限制读取字节数 / 严格 UTF-8 解码
editor-cli.exe log tail --log-path D:\path\to\editor_38564.log --max-bytes 2097152 --encoding utf8
```

#### log grep — 按正则过滤日志

```powershell
# 关键字过滤（默认忽略大小写，带 2 行上下文）
editor-cli.exe log grep "boom"

# 正则 + 自定义上下文行数 + 大小写敏感 + 限制匹配数
editor-cli.exe log grep "attempt to (call|index)" --context 3 --case-sensitive --max-matches 20

# 限定在某次试玩会话范围内搜索
editor-cli.exe log grep "attempt to" --play-session 77389d5
```

#### log trace — 结构化错误报告

```powershell
# 分析当前/最近一次试玩（默认输出 JSON）
editor-cli.exe log trace

# 人类可读文本输出
editor-cli.exe log trace --text

# 指定试玩会话 id
editor-cli.exe log trace --play-session 77389d5

# 合并外部规则文件 / 关闭多行堆栈捕获
editor-cli.exe log trace --patterns-file my-rules.json --no-multiline
```

自动归类错误（Lua 异常、服务 meta 缺失、堆栈等），给出 freshness 判断和错误统计，适合崩溃归因。

#### log latest — 最近一次试玩的原始日志

```powershell
# 查看最近一次试玩的完整日志
editor-cli.exe log latest

# 指定会话 + 级别过滤
editor-cli.exe log latest --play-session 77389d5 --level error
```

> deprecated 说明：旧版 `logs`、`watch` 命令仍可用，分别等价于 `log tail`；新版日志基于文件，`clear-logs` 已无必要。

---

### screenshot — 截图

**作用：** 远程截取编辑器窗口或游戏画面。

```powershell
# 截取编辑器画面（默认保存到 <文档目录>/editor_cli_screenshots/）
editor-cli.exe screenshot editor

# 截取游戏画面，指定保存路径
editor-cli.exe screenshot game -o D:\shots\game.png

# PNG 字节直接输出到终端 stdout（便于管道处理）
editor-cli.exe screenshot editor --stdout > editor.png

# 已存在时不覆盖，自动改名加 -1/-2 后缀
editor-cli.exe screenshot editor -o D:\shots\editor.png --no-clobber
```

---

### docs search — 搜索文档与 API 知识

**作用：** 搜索云端官方文档与 API 知识库，无需连接编辑器（但需要编辑器处于登录状态）。

```powershell
# 默认搜索编辑器使用手册
editor-cli.exe docs search "如何发布地图"

# 指定知识库：manual / game-api / editor-api / asset
editor-cli.exe docs search "如何创建 Unit" --docset game-api
editor-cli.exe docs search "官方预设单位" --docset asset

# 限制返回条数（推荐 2-3，前面的结果最相关）
editor-cli.exe docs search "如何发布地图" --limit 3
```

知识库说明：

| docset | 内容 |
| --- | --- |
| `manual` | 编辑器用户手册（默认） |
| `game-api` | 运行时游戏 API（Service / Unit / Enum 等） |
| `editor-api` | 编辑器 Lua API（用脚本操控编辑器本身） |
| `asset` | 官方资源与预设（预设单位、官方资源列表） |

> 注：原点编辑器（fs）暂无远程知识库，仅支持世界编辑器（se）工程。未登录或 token 过期时会提示重新登录编辑器。标记 `[索引型片段]` 的条目是继承成员索引列表，不是 API 用法文档。

---

## 旧命令迁移对照

以下旧命令已标记 deprecated，仍可使用，但建议迁移到新命令：

| 旧命令 | 新命令 |
| --- | --- |
| `logs` | `log tail` |
| `watch` | `log tail`（新版日志基于文件，直接反复 tail 即可） |
| `clear-logs` | 不再需要（文件日志无需清空缓冲区） |
| `eval <code>` | `exec <code>` |
| `set-default-server <id>` | `editor-instances use <id>` |
| `--host` / `--port` 选项 | 自动发现实例，用 `--editor-instance` 选择 |

---

## 编辑时 API（Idle 状态）

> 📖 编辑时 API 文档：世界编辑器参考 editor\_sdk 各 Service 源码，原点编辑器参考 [EggyEditorAPI](https://u5-creator.s3.game.163.com/manual/pc_md/lua/EggyEditorAPI.html)

> ⚠️ **重要：世界编辑器（SE / 状态同步）与原点编辑器（FS / 帧同步）的编辑时 API 不同**
>
> * **世界编辑器（SE / 状态同步）**：使用 **editor\_sdk**。通过全局变量 `editor` 获取各服务再调用方法，形如 `editor:GetService("World"):FindUnitsByName("Enemy")`
> * **原点编辑器（FS / 帧同步）**：使用 **EditorAPI**。直接调用静态接口，形如 `EditorAPI.get_all_unit_ids()`
> * 两种模式未来会**统一到 editor\_sdk 形式**，新写的自动化脚本建议优先熟悉 editor\_sdk 的调用方式
>
> 判断当前编辑器：`status` 输出中的 `editor_mode` 字段（`se` = 世界编辑器，`fs` = 原点编辑器）。以下示例均分别给出两种编辑器的写法。

### 开启 / 关闭试玩

```powershell
# 推荐：直接使用 play 命令（世界 / 原点编辑器通用）
.\editor-cli.exe play start
.\editor-cli.exe play stop
```

```powershell
# 世界编辑器（editor_sdk）：通过全局 editor 调用
.\editor-cli.exe exec "editor:RunGame()"
.\editor-cli.exe exec "editor:StopGame()"

# 原点编辑器（EditorAPI）：静态接口
.\editor-cli.exe exec "EditorAPI.run_game()"
.\editor-cli.exe exec "EditorAPI.stop_game()"
```

开始试玩后，编辑器会进入 `entering` → `map-loading` → `playing` 的过渡过程。可以用 `status` 命令轮询等待进入 `playing` 状态后再执行游戏内操作。

### 查询场景单位

```powershell
# 世界编辑器（editor_sdk）：先取 World 服务，再调方法
# 获取当前选中的单位列表
.\editor-cli.exe exec "local world = editor:GetService('World'); return world:getCurEditUnitList()"

# 世界编辑器：按名称查找单位
.\editor-cli.exe exec "local world = editor:GetService('World'); return world:FindUnitsByName('Enemy')"

# 世界编辑器：获取指定单位的详细数据
.\editor-cli.exe exec "local world = editor:GetService('World'); return world:getSceneUnitData(123)"
```

```powershell
# 原点编辑器（EditorAPI）
# 获取场景中所有单位的 ID
.\editor-cli.exe exec "return EditorAPI.get_all_unit_ids()"

# 获取当前选中的单位
.\editor-cli.exe exec "return EditorAPI.get_selected_unit_ids()"

# 按名称搜索单位
.\editor-cli.exe exec "return EditorAPI.query_scene_units('Enemy', false)"

# 获取指定单位的详细数据
.\editor-cli.exe exec "local d = EditorAPI.get_scene_unit_data(123); return d.name"
```

### 创建场景组件

```powershell
# 世界编辑器（editor_sdk）：按资源创建单位（contentId 为资源编号，坐标用 math.Vector3）
.\editor-cli.exe exec "local world = editor:GetService('World'); world:CreateAsset(100051, math.Vector3(0, 0, 10))"

# 世界编辑器：设置位置/旋转/缩放（rotation 为 math.Quaternion）
.\editor-cli.exe exec "local world = editor:GetService('World'); world:setUnitTransform(123, math.Vector3(5, 0, 5), math.Quaternion(0, 0, 0, 1), {2.0, 1.0, 2.0})"

# 世界编辑器：删除单位
.\editor-cli.exe exec "local world = editor:GetService('World'); world:deleteUnits({123})"
```

```powershell
# 原点编辑器（EditorAPI）：创建一个组件（key 为组件编号，坐标用 math.Vector3）
.\editor-cli.exe exec "EditorAPI.create_obstacle(100051, math.Vector3(0, 0, 10))"

# 原点编辑器：创建组件并设置缩放和旋转（一条命令完成）
.\editor-cli.exe exec "local uid = EditorAPI.create_obstacle(100051, math.Vector3(5, 0, 5)); EditorAPI.set_unit_attr(uid, 'scale', math.Vector3(2.0, 1.0, 2.0)); EditorAPI.set_unit_attr(uid, 'model_angle', {0, 90, 0})"

# 原点编辑器：删除组件
.\editor-cli.exe exec "EditorAPI.destroy_obstacle(123)"
```

### 修改单位属性

```powershell
# 世界编辑器（editor_sdk）：修改内置属性（propName 为 UnitType / Name / world_position / model_angle / scale 等）
.\editor-cli.exe exec "local world = editor:GetService('World'); world:setUnitProperty(123, 'Name', 'NewName')"
.\editor-cli.exe exec "local world = editor:GetService('World'); world:setUnitProperty(123, 'world_position', math.Vector3(0, 0, 10))"
```

```powershell
# 原点编辑器（EditorAPI）：修改单位名称
.\editor-cli.exe exec "EditorAPI.set_unit_attr(123, 'name', 'NewName')"

# 原点编辑器：修改透明度
.\editor-cli.exe exec "EditorAPI.set_unit_attr(123, 'model_alpha', 0.5)"

# 原点编辑器：修改血量
.\editor-cli.exe exec "EditorAPI.set_unit_attr(123, 'ob_max_hp', 500)"
```

> 世界编辑器更多接口（自定义属性 `setUnitAttribute`、克隆 `cloneUnit`、组合 `groupUnits`、物理 `setPhysicEnable` 等）见 editor\_sdk 各 Service 源码（`editor_sdk/services/common/WorldService` 等）。
>
> **注意：** editor\_sdk 目前接口命名 PascalCase 与 camelCase 混用（如 `CreateAsset` 与 `getSceneUnitData` 并存），且仍在演进中，以上示例均按运行时实际接口验证过；其余接口以运行时为准。

### 环境设置

```powershell
# 世界编辑器（editor_sdk）：获取相机属性
.\editor-cli.exe exec "return editor:GetService('Camera'):GetCameraProperties()"

# 世界编辑器：获取当前天空盒 ID
.\editor-cli.exe exec "return editor:GetService('Environment'):getCurSkybox()"
```

```powershell
# 原点编辑器（EditorAPI）：获取相机属性
.\editor-cli.exe exec "return EditorAPI.get_camera_properties()"

# 原点编辑器：获取当前天空盒 ID
.\editor-cli.exe exec "return EditorAPI.get_cur_skybox()"
```

### 截图

```powershell
# 推荐：直接使用 screenshot 命令（世界 / 原点编辑器通用）
.\editor-cli.exe screenshot editor

# 原点编辑器（EditorAPI）：也可以通过 exec 调 Lua API
.\editor-cli.exe exec "EditorAPI.take_screenshot()"

# 原点编辑器：指定分辨率截图
.\editor-cli.exe exec "EditorAPI.take_screenshot_with_size(1920, 1080)"
```

---

## 调试时 API（Playing 状态）

> 📖 调试时 API 文档：世界编辑器参考 editor\_sdk 各 Service 源码，原点编辑器参考 [EggyEditorAPI](https://u5-creator.s3.game.163.com/manual/pc_md/lua/EggyEditorAPI.html)

调试时操作需要先开始试玩（`play start`）并等待进入 `playing` 状态。游戏内逻辑通过"在试玩上下文执行代码"的方式下发，两种模式的入口不同：

* **世界编辑器（SE）**：`editor:ExecuteGameCode(code)`
* **原点编辑器（FS）**：`EditorAPI.game_execute(code)`
* 也可以直接用 `exec --context server` / `--context client` 在对应上下文运行（世界编辑器模式）

```powershell
# 世界编辑器（editor_sdk）
.\editor-cli.exe exec "editor:ExecuteGameCode('print([[hello from game]])')"

# 原点编辑器（EditorAPI）
.\editor-cli.exe exec "EditorAPI.game_execute('print([[hello from game]])')"
```

以下示例以原点编辑器的 `EditorAPI.game_execute()` 写法给出，世界编辑器把外层调用换成 `editor:ExecuteGameCode('...')` 即可。

### 获取玩家状态

```powershell
# 获取玩家位置
.\editor-cli.exe exec "EditorAPI.game_execute('local roles = GameAPI.get_all_roles(); if not roles or #roles == 0 then return end; local u = roles[1].get_ctrl_unit(); local pos = u.get_position(); print(pos)')"

# 获取玩家血量
.\editor-cli.exe exec "EditorAPI.game_execute('local roles = GameAPI.get_all_roles(); if not roles or #roles == 0 then return end; local u = roles[1].get_ctrl_unit(); print(u.get_life())')"

# 判断玩家是否死亡
.\editor-cli.exe exec "EditorAPI.game_execute('local roles = GameAPI.get_all_roles(); if not roles or #roles == 0 then return end; local u = roles[1].get_ctrl_unit(); print(u.is_die_status())')"
```

> **建议：** 每条命令只 `print` 一个值，避免在 `print()` 内做复杂字符串拼接。拼接容易因 PowerShell 引号转义出错。需要多个数据时分条执行，简单可靠。

### 玩家操控

```powershell
# 瞬移到指定坐标
.\editor-cli.exe exec "EditorAPI.game_execute('local roles = GameAPI.get_all_roles(); if not roles or #roles == 0 then return end; local u = roles[1].get_ctrl_unit(); u.set_position(math.Vector3(10, 2, -5))')"

# 物理移动到指定坐标（持续 5 秒，会触发沿途碰撞）
.\editor-cli.exe exec "EditorAPI.game_execute('local roles = GameAPI.get_all_roles(); if not roles or #roles == 0 then return end; local u = roles[1].get_ctrl_unit(); u.cmd_move_to_pos(math.Vector3(10, 0, 20), 5.0)')"

# 让玩家跳跃
.\editor-cli.exe exec "EditorAPI.game_execute('local roles = GameAPI.get_all_roles(); if not roles or #roles == 0 then return end; local u = roles[1].get_ctrl_unit(); u.jump()')"

# 让玩家冲刺
.\editor-cli.exe exec "EditorAPI.game_execute('local roles = GameAPI.get_all_roles(); if not roles or #roles == 0 then return end; local u = roles[1].get_ctrl_unit(); u.cmd_rush()')"
```

### 广播自定义事件

```powershell
# 广播无数据事件（模拟触发游戏逻辑）
.\editor-cli.exe exec "EditorAPI.game_execute('LuaAPI.global_send_custom_event([[Test_Event]], nil)')"
```

---

## 引号规则

在 PowerShell 中使用 `exec` 时，注意引号嵌套：

```powershell
# 直接 exec：外层双引号，Lua 字符串用单引号
.\editor-cli.exe exec "EditorAPI.set_unit_attr(123, 'name', 'NewName')"

# game_execute：外层双引号，中层单引号，Lua 内字符串用 [[]] 长字符串
.\editor-cli.exe exec "EditorAPI.game_execute('print([[hello world]])')"
```

> **关键规则：** `game_execute('...')` 内部需要字符串字面量时，使用 Lua 的 `[[]]` 长字符串语法，不要用单引号或双引号。PowerShell 会错误解析 `''` 和 `\"`，导致参数截断。

---

## 如何读取 exec 的执行结果

新版 `exec` **直接在终端输出执行结果**：

* Lua 代码里的 `print(...)` 输出会打印到终端
* 用 `return` 返回的值会直接作为结果输出

```powershell
# return 返回值直接输出
.\editor-cli.exe exec "local ids = EditorAPI.get_all_unit_ids(); return #ids"
# 输出：42

# 需要结构化数据时用 --json
.\editor-cli.exe exec "return 1+1" --json
# 输出：{ "success": true, "result": "2" }
```

如果需要拿到较大量的输出，也可以让 Lua 侧写日志，再用 `log tail` / `log grep` 读取：

```powershell
.\editor-cli.exe exec "EditorAPI.log('total units: 42')"
.\editor-cli.exe log grep "total units"
```

---

## 常见问题

### Q: 提示连接失败 / 找不到编辑器实例

编辑器未启动，或未开启 editor-cli 功能。请确认：

* 编辑器已启动
* editor-cli 功能已开启
* 如果开了多个编辑器，用 `editor-instances list` 确认实例状态，用 `--editor-instance` 指定

### Q: exec 命令报错

* 检查 Lua 语法是否正确（语法错误和运行时错误都会带完整堆栈返回）
* 确认调用的 API 名称是否与编辑器文档一致
* `--context server` / `--context client` 仅在试玩进行中可用

### Q: 退出码的含义

* `0`：成功（`code diff` 发现冲突也是 0，冲突是数据不是失败）
* `1`：一般错误（连接失败、参数错误、Lua 执行失败等）
* 其他非零：特定失败类型（如 `code validate` 发现问题、`code init` 时编辑器不可达），错误信息中会给出下一步建议

### Q: docs search 提示 token 过期

需要在蛋仔编辑器中重新登录后重试。另外原点编辑器（fs）暂无远程知识库。

### Q: 如何获取 JSON 格式输出

在任何命令后加 `--json`：

```powershell
editor-cli.exe status --json
editor-cli.exe log tail --lines 10 --json
```

JSON 格式便于在自动化脚本或 CI 流程中解析。

---

文档更新：2026-07-30，基于最新版 editor-cli（新增 editor-instances / map / play / code / log / docs 命令组）
