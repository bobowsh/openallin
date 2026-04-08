# OpenAllIn — 全栈 AI 编程 Harness

> 一个面向 AI 编码工具的工程化框架，将六大成熟框架的核心优势融为一体，为团队提供结构化的开发流程和规范。

## 为什么需要 OpenAllIn？

AI 编程工具越来越强大，但实际使用中总会遇到 6 大不稳定性：

| 层级 | 名称 | 解决的问题 |
|------|------|-----------|
| Layer 6 | Workspace | AI 没有长期记忆 → 文件化状态与记忆 |
| Layer 5 | Orchestration | 团队协作混乱 → 多 Agent 协调 |
| Layer 4 | Execution | 长对话上下文崩溃 → 分阶段工作流 |
| Layer 3 | Enhancement | 安全/验证缺失 → Hook 自动化 |
| Layer 2 | Skills | AI 写代码像实习生 → 工程方法论技能库 |
| Layer 1 | Spec | AI 不知道你想要什么 → 规格驱动开发 |

### 技术特色

- **纯文本/Shell/JSON** — 无外部依赖，可离线运行
- **分层设计** — 每层独立可选，支持渐进式采用
- **语言无关** — 适用于任何语言/框架的项目
- **多工具支持** — OpenCode、Claude Code、Cursor、Codex 等

### 核心文件关系

```
AGENTS.md           ← AI 工具的统一入口
    ↓
skills/*.md         ← 工程方法论（brainstorming, TDD, debugging 等）
rules/*.md          ← 编码规范、安全规则
agents/*.md         ← Agent 角色定义（planner/implementer/reviewer）
changes/<name>/     ← 每个变更：proposal → design → spec → tasks
workspace/          ← 运行时状态（STATE.md, ROADMAP.md）
config/             ← 配置 + 学习记忆（memory.json, instincts.json）
hooks/              ← 事件钩子（session 启动/结束/tool 调用）
scripts/            ← 工具脚本（init/install/validate/archive）
```

### 关键设计思想

- **Delta Spec** — 变更只描述增量，不重写全量规格
- **RFC 2119 关键字** — MUST/SHALL/SHOULD 区分强制级别
- **Gherkin 场景** — GIVEN/WHEN/THEN 描述行为
- **波次执行** — 独立任务并行，依赖任务串行
- **文件化记忆** — 所有状态持久化到文件，不依赖 LLM 上下文

## 架构总览

OpenAllIn 采用 **分层搭积木** 设计，每层独立可选、自由组合：

```
┌─────────────────────────────────────────────────┐
│  Layer 6: Workspace  — 项目记忆与并行流水线      │  ← Trellis
│  tasks/  workspace/  parallel pipeline            │
├─────────────────────────────────────────────────┤
│  Layer 5: Orchestration — 多代理团队编排          │  ← OMC
│  team-plan  team-exec  team-verify  agent roles  │
├─────────────────────────────────────────────────┤
│  Layer 4: Execution — 阶段化执行与上下文工程      │  ← GSD
│  discuss → plan → execute → verify → ship       │
├─────────────────────────────────────────────────┤
│  Layer 3: Enhancement — 安全/记忆/学习/验证      │  ← ECC
│  hooks  security  memory  instincts  learning    │
├─────────────────────────────────────────────────┤
│  Layer 2: Skills — 工程方法论技能库              │  ← Superpowers
│  brainstorm  TDD  debug  review  worktree        │
├─────────────────────────────────────────────────┤
│  Layer 1: Spec — 规格驱动开发                    │  ← OpenSpec
│  project.md  specs/  changes/  delta system      │
└─────────────────────────────────────────────────┘
```

## 目录结构

