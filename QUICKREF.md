# OpenAllIn 快速参考卡

> 一页纸记住所有命令、文件和规则

## 命令速查 (16 个)

| 命令 | 用途 | 触发层 | 多轮迭代 |
|------|------|--------|----------|
| `/oa-propose <name>` | 创建变更提案 | Spec | - |
| `/oa-apply <name>` | 执行任务清单 | Spec | - |
| `/oa-validate <name>` | 验证规格格式 | Spec | - |
| `/oa-archive <name>` | 归档变更并合并规格 | Spec | - |
| `/oa-discuss` | 讨论澄清需求 | Execution | ✅ 5轮 |
| `/oa-plan` | 计划原子任务 | Execution | - |
| `/oa-execute` | 波次并行执行 | Execution | - |
| `/oa-verify` | 多维度验证 | Execution | - |
| `/oa-ship` | 创建 PR 发布 | Execution | - |
| `/oa-brainstorming` | 头脑风暴 | Skills | ✅ 5轮 |
| `/oa-debugging` | 系统化调试 | Skills | ✅ 5轮 |
| `/oa-writing-plans` | 计划编写 | Skills | ✅ 4轮 |
| `/oa-worktree` | Git Worktree 隔离 | Skills | - |
| `/oa-team-plan` | 团队规划 | Orchestration | - |
| `/oa-team-exec` | 团队执行 | Orchestration | - |
| `/oa-team-verify` | 团队验证 | Orchestration | - |

## 关键文件

| 文件 | 层 | 用途 |
|------|-----|------|
| `project.md` | Spec | 项目全局上下文 |
| `specs/*/spec.md` | Spec | 系统行为规格 |
| `changes/<name>/proposal.md` | Spec | 变更动机 |
| `changes/<name>/design.md` | Spec | 技术方案 |
| `changes/<name>/tasks.md` | Spec | 任务清单 |
| `skills/oa-*/` | Skills | CLI 命令（oa-propose, oa-brainstorming 等）|
| `workspace/STATE.md` | Workspace | 当前执行状态 |
| `workspace/ROADMAP.md` | Workspace | 项目路线图 |
| `config/settings.json` | Enhancement | 全局配置 |
| `config/memory.json` | Enhancement | 项目记忆 |
| `hooks/hooks.json` | Enhancement | Hook 注册 |

## 规格关键词

| 关键词 | 强制度 | 示例 |
|--------|--------|------|
| MUST | 必须 | 系统 MUST 验证输入 |
| SHALL | 应该 | 系统 SHALL 返回 JWT |
| SHOULD | 建议 | 系统 SHOULD 记录日志 |
| MAY | 可选 | 系统 MAY 缓存结果 |

## 场景格式

```markdown
#### Scenario: <场景名>
- GIVEN <前置条件>
- WHEN <触发动作>
- THEN <预期结果>
- AND <附加结果>
```

## 技能触发

| 场景 | 技能 |
|------|------|
| 新功能/创意工作 | brainstorming |
| 写代码前 | tdd-workflow |
| Bug/测试失败 | systematic-debugging |
| 任务完成 | code-review |
| 开始分支 | worktree-isolation |
| 多步任务 | writing-plans |
| 声称完成前 | verification |

## 配置预设

| 模式 | 适用场景 |
|------|---------|
| yolo + coarse + budget | 原型/快速验证 |
| interactive + standard + balanced | 日常开发 |
| interactive + fine + quality | 生产发布 |

## 采用路径

```
Week 1-2:  Spec + Skills        → 养成习惯
Week 2-4:  + Execution           → 解决长任务
Week 4-8:  + Orchestration      → 团队协作
           + Workspace           → 项目记忆
Continuous: + Enhancement       → 安全/学习
```

## 黄金法则

1. **规格先行** — 需求没对齐不写代码
2. **证据优先** — 验证命令输出再声称成功
3. **上下文清洁** — 拆小任务，阶段分离
4. **纪律默认** — 技能自动触发，不可跳过
5. **文件即记忆** — 所有状态持久化
6. **角色分离** — 决策和执行用不同 agent
