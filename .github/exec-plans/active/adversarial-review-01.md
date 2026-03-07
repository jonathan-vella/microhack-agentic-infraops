# Adversarial Review #1 — Site Plan & Step Decomposition

**Date**: 2026-03-07
**Reviewer**: Sonnet 4.6 (subagent)
**Scope**: Plan + proposed 10-step decomposition + session management system

---

## CRITICAL (3)

### C1. AGENDA.md "UNCHANGED" constraint creates guaranteed broken links
AGENDA.md contains facilitator links, `> [!NOTE]` callout, and old repo URL. Moving to `docs/about/agenda.md` breaks all three. The "UNCHANGED" constraint directly contradicts the plan's own requirements for callout conversion, link fixing, and URL rewriting.
**Resolution**: Redefined as "content meaning preserved; links and callout syntax adapted for Jekyll."

### C2. 6+ challenge files link to facilitator content excluded from site
Files with links to `../facilitator/scoring-rubric.md`: challenge-2, 3, 4, 5, 6, plus quick-reference-card.md. AGENDA.md links to `facilitator-guide.md` twice. All will 404 on the published site.
**Resolution**: Explicit facilitator link strategy added to transformation rules — remove links but keep descriptive text, or convert to full GitHub repo URLs.

### C3. Session tracker inside `docs/` would be published to site
`docs/exec-plans/active/` is inside the Jekyll source directory. Without exclusion, it gets built and published.
**Resolution**: Moved tracker to `.github/exec-plans/active/` (outside docs/).

---

## HIGH (5)

### H1. GitHub Pages build approach is contradictory
Plan says "build from docs/ on main" (classic mode) but also "GitHub Actions (not branch-based)" (custom mode). `jekyll-relative-links` is not a GitHub Pages supported gem — classic mode would silently ignore it, breaking all `.md` internal links.
**Resolution**: Unambiguously use GitHub Actions build mode. Step 2 produces complete workflow YAML.

### H2. Step 6 is oversized (9 files, 3 transformation types)
If interrupted mid-step, no way to know which of 9 files completed. Resume would re-do all 9.
**Resolution**: File-level sub-checkboxes added to tracker for all migration steps (C-G).

### H3. `<details>` blocks won't render markdown in Jekyll
37 `<details>` blocks across source files (24 in getting-started.md, 10 in hints-and-tips.md, 3 in challenges). Kramdown doesn't process markdown inside raw HTML without `markdown="1"`.
**Resolution**: Global transformation rule: add `markdown="1"` to ALL `<details>` tags.

### H4. Wrong repo URLs in 9 locations across 5 files
References to `azure-agentic-infraops-workshop` (old repo) in: getting-started.md (2), microhack/README.md (1), workshop-invitation.md (1), challenge-3-implementation.md (1), AGENDA.md (1). upstream-sync.md has 3 but is excluded.
**Resolution**: Global find-replace rule added to transformation rules.

### H5. No htmlproofer installation path
Plan calls for htmlproofer but it's not in Gemfile, devcontainer, or workflow.
**Resolution**: Added `html-proofer ~> 5.0` to Gemfile spec in Step 2.

---

## MEDIUM (7)

### M1. Mermaid diagram audit list is inaccurate
Plan claims diagrams in copilot-guide.md (none exist). Quick-reference-card.md has a 4-backtick code example, not a live chart. Actual live Mermaid locations: microhack/README.md (2), challenges/README.md (1), challenge-3-implementation.md (1), challenge-8-partner-showcase.md (1). Total: 5 live diagrams.
**Resolution**: Corrected in tracker and step 10 audit checklist.

### M2. getting-started.md (640 lines) as section index is poor UX
Just-the-docs section indexes should be short intro pages (10-30 lines).
**Resolution**: getting-started.md migrates as `setup.md` child. Short index.md created separately.

### M3. Session resumability is step-level, not file-level
Steps 5-9 create multiple files each. No mechanism to detect partial completion.
**Resolution**: File-level sub-checkboxes added to tracker for all multi-file steps.

### M4. TIP callout mapped to NOTE (loses visual distinction)
Plan Step 21 maps `> [!TIP]` → `{: .note }` but _config.yml defines separate `tip` callout (purple).
**Resolution**: TIP → `{: .tip }` in all transformation rules.

### M5. No .gitignore for docs/ folder
`bundle install` generates _site/, .jekyll-cache/, vendor/. None gitignored.
**Resolution**: Step 2 creates `docs/.gitignore`.

### M6. Mermaid version pinning may need syntax verification
`mermaid.version` config key behavior changed in just-the-docs v0.10. Syntax needs verification.
**Resolution**: Step 2 to verify actual v0.10 config syntax.

### M7. microhack/README.md content splitting is vaguely defined
README contains 7+ distinct sections that need to go to different target files. "Incorporate" is too vague.
**Resolution**: Explicit extraction map added to Step 4 in tracker.

---

## LOW (6)

### L1. No documented include API for challenge_header.html
Step 3 creates the include, Step 6 uses it. If parameter names mismatch, all 8 files break.

### L2. No Gemfile.lock commit strategy
Plan says commit Gemfile.lock but no step generates or commits it.

### L3. jekyll-relative-links may not handle anchor links correctly
Links like `getting-started.md#section` might not rewrite correctly.

### L4. Custom layouts (home, minimal) not in just-the-docs
Phase 6 recommends `home` and `minimal` layouts that don't exist in the theme. Would need `_layouts/` files.

### L5. Print CSS for quick-reference-card not assigned to any step
@media print rules mentioned in Phase 6 but no step creates them.

### L6. dependabot.yml not assigned to any step
Plan recommends Dependabot for Gemfile security but no step creates it.