```
openallin/
├── AGENTS.md                    # 统一指令入口（所有 AI 工具读取）
├── project.md                   # 项目全局上下文（技术栈、架构、规范）
├── README.md                    # 本文件
│
├── specs/                       # [Spec 层] 当前系统行为规格（SOURCE OF TRUTH）
│   ├── auth/
│   │   └── spec.md
│   ├── api/
│   │   └── spec.md
│   └── ui/
│       └── spec.md
│
├── changes/                     # [Spec 层] 进行中的变更提案
│   ├── <change-name>/
│   │   ├── proposal.md          # WHY：动机、范围、影响
│   │   ├── design.md            # HOW：技术方案、架构决策
│   │   ├── specs/               # WHAT：增量规格（ADDED/MODIFIED/REMOVED）
│   │   │   └── spec.md
│   │   └── tasks.md             # STEPS：实现清单
│   └── archive/                 # 已归档的变更（按时间戳）
│
├── skills/                      # [Skills 层] 可组合技能
│   ├── brainstorming.md         # 头脑风暴与需求探索
│   ├── tdd-workflow.md          # 测试驱动开发
│   ├── systematic-debugging.md  # 系统化调试
│   ├── code-review.md           # 代码审查
│   ├── worktree-isolation.md    # Git Worktree 隔离
│   ├── writing-plans.md         # 计划编写
│   └── verification.md          # 验证闭环
│
├── agents/                      # [Orchestration 层] 专用代理定义
│   ├── planner.md               # 架构师/规划器（高阶推理）
│   ├── implementer.md           # 执行者（代码实现）
│   ├── reviewer.md              # 审查者（质量把关）
│   ├── debugger.md              # 调试者（问题诊断）
│   └── researcher.md            # 研究者（信息检索）
│
├── rules/                       # [Enhancement 层] 全局规则
│   ├── coding-standards.md      # 编码规范
│   ├── security-rules.md        # 安全规则
│   ├── commit-rules.md          # 提交规则
│   └── review-rules.md          # 审查规则
│
├── hooks/                       # [Enhancement 层] 事件驱动自动化
│   ├── hooks.json               # Hook 注册表
│   ├── pre-tool-use.js          # 工具执行前检查
│   ├── post-tool-use.js         # 工具执行后审计
│   ├── session-start.js         # 会话启动：加载上下文
│   └── session-end.js           # 会话结束：持久化状态
│
├── config/                      # [Enhancement 层] 配置
│   ├── settings.json            # 全局设置
│   ├── memory.json              # 记忆与学习数据
│   └── instincts.json           # 直觉/模式库
│
├── tasks/                       # [Execution 层] 任务驱动工作流
│   ├── <task-id>/
│   │   ├── task.json            # 元数据：状态、分支、优先级
│   │   ├── prd.md               # 需求文档
│   │   ├── implement.jsonl      # 实现 Agent 上下文配置
│   │   └── check.jsonl          # 检查 Agent 上下文配置
│   └── archive/
│
├── workspace/                   # [Workspace 层] 项目记忆
│   ├── index.md                 # 会话索引
│   ├── STATE.md                 # 当前执行状态
│   ├── ROADMAP.md               # 项目路线图
│   └── journals/
│       └── journal-<date>.md    # 每日工作日志
│
├── .planning/                   # [Execution 层] 运行时规划状态
│   ├── config.json              # 运行配置
│   ├── CONTEXT.md               # 澄清后的需求
│   └── REQUIREMENTS.md          # 提取的需求
│
├── templates/                   # 模板库
│   ├── proposal.md
│   ├── design.md
│   ├── spec.md
│   ├── tasks.md
│   └── task.json
│
└── scripts/                     # 工具脚本
    ├── init.sh                  # 初始化脚本
    ├── install.sh               # 安装脚本（多平台支持）
    ├── validate-spec.sh         # 规格验证
    └── archive-change.sh        # 变更归档
```

## 安装指南

OpenAllIn 支持 **一键安装** 到多种 AI 编码工具中。以下是各平台的安装方式。

### 方式一：一键安装脚本（推荐）

```bash
# 克隆仓库
git clone https://github.com/vanrayliu/openallin.git
cd openallin

# 安装到指定工具（支持多参数）
bash scripts/install.sh opencode                    # 仅 OpenCode（当前目录）
bash scripts/install.sh claude                      # 仅 Claude Code（当前目录）
bash scripts/install.sh opencode claude             # 同时安装（当前目录）
bash scripts/install.sh opencode --target /path/to/project  # 安装到指定目录
```

### 方式二：手动安装

