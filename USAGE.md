# OpenAllIn 使用手册

> 本手册将指导你如何在老项目和新项目中使用 OpenAllIn

---

## 目录

1. [老项目如何使用 OpenAllIn](#一老项目如何使用-openallin)
2. [新项目如何使用 OpenAllIn](#二新项目如何使用-openallin)
3. [通过 AI 助手安装 OpenAllIn（推荐）](#三通过-ai-助手安装-openallin推荐)
4. [通过自然语言使用 OpenAllIn](#四通过自然语言使用-openallin)
5. [常用工作流](#五常用工作流)
6. [常见问题](#六常见问题)
7. [下一步](#七下一步)
8. [最佳实践](#八最佳实践)
9. [获取帮助](#九获取帮助)

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
# agents/         - Agent 角色定义（planner, implementer, reviewer 等）
# rules/          - 编码规范和安全规则
# scripts/        - 工具脚本（init/install/validate/archive/uninstall）
# specs/          - 规格目录
# workspace/      - 工作区
# templates/      - 模板库
# changes/        - 变更提案目录
# config/         - 配置文件
# tasks/          - 任务驱动工作流目录
# hooks/          - 事件钩子（session start/end/tool calls）
# examples/       - 示例变更提案（学习参考）
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

**验证 22 个命令全部安装：**

```bash
# 应该有 22 个 oa-* 命令
ls -d .opencode/skills/oa-*/ | wc -l
# 输出应该是 22
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

## 三、通过 AI 助手安装 OpenAllIn（推荐）

> 如果你是 Claude Code、OpenCode 等工具的用户，可以通过自然语言直接让 AI 帮你安装，无需手动执行命令。

### 适用场景

- ✅ 你正在使用 Claude Code、OpenCode 等 AI 编程工具
- ✅ 你希望用对话方式完成安装
- ✅ 你想让 AI 自动处理配置细节

### 方式 1：提供 Git 地址安装

**步骤 1：打开你的项目**

```bash
cd /path/to/your-project
opencode  # 或 claude
```

**步骤 2：对 AI 说（必须提供 Git 地址）**

```
请帮我安装 OpenAllIn：https://github.com/vanrayliu/openallin
```

或完整地址：

```
请帮我安装 OpenAllIn：https://github.com/vanrayliu/openallin.git
```

**AI 会做什么：**

```
AI: 好的，我来帮你安装 OpenAllIn。

1. 首先克隆 OpenAllIn 仓库到临时目录...
   ✅ git clone https://github.com/vanrayliu/openallin.git /tmp/openallin

2. 检测到你在使用 OpenCode，开始安装...
   ✅ 创建 .opencode/ 目录
   ✅ 安装 22 个命令（oa-propose, oa-brainstorming, oa-tdd, oa-security, oa-review 等）
   ✅ 复制 agents/（角色定义）
   ✅ 复制 rules/（编码规范）
   ✅ 创建 specs/, changes/, workspace/ 等目录

3. 安装完成！请重启 OpenCode 以加载新命令。

接下来你可以：
- 编辑 project.md 填入项目信息
- 使用 /oa-brainstorming 开始头脑风暴
- 使用 /oa-propose <name> 创建变更提案
```

---

### 方式 2：克隆后安装

**步骤 1：先克隆 OpenAllIn 仓库**

```bash
git clone https://github.com/vanrayliu/openallin.git
cd openallin
opencode  # 或 claude
```

**步骤 2：对 AI 说**

```
帮我安装到 /path/to/my-project
```

**AI 会做什么：**

```
AI: 好的，我来帮你安装到指定目录。

1. 检测到当前在 OpenAllIn 仓库目录
2. 运行安装脚本...
   ✅ bash scripts/install.sh --target /path/to/my-project
3. 安装完成！
```

**步骤 3：验证安装**

你：
```
检查一下 OpenAllIn 是否安装成功
```

AI：
```
AI: 检查安装状态...

✅ AGENTS.md 存在
✅ project.md 存在
✅ .opencode/skills/ 存在
✅ 22 个命令已安装：
   - /oa-propose
   - /oa-apply
   - /oa-validate
   - /oa-archive
   - /oa-discuss
   - /oa-plan
   - /oa-execute
   - /oa-verify
   - /oa-review
   - /oa-ship
   - /oa-land
   - /oa-security
   - /oa-qa-browser
   - /oa-benchmark
   - /oa-brainstorming
   - /oa-debugging
   - /oa-tdd
   - /oa-writing-plans
   - /oa-worktree
   - /oa-team-plan
   - /oa-team-exec
   - /oa-team-verify

✅ OpenAllIn 安装成功！
```

---

### 方式 4：指定安装配置

**指定 CLI 工具：**

```
我是用 Claude Code 的，帮我安装 OpenAllIn：https://github.com/vanrayliu/openallin
```

**同时安装到多个工具：**

```
帮我同时安装到 OpenCode 和 Claude Code：https://github.com/vanrayliu/openallin
```

**只安装特定组件：**

```
只安装 OpenAllIn 的 brainstorming 和 tdd 命令：https://github.com/vanrayliu/openallin
```

---

### 为什么需要提供 Git 地址？

AI 助手无法预知你要安装的项目来源，因此需要你提供：

| 场景 | 你需要提供 |
|------|----------|
| 从 GitHub 安装 | `https://github.com/vanrayliu/openallin` |
| 从 Gitee 安装 | `https://gitee.com/yourname/openallin` |
| 从私有仓库安装 | `git@github.com:yourname/openallin.git` |
| 本地已克隆 | 先 `cd openallin`，再说"帮我安装到 xxx" |

---

### 安装后的配置

**编辑项目上下文：**

```
帮我编辑 project.md，这是一个电商平台项目，使用 React + Node.js + PostgreSQL
```

AI 会自动帮你填充：
- 技术栈信息
- 架构模式
- 业务领域

**配置团队规范：**

```
我们团队使用 ESLint + Prettier，提交信息遵循 Conventional Commits
```

AI 会更新 `rules/coding-standards.md` 和 `rules/commit-rules.md`。

---

### 常用自然语言安装命令速查

| 你说的 | AI 做的事 |
|--------|----------|
| "安装 OpenAllIn：https://github.com/vanrayliu/openallin" | 执行完整安装流程 |
| "检查安装状态" | 验证所有组件是否正确安装 |
| "卸载 OpenAllIn" | 运行卸载脚本 |
| "更新 OpenAllIn" | 重新安装最新版本 |
| "编辑 project.md" | 引导填写项目信息 |
| "配置团队规范" | 更新 rules/ 目录 |

---

### 为什么推荐自然语言安装？

| 对比项 | 命令行安装 | 自然语言安装 |
|--------|-----------|-------------|
| **学习成本** | 需要记住命令 | 直接说需求 |
| **错误处理** | 需要自己排查 | AI 自动解决 |
| **配置引导** | 手动编辑文件 | AI 引导填写 |
| **适合人群** | 熟悉命令行的开发者 | 所有用户 |
| **灵活性** | 完全控制 | AI 辅助决策 |

**推荐：** 如果你正在使用 AI 编程工具，优先选择自然语言安装。

---

## 四、通过自然语言使用 OpenAllIn

> 除了使用 `/oa-*` 命令，你还可以直接用自然语言描述需求，让 AI 助手自动选择并执行合适的命令。

### 为什么用自然语言？

| 命令方式 | 自然语言方式 |
|---------|------------|
| 需要记住命令名称 | 直接说需求 |
| 需要了解命令参数 | AI 自动推断 |
| 需要手动执行多个命令 | AI 自动串联执行 |
| 适合：熟练用户 | 适合：所有用户 |

---

### 基础用法示例

#### 1. 创建变更

**命令方式：**
```
/oa-propose add-user-login
/oa-validate add-user-login
```

**自然语言方式：**
```
我想添加一个用户登录功能，帮我创建变更提案
```

AI 会自动：
1. 识别需求 → 调用 `/oa-propose user-login`
2. 创建提案文件
3. 验证规格格式

---

#### 2. 头脑风暴

**命令方式：**
```
/oa-brainstorming
```
然后手动回答 5 轮问题。

**自然语言方式：**
```
我想做一个用户登录功能，不确定具体怎么做，帮我梳理一下
```

AI 会自动：
1. 启动头脑风暴模式
2. 引导你完成需求分析
3. 生成总结文档

---

#### 3. 规划任务

**命令方式：**
```
/oa-plan user-login
```

**自然语言方式：**
```
用户登录功能需要拆分成哪些任务？帮我规划一下
```

AI 会自动：
1. 分析需求
2. 拆分原子任务
3. 规划执行波次

---

#### 4. 执行任务

**命令方式：**
```
/oa-execute user-login
/oa-verify user-login
```

**自然语言方式：**
```
开始执行用户登录功能的任务，完成后验证一下
```

AI 会自动：
1. 执行所有任务
2. 运行验证
3. 报告结果

---

### 高级用法示例

#### 完整工作流（一句话触发）

```
帮我实现用户登录功能，从需求分析到代码实现全部完成
```

AI 会自动执行：
1. 头脑风暴 → 理清需求
2. 创建提案 → 生成规格
3. 规划任务 → 拆分工作
4. 执行任务 → 写代码
5. 验证质量 → 确保正确
6. 创建 PR → 提交代码

---

#### Bug 修复

**命令方式：**
```
/oa-debugging 登录失败后页面卡住
```

**自然语言方式：**
```
登录失败后页面一直转圈，帮我定位并修复这个问题
```

AI 会自动：
1. 启动调试模式
2. 多轮问答定位问题
3. 修复代码
4. 验证修复

---

#### TDD 开发

**命令方式：**
```
/oa-tdd 用户登录功能
```

**自然语言方式：**
```
用 TDD 的方式开发用户登录功能
```

AI 会自动：
1. 先写测试（Red）
2. 写实现代码（Green）
3. 重构优化（Refactor）
4. 循环直到完成

---

### 常用自然语言短语速查

#### 需求相关

| 你说的 | AI 做的事 |
|--------|----------|
| "我想做 XXX 功能" | 启动头脑风暴 |
| "帮我分析一下 XXX 需求" | 调用 `/oa-brainstorming` |
| "创建 XXX 功能的变更提案" | 调用 `/oa-propose` |
| "验证一下这个变更的规格" | 调用 `/oa-validate` |

#### 任务相关

| 你说的 | AI 做的事 |
|--------|----------|
| "帮我规划 XXX 的任务" | 调用 `/oa-plan` |
| "开始执行任务" | 调用 `/oa-execute` |
| "检查一下完成情况" | 调用 `/oa-verify` |
| "提交这个变更" | 调用 `/oa-ship` |

#### 调试相关

| 你说的 | AI 做的事 |
|--------|----------|
| "XXX 有 bug，帮我修复" | 调用 `/oa-debugging` |
| "页面报错了：XXX" | 分析错误 → 修复 |
| "测试失败了：XXX" | 定位问题 → 修复 |

#### 安全相关

| 你说的 | AI 做的事 |
|--------|----------|
| "检查安全性" | 调用 `/oa-security` |
| "安全审计" | 调用 `/oa-security` |
| "这个代码有安全漏洞吗？" | 调用 `/oa-security` + 分析 |
| "review 一下安全性" | OWASP + STRIDE 检查 |

#### 部署相关

| 你说的 | AI 做的事 |
|--------|----------|
| "部署到生产" | 调用 `/oa-land` |
| "上线" | 调用 `/oa-land` |
| "检查部署状态" | 调用 `/oa-land` + 烟雾测试 |
| "部署失败，回滚" | 生成回滚计划 |

#### 测试相关

| 你说的 | AI 做的事 |
|--------|----------|
| "浏览器测试" | 调用 `/oa-qa-browser` |
| "视觉回归测试" | 调用 `/oa-qa-browser` + 视觉检查 |
| "无障碍测试" | 调用 `/oa-qa-browser` + WCAG 检查 |
| "性能测试" | 调用 `/oa-benchmark` |
| "API 性能基准" | 调用 `/oa-benchmark` + API 基准 |

#### 审查相关

| 你说的 | AI 做的事 |
|--------|----------|
| "review 代码" | 调用 `/oa-review` |
| "代码审查" | 调用 `/oa-review` |
| "设计审查" | 调用 `/oa-review` + 设计检查 |
| "架构审查" | 调用 `/oa-review` + 架构检查 |
| "审查 UI/UX" | 调用 `/oa-review` + UI/UX 检查 |

#### 查询相关

| 你说的 | AI 做的事 |
|--------|----------|
| "查看当前项目状态" | 读取 `workspace/STATE.md` |
| "有哪些未完成的任务？" | 检查 `changes/*/tasks.md` |
| "XXX 功能的规格是什么？" | 读取 `specs/*/spec.md` |
| "项目的测试覆盖率如何？" | 运行测试并分析 |

---

### 自然语言最佳实践

#### ✅ 好的表达方式

```
✅ "我想添加用户登录功能，支持用户名密码和手机验证码两种方式"
   → 需求清晰，AI 能准确理解

✅ "帮我实现购物车功能，包括添加商品、修改数量、删除商品"
   → 功能点明确，AI 能拆分任务

✅ "这个 API 接口返回 500 错误，日志显示数据库连接超时"
   → 问题具体，AI 能快速定位
```

#### ❌ 不好的表达方式

```
❌ "帮我写个功能"
   → 太模糊，AI 不知道你要什么

❌ "代码不工作"
   → 没说哪个功能、什么错误

❌ "优化一下"
   → 没说优化什么、优化目标是什么
```

---

### 自然语言 vs 命令：何时使用哪种？

| 场景 | 推荐方式 | 原因 |
|------|---------|------|
| 简单、明确的任务 | 命令 | 快速、精确 |
| 复杂、多步骤任务 | 自然语言 | AI 自动串联 |
| 不确定如何开始 | 自然语言 | AI 引导思考 |
| 调试、排查问题 | 自然语言 | 交互式问答 |
| 批量操作 | 命令 | 可脚本化 |
| 学习、探索 | 自然语言 | AI 解释说明 |

**建议：** 新用户从自然语言开始，熟练后两种方式混合使用。

---

## 五、常用工作流

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

## 六、常见问题

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
- `agents/`、`hooks/`、`rules/`、`scripts/`、`specs/`、`templates/`、`workspace/`、`config/`、`changes/`、`tasks/`、`.planning/` 目录

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
/oa-security
/oa-land
/oa-qa-browser
/oa-benchmark
```

**可选参数的命令：**
```bash
/oa-discuss [topic]            # 可选主题，如：/oa-discuss 登录功能
/oa-plan [phase]               # 可选阶段，如：/oa-plan user-login
/oa-execute [phase]            # 可选阶段
/oa-verify [phase]             # 可选阶段
/oa-review [phase]             # 可选阶段，如：/oa-review user-login
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

## 七、下一步

1. **编辑 project.md** - 填入你的项目信息
2. **尝试第一个命令** - `/oa-brainstorming` 或 `/oa-propose`
3. **阅读 QUICKREF.md** - 快速参考卡（22 个命令速查）
4. **阅读 WORKFLOW.md** - 详细工作流程和最佳实践
5. **查看 examples/** - 示例变更提案（学习参考）

---

## 八、最佳实践

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

## 九、获取帮助

- **GitHub**: https://github.com/vanrayliu/openallin
- 问题反馈: https://github.com/vanrayliu/openallin/issues
- **文档**: 
  - README.md - 项目介绍和安装指南
  - QUICKREF.md - 快速参考卡（22 个命令速查）
  - WORKFLOW.md - 详细工作流程和最佳实践
- **示例**: 
  - examples/ - 示例变更提案（学习参考）
  - templates/ - 模板库（proposal.md, design.md, spec.md 等）
