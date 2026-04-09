---
name: oa-archive
description: OpenAllIn /oa-archive 命令 — 归档变更并合并到规格库
---

# /oa-archive — 归档变更并合并到规格库

当用户输入 `/oa-archive <name>` 时执行此技能。

## 工作流程

### 1. 解析变更名称
- 从命令参数提取变更名称
- 格式：`/oa-archive add-user-login`

### 2. 验证变更完成
- 检查 `changes/<name>/tasks/tasks.md` 中所有任务是否完成
- 如果有未完成任务，提示用户先完成

### 3. 运行归档脚本
如果 `scripts/archive-change.sh` 存在，运行它：
```bash
bash scripts/archive-change.sh <name>
```

### 4. 手动归档步骤
如果没有脚本，手动执行：

#### 4.1 合并 specs 到规格库
```bash
cp -r changes/<name>/specs/* specs/
```

#### 4.2 更新变更状态
- 移动 `changes/<name>` 到 `changes/archive/<name>-<date>/`

#### 4.3 更新 CHANGELOG.md
添加新条目：
```markdown
## <date> - <name>

- 描述变更内容
- 影响范围
```

### 5. 清理
- 确认归档完成后，可以删除 `changes/<name>`

## 输出

- 归档结果报告
- specs/ 变更摘要
- CHANGELOG.md 更新内容
