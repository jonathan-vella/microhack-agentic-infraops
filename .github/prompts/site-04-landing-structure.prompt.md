---
description: "Step 4: Create landing page and section index pages. Establishes the site navigation hierarchy."
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

# Site Step 4: Landing Page & Section Structure

## Mission

Create the landing page (`docs/index.md`) and all 5 section index pages. The landing page synthesizes content from multiple source files into a compelling entry point. Section indexes establish the `has_children: true` navigation hierarchy.

## Prerequisites

- Step 2 complete (`docs/_config.yml` exists)
- Step 3 complete (SCSS and assets exist)

## Context to Load

1. Read the session tracker: `.github/exec-plans/active/site-execution.md` — verify B1 is the current step
2. Read these source files (content extraction sources):
   - `import/microhack/README.md` — business scenario, scoring, learning objectives, Mermaid diagrams
   - `import/microhack/workshop-invitation.md` — tagline, event summary
   - `import/microhack/challenges/README.md` — challenge workflow diagram (Mermaid)
   - `import/microhack/AGENDA.md` — schedule table

## Tasks

### Task 1: Create `docs/index.md` — Landing Page

**Frontmatter:**
```yaml
---
layout: default
title: Home
nav_order: 1
description: "Agentic InfraOps MicroHack — 6-hour hands-on workshop: Design, deploy, and present Azure infrastructure using AI agents and GitHub Copilot"
permalink: /
---
```

**Content extraction map** (what goes where from source files):

| Source File | Section/Lines | What to Extract | Landing Page Section |
|---|---|---|---|
| `workshop-invitation.md` | Title + first paragraph | Event tagline, one-liner | Hero section |
| `microhack/README.md` | "What is this MicroHack?" | Summary paragraph | About section |
| `microhack/README.md` | Learning Objectives list | 5 learning objectives | Objectives section |
| `microhack/README.md` | Business Scenario section | Nordic Fresh Foods teaser | Scenario teaser |
| `microhack/README.md` | Scoring table | Points breakdown (105 + 25) | Key facts |
| `AGENDA.md` | Schedule table | Time/Activity overview | Schedule Gantt (new Mermaid) |
| — | New content | Navigation cards to sections | Nav cards |

**Structure:**
1. Hero: Title + tagline + "Get Started" CTA button
2. What is this MicroHack? (2-3 sentences)
3. Schedule overview (Mermaid Gantt chart — create NEW, don't copy from source)
4. Key facts: 6 hours, 8 challenges, 105 + 25 bonus points
5. Learning objectives (bullet list from microhack/README.md)
6. Business scenario teaser (Nordic Fresh Foods — brief)
7. Navigation cards: Getting Started, Challenges, Guides, Reference, About

**Important:**
- Rewrite content in your own words — don't copy verbatim (avoid duplication)
- Apply repo URL rewriting rule: `azure-agentic-infraops-workshop` → `microhack-agentic-infraops`
- Use the nav-card-grid CSS classes from Step 3

### Task 2: Create 5 Section Index Pages

Each section index page needs `has_children: true` in frontmatter. Keep them SHORT (10-30 lines of content). They serve as navigation waypoints, not full content pages.

#### `docs/getting-started/index.md`
```yaml
---
layout: default
title: Getting Started
nav_order: 2
has_children: true
description: "Set up your environment and learn the workshop scenario"
---
```
Short intro: 2-3 sentences about what this section covers (environment setup, prerequisites, scenario background). Link to the children.

#### `docs/challenges/index.md`
```yaml
---
layout: default
title: Challenges
nav_order: 3
has_children: true
description: "8 challenges taking you from requirements to partner showcase"
---
```
Content: Challenge overview table (number, name, duration, points) + the workflow Mermaid diagram from `import/microhack/challenges/README.md`. This is a more substantial index page (the challenge table is valuable context).

#### `docs/guides/index.md`
```yaml
---
layout: default
title: Guides
nav_order: 4
has_children: true
description: "Copilot guides, hints, and quick reference for the workshop"
---
```
Short intro: What guides are available and when to use them.

#### `docs/reference/index.md`
```yaml
---
layout: default
title: Reference
nav_order: 5
has_children: true
description: "Glossary, troubleshooting, and governance scripts reference"
---
```
Short intro: Reference materials for during and after the workshop.

#### `docs/about/index.md`
```yaml
---
layout: default
title: About
nav_order: 6
has_children: true
description: "Agenda, event details, and feedback"
---
```
Short intro: Event logistics and meta-information.

## Completion Criteria

- [ ] `docs/index.md` exists with hero, schedule, objectives, scenario, nav cards
- [ ] `docs/getting-started/index.md` exists (short, has_children: true)
- [ ] `docs/challenges/index.md` exists (challenge table + Mermaid workflow diagram)
- [ ] `docs/guides/index.md` exists (short, has_children: true)
- [ ] `docs/reference/index.md` exists (short, has_children: true)
- [ ] `docs/about/index.md` exists (short, has_children: true)
- [ ] All frontmatter has correct nav_order values

## After Completion

Update the session tracker (`.github/exec-plans/active/site-execution.md`):
1. Check off B1 and B2 items
2. Update "Current Session Target" to C1
3. Append a session log entry
