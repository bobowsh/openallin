# OpenAllIn — Full-Stack AI Programming Harness

> A framework for AI coding tools that unifies the best practices from OpenSpec, Superpowers, GSD, OMC, ECC, and Trellis, providing structured development workflows for teams.

---

# OpenAllIn — 全栈 AI 编程 Harness

> 一个面向 AI 编码工具的工程化框架，将六大成熟框架的核心优势融为一体，为团队提供结构化的开发流程和规范。

---

## 📖 使用教程 / User Guide

| 语言 | 文档 | 说明 |
|------|------|------|
| 🇨🇳 **中文** | [USAGE.md](./USAGE.md) | 详细使用手册（老项目、新项目、工作流、FAQ、最佳实践） |
| 🇺🇸 **English** | [USAGE_EN.md](./USAGE_EN.md) | Comprehensive user guide (legacy/new projects, workflows, FAQ, best practices) |

---

## 🚀 Quick Start / 快速开始

### 💬 Natural Language Commands / 自然语言命令

You can use **natural language** to trigger installation, updates, and workflows:

你可以用**自然语言**让 AI 执行安装、更新和工作流：

| What You Say / 你说的 | AI Executes / AI 执行的 |
|----------------------|------------------------|
| "Install OpenAllIn" / "安装 OpenAllIn" | `bash scripts/install.sh` |
| "Update OpenAllIn" / "更新一下" | `bash scripts/update.sh` |
| "Preview update" / "预览更新内容" | `bash scripts/update.sh --dry-run` |
| "Force update" / "强制更新" | `bash scripts/update.sh --force` |
| "Uninstall OpenAllIn" / "卸载 OpenAllIn" | `bash scripts/uninstall.sh` |
| "Add a new feature" / "我想加个新功能" | `/oa-propose <name>` |
| "Discuss requirements" / "讨论需求" | `/oa-discuss` |
| "Start implementation" / "开始实现" | `/oa-apply <name>` |
| "Check code quality" / "检查代码质量" | `/oa-review` |
| "Security check" / "安全检查" | `/oa-security` |
| "Ship this" / "发布这个" | `/oa-ship` |
| "Deploy to production" / "部署到生产" | `/oa-land` |
| "Debug this bug" / "调试这个 bug" | `/oa-debugging` |
| "Write a test" / "写个测试" | `/oa-tdd` |

---

```bash
# 1. Clone this repo
git clone https://github.com/vanrayliu/openallin.git

# 2. Go to YOUR project directory (NOT the cloned repo)
cd your-project

# 3. Install OpenAllIn to YOUR project (current directory)
# This creates .claude/, skills/, rules/, etc. in YOUR project
bash /path/to/openallin/scripts/install.sh claude

# 4. Done! Restart your AI coding tool
```

**IMPORTANT:** Installation is **project-level**, not home directory. Run `install.sh` from your project directory.

For other AI tools:
```bash
bash install.sh opencode    # OpenCode
bash install.sh claude      # Claude Code  
bash install.sh cursor      # Cursor
bash install.sh codex       # Codex
bash install.sh             # All tools
```

---

## Why OpenAllIn?

AI coding tools are powerful, but 6 common instabilities often emerge in practice:

| Layer | Name | Problem Solved |
|-------|------|----------------|
| Layer 6 | Workspace | AI lacks long-term memory → File-based state & memory |
| Layer 5 | Orchestration | Team collaboration chaos → Multi-Agent coordination |
| Layer 4 | Execution | Long对话上下文崩溃 → Phase-based workflows |
| Layer 3 | Enhancement | Security/verification gaps → Hook automation + security audit, deployment verification, browser testing, performance benchmarking |
| Layer 2 | Skills | AI codes like an intern → Engineering methodology skill library |
| Layer 1 | Spec | AI doesn't know what you want → Spec-driven development |

### Technical Features

- **Pure text/Shell/JSON** — No external dependencies, works offline
- **Layered design** — Each layer independently optional, progressive adoption
- **Language-agnostic** — Works with any language/framework
- **Multi-tool support** — OpenCode, Claude Code, Cursor, Codex, and more

### Core File Relationships

```
AGENTS.md                ← Unified entry point for AI tools
    ↓
skills/oa-*/           ← 23 commands (oa-propose, oa-brainstorming, oa-tdd, oa-security, oa-review, oa-ui-design, etc.)
rules/*.md               ← Coding standards, security rules
agents/*.md              ← Agent role definitions (planner/implementer/reviewer)
changes/<name>/          ← Each change: proposal → design → spec → tasks
workspace/               ← Runtime state (STATE.md, ROADMAP.md)
config/                  ← Configuration + learning (memory.json, instincts.json)
hooks/                   ← Event hooks (session start/end/tool calls)
scripts/                 ← Utility scripts (init/install/validate/archive)
```

