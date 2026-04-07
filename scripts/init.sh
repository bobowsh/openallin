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

> 分层可组合的工程框架，融合 OpenSpec、Superpowers、GSD、OMC、ECC、Trellis 核心优势

## 核心原则

1. **Spec First** — 需求对齐前不写代码
2. **Engineering Discipline** — 优秀工程习惯是默认行为
3. **Context Hygiene** — 拆小任务、阶段分离、信息结构化
4. **Team Orchestration** — 多代理像团队一样协作
5. **Capability Enhancement** — 安全、记忆、学习、验证闭环
6. **Project Memory** — 文件持久化而非 LLM 记忆

## 命令

```
/oa:propose <name>    → 创建变更提案
/oa:apply <name>      → 执行任务清单
/oa:discuss <phase>   → 讨论阶段
/oa:plan <phase>      → 计划阶段
/oa:execute <phase>   → 执行阶段
/oa:verify <phase>    → 验证阶段
/oa:ship <phase>      → 发布阶段
/oa:brainstorm        → 头脑风暴
/oa:tdd               → 测试驱动开发
/oa:debug             → 系统化调试
/oa:review            → 代码审查
```

## 工作流

### 规格驱动 (OpenSpec)
1. `/oa:propose` → 创建 proposal.md + design.md + specs/ + tasks.md
2. 用户审核确认
3. `/oa:apply` → 按 tasks.md 逐项执行
4. `/oa:archive` → 合并增量规格到 specs/

### 阶段执行 (GSD)
1. `/oa:discuss` → 澄清模糊地带，输出 CONTEXT.md
2. `/oa:plan` → 拆分原子任务，输出执行波次
3. `/oa:execute` → 波次并行执行，每波独立上下文
4. `/oa:verify` → 多维度验证（lint/test/build）
5. `/oa:ship` → 创建 PR

## 技能

- **brainstorming** — 任何创造性工作前必须使用
- **tdd-workflow** — 实现功能或修复 bug 前必须使用
- **systematic-debugging** — 遇到 bug 或测试失败时必须使用
- **code-review** — 完成任务或合并前必须使用
- **worktree-isolation** — 开始功能开发时使用
- **writing-plans** — 有多步任务时在编码前使用
- **verification** — 声称完成前必须使用

## 规则

- 编码规范: rules/coding-standards.md
- 安全规则: rules/security-rules.md
- 提交规则: rules/commit-rules.md
- 审查规则: rules/review-rules.md

## 项目上下文

项目全局上下文: project.md
当前状态: workspace/STATE.md
路线图: workspace/ROADMAP.md
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
