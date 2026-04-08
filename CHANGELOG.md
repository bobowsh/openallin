# Changelog

All notable changes to this project will be documented in this file.

## [v1.0.0] - 2026-04-08

### Added
- **Bilingual Support**: README.md (English/Chinese), README_zh.md (Chinese only)
- **6-Layer Architecture**: Workspace, Orchestration, Execution, Enhancement, Skills, Spec
- **17 AI Commands**: /oa:propose, apply, validate, archive, discuss, plan, execute, verify, ship, team-plan, team-exec, team-verify, brainstorm, tdd, debug, review, worktree
- **7 Engineering Skills**: brainstorming, tdd-workflow, systematic-debugging, code-review, worktree-isolation, writing-plans, verification
- **5 Agent Roles**: planner, implementer, reviewer, debugger, researcher
- **4 Rule Sets**: coding-standards, security-rules, commit-rules, review-rules
- **4 Event Hooks**: session-start, session-end, pre-tool-use, post-tool-use
- **Multi-Platform Installation**: OpenCode, Claude Code, Cursor, Codex support
- **Delta Spec System**: Incremental spec changes with ADDED/MODIFIED/REMOVED
- **Example Change**: add-user-login with complete proposal, design, specs, tasks

### Features
- Pure text/Shell/JSON implementation (no external dependencies)
- Works offline
- Language-agnostic (any programming language/framework)
- Progressive adoption (each layer independently optional)

### Scripts
- `init.sh`: Initialize new project with OpenAllIn structure
- `install.sh`: One-click installation for multiple AI tools
- `validate-spec.sh`: Validate spec format compliance
- `archive-change.sh`: Archive completed changes and merge to main specs
