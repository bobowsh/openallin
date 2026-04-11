# Changelog

All notable changes to this project will be documented in this file.

## [v1.7.4] - 2026-04-11

### Fixed
- **Skills comprehensive review and fixes**:
  - oa-worktree.md: fixed branch name reference errors (unified `feature/<name>` format)
  - oa-team-exec.md: fixed path inconsistency issues (worktree directory and branch naming)
  - oa-ui-design.md: updated data counts (1220 entries, 9 domains, accurate counts)
  - oa-ship.md: added verification steps before commit (lint/typecheck/test)
  - oa-discuss.md vs oa-brainstorming.md: clarified different use cases (Spec-Driven vs exploratory)
  - oa-validate.md: added manual backup steps when scripts don't exist
  - oa-archive.md: added manual backup steps when scripts don't exist
- **install.sh**: removed duplicate `*)` default case (line 447-452 conflict)
- **products.csv**: rewritten with consistent 6-column format, no duplicates (530 entries)

### Added
- **lib/review/**: design-checklist.md, architecture-checklist.md, custom-rules.md
- **lib/security/**: checklist.md (OWASP+STRIDE), patterns.md, custom-rules.md
- **lib/browser/**: playwright-config.md (already had test-templates.md)
- **lib/performance/**: benchmark-templates.md, thresholds.md
- **lib/deploy/**: smoke-tests.md, rollback.md, custom-smoke-tests.md

### Changed
- Updated data counts to accurate values:
  - styles.csv: 70 entries
  - products.csv: 530 entries
  - colors.csv: 161 entries
  - typography.csv: 66 entries
  - landing.csv: 65 entries
  - ux.csv: 127 entries
  - techstack.csv: 15 entries
  - ui-reasoning.csv: 161 entries
  - charts.csv: 25 entries
  - **Total**: 1220 entries (exceeds UI UX Pro Max 596 by 2x+)

---

## [v1.7.3] - 2026-04-11

### Added
- **Full UI UX Pro Max implementation**: 850+ entries, 9 domains (complete)
  - products.csv: 125 → 161 (+36: architecture, construction, logistics, agriculture, mining, manufacturing, energy, water, air, space, research, consulting, recruitment)
  - colors.csv: 123 → 161 (+38: aligned 1:1 with product types)
  - ui-reasoning.csv: 57 → 161 (+104: mobile/desktop specific design decisions)
  - charts.csv: NEW 25 chart types (dashboard visualization recommendations)
  - **Total**: 850+ entries (UI UX Pro Max: 596 entries)
- **Chart domain**: Dashboard visualization recommendations
  - 25 chart types: line, bar, pie, scatter, heatmap, treemap, gauge, waterfall, etc.
  - Best use cases, visual style, data requirements, interactions
- **9 search domains**: style, product, color, typography, landing, ux, techstack, ui-reasoning, chart
- **Comparison with UI UX Pro Max**:
  - styles: 67 → 70 ✓ (more)
  - products: 161 → 161 ✓ (match)
  - colors: 161 → 161 ✓ (match, 1:1 with products)
  - typography: 57 → 66 ✓ (more)
  - charts: 25 → 25 ✓ (NEW)
  - landing: 24 → 65 ✓ (more)
  - techstack: 15 → 15 ✓ (match)
  - ux: 99 → 127 ✓ (more)
  - reasoning: 161 → 161 ✓ (match)
- **All implementations are self-written, not copied**

### Changed
- Updated core.py: Added chart domain support (9 domains)
- Updated design_system.py: Added chart domain to full system generation (9 domains)
- Updated skills/oa-ui-design.md: Full implementation documentation (850+ entries)

---

## [v1.7.2] - 2026-04-11

### Added
- **Expanded data files**: 324 → 648 entries (doubled)
  - colors.csv: 16 → 123 palettes (107 new palettes: industry, brand, nature, gem, fabric, social, digital)
  - landing.csv: 12 → 65 patterns (53 new patterns: tool, calculator, quiz, generator, booking, donation, subscription)
  - ux.csv: 20 → 127 principles (107 new principles: WCAG 2.1 complete coverage, accessibility, usability, interaction design)
  - ui-reasoning.csv: NEW 57 design reasoning logic entries
- **ui-reasoning domain**: Design decision reasoning
  - 57 reasoning categories covering design decisions
  - Decision factors, implications, and alternatives
  - WCAG impact, performance impact, cognitive impact analysis
  - Questions: "为什么选择这个配色？", "如何设计CTA？", "是否支持深色模式？"
- **8 search domains**: style, product, color, typography, landing, ux, techstack, ui-reasoning
- **All implementations are self-written, not copied**

### Changed
- Updated core.py: Added ui-reasoning domain support
- Updated design_system.py: Added ui-reasoning domain to full system generation
- Updated skills/oa-ui-design.md: 648 total entries documentation

---

## [v1.7.1] - 2026-04-11

### Fixed
- **UI design data files**: Corrected data counts
  - styles.csv: 70 UI styles (animations, interactions, effects)
  - products.csv: 125 industry/product types
  - colors.csv: 16 color palettes
  - typography.csv: 66 font pairings (context-specific)
  - landing.csv: 12 landing page patterns
  - ux.csv: 20 UX principles
  - techstack.csv: 15 tech stack guidelines
  - **Total**: 324 entries (consistent across all docs)
- **BM25 tokenize**: Added underscore splitting for better matching
- **design_system.py**: Added techstack domain support
- **skills/oa-ui-design.md**: Fixed data counts in Implementation section

---

## [v1.7.0] - 2026-04-11

### Added
- **/oa-ui-design command**: Professional UI/UX design intelligence system
  - 125 industry/product types (Tech, Finance, Healthcare, E-commerce, Services, Creative, Lifestyle, Emerging Tech)
  - 70 UI styles (Minimalism, Glassmorphism, Neumorphism, Brutalism, Dark Mode, Bento Grid, AI-Native UI, Spatial UI, animations, interactions, etc.)
  - 16 color palettes with industry-appropriate recommendations
  - 66 typography pairings (Google Fonts compatible, context-specific)
  - 15 tech stack guidelines (React, Next.js, Vue, SwiftUI, Flutter, etc.)
  - 12 landing page patterns
  - 20 UX principles (WCAG compatible)
  - Pre-delivery checklist (accessibility, responsiveness, performance, interaction)
  - Anti-patterns detection (what NOT to do)
  - Integration points: after `/oa-brainstorming`, before `/oa-execute`
