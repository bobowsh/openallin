---
name: oa-ship
description: OpenAllIn /oa-ship 命令 — 发布变更
---

# /oa-ship — 发布变更

当用户输入 `/oa-ship <phase>` 时执行此技能。

## 工作流程

### 1. 最终验证
- 确保所有验证通过
- 检查 CHANGELOG.md 更新

### 2. Git 操作
```bash
git add .
git commit -m "feat: <描述>"
git push
```

### 3. 创建 Pull Request
- 使用 `gh pr create`
- 包含变更描述
- 链接相关 issue

### 4. 输出结果
- PR 链接
- 变更摘要

## 输出

- PR 链接
- 发布确认
