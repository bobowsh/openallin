#!/bin/bash

# OpenAllIn 安装脚本
# 用法: 
#   bash scripts/install.sh claude                    # 安装到当前目录
#   bash scripts/install.sh claude --target dir      # 安装到指定目录
#   bash scripts/install.sh claude dir                # 安装到指定目录（简写）
#   bash scripts/install.sh opencode claude           # 安装多个工具到当前目录
#   bash scripts/install.sh                           # 自动检测当前 CLI 并安装

set -e

HARNESS_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# 解析参数
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
    --target=*)
      TARGET="${arg#*=}"
      ;;
    -t=*)
      TARGET="${arg#*=}"
      ;;
    opencode|claude|cursor|codex|all)
      TOOLS+=("$arg")
      ;;
    *)
      # 其他参数，检查是否是有效路径
      if [ -d "$arg" ] || [ "$arg" = "." ]; then
        TARGET="$arg"
      fi
      ;;
  esac
done

# 如果没有指定工具，自动检测当前 CLI 环境
if [ ${#TOOLS[@]} -eq 0 ]; then
  # 检测当前运行环境
  if [ -n "$OPENCODE" ] || [ -n "$OPENCODE_PROJECT_DIR" ] || [ -d ".opencode" ]; then
    TOOLS=(opencode)
    echo "🔍 检测到 OpenCode 环境"
  elif [ -n "$CLAUDE_CODE" ] || [ -n "$CLAUDE_PROJECT_DIR" ] || [ -d ".claude" ]; then
    TOOLS=(claude)
    echo "🔍 检测到 Claude Code 环境"
  elif [ -n "$CURSOR" ] || [ -n "$CURSOR_PROJECT_DIR" ] || [ -d ".cursor" ]; then
    TOOLS=(cursor)
    echo "🔍 检测到 Cursor 环境"
  elif [ -n "$CODEX" ] || [ -n "$CODEX_PROJECT_DIR" ] || [ -d ".codex" ]; then
    TOOLS=(codex)
    echo "🔍 检测到 Codex 环境"
  elif [ -n "$OPENCLAW" ] || [ -n "$OPENCLAW_PROJECT_DIR" ] || [ -d ".openclaw" ]; then
    TOOLS=(openclaw)
    echo "🔍 检测到 OpenClaw 环境"
  elif [ -n "$GEMINI_CLI" ] || [ -n "$GEMINI_PROJECT_DIR" ] || [ -d ".gemini" ]; then
    TOOLS=(gemini)
    echo "🔍 检测到 Gemini CLI 环境"
  elif [ -n "$WINDSURF" ] || [ -n "$WINDSURF_PROJECT_DIR" ] || [ -d ".windsurf" ]; then
    TOOLS=(windsurf)
    echo "🔍 检测到 Windsurf 环境"
  elif [ -n "$KILO" ] || [ -n "$KILO_PROJECT_DIR" ] || [ -d ".kilo" ]; then
    TOOLS=(kilo)
    echo "🔍 检测到 Kilo Code 环境"
  elif [ -n "$AUGMENT" ] || [ -n "$AUGMENT_PROJECT_DIR" ] || [ -d ".augment" ]; then
    TOOLS=(augment)
    echo "🔍 检测到 Augment 环境"
  elif [ -n "$ZED" ] || [ -n "$ZED_PROJECT_DIR" ] || [ -d ".zed" ]; then
    TOOLS=(zed)
    echo "🔍 检测到 Zed 环境"
  else
    # 默认安装两个最通用的
    TOOLS=(opencode claude)
    echo "🔍 未检测到特定 CLI 环境，安装到 opencode 和 claude"
  fi
fi

echo "🚀 OpenAllIn 安装程序"
echo "===================="
echo "目标目录: $TARGET"
echo "安装工具: ${TOOLS[*]}"
echo ""

# 检测并阻止安装到 home 目录或根目录
EXPANDED_TARGET=$(eval echo "$TARGET")
if [ "$EXPANDED_TARGET" = "$HOME" ] || [ "$EXPANDED_TARGET" = "/" ] || [ "$EXPANDED_TARGET" = "$HOME/" ]; then
  echo "❌ 不允许安装到 home 目录 ($HOME) 或根目录"
  echo ""
  echo "请在项目目录下运行安装："
  echo "  cd your-project && bash scripts/install.sh claude"
  exit 1
fi

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

# 创建必要目录（确保完整性）
mkdir -p tasks/archive .planning

for tool in "${TOOLS[@]}"; do
  case "$tool" in
    opencode)
      echo ""
      echo "🔧 安装到 OpenCode..."

      # 创建 .opencode 目录
      mkdir -p .opencode/{skills,agents,rules,commands}

      # 清理旧的 skills 文件（避免与新格式冲突）
      rm -f .opencode/skills/*.md 2>/dev/null || true

      # 复制 commands（oa-* 命令）— OpenCode 需要 <name>/SKILL.md 格式
      for skill_file in "$HARNESS_DIR/skills/oa-"*.md; do
        [ -f "$skill_file" ] || continue
        name=$(basename "$skill_file" .md)
        mkdir -p ".opencode/skills/$name"
        cp "$skill_file" ".opencode/skills/$name/SKILL.md"
        echo "  ✅ command: $name"
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
      
      # 复制 lib/ 目录（支持库）
      if [ -d "$HARNESS_DIR/lib" ]; then
        cp -rn "$HARNESS_DIR/lib" ".opencode/" 2>/dev/null || true
        echo "  ✅ lib/ 支持库已复制"
      fi

      # 创建/更新 opencode.json
      if [ -f "opencode.json" ]; then
        BAK_FILE="opencode.json.bak.$(date +%Y%m%d_%H%M%S)"
        cp opencode.json "$BAK_FILE"
        echo "  📦 备份已保存: $BAK_FILE"
      fi

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

      # 创建 CLAUDE.md（备份后复制）
      if [ -f "CLAUDE.md" ]; then
        BAK_FILE="CLAUDE.md.bak.$(date +%Y%m%d_%H%M%S)"
        cp CLAUDE.md "$BAK_FILE"
        echo "  📦 备份: CLAUDE.md -> $BAK_FILE"
      fi
      cp "$HARNESS_DIR/AGENTS.md" CLAUDE.md
      echo "  ✅ CLAUDE.md 已创建/更新"

      # 清理旧的 skills 文件（避免与新格式冲突）
      rm -f .claude/skills/*.md 2>/dev/null || true

      # 复制 commands（oa-* 命令）— Claude Code 需要 <name>/SKILL.md 格式
      for skill_file in "$HARNESS_DIR/skills/oa-"*.md; do
        [ -f "$skill_file" ] || continue
        name=$(basename "$skill_file" .md)
        mkdir -p ".claude/skills/$name"
        cp "$skill_file" ".claude/skills/$name/SKILL.md"
        echo "  ✅ command: $name"
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

      # 复制 lib/ 目录（支持库）
      if [ -d "$HARNESS_DIR/lib" ]; then
        cp -rn "$HARNESS_DIR/lib" ".claude/" 2>/dev/null || true
        echo "  ✅ lib/ 支持库已复制"
      fi

      # 复制 hooks 文件（覆盖 stub 或旧版本）
      for hook in "$HARNESS_DIR/hooks/"*.js; do
        [ -f "$hook" ] || continue
        if [ -f ".claude/hooks/$(basename "$hook")" ]; then
          BAK_FILE=".claude/hooks/$(basename "$hook").bak.$(date +%Y%m%d_%H%M%S)"
          cp ".claude/hooks/$(basename "$hook")" "$BAK_FILE"
          echo "  📦 备份: $(basename "$hook") -> $BAK_FILE"
        fi
        cp "$hook" ".claude/hooks/"
        echo "  ✅ hook: $(basename "$hook")"
      done

      # 使用 jq 合并 hooks 配置到 settings.json（保留用户原有配置）
      OA_START='{ "matcher": "", "hooks": [{ "type": "command", "command": "node $CLAUDE_PROJECT_DIR/.claude/hooks/session-start.js" }] }'
      OA_END='{ "matcher": "", "hooks": [{ "type": "command", "command": "node $CLAUDE_PROJECT_DIR/.claude/hooks/session-end.js" }] }'
      OA_PRE='{ "matcher": "", "hooks": [{ "type": "command", "command": "node $CLAUDE_PROJECT_DIR/.claude/hooks/pre-tool-use.js" }] }'
      OA_POST='{ "matcher": "", "hooks": [{ "type": "command", "command": "node $CLAUDE_PROJECT_DIR/.claude/hooks/post-tool-use.js" }] }'

      if [ -f ".claude/settings.json" ]; then
        # settings.json 已存在，备份后合并 hooks（去重）
        BAK_FILE=".claude/settings.json.bak.$(date +%Y%m%d_%H%M%S)"
        cp .claude/settings.json "$BAK_FILE"
        echo "  📦 备份已保存: $BAK_FILE"

        if command -v jq >/dev/null 2>&1; then
          # 检查是否已存在 OpenAllIn hooks，如果存在则跳过合并
          if jq -e '.hooks.SessionStart[] | select(.hooks[].command | contains("session-start.js"))' "$BAK_FILE" >/dev/null 2>&1; then
            echo "  ✅ OpenAllIn hooks 已存在，跳过合并"
          else
            jq \
              --argjson s "$OA_START" \
              --argjson e "$OA_END" \
              --argjson p "$OA_PRE" \
              --argjson o "$OA_POST" \
              '.hooks.SessionStart = (.hooks.SessionStart // []) | .hooks.SessionEnd = (.hooks.SessionEnd // []) | .hooks.PreToolUse = (.hooks.PreToolUse // []) | .hooks.PostToolUse = (.hooks.PostToolUse // []) | .hooks.SessionStart = ([$s] + (.hooks.SessionStart | map(if has("matcher") then . else {matcher:"", hooks: [.]} end))) | .hooks.SessionEnd = ([$e] + (.hooks.SessionEnd | map(if has("matcher") then . else {matcher:"", hooks: [.]} end))) | .hooks.PreToolUse = ([$p] + (.hooks.PreToolUse | map(if has("matcher") then . else {matcher:"", hooks: [.]} end))) | .hooks.PostToolUse = ([$o] + (.hooks.PostToolUse | map(if has("matcher") then . else {matcher:"", hooks: [.]} end)))' \
              "$BAK_FILE" > .claude/settings.json
            echo "  ✅ .claude/settings.json 已更新（OpenAllIn hooks 已合并）"
          fi
        else
          echo "  ⚠️  jq 未安装，无法自动合并 hooks。原始配置已备份，请手动处理。"
        fi
      else
        # settings.json 不存在，创建新的
        cat > .claude/settings.json << EOF
{
  "hooks": {
    "SessionStart": [$OA_START],
    "SessionEnd": [$OA_END],
    "PreToolUse": [$OA_PRE],
    "PostToolUse": [$OA_POST]
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

    openclaw)
      echo ""
      echo "🔧 安装到 OpenClaw..."

      mkdir -p .openclaw/{skills,agents,rules}

      # OpenClaw 技能格式
      for skill_file in "$HARNESS_DIR/skills/oa-"*.md; do
        [ -f "$skill_file" ] || continue
        name=$(basename "$skill_file" .md)
        mkdir -p ".openclaw/skills/$name"
        cp "$skill_file" ".openclaw/skills/$name/SKILL.md"
        echo "  ✅ command: $name"
      done

      # 复制 agents 和 rules
      cp -n "$HARNESS_DIR/agents/"*.md ".openclaw/agents/" 2>/dev/null || true
      cp -n "$HARNESS_DIR/rules/"*.md ".openclaw/rules/" 2>/dev/null || true
      
      # 复制 lib/ 目录（支持库）
      if [ -d "$HARNESS_DIR/lib" ]; then
        cp -rn "$HARNESS_DIR/lib" ".openclaw/" 2>/dev/null || true
        echo "  ✅ lib/ 支持库已复制"
      fi

      echo "  ✅ OpenClaw 安装完成"
      ;;

    gemini)
      echo ""
      echo "🔧 安装到 Gemini CLI..."

      mkdir -p .gemini

      # Gemini CLI 读取 AGENTS.md
      if [ ! -f "AGENTS.md" ]; then
        cp "$HARNESS_DIR/AGENTS.md" .
        echo "  ✅ AGENTS.md 已创建"
      fi

      # 复制 skills
      for skill_file in "$HARNESS_DIR/skills/oa-"*.md; do
        [ -f "$skill_file" ] || continue
        name=$(basename "$skill_file" .md)
        mkdir -p ".gemini/skills/$name"
        cp "$skill_file" ".gemini/skills/$name/SKILL.md"
        echo "  ✅ command: $name"
      done
      
      # 复制 lib/ 目录（支持库）
      if [ -d "$HARNESS_DIR/lib" ]; then
        cp -rn "$HARNESS_DIR/lib" ".gemini/" 2>/dev/null || true
        echo "  ✅ lib/ 支持库已复制"
      fi

      echo "  ✅ Gemini CLI 安装完成"
      ;;

    windsurf)
      echo ""
      echo "🔧 安装到 Windsurf..."

      # Windsurf 读取 AGENTS.md
      if [ ! -f "AGENTS.md" ]; then
        cp "$HARNESS_DIR/AGENTS.md" .
        echo "  ✅ AGENTS.md 已创建"
      fi

      echo "  ✅ Windsurf 安装完成（通过 AGENTS.md 读取指令）"
      ;;

    kilo)
      echo ""
      echo "🔧 安装到 Kilo Code..."

      # Kilo Code 读取 AGENTS.md
      if [ ! -f "AGENTS.md" ]; then
        cp "$HARNESS_DIR/AGENTS.md" .
        echo "  ✅ AGENTS.md 已创建"
      fi

      echo "  ✅ Kilo Code 安装完成（通过 AGENTS.md 读取指令）"
      ;;

    augment)
      echo ""
      echo "🔧 安装到 Augment..."

      # Augment 读取 AGENTS.md
      if [ ! -f "AGENTS.md" ]; then
        cp "$HARNESS_DIR/AGENTS.md" .
        echo "  ✅ AGENTS.md 已创建"
      fi

      echo "  ✅ Augment 安装完成（通过 AGENTS.md 读取指令）"
      ;;

    zed)
      echo ""
      echo "🔧 安装到 Zed..."

      # Zed 读取 AGENTS.md
      if [ ! -f "AGENTS.md" ]; then
        cp "$HARNESS_DIR/AGENTS.md" .
        echo "  ✅ AGENTS.md 已创建"
      fi

      echo "  ✅ Zed 安装完成（通过 AGENTS.md 读取指令）"
      ;;

    *)
      echo "⚠️  未知工具：$tool"
      echo "   支持的工具：opencode, claude, cursor, codex, openclaw, gemini, windsurf, kilo, augment, zed"
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
echo "  3. 输入 /oa-propose <name> 开始第一个变更提案"
echo ""
