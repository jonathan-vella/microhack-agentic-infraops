---
description: "Step 6: Migrate all 8 challenge files + update challenges index. Includes challenge header component, callout conversion, facilitator link removal."
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

# Site Step 6: Migrate Challenges

## Mission

Migrate all 8 challenge files from `import/microhack/challenges/` to `docs/challenges/`. Each challenge gets frontmatter, the challenge_header include, callout conversion, and facilitator link cleanup. Update the challenges index with the workflow diagram.

## Prerequisites

- Step 3 complete (`docs/_includes/challenge_header.html` exists — know the parameter API)
- Step 4 complete (`docs/challenges/index.md` exists with `has_children: true`)

## Context to Load

1. Read the session tracker: `.github/exec-plans/active/site-execution.md` — verify D1 is the current step
2. Read the transformation rules in the tracker
3. Read `docs/_includes/challenge_header.html` — confirm parameter names (duration, points, agents, outputs)
4. Read all source files:
   - `import/microhack/challenges/README.md` (40 lines)
   - `import/microhack/challenges/challenge-1-requirements.md` through `challenge-8-partner-showcase.md`

## Challenge Metadata Reference

| Challenge | Duration | Points | Agent(s) | Output File(s) |
|---|---|---|---|---|
| 1: Requirements | 30 min | 20 | requirements | 01-requirements.md |
| 2: Architecture | 30 min | 25 | architect | 02-architecture-assessment.md, 03-des-architecture-diagram.md |
| 3: Implementation | 45 min | 25 | bicep-plan, bicep-code, deploy | main.bicep, main.bicepparam, deploy.ps1 |
| 4: DR Curveball | 45 min | 10 | architect | 04-adr-ha-dr-strategy.md |
| 5: Load Testing | 30 min | 5 | — | 05-load-test-results.md |
| 6: Documentation | 15 min | 5 | design | 07-ab-operations-guide.md (min 2 docs) |
| 7: Diagnostics | 5 min | 5 | — | 07-diagnostics-quick-card.md |
| 8: Partner Showcase | 60 min | 10 | — | Presentation (facilitator-scored) |

## Facilitator Link Strategy

These files contain links to `../facilitator/scoring-rubric.md` that will 404 on the published site:
- challenge-2-architecture.md (line ~188)
- challenge-3-implementation.md (line ~252)
- challenge-4-dr-curveball.md (line ~189)
- challenge-5-load-testing.md (line ~190)
- challenge-6-documentation.md (line ~162)

**Resolution**: In the scoring/reference blockquotes at the end of each challenge, remove the `[Scoring Rubric](../facilitator/scoring-rubric.md)` link. Replace with plain text: "Scoring rubric available from your facilitator" or similar. Keep any other content in those blockquotes.

Additionally, `challenge-3-implementation.md` line ~7 references a governance script URL pointing to the old repo — rewrite to the new repo URL.

## Tasks

### Task 1: Update `docs/challenges/index.md` content (D1)

The index page was created in Step 4 with basic structure. Now enhance it with:
- The Mermaid flowchart from `import/microhack/challenges/README.md` (line 24+)
- Challenge overview table with links to each challenge page
- Brief intro text about the challenge progression

### Tasks 2-9: Migrate each challenge file (D2-D9)

For EACH challenge file:

1. **Add frontmatter:**
```yaml
---
layout: default
title: "C{N}: {Title}"
parent: Challenges
nav_order: {N+1}   # (index is 1, so C1=2, C2=3, etc.)
description: "{Brief description}"
---
```

2. **Add challenge header include** (immediately after frontmatter):
```liquid
{% include challenge_header.html
   duration="{duration}"
   points="{points}"
   agents="{agents}"
   outputs="{outputs}"
%}
```
Use the metadata reference table above for values.

3. **Apply transformation rules:**
   - Convert callouts (challenges 2-6 have `> [!NOTE]` blocks)
   - Rewrite repo URLs (challenge 3 has governance script link)
   - Remove/rewrite facilitator links (challenges 2-6)
   - Fix internal cross-links between challenges

4. **Preserve all content** — don't remove or summarize. Only transform syntax.

### Processing Order

Process files in order. After completing EACH file, check off the corresponding item in the tracker before proceeding to the next:
1. challenges/index.md content update (D1)
2. challenge-1-requirements.md (D2)
3. challenge-2-architecture.md (D3) — has facilitator link + callout
4. challenge-3-implementation.md (D4) — has facilitator link + callout + Mermaid + repo URL
5. challenge-4-dr-curveball.md (D5) — has facilitator link + callout
6. challenge-5-load-testing.md (D6) — has facilitator link + callout
7. challenge-6-documentation.md (D7) — has facilitator link + callout
8. challenge-7-diagnostics.md (D8)
9. challenge-8-partner-showcase.md (D9) — has Mermaid diagram

## Completion Criteria

- [ ] `docs/challenges/index.md` has challenge table + Mermaid workflow diagram
- [ ] All 8 challenge files exist in `docs/challenges/` with:
  - Correct frontmatter (parent: Challenges, sequential nav_order)
  - Challenge header include with correct metadata
  - Callouts converted (where applicable)
  - Facilitator links removed/rewritten (where applicable)
  - Repo URLs rewritten (where applicable)
  - Mermaid diagrams preserved (challenges 3 and 8)
  - All other content preserved verbatim

## After Completion

Update the session tracker (`.github/exec-plans/active/site-execution.md`):
1. Check off D1 through D9 items individually
2. Update "Current Session Target" to E1
3. Append a session log entry
