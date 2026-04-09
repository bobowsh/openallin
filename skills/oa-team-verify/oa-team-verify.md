---
name: oa-team-verify
description: OpenAllIn /oa-team-verify 命令 — 团队验证
---

# /oa-team-verify — 团队验证

当用户输入 `/oa-team-verify` 时执行此技能。

## 工作流程

### 1. 合并 Worktrees
将各成员的工作合并到主分支。

### 2. 团队代码审查
- reviewer 角色进行整体审查
- 检查代码质量和一致性

### 3. 安全检查
- 运行安全扫描
- 检查依赖漏洞

### 4. 集成测试
- 合并后运行完整测试套件
- 验证所有功能正常

### 5. 输出报告
```markdown
# 团队验证报告

## ✅ 代码审查通过
## ✅ 安全检查通过
## ✅ 集成测试通过

## 可以发布
```
