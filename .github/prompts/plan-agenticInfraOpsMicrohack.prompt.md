# Plan: Agentic InfraOps MicroHack — GitHub Pages Site

## TL;DR
Consolidate all content from `import/` into a new `docs/` folder formatted for Jekyll + GitHub Pages using the **just-the-docs** theme. Add a devcontainer mirroring the brain-trek repo pattern. Publish as a public-facing site at `jonathan-vella.github.io/microhack-agentic-infraops`. Facilitator-only content stays in the repo but is excluded from the built site. The hackathon agenda is preserved exactly as-is.

---

## Decisions
- **Theme**: just-the-docs (v0.10+) — proven in the brain-trek repo, excellent for technical documentation, supports Mermaid, callouts, search, navigation, code copy, breadcrumbs, mobile-responsive
- **Audience**: Public-facing (participants, facilitators access the repo directly for sensitive content)
- **Facilitator docs**: Excluded from published site (stored outside `docs/`)
- **Challenge 4 (DR)**: Published openly like all other challenges — no spoiler protection, no hiding
- **Logo/favicon**: Event-branded SVG logo + favicon added to `docs/assets/images/`
- **Feedback form**: Markdown template on site + link to live Microsoft Forms URL when available
- **Upstream sync**: Excluded — not relevant for microhack participants
- **Contributing guide**: Excluded — not relevant for a workshop event
- **Governance scripts**: Included with documentation in the published site
- **Domain**: Default GitHub Pages URL (`jonathan-vella.github.io/microhack-agentic-infraops`)
- **Agenda**: NOT modified (preserved exactly as authored)
- **Jekyll source**: `docs/` folder (GitHub Pages configured to build from `docs/` on `main`)

---

## Phase 1: DevContainer Setup

### Step 1: Create `.devcontainer/devcontainer.json`
Model after `jonathan-vella/microsoft-sovereign-cloud-brain-trek/.devcontainer/devcontainer.json`:
- **Base image**: `mcr.microsoft.com/devcontainers/jekyll:2-bookworm`
- **Features**: Node.js LTS (for markdownlint-cli2)
- **No Python** needed (no diagram generation scripts in this project)
- **VS Code extensions**:
  - `DavidAnson.vscode-markdownlint`
  - `yzhang.markdown-all-in-one`
  - `bierner.markdown-mermaid`
  - `redhat.vscode-yaml`
  - `EditorConfig.EditorConfig`
  - `esbenp.prettier-vscode`
  - `sissel.shopify-liquid`
- **Forwarded ports**: 4000 (Jekyll dev server)
- **postCreateCommand**: `sh /usr/local/post-create.sh && npm install -g markdownlint-cli2`
- **Settings**: markdownlint config, editor formatting

### Step 2: Create `.devcontainer/README.md`
Brief doc explaining how to use the devcontainer, start Jekyll, and preview locally.

---

## Phase 2: Jekyll Configuration & Scaffolding

### Step 3: Create `docs/Gemfile`
```
source "https://rubygems.org"
gem "jekyll", "~> 4.4"
gem "just-the-docs", "~> 0.10"
gem "jekyll-feed", "~> 0.15"
gem "jekyll-seo-tag", "~> 2.8"
gem "jekyll-sitemap", "~> 1.4"
gem "jekyll-relative-links", "~> 0.7"
```

### Step 4: Create `docs/_config.yml`
Key configuration:
- **title**: "Agentic InfraOps MicroHack"
- **description**: "6-hour hands-on microhack: Design, deploy, and present Azure infrastructure using AI agents and GitHub Copilot"
- **baseurl**: "/microhack-agentic-infraops"
- **url**: "https://jonathan-vella.github.io"
- **theme**: just-the-docs
- **color_scheme**: custom (see Phase 5)
- **logo**: "/assets/images/logo.svg"
- **favicon_ico**: "/assets/images/favicon.ico"
- **mermaid**: version "10.6.0" (tested, proven in brain-trek)
- **search**: enabled, heading_level 2
- **enable_copy_code_button**: true
- **heading_anchors**: true
- **back_to_top**: true
- **breadcrumbs**: true
- **callouts**: warning (yellow), note (blue), important (green), tip (purple), time (red — custom for time-sensitive coaching)
- **aux_links**: "View on GitHub" → repo URL
- **gh_edit_link**: true
- **footer_content**: copyright Jonathan Vella, MIT license
- **nav_sort**: case_insensitive
- **exclude**: Gemfile, Gemfile.lock, README.md, LICENSE, .gitignore, node_modules, vendor

