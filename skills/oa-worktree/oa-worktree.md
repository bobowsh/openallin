---
name: oa-worktree
description: OpenAllIn /oa:worktree 命令 — Git Worktree 隔离
---

# /oa:worktree — Git Worktree 隔离

当用户输入 `/oa:worktree` 时执行此技能。

## 工作流程

### 1. 检查当前状态
- 查看现有 worktrees
- 检查分支状态

### 2. 创建新 Worktree
```bash
# 创建新分支和新 worktree
git worktree add -b feature/<name> ../worktree-<name> main
```

### 3. 切换到 Worktree
```bash
cd ../worktree-<name>
```

### 4. 工作完成后
```bash
# 合并回主分支
git checkout main
git merge worktree-<name>
# 删除 worktree
git worktree remove worktree-<name>
```

## 输出

- 新 worktree 路径
- 工作指引

## 注意事项

- 使用 worktree 隔离功能开发
- 避免在主分支直接开发
- 完成工作后及时合并和清理