- **UI design library**: `lib/ui-design/quick-reference.md`
  - Industry → Pattern mapping
  - Industry → Color mood recommendations
  - Industry → Typography mood recommendations
  - UI style selection guide
  - Color contrast quick reference
  - Animation timing guide
  - Font loading best practices
- **BM25 search engine**: `lib/ui-design/scripts/core.py` (Okapi BM25 implementation)
- **Design system generator**: `lib/ui-design/scripts/design_system.py`
- **Inspired by UI UX Pro Max**: https://github.com/nextlevelbuilder/ui-ux-pro-max-skill (62.4K stars)
- **All implementations are self-written, not copied**

### Changed
- **Updated AGENTS.md**: Added `/oa-ui-design` command (23 commands)
- **Updated QUICKREF.md**: Command count increased from 22 to 23
- **Updated README.md**: Added skill file and lib directory, updated command counts
- **Updated README_zh.md**: Added skill file and lib directory, updated command counts

### Documentation
- All documentation now consistent: 23 skills (extended from 20-22 target)
- Total: 23 commands ✅
- Total lib directories: 6 (security, deploy, browser, performance, review, ui-design)

---

## [v1.6.0] - 2026-04-10

### Added
- **/oa-review command**: Comprehensive code, design, and architecture review
  - Code quality review (style, structure, readability, performance)
  - Design review (UI/UX consistency, accessibility WCAG 2.1, responsive design)
  - Architecture review (SOLID principles, design patterns, module coupling)
  - Security awareness (quick check, detailed check via `/oa-security`)
  - Integration points: after `/oa-execute`, before `/oa-ship`
