---
name: oa-validate
description: OpenAllIn /oa:validate 命令 — 验证规格文档格式
---

# /oa:validate — 验证规格文档格式

当用户输入 `/oa:validate <name>` 时执行此技能。

## 工作流程

### 1. 解析变更名称
- 从命令参数提取变更名称
- 格式：`/oa:validate add-user-login`

### 2. 验证目录结构
检查 `changes/<name>/` 是否包含：
- `proposal/proposal.md`
- `design/design.md`
- `specs/`
- `tasks/tasks.md`

### 3. 验证文档内容
对每个文档检查：
- 非空内容
- 包含必要的章节（概述、验收标准等）
- 格式正确

### 4. 运行脚本验证
如果 `scripts/validate-spec.sh` 存在，运行它：
```bash
bash scripts/validate-spec.sh changes/<name>
```

### 5. 输出结果
- 验证通过：输出 ✅
- 验证失败：列出所有问题

## 输出

- 验证结果报告
- 失败时列出具体问题和建议修复方案
