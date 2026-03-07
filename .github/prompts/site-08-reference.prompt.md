---
description: "Step 8: Migrate reference content — glossary, troubleshooting, governance scripts documentation."
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

# Site Step 8: Migrate Reference

## Mission

Migrate the three reference files to `docs/reference/`: glossary, troubleshooting, and governance scripts documentation. The governance scripts page is a new consolidation (not a direct 1:1 migration).

## Prerequisites

- Step 4 complete (`docs/reference/index.md` exists with `has_children: true`)

## Context to Load

1. Read the session tracker: `.github/exec-plans/active/site-execution.md` — verify F1 is the current step
2. Read the transformation rules in the tracker
3. Read source files:
   - `import/docs/GLOSSARY.md` (127 lines)
   - `import/docs/troubleshooting.md` (187 lines)
   - `import/microhack/scripts/README.md` (line count varies)

## Tasks

### Task 1: Migrate `GLOSSARY.md` → `docs/reference/glossary.md` (F1)

**Frontmatter:**
```yaml
---
layout: default
title: Glossary
parent: Reference
nav_order: 1
description: "Definitions of key terms used throughout the workshop"
---
```

**Transformations:**
- Convert filename from GLOSSARY.md to glossary.md (lowercase)
- Add alphabetical anchor links if not already present (the glossary likely has terms organized by letter)
- Check for callouts (unlikely but verify)
- No expected repo URLs or facilitator links

### Task 2: Migrate `troubleshooting.md` → `docs/reference/troubleshooting.md` (F2)

**Frontmatter:**
```yaml
---
layout: default
title: Troubleshooting
parent: Reference
nav_order: 2
description: "Common issues and solutions for environment setup, Azure deployments, and agent interactions"
---
```

**Transformations:**
- Check for callouts and convert
- Fix internal links (references to other docs)
- Check for `<details>` blocks

### Task 3: Create `docs/reference/governance-scripts.md` (F3)

This is a NEW consolidated page based on `import/microhack/scripts/README.md`.

**Frontmatter:**
```yaml
---
layout: default
title: Governance Scripts
parent: Reference
nav_order: 3
description: "Azure Policy governance scripts for workshop environment setup"
---
```

**Content approach:**
- Read `import/microhack/scripts/README.md` for the documentation content
- Reference the actual `.ps1` script files by their repo paths (they stay in `import/microhack/scripts/`, not in `docs/`)
- Use full GitHub repo URLs for script links: `https://github.com/jonathan-vella/microhack-agentic-infraops/blob/main/import/microhack/scripts/{filename}`
- Document what each script does (Setup-GovernancePolicies.ps1, Remove-GovernancePolicies.ps1, Get-GovernanceStatus.ps1)
- Apply repo URL rewriting if the source references the old repo name

## Completion Criteria

- [ ] `docs/reference/glossary.md` exists with frontmatter + clean formatting
- [ ] `docs/reference/troubleshooting.md` exists with frontmatter + callouts converted
- [ ] `docs/reference/governance-scripts.md` exists with:
  - Script documentation from README.md
  - Correct GitHub repo URLs to .ps1 files
  - No old repo name references

## After Completion

Update the session tracker (`.github/exec-plans/active/site-execution.md`):
1. Check off F1, F2, F3 items individually
2. Update "Current Session Target" to G1
3. Append a session log entry