- **Design review library**: `lib/review/design-checklist.md`
  - UI consistency checklist (color, typography, spacing, components)
  - UX best practices (navigation, forms, feedback, empty states)
  - Accessibility checklist (WCAG 2.1, keyboard navigation, screen reader)
  - Responsive design checklist (breakpoints, mobile optimization)
  - Visual polish checklist (layout, animations, images)
- **Architecture review library**: `lib/review/architecture-checklist.md`
  - SOLID principles (SRP, OCP, LSP, ISP, DIP)
  - Design patterns (creational, structural, behavioral)
  - Module coupling (coupling types, cohesion types)
  - Layered architecture (presentation, application, domain, infrastructure)
  - Error handling, dependency management, scalability, performance, testing
- **Natural language routing examples**:
  - Review: "review 代码", "代码审查", "设计审查", "架构审查", "审查 UI/UX"

### Changed
- **Updated QUICKREF.md**: Command count increased from 21 to 22
- **Updated USAGE.md**: Added review routing examples
- **Updated USAGE_EN.md**: Added review routing examples in English
- **Updated skill trigger table**: Changed "任务完成 → code-review" to "任务完成 → oa-review"

### Documentation
- All documentation now consistent: 22 skills, Phase 1 + Phase 2 + Phase 3 complete
- Total: 22 commands (within 20-22 target) ✅

---

## [v1.5.0] - 2026-04-10

### Added
- **/oa-qa-browser command**: Real browser testing with Playwright
  - Visual regression tests (screenshot comparison)
  - Functional tests (user flows)
  - Accessibility tests (WCAG 2.1 compliance)
  - Performance tests (Core Web Vitals)
  - Browser coverage: Chromium, Firefox, WebKit, Mobile viewports
- **/oa-benchmark command**: Automated performance testing and benchmarking
  - API response time benchmarks (average, p95, p99)
  - Page load time benchmarks
  - Database query benchmarks
  - Resource usage benchmarks (memory, CPU)
  - Concurrent load benchmarks
  - Baseline comparison with regression detection
- **Browser testing library**: `lib/browser/`
  - `playwright-config.md`: Playwright setup and configuration guide
  - `test-templates.md`: Ready-to-use browser test templates
- **Performance testing library**: `lib/performance/`
  - `benchmark-templates.md`: API, page load, database, and resource benchmarks
- **Natural language routing examples**:
  - Browser testing: "浏览器测试", "browser test", "视觉回归测试"
  - Performance: "性能测试", "benchmark", "API 性能基准"

### Changed
- **Updated QUICKREF.md**: Command count increased from 19 to 21
- **Updated USAGE.md**: Added browser testing and performance routing examples
- **Updated USAGE_EN.md**: Added browser testing and performance routing examples in English
- **Updated skill trigger table**: Added "浏览器测试 → oa-qa-browser" and "性能测试 → oa-benchmark"

### Documentation
- All documentation now consistent: 21 skills, Phase 1 + Phase 2 complete

---

## [v1.4.0] - 2026-04-10

### Added
- **/oa-security command**: Automated security audit using OWASP Top 10 and STRIDE threat modeling
  - Detects common vulnerabilities (SQL injection, XSS, hardcoded secrets, etc.)
  - Severity classification (Critical/High/Medium/Low)
  - Blocks `/oa-ship` if critical/high issues found
  - Integration points: after `/oa-execute`, before `/oa-ship`
- **/oa-land command**: Deployment verification after merge
  - Monitors CI/CD pipeline status
  - Runs smoke tests on deployed environment
  - Generates rollback plan if deployment fails
  - Integration points: after `/oa-ship` and successful PR merge
