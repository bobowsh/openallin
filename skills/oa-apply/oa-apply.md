---
name: oa-apply
description: OpenAllIn /oa-apply 命令 — 执行变更任务清单
---

# /oa-apply — 执行变更任务清单

当用户输入 `/oa-apply <name>` 时执行此技能。

## 工作流程

### 1. 解析变更名称
- 从命令参数提取变更名称
- 格式：`/oa-apply add-user-login`

### 2. 验证变更存在
- 检查 `changes/<name>/tasks/tasks.md` 是否存在
- 如果不存在，提示用户先运行 `/oa-propose <name>`

### 3. 读取任务清单
打开 `changes/<name>/tasks/tasks.md`，按顺序执行未完成的任务。

### 4. 执行任务
对每个未完成的任务：
1. 明确任务内容
2. 执行实现
3. 更新任务清单（标记为完成）
4. 记录执行时间和结果

### 5. 完成确认
- 所有任务完成后，输出总结
- 提示可以运行 `/oa-archive <name>` 归档

## 输出

- 更新 `changes/<name>/tasks/tasks.md`
- 报告执行进度和结果

## 注意事项

- 按顺序执行，不要跳步
- 每次只执行一个任务
- 完成后立即更新任务清单
