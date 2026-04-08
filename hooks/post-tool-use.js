#!/usr/bin/env node

/**
 * Post-Tool-Use Hook
 * 工具执行后审计
 */

const fs = require('fs');
const path = require('path');

const HARNESS_DIR = process.env.CLAUDE_PROJECT_DIR
  ? path.resolve(process.env.CLAUDE_PROJECT_DIR)
  : path.resolve(__dirname, '..');

let data = '';
process.stdin.on('data', chunk => data += chunk);
process.stdin.on('end', () => {
  try {
    const input = JSON.parse(data);
    const tool = input.tool;

    // 1. 文件修改后检查 console.log
    if (tool === 'Write' || tool === 'Edit') {
      const filePath = input.input?.filePath || '';
      if (filePath.endsWith('.js') || filePath.endsWith('.ts')) {
        try {
          const content = fs.readFileSync(filePath, 'utf-8');
          const consoleLogs = content.match(/console\.(log|debug|info|warn)/g);
          if (consoleLogs) {
            console.log(`审计: ${filePath} 包含 ${consoleLogs.length} 个 console 调用`);
          }
        } catch (e) {
          // 文件可能不存在
        }
      }
    }

    // 2. 记录工具使用
    const logDir = path.join(HARNESS_DIR, 'workspace');
    if (!fs.existsSync(logDir)) {
      fs.mkdirSync(logDir, { recursive: true });
    }
    const logPath = path.join(logDir, 'tool-usage.log');
    const logEntry = `[${new Date().toISOString()}] ${tool}\n`;
    fs.appendFileSync(logPath, logEntry);

  } catch (e) {
    // 静默失败
  }

  process.exit(0);
});
