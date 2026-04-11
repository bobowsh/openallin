#!/bin/bash

# OpenAllIn 更新脚本
# 用法: 
#   bash scripts/update.sh                    # 更新当前项目
#   bash scripts/update.sh --target dir       # 更新指定目录
#   bash scripts/update.sh --dry-run          # 预览将更新的内容
#   bash scripts/update.sh --force            # 强制覆盖所有文件

set -e

echo "🔄 OpenAllIn 更新程序"
echo "======================"

HARNESS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="."
DRY_RUN=false
FORCE=false
SKIP_NEXT=false

# 解析参数
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
  case "$arg" in
    --target=*)
      TARGET="${arg#*=}"
      ;;
    --dry-run)
      DRY_RUN=true
      ;;
    --force|-f)
      FORCE=true
      ;;
    *)
      if [ -d "$arg" ]; then
        TARGET="$arg"
      fi
      ;;
  esac
done

# 检测并阻止在 home 目录更新
EXPANDED_TARGET=$(eval echo "$TARGET")
if [ "$EXPANDED_TARGET" = "$HOME" ] || [ "$EXPANDED_TARGET" = "/" ]; then
  echo "❌ 不允许在 home 目录或根目录更新"
  exit 1
fi

if [ ! -d "$TARGET" ]; then
  echo "❌ 目标目录不存在：$TARGET"
  exit 1
fi

cd "$TARGET"

# 检查是否安装了 OpenAllIn
if [ ! -f "AGENTS.md" ] && [ ! -f "CLAUDE.md" ] && [ ! -d ".claude" ] && [ ! -d ".opencode" ]; then
  echo "⚠️  未检测到 OpenAllIn 安装"
  echo ""
  echo "请先运行安装："
  echo "  bash $HARNESS_DIR/scripts/install.sh"
  exit 1
fi

echo "目标目录：$TARGET"
echo ""

# 备份函数
backup_file() {
  local file="$1"
  if [ -f "$file" ]; then
    BAK_FILE="$file.bak.$(date +%Y%m%d_%H%M%S)"
    cp "$file" "$BAK_FILE"
    echo "  📦 备份：$file -> $BAK_FILE"
  fi
}

# 更新文件函数（如果目标文件存在且不同则更新）
update_file() {
  local src="$1"
  local dst="$2"
  local force="${3:-false}"
  
  if [ ! -f "$src" ]; then
    return
  fi
  
  if [ ! -f "$dst" ] || [ "$force" = true ] || ! diff -q "$src" "$dst" > /dev/null 2>&1; then
    if [ "$DRY_RUN" = true ]; then
      echo "  🔄 将更新：$dst"
    else
      if [ -f "$dst" ]; then
        backup_file "$dst"
      fi
      cp "$src" "$dst"
      echo "  ✅ 已更新：$dst"
    fi
  fi
}

# 更新目录函数
update_dir() {
  local src="$1"
  local dst="$2"
  
  if [ ! -d "$src" ]; then
    return
  fi
  
  if [ "$DRY_RUN" = true ]; then
    echo "  🔄 将同步：$dst/"
  else
    cp -rn "$src" "$dst" 2>/dev/null || true
    echo "  ✅ 已同步：$dst/"
  fi
}

# 检测已安装的工具
INSTALLED_TOOLS=()
[ -d ".opencode" ] && INSTALLED_TOOLS+=( "opencode" )
[ -d ".claude" ] && INSTALLED_TOOLS+=( "claude" )
[ -d ".cursor" ] && INSTALLED_TOOLS+=( "cursor" )
[ -d ".codex" ] && INSTALLED_TOOLS+=( "codex" )
[ -d ".openclaw" ] && INSTALLED_TOOLS+=( "openclaw" )
[ -d ".gemini" ] && INSTALLED_TOOLS+=( "gemini" )

