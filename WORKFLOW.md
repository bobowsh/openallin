# OpenAllIn 工作流指南

> 从需求到交付的完整路径，6 层能力协同工作

## 总览

```
需求 → [Spec 层] → 规格对齐 → [Skills 层] → 工程纪律 → [Execution 层] → 阶段执行
                                                    ↓
[Workspace 层] ← 项目记忆 ← [Enhancement 层] ← 安全验证 ← [Orchestration 层] ← 团队编排
```

## 场景 1: 个人开发者 — 轻量模式

适合：需求明确、单人开发、快速迭代

### 路径：Spec + Skills

```
1. /oa-brainstorming          → 澄清需求
2. /oa-propose <name>      → 生成 proposal + design + specs + tasks
3. 审核确认
4. /oa-apply <name>        → 按 tasks.md 逐项执行
   ├── 每个任务前自动触发 TDD skill
   ├── 遇到 bug 自动触发 debugging skill
   └── 完成后自动触发 verification skill
5. /oa-verify <phase>      → 最终验证
6. git commit && push
```

**关键点**：
- 不需要阶段化执行（任务本身已足够小）
- 不需要多代理编排（单人单会话）
- 规格是核心资产，必须认真写

---

## 场景 2: 复杂功能 — 阶段模式

适合：需求模糊、长任务、需要多步验证

### 路径：Spec + Execution + Skills

```
Phase 0: 规格
1. /oa-brainstorming          → 探索需求
2. /oa-propose <name>      → 生成变更提案
3. 审核确认

Phase 1: 讨论
4. /oa-discuss <phase>     → 识别模糊地带
   ├── 输出: CONTEXT.md（澄清后的需求）
   └── 回答所有"灰色问题"

Phase 2: 计划
5. /oa-plan <phase>        → 拆分原子任务
   ├── 并行调研不同实现方案
   ├── 计划检查器验证任务质量
   └── 输出: 执行波次计划

Phase 3: 执行
6. /oa-execute <phase>     → 波次执行
   ├── Wave 1: 独立任务（可并行）
   ├── Wave 2: 依赖 Wave 1 的任务
   └── 每个任务独立上下文，原子提交

Phase 4: 验证
7. /oa-verify <phase>      → 多维度验证
   ├── 提取可验证交付物
   ├── 逐项检查
   └── 如有问题 → debug → 修复 → 重新验证

Phase 5: 发布
8. /oa-ship <phase>        → 创建 PR
   └── 自动生成 PR 描述
```

**关键点**：
- 每个阶段输出都是持久化文件
- 阶段之间上下文隔离，防止 context rot
- 可以随时从上次中断处继续（通过 STATE.md 恢复）

---

## 场景 3: 团队协作 — 编排模式

适合：多人并行、长期项目、需要统一标准

### 路径：全层启用

```
Step 1: 规格对齐（Spec 层）
/oa-propose <feature-a>    → 变更 A
/oa-propose <feature-b>    → 变更 B
→ 两个变更独立，可并行开发

Step 2: 团队规划（Orchestration 层）
/oa-team-plan
├── Planner Agent: 评估需求，拆分任务
├── Researcher Agent: 技术方案调研
└── 输出: 任务分配方案

Step 3: 并行执行（Workspace 层 + Execution 层）
/oa-team-exec
├── Worktree A: Implementer Agent → Feature A
├── Worktree B: Implementer Agent → Feature B
└── 每个 worktree 独立上下文、独立分支

Step 4: 质量关卡（Enhancement 层）
/oa-team-verify
├── Reviewer Agent: 代码审查
├── Security Hook: 安全检查
├── Verification: 测试/构建验证
└── Ralph Loop: 自动修复循环

Step 5: 记忆沉淀（Workspace 层）
├── 工作日志自动记录
├── 项目决策沉淀到 memory.json
├── 模式提取到 instincts.json
└── 归档到 changes/archive/
```

**关键点**：
- 每个 agent 有明确角色和工具限制
- Worktree 隔离确保并行不冲突
- Ralph Loop 自动修复常见问题
- 所有产出持久化到文件系统

---

## 技能触发规则

| 场景 | 自动触发技能 |
|------|-------------|
| 开始新功能 | brainstorming → writing-plans |
| 写代码前 | tdd-workflow |
| 测试失败 | systematic-debugging |
| 完成任务 | code-review → verification |
| 开始开发分支 | worktree-isolation |
| 会话启动 | 自动加载 STATE.md + memory.json |
| 会话结束 | 自动保存工作日志 |

---

## 上下文管理策略

### 问题：Context Rot
长对话中 AI 会遗忘、重复犯错、误判因果。

### 解决：四层隔离

1. **阶段隔离**：每个 phase 独立上下文
2. **任务隔离**：每个 task 独立上下文
3. **Agent 隔离**：每个 agent 独立上下文
4. **Worktree 隔离**：每个分支独立文件系统

### 状态传递

```
Phase N 输出文件 → Phase N+1 输入
task-A/CONTEXT.md → plan-phase 读取
task-A/plan.md → execute-phase 读取
task-A/verify-report.md → ship-phase 读取
```

---

## 规格驱动开发详解

### 增量规格系统

```
主规格: specs/auth/spec.md
变更 A: changes/add-2fa/specs/auth/spec.md (ADDED: 2FA)
变更 B: changes/session-timeout/specs/auth/spec.md (MODIFIED: 超时时间)

归档后:
specs/auth/spec.md (包含 2FA + 新超时时间)
```

### 规格格式

```markdown
## Requirement: <需求名>
系统 MUST/SHALL/SHOULD/MAY <行为描述>

#### Scenario: <场景名>
- GIVEN <前置条件>
- WHEN <触发动作>
- THEN <预期结果>
- AND <附加结果>
```

### 关键词含义

| 关键词 | 含义 | 强制程度 |
|--------|------|---------|
| MUST | 必须 | 强制 |
| SHALL | 应该 | 强制 |
| SHOULD | 建议 | 推荐 |
| MAY | 可以 | 可选 |

---

## 配置调优

### 轻量模式（个人/原型）
```json
{
  "mode": "yolo",
  "granularity": "coarse",
  "model_profile": "budget",
  "features": {
    "spec_driven": true,
    "phase_execution": false,
    "team_orchestration": false
  }
}
```

### 标准模式（日常开发）
```json
{
  "mode": "interactive",
  "granularity": "standard",
  "model_profile": "balanced",
  "features": {
    "spec_driven": true,
    "phase_execution": true,
    "team_orchestration": false
  }
}
```

### 生产模式（发布/团队）
```json
{
  "mode": "interactive",
  "granularity": "fine",
  "model_profile": "quality",
  "features": {
    "spec_driven": true,
    "phase_execution": true,
    "team_orchestration": true,
    "security_hooks": true,
    "continuous_learning": true
  }
}
```
