---
description: "Step 7: Migrate guide content — Copilot guide, hints & tips, quick reference card. Includes details block conversion and facilitator link cleanup."
model: Claude Opus 4.6
tools:
  - edit/editFiles
  - read/readFile
  - search/codebase
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/problems
  - todo
---

# Site Step 7: Migrate Guides

## Mission

Migrate the three guide files to `docs/guides/`: copilot-guide.md, hints-and-tips.md, and quick-reference-card.md. Key challenges: hints-and-tips has 10 `<details>` blocks, quick-reference-card has a facilitator link and a Mermaid code example that must NOT render as a live diagram.

## Prerequisites

- Step 4 complete (`docs/guides/index.md` exists with `has_children: true`)

## Context to Load

1. Read the session tracker: `.github/exec-plans/active/site-execution.md` — verify E1 is the current step
2. Read the transformation rules in the tracker
3. Read source files:
   - `import/docs/copilot-guide.md` (361 lines)
   - `import/docs/hints-and-tips.md` (614 lines)
   - `import/docs/quick-reference-card.md` (235 lines)

## Tasks

### Task 1: Migrate `copilot-guide.md` → `docs/guides/copilot-guide.md` (E1)

**Frontmatter:**
```yaml
---
layout: default
title: Copilot & Agents Guide
parent: Guides
nav_order: 1
description: "How to use GitHub Copilot and AI agents effectively during the workshop"
---
```

**Transformations:**
- Callouts: 1 (TIP at line ~75)
- No `<details>` blocks
- No Mermaid diagrams (verified — plan was wrong about this)
- Fix internal links to other docs

### Task 2: Migrate `hints-and-tips.md` → `docs/guides/hints-and-tips.md` (E2)

**Frontmatter:**
```yaml
---
layout: default
title: Hints & Tips
parent: Guides
nav_order: 2
description: "Practical hints, tips, and role-specific guidance for each challenge"
---
```

**Transformations:**
- `<details>` blocks: 10 (ALL need `markdown="1"`)
- Check for callouts (may have none — verify by reading the file)
- Fix internal links

### Task 3: Migrate `quick-reference-card.md` → `docs/guides/quick-reference-card.md` (E3)

**Frontmatter:**
```yaml
---
layout: default
title: Quick Reference Card
parent: Guides
nav_order: 3
description: "At-a-glance reference card for challenges, scoring, agents, and key commands"
---
```

**Transformations:**
- Facilitator link: Line ~34 has `[Scoring Rubric](../microhack/facilitator/scoring-rubric.md)` — replace with descriptive text (e.g., "Scoring Rubric (available from facilitator)")
- Mermaid code example: Line ~129 uses 4-backtick fencing (` ````mermaid `). This is documentation OF Mermaid syntax, NOT a live diagram. **Verify it does NOT render as a live Mermaid chart** in Jekyll. If it does (because just-the-docs processes all mermaid-fenced blocks), wrap it differently to prevent rendering (e.g., use ```` ```text ```` or escape it).
- Fix internal links (links to challenge files, other docs)

## Completion Criteria

- [ ] `docs/guides/copilot-guide.md` exists with frontmatter + callout converted
- [ ] `docs/guides/hints-and-tips.md` exists with frontmatter + 10 `<details>` blocks have `markdown="1"`
- [ ] `docs/guides/quick-reference-card.md` exists with:
  - Facilitator link removed/rewritten
  - Mermaid code example verified (must show as code, not live chart)
  - Internal links fixed

## After Completion

Update the session tracker (`.github/exec-plans/active/site-execution.md`):
1. Check off E1, E2, E3 items individually
2. Update "Current Session Target" to F1
3. Append a session log entry
