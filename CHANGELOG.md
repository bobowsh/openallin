# Changelog

All notable changes to this project will be documented in this file.

## [v1.1.0] - 2026-04-09

### Added
- **16 Command Skills**: oa-propose, oa-apply, oa-validate, oa-archive, oa-discuss, oa-plan, oa-execute, oa-verify, oa-ship, oa-team-plan, oa-team-exec, oa-team-verify, oa-worktree, oa-brainstorming, oa-debugging, oa-writing-plans
- **Multi-round Iteration Design**:
  - oa-brainstorming: 5-round brainstorming (intent → boundary → environment → solution → confirm)
  - oa-debugging: 5-round debugging (reproduce → hypothesize → locate → fix → prevent)
  - oa-writing-plans: 4-round planning (understand → refine → risk → confirm)
  - oa-discuss: 5-round discussion with round summary and user decision
- **uninstall.sh**: Complete uninstallation with global settings.json cleanup

### Changed
- **Consolidated skills structure**: Removed `skills/` directory, all skills now in `.opencode/skills/oa-*`
- **Updated install.sh**: Simplified to copy directly from `.opencode/skills/`
- **Updated AGENTS.md**: Command list now matches actual 16 oa-* skills

### Fixed
- Prevent duplicate hooks on re-install
- Always backup config files before modification
- Reject installation to home or root directory
- Convert old-format hooks to new format when merging
- Claude Code settings.json merge preserves user hooks with backup

## [v1.0.0] - 2026-04-08

### Added
- **Bilingual Support**: README.md (English/Chinese), README_zh.md (Chinese only)
- **6-Layer Architecture**: Workspace, Orchestration, Execution, Enhancement, Skills, Spec
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
- `uninstall.sh`: Complete uninstallation