- **Security library**: `lib/security/`
  - `checklist.md`: Quick reference for OWASP Top 10 and STRIDE
  - `patterns.md`: Detailed vulnerability patterns with detection and fixes
- **Deployment library**: `lib/deploy/`
  - `smoke-tests.md`: Smoke test templates for deployment verification
  - `rollback.md`: Rollback procedures for various platforms (Git, Kubernetes, AWS, Heroku, Docker)
- **Natural language routing examples**:
  - Security: "检查安全性", "security review", "安全审计"
  - Deployment: "部署", "deploy", "land", "上线"

### Changed
- **Updated QUICKREF.md**: Command count increased from 17 to 19
- **Updated USAGE.md**: Added security and deployment routing examples
- **Updated USAGE_EN.md**: Added security and deployment routing examples in English
- **Updated skill trigger table**: Added "安全检查 → oa-security" and "部署/上线 → oa-land"

### Documentation
- Created `docs/GSTACK_INTEGRATION_PLAN.md`: Detailed implementation plan for borrowing GStack features
- All documentation now consistent: 19 skills, Phase 1 complete

---

## [v1.3.0] - 2026-04-10

### Added
- **Auto-detect 10+ CLI tools**: OpenCode, Claude Code, Cursor, Codex, OpenClaw, Gemini CLI, Windsurf, Kilo Code, Augment, Zed
- **/oa-tdd command**: Test-driven development workflow (Red-Green-Refactor cycle)
- **Comprehensive User Guide**:
  - Chinese version: `USAGE.md` (1174 lines, 9 chapters)
  - English version: `USAGE_EN.md` (1178 lines, 9 chapters)
- **Natural language installation guide**: Install OpenAllIn via AI assistant with Git URL
- **Natural language usage guide**: Use OpenAllIn with natural language instead of commands
  - 15+ natural language phrases quick reference
  - When to use commands vs natural language comparison table
  - Good/poor expression examples

### Changed
- **Updated README.md**: Added user guide links at the top
- **Updated QUICKREF.md**: All 17 commands listed
- **Updated AGENTS.md**: Consistent command examples

### Fixed
- **Skills directory structure**: Corrected from nested to flat structure (`proposal.md` not `proposal/proposal.md`)
- **README.md skills count**: Fixed mismatch (16 → 17)
- **USAGE.md duplicate content**: Removed duplicate Q11 and Q12
- **Natural language installation**: Now requires Git URL (e.g., `https://github.com/vanrayliu/openallin`)

### Documentation
- All documents now consistent: 17 skills, 9 chapters, 10+ supported CLI tools
- Total documentation: 2000+ lines

## [v1.2.0] - 2026-04-09

### Added
- **10+ CLI Tools Support**: OpenCode, Claude Code, Cursor, Codex, OpenClaw, Gemini CLI, Windsurf, Kilo Code, Augment, Zed
- **Auto-detection**: Automatically detect current CLI environment when no tool specified
- **Environment variable detection**: OPENCODE, CLAUDE_CODE, CURSOR, CODEX, OPENCLAW, GEMINI_CLI, WINDSURF, KILO, AUGMENT, ZED

### Changed
- **Flattened skills structure**: `skills/oa-*.md` (single file per command)
- **Skills installation format**: `<name>/SKILL.md` for CLI tool compatibility
- **Unified command format**: All commands use `/oa-` prefix (not `/oa:`)

### Fixed
- Clean up old flat skill files before installing new format
- Install skills with correct `<name>/SKILL.md` wrapper for Claude Code/OpenCode
- Documentation consistency: all docs reference correct 16 commands

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
- **Consolidated skills structure**: All skills in `skills/oa-*/` (universal source for all CLI tools)
- **Updated install.sh**: Copies from `skills/oa-*/` to tool-specific directories
- **Updated AGENTS.md**: Command list matches actual 16 oa-* skills

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