### Step 5: Create GitHub Pages deploy workflow
Create `.github/workflows/pages.yml` using the `actions/jekyll-build-pages` action for building from `docs/` folder approach, or use the GitHub Actions workflow for custom Jekyll builds.

---

## Phase 3: Content Migration & Structure

### Proposed `docs/` folder structure:
```
docs/
├── _config.yml
├── Gemfile
├── index.md                         # Landing page (new)
├── _sass/
│   └── custom/
│       └── custom.scss              # Custom color scheme + styles
├── _includes/
│   └── footer_custom.html           # Custom footer
├── assets/
│   └── images/
│       ├── logo.svg                 # Event-branded SVG logo
│       └── favicon.ico              # Favicon
│
├── getting-started/
│   ├── index.md                     # ← import/docs/getting-started.md
│   └── workshop-prep.md             # ← import/docs/workshop-prep.md
│
├── guides/
│   ├── copilot-guide.md             # ← import/docs/copilot-guide.md
│   ├── hints-and-tips.md            # ← import/docs/hints-and-tips.md
│   └── quick-reference-card.md      # ← import/docs/quick-reference-card.md
│
├── challenges/
│   ├── index.md                     # ← import/microhack/challenges/README.md + AGENDA schedule
│   ├── challenge-1-requirements.md  # ← import/microhack/challenges/challenge-1-requirements.md
│   ├── challenge-2-architecture.md  # ← ditto
│   ├── challenge-3-implementation.md
│   ├── challenge-4-dr-curveball.md
│   ├── challenge-5-load-testing.md
│   ├── challenge-6-documentation.md
│   ├── challenge-7-diagnostics.md
│   └── challenge-8-partner-showcase.md
│
├── reference/
│   ├── glossary.md                  # ← import/docs/GLOSSARY.md
│   ├── troubleshooting.md           # ← import/docs/troubleshooting.md
│   └── governance-scripts.md        # ← import/microhack/scripts/README.md (consolidated)
│
├── about/
│   ├── agenda.md                    # ← import/microhack/AGENDA.md (UNCHANGED)
│   ├── invitation.md                # ← import/microhack/workshop-invitation.md
│   └── feedback.md                  # ← import/microhack/feedback-form.md
│
└── (EXCLUDED from docs/ — stays in repo only):
    import/microhack/facilitator/*
    import/docs/upstream-sync.md
    import/docs/guides/contributing.md
    import/microhack/participant/README.md (just a redirect, merged into navigation)
```

### Step 6: Create `docs/index.md` — Landing Page (NEW content)
- Event branding header with title and tagline
- "What is this MicroHack?" summary (adapted from README.md + invitation)
- Quick-start CTA button → Getting Started
- Visual schedule overview (Mermaid Gantt from microhack/README.md)
- Key facts: 6 hours, 8 challenges, 105 + 25 bonus points
- Learning objectives (from microhack/README.md)
- Business scenario teaser (Nordic Fresh Foods)
- Navigation cards for main sections

