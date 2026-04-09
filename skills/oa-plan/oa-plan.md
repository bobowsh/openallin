---
name: oa-plan
description: OpenAllIn /oa:plan 命令 — 规划执行任务
---

# /oa:plan — 规划执行任务

当用户输入 `/oa:plan <phase>` 时执行此技能。

## 工作流程

### 1. 分析 CONTEXT
读取 `workspace/CONTEXT.md` 了解需求和约束。

### 2. 拆分原子任务
- 将需求拆分为独立、可测试的小任务
- 每个任务应该有明确的完成标准

### 3. 规划执行波次
- 确定任务依赖关系
- 将独立任务分组为波次
- 每波任务可以并行执行

### 4. 输出执行计划
创建 `workspace/PLAN.md`：
```markdown
# 执行计划

## 波次 1
- [ ] 任务 1.1
- [ ] 任务 1.2

## 波次 2
- [ ] 任务 2.1
- ...
```

## 输出

- `workspace/PLAN.md` — 执行计划和波次安排
