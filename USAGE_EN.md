# OpenAllIn User Guide

> This guide will show you how to use OpenAllIn in both legacy and new projects

---

## Table of Contents

1. [How to Use OpenAllIn in Legacy Projects](#1-how-to-use-openallin-in-legacy-projects)
2. [How to Use OpenAllIn in New Projects](#2-how-to-use-openallin-in-new-projects)
3. [Install via AI Assistant (Recommended)](#3-install-via-ai-assistant-recommended)
4. [Use OpenAllIn via Natural Language](#4-use-openallin-via-natural-language)
5. [Common Workflows](#5-common-workflows)
6. [FAQ](#6-faq)
7. [Next Steps](#7-next-steps)
8. [Best Practices](#8-best-practices)
9. [Get Help](#9-get-help)

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
# agents/         - Agent role definitions (planner, implementer, reviewer, etc.)
# rules/          - Coding standards and security rules
# scripts/        - Utility scripts (init/install/validate/archive/uninstall)
# specs/          - Specs directory
# workspace/      - Workspace
# templates/      - Template library
# changes/        - Change proposals directory
# config/         - Configuration files
# tasks/          - Task-driven workflow directory
# hooks/          - Event hooks (session start/end/tool calls)
# examples/       - Example change proposals (for learning)
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

**Verify all 23 commands are installed:**

```bash
# Should have 22 oa-* commands
ls -d .opencode/skills/oa-*/ | wc -l
# Output should be 22
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

## 3. Install via AI Assistant (Recommended)

> If you're using Claude Code, OpenCode, or similar tools, you can install OpenAllIn through natural language without manually running commands.

### When to Use

- ✅ You're using Claude Code, OpenCode, or similar AI coding tools
- ✅ You prefer conversational installation
- ✅ You want AI to handle configuration details automatically

### Method 1: Provide Git URL to Install

**Step 1: Open Your Project**

```bash
cd /path/to/your-project
opencode  # or claude
```

**Step 2: Tell the AI (Must provide Git URL)**

```
Please install OpenAllIn for me: https://github.com/vanrayliu/openallin
```

Or with full URL:

```
Please install OpenAllIn for me: https://github.com/vanrayliu/openallin.git
```

**What AI Will Do:**

```
AI: Sure, I'll install OpenAllIn for you.

1. Cloning OpenAllIn repository to temporary directory...
   ✅ git clone https://github.com/vanrayliu/openallin.git /tmp/openallin

2. Detected you're using OpenCode, starting installation...
   ✅ Created .opencode/ directory
   ✅ Installed 23 commands (oa-propose, oa-brainstorming, oa-tdd, oa-security, oa-review, etc.)
   ✅ Copied agents/ (role definitions)
   ✅ Copied rules/ (coding standards)
   ✅ Created specs/, changes/, workspace/ directories

3. Installation complete! Please restart OpenCode to load new commands.

Next steps:
- Edit project.md with your project information
- Use /oa-brainstorming to start brainstorming
- Use /oa-propose <name> to create change proposals
```

---

### Method 2: Clone Then Install

**Step 1: Clone OpenAllIn Repository First**

```bash
git clone https://github.com/vanrayliu/openallin.git
cd openallin
opencode  # or claude
```

**Step 2: Tell the AI**

```
Help me install to /path/to/my-project
```

**What AI Will Do:**

```
AI: Sure, I'll install to the specified directory.

1. Detected current directory is OpenAllIn repository
2. Running installation script...
   ✅ bash scripts/install.sh --target /path/to/my-project
3. Installation complete!
```

**Step 3: Verify Installation**

You:
```
Check if OpenAllIn is installed correctly
```

AI:
```
AI: Checking installation status...

✅ AGENTS.md exists
✅ project.md exists
✅ .opencode/skills/ exists
✅ 23 commands installed:
   - /oa-propose
   - /oa-apply
   - /oa-validate
   - /oa-archive
   - /oa-discuss
   - /oa-plan
   - /oa-execute
   - /oa-verify
   - /oa-review
   - /oa-ship
   - /oa-land
   - /oa-security
   - /oa-qa-browser
   - /oa-benchmark
   - /oa-brainstorming
   - /oa-debugging
   - /oa-tdd
   - /oa-writing-plans
   - /oa-worktree
   - /oa-team-plan
   - /oa-team-exec
   - /oa-team-verify

✅ OpenAllIn installed successfully!
```

---

### Method 3: Specify Installation Options

**Specify CLI tool:**

```
I'm using Claude Code, please install OpenAllIn: https://github.com/vanrayliu/openallin
```

**Install to multiple tools:**

```
Install to both OpenCode and Claude Code: https://github.com/vanrayliu/openallin
```

**Install specific components only:**

```
Only install OpenAllIn's brainstorming and tdd commands: https://github.com/vanrayliu/openallin
```

---

### Why Must I Provide Git URL?

AI assistants cannot predict your project source, so you need to provide it:

| Scenario | What to Provide |
|----------|-----------------|
| Install from GitHub | `https://github.com/vanrayliu/openallin` |
| Install from Gitee | `https://gitee.com/yourname/openallin` |
| Install from private repo | `git@github.com:yourname/openallin.git` |
| Already cloned locally | First `cd openallin`, then say "install to xxx" |

---

### Post-Installation Configuration

**Edit project context:**

```
Help me edit project.md, this is an e-commerce platform using React + Node.js + PostgreSQL
```

AI will fill in based on your input:
- Tech stack information
- Architecture patterns
- Business domain

**Configure team standards:**

```
Our team uses ESLint + Prettier, commits follow Conventional Commits
```

AI will update `rules/coding-standards.md` and `rules/commit-rules.md`.

---

### Natural Language Installation/Update/Uninstall Commands Quick Reference

| What You Say | What AI Does |
|--------------|--------------|
| "Install OpenAllIn: https://github.com/vanrayliu/openallin" | Execute full installation |
| "Check installation status" | Verify all components |
| "Uninstall OpenAllIn" | Run uninstall script |
| "Update OpenAllIn" | Run `bash scripts/update.sh` |
| "Preview what will be updated" | Run `bash scripts/update.sh --dry-run` |
| "Force update, overwrite all configs" | Run `bash scripts/update.sh --force` |
| "Edit project.md" | Guide you through filling in info |
| "Configure team standards" | Update rules/ directory |

---

### Why Natural Language Installation?

| Comparison | Command Line | Natural Language |
|------------|--------------|------------------|
| **Learning Curve** | Need to remember commands | Just state your needs |
| **Error Handling** | Debug yourself | AI handles automatically |
| **Configuration** | Manual file editing | AI guides you |
| **Target Users** | Developers familiar with CLI | All users |
| **Flexibility** | Full control | AI-assisted decisions |

**Recommendation:** If you're using AI coding tools, prefer natural language installation.

---

## 4. Use OpenAllIn via Natural Language

> Instead of using `/oa-*` commands, you can describe your needs in natural language and let the AI assistant choose and execute the appropriate commands automatically.

### Why Use Natural Language?

| Command Approach | Natural Language Approach |
|-----------------|--------------------------|
| Need to remember command names | Just state your needs |
| Need to understand command parameters | AI infers automatically |
| Need to manually execute multiple commands | AI chains them automatically |
| Best for: Experienced users | Best for: All users |

---

### Basic Usage Examples

#### 1. Create a Change

**Command Approach:**
```
/oa-propose add-user-login
/oa-validate add-user-login
```

**Natural Language Approach:**
```
I want to add a user login feature, help me create a change proposal
```

AI will follow the recommended workflow:
1. Recognize the need → Call `/oa-propose user-login`
2. Create proposal files
3. Validate spec format

---

#### 2. Brainstorming

**Command Approach:**
```
/oa-brainstorming
```
Then manually answer 5 rounds of questions.

**Natural Language Approach:**
```
I want to build a user login feature but not sure how, help me think through it
```

AI will follow the recommended workflow:
1. Start brainstorming mode
2. Guide you through requirement analysis
3. Generate summary document

---

#### 3. Plan Tasks

**Command Approach:**
```
/oa-plan user-login
```

**Natural Language Approach:**
```
What tasks are needed for the user login feature? Help me plan
```

AI will follow the recommended workflow:
1. Analyze requirements
2. Split into atomic tasks
3. Plan execution waves

---

#### 4. Execute Tasks

**Command Approach:**
```
/oa-execute user-login
/oa-verify user-login
```

**Natural Language Approach:**
```
Start executing the user login tasks, verify when done
```

AI will follow the recommended workflow:
1. Execute all tasks
2. Run verification
3. Report results

---

### Advanced Usage Examples

#### Complete Workflow (One Sentence Trigger)

```
Help me implement the user login feature, from requirement analysis to code implementation
```

AI will follow the recommended workflow:
1. /oa-brainstorming → Clarify requirements
2. /oa-propose → Generate specs
3. /oa-plan → Split work
4. /oa-execute → Write code
5. /oa-verify → Ensure correctness
6. /oa-ship → Submit code

---

#### Bug Fixing

**Command Approach:**
```
/oa-debugging login failure page freeze
```

**Natural Language Approach:**
```
The page keeps spinning after login fails, help me locate and fix this issue
```

AI will follow the recommended workflow:
1. Start debug mode
2. Multi-round Q&A to locate problem
3. Fix the code
4. Verify the fix

---

#### TDD Development

**Command Approach:**
```
/oa-tdd user login feature
```

**Natural Language Approach:**
```
Develop the user login feature using TDD
```

AI will follow the recommended workflow:
1. Write tests first (Red)
2. Write implementation (Green)
3. Refactor and optimize (Refactor)
4. Loop until complete

---

### Natural Language Quick Reference

#### Requirements

| What You Say | What AI Does |
|--------------|--------------|
| "I want to build XXX feature" | Start brainstorming |
| "Help me analyze XXX requirements" | Call `/oa-brainstorming` |
| "Create a change proposal for XXX" | Call `/oa-propose` |
| "Validate this change's specs" | Call `/oa-validate` |

#### Tasks

| What You Say | What AI Does |
|--------------|--------------|
| "Help me plan tasks for XXX" | Call `/oa-plan` |
| "Start executing tasks" | Call `/oa-execute` |
| "Check completion status" | Call `/oa-verify` |
| "Submit this change" | Call `/oa-ship` |

#### Debugging

| What You Say | What AI Does |
|--------------|--------------|
| "XXX has a bug, help me fix it" | Call `/oa-debugging` |
| "Page shows error: XXX" | Analyze error → Fix |
| "Tests failing: XXX" | Locate issue → Fix |

#### Security

| What You Say | What AI Does |
|--------------|--------------|
| "Check security" | Call `/oa-security` |
| "Security audit" | Call `/oa-security` |
| "Does this code have security vulnerabilities?" | Call `/oa-security` + analyze |
| "Review security" | OWASP + STRIDE check |

#### Deployment

| What You Say | What AI Does |
|--------------|--------------|
| "Deploy to production" | Call `/oa-land` |
| "Go live" | Call `/oa-land` |
| "Check deployment status" | Call `/oa-land` + smoke tests |
| "Deployment failed, rollback" | Generate rollback plan |

#### Testing

| What You Say | What AI Does |
|--------------|--------------|
| "Browser test" | Call `/oa-qa-browser` |
| "Visual regression test" | Call `/oa-qa-browser` + visual check |
| "Accessibility test" | Call `/oa-qa-browser` + WCAG check |
| "Performance test" | Call `/oa-benchmark` |
| "API performance benchmark" | Call `/oa-benchmark` + API benchmark |

#### Review

| What You Say | What AI Does |
|--------------|--------------|
| "Review code" | Call `/oa-review` |
| "Code review" | Call `/oa-review` |
| "Design review" | Call `/oa-review` + design check |
| "Architecture review" | Call `/oa-review` + architecture check |
| "Review UI/UX" | Call `/oa-review` + UI/UX check |

#### Design

| What You Say | What AI Does |
|--------------|--------------|
| "Design UI" | Call `/oa-ui-design` |
| "Generate design system" | Call `/oa-ui-design` + output design system |
| "Color palette" | Call `/oa-ui-design` + color recommendations |
| "Design landing page" | Call `/oa-ui-design` + landing page pattern |
| "UI style recommendations" | Call `/oa-ui-design` + style recommendations |
| "Font pairing" | Call `/oa-ui-design` + typography recommendations |

#### Queries

| What You Say | What AI Does |
|--------------|--------------|
| "Show current project status" | Read `workspace/STATE.md` |
| "What tasks are incomplete?" | Check `changes/*/tasks.md` |
| "What's the spec for XXX feature?" | Read `specs/*/spec.md` |
| "What's the test coverage?" | Run tests and analyze |

---

### Natural Language Best Practices

#### ✅ Good Expressions

```
✅ "I want to add user login, supporting both username/password and SMS code"
   → Clear requirements, AI can understand accurately

✅ "Help me implement shopping cart with add/modify/delete items"
   → Clear features, AI can split tasks

✅ "This API returns 500 error, logs show database connection timeout"
   → Specific problem, AI can locate quickly
```

#### ❌ Poor Expressions

```
❌ "Help me write a feature"
   → Too vague, AI doesn't know what you want

❌ "Code not working"
   → Didn't say which feature, what error

❌ "Optimize it"
   → Didn't say what to optimize, what's the goal
```

---

### Natural Language vs Commands: When to Use Which?

| Scenario | Recommended Approach | Reason |
|----------|---------------------|--------|
| Simple, clear tasks | Commands | Fast, precise |
| Complex, multi-step tasks | Natural language | AI chains automatically |
| Unsure how to start | Natural language | AI guides thinking |
| Debugging, troubleshooting | Natural language | Interactive Q&A |
| Batch operations | Commands | Scriptable |
| Learning, exploring | Natural language | AI explains |

**Recommendation:** New users start with natural language, mix both when experienced.

---

## 5. Common Workflows

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

## 6. FAQ

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
- `agents/`, `hooks/`, `rules/`, `scripts/`, `specs/`, `templates/`, `workspace/`, `config/`, `changes/`, `tasks/`, `.planning/` directories

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
/oa-security
/oa-land
/oa-qa-browser
/oa-benchmark
```

**Commands with optional arguments:**
```bash
/oa-discuss [topic]            # Optional topic, e.g.: /oa-discuss Login feature
/oa-plan [phase]               # Optional phase, e.g.: /oa-plan user-login
/oa-execute [phase]            # Optional phase
/oa-verify [phase]             # Optional phase
/oa-review [phase]             # Optional phase, e.g.: /oa-review user-login
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

## 7. Next Steps

1. **Edit project.md** - Fill in your project information
2. **Try your first command** - `/oa-brainstorming` or `/oa-propose`
3. **Read QUICKREF.md** - Quick reference card (23 commands cheat sheet)
4. **Read WORKFLOW.md** - Detailed workflows and best practices
5. **Check examples/** - Example change proposals (for learning)

---

## 8. Best Practices

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

## 9. Get Help

- **GitHub**: https://github.com/vanrayliu/openallin
- **Issue Tracker**: https://github.com/vanrayliu/openallin/issues
- **Documentation**: 
  - README.md - Project introduction and installation guide
  - QUICKREF.md - Quick reference card (23 commands cheat sheet)
  - WORKFLOW.md - Detailed workflows and best practices
  - USAGE.md - User guide (this document)
- **Examples**: 
  - examples/ - Example change proposals (for learning)
  - templates/ - Template library (proposal.md, design.md, spec.md, etc.)
- **Configuration**:
  - agents/ - Agent role definitions (planner, implementer, reviewer, etc.)
  - rules/ - Coding standards and security rules
