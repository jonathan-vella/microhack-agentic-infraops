---
description: "Step 5: Migrate Getting Started content — setup guide and workshop prep. Heaviest callout + details block conversion (17 callouts, 24 details blocks)."
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

# Site Step 5: Migrate Getting Started

## Mission

Migrate the Getting Started content: `getting-started.md` → `docs/getting-started/setup.md` and `workshop-prep.md` → `docs/getting-started/workshop-prep.md`. This is the heaviest transformation step due to 17 callouts and 24 `<details>` blocks in getting-started.md alone.

## Prerequisites

- Step 4 complete (`docs/getting-started/index.md` exists with `has_children: true`)

## Context to Load

1. Read the session tracker: `.github/exec-plans/active/site-execution.md` — verify C1 is the current step
2. Read the transformation rules in the tracker (section "Transformation Rules")
3. Read source files:
   - `import/docs/getting-started.md` (640 lines)
   - `import/docs/workshop-prep.md` (296 lines)

## Transformation Rules (from tracker)

Apply ALL of these to every file:

### 1. Callout Conversion
Remove the `> [!TYPE]` line. Keep blockquote content. Add `{: .type }` after the closing blockquote.

Example:
```markdown
<!-- BEFORE (GitHub-flavored) -->
> [!WARNING]
> This is a warning message
> that spans multiple lines.

<!-- AFTER (just-the-docs) -->
> This is a warning message
> that spans multiple lines.
{: .warning }
```

Mapping:
- `> [!WARNING]` → `{: .warning }`
- `> [!TIP]` → `{: .tip }`
- `> [!NOTE]` → `{: .note }`
- `> [!IMPORTANT]` → `{: .important }`

### 2. `<details>` Blocks
Add `markdown="1"` to every `<details>` tag:
- `<details>` → `<details markdown="1">`
- `<details open>` → `<details open markdown="1">`

### 3. Repo URL Rewriting
Replace all occurrences: `azure-agentic-infraops-workshop` → `microhack-agentic-infraops`

### 4. Internal Link Fixing
Update relative paths to reflect new location in `docs/getting-started/`:
- Links to other challenge files → `../challenges/challenge-N-*.md`
- Links to copilot-guide → `../guides/copilot-guide.md`
- Links to troubleshooting → `../reference/troubleshooting.md`

## Tasks

### Task 1: Migrate `getting-started.md` → `docs/getting-started/setup.md`

**Frontmatter:**
```yaml
---
layout: default
title: Setup Guide
parent: Getting Started
nav_order: 1
description: "Complete environment setup: Azure subscription, GitHub Codespace, VS Code extensions, and verification"
---
```

**Transformations needed:**
- Callouts: 17 total (TIP ×4, WARNING ×6, IMPORTANT ×4, NOTE ×3)
- `<details>` blocks: 24 (ALL need `markdown="1"`)
- Repo URLs: 2 occurrences (git clone + cd commands around line 382-383)
- Internal links: Check all relative links and update paths

**Approach:**
1. Read the entire source file
2. Add frontmatter
3. Convert all 17 callouts systematically (work top-to-bottom)
4. Add `markdown="1"` to all 24 `<details>` tags
5. Fix the 2 repo URLs
6. Fix any internal relative links
7. Write the complete output file

### Task 2: Migrate `workshop-prep.md` → `docs/getting-started/workshop-prep.md`

**Frontmatter:**
```yaml
---
layout: default
title: Workshop Prep & Scenario
parent: Getting Started
nav_order: 2
description: "Business scenario details, team roles, and preparation checklist for Nordic Fresh Foods"
---
```

**Transformations needed:**
- Check for callouts (may have none — verify)
- Check for `<details>` blocks
- Check for repo URLs
- Fix internal relative links

## Completion Criteria

- [ ] `docs/getting-started/setup.md` exists with:
  - Correct frontmatter (parent: Getting Started, nav_order: 1)
  - All 17 callouts converted to just-the-docs syntax
  - All 24 `<details>` blocks have `markdown="1"`
  - Repo URLs rewritten (2 occurrences)
  - No broken internal links
- [ ] `docs/getting-started/workshop-prep.md` exists with:
  - Correct frontmatter (parent: Getting Started, nav_order: 2)
  - All applicable transformations applied

## After Completion

Update the session tracker (`.github/exec-plans/active/site-execution.md`):
1. Check off C1 and C2 items individually (one per file)
2. Update "Current Session Target" to D1
3. Append a session log entry