if [ ${#INSTALLED_TOOLS[@]} -eq 0 ]; then
  echo "⚠️  未检测到已安装的工具"
  exit 1
fi

echo "检测到已安装的工具：${INSTALLED_TOOLS[*]}"
echo ""

# 更新统计
UPDATED=0
SKIPPED=0

echo "开始更新..."
echo ""

# 更新公共文件
echo "📁 公共文件:"
update_file "$HARNESS_DIR/AGENTS.md" "AGENTS.md" "$FORCE"
[ $? -eq 0 ] && ((UPDATED++)) || ((SKIPPED++))

if [ ! -f "project.md" ]; then
  if [ "$DRY_RUN" = true ]; then
    echo "  📄 将创建：project.md"
  else
    cp "$HARNESS_DIR/project.md" "project.md"
    echo "  ✅ 已创建：project.md"
    ((UPDATED++))
  fi
else
  if [ "$FORCE" = true ]; then
    update_file "$HARNESS_DIR/project.md" "project.md" true
    ((UPDATED++))
  else
    echo "  ⏭️  跳过：project.md (保留用户自定义)"
    ((SKIPPED++))
  fi
fi

# 更新各工具的 skills
for tool in "${INSTALLED_TOOLS[@]}"; do
  echo ""
  case "$tool" in
    opencode)
      echo "🔧 OpenCode skills:"
      if [ -d ".opencode/skills" ]; then
        # 删除旧的 skills 格式（如果是单个 .md 文件）
        find ".opencode/skills" -maxdepth 1 -name "oa-*.md" -delete 2>/dev/null || true
        
        # 复制新格式（<name>/SKILL.md）
        for skill_file in "$HARNESS_DIR/skills/oa-"*.md; do
          [ -f "$skill_file" ] || continue
          name=$(basename "$skill_file" .md)
          skill_dir=".opencode/skills/$name"
          if [ ! -d "$skill_dir" ] || [ "$FORCE" = true ]; then
            if [ "$DRY_RUN" = true ]; then
              echo "  🔄 将更新：$skill_dir/SKILL.md"
            else
              rm -rf "$skill_dir" 2>/dev/null || true
              mkdir -p "$skill_dir"
              cp "$skill_file" "$skill_dir/SKILL.md"
              echo "  ✅ 已更新：$name"
              ((UPDATED++))
            fi
          fi
        done
      fi
      
      # 更新 agents
      if [ -d ".opencode/agents" ]; then
        for agent in "$HARNESS_DIR/agents/"*.md; do
          [ -f "$agent" ] || continue
          update_file "$agent" ".opencode/agents/$(basename "$agent")" "$FORCE"
        done
      fi
      
      # 更新 rules
      if [ -d ".opencode/rules" ]; then
        for rule in "$HARNESS_DIR/rules/"*.md; do
          [ -f "$rule" ] || continue
          update_file "$rule" ".opencode/rules/$(basename "$rule")" "$FORCE"
        done
      fi
      
      # 更新 lib/
      if [ -d "$HARNESS_DIR/lib" ]; then
        if [ "$DRY_RUN" = true ]; then
          echo "  🔄 将同步：.opencode/lib/"
        else
          cp -rn "$HARNESS_DIR/lib" ".opencode/" 2>/dev/null || true
          echo "  ✅ 已同步：.opencode/lib/"
        fi
      fi
      ;;
    
    claude)
      echo "🔧 Claude Code skills:"
      if [ -d ".claude/skills" ]; then
        # 删除旧的 skills 格式
        find ".claude/skills" -maxdepth 1 -name "oa-*.md" -delete 2>/dev/null || true
        
        # 复制新格式
        for skill_file in "$HARNESS_DIR/skills/oa-"*.md; do
          [ -f "$skill_file" ] || continue
          name=$(basename "$skill_file" .md)
          skill_dir=".claude/skills/$name"
          if [ ! -d "$skill_dir" ] || [ "$FORCE" = true ]; then
            if [ "$DRY_RUN" = true ]; then
              echo "  🔄 将更新：$skill_dir/SKILL.md"
            else
              rm -rf "$skill_dir" 2>/dev/null || true
              mkdir -p "$skill_dir"
              cp "$skill_file" "$skill_dir/SKILL.md"
              echo "  ✅ 已更新：$name"
              ((UPDATED++))
            fi
          fi
        done
      fi
      
      # 更新 agents
      if [ -d ".claude/agents" ]; then
        for agent in "$HARNESS_DIR/agents/"*.md; do
          [ -f "$agent" ] || continue
          update_file "$agent" ".claude/agents/$(basename "$agent")" "$FORCE"
        done
      fi
      
      # 更新 rules
      if [ -d ".claude/rules" ]; then
        for rule in "$HARNESS_DIR/rules/"*.md; do
          [ -f "$rule" ] || continue
          update_file "$rule" ".claude/rules/$(basename "$rule")" "$FORCE"
        done
      fi
      
      # 更新 hooks
      if [ -d ".claude/hooks" ]; then
        for hook in "$HARNESS_DIR/hooks/"*.js; do
          [ -f "$hook" ] || continue
          update_file "$hook" ".claude/hooks/$(basename "$hook")" "$FORCE"
        done
      fi
      
      # 更新 lib/
      if [ -d "$HARNESS_DIR/lib" ]; then
        if [ "$DRY_RUN" = true ]; then
          echo "  🔄 将同步：.claude/lib/"
        else
          cp -rn "$HARNESS_DIR/lib" ".claude/" 2>/dev/null || true
          echo "  ✅ 已同步：.claude/lib/"
        fi
      fi
      ;;
    
    cursor)
      echo "🔧 Cursor rules:"
      if [ -f ".cursor/rules/openallin.mdc" ]; then
        if [ "$DRY_RUN" = true ]; then
          echo "  🔄 将更新：.cursor/rules/openallin.mdc"
        else
          cat > ".cursor/rules/openallin.mdc" << EOF
