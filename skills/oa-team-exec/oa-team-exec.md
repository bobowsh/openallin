---
name: oa-team-exec
description: OpenAllIn /oa:team-exec 命令 — 团队并行执行
---

# /oa:team-exec — 团队并行执行

当用户输入 `/oa:team-exec` 时执行此技能。

## 工作流程

### 1. 读取团队计划
打开 `workspace/TEAM-PLAN.md`。

### 2. 创建 Git Worktrees
为每个成员创建独立的工作树：
```bash
git worktree add ../feature-1 feature-branch
git worktree add ../feature-2 feature-branch
```

### 3. 并行执行
- 各成员在独立 worktree 中工作
- 通过 `workspace/journals/` 同步进度

### 4. 定期同步
- 合并完成的 worktree
- 解决冲突

## 输出

- worktree 状态
- 进度报告

## 注意事项

- 每个 worktree 独立，避免相互干扰
- 定期合并以避免大幅偏离主分支