### Step 7: Migrate `import/docs/` files
For each file, add/update YAML frontmatter:
```yaml
---
layout: default
title: "Page Title"
nav_order: N
parent: "Section Name"
description: "SEO description"
---
```
Content changes needed per file:
- **getting-started.md**: Convert `> [!WARNING]`/`> [!TIP]` GitHub-flavored callouts to just-the-docs `{: .warning }` / `{: .note }` syntax
- **copilot-guide.md**: Same callout conversion; verify Mermaid blocks use ```` ```mermaid ```` fencing (should work with just-the-docs mermaid config)
- **hints-and-tips.md**: Callout conversion; `<details>` tags should render fine
- **quick-reference-card.md**: Add print-friendly CSS class
- **troubleshooting.md**: Callout conversion
- **workshop-prep.md**: Callout conversion; `<details>` preserved
- **GLOSSARY.md**: Convert to `glossary.md` with alphabetical anchors

### Step 8: Migrate `import/microhack/challenges/` files
For each challenge file:
- Add `parent: Challenges` frontmatter
- Add `nav_order: N` matching challenge number
- Convert any GitHub-flavored callouts to just-the-docs syntax
- Fix internal cross-links (e.g., links to other challenge files → relative paths within `challenges/`)
- Add a consistent "challenge header" with metadata: Duration, Points, Agent(s), Output file(s)

### Step 9: Migrate `import/microhack/` root files
- **AGENDA.md** → `about/agenda.md`: Add frontmatter ONLY; **no content changes**
- **workshop-invitation.md** → `about/invitation.md`: Add frontmatter, convert callouts
- **feedback-form.md** → `about/feedback.md`: Add frontmatter

### Step 10: Migrate governance scripts documentation
- Consolidate `import/microhack/scripts/README.md` into `reference/governance-scripts.md`
- The actual `.ps1` files stay in the repo (not in `docs/`)
- Documentation references the scripts by repo path

### Step 11: Create `import/microhack/` README redirect
- The original `import/microhack/README.md` content (overview, workflow diagram, scoring) should be incorporated into the landing page (`index.md`) and challenges overview (`challenges/index.md`)

---

## Phase 4: Navigation & Frontmatter

### Step 12: Define navigation hierarchy
```
Home (index.md)                        nav_order: 1
Getting Started                        nav_order: 2
  ├── Setup Guide                      nav_order: 1 (parent: Getting Started)
  └── Workshop Prep & Scenario         nav_order: 2 (parent: Getting Started)
Challenges                             nav_order: 3
  ├── Overview & Schedule              nav_order: 1 (parent: Challenges)
  ├── C1: Requirements                 nav_order: 2
  ├── C2: Architecture                 nav_order: 3
  ├── C3: Implementation              nav_order: 4
  ├── C4: DR Curveball                nav_order: 5
  ├── C5: Load Testing                nav_order: 6
  ├── C6: Documentation               nav_order: 7
  ├── C7: Diagnostics                 nav_order: 8
  └── C8: Partner Showcase            nav_order: 9
Guides                                 nav_order: 4
  ├── Copilot & Agents Guide          nav_order: 1 (parent: Guides)
  ├── Hints & Tips                     nav_order: 2
  └── Quick Reference Card            nav_order: 3
Reference                              nav_order: 5
  ├── Glossary                         nav_order: 1 (parent: Reference)
  ├── Troubleshooting                  nav_order: 2
  └── Governance Scripts              nav_order: 3
About                                  nav_order: 6
  ├── Agenda                           nav_order: 1 (parent: About)
  ├── Workshop Invitation             nav_order: 2
  └── Feedback Form                   nav_order: 3