### Key Design Concepts

- **Delta Spec** — Changes describe only deltas, not full specs
- **RFC 2119 Keywords** — MUST/SHALL/SHOULD for mandatory levels
- **Gherkin Scenarios** — GIVEN/WHEN/THEN for behavior description
- **Wave Execution** — Independent tasks parallel, dependent tasks sequential
- **File-based Memory** — All state persisted to files, not LLM context

---

## 为什么需要 OpenAllIn？

AI 编程工具越来越强大，但实际使用中总会遇到 6 大不稳定性：

| 层级 | 名称 | 解决的问题 |
|------|------|-----------|
| Layer 6 | Workspace | AI 没有长期记忆 → 文件化状态与记忆 |
| Layer 5 | Orchestration | 团队协作混乱 → 多 Agent 协调 |
| Layer 4 | Execution | 长对话上下文崩溃 → 分阶段工作流 |
| Layer 3 | Enhancement | 安全/验证缺失 → Hook 自动化 + 安全审计、部署验证、浏览器测试、性能基准 |
| Layer 2 | Skills | AI 写代码像实习生 → 工程方法论技能库 |
| Layer 1 | Spec | AI 不知道你想要什么 → 规格驱动开发 |

### 技术特色

- **纯文本/Shell/JSON** — 无外部依赖，可离线运行
- **分层设计** — 每层独立可选，支持渐进式采用
- **语言无关** — 适用于任何语言/框架的项目
- **多工具支持** — OpenCode、Claude Code、Cursor、Codex 等

### 核心文件关系

```
AGENTS.md                ← AI 工具的统一入口
    ↓
skills/oa-*/           ← 23 个命令（oa-propose, oa-brainstorming, oa-tdd, oa-security, oa-review, oa-ui-design 等）
rules/*.md               ← 编码规范、安全规则
agents/*.md              ← Agent 角色定义（planner/implementer/reviewer）
changes/<name>/          ← 每个变更：proposal → design → spec → tasks
workspace/               ← 运行时状态（STATE.md, ROADMAP.md）
config/                  ← 配置 + 学习记忆（memory.json, instincts.json）
hooks/                   ← 事件钩子（session 启动/结束/tool 调用）
scripts/                 ← 工具脚本（init/install/validate/archive）
```

### 关键设计思想

- **Delta Spec** — 变更只描述增量，不重写全量规格
- **RFC 2119 关键字** — MUST/SHALL/SHOULD 区分强制级别
- **Gherkin 场景** — GIVEN/WHEN/THEN 描述行为
- **波次执行** — 独立任务并行，依赖任务串行
- **文件化记忆** — 所有状态持久化到文件，不依赖 LLM 上下文

---

## Architecture Overview / 架构总览

OpenAllIn uses a **layered, composable** design where each layer is independently optional and freely combinable:

```
┌─────────────────────────────────────────────────┐
│  Layer 6: Workspace  — Project Memory &          │  ← Trellis
│             Parallel Pipeline                     │
├─────────────────────────────────────────────────┤
│  Layer 5: Orchestration — Multi-Agent Team       │  ← OMC
│             Coordination                          │
├─────────────────────────────────────────────────┤
│  Layer 4: Execution — Phase-Based Workflow &     │  ← GSD
│             Context Engineering                   │
├─────────────────────────────────────────────────┤
│  Layer 3: Enhancement — Security / Memory /      │  ← ECC
│             Learning / Verification               │
├─────────────────────────────────────────────────┤
│  Layer 2: Skills — Engineering Methodology       │  ← Superpowers
│             Library                               │
├─────────────────────────────────────────────────┤
│  Layer 1: Spec — Spec-Driven Development         │  ← OpenSpec
└─────────────────────────────────────────────────┘
```

---

## Directory Structure / 目录结构

