---
description: "Step 3: Create theme assets — custom SCSS, logo SVG, favicon, challenge header include, footer. Defines the visual identity of the site."
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

# Site Step 3: Theme & Assets

## Mission

Create the visual identity: custom color scheme (Azure blue), challenge metadata component, print styles, `<details>` block styling, logo, and favicon. After this step + a smoke test, the site skeleton should render correctly with the just-the-docs theme.

## Prerequisites

- Step 2 complete (`docs/_config.yml` exists with callout definitions and theme settings)

## Context to Load

1. Read the session tracker: `.github/exec-plans/active/site-execution.md` — verify A3 is the current step
2. Read plan Phase 5 (Theme Customization): `.github/prompts/plan-agenticInfraOpsMicrohack.prompt.md`
3. Read `docs/_config.yml` — verify callout definitions and color_scheme value

## Tasks

### Task 1: Create `docs/_sass/custom/custom.scss`

Custom styling for:

1. **Color scheme** — Azure blue (#0078D4) primary, green (#107C10) accent
2. **Challenge header cards** — Styled info boxes for Duration, Points, Agent, Output badges
3. **`<details>` blocks** — Border, padding, cursor styling (just-the-docs doesn't style these)
4. **Print CSS** — `@media print` rules for quick-reference-card (hide sidebar, navigation, search)
5. **Responsive tables** — Horizontal scroll wrapper for wide tables
6. **Time callout** — Red-bordered callout for time-sensitive coaching
7. **Landing page** — Hero section styling, navigation card grid

Reference the just-the-docs customization docs for the correct SCSS override approach. The file must follow the just-the-docs `_sass/custom/custom.scss` convention (the theme auto-loads this file).

Key CSS classes to define:
- `.challenge-header` — Flex container for challenge metadata badges
- `.challenge-badge` — Individual badge (duration, points, agent, output)
- `.nav-card-grid` — Landing page navigation card layout
- `.nav-card` — Individual navigation card
- `details[open]` — Expanded state styling
- `@media print` — Print-optimized layout

### Task 2: Create `docs/assets/images/logo.svg`

Event-branded SVG logo:
- Incorporate Azure/Microsoft identity colors (#0078D4 blue)
- Include "Agentic InfraOps MicroHack" text or abbreviation
- Must work at sidebar width (~250px wide)
- Keep SVG simple and small (< 5KB)
- Consider a gear/cog + AI/brain motif representing infrastructure + agents

### Task 3: Create `docs/assets/images/favicon.ico`

Since creating a real .ico file programmatically is complex, create a simple SVG favicon instead:
- Create `docs/assets/images/favicon.svg` (modern browsers support SVG favicons)
- Update the `_config.yml` reference if needed (or create a `_includes/head_custom.html` to add SVG favicon link)
- Alternatively, use an online tool reference in the step — note in tracker if deferred

### Task 4: Create `docs/_includes/challenge_header.html`

Liquid include template for challenge metadata. **API contract** (step 6 depends on these exact parameter names):

```liquid
<!-- Challenge Header Component -->
<!-- Parameters: duration, points, agents, outputs -->
<div class="challenge-header" markdown="0">
  <span class="challenge-badge challenge-badge--duration">⏱️ {{ include.duration }}</span>
  <span class="challenge-badge challenge-badge--points">🏆 {{ include.points }} pts</span>
  {% if include.agents %}
  <span class="challenge-badge challenge-badge--agent">🤖 {{ include.agents }}</span>
  {% endif %}
  {% if include.outputs %}
  <span class="challenge-badge challenge-badge--output">📄 {{ include.outputs }}</span>
  {% endif %}
</div>
```

### Task 5: Smoke Test

If in a devcontainer or Ruby environment:
```bash
cd docs && bundle install && bundle exec jekyll build
```

Verify:
- Zero build errors
- `_site/` directory created
- Theme CSS loads (check `_site/assets/css/`)
- 404 page generated at `_site/404.html`

If not in a Ruby environment, note the smoke test as deferred in the tracker.

## Completion Criteria

- [ ] `docs/_sass/custom/custom.scss` exists with Azure colors, challenge badges, details styling, print CSS
- [ ] `docs/assets/images/logo.svg` exists (event-branded)
- [ ] Favicon solution implemented (SVG or deferred)
- [ ] `docs/_includes/challenge_header.html` exists with documented parameter API
- [ ] Smoke test passed OR noted as deferred

## After Completion

Update the session tracker (`.github/exec-plans/active/site-execution.md`):
1. Check off A3 items including smoke test result
2. Update "Current Session Target" to B1
3. Append a session log entry