```

### Step 13: Create section index pages
Each section (`getting-started/`, `challenges/`, `guides/`, `reference/`, `about/`) needs an `index.md` with `has_children: true` frontmatter.

---

## Phase 5: Theme Customization & UI Improvements

### Theme Recommendation: **just-the-docs** (v0.10+)

**Why just-the-docs:**
- Already proven in your brain-trek repo — consistency across projects
- Best-in-class documentation navigation (sidebar, breadcrumbs, search)
- Native Mermaid diagram support (critical for challenge content)
- Code copy buttons (essential for CLI commands)
- Callout system (warning, note, important — used heavily in content)
- Mobile-responsive (participants may use tablets)
- Active maintenance, MIT licensed
- GitHub Pages compatible via GitHub Actions workflow

### Step 14: Custom color scheme
Create `docs/_sass/custom/custom.scss` with:
- **Primary color**: Azure blue (#0078D4) for headers and links
- **Accent color**: Green (#107C10) for success states
- **Warning accents**: Yellow/amber for time-sensitive callouts
- **Challenge header cards**: Styled info boxes showing Duration, Points, Agent, Output

### Step 15: Custom CSS for challenge metadata
Add styled "challenge header" component:
- Duration badge, Points badge, Agent badge
- Visual differentiation between challenge types
- Print-friendly styling for quick-reference-card.md

### Step 16: Custom callout for time management
Define a custom `time` callout (red) for time-sensitive coaching tips that appear throughout challenge docs.

### Step 17: Custom landing page styling
- Hero section with event name + one-liner
- Card grid for navigation sections
- Microsoft partner/event branding compatibility

### Step 18: Mermaid theme configuration
Configure Mermaid to use Azure-inspired colors for diagrams (the content has many Mermaid diagrams — workflow, Gantt, flowcharts).

### Step 18b: Create logo and favicon
- Create `docs/assets/images/logo.svg` — event-branded SVG logo with Azure/Microsoft identity + "Agentic InfraOps MicroHack" text
- Create `docs/assets/images/favicon.ico` — derived from logo, 32x32 and 16x16 sizes
- Reference in `_config.yml` via `logo` and `favicon_ico` keys
- Logo appears in sidebar header, replacing plain text title

---

## Phase 6: Layout & UI Recommendations

### Recommended layouts:
1. **`default`** — Used for all content pages (provided by just-the-docs)
2. **`home`** — Custom landing page layout with hero section + nav cards
3. **`minimal`** — For quick-reference-card.md (no sidebar, print-optimized)

### UI Improvements:
1. **Challenge progress sidebar** — Visual indicator of challenge sequence in sidebar navigation with points
2. **"You are here" breadcrumbs** — Enabled via `breadcrumbs: true`
3. **Printable quick-reference** — Add `@media print` CSS for the reference card
4. **Collapsible sections** — `<details>` tags preserved from source content (hints, role cards)
5. **Responsive tables** — Add horizontal scroll wrapper for wide tables (quota tables, scoring rubrics)
6. **Time callouts** — Red-bordered callouts for coaching time management cues
7. **Code copy buttons** — Native just-the-docs feature, enabled
8. **Search** — Full-text search across all participant content
9. **Back-to-top** — Enabled, important for long challenge docs
10. **Footer** — "Edit on GitHub" link + copyright
11. **404 page** — Custom `docs/404.md` with helpful navigation

---

## Phase 7: GitHub Actions & Deployment

### Step 19: Create GitHub Actions workflow
`.github/workflows/pages.yml`:
- Trigger: push to `main` branch
- Build Jekyll site from `docs/` folder
- Deploy to GitHub Pages
- Use `actions/configure-pages`, `actions/jekyll-build-pages`, `actions/deploy-pages`

### Step 20: Configure GitHub Pages
- Set source: GitHub Actions (not branch-based)
- Ensure repo settings allow GitHub Pages deployment

---

## Phase 8: Content Formatting Audit

### Step 21: Callout syntax conversion
Systematically convert all GitHub-flavored callouts:
- `> [!WARNING]` → `{: .warning }` + block quote
- `> [!TIP]` → `{: .note }` (or custom `{: .tip }`)
- `> [!IMPORTANT]` → `{: .important }`
- `> [!NOTE]` → `{: .note }`

Files requiring conversion: getting-started.md, copilot-guide.md, hints-and-tips.md, troubleshooting.md, workshop-prep.md, facilitator-guide.md (excluded but for completeness).

### Step 22: Fix internal links
Update all cross-references to use new relative paths:
- Challenge files linking to each other → `../challenges/challenge-N-*.md`
- References to `docs/*.md` → appropriate new paths
- Remove references to VERSION.md (doesn't exist in this project)
- Update any references to `.github/` paths (agents, skills, instructions) — these are part of the source repo, not this project

### Step 23: Verify Mermaid blocks
All Mermaid diagrams should render with just-the-docs config. Verify:
- Flowcharts in challenges/README.md, microhack/README.md
- Gantt charts in quick-reference-card.md, microhack/README.md
- Sequence/workflow diagrams in copilot-guide.md

### Step 24: Handle `<details>` blocks
The `<details>` HTML blocks used extensively in hints-and-tips.md and getting-started.md should render correctly in Jekyll. Verify `kramdown` processes them. May need `markdown="1"` attribute on some blocks.

---

## Relevant Files

### Files to CREATE:
- `.devcontainer/devcontainer.json` — devcontainer config (model after brain-trek)
- `.devcontainer/README.md` — devcontainer usage docs
- `docs/_config.yml` — Jekyll configuration
- `docs/Gemfile` — Ruby dependencies
- `docs/index.md` — Landing page (new content)
- `docs/_sass/custom/custom.scss` — Custom theme styling
- `docs/404.md` — Custom 404 page
- `.github/workflows/pages.yml` — GitHub Pages deployment
- Section index files (5): `docs/getting-started/index.md`, `docs/challenges/index.md`, `docs/guides/index.md`, `docs/reference/index.md`, `docs/about/index.md`

### Files to MIGRATE (with frontmatter + callout conversion):
- `import/docs/getting-started.md` → `docs/getting-started/index.md`
- `import/docs/workshop-prep.md` → `docs/getting-started/workshop-prep.md`
- `import/docs/copilot-guide.md` → `docs/guides/copilot-guide.md`
- `import/docs/hints-and-tips.md` → `docs/guides/hints-and-tips.md`
- `import/docs/quick-reference-card.md` → `docs/guides/quick-reference-card.md`
- `import/docs/GLOSSARY.md` → `docs/reference/glossary.md`
- `import/docs/troubleshooting.md` → `docs/reference/troubleshooting.md`
- `import/microhack/challenges/*.md` (8 files + README) → `docs/challenges/`
- `import/microhack/AGENDA.md` → `docs/about/agenda.md` (content UNCHANGED)
- `import/microhack/workshop-invitation.md` → `docs/about/invitation.md`
- `import/microhack/feedback-form.md` → `docs/about/feedback.md`
- `import/microhack/scripts/README.md` → `docs/reference/governance-scripts.md`

### Files EXCLUDED from published site:
- `import/microhack/facilitator/*` (facilitator-guide.md, scoring-rubric.md, solution-reference.md, README.md) — kept in repo only
- `import/docs/upstream-sync.md` — not relevant
- `import/docs/guides/contributing.md` — not relevant
- `import/microhack/participant/README.md` — just a redirect, merged into navigation
- `import/docs/README.md` — repo-level docs index, replaced by site landing page

---

## Verification

1. **Local build test**: `cd docs && bundle install && bundle exec jekyll serve` — site builds with zero errors
2. **Broken links audit**: Verify all internal cross-references resolve after migration
3. **Mermaid rendering**: Verify all Mermaid diagrams render (flowcharts, Gantt charts, sequences)
4. **Callout rendering**: Verify all converted callouts display correctly
5. **`<details>` blocks**: Verify collapsible sections work (hints-and-tips, getting-started)
6. **Search**: Verify full-text search indexes all participant content
7. **Navigation**: Verify sidebar hierarchy matches planned structure
8. **Mobile**: Test responsive layout on mobile viewport
9. **Print**: Verify quick-reference-card prints cleanly
10. **Agenda integrity**: Diff `import/microhack/AGENDA.md` content against `docs/about/agenda.md` — must be identical (only frontmatter added)
11. **404 page**: Navigate to non-existent URL, verify custom 404 renders
12. **GitHub Actions**: Push to main, verify deployment succeeds

---

## Scope Boundaries

**Included:**
- All participant-facing content
- Challenge content (all 8 challenges)
- Governance scripts documentation
- DevContainer for local Jekyll development
- GitHub Pages deployment pipeline
- Theme customization (just-the-docs + Azure colors)
- Navigation structure, search, callouts, Mermaid, code copy

**Excluded:**
- Facilitator-only content on published site (remains in repo)
- Upstream sync documentation
- Contributing guide
- Custom domain configuration
- Analytics/tracking
- Leaderboard app (separate service, referenced but not built here)
- Agent/skill/instruction files (`.github/agents/`, `.github/skills/`) — part of the source project, not this documentation site

---

## Adversarial Review Findings (Incorporated)

### Critical — Must address before implementation:
1. ~~Challenge 4 spoiler~~: **RESOLVED** — Challenge 4 is published openly like all other challenges. No hiding, no spoiler protection. Not referred to as "curveball" in site navigation/titles.
2. **Facilitator content quarantine**: Facilitator files stay in `import/microhack/facilitator/` — NEVER in `docs/`. Add build-time grep validation in GitHub Actions to fail if facilitator/solution content leaks into `docs/`.
3. **Dead `.github/` references**: All content references to `.github/agents/`, `.github/skills/`, `.github/instructions/` must be converted to full GitHub web URLs (e.g., `https://github.com/OWNER/REPO/blob/main/.github/agents/architect.agent.md`).
4. **Ruby version pinning**: Pin Ruby version in DevContainer AND GitHub Actions workflow to match. Commit `Gemfile.lock` for reproducibility.
5. **Complete GitHub Actions workflow**: Provide full workflow YAML (not just action references) with ruby/setup-ruby, bundler-cache, jekyll build, upload-pages-artifact, deploy-pages. Include timeout-minutes.

### High — Significant risk, must plan for:
6. **Mermaid version audit**: Pin Mermaid to tested version (10.6.x, proven in brain-trek). Audit all Mermaid diagrams locally before deployment. Provide static SVG fallbacks for critical diagrams.
7. **Callout syntax validation**: Test just-the-docs v0.10+ callout API locally with one file before batch conversion. Create migration script for `> [!WARNING]` → `{: .warning }` conversion.
8. **Link validation**: Add `htmlproofer` to GitHub Actions to catch broken internal links post-migration. Create link mapping table.
9. **`<details>` block styling**: Add custom SCSS for `<details>` elements (border, padding, cursor) since just-the-docs doesn't style these by default.
10. **Mobile & accessibility**: Test on mobile viewports. Add responsive table CSS wrappers. Run Lighthouse accessibility audit (target ≥90).

### Medium — Address during implementation:
11. **VERSION.md references**: Remove or replace `VERSION.md` cross-references (file doesn't exist in this project).
12. **Content deduplication**: Consolidate overlapping README content into single sources (index.md + challenges/index.md).
13. **Emoji in headings**: Consider removing emojis from headings for accessibility and print compatibility.
14. **Frontmatter validation**: Create markdownlint config enforcing required frontmatter keys.
15. **Dependabot**: Add `.github/dependabot.yml` for Gemfile security updates.
16. **Migration script**: Create `scripts/migrate-docs.sh` to automate file copy, callout conversion, path updates.

### Opportunities — Would significantly elevate the site:
17. **Reusable challenge header include**: Create `_includes/challenge_header.html` Liquid template for consistent metadata (Duration, Points, Agent, Output) across all 8 challenges.
18. **"Report an issue" button**: Add per-page GitHub issue link for participant feedback.
19. **Event mode vs archive mode**: Use `site.event_active` config toggle to show/hide countdown, curveball warnings, etc.
20. **404 page**: Create `docs/404.md` with helpful navigation links.

## Further Considerations

1. **Feedback form**: Link to live Microsoft Forms URL when available. Add prominent CTA button on the feedback page pointing to the actual form.

2. **Logo design**: Create an event-branded SVG logo for `docs/assets/images/logo.svg` and matching `favicon.ico`. Configure in `_config.yml` via `logo` and `favicon_ico` settings. Design should incorporate Azure/Microsoft branding + "Agentic InfraOps MicroHack" identity.