---
description: OpenAllIn 统一工程框架
globs: **/*
---

$(cat "$HARNESS_DIR/AGENTS.md")
EOF
          echo "  ✅ 已更新：.cursor/rules/openallin.mdc"
          ((UPDATED++))
        fi
      fi
      ;;
    
    codex|openclaw|gemini)
      echo "🔧 $tool:"
      # 更新 skills
      skill_dir=".$tool/skills"
      if [ -d "$skill_dir" ]; then
        for skill_file in "$HARNESS_DIR/skills/oa-"*.md; do
          [ -f "$skill_file" ] || continue
          name=$(basename "$skill_file" .md)
          skill_path="$skill_dir/$name"
          if [ ! -d "$skill_path" ] || [ "$FORCE" = true ]; then
            if [ "$DRY_RUN" = true ]; then
              echo "  🔄 将更新：$skill_path/SKILL.md"
            else
              rm -rf "$skill_path" 2>/dev/null || true
              mkdir -p "$skill_path"
              cp "$skill_file" "$skill_path/SKILL.md"
              echo "  ✅ 已更新：$name"
              ((UPDATED++))
            fi
          fi
        done
      fi
      
      # 更新 lib/
      if [ -d "$HARNESS_DIR/lib" ]; then
        if [ "$DRY_RUN" = true ]; then
          echo "  🔄 将同步：$skill_dir/lib/"
        else
          cp -rn "$HARNESS_DIR/lib" "$skill_dir/" 2>/dev/null || true
          echo "  ✅ 已同步：$skill_dir/lib/"
        fi
      fi
      ;;
  esac
done

# 更新 workspace 模板
if [ -d "workspace" ] && [ -d "$HARNESS_DIR/workspace" ]; then
  echo ""
  echo "📁 Workspace 模板:"
  for template in "$HARNESS_DIR/workspace/"*.md; do
    [ -f "$template" ] || continue
    update_file "$template" "workspace/$(basename "$template")" "$FORCE"
  done
fi

# 更新 templates
if [ -d "templates" ] && [ -d "$HARNESS_DIR/templates" ]; then
  echo ""
  echo "📁 Templates:"
  update_dir "$HARNESS_DIR/templates" "templates"
fi

# 更新 CHANGELOG.md（如果存在）
if [ -f "$HARNESS_DIR/CHANGELOG.md" ]; then
  echo ""
  echo "📁 CHANGELOG:"
  update_file "$HARNESS_DIR/CHANGELOG.md" "CHANGELOG.md" "$FORCE"
fi

# 总结
echo ""
echo "======================"
echo "更新完成!"
echo ""
echo "统计:"
echo "  已更新：$UPDATED 个文件/目录"
echo "  已跳过：$SKIPPED 个文件/目录"
echo ""

if [ "$DRY_RUN" = true ]; then
  echo "⚠️  这是预览模式，没有实际更新任何文件"
  echo ""
  echo "要实际执行更新，请运行："
  echo "  bash scripts/update.sh"
  echo ""
  echo "要强制覆盖所有文件（包括自定义配置），请运行："
  echo "  bash scripts/update.sh --force"
else
  echo "✅ 更新成功!"
  echo ""
  echo "备份文件已保存为 .bak.* 格式，确认更新无误后可以删除"
fi
