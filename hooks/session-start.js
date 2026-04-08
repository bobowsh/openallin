#!/usr/bin/env node

/**
 * Session Start Hook
 * 在每次会话启动时自动加载项目上下文
 */

const fs = require('fs');
const path = require('path');

const HARNESS_DIR = process.env.CLAUDE_PROJECT_DIR
  ? path.resolve(process.env.CLAUDE_PROJECT_DIR)
  : path.resolve(__dirname, '..');

function loadContext() {
  const context = [];

  // 1. 加载项目上下文
  const projectMd = path.join(HARNESS_DIR, 'project.md');
  if (fs.existsSync(projectMd)) {
    context.push('## 项目上下文');
    context.push(fs.readFileSync(projectMd, 'utf-8'));
  }

  // 2. 加载当前状态
  const stateMd = path.join(HARNESS_DIR, 'workspace', 'STATE.md');
  if (fs.existsSync(stateMd)) {
    context.push('## 当前状态');
    context.push(fs.readFileSync(stateMd, 'utf-8'));
  }

  // 3. 加载路线图
  const roadmapMd = path.join(HARNESS_DIR, 'workspace', 'ROADMAP.md');
  if (fs.existsSync(roadmapMd)) {
    context.push('## 项目路线图');
    context.push(fs.readFileSync(roadmapMd, 'utf-8'));
  }

  // 4. 加载活跃任务
  const tasksDir = path.join(HARNESS_DIR, 'tasks');
  if (fs.existsSync(tasksDir)) {
    const tasks = fs.readdirSync(tasksDir).filter(f => f !== 'archive');
    if (tasks.length > 0) {
      context.push('## 活跃任务');
      tasks.forEach(task => {
        const taskJson = path.join(tasksDir, task, 'task.json');
        if (fs.existsSync(taskJson)) {
          const taskData = JSON.parse(fs.readFileSync(taskJson, 'utf-8'));
          context.push(`- ${task}: ${taskData.status || 'unknown'}`);
        }
      });
    }
  }

  // 5. 加载记忆和直觉
  const memoryJson = path.join(HARNESS_DIR, 'config', 'memory.json');
  if (fs.existsSync(memoryJson)) {
    context.push('## 项目记忆');
    context.push(fs.readFileSync(memoryJson, 'utf-8'));
  }

  return context.join('\n\n---\n\n');
}

// 输出上下文（供 AI 代理读取）
console.log(loadContext());
