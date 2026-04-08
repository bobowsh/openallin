#!/bin/bash

# 规格验证脚本
# 检查 spec.md 文件格式是否符合规范

set -e

SPEC_FILE="${1:-}"

if [ -z "$SPEC_FILE" ]; then
  echo "用法: $0 <spec-file>"
  echo "  验证规格文件格式"
  exit 1
fi

if [ ! -f "$SPEC_FILE" ]; then
  echo "❌ 文件不存在: $SPEC_FILE"
  exit 1
fi

ERRORS=0

echo "🔍 验证规格: $SPEC_FILE"
echo "---"

# 检查 RFC 2119 关键词
if grep -qE '\b(MUST|SHALL|SHOULD|MAY|SHALL NOT|SHOULD NOT)\b' "$SPEC_FILE"; then
  echo "✅ 包含 RFC 2119 关键词"
else
  echo "⚠️  缺少 RFC 2119 关键词 (MUST/SHALL/SHOULD/MAY)"
  ERRORS=$((ERRORS + 1))
fi

# 检查 Scenario 格式
if grep -qE '^#### Scenario:' "$SPEC_FILE"; then
  echo "✅ 包含 Scenario 格式"
else
  echo "⚠️  缺少 Scenario 格式 (#### Scenario: <name>)"
  ERRORS=$((ERRORS + 1))
fi

# 检查 Gherkin 关键词
if grep -qE '\b(GIVEN|WHEN|THEN|AND)\b' "$SPEC_FILE"; then
  echo "✅ 包含 Gherkin 关键词"
else
  echo "⚠️  缺少 Gherkin 关键词 (GIVEN/WHEN/THEN/AND)"
  ERRORS=$((ERRORS + 1))
fi

# 检查 Requirement 格式
if grep -qE '^## (ADDED |MODIFIED |REMOVED )?Requirement:' "$SPEC_FILE"; then
  echo "✅ 包含 Requirement 格式"
else
  echo "⚠️  缺少 Requirement 格式"
  ERRORS=$((ERRORS + 1))
fi

echo "---"
if [ $ERRORS -eq 0 ]; then
  echo "✅ 规格验证通过"
  exit 0
else
  echo "⚠️  发现 $ERRORS 个问题"
  exit 1
fi
