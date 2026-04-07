# OpenAllIn — Unified AI Coding Harness

> A layered, composable engineering framework combining the best of OpenSpec, Superpowers, GSD, OMC, ECC, and Trellis.

## Architecture

OpenAllIn uses a **layered, composable** design where each layer is independently optional and freely combinable:

```
┌─────────────────────────────────────────────────┐
│  Layer 6: Workspace  — Project Memory &          │  ← Trellis
│             Parallel Pipeline                     │
├─────────────────────────────────────────────────┤
│  Layer 5: Orchestration — Multi-Agent Team       │  ← OMC
│             Coordination                          │
├─────────────────────────────────────────────────┤
│  Layer 4: Execution — Phase-Based Workflow &     │  ← GSD
│             Context Engineering                   │
├─────────────────────────────────────────────────┤
│  Layer 3: Enhancement — Security / Memory /      │  ← ECC
│             Learning / Verification               │
├─────────────────────────────────────────────────┤
│  Layer 2: Skills — Engineering Methodology       │  ← Superpowers
│             Library                               │
├─────────────────────────────────────────────────┤
│  Layer 1: Spec — Spec-Driven Development         │  ← OpenSpec
└─────────────────────────────────────────────────┘
```

## Core Principles

1. **Spec First** — Align on requirements before writing code
2. **Engineering Discipline** — Make best practices the default behavior
3. **Context Hygiene** — Small tasks, phase separation, structured information
4. **Team Orchestration** — Multiple agents collaborate like a real team
5. **Capability Enhancement** — Security, memory, learning, verification loops
6. **Project Memory** — File-based persistence over LLM memory

## Installation

### Quick Install

```bash
# Clone and install
git clone https://github.com/vanrayliu/openallin.git
cd openallin
bash scripts/install.sh opencode   # For OpenCode
bash scripts/install.sh claude     # For Claude Code
bash scripts/install.sh all        # For all tools
```

### OpenCode

```bash
# Project-level
cp AGENTS.md your-project/
cp project.md your-project/
cp -r rules/ your-project/.opencode/rules/
cp -r agents/ your-project/.opencode/agents/

# Skills need SKILL.md wrapper — use install script instead
# Or manually: for each skill, create .opencode/skills/<name>/SKILL.md with frontmatter

# Or use the install script
bash scripts/install.sh opencode your-project/
```

OpenCode reads `AGENTS.md` natively. Skills go to `.opencode/skills/<name>/SKILL.md` with YAML frontmatter.

### Claude Code

```bash
# Project-level
cp AGENTS.md your-project/CLAUDE.md
cp project.md your-project/
cp -r rules/ your-project/.claude/rules/
cp -r agents/ your-project/.claude/agents/

# Skills need SKILL.md wrapper — use install script instead
# Or manually: for each skill, create .claude/skills/<name>/SKILL.md with frontmatter

# Hooks
cp -r hooks/ your-project/.claude/hooks/
# Then configure hooks in .claude/settings.json (see README.md)

# Or use the install script
bash scripts/install.sh claude your-project/
```

Claude Code reads `CLAUDE.md` natively. Hooks are configured in `.claude/settings.json`.

### Other Tools

| Tool | Install | Notes |
|------|---------|-------|
| **Cursor** | Copy `AGENTS.md` to project root or `.cursor/rules/` | Reads `.mdc` files |
| **Codex** | Copy `AGENTS.md` to project root | Reads AGENTS.md |
| **Gemini CLI** | Copy `AGENTS.md` to project root | Claude Code compatible |
| **Windsurf** | Copy `AGENTS.md` to project root | Auto-detects |

### Minimal Install (Universal)

```bash
cp AGENTS.md your-project/
cp project.md your-project/
cp -r specs/ your-project/
cp -r changes/ your-project/
cp -r workspace/ your-project/workspace/
```

This works with any tool that reads `AGENTS.md` from the project root.

## Quick Start

```
/oa:propose <name>    → Create change proposal
/oa:apply <name>      → Execute tasks from checklist
/oa:discuss <phase>   → Discuss and clarify requirements
/oa:plan <phase>      → Plan atomic tasks
/oa:execute <phase>   → Execute in waves
/oa:verify <phase>    → Verify quality
/oa:ship <phase>      → Ship and create PR
/oa:brainstorm        → Brainstorming session
/oa:tdd               → Test-driven development
/oa:debug             → Systematic debugging
/oa:review            → Code review
```

## License

MIT
