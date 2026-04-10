# OpenAllIn 使用手册

> 本手册将指导你如何在老项目和新项目中使用 OpenAllIn

---

## 目录

1. [老项目如何使用 OpenAllIn](#一老项目如何使用-openallin)
2. [新项目如何使用 OpenAllIn](#二新项目如何使用-openallin)
3. [常用工作流](#三常用工作流)
4. [常见问题](#四常见问题)
5. [下一步](#五下一步)
6. [最佳实践](#六最佳实践)
7. [获取帮助](#七获取帮助)

---

## 一、老项目如何使用 OpenAllIn

如果你已经有一个正在开发的项目，想要引入 OpenAllIn，请按以下步骤操作：

### 步骤 1：克隆 OpenAllIn 到临时目录

```bash
# 克隆到临时位置（不要克隆到你的项目目录里）
git clone https://github.com/vanrayliu/openallin.git /tmp/openallin
```

### 步骤 2：进入你的项目目录

```bash
cd /path/to/your-project
```

### 步骤 3：运行安装脚本

```bash
# 自动检测当前 CLI 环境并安装
bash /tmp/openallin/scripts/install.sh
```

**或者明确指定 CLI 工具：**

```bash
# 安装到 OpenCode
bash /tmp/openallin/scripts/install.sh opencode

# 安装到 Claude Code
bash /tmp/openallin/scripts/install.sh claude

# 同时安装到多个工具
bash /tmp/openallin/scripts/install.sh opencode claude
```

### 步骤 4：确认安装成功

```bash
# 检查安装的文件
ls -la

# 应该看到：
# AGENTS.md       - OpenAllIn 入口文件（OpenCode）
# CLAUDE.md       - OpenAllIn 入口文件（Claude Code）
# project.md      - 项目上下文（已存在则保留）
# .opencode/      - OpenCode 配置（如果安装了 opencode）
# .claude/        - Claude Code 配置（如果安装了 claude）
# rules/          - 编码规范
# scripts/        - 工具脚本（init/install/validate/archive/uninstall）
# specs/          - 规格目录
# workspace/      - 工作区
# templates/      - 模板库
# changes/        - 变更提案目录
# config/         - 配置文件
```

**检查 CLI 配置文件：**

```bash
# OpenCode
ls .opencode/skills/

# Claude Code
ls .claude/skills/
```

**检查 skills 文件格式：**

```bash
# 每个 skill 应该是 <name>/SKILL.md 格式
ls .opencode/skills/oa-propose/
# 应该看到：SKILL.md

# 检查任意 skill 内容
head -20 .opencode/skills/oa-propose/SKILL.md
```

**验证 17 个命令全部安装：**

```bash
# 应该有 17 个 oa-* 命令
ls -d .opencode/skills/oa-*/ | wc -l
# 输出应该是 17
```

### 步骤 5：编辑项目上下文

```bash
# 编辑 project.md，填入你的项目信息
vim project.md
```

**project.md 示例：**

```markdown
# 项目上下文

## 技术栈
- 语言: TypeScript
- 框架: React + Node.js
- 包管理: pnpm
- 测试: Jest
- 构建: Vite

## 架构模式
- 前后端分离
- RESTful API
- PostgreSQL 数据库

## 编码规范
- 使用 ESLint + Prettier
- 提交信息遵循 Conventional Commits

## 业务领域
- 电商平台
- 用户管理、商品管理、订单管理
```

### 步骤 6：重启 CLI 工具

```bash
# 重启 OpenCode
opencode

# 或重启 Claude Code
claude
```

### 步骤 7：测试命令

```
/oa-brainstorming
```

或

```
/oa-propose test-feature
```

### 步骤 8：清理临时文件（可选）

```bash
# 安装完成后可以删除临时克隆目录
rm -rf /tmp/openallin
```

---

## 二、新项目如何使用 OpenAllIn

如果你要从零开始一个新项目，请按以下步骤操作：

### 步骤 1：创建项目目录

```bash
mkdir my-new-project
cd my-new-project
```

### 步骤 2：初始化 Git（推荐）

```bash
git init
git remote add origin https://github.com/your-username/my-new-project.git
```

### 步骤 3：克隆 OpenAllIn

```bash
git clone https://github.com/vanrayliu/openallin.git /tmp/openallin
```

### 步骤 4：运行安装脚本

```bash
# 自动检测并安装
bash /tmp/openallin/scripts/install.sh
```

### 步骤 5：初始化项目

```bash
# 使用 init.sh 初始化完整的项目结构
bash scripts/init.sh
```

这会创建：
- `workspace/STATE.md` - 项目状态
- `workspace/ROADMAP.md` - 项目路线图
- `config/settings.json` - 配置文件
- 其他必要的目录结构

### 步骤 6：编辑项目上下文

```bash
vim project.md
```

**新项目的 project.md 示例：**

```markdown
# 项目上下文

## 技术栈
- 语言: 
- 框架: 
- 包管理: 
- 测试: 
- 构建: 

## 架构模式
- 架构风格: 
- 分层约定: 
- 数据流: 

## 编码规范
- 命名约定: 
- 文件格式: 
- 注释风格: 
- 提交信息: 

## 业务领域
- 领域术语: 
- 核心实体: 
- 业务流程: 

## 项目约束
- 已有服务: 
- 接口规范: 
- 安全要求: 
- 性能目标: 
```

### 步骤 7：添加到 Git

```bash
git add .
git commit -m "chore: initialize project with OpenAllIn"
git push -u origin main
```

### 步骤 8：启动 CLI 工具并开始开发

```bash
opencode
# 或
claude
```

---

## 三、常用工作流

### 工作流 1：快速变更（适合小功能）

```
你: /oa-propose add-user-login

AI: 创建变更提案：
    - changes/add-user-login/proposal.md
    - changes/add-user-login/design.md
    - changes/add-user-login/specs/
    - changes/add-user-login/tasks.md

你: /oa-validate add-user-login

AI: 验证规格格式...
    ✅ RFC 2119 关键词
    ✅ Scenario 格式
    ✅ Gherkin 关键词
    ✅ Requirement 格式

你: /oa-apply add-user-login

AI: 执行任务清单中的任务...

你: /oa-archive add-user-login

AI: 归档变更并合并到 specs/
```

### 工作流 2：复杂需求（适合大功能）

```
你：/oa-brainstorming

AI: 第 1 轮：你想解决什么问题？
你：用户登录功能

AI: 第 2 轮：边界条件是什么？
你：用户名不存在、密码错误、空输入

AI: 第 3 轮：技术限制是什么？
你：需要支持 JWT，30 分钟过期

...（继续迭代，最多 5 轮）

你：讨论充分，结束头脑风暴

AI: 
**头脑风暴总结**
- 核心需求：用户登录、记住登录状态、JWT token 管理
- 技术方案：JWT + Redis 会话存储
- 已生成 workspace/brainstorm-YYYY-MM-DD.md

你：/oa-propose user-login

AI: 创建变更提案：
    - changes/user-login/proposal.md
    - changes/user-login/design.md
    - changes/user-login/specs/
    - changes/user-login/tasks.md

你：/oa-validate user-login

AI: 验证规格格式...
    ✅ RFC 2119 关键词
    ✅ Scenario 格式
    ✅ Gherkin 关键词
    ✅ Requirement 格式

你：/oa-plan user-login

AI: 已拆分为 5 个原子任务

你：/oa-execute user-login

AI: 正在执行第 1 波任务...

你：/oa-verify user-login

AI: 验证通过 ✅

你：/oa-ship user-login

AI: 已创建 PR
```

### 工作流 3：TDD 开发

```
你：/oa-tdd 用户登录功能

AI: 
**TDD 循环 #1**

**🔴 Red**
- 测试文件：tests/auth/login.test.js
- 测试内容：正确用户名密码应该登录成功
- 运行结果：❌ 失败

**🟢 Green**
- 实现文件：src/auth/login.js
- 运行结果：✅ 通过

**🔵 Refactor**
- 重构内容：提取验证逻辑
- 运行结果：✅ 通过

**下一步**
- 继续添加测试用例？
```

### 工作流 4：Bug 修复

```
你: /oa-debugging 登录失败后页面卡住

AI: 第 1 轮：问题是什么？
你: 输入错误密码后，页面一直转圈

AI: 第 2 轮：如何重现？
你: 输入错误密码，点击登录

AI: 第 3 轮：可能原因是什么？
你: 错误处理没有正确返回

...（继续调试）

AI: 已定位问题：src/auth/login.js:42
```

---

## 四、常见问题

### Q1: 安装后看不到 `/oa-*` 命令？

**原因：** 技能文件格式不对或 CLI 工具未重启。

**解决：**
```bash
# 检查技能目录结构
ls .opencode/skills/
# 应该看到 oa-apply/, oa-propose/ 等目录

# 检查 SKILL.md 是否存在
ls .opencode/skills/oa-propose/SKILL.md

# 重启 CLI 工具
opencode
# 或
claude
```

### Q2: 如何卸载 OpenAllIn？

```bash
# 进入项目目录
cd /path/to/your-project

# 运行卸载脚本（会提示确认）
bash scripts/uninstall.sh

# 或强制卸载（不提示确认）
bash scripts/uninstall.sh --force
```

**卸载会删除：**
- `AGENTS.md`、`CLAUDE.md`、`project.md`
- `.claude/`、`.opencode/` 目录
- `rules/`、`scripts/`、`specs/`、`templates/`、`workspace/`、`config/`、`changes/`、`tasks/` 目录

**不会删除：**
- 你的业务代码
- `node_modules/`
- 任何非 OpenAllIn 生成的文件

**清理全局配置：**
卸载脚本也会清理 `~/.claude/settings.json` 中的 OpenAllIn hooks。

**注意事项：**
1. 卸载前请确保没有正在进行的变更（`changes/` 目录）
2. 如需保留规格，请先备份 `specs/` 目录
3. 如需保留项目记忆，请备份 `workspace/` 和 `config/memory.json`
4. 卸载后如需重新安装，运行 `bash scripts/install.sh`

### Q3: 如何更新 OpenAllIn？

```bash
# 重新克隆最新版本
rm -rf /tmp/openallin
git clone https://github.com/vanrayliu/openallin.git /tmp/openallin

# 重新安装
bash /tmp/openallin/scripts/install.sh
```

### Q4: 支持哪些 CLI 工具？

OpenAllIn 支持自动检测以下 CLI 工具：

| CLI 工具 | 环境变量 | 目录检测 |
|----------|----------|----------|
| OpenCode | `$OPENCODE` | `.opencode/` |
| Claude Code | `$CLAUDE_CODE` | `.claude/` |
| Cursor | `$CURSOR` | `.cursor/` |
| Codex | `$CODEX` | `.codex/` |
| OpenClaw | `$OPENCLAW` | `.openclaw/` |
| Gemini CLI | `$GEMINI_CLI` | `.gemini/` |
| Windsurf | `$WINDSURF` | `.windsurf/` |
| Kilo Code | `$KILO` | `.kilo/` |
| Augment | `$AUGMENT` | `.augment/` |
| Zed | `$ZED` | `.zed/` |

### Q5: 如何查看所有可用命令？

```
/skills
```

或直接问：
```
有哪些可用的命令？
```

### Q6: project.md 和 AGENTS.md 有什么区别？

- **AGENTS.md**: OpenAllIn 的入口文件，定义框架结构和工作流程
- **project.md**: 项目特定的上下文，包含技术栈、业务领域、编码规范等

**AGENTS.md 不要修改**，**project.md 需要你填入项目信息**。

### Q7: changes/ 目录是什么？

`changes/` 目录存放正在进行的变更提案：

```
changes/
├── add-user-login/           # 变更名称
│   ├── proposal.md           # WHY: 为什么要做
│   ├── design.md             # HOW: 技术方案
│   ├── specs/                # WHAT: 增量规格
│   │   └── auth/spec.md
│   └── tasks.md              # STEPS: 任务清单
└── archive/                  # 已归档的变更
    └── 2026-04-09-add-user-login/
```

### Q8: specs/ 目录是什么？

`specs/` 目录存放系统的完整规格（Source of Truth）：

```
specs/
├── auth/
│   └── spec.md               # 认证模块规格
├── api/
│   └── spec.md               # API 模块规格
└── ui/
    └── spec.md               # UI 模块规格
```

变更归档后，增量规格会合并到这里。

### Q9: 如何查看某个命令的详细用法？

```bash
# 查看技能文件内容
cat skills/oa-propose.md

# 或在 CLI 中直接问
/oa-propose --help
# 或
如何使用 oa-propose 命令？
```

### Q10: 命令参数如何传递？

部分命令需要参数，部分不需要：

**需要参数的命令：**
```bash
/oa-propose <change-name>      # 如：/oa-propose add-user-login
/oa-apply <change-name>        # 如：/oa-apply add-user-login
/oa-validate <change-name>     # 如：/oa-validate add-user-login
/oa-archive <change-name>      # 如：/oa-archive add-user-login
/oa-tdd <feature-description>  # 如：/oa-tdd 用户登录功能
```

**不需要参数的命令：**
```bash
/oa-brainstorming
/oa-debugging
/oa-writing-plans
/oa-worktree
/oa-team-plan
/oa-team-exec
/oa-team-verify
```

**可选参数的命令：**
```bash
/oa-discuss [topic]            # 可选主题，如：/oa-discuss 登录功能
/oa-plan [phase]               # 可选阶段，如：/oa-plan user-login
/oa-execute [phase]            # 可选阶段
/oa-verify [phase]             # 可选阶段
/oa-ship [phase]               # 可选阶段
```

### Q11: 如何在多项目中使用 OpenAllIn？

每个项目独立安装 OpenAllIn：

```bash
# 项目 A
cd /path/to/project-a
bash /tmp/openallin/scripts/install.sh claude

# 项目 B
cd /path/to/project-b
bash /tmp/openallin/scripts/install.sh opencode
```

**注意事项：**
1. 每个项目的 `project.md` 独立维护
2. 每个项目的 `specs/`、`changes/`、`workspace/` 独立
3. 不同项目可以使用不同的 CLI 工具
4. 建议将 OpenAllIn 作为 submodule 引入项目

```bash
# 使用 git submodule
git submodule add https://github.com/vanrayliu/openallin.git openallin
bash openallin/scripts/install.sh claude
```

### Q12: 如何备份和恢复 OpenAllIn 配置？

**备份：**
```bash
# 备份项目配置
tar -czf openallin-backup.tar.gz \
    project.md \
    specs/ \
    changes/ \
    workspace/ \
    config/ \
    .claude/ \
    .opencode/
```

**恢复：**
```bash
# 重新安装 OpenAllIn
bash scripts/install.sh

# 恢复配置
tar -xzf openallin-backup.tar.gz
```

### Q11: 如何在多项目中使用 OpenAllIn？

每个项目独立安装 OpenAllIn：

```bash
# 项目 A
cd /path/to/project-a
bash /tmp/openallin/scripts/install.sh claude

# 项目 B
cd /path/to/project-b
bash /tmp/openallin/scripts/install.sh opencode
```

**注意事项：**
1. 每个项目的 `project.md` 独立维护
2. 每个项目的 `specs/`、`changes/`、`workspace/` 独立
3. 不同项目可以使用不同的 CLI 工具
4. 建议将 OpenAllIn 作为 submodule 引入项目

```bash
# 使用 git submodule
git submodule add https://github.com/vanrayliu/openallin.git openallin
bash openallin/scripts/install.sh claude
```

### Q12: 如何备份和恢复 OpenAllIn 配置？

**备份：**
```bash
# 备份项目配置
tar -czf openallin-backup.tar.gz \
    project.md \
    specs/ \
    changes/ \
    workspace/ \
    config/ \
    .claude/ \
    .opencode/
```

**恢复：**
```bash
# 重新安装 OpenAllIn
bash scripts/install.sh

# 恢复配置
tar -xzf openallin-backup.tar.gz
```

### Q13: 如何处理命令执行失败？

**检查步骤：**
```bash
# 1. 检查错误信息
# AI 通常会说明失败原因

# 2. 检查相关文件是否存在
ls changes/<change-name>/

# 3. 检查规格格式
/oa-validate <change-name>

# 4. 手动重试
# 如果自动执行失败，可以手动执行任务

# 5. 使用调试模式
/oa-debugging
```

**常见错误：**
| 错误 | 原因 | 解决 |
|------|------|------|
| 找不到变更 | changes/<name> 目录不存在 | 先运行 /oa-propose |
| 规格验证失败 | 格式不对 | /oa-validate 检查 |
| 任务执行失败 | 依赖问题 | 检查 tasks.md 顺序 |
| Git 冲突 | 有未提交变更 | 先提交或 stash |
| 技能未加载 | CLI 未重启 | 重启 CLI 工具 |

---

## 五、下一步

1. **编辑 project.md** - 填入你的项目信息
2. **尝试第一个命令** - `/oa-brainstorming` 或 `/oa-propose`
3. **阅读 QUICKREF.md** - 快速参考卡（17 个命令速查）
4. **阅读 WORKFLOW.md** - 详细工作流程和最佳实践
5. **查看 examples/** - 示例变更提案（学习参考）

---

## 六、最佳实践

### 1. 规格先行

在写代码之前，先用 `/oa-propose` 明确：
- **WHY**: 为什么要做这个变更？
- **WHAT**: 具体要做什么？
- **HOW**: 技术方案是什么？

### 2. 小步快跑

- 每个变更尽量小（1-3 天能完成）
- 频繁归档（`/oa-archive`）
- 及时合并规格到 `specs/`

### 3. 验证驱动

- 执行前验证：`/oa-validate`
- 执行后验证：`/oa-verify`
- 发布前验证：`/oa-ship` 前再跑一次验证

### 4. 上下文管理

- 长任务使用 `/oa-discuss` → `/oa-plan` → `/oa-execute`
- 复杂功能使用头脑风暴（`/oa-brainstorming`）
- Bug 修复使用调试流程（`/oa-debugging`）

### 5. 团队协作

- 使用 `/oa-team-plan` 进行团队规划
- 使用 Git Worktree 隔离开发（`/oa-worktree`）
- 使用 `/oa-team-verify` 进行交叉验证

### 6. 知识沉淀

- 所有规格写入 `specs/`
- 所有状态写入 `workspace/`
- 所有学习写入 `config/memory.json`

---

## 七、获取帮助

- **GitHub**: https://github.com/vanrayliu/openallin
- 问题反馈: https://github.com/vanrayliu/openallin/issues
- **文档**: 
  - README.md - 项目介绍和安装指南
  - QUICKREF.md - 快速参考卡（17 个命令速查）
  - WORKFLOW.md - 详细工作流程和最佳实践
- **示例**: 
  - examples/ - 示例变更提案（学习参考）
  - templates/ - 模板库（proposal.md, design.md, spec.md 等）
