#!/usr/bin/env node

/**
 * Session End Hook
 * 在会话结束时持久化状态
 */

const fs = require('fs');
const path = require('path');

const HARNESS_DIR = process.env.CLAUDE_PROJECT_DIR
  ? path.resolve(process.env.CLAUDE_PROJECT_DIR)
  : path.resolve(__dirname, '..');

function saveState(sessionSummary) {
  const workspaceDir = path.join(HARNESS_DIR, 'workspace');
  const journalsDir = path.join(workspaceDir, 'journals');

  // 确保目录存在
  if (!fs.existsSync(journalsDir)) {
    fs.mkdirSync(journalsDir, { recursive: true });
  }

  // 保存工作日志
  const today = new Date().toISOString().split('T')[0];
  const journalPath = path.join(journalsDir, `journal-${today}.md`);

  let journal = '';
  if (fs.existsSync(journalPath)) {
    journal = fs.readFileSync(journalPath, 'utf-8');
  }

  journal += `\n\n## ${new Date().toISOString()}\n\n`;
  journal += sessionSummary || '会话结束，无摘要。';
  journal += '\n';

  fs.writeFileSync(journalPath, journal);

  // 更新状态文件
  const statePath = path.join(workspaceDir, 'STATE.md');
  const state = `# 当前状态

> 最后更新: ${new Date().toISOString()}

## 当前任务
<!-- 由 AI 代理更新 -->

## 进度
<!-- 由 AI 代理更新 -->

## 待确认事项
<!-- 由 AI 代理更新 -->
`;

  fs.writeFileSync(statePath, state);

  console.log('状态已保存');
}

// 从 stdin 读取会话摘要
let data = '';
process.stdin.on('data', chunk => data += chunk);
process.stdin.on('end', () => {
  try {
    let summary = '';
    if (data && data.trim()) {
      const parsed = JSON.parse(data);
      summary = parsed.summary || '';
    }
    saveState(summary);
  } catch (e) {
    // 解析失败，记录错误后仍尝试保存原始内容
    console.error('会话摘要解析失败:', e.message);
    saveState(data.trim() || '');
  }
});
