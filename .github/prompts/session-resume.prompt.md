---
description: "Resume a site build session. Loads progress state, identifies next step, and continues work from where the last session left off."
model: Claude Opus 4.6
tools:
  - edit/editFiles
  - read/readFile
  - search/codebase
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/terminalLastCommand
  - read/terminalSelection
  - read/problems
  - web/fetch
  - todo
---

# Resume Site Build Session

## Mission

Load the current execution state from the session tracker, identify the next incomplete step, load only the context needed for that step, and continue execution.

## Workflow

### Step 1 — Load session state

Read `.github/exec-plans/active/site-execution.md` completely.

Identify:
- The current phase (A through H)
- The specific next unchecked item
- Any blockers noted in the session log
- The transformation rules (if working on Phases C-G)

### Step 2 — Load step-specific context

Based on the current phase, read ONLY the context files listed in the "Key Files" section of the session tracker. Do NOT load the entire plan — read only what's needed.

Context loading budget (minimize token usage):

| Phase          | Max files to read                                                  |
| -------------- | ------------------------------------------------------------------ |
| A (foundation) | 2 (tracker + relevant step prompt)                                 |
| B (structure)  | 3 (tracker + step prompt + source README files for content)        |
| C (getting-started) | 3 (tracker + step prompt + source files being migrated)       |
| D (challenges) | 3 (tracker + step prompt + source challenge file being migrated)   |
| E (guides)     | 3 (tracker + step prompt + source guide file being migrated)       |
| F (reference)  | 3 (tracker + step prompt + source reference file being migrated)   |
| G (about)      | 3 (tracker + step prompt + source about file being migrated)       |
| H (audit)      | 2 (tracker + step prompt)                                          |

### Step 3 — Check for partially completed steps

For migration phases (C-G), check if the step was partially completed:
1. Look at the file-level checkboxes in the tracker
2. Check if destination files already exist: `ls docs/{section}/*.md`
3. If files exist, verify they have frontmatter (first line is `---`)

If partially completed: skip already-done files, continue from the first unchecked item.

### Step 4 — Execute the next step

Load the step-specific prompt file:
- Phase A: `site-01-devcontainer.prompt.md`, `site-02-jekyll-scaffold.prompt.md`, or `site-03-theme-assets.prompt.md`
- Phase B: `site-04-landing-structure.prompt.md`
- Phase C: `site-05-getting-started.prompt.md`
- Phase D: `site-06-challenges.prompt.md`
- Phase E: `site-07-guides.prompt.md`
- Phase F: `site-08-reference.prompt.md`
- Phase G: `site-09-about.prompt.md`
- Phase H: `site-10-audit-validate.prompt.md`

Follow the prompt's tasks exactly. After completing each item:
1. Check off the item in the session tracker
2. If the item produces a file, verify it exists
3. If a validation command is specified, run it

### Step 5 — Update session state (MANDATORY before ending)

Before the session ends, update the session tracker:

1. Check off all completed items (file-level granularity for Phases C-G)
2. Update the "Current Session Target" section with the next step
3. Append a row to the "Session Log" table
4. Record any decisions made in the "Decisions Made" table
5. Note any blockers discovered

## Prompt-to-Phase Mapping

| Prompt File | Phase | Description |
|---|---|---|
| `site-01-devcontainer.prompt.md` | A1 | DevContainer setup |
| `site-02-jekyll-scaffold.prompt.md` | A2 | Gemfile, _config.yml, workflow, 404, .gitignore |
| `site-03-theme-assets.prompt.md` | A3 | SCSS, logo, favicon, challenge_header include |
| `site-04-landing-structure.prompt.md` | B1-B2 | Landing page + 5 section indexes |
| `site-05-getting-started.prompt.md` | C1-C2 | getting-started.md + workshop-prep.md |
| `site-06-challenges.prompt.md` | D1-D9 | 8 challenge files + index update |
| `site-07-guides.prompt.md` | E1-E3 | copilot-guide, hints-and-tips, quick-reference-card |
| `site-08-reference.prompt.md` | F1-F3 | glossary, troubleshooting, governance-scripts |
| `site-09-about.prompt.md` | G1-G3 | agenda, invitation, feedback |
| `site-10-audit-validate.prompt.md` | H1-H10 | Build, links, callouts, Mermaid, nav, search |

## Output Expectations

- Session tracker is always up-to-date when the session ends
- Each session makes measurable forward progress (at least one checkbox completed)
- Context loading is minimal — only what's needed for the current step
- Migration steps update the tracker after EACH file, not at step end

## Quality Assurance

- [ ] Session tracker was read before any work began
- [ ] Only phase-relevant context was loaded
- [ ] All completed items are checked off in the tracker
- [ ] Session log has a new entry for this session
- [ ] No work was done outside the current phase's scope