---

#### OpenCode

OpenCode 原生兼容 `AGENTS.md`，安装最简单：

**项目级安装**（推荐）：
```bash
# 1. 将 OpenAllIn 核心文件复制到项目根目录
cp openallin/AGENTS.md your-project/
cp openallin/project.md your-project/
cp -r openallin/specs/ your-project/
cp -r openallin/changes/ your-project/
cp -r openallin/config/ your-project/config/
cp -r openallin/workspace/ your-project/workspace/
cp -r openallin/templates/ your-project/templates/
cp -r openallin/scripts/ your-project/scripts/

# 2. Skills 需要 SKILL.md 包装（推荐使用安装脚本自动转换）
# 手动方式: mkdir -p your-project/.opencode/skills/brainstorming
#          然后创建 SKILL.md 带 YAML frontmatter

# 3. 配置 opencode.json（在项目根目录）
cat > your-project/opencode.json << 'EOF'
{
  "instructions": ["AGENTS.md", "project.md"],
  "permission": {
    "skill": {
      "*": "allow"
    }
  }
}
EOF
```

**全局安装**（所有项目可用）：
```bash
# Copy AGENTS.md to global config
cp openallin/AGENTS.md ~/.config/opencode/AGENTS.md
# Skills need SKILL.md wrapper — use install script for proper format
```

**OpenCode 目录映射**：
| OpenAllIn 目录 | OpenCode 目标路径 |
|---------------|-------------------|
| `AGENTS.md` | 项目根目录 `AGENTS.md` |
| `skills/*.md` | `.opencode/skills/<name>/SKILL.md` |
| `rules/*.md` | `.opencode/rules/` |
| `agents/*.md` | `.opencode/agents/` |

---

#### Claude Code

Claude Code 使用 `CLAUDE.md` 作为主指令文件：

**项目级安装**（推荐）：
```bash
# 1. 创建 .claude 目录结构
mkdir -p your-project/.claude/{rules,skills,agents,hooks}

# 2. 复制核心文件
cp openallin/AGENTS.md your-project/CLAUDE.md
cp openallin/project.md your-project/
cp -r openallin/specs/ your-project/
cp -r openallin/changes/ your-project/
cp -r openallin/config/ your-project/config/
cp -r openallin/workspace/ your-project/workspace/
cp -r openallin/templates/ your-project/templates/
cp -r openallin/scripts/ your-project/scripts/

# 3. 复制 rules 和 agents
cp openallin/rules/*.md your-project/.claude/rules/
cp openallin/agents/*.md your-project/.claude/agents/

# 4. 复制 hooks
cp openallin/hooks/*.js your-project/.claude/hooks/

# 5. 配置 hooks（在 .claude/settings.json 中）
cat > your-project/.claude/settings.json << 'EOF'
{
  "hooks": {
    "SessionStart": [
      { "type": "command", "command": "node $CLAUDE_PROJECT_DIR/.claude/hooks/session-start.js" }
    ],
    "SessionEnd": [
      { "type": "command", "command": "node $CLAUDE_PROJECT_DIR/.claude/hooks/session-end.js" }
    ],
    "PreToolUse": [
      { "type": "command", "command": "node $CLAUDE_PROJECT_DIR/.claude/hooks/pre-tool-use.js" }
    ],
    "PostToolUse": [
      { "type": "command", "command": "node $CLAUDE_PROJECT_DIR/.claude/hooks/post-tool-use.js" }
    ]
  }
}
EOF
```

**全局安装**（所有项目可用）：
```bash
cp openallin/AGENTS.md ~/.claude/CLAUDE.md
# Skills need SKILL.md wrapper — use install script for proper format
cp -r openallin/rules/* ~/.claude/rules/
```

---

#### 其他工具

| 工具 | 安装方式 | 说明 |
|------|---------|------|
| **Cursor** | 复制 `AGENTS.md` 到项目根目录，或放入 `.cursor/rules/` | 读取 `AGENTS.md` 或 `.cursor/rules/` |
| **Codex** | 复制 `AGENTS.md` 到项目根目录 | 通过 AGENTS.md 读取指令 |
| **Gemini CLI** | 复制 `AGENTS.md` 到项目根目录 | 兼容 Claude Code 格式 |
| **Windsurf** | 复制 `AGENTS.md` 到项目根目录 | 自动读取 |
| **Kilo Code** | 复制 `AGENTS.md` 到项目根目录 | 自动读取 |

