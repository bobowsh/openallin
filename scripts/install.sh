#!/bin/bash

# OpenAllIn 安装脚本
# 用法: bash scripts/install.sh [opencode|claude|cursor|codex|all] [--target dir]

set -e

HARNESS_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# 解析参数: [tool1] [tool2] ... [--target dir]
TOOLS=()
TARGET="."
SKIP_NEXT=false

for arg in "$@"; do
  if [ "$SKIP_NEXT" = true ]; then
    TARGET="$arg"
    SKIP_NEXT=false
    continue
  fi
  if [ "$arg" = "--target" ] || [ "$arg" = "-t" ]; then
    SKIP_NEXT=true
    continue
  fi
  # Handle --target=value format
  case "$arg" in
    --target=*|-t=*)
      TARGET="${arg#*=}"
      ;;
    *)
      TOOLS+=("$arg")
      ;;
  esac
done

# 如果没有指定工具，默认安装所有
if [ ${#TOOLS[@]} -eq 0 ] || ([ ${#TOOLS[@]} -eq 1 ] && [ "${TOOLS[0]}" = "all" ]); then
  TOOLS=(opencode claude)
fi

echo "🚀 OpenAllIn 安装程序"
echo "===================="
echo "目标目录: $TARGET"
echo "安装工具: ${TOOLS[*]}"
echo ""

if [ ! -d "$TARGET" ]; then
  echo "❌ 目标目录不存在: $TARGET"
  exit 1
fi

cd "$TARGET"

# 复制公共文件
echo "📁 复制公共文件..."
[ ! -f "AGENTS.md" ] && cp "$HARNESS_DIR/AGENTS.md" .
[ ! -f "project.md" ] && cp "$HARNESS_DIR/project.md" .
cp -rn "$HARNESS_DIR/specs" . 2>/dev/null || true
cp -rn "$HARNESS_DIR/changes" . 2>/dev/null || true
cp -rn "$HARNESS_DIR/config" . 2>/dev/null || true
cp -rn "$HARNESS_DIR/workspace" . 2>/dev/null || true
cp -rn "$HARNESS_DIR/templates" . 2>/dev/null || true
cp -rn "$HARNESS_DIR/scripts" . 2>/dev/null || true
cp -rn "$HARNESS_DIR/rules" . 2>/dev/null || true

for tool in "${TOOLS[@]}"; do
  case "$tool" in
    opencode)
      echo ""
      echo "🔧 安装到 OpenCode..."

      # 创建 .opencode 目录
      mkdir -p .opencode/{skills,agents,rules,commands}

      # 转换 skills 格式
      for skill in "$HARNESS_DIR/skills/"*.md; do
        [ -f "$skill" ] || continue
        name=$(basename "$skill" .md)
        skill_dir=".opencode/skills/$name"
        mkdir -p "$skill_dir"

        if [ ! -f "$skill_dir/SKILL.md" ]; then
          cat > "$skill_dir/SKILL.md" << EOF
---
name: $name
description: OpenAllIn $name skill — 工程方法论技能
---

$(cat "$skill")
EOF
          echo "  ✅ skill: $name"
        fi
      done

      # 复制 agents
      for agent in "$HARNESS_DIR/agents/"*.md; do
        [ -f "$agent" ] || continue
        name=$(basename "$agent" .md)
        if [ ! -f ".opencode/agents/$name.md" ]; then
          cp "$agent" ".opencode/agents/"
          echo "  ✅ agent: $name"
        fi
      done

      # 复制 rules
      for rule in "$HARNESS_DIR/rules/"*.md; do
        [ -f "$rule" ] || continue
        if [ ! -f ".opencode/rules/$(basename "$rule")" ]; then
          cp "$rule" ".opencode/rules/"
          echo "  ✅ rule: $(basename "$rule")"
        fi
      done

      # 创建/更新 opencode.json
      if [ ! -f "opencode.json" ]; then
        cat > opencode.json << 'EOF'
{
  "instructions": ["AGENTS.md", "project.md"],
  "permission": {
    "skill": {
      "*": "allow"
    }
  }
}
EOF
        echo "  ✅ opencode.json 已创建"
      fi
      ;;

    claude)
      echo ""
      echo "🔧 安装到 Claude Code..."

      # 创建 .claude 目录
      mkdir -p .claude/{rules,skills,agents,hooks}

      # 创建 CLAUDE.md（如果不存在）
      if [ ! -f "CLAUDE.md" ]; then
        cp "$HARNESS_DIR/AGENTS.md" CLAUDE.md
        echo "  ✅ CLAUDE.md 已创建"
      fi

      # 转换 skills 格式
      for skill in "$HARNESS_DIR/skills/"*.md; do
        [ -f "$skill" ] || continue
        name=$(basename "$skill" .md)
        skill_dir=".claude/skills/$name"
        mkdir -p "$skill_dir"

        if [ ! -f "$skill_dir/SKILL.md" ]; then
          cat > "$skill_dir/SKILL.md" << EOF
