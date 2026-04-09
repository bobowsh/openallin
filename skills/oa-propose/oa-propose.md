---
name: oa-propose
description: OpenAllIn /oa-propose 命令 — 创建变更提案
---

# /oa-propose — 创建变更提案

当用户输入 `/oa-propose <name>` 时执行此技能。

## 工作流程

### 1. 解析提案名称
- 从命令参数提取提案名称
- 格式：`/oa-propose add-user-login`

### 2. 创建变更目录结构
```
changes/<name>/
├── proposal/proposal.md    # 提案文档
├── design/design.md        # 设计文档
├── specs/                   # 规格文档
│   └── api.md
└── tasks/tasks.md          # 任务清单
```

### 3. 生成提案模板

创建 `changes/<name>/proposal/proposal.md`：
```markdown
# 变更提案: <name>

> 创建时间: YYYY-MM-DD

## 概述
[简要描述此变更的目的和动机]

## 需求分析
### 用户故事
- 作为 [角色]，我希望 [功能]，以便 [收益]

## 验收标准
- [ ]

## 影响范围
- 
```

### 4. 生成设计模板

创建 `changes/<name>/design/design.md`：
```markdown
# 设计方案: <name>

## 架构设计

## 接口设计

## 数据模型

## 实现计划
```

### 5. 生成任务模板

创建 `changes/<name>/tasks/tasks.md`：
```markdown
# 任务清单: <name>

## 任务列表
- [ ] 任务 1
- [ ] 任务 2

## 执行记录
| 时间 | 任务 | 状态 |
```

## 输出

- 创建完整的变更目录结构
- 输出下一步操作指引

## 注意事项

- 如果变更已存在，提示用户并退出
- 使用 `set -e` 确保失败时停止
- 时间使用 ISO 8601 格式 (UTC)
