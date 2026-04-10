# GStack Integration Plan

> Borrowing proven practices from GStack (68.6K stars) while keeping OpenAllIn lightweight.

## Overview

**Goal**: Integrate GStack's best practices into OpenAllIn, adding 3-5 commands while maintaining the lightweight philosophy.

**Phases**: 3 phases over 3-4 weeks

**Philosophy**: Borrow concepts, not copy implementations. Keep OpenAllIn focused on spec-driven development.

---

## Phase 1: Security + Deploy (1 week)

### 1. `/oa-security` — Security Audit

**Borrowed from**: GStack `/cso` (CSO skill)

**Concept**: Automated security review using OWASP Top 10 and STRIDE threat modeling.

**Implementation**:
- Add `skills/oa-security.md` skill
- Security checklist:
  - OWASP Top 10 (A01-A10)
  - STRIDE threat categories
  - Input validation, auth, crypto, logging
- Integration points:
  - Called after `/oa-ship` automatically
  - Can be invoked manually: `/oa-security`
- Output format:
  - Security findings report
  - Risk severity (Critical/High/Medium/Low)
  - Remediation recommendations

**Deliverables**:
- `skills/oa-security.md`
- `lib/security/checklist.md` (OWASP + STRIDE)
- `lib/security/patterns.md` (common vulnerability patterns)

**Estimated effort**: 2-3 hours

---

### 2. `/oa-land` — Land and Deploy

**Borrowed from**: GStack `/land-and-deploy`

**Concept**: Verify deployment after merge. Catch deployment issues early.

**Implementation**:
- Add `skills/oa-land.md` skill
- Workflow:
  1. Merge PR to main
  2. Trigger CI/CD pipeline
  3. Verify deployment succeeds
  4. Run smoke tests on deployed environment
  5. Rollback if critical issues detected
- Integration points:
  - After `/oa-ship` and `/oa-merge`
  - Manual invocation: `/oa-land`
- Output format:
  - Deployment status (Success/Failed)
  - Environment URL
  - Smoke test results
  - Rollback instructions (if needed)

**Deliverables**:
- `skills/oa-land.md`
- `lib/deploy/smoke-tests.md` (smoke test templates)
- `lib/deploy/rollback.md` (rollback procedures)

**Estimated effort**: 2 hours

---

### 3. Natural Language Router

**Borrowed from**: GStack natural language routing

**Concept**: Route natural language requests to appropriate skills without explicit command.

**Implementation**:
- Update `USAGE.md` and `USAGE_EN.md` with routing examples
- Add routing logic to AGENTS.md
- Common patterns:
  - "测试这个功能" → `/oa-test`
  - "写个计划" → `/oa-plan`
  - "部署到生产" → `/oa-land`
  - "检查安全性" → `/oa-security`
  - "修复这个bug" → `/oa-debugging`
- Ambiguity resolution:
  - If unsure, ask user to clarify
  - Provide command suggestions

**Deliverables**:
- Updated USAGE.md / USAGE_EN.md
- Routing examples in AGENTS.md

**Estimated effort**: 1 hour

---

## Phase 2: Browser Testing + Benchmark (1-2 weeks)

### 4. `/oa-qa-browser` — Browser Testing

**Borrowed from**: GStack `/qa` + `/browse`

**Concept**: Real browser testing with Playwright. Visual and functional validation.

**Implementation**:
- Add `skills/oa-qa-browser.md` skill
- Test types:
  - Visual regression (screenshot comparison)
  - Functional tests (user flows)
  - Accessibility checks (WCAG 2.1)
  - Performance metrics (Core Web Vitals)
- Browser coverage:
  - Chrome, Firefox, Safari (desktop)
  - Mobile viewport testing
- Integration points:
  - After `/oa-execute` (optional)
  - Manual: `/oa-qa-browser`
- Output format:
  - Test results (passed/failed)
  - Visual diffs (if regression)
  - Accessibility score
  - Performance metrics

**Deliverables**:
- `skills/oa-qa-browser.md`
- `lib/browser/playwright-config.md`
- `lib/browser/test-templates.md`

**Estimated effort**: 4-6 hours

---

### 5. `/oa-benchmark` — Performance Testing

**Borrowed from**: GStack performance benchmarking concepts

**Concept**: Automated performance testing and benchmarking.

**Implementation**:
- Add `skills/oa-benchmark.md` skill
- Benchmark types:
  - API response time
  - Page load time
  - Database query performance
  - Memory/CPU usage
- Integration points:
  - After `/oa-qa-browser`
  - Manual: `/oa-benchmark`
- Output format:
  - Benchmark results
  - Comparison with baseline
  - Performance regression alerts