---
name: $name
description: OpenAllIn $name skill — 工程方法论技能
---

$(cat "$skill")
EOF
          echo "  ✅ skill: $name"
        fi
      done

      # 复制 agents
      for agent in "$HARNESS_DIR/agents/"*.md; do
        [ -f "$agent" ] || continue
        if [ ! -f ".claude/agents/$(basename "$agent")" ]; then
          cp "$agent" ".claude/agents/"
          echo "  ✅ agent: $(basename "$agent")"
        fi
      done

      # 复制 rules
      for rule in "$HARNESS_DIR/rules/"*.md; do
        [ -f "$rule" ] || continue
        if [ ! -f ".claude/rules/$(basename "$rule")" ]; then
          cp "$rule" ".claude/rules/"
          echo "  ✅ rule: $(basename "$rule")"
        fi
      done

      # 复制 hooks
      for hook in "$HARNESS_DIR/hooks/"*.js; do
        [ -f "$hook" ] || continue
        if [ ! -f ".claude/hooks/$(basename "$hook")" ]; then
          cp "$hook" ".claude/hooks/"
          echo "  ✅ hook: $(basename "$hook")"
        fi
      done

      # 创建/更新 .claude/settings.json
      if [ ! -f ".claude/settings.json" ]; then
        cat > .claude/settings.json << 'EOF'
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
        echo "  ✅ .claude/settings.json 已创建（含 hooks 配置）"
      fi
      ;;

    cursor)
      echo ""
      echo "🔧 安装到 Cursor..."

      mkdir -p .cursor/rules

      # Cursor 读取 .cursor/rules/ 下的 .mdc 文件
      cat > .cursor/rules/openallin.mdc << EOF
---
description: OpenAllIn 统一工程框架
globs: **/*
---

$(cat "$HARNESS_DIR/AGENTS.md")
EOF
      echo "  ✅ .cursor/rules/openallin.mdc 已创建"
      ;;

    codex)
      echo ""
      echo "🔧 安装到 Codex..."

      # Codex 读取 AGENTS.md
      if [ ! -f "AGENTS.md" ]; then
        cp "$HARNESS_DIR/AGENTS.md" .
        echo "  ✅ AGENTS.md 已创建"
      fi

      mkdir -p .codex
      echo "  ✅ Codex 安装完成（通过 AGENTS.md 读取指令）"
      ;;

    *)
      echo "⚠️  未知工具: $tool"
      echo "   支持的工具: opencode, claude, cursor, codex"
      ;;
  esac
done

echo ""
echo "✅ OpenAllIn 安装完成!"
echo ""
echo "已安装到: $TARGET"
echo "已启用工具: ${TOOLS[*]}"
echo ""
echo "下一步:"
echo "  1. 编辑 project.md 填入你的项目信息"
echo "  2. 启动你的 AI 编码工具"
echo "  3. 输入 /oa:propose <name> 开始第一个变更提案"
echo ""