**通用安装**（适用于所有工具）：
```bash
# 最小安装：只复制核心指令文件
cp openallin/AGENTS.md your-project/
cp openallin/project.md your-project/
cp -r openallin/specs/ your-project/
cp -r openallin/changes/ your-project/
cp -r openallin/workspace/ your-project/workspace/
```

---

### 安装后验证

```bash
# 1. 检查文件是否就位
ls -la your-project/AGENTS.md       # OpenCode
ls -la your-project/CLAUDE.md       # Claude Code
ls -la your-project/.opencode/skills/  # OpenCode skills
ls -la your-project/.claude/skills/    # Claude Code skills

# 2. 启动 AI 工具，确认指令已加载
opencode          # 应显示 AGENTS.md 内容摘要
claude            # 应显示 CLAUDE.md 内容摘要

# 3. 测试技能是否可用
# 在 AI 工具中输入 /skills 或询问 AI "你有哪些可用技能"
```

---

## 快速开始

### 1. 初始化

```bash
# 在项目根目录初始化 OpenAllIn
bash scripts/init.sh
```

### 2. 工作流

```
# Step 1: 规格驱动（先把"做什么"写清楚）
/oa:propose <change-name>     → 创建变更提案（proposal + design + specs + tasks）
/oa:validate <change-name>    → 验证规格格式
/oa:apply <change-name>       → 按任务清单执行
/oa:archive <change-name>     → 归档变更并合并到主规格

# Step 2: 阶段化执行（解决上下文腐烂）
/oa:discuss <phase>           → 讨论阶段，澄清模糊地带
/oa:plan <phase>              → 计划阶段，拆分原子任务
/oa:execute <phase>           → 执行阶段，波次并行
/oa:verify <phase>            → 验证阶段，质量把关
/oa:ship <phase>              → 发布阶段，创建 PR

# Step 3: 团队协作（多代理编排）
/oa:team-plan                 → 团队规划
/oa:team-exec                 → 团队执行
/oa:team-verify               → 团队验证

# Step 4: 技能调用（工程纪律）
/oa:brainstorm                → 头脑风暴
/oa:tdd                       → 测试驱动开发
/oa:debug                     → 系统化调试
/oa:review                    → 代码审查
/oa:worktree                  → Git Worktree 隔离
```

### 三种典型工作流

**个人轻量模式**：brainstorm → propose → apply → verify → commit

**复杂功能分阶段**：Discuss（澄清需求）→ Plan（原子任务）→ Execute（波次执行）→ Verify（多维验证）→ Ship（创建 PR）

**团队协作模式**：Spec 对齐 → Planner/Researcher 规划 → Worktree 并行开发 → Reviewer 审核 → Memory 沉淀

### 3. 分层采用建议

| 你的痛点 | 优先启用层 | 组合建议 |
|---------|-----------|---------|
| 需求总跑偏 | Spec 层 | Spec + Skills |
| AI 写得太随意 | Skills 层 | Spec + Skills |
| 长任务容易崩 | Execution 层 | Spec + Execution |
| 需要多人并行 | Orchestration 层 | Spec + Orchestration |
| 跨会话失忆 | Workspace 层 | Spec + Workspace |
| 想要完整体系 | 全层 | 全部（建议渐进式） |

## 设计理念

1. **规格先行** — 需求没对齐前不写代码（OpenSpec）
2. **工程纪律** — 把优秀工程师的习惯变成默认动作（Superpowers）
3. **上下文清洁** — 拆小任务、阶段分离、信息结构化（GSD）
4. **团队编排** — 多代理像团队一样协作（OMC）
5. **能力增强** — 安全、记忆、学习、验证闭环（ECC）
6. **项目记忆** — 用文件而非 LLM 记忆来持久化上下文（Trellis）

## 许可证

MIT
