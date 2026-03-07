---
description: "Step 10: Final audit and validation — build test, broken link check, callout verification, Mermaid check, navigation, search, mobile responsiveness."
model: Claude Opus 4.6
tools:
  - edit/editFiles
  - read/readFile
  - search/codebase
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/problems
  - web/fetch
  - todo
---

# Site Step 10: Audit & Validate

## Mission

Run a comprehensive audit of the complete site: build test, broken link detection, callout rendering verification, Mermaid diagram validation, `<details>` block testing, navigation hierarchy check, and search verification. Fix any issues found.

## Prerequisites

- Steps 1-9 all complete (all content migrated)

## Context to Load

1. Read the session tracker: `.github/exec-plans/active/site-execution.md` — verify H1 is the current step
2. Skim all files in `docs/` to get an overview of what exists

## Tasks

### Task 1: Jekyll Build Test (H1)

```bash
cd docs && bundle install && bundle exec jekyll build
```

**Expected**: Zero errors, zero warnings (deprecation notices OK).
**If errors**: Fix each error before proceeding. Common issues:
- YAML frontmatter syntax errors
- Missing closing tags in Liquid includes
- Invalid Liquid template syntax
- Missing parent pages referenced in frontmatter

### Task 2: Broken Link Check (H2)

```bash
cd docs && bundle exec htmlproofer _site/ \
  --ignore-urls "/fonts.googleapis.com/,/fonts.gstatic.com/" \
  --no-enforce-https \
  --ignore-status-codes "999" \
  --allow-missing-href
```

**Expected**: Zero broken internal links.
**Common fixes needed**:
- Facilitator links that weren't caught in migration
- Old repo URLs that weren't rewritten
- Internal links with wrong relative paths
- Anchor links (`#section-name`) that don't match actual headings

### Task 3: Callout Rendering Spot Check (H3)

Verify callout conversion by checking these specific files in the built `_site/`:
1. `getting-started/setup.html` — should have 17 styled callouts (not raw `[!WARNING]` text)
2. `challenges/challenge-2-architecture.html` — should have 1 styled NOTE callout
3. `about/agenda.html` — should have 1 styled NOTE callout
4. `about/feedback.html` — should have 1 styled TIP callout
5. `guides/copilot-guide.html` — should have 1 styled TIP callout

```bash
# Quick check: no raw [!WARNING], [!TIP], [!NOTE], [!IMPORTANT] should appear in built HTML
grep -r '\[!WARNING\]\|\[!TIP\]\|\[!NOTE\]\|\[!IMPORTANT\]' docs/_site/ || echo "PASS: No unconverted callouts"
```

### Task 4: `<details>` Block Rendering Check (H4)

Verify markdown inside `<details>` blocks renders as HTML (not raw text):
1. Check `getting-started/setup.html` — 24 `<details>` blocks should have rendered markdown
2. Check `guides/hints-and-tips.html` — 10 `<details>` blocks should have rendered markdown

```bash
# Quick check: <details> blocks should contain <p>, <code>, <ul> etc., not raw markdown
grep -A5 '<details' docs/_site/getting-started/setup.html | head -30
```

### Task 5: Mermaid Diagram Verification (H5)

Verify these 5 live Mermaid diagrams have the correct ```` ```mermaid ```` fencing (they render client-side via JS):
1. `docs/index.md` — schedule Gantt chart (created in Step 4)
2. `docs/challenges/index.md` — workflow flowchart (from challenges/README.md)
3. `docs/challenges/challenge-3-implementation.md` — deployment flowchart
4. `docs/challenges/challenge-8-partner-showcase.md` — timeline diagram

Also verify from `import/microhack/README.md`: if any Mermaid diagrams were incorporated into `index.md` or `challenges/index.md`.

### Task 6: Quick Reference Mermaid Code Block (H6)

Verify `docs/guides/quick-reference-card.md` — the Mermaid code example (originally 4-backtick fenced) must NOT render as a live Mermaid chart. It should show as a code sample.

```bash
# Check the built HTML — should show <code> or <pre>, not a Mermaid-processed SVG
grep -A3 'mermaid' docs/_site/guides/quick-reference-card.html | head -10
```

### Task 7: Navigation Hierarchy Check (H7)

Verify the sidebar navigation matches the planned structure:

```
Home                            nav_order: 1
Getting Started                 nav_order: 2
  ├── Setup Guide               nav_order: 1
  └── Workshop Prep & Scenario  nav_order: 2
Challenges                      nav_order: 3
  ├── (index content)           nav_order: 1
  ├── C1: Requirements          nav_order: 2
  ├── C2: Architecture          nav_order: 3
  ├── C3: Implementation        nav_order: 4
  ├── C4: DR Curveball          nav_order: 5
  ├── C5: Load Testing          nav_order: 6
  ├── C6: Documentation         nav_order: 7
  ├── C7: Diagnostics           nav_order: 8
  └── C8: Partner Showcase      nav_order: 9
Guides                          nav_order: 4
  ├── Copilot & Agents Guide    nav_order: 1
  ├── Hints & Tips              nav_order: 2
  └── Quick Reference Card      nav_order: 3
Reference                       nav_order: 5
  ├── Glossary                  nav_order: 1
  ├── Troubleshooting           nav_order: 2
  └── Governance Scripts        nav_order: 3
About                           nav_order: 6
  ├── Agenda                    nav_order: 1
  ├── Workshop Invitation       nav_order: 2
  └── Feedback Form             nav_order: 3
```

Check by examining frontmatter of all files:
```bash
grep -r "^title:\|^parent:\|^nav_order:" docs/ --include="*.md" | sort
```

### Task 8: Search Verification (H8)

If running `jekyll serve`, verify:
- Search box appears in header
- Typing a term (e.g., "Nordic Fresh Foods") returns results
- Results link to correct pages

If only doing a build, verify the search index is generated:
```bash
ls -la docs/_site/assets/js/search-data.json 2>/dev/null && echo "Search index exists" || echo "MISSING search index"
```

### Task 9: Mobile Responsiveness (H9)

If running `jekyll serve`:
- Open DevTools → Toggle device toolbar → Select mobile viewport
- Verify sidebar collapses to hamburger menu
- Verify tables scroll horizontally
- Verify code blocks don't overflow

If build-only, this is deferred to post-deployment verification.

### Task 10: Agenda Integrity Check (H10)

Diff the agenda content (excluding frontmatter and the 5 known changes):
```bash
# Compare source and destination, ignoring frontmatter
tail -n +6 docs/about/agenda.md > /tmp/agenda-new.md
diff import/microhack/AGENDA.md /tmp/agenda-new.md
```

Review the diff: only the 5 documented changes (1 callout, 2 facilitator links, 1 getting-started link, 1 repo URL) should appear. Flag any unexpected differences.

## Completion Criteria

- [ ] Jekyll build: zero errors
- [ ] htmlproofer: zero broken internal links
- [ ] Callout spot check: all 5 files render callouts correctly
- [ ] `<details>` check: markdown renders inside details blocks
- [ ] Mermaid: all 5 live diagrams have correct fencing (4-5 diagrams)
- [ ] Quick reference: Mermaid code example shows as code, not live chart
- [ ] Navigation: sidebar matches planned hierarchy
- [ ] Search: index generated, search functional (if server running)
- [ ] Mobile: responsive layout works (or deferred)
- [ ] Agenda: only 5 documented changes from source

## After Completion

Update the session tracker (`.github/exec-plans/active/site-execution.md`):
1. Check off H1 through H10 items
2. Update Status to "Complete" (if all pass)
3. Append final session log entry
4. Record any remaining issues as follow-up items