```
openallin/
├── AGENTS.md                    # Unified entry point (all AI tools)
├── project.md                   # Project global context
├── README.md                    # Bilingual README (this file)
├── README_zh.md               # Chinese version
│
├── examples/                   # Example change proposals (for learning)
│   └── add-user-login/        # User login system example
│
├── specs/                       # [Spec Layer] Current system specs (SOURCE OF TRUTH)
│   ├── auth/
│   ├── api/
│   └── ui/
│
├── changes/                     # [Spec Layer] In-progress change proposals (empty by default)
│   ├── <change-name>/
│   │   ├── proposal.md         # WHY: motivation, scope, impact
│   │   ├── design.md           # HOW: technical approach, decisions
│   │   ├── specs/              # WHAT: delta specs (ADDED/MODIFIED/REMOVED)
│   │   └── tasks.md            # STEPS: implementation checklist
│   └── archive/                # Archived changes (by timestamp)
│
├── skills/                      # [Skills Layer] CLI commands (oa-*)
│   ├── oa-propose.md          # Create change proposal
│   ├── oa-apply.md            # Execute tasks from checklist
│   ├── oa-validate.md          # Validate spec format
│   ├── oa-archive.md           # Archive change and merge to specs
│   ├── oa-discuss.md          # Discuss and clarify requirements
│   ├── oa-plan.md             # Plan atomic tasks
│   ├── oa-execute.md          # Execute in waves
│   ├── oa-verify.md           # Verify quality
│   ├── oa-ship.md             # Ship and create PR
│   ├── oa-team-plan.md        # Team planning
│   ├── oa-team-exec.md        # Team execution
│   ├── oa-team-verify.md      # Team verification
│   ├── oa-brainstorming.md    # Brainstorming session
│   ├── oa-debugging.md        # Systematic debugging
│   ├── oa-tdd.md              # Test-driven development
│   ├── oa-writing-plans.md     # Plan writing
│   ├── oa-worktree.md         # Git Worktree isolation
│   ├── oa-security.md         # Security audit (OWASP + STRIDE)
│   ├── oa-land.md             # Deployment verification
│   ├── oa-qa-browser.md       # Browser testing (Playwright)
│   ├── oa-benchmark.md        # Performance testing
│   ├── oa-review.md           # Code/design/architecture review
│   └── oa-ui-design.md        # UI/UX design intelligence
│
├── lib/                         # [Skills Layer] Supporting libraries
│   ├── security/               # Security audit library
│   │   ├── checklist.md        # OWASP + STRIDE checklist
│   │   └── patterns.md         # Vulnerability patterns
│   ├── deploy/                 # Deployment library
│   │   ├── smoke-tests.md      # Smoke test templates
│   │   └── rollback.md         # Rollback procedures
│   ├── browser/                # Browser testing library
│   │   ├── playwright-config.md # Playwright setup guide
│   │   └── test-templates.md   # Test templates
│   ├── performance/            # Performance testing library
│   │   └── benchmark-templates.md # Benchmark templates
│   ├── review/                 # Review library
│   │   ├── design-checklist.md # UI/UX design checklist
│   │   └── architecture-checklist.md # Architecture checklist
│   └── ui-design/              # UI design library
│       └── quick-reference.md  # Design patterns & recommendations
│
├── agents/                      # [Orchestration Layer] Agent definitions
│   ├── planner.md              # Architect/planner (high-level reasoning)
│   ├── implementer.md           # Implementer (code writing)
│   ├── reviewer.md             # Reviewer (quality gate)
│   ├── debugger.md             # Debugger (problem diagnosis)
│   └── researcher.md           # Researcher (information retrieval)
│
├── rules/                       # [Enhancement Layer] Global rules
│   ├── coding-standards.md
│   ├── security-rules.md
│   ├── commit-rules.md
│   └── review-rules.md
│
├── hooks/                       # [Enhancement Layer] Event hooks
│   ├── hooks.json              # Hook registry
│   ├── pre-tool-use.js        # Pre-tool security check
│   ├── post-tool-use.js       # Post-tool audit
│   ├── session-start.js        # Session start: load context
│   └── session-end.js         # Session end: persist state
│
├── config/                      # [Enhancement Layer] Configuration
│   ├── settings.json
│   ├── memory.json
│   └── instincts.json
│
├── tasks/                       # [Execution Layer] Task-driven workflow
│   ├── <task-id>/
│   └── archive/
│
├── workspace/                   # [Workspace Layer] Project memory
│   ├── index.md
│   ├── STATE.md
│   ├── ROADMAP.md
│   └── journals/
│
├── .planning/                   # [Execution Layer] Runtime planning state
│   ├── config.json
│   ├── CONTEXT.md
│   └── REQUIREMENTS.md
│
├── templates/                   # Template library
│   ├── proposal.md
│   ├── design.md
│   ├── spec.md
│   ├── tasks.md
│   └── task.json
│
└── scripts/                     # Utility scripts
    ├── init.sh                 # Initialization
    ├── install.sh              # Installation (multi-platform)
    ├── uninstall.sh            # Uninstallation
    ├── validate-spec.sh        # Spec validation
    └── archive-change.sh       # Change archival
```