**Deliverables**:
- `skills/oa-benchmark.md`
- `lib/performance/benchmark-templates.md`

**Estimated effort**: 3-4 hours

---

## Phase 3: Enhanced Review (1 week)

### 6. Enhanced `/oa-review`

**Borrowed from**: GStack `/design-shotgun` + `/design-html`

**Concept**: Add design and architecture review to existing `/oa-review`.

**Enhancement areas**:
- Design review:
  - UI/UX consistency
  - Accessibility (WCAG 2.1)
  - Responsive design
  - Color contrast, typography
- Architecture review:
  - SOLID principles
  - Design patterns usage
  - Module coupling analysis
  - Dependency check

**Implementation**:
- Update `skills/oa-review.md` with design/architecture sections
- Add checklists to `lib/review/`
- Keep existing code review functionality

**Deliverables**:
- Updated `skills/oa-review.md`
- `lib/review/design-checklist.md`
- `lib/review/architecture-checklist.md`

**Estimated effort**: 2-3 hours

---

## Success Metrics

**Phase 1 Success**:
- `/oa-security` catches at least 1 security issue per project
- `/oa-land` detects deployment issues before production
- Natural language routing works for 80% of common requests

**Phase 2 Success**:
- `/oa-qa-browser` catches visual regressions
- `/oa-benchmark` identifies performance bottlenecks

**Phase 3 Success**:
- Enhanced `/oa-review` improves design consistency

---

## Command Count Impact

**Before**: 17 commands (`/oa-*`)

**After Phase 1**: +2 commands (security, land) = 19 commands

**After Phase 2**: +2 commands (qa-browser, benchmark) = 21 commands

**After Phase 3**: +1 command (review) = 22 commands

**Total**: 22 commands (lightweight, within 20-22 target) ✅

---

## Implementation Guidelines

1. **Keep it simple**: Each skill should be a single markdown file
2. **Checklist-driven**: Use checklists, not complex logic
3. **Optional integration**: New commands are optional, not mandatory
4. **User control**: User can skip any automated step
5. **Documentation first**: Write skill before implementing libraries

---

## Next Actions

1. **Create Phase 1 files**:
   - `skills/oa-security.md`
   - `lib/security/checklist.md`
   - `lib/security/patterns.md`
   - `skills/oa-land.md`
   - `lib/deploy/smoke-tests.md`

2. **Update documentation**:
   - USAGE.md (natural language routing)
   - USAGE_EN.md (natural language routing)
   - QUICKREF.md (add new commands)

3. **Test Phase 1**:
   - Test `/oa-security` on existing code
   - Test `/oa-land` on deployment workflow

4. **Publish Phase 1**:
   - Merge to main
   - Tag as v1.4.0
   - Update CHANGELOG

---

## Dependencies

**Phase 1**:
- No external dependencies (checklist-based)

**Phase 2**:
- Playwright (browser testing)
- Lighthouse (performance metrics)

**Phase 3**:
- No external dependencies (checklist-based)

---

## Risks and Mitigations

| Risk | Mitigation |
|------|------------|
| Over-engineering | Keep skills as checklists, not complex tools |
| Scope creep | Limit to 3-5 new commands |
| Documentation burden | Update USAGE incrementally |
| Testing overhead | Make browser testing optional |
| Learning curve | Natural language routing reduces complexity |

---

## Timeline

**Week 1**: Phase 1 (security + deploy + routing)

**Week 2-3**: Phase 2 (browser testing + benchmark)

**Week 4**: Phase 3 (enhanced review) + documentation

---

## Comparison with GStack

| Feature | GStack | OpenAllIn |
|---------|--------|-----------|
| Security audit | `/cso` (CSO skill) | `/oa-security` (checklist) |
| Deployment | `/land-and-deploy` | `/oa-land` (checklist) |
| Browser testing | `/qa` + `/browse` | `/oa-qa-browser` (Playwright) |
| Design review | `/design-shotgun` | Enhanced `/oa-review` |
| Benchmark | Performance tests | `/oa-benchmark` |
| Multi-agent | `/pair-agent` | Team orchestration (existing) |

**Key difference**: OpenAllIn keeps it simple with checklist-driven skills, while GStack has full AI orchestration.

---

## Open Questions

1. Should `/oa-security` be mandatory after `/oa-ship`?
   - Recommendation: Optional, user can enable auto-run

2. Should `/oa-qa-browser` require Playwright setup?
   - Recommendation: Optional, provide setup guide

3. Should `/oa-benchmark` compare against production baseline?
   - Recommendation: Optional, user provides baseline

---

## Conclusion

This plan borrows GStack's proven concepts while maintaining OpenAllIn's lightweight philosophy. The result: 22 commands (within 20-22 target) that add security, deployment, testing, and design capabilities.