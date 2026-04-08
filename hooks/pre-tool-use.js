#!/usr/bin/env node

/**
 * Pre-Tool-Use Hook
 * 在工具执行前进行安全检查
 */

const fs = require('fs');
const path = require('path');

const HARNESS_DIR = process.env.CLAUDE_PROJECT_DIR
  ? path.resolve(process.env.CLAUDE_PROJECT_DIR)
  : path.resolve(__dirname, '..');

// 从 stdin 读取工具信息
let data = '';
process.stdin.on('data', chunk => data += chunk);
process.stdin.on('end', () => {
  try {
    const input = JSON.parse(data);
    const tool = input.tool;
    const args = input.input || {};

    // 1. 密钥检测
    const secretPatterns = [
      /sk-[a-zA-Z0-9]{20,}/,
      /ghp_[a-zA-Z0-9]{36}/,
      /AKIA[0-9A-Z]{16}/,
      /-----BEGIN (RSA |EC )?PRIVATE KEY-----/,
    ];

    const checkSecrets = (obj) => {
      if (typeof obj === 'string') {
        for (const pattern of secretPatterns) {
          if (pattern.test(obj)) {
            console.error('安全警告: 检测到可能的密钥');
            process.exit(2);
          }
        }
      } else if (typeof obj === 'object' && obj !== null) {
        Object.values(obj).forEach(checkSecrets);
      }
    };

    checkSecrets(args);

    // 2. Git 安全
    if (tool === 'Bash') {
      const command = args.command || '';
      if (command.includes('--no-verify')) {
        console.error('安全警告: 不允许使用 --no-verify 标志');
        process.exit(2);
      }
    }

    // 3. 配置文件保护
    if (tool === 'Write' || tool === 'Edit') {
      const filePath = args.filePath || '';
      const protectedFiles = [
        '.eslintrc', 'biome.json', '.ruff.toml',
        'package.json', 'tsconfig.json'
      ];

      for (const protectedFile of protectedFiles) {
        if (filePath.includes(protectedFile)) {
          console.log(`注意: 正在修改受保护的配置文件 ${filePath}`);
          // 不阻止，但记录
        }
      }
    }

    // 通过检查
    process.exit(0);

  } catch (e) {
    // 解析失败，放行
    process.exit(0);
  }
});
