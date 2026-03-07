# Exec Plan: GitHub Pages Site Build

> Living session state tracker. Updated at the END of every session.
> Read this file FIRST at the start of any new session.

**Status**: Active
**Owner**: Human + Copilot agents
**Created**: 2026-03-07
**Plan**: `.github/prompts/plan-agenticInfraOpsMicrohack.prompt.md`
**Adversarial review**: `.github/exec-plans/active/adversarial-review-01.md`

---

## Current Session Target

<!-- Update this at the START of each session -->

**Phase**: G (About)
**Step**: G1 — Migrate AGENDA.md
**Prompt**: `site-09-about.prompt.md`
**Goal**: Migrate agenda.md, invitation.md, feedback.md to docs/about/
**Blockers**: Smoke test deferred (no Ruby in WSL environment — will run in devcontainer or CI)

---

## Phase Progress

### Phase A — Foundation (Steps 1-3)

**Prompt sequence**: site-01, site-02, site-03

- [x] A1: Create `.devcontainer/devcontainer.json` (Jekyll 2-bookworm, Node.js LTS, VS Code extensions)
- [x] A1: Create `.devcontainer/README.md` (usage docs)
- [x] A2: Create `docs/Gemfile` (jekyll ~4.4, just-the-docs ~0.10, html-proofer ~5.0)
- [x] A2: Create `docs/_config.yml` (theme, callouts, mermaid, search, nav)
- [x] A2: Create `.github/workflows/pages.yml` (GitHub Actions build from docs/)
- [x] A2: Create `docs/404.md` (custom 404 page)
- [x] A2: Create `docs/.gitignore` (_site/, .jekyll-cache/, vendor/)
- [x] A3: Create `docs/_sass/custom/custom.scss` (Azure blue #0078D4, callout styles, challenge cards, print CSS, `<details>` styling)
- [x] A3: Create `docs/assets/images/logo.svg` (event-branded SVG logo)
- [x] A3: Create `docs/assets/images/favicon.svg` + `_includes/head_custom.html` (SVG favicon — modern browsers)
- [x] A3: Create `docs/_includes/challenge_header.html` (Liquid template: duration, points, agent, output params)
- [ ] **Smoke test**: `cd docs && bundle install && bundle exec jekyll build` — DEFERRED (no Ruby in WSL; run in devcontainer or CI)

### Phase B — Structure (Step 4)

**Prompt**: site-04

- [x] B1: Create `docs/index.md` (landing page — hero, CTA, schedule, navigation cards)
  - Extract from: `import/microhack/README.md` (business scenario, scoring, learning objectives)
  - Extract from: `import/microhack/workshop-invitation.md` (tagline, one-liner)
  - New: Mermaid Gantt schedule overview
- [x] B2: Create `docs/getting-started/index.md` (section index — short intro, has_children: true)
- [x] B2: Create `docs/challenges/index.md` (section index — challenge overview table + workflow diagram from README.md)
- [x] B2: Create `docs/guides/index.md` (section index — short intro, has_children: true)
- [x] B2: Create `docs/reference/index.md` (section index — short intro, has_children: true)
- [x] B2: Create `docs/about/index.md` (section index — short intro, has_children: true)

### Phase C — Content Migration: Getting Started (Step 5)

**Prompt**: site-05

Transformation rules for ALL migration steps:

1. Add YAML frontmatter (layout, title, nav_order, parent, description)
2. Convert callouts: `> [!WARNING]` → `{: .warning }`, `> [!TIP]` → `{: .tip }`, `> [!NOTE]` → `{: .note }`, `> [!IMPORTANT]` → `{: .important }`
3. Add `markdown="1"` to ALL `<details>` tags
4. Rewrite repo URLs: `azure-agentic-infraops-workshop` → `microhack-agentic-infraops`
5. Fix internal cross-links to new relative paths
6. Remove/rewrite facilitator content links (convert to GitHub repo URLs or descriptive text)

- [x] C1: Migrate `import/docs/getting-started.md` → `docs/getting-started/setup.md`
  - Callouts: 16 (TIP ×3, WARNING ×6, IMPORTANT ×4, NOTE ×3)
  - `<details>` blocks: 24 (all need `markdown="1"`)
  - Repo URLs: 2 (git clone + cd)
- [x] C2: Migrate `import/docs/workshop-prep.md` → `docs/getting-started/workshop-prep.md`

### Phase D — Content Migration: Challenges (Step 6)

**Prompt**: site-06

- [x] D1: Create `docs/challenges/index.md` content (merge challenges/README.md workflow diagram + AGENDA schedule extract)
  - Mermaid diagram from: `import/microhack/challenges/README.md` (1 flowchart)
- [x] D2: Migrate `challenge-1-requirements.md` → `docs/challenges/challenge-1-requirements.md`
  - Add challenge_header include (Duration: 30min, Points: 20, Agent: requirements)
- [x] D3: Migrate `challenge-2-architecture.md` → `docs/challenges/challenge-2-architecture.md`
  - Callouts: 1 (NOTE), Facilitator link: 1 (scoring-rubric.md → remove/rewrite)
- [x] D4: Migrate `challenge-3-implementation.md` → `docs/challenges/challenge-3-implementation.md`
  - Callouts: 1 (NOTE), Facilitator link: 1, Mermaid: 1, Repo URL: 1 (governance scripts)
- [x] D5: Migrate `challenge-4-dr-curveball.md` → `docs/challenges/challenge-4-dr-curveball.md`
  - Callouts: 1 (NOTE), Facilitator link: 1
- [x] D6: Migrate `challenge-5-load-testing.md` → `docs/challenges/challenge-5-load-testing.md`
  - Callouts: 1 (NOTE), Facilitator link: 1
- [x] D7: Migrate `challenge-6-documentation.md` → `docs/challenges/challenge-6-documentation.md`
  - Callouts: 1 (NOTE), Facilitator link: 1
- [x] D8: Migrate `challenge-7-diagnostics.md` → `docs/challenges/challenge-7-diagnostics.md`
- [x] D9: Migrate `challenge-8-partner-showcase.md` → `docs/challenges/challenge-8-partner-showcase.md`
  - Mermaid: 1 (timeline diagram)

### Phase E — Content Migration: Guides (Step 7)

**Prompt**: site-07

- [x] E1: Migrate `import/docs/copilot-guide.md` → `docs/guides/copilot-guide.md`
  - Callouts: 1 (TIP)
- [x] E2: Migrate `import/docs/hints-and-tips.md` → `docs/guides/hints-and-tips.md`
  - `<details>` blocks: 10 (all need `markdown="1"`)
- [x] E3: Migrate `import/docs/quick-reference-card.md` → `docs/guides/quick-reference-card.md`
  - Facilitator link: 1 (scoring-rubric → rewrite to GitHub URL or descriptive text)
  - Mermaid: 1 (4-backtick code example — must NOT render as live chart, verify)

### Phase F — Content Migration: Reference (Step 8)

**Prompt**: site-08

- [x] F1: Migrate `import/docs/GLOSSARY.md` → `docs/reference/glossary.md`
- [x] F2: Migrate `import/docs/troubleshooting.md` → `docs/reference/troubleshooting.md`
- [x] F3: Create `docs/reference/governance-scripts.md` (consolidate `import/microhack/scripts/README.md`)

### Phase G — Content Migration: About (Step 9)

**Prompt**: site-09

- [ ] G1: Migrate `import/microhack/AGENDA.md` → `docs/about/agenda.md`
  - Content meaning preserved; links and callout syntax adapted for Jekyll
  - Callouts: 1 (NOTE)
  - Facilitator links: 2 (rewrite to GitHub repo URLs)
  - Repo URL: 1 (old repo name → new)
- [ ] G2: Migrate `import/microhack/workshop-invitation.md` → `docs/about/invitation.md`
  - Repo URL: 1 (getting started link)
- [ ] G3: Migrate `import/microhack/feedback-form.md` → `docs/about/feedback.md`
  - Callouts: 1 (TIP)

### Phase H — Audit & Validation (Step 10)

**Prompt**: site-10

- [ ] H1: Run `bundle exec jekyll build` — zero errors
- [ ] H2: Run `bundle exec htmlproofer _site/` — zero broken internal links
- [ ] H3: Verify all callouts render correctly (spot check 5 pages)
- [ ] H4: Verify all `<details>` blocks render markdown content (spot check getting-started + hints-and-tips)
- [ ] H5: Verify all 5 live Mermaid diagrams render (README Gantt, challenges flowchart, challenge-3, challenge-8, index.md Gantt)
- [ ] H6: Verify quick-reference-card Mermaid code block does NOT render as live chart
- [ ] H7: Verify sidebar navigation matches planned hierarchy
- [ ] H8: Verify search indexes all content
- [ ] H9: Verify mobile-responsive layout (viewport test)
- [ ] H10: Diff `import/microhack/AGENDA.md` content against `docs/about/agenda.md` — meaning preserved

---

## Transformation Rules (Apply to ALL migration steps)

These rules apply to every file migrated in Phases C-G:

### 1. Callout Conversion

```
> [!WARNING]       →  {: .warning }    (yellow)
> text              →  > text

> [!TIP]           →  {: .tip }        (purple)
> text              →  > text

> [!NOTE]          →  {: .note }       (blue)
> text              →  > text

> [!IMPORTANT]     →  {: .important }  (green)
> text              →  > text
```

Format: Remove the `> [!TYPE]` line. Keep the blockquote content. Add `{: .warning }` (or appropriate type) on the line immediately after the closing blockquote.

### 2. `<details>` Block Handling

Add `markdown="1"` attribute to every `<details>` tag:

```html
<details>           →  <details markdown="1">
<details open>      →  <details open markdown="1">
```

### 3. Repo URL Rewriting

```
azure-agentic-infraops-workshop  →  microhack-agentic-infraops
```

Apply to all URLs, git clone commands, and path references.

### 4. Facilitator Link Strategy

Links to `facilitator/scoring-rubric.md`, `facilitator/facilitator-guide.md`, or `facilitator/solution-reference.md`:

- **In challenge scoring sections**: Remove the link but keep descriptive text (e.g., "See scoring rubric for details" without link)
- **In AGENDA.md**: Convert to full GitHub repo URL: `https://github.com/jonathan-vella/microhack-agentic-infraops/blob/main/import/microhack/facilitator/facilitator-guide.md`

### 5. Challenge Header Include

Each challenge file (D2-D9) must include the challenge header at the top of content (after frontmatter):

```liquid
{% include challenge_header.html
   duration="30 min"
   points="20"
   agents="requirements"
   outputs="01-requirements.md"
%}
```

---

## Key Files (context loading reference)

### Always read (every session)

1. **This file** — `.github/exec-plans/active/site-execution.md`
2. **Plan** — `.github/prompts/plan-agenticInfraOpsMicrohack.prompt.md` (read only the phase you're working on)

### Read when working on specific phases

| Phase          | Additional context files                                        |
| -------------- | --------------------------------------------------------------- |
| A (foundation) | Plan Phases 1, 2, 5; brain-trek devcontainer for reference      |
| B (structure)  | `import/microhack/README.md`, `import/microhack/challenges/README.md` |
| C (getting-started) | `import/docs/getting-started.md`, `import/docs/workshop-prep.md` |
| D (challenges) | All 8 `import/microhack/challenges/*.md` files                  |
| E (guides)     | `import/docs/copilot-guide.md`, `hints-and-tips.md`, `quick-reference-card.md` |
| F (reference)  | `import/docs/GLOSSARY.md`, `troubleshooting.md`, `import/microhack/scripts/README.md` |
| G (about)      | `import/microhack/AGENDA.md`, `workshop-invitation.md`, `feedback-form.md` |
| H (audit)      | All files in `docs/` (built site)                               |

---

## Session Log

<!-- Append one entry per session. Keep entries concise. -->

| #   | Date       | Phase/Step | What was done            | What's next         | Blockers  |
| --- | ---------- | ---------- | ------------------------ | ------------------- | --------- |
| 0   | 2026-03-07 | Planning   | Created execution plan,  | A1: DevContainer    | None      |
|     |            |            | session tracker, 10 step | setup               |           |
|     |            |            | prompts, session-resume  |                     |           |
|     |            |            | prompt; adversarial      |                     |           |
|     |            |            | review completed         |                     |           |
| 1   | 2026-03-07 | A / A1     | Created devcontainer.json| A2: Jekyll scaffold | None      |
|     |            |            | + README.md; JSON valid  |                     |           |
| 2   | 2026-03-07 | A / A2     | Created Gemfile, _config | A3: Theme assets    | None      |
|     |            |            | .yml, pages.yml workflow,|                     |           |
|     |            |            | 404.md, .gitignore; all  |                     |           |
|     |            |            | YAML validated; config   |                     |           |
|     |            |            | uses verified JTD v0.10  |                     |           |
|     |            |            | keys from official docs  |                     |           |
| 3   | 2026-03-07 | A / A3     | Created custom.scss      | B1: Landing page +  | Smoke test|
|     |            |            | (Azure colors, challenge | section indexes     | deferred  |
|     |            |            | badges, details, print   |                     | (no Ruby) |
|     |            |            | CSS), logo.svg, favicon  |                     |           |
|     |            |            | .svg + head_custom.html, |                     |           |
|     |            |            | challenge_header.html    |                     |           |
| 4   | 2026-03-07 | B / B1-B2  | Created docs/index.md    | C1: Migrate getting | None      |
|     |            |            | landing page (hero, Gantt| -started.md → setup |           |
|     |            |            | schedule, key facts,     | .md                 |           |
|     |            |            | objectives, scenario,    |                     |           |
|     |            |            | nav cards) + 5 section   |                     |           |
|     |            |            | index pages with correct |                     |           |
|     |            |            | frontmatter & nav_order  |                     |           |
| 5   | 2026-03-07 | C / C1-C2  | Migrated getting-started | D1: Create challenge| None      |
|     |            |            | .md → setup.md (16       | index content       |           |
|     |            |            | callouts, 24 details, 2  |                     |           |
|     |            |            | repo URLs, 7 link fixes) |                     |           |
|     |            |            | + workshop-prep.md (1    |                     |           |
|     |            |            | link fix). All verified. |                     |           |
| 6   | 2026-03-07 | D / D1-D9  | Migrated all 8 challenge | E1: Migrate copilot | None      |
|     |            |            | files + updated index    | -guide.md           |           |
|     |            |            | with links. Callouts (5  |                     |           |
|     |            |            | NOTE→{:.note}), details  |                     |           |
|     |            |            | (3×markdown=1), repo URL |                     |           |
|     |            |            | (1), facilitator links   |                     |           |
|     |            |            | (5 removed), Mermaid (2  |                     |           |
|     |            |            | preserved). All verified.|                     |           |
| 7   | 2026-03-07 | E / E1-E3  | Migrated 3 guide files:  | F1: Migrate glossary| None      |
|     |            |            | copilot-guide (1 TIP     | .md                 |           |
|     |            |            | callout, 4 link fixes),  |                     |           |
|     |            |            | hints-and-tips (10       |                     |           |
|     |            |            | details→markdown=1),     |                     |           |
|     |            |            | quick-reference-card (1  |                     |           |
|     |            |            | facilitator link→text,   |                     |           |
|     |            |            | stray backtick fence     |                     |           |
|     |            |            | fixed). All verified.    |                     |           |
| 8   | 2026-03-07 | F / F1-F3  | Migrated 3 reference     | G1: Migrate AGENDA  | None      |
|     |            |            | files: glossary (alpha   | .md                 |           |
|     |            |            | anchors added), trouble  |                     |           |
|     |            |            | shooting (version link   |                     |           |
|     |            |            | removed, script path     |                     |           |
|     |            |            | fixed), governance-      |                     |           |
|     |            |            | scripts (3 callouts      |                     |           |
|     |            |            | converted, GH URLs for   |                     |           |
|     |            |            | .ps1 files). All verified|                     |           |

---

## Decisions Made During Execution

<!-- Record any runtime decisions that deviate from the plan -->

| Date       | Decision                                         | Rationale                                           |
| ---------- | ------------------------------------------------ | --------------------------------------------------- |
| 2026-03-07 | Tracker in `.github/exec-plans/` not `docs/`     | Avoid publishing internal state to GitHub Pages     |
| 2026-03-07 | GitHub Actions build mode (not classic Pages)    | Need jekyll-relative-links (not in GH Pages gems)   |
| 2026-03-07 | AGENDA.md "meaning preserved" not "UNCHANGED"    | Must fix broken links, callouts, repo URLs          |
| 2026-03-07 | TIP callout → `{: .tip }` (not `{: .note }`)    | Preserve visual distinction between TIP and NOTE    |
| 2026-03-07 | getting-started.md → `setup.md` (child page)     | 640-line file too long for section index page       |
| 2026-03-07 | File-level checkboxes for all migration steps    | Enable mid-step resume without re-doing completed   |
| 2026-03-07 | htmlproofer added to Gemfile                     | Automated broken link detection in audit step       |
| 2026-03-07 | `<details>` blocks get `markdown="1"` globally   | Kramdown doesn't process markdown in raw HTML       |
| 2026-03-07 | Facilitator links → descriptive text or GH URLs  | Facilitator content excluded from site; links break |
| 2026-03-07 | SVG favicon instead of .ico                      | Can't generate .ico programmatically; SVG supported by modern browsers; added via head_custom.html |
| 2026-03-07 | Smoke test deferred to devcontainer/CI            | Ruby not available in WSL environment               |
| 2026-03-07 | getting-started.md has 16 callouts, not 17       | Actual count: TIP ×3, WARNING ×6, IMPORTANT ×4, NOTE ×3 = 16 (tracker had TIP ×4) |
| 2026-03-07 | Fixed stray 4-backtick fence in quick-ref-card   | Original had ```` wrapping Pro Tips content in a code block — removed opening and closing stray fences |

---

## Adversarial Review Summary

Completed 2026-03-07. Full findings in `.github/exec-plans/active/adversarial-review-01.md`.

### Critical (3) — All addressed

- C1: AGENDA.md "UNCHANGED" constraint → redefined as "meaning preserved"
- C2: Facilitator links in 6+ files → explicit removal/rewrite strategy in transformation rules
- C3: Tracker inside docs/ → moved to `.github/exec-plans/`

### High (5) — All addressed

- H1: Build mode contradiction → GitHub Actions mode only
- H2: Step 6 oversized → file-level checkboxes added
- H3: `<details>` blocks won't render markdown → `markdown="1"` rule added
- H4: Wrong repo URLs → global find-replace rule added
- H5: No htmlproofer → added to Gemfile

### Medium (7) — Incorporated into step prompts

- M1: Corrected Mermaid audit list (5 live diagrams, not in copilot-guide)
- M2: getting-started split into short index + setup.md child
- M3: File-level sub-checkboxes added to tracker
- M4: TIP → `{: .tip }` mapping corrected
- M5: `docs/.gitignore` added to Step 2
- M6: Mermaid version config to be verified during Step 2
- M7: Explicit extraction map added for microhack/README.md content
