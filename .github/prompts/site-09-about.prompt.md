---
description: "Step 9: Migrate about content — agenda (meaning preserved), workshop invitation, feedback form."
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

# Site Step 9: Migrate About

## Mission

Migrate the three about files to `docs/about/`: agenda, invitation, and feedback form. The agenda requires special care — content meaning must be preserved but links, callouts, and repo URLs must be adapted for Jekyll.

## Prerequisites

- Step 4 complete (`docs/about/index.md` exists with `has_children: true`)

## Context to Load

1. Read the session tracker: `.github/exec-plans/active/site-execution.md` — verify G1 is the current step
2. Read the transformation rules in the tracker (especially the facilitator link strategy)
3. Read source files:
   - `import/microhack/AGENDA.md` (154 lines) — READ CAREFULLY, special handling
   - `import/microhack/workshop-invitation.md` (103 lines)
   - `import/microhack/feedback-form.md` (175 lines)

## Tasks

### Task 1: Migrate `AGENDA.md` → `docs/about/agenda.md` (G1)

**SPECIAL HANDLING**: Content meaning preserved. Links and callout syntax adapted for Jekyll.

**Frontmatter:**
```yaml
---
layout: default
title: Agenda
parent: About
nav_order: 1
description: "Detailed 6-hour workshop agenda with timing, activities, and facilitator notes"
---
```

**Known transformations required:**
1. **Callout (line ~51)**: `> [!NOTE]` → convert to just-the-docs `{: .note }` syntax
2. **Facilitator link (line ~52)**: `[facilitator-guide.md](facilitator/facilitator-guide.md)` → convert to full GitHub repo URL: `[facilitator-guide.md](https://github.com/jonathan-vella/microhack-agentic-infraops/blob/main/import/microhack/facilitator/facilitator-guide.md)`
3. **Facilitator link (line ~153)**: Same treatment as above
4. **Getting started link (line ~154)**: `(../docs/getting-started.md)` → fix to site-relative path: `({{ site.baseurl }}/getting-started/setup/)` or `(../getting-started/setup.md)`
5. **Repo URL (line ~151)**: `azure-agentic-infraops-workshop` → `microhack-agentic-infraops`

**All other content MUST remain identical.** Do not rewrite, rephrase, or restructure any text, tables, or headings. Only the 5 specific transformations above should change the file.

### Task 2: Migrate `workshop-invitation.md` → `docs/about/invitation.md` (G2)

**Frontmatter:**
```yaml
---
layout: default
title: Workshop Invitation
parent: About
nav_order: 2
description: "Event invitation details — what to expect, what to bring, and how to prepare"
---
```

**Transformations:**
- Repo URL (line ~67): getting started link with old repo name → rewrite
- Check for callouts (verify)
- Fix internal links

### Task 3: Migrate `feedback-form.md` → `docs/about/feedback.md` (G3)

**Frontmatter:**
```yaml
---
layout: default
title: Feedback Form
parent: About
nav_order: 3
description: "Workshop feedback form — help us improve future events"
---
```

**Transformations:**
- Callout (line ~5): `> [!TIP]` → `{: .tip }` syntax
- Check for Microsoft Forms URL placeholder — preserve as-is (will be updated when live URL is available)

## Completion Criteria

- [ ] `docs/about/agenda.md` exists with:
  - Correct frontmatter
  - Callout converted (1 instance)
  - Facilitator links converted to full GitHub repo URLs (2 instances)
  - Getting started link fixed
  - Repo URL rewritten
  - ALL other content byte-identical to source (verify with diff minus frontmatter + 5 changes)
- [ ] `docs/about/invitation.md` exists with frontmatter + repo URL rewritten
- [ ] `docs/about/feedback.md` exists with frontmatter + callout converted

## After Completion

Update the session tracker (`.github/exec-plans/active/site-execution.md`):
1. Check off G1, G2, G3 items individually
2. Update "Current Session Target" to H1
3. Append a session log entry
