#!/bin/bash

# OpenAllIn 初始化脚本
# 在项目根目录运行此脚本

set -e

HARNESS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_DIR="${1:-.}"

echo "🚀 OpenAllIn 初始化"
echo "=================="

# 检查目标目录
if [ ! -d "$TARGET_DIR" ]; then
  echo "❌ 目标目录不存在: $TARGET_DIR"
  exit 1
fi

cd "$TARGET_DIR"

# 创建目录结构
echo "📁 创建目录结构..."
mkdir -p specs/{auth,api,ui}
mkdir -p changes/archive
mkdir -p rules
mkdir -p config
mkdir -p tasks/archive
mkdir -p workspace/journals
mkdir -p .planning

# 复制模板和规则文件
echo "📋 复制模板文件..."
cp -rn "$HARNESS_DIR/templates" . 2>/dev/null || true
cp -rn "$HARNESS_DIR/rules" . 2>/dev/null || true
cp "$HARNESS_DIR/project.md" . 2>/dev/null || true

# 创建 AGENTS.md
if [ ! -f "AGENTS.md" ]; then
  echo "📝 创建 AGENTS.md..."
  cat > AGENTS.md << 'EOF'
# OpenAllIn — Unified AI Coding Harness

> A layered, composable engineering framework combining the best of OpenSpec, Superpowers, GSD, OMC, ECC, and Trellis.

## Core Principles

1. **Spec First** — Align on requirements before writing code
2. **Engineering Discipline** — Make best practices the default behavior
3. **Context Hygiene** — Small tasks, phase separation, structured information
4. **Team Orchestration** — Multiple agents collaborate like a real team
5. **Capability Enhancement** — Security, memory, learning, verification loops
6. **Project Memory** — File-based persistence over LLM memory

## Commands

```
/oa:propose <name>    → Create change proposal
/oa:apply <name>      → Execute tasks from checklist
/oa:validate <name>   → Validate spec format
/oa:archive <name>    → Archive change and merge to specs
/oa:discuss <phase>   → Discuss phase
/oa:plan <phase>      → Plan phase
/oa:execute <phase>   → Execute phase
/oa:verify <phase>    → Verify phase
/oa:ship <phase>      → Ship phase
/oa:team-plan         → Team planning
/oa:team-exec         → Team execution
/oa:team-verify       → Team verification
/oa:brainstorm        → Brainstorming
/oa:tdd               → Test-driven development
/oa:debug             → Systematic debugging
/oa:review            → Code review
/oa:worktree          → Git Worktree isolation
```

## Workflows

### Spec-Driven (OpenSpec)
1. `/oa:propose` → Create proposal.md + design.md + specs/ + tasks.md
2. User review and confirm
3. `/oa:apply` → Execute tasks.md items
4. `/oa:archive` → Merge delta specs to specs/

### Phase Execution (GSD)
1. `/oa:discuss` → Clarify requirements, output CONTEXT.md
2. `/oa:plan` → Split atomic tasks, output execution waves
3. `/oa:execute` → Execute in waves, each wave independent context
4. `/oa:verify` → Multi-dimensional verification (lint/test/build)
5. `/oa:ship` → Create PR

## Skills

- **brainstorming** — Required before any creative work
- **tdd-workflow** — Required before implementing features or fixing bugs
- **systematic-debugging** — Required when encountering bugs or test failures
- **code-review** — Required before completing tasks or merging
- **worktree-isolation** — Use when starting feature development
- **writing-plans** — Use before coding for multi-step tasks
- **verification** — Required before claiming completion

## Rules

- Coding standards: rules/coding-standards.md
- Security rules: rules/security-rules.md
- Commit rules: rules/commit-rules.md
- Review rules: rules/review-rules.md

## Project Context

Project context: project.md
Current state: workspace/STATE.md
Roadmap: workspace/ROADMAP.md
EOF
fi

# 创建初始状态文件
echo "📊 创建状态文件..."
cat > workspace/STATE.md << EOF
# 当前状态

> 最后更新: $(date -u +%Y-%m-%dT%H:%M:%SZ)

## 当前任务
无活跃任务

## 进度
OpenAllIn Harness 已初始化

## 待确认事项
无
EOF

cat > workspace/ROADMAP.md << 'EOF'
# 项目路线图

## 规格状态
| 模块 | 状态 | 最后更新 |
|------|------|---------|
| - | - | - |

## 变更状态
| 变更 | 状态 | 阶段 |
|------|------|------|
| - | - | - |

## 任务状态
| 任务 | 状态 | 负责人 |
|------|------|--------|
| - | - | - |
EOF

# 创建配置文件
echo "⚙️ 创建配置文件..."
cat > config/settings.json << 'EOF'
{
  "version": "1.0.0",
  "mode": "interactive",
  "granularity": "standard",
  "model_profile": "balanced",
  "features": {
    "spec_driven": true,
    "phase_execution": true,
    "team_orchestration": false,
    "security_hooks": true,
    "memory_persistence": true,
    "continuous_learning": false
  },
  "limits": {
    "max_thinking_tokens": 10000,
    "autocompact_pct": 50,
    "subagent_model": "haiku",
    "max_parallel_tasks": 3,
    "ralph_loop_max_iterations": 5
  },
  "paths": {
    "specs_dir": "specs",
    "changes_dir": "changes",
    "skills_dir": "skills",
    "agents_dir": "agents",
    "rules_dir": "rules",
    "hooks_dir": "hooks",
    "tasks_dir": "tasks",
    "workspace_dir": "workspace",
    "planning_dir": ".planning"
  }
}
EOF

cat > config/memory.json << 'EOF'
{
  "project_decisions": [],
  "learned_patterns": [],
  "recurring_issues": [],
  "team_conventions": [],
  "last_updated": null
}
EOF

cat > config/instincts.json << 'EOF'
{
  "instincts": [],
  "version": "1.0.0",
  "description": "直觉/模式库 — 从会话中自动提取的可靠模式",
  "schema": {
    "instinct": {
      "id": "string",
      "pattern": "string",
      "context": "string",
      "confidence": "number (0-1)",
      "times_used": "number",
      "created_at": "ISO date",
      "updated_at": "ISO date"
    }
  }
}
EOF

cat > .planning/config.json << 'EOF'
{
  "mode": "interactive",
  "granularity": "standard",
  "model_profile": "balanced"
}
EOF

echo ""
echo "✅ OpenAllIn 初始化完成!"
echo ""
echo "下一步:"
echo "  1. 编辑 project.md 填入你的项目信息"
echo "  2. 运行 /oa:propose <name> 创建第一个变更提案"
echo "  3. 或运行 /oa:brainstorm 开始头脑风暴"
echo ""