---

## Installation / 安装指南

OpenAllIn supports **one-click installation** to multiple AI coding tools.

### Method 1: One-click Install Script (Recommended) / 一键安装脚本（推荐）

```bash
# Clone repository
git clone https://github.com/vanrayliu/openallin.git
cd openallin

# Install to specified tools
bash scripts/install.sh opencode                    # OpenCode only
bash scripts/install.sh claude                      # Claude Code only
bash scripts/install.sh opencode claude             # Both tools
bash scripts/install.sh opencode --target /path/to/project  # Install to directory
```

### Method 2: Manual Installation / 手动安装

---

#### OpenCode

OpenCode natively supports `AGENTS.md`:

**Project-level (Recommended)**:
```bash
# 1. Copy OpenAllIn core files
cp openallin/AGENTS.md your-project/
cp openallin/project.md your-project/
cp -r openallin/specs/ your-project/
cp -r openallin/changes/ your-project/
cp -r openallin/config/ your-project/config/
cp -r openallin/workspace/ your-project/workspace/
cp -r openallin/templates/ your-project/templates/
cp -r openallin/scripts/ your-project/scripts/
cp -r openallin/rules/ your-project/rules/

# 2. Skills require SKILL.md wrapper (install script handles this)
mkdir -p your-project/.opencode/skills/brainstorming
# Create SKILL.md with YAML frontmatter

# 3. Configure opencode.json
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

**Global install**:
```bash
cp openallin/AGENTS.md ~/.config/opencode/AGENTS.md
```

**OpenCode Directory Mapping**:
| OpenAllIn | OpenCode Target |
|-----------|-----------------|
| `AGENTS.md` | Project root `AGENTS.md` |
| `skills/*.md` | `.opencode/skills/<name>/SKILL.md` |
| `rules/*.md` | `.opencode/rules/` |
| `agents/*.md` | `.opencode/agents/` |
| `hooks/*.js` | `.opencode/hooks/` |

---

#### Claude Code

Claude Code uses `CLAUDE.md` as the main instruction file:

**Project-level (Recommended)**:
```bash
# 1. Create .claude directory structure
mkdir -p your-project/.claude/{rules,skills,agents,hooks}

# 2. Copy core files
cp openallin/AGENTS.md your-project/CLAUDE.md
cp openallin/project.md your-project/
cp -r openallin/specs/ your-project/
cp -r openallin/changes/ your-project/
cp -r openallin/config/ your-project/config/
cp -r openallin/workspace/ your-project/workspace/
cp -r openallin/templates/ your-project/templates/
cp -r openallin/scripts/ your-project/scripts/

# 3. Copy rules and agents
cp openallin/rules/*.md your-project/.claude/rules/
cp openallin/agents/*.md your-project/.claude/agents/

# 4. Copy hooks (including hooks.json)
cp openallin/hooks/*.js openallin/hooks/hooks.json your-project/.claude/hooks/

# 5. Configure hooks
cat > your-project/.claude/settings.json << 'EOF'
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "node $CLAUDE_PROJECT_DIR/.claude/hooks/session-start.js" }
        ]
      }
    ],
    "SessionEnd": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "node $CLAUDE_PROJECT_DIR/.claude/hooks/session-end.js" }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "node $CLAUDE_PROJECT_DIR/.claude/hooks/pre-tool-use.js" }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "node $CLAUDE_PROJECT_DIR/.claude/hooks/post-tool-use.js" }
        ]
      }
    ]
  }
}
EOF
```

**Global install**:
```bash
cp openallin/AGENTS.md ~/.claude/CLAUDE.md
cp -r openallin/rules/* ~/.claude/rules/
```

**Claude Code Directory Mapping**:
| OpenAllIn | Claude Code Target |
|-----------|-------------------|
| `AGENTS.md` | Project root `CLAUDE.md` |
| `skills/*.md` | `.claude/skills/<name>/SKILL.md` |
| `rules/*.md` | `.claude/rules/` |
| `agents/*.md` | `.claude/agents/` |
| `hooks/*.js` | `.claude/hooks/` |

---

#### Other Tools / 其他工具

| Tool | Install Method | Notes |
|------|---------------|-------|
| **Cursor** | Copy `AGENTS.md` to root or `.cursor/rules/` | Reads `AGENTS.md` or `.cursor/rules/` |
| **Codex** | Copy `AGENTS.md` to root | Reads AGENTS.md |
| **Gemini CLI** | Copy `AGENTS.md` to root | Claude Code compatible |
| **Windsurf** | Copy `AGENTS.md` to root | Auto-detects |
| **Kilo Code** | Copy `AGENTS.md` to root | Auto-detects |

**Universal install** (all tools):
```bash
cp openallin/AGENTS.md your-project/
cp openallin/project.md your-project/
cp -r openallin/specs/ your-project/
cp -r openallin/changes/ your-project/
cp -r openallin/workspace/ your-project/workspace/
```

---

### Post-Install Verification / 安装后验证

```bash
# 1. Check files
ls -la your-project/AGENTS.md       # OpenCode
ls -la your-project/CLAUDE.md        # Claude Code

# 2. Start AI tool, confirm instructions loaded
opencode
claude

# 3. Test skills
# Type /skills or ask "what skills do you have"
```

---

## Quick Start / 快速开始

### 1. Initialize / 初始化

```bash
bash scripts/init.sh
```

### 2. Workflow / 工作流

```
# Step 1: Spec-driven (clarify "what" first)
# 规格驱动（先把"做什么"写清楚）
/oa-propose <change-name>     → Create change proposal
/oa-validate <change-name>    → Validate spec format
/oa-apply <change-name>       → Execute tasks from checklist
/oa-archive <change-name>     → Archive change and merge to specs

# Step 2: Phase execution (solve context rot)
# 阶段化执行（解决上下文腐烂）
/oa-discuss <phase>           → Discuss phase, clarify ambiguity
/oa-plan <phase>              → Plan phase, split atomic tasks
/oa-execute <phase>           → Execute phase, parallel waves
/oa-verify <phase>            → Verify phase, quality gate
/oa-review <phase>            → Review phase (code/design/architecture)
/oa-security                  → Security audit (OWASP + STRIDE)
/oa-ship <phase>              → Ship phase, create PR
/oa-land                      → Land phase, deployment verification

# Step 3: Team collaboration (multi-agent orchestration)
# 团队协作（多代理编排）
/oa-team-plan                 → Team planning
/oa-team-exec                 → Team execution
/oa-team-verify               → Team verification

# Step 4: Skill invocation (engineering discipline)
# 技能调用（工程纪律）
/oa-brainstorming                → Brainstorming session (multi-round)
/oa-debugging                    → Systematic debugging (multi-round)
/oa-tdd                          → Test-driven development (Red-Green-Refactor)
/oa-writing-plans               → Plan writing (multi-round)
/oa-worktree                    → Git Worktree isolation
/oa-ui-design                   → UI/UX design intelligence
/oa-qa-browser                 → Browser testing (Playwright)
/oa-benchmark                   → Performance testing
```

### Three Typical Workflows / 三种典型工作流

**Personal Lightweight Mode**: brainstorm → propose → apply → verify → commit

**Complex Feature Phased Mode**: Discuss → Plan → Execute → Verify → Ship

**Team Collaboration Mode**: Spec alignment → Planner/Researcher planning → Worktree parallel development → Reviewer review → Memory persistence

### 3. Layered Adoption Guide / 分层采用建议

| Pain Point | Priority Layer | Combination |
|------------|---------------|-------------|
| AI doesn't know what you want | Spec Layer | Spec + Skills |
| AI codes like an intern | Skills Layer | Spec + Skills |
| Long conversations break | Execution Layer | Spec + Execution |
| Multi-person chaos | Orchestration Layer | Spec + Orchestration |
| Session amnesia | Workspace Layer | Spec + Workspace |
| Full system wanted | All Layers | All (progressive) |

---

## Documentation / 文档

| Document | Description |
|----------|-------------|
| **README.md** | Project introduction and installation guide / 项目介绍和安装指南 |
| **README_zh.md** | Chinese version / 中文版 |
| **QUICKREF.md** | Quick reference card (23 commands) / 快速参考卡 |
| **WORKFLOW.md** | Detailed workflows / 详细工作流程 |
| **USAGE.md** | User guide (Chinese) / 使用手册（中文） |
| **USAGE_EN.md** | User guide (English) / 使用手册（英文） |

---

## Design Philosophy / 设计理念

1. **Spec First** — Align on requirements before writing code (OpenSpec)
2. **Engineering Discipline** — Make best practices default behavior (Superpowers)
3. **Context Hygiene** — Small tasks, phase separation, structured information (GSD)
4. **Team Orchestration** — Multiple agents collaborate like a real team (OMC)
5. **Capability Enhancement** — Security, memory, learning, verification loops (ECC)
6. **Project Memory** — File-based persistence over LLM memory (Trellis)

---

## License / 许可证

MIT
