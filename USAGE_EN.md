# OpenAllIn User Guide

> This guide will show you how to use OpenAllIn in both legacy and new projects

---

## Table of Contents

1. [How to Use OpenAllIn in Legacy Projects](#1-how-to-use-openallin-in-legacy-projects)
2. [How to Use OpenAllIn in New Projects](#2-how-to-use-openallin-in-new-projects)
3. [Common Workflows](#3-common-workflows)
4. [FAQ](#4-faq)
5. [Next Steps](#5-next-steps)
6. [Best Practices](#6-best-practices)
7. [Get Help](#7-get-help)

---

## 1. How to Use OpenAllIn in Legacy Projects

If you already have a project under development and want to adopt OpenAllIn, follow these steps:

### Step 1: Clone OpenAllIn to a Temporary Directory

```bash
# Clone to a temporary location (NOT into your project directory)
git clone https://github.com/vanrayliu/openallin.git /tmp/openallin
```

### Step 2: Enter Your Project Directory

```bash
cd /path/to/your-project
```

### Step 3: Run Installation Script

```bash
# Auto-detect current CLI environment and install
bash /tmp/openallin/scripts/install.sh
```

**Or specify CLI tool explicitly:**

```bash
# Install to OpenCode
bash /tmp/openallin/scripts/install.sh opencode

# Install to Claude Code
bash /tmp/openallin/scripts/install.sh claude

# Install to both tools
bash /tmp/openallin/scripts/install.sh opencode claude
```

### Step 4: Verify Installation Success

```bash
# Check installed files
ls -la

# You should see:
# AGENTS.md       - OpenAllIn entry point (OpenCode)
# CLAUDE.md       - OpenAllIn entry point (Claude Code)
# project.md      - Project context (keep if exists)
# .opencode/      - OpenCode config (if installed opencode)
# .claude/        - Claude Code config (if installed claude)
# rules/          - Coding standards
# scripts/        - Utility scripts (init/install/validate/archive/uninstall)
# specs/          - Specs directory
# workspace/      - Workspace
# templates/      - Template library
# changes/        - Change proposals directory
# config/         - Configuration files
```

**Check CLI configuration:**

```bash
# OpenCode
ls .opencode/skills/

# Claude Code
ls .claude/skills/
```

**Check skills file format:**

```bash
# Each skill should be <name>/SKILL.md format
ls .opencode/skills/oa-propose/
# Should see: SKILL.md

# Check any skill content
head -20 .opencode/skills/oa-propose/SKILL.md
```

**Verify all 17 commands are installed:**

```bash
# Should have 17 oa-* commands
ls -d .opencode/skills/oa-*/ | wc -l
# Output should be 17
```

### Step 5: Edit Project Context

```bash
# Edit project.md, fill in your project information
vim project.md
```

**project.md example:**

```markdown
# Project Context

## Tech Stack
- Language: TypeScript
- Framework: React + Node.js
- Package Manager: pnpm
- Testing: Jest
- Build: Vite

## Architecture Patterns
- Frontend-backend separation
- RESTful API
- PostgreSQL database

## Coding Standards
- Use ESLint + Prettier
- Commits follow Conventional Commits

## Business Domain
- E-commerce platform
- User management, product management, order management
```

### Step 6: Restart CLI Tool

```bash
# Restart OpenCode
opencode

# Or restart Claude Code
claude
```

### Step 7: Test Commands

```
/oa-brainstorming
```

Or

```
/oa-propose test-feature
```

### Step 8: Cleanup Temporary Files (Optional)

```bash
# After installation, you can delete the temporary clone directory
rm -rf /tmp/openallin
```

---

## 2. How to Use OpenAllIn in New Projects

If you're starting a new project from scratch, follow these steps:

### Step 1: Create Project Directory

```bash
mkdir my-new-project
cd my-new-project
```

### Step 2: Initialize Git (Recommended)

```bash
git init
git remote add origin https://github.com/your-username/my-new-project.git
```

### Step 3: Clone OpenAllIn

```bash
git clone https://github.com/vanrayliu/openallin.git /tmp/openallin
```

### Step 4: Run Installation Script

```bash
# Auto-detect and install
bash /tmp/openallin/scripts/install.sh
```

### Step 5: Initialize Project

```bash
# Use init.sh to initialize complete project structure
bash scripts/init.sh
```

This will create:
- `workspace/STATE.md` - Project state
- `workspace/ROADMAP.md` - Project roadmap
- `config/settings.json` - Configuration file
- Other necessary directory structures

### Step 6: Edit Project Context

```bash
vim project.md
```

**New project project.md example:**

```markdown
# Project Context

## Tech Stack
- Language: 
- Framework: 
- Package Manager: 
- Testing: 
- Build: 

## Architecture Patterns
- Architecture Style: 
- Layer Conventions: 
- Data Flow: 

## Coding Standards
- Naming Conventions: 
- File Formats: 
- Comment Style: 
- Commit Messages: 

## Business Domain
- Domain Terminology: 
- Core Entities: 
- Business Processes: 

## Project Constraints
- Existing Services: 
- Interface Specifications: 
- Security Requirements: 
- Performance Goals: 
```

### Step 7: Add to Git

```bash
git add .
git commit -m "chore: initialize project with OpenAllIn"
git push -u origin main
```

### Step 8: Start CLI Tool and Begin Development

```bash
opencode
# or
claude
```

---

## 3. Common Workflows

### Workflow 1: Quick Change (Suitable for Small Features)

```
You: /oa-propose add-user-login

AI: Create change proposal:
    - changes/add-user-login/proposal.md
    - changes/add-user-login/design.md
    - changes/add-user-login/specs/
    - changes/add-user-login/tasks.md

You: /oa-validate add-user-login

AI: Validate spec format...
    ✅ RFC 2119 keywords
    ✅ Scenario format
    ✅ Gherkin keywords
    ✅ Requirement format

You: /oa-apply add-user-login

AI: Execute tasks from checklist...

You: /oa-archive add-user-login

AI: Archive change and merge to specs/
```

### Workflow 2: Complex Requirements (Suitable for Large Features)

```
You: /oa-brainstorming

AI: Round 1: What problem do you want to solve?
You: User login feature

AI: Round 2: What are the boundary conditions?
You: Username doesn't exist, wrong password, empty input

AI: Round 3: What are the technical constraints?
You: Need JWT support, 30-minute expiration

... (continue iterating, up to 5 rounds)

You: Discussion complete, end brainstorming

AI: 
**Brainstorming Summary**
- Core requirements: User login, remember login state, JWT token management
- Technical solution: JWT + Redis session storage
- Generated workspace/brainstorm-YYYY-MM-DD.md

You: /oa-propose user-login

AI: Create change proposal:
    - changes/user-login/proposal.md
    - changes/user-login/design.md
    - changes/user-login/specs/
    - changes/user-login/tasks.md

You: /oa-validate user-login

AI: Validate spec format...
    ✅ RFC 2119 keywords
    ✅ Scenario format
    ✅ Gherkin keywords
    ✅ Requirement format

You: /oa-plan user-login

AI: Split into 5 atomic tasks

You: /oa-execute user-login

AI: Executing wave 1 tasks...

You: /oa-verify user-login

AI: Verification passed ✅

You: /oa-ship user-login

AI: PR created
```

### Workflow 3: TDD Development

```
You: /oa-tdd User login feature

AI: 
**TDD Cycle #1**

**🔴 Red**
- Test file: tests/auth/login.test.js
- Test content: Successful login with correct username/password
- Run result: ❌ Failed

**🟢 Green**
- Implementation file: src/auth/login.js
- Run result: ✅ Passed

**🔵 Refactor**
- Refactor content: Extract validation logic
- Run result: ✅ Passed

**Next Steps**
- Continue adding test cases?
```

### Workflow 4: Bug Fix

```
You: /oa-debugging Page freezes after login failure

AI: Round 1: What is the problem?
You: Page keeps spinning after entering wrong password

AI: Round 2: How to reproduce?
You: Enter wrong password, click login

AI: Round 3: What are the possible causes?
You: Error handling doesn't return properly

... (continue debugging)

AI: Problem located: src/auth/login.js:42
```

---

## 4. FAQ

### Q1: Can't see `/oa-*` commands after installation?

**Cause:** Skill file format incorrect or CLI tool not restarted.

**Solution:**
```bash
# Check skill directory structure
ls .opencode/skills/
# Should see oa-apply/, oa-propose/, etc. directories

# Check if SKILL.md exists
ls .opencode/skills/oa-propose/SKILL.md

# Restart CLI tool
opencode
# or
claude
```

### Q2: How to uninstall OpenAllIn?

```bash
# Enter project directory
cd /path/to/your-project

# Run uninstall script (will prompt for confirmation)
bash scripts/uninstall.sh

# Or force uninstall (no confirmation prompt)
bash scripts/uninstall.sh --force
```

**Uninstall will delete:**
- `AGENTS.md`, `CLAUDE.md`, `project.md`
- `.claude/`, `.opencode/` directories
- `rules/`, `scripts/`, `specs/`, `templates/`, `workspace/`, `config/`, `changes/`, `tasks/` directories

**Will NOT delete:**
- Your business code
- `node_modules/`
- Any files not generated by OpenAllIn

**Cleanup global configuration:**
Uninstall script will also clean up OpenAllIn hooks in `~/.claude/settings.json`.

**Notes:**
1. Ensure no in-progress changes in `changes/` directory before uninstalling
2. Backup `specs/` directory if you want to keep specs
3. Backup `workspace/` and `config/memory.json` if you want to keep project memory
4. To reinstall after uninstalling, run `bash scripts/install.sh`

### Q3: How to update OpenAllIn?

```bash
# Re-clone latest version
rm -rf /tmp/openallin
git clone https://github.com/vanrayliu/openallin.git /tmp/openallin

# Reinstall
bash /tmp/openallin/scripts/install.sh
```

### Q4: Which CLI tools are supported?

OpenAllIn supports auto-detection of the following CLI tools:

| CLI Tool | Environment Variable | Directory Detection |
|----------|---------------------|---------------------|
| OpenCode | `$OPENCODE` | `.opencode/` |
| Claude Code | `$CLAUDE_CODE` | `.claude/` |
| Cursor | `$CURSOR` | `.cursor/` |
| Codex | `$CODEX` | `.codex/` |
| OpenClaw | `$OPENCLAW` | `.openclaw/` |
| Gemini CLI | `$GEMINI_CLI` | `.gemini/` |
| Windsurf | `$WINDSURF` | `.windsurf/` |
| Kilo Code | `$KILO` | `.kilo/` |
| Augment | `$AUGMENT` | `.augment/` |
| Zed | `$ZED` | `.zed/` |

### Q5: How to view all available commands?

```
/skills
```

Or ask directly:
```
What commands are available?
```

### Q6: What's the difference between project.md and AGENTS.md?

- **AGENTS.md**: OpenAllIn entry point, defines framework structure and workflows
- **project.md**: Project-specific context, contains tech stack, business domain, coding standards, etc.

**Do NOT modify AGENTS.md**, **you need to fill in project information in project.md**.

### Q7: What is the changes/ directory?

The `changes/` directory stores in-progress change proposals:

```
changes/
├── add-user-login/           # Change name
│   ├── proposal.md           # WHY: Why do this
│   ├── design.md             # HOW: Technical solution
│   ├── specs/                # WHAT: Delta specs
│   │   └── auth/spec.md
│   └── tasks.md              # STEPS: Task checklist
└── archive/                  # Archived changes
    └── 2026-04-09-add-user-login/
```

### Q8: What is the specs/ directory?

The `specs/` directory stores the complete system specifications (Source of Truth):

```
specs/
├── auth/
│   └── spec.md               # Auth module spec
├── api/
│   └── spec.md               # API module spec
└── ui/
    └── spec.md               # UI module spec
```

After change archival, delta specs are merged here.

### Q9: How to view detailed usage of a command?

```bash
# View skill file content
cat skills/oa-propose.md

# Or ask directly in CLI
/oa-propose --help
# or
How to use oa-propose command?
```

### Q10: How to pass command arguments?

Some commands require arguments, some don't:

**Commands requiring arguments:**
```bash
/oa-propose <change-name>      # e.g.: /oa-propose add-user-login
/oa-apply <change-name>        # e.g.: /oa-apply add-user-login
/oa-validate <change-name>     # e.g.: /oa-validate add-user-login
/oa-archive <change-name>      # e.g.: /oa-archive add-user-login
/oa-tdd <feature-description>  # e.g.: /oa-tdd User login feature
```

**Commands without arguments:**
```bash
/oa-brainstorming
/oa-debugging
/oa-writing-plans
/oa-worktree
/oa-team-plan
/oa-team-exec
/oa-team-verify
```

**Commands with optional arguments:**
```bash
/oa-discuss [topic]            # Optional topic, e.g.: /oa-discuss Login feature
/oa-plan [phase]               # Optional phase, e.g.: /oa-plan user-login
/oa-execute [phase]            # Optional phase
/oa-verify [phase]             # Optional phase
/oa-ship [phase]               # Optional phase
```

### Q11: How to use OpenAllIn across multiple projects?

Install OpenAllIn independently in each project:

```bash
# Project A
cd /path/to/project-a
bash /tmp/openallin/scripts/install.sh claude

# Project B
cd /path/to/project-b
bash /tmp/openallin/scripts/install.sh opencode
```

**Notes:**
1. Each project's `project.md` is maintained independently
2. Each project's `specs/`, `changes/`, `workspace/` are independent
3. Different projects can use different CLI tools
4. Recommended to introduce OpenAllIn as a submodule

```bash
# Using git submodule
git submodule add https://github.com/vanrayliu/openallin.git openallin
bash openallin/scripts/install.sh claude
```

### Q12: How to backup and restore OpenAllIn configuration?

**Backup:**
```bash
# Backup project configuration
tar -czf openallin-backup.tar.gz \
    project.md \
    specs/ \
    changes/ \
    workspace/ \
    config/ \
    .claude/ \
    .opencode/
```

**Restore:**
```bash
# Reinstall OpenAllIn
bash scripts/install.sh

# Restore configuration
tar -xzf openallin-backup.tar.gz
```

### Q13: How to handle command execution failures?

**Check steps:**
```bash
# 1. Check error message
# AI will usually explain the failure reason

# 2. Check if related files exist
ls changes/<change-name>/

# 3. Check spec format
/oa-validate <change-name>

# 4. Manual retry
# If automatic execution fails, you can execute tasks manually

# 5. Use debug mode
/oa-debugging
```

**Common errors:**
| Error | Cause | Solution |
|-------|-------|----------|
| Change not found | changes/<name> directory doesn't exist | Run /oa-propose first |
| Spec validation failed | Format incorrect | Check with /oa-validate |
| Task execution failed | Dependency issues | Check tasks.md order |
| Git conflict | Uncommitted changes | Commit or stash first |
| Skill not loaded | CLI not restarted | Restart CLI tool |

---

## 5. Next Steps

1. **Edit project.md** - Fill in your project information
2. **Try your first command** - `/oa-brainstorming` or `/oa-propose`
3. **Read QUICKREF.md** - Quick reference card (17 commands cheat sheet)
4. **Read WORKFLOW.md** - Detailed workflows and best practices
5. **Check examples/** - Example change proposals (for learning)

---

## 6. Best Practices

### 1. Spec First

Before writing code, use `/oa-propose` to clarify:
- **WHY**: Why make this change?
- **WHAT**: What exactly to do?
- **HOW**: What's the technical solution?

### 2. Small Steps

- Keep each change small (completable in 1-3 days)
- Archive frequently (`/oa-archive`)
- Merge specs to `specs/` promptly

### 3. Verification-Driven

- Pre-execution verification: `/oa-validate`
- Post-execution verification: `/oa-verify`
- Pre-release verification: Run verification again before `/oa-ship`

### 4. Context Management

- Use `/oa-discuss` → `/oa-plan` → `/oa-execute` for long tasks
- Use brainstorming for complex features (`/oa-brainstorming`)
- Use debug flow for bug fixes (`/oa-debugging`)

### 5. Team Collaboration

- Use `/oa-team-plan` for team planning
- Use Git Worktree for isolated development (`/oa-worktree`)
- Use `/oa-team-verify` for cross-verification

### 6. Knowledge Persistence

- Write all specs to `specs/`
- Write all state to `workspace/`
- Write all learnings to `config/memory.json`

---

## 7. Get Help

- **GitHub**: https://github.com/vanrayliu/openallin
- **Issue Tracker**: https://github.com/vanrayliu/openallin/issues
- **Documentation**: 
  - README.md - Project introduction and installation guide
  - QUICKREF.md - Quick reference card (17 commands cheat sheet)
  - WORKFLOW.md - Detailed workflows and best practices
  - USAGE.md - User guide (this document)
- **Examples**: 
  - examples/ - Example change proposals (for learning)
  - templates/ - Template library (proposal.md, design.md, spec.md, etc.)
- **Configuration**:
  - agents/ - Agent role definitions (planner, implementer, reviewer, etc.)
  - rules/ - Coding standards and security rules
