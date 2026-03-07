---
description: "Step 2: Create Jekyll scaffolding — Gemfile, _config.yml, GitHub Actions workflow, 404 page, .gitignore. This is the core site configuration."
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

# Site Step 2: Jekyll Scaffold

## Mission

Create the Jekyll configuration files that define the site structure, theme, and deployment pipeline. After this step, running `bundle exec jekyll build` in `docs/` should produce a site skeleton with the just-the-docs theme.

## Prerequisites

- Step 1 complete (devcontainer exists — not required but provides context)

## Context to Load

1. Read the session tracker: `.github/exec-plans/active/site-execution.md` — verify A2 is the current step
2. Read plan Phases 2 and 7: `.github/prompts/plan-agenticInfraOpsMicrohack.prompt.md`

## Tasks

### Task 1: Create `docs/Gemfile`

```ruby
source "https://rubygems.org"

gem "jekyll", "~> 4.4"
gem "just-the-docs", "~> 0.10"
gem "jekyll-feed", "~> 0.15"
gem "jekyll-seo-tag", "~> 2.8"
gem "jekyll-sitemap", "~> 1.4"
gem "jekyll-relative-links", "~> 0.7"
gem "html-proofer", "~> 5.0", group: :test
```

### Task 2: Create `docs/_config.yml`

Key settings (adapt to just-the-docs v0.10 syntax — fetch the just-the-docs docs if needed to verify config keys):

```yaml
title: "Agentic InfraOps MicroHack"
description: "6-hour hands-on microhack: Design, deploy, and present Azure infrastructure using AI agents and GitHub Copilot"
baseurl: "/microhack-agentic-infraops"
url: "https://jonathan-vella.github.io"

theme: just-the-docs

color_scheme: custom

logo: "/assets/images/logo.svg"
favicon_ico: "/assets/images/favicon.ico"

# Search
search_enabled: true
search:
  heading_level: 2

# UI features
enable_copy_code_button: true
heading_anchors: true
back_to_top: true
back_to_top_text: "Back to top"

# Navigation
nav_sort: case_insensitive
breadcrumbs: true

# Mermaid — verify exact config key for just-the-docs v0.10+
mermaid:
  version: "10.6.0"

# Callouts
callouts:
  warning:
    title: Warning
    color: yellow
  note:
    title: Note
    color: blue
  important:
    title: Important
    color: green
  tip:
    title: Tip
    color: purple
  time:
    title: Time Check
    color: red

# External links
aux_links:
  "View on GitHub":
    - "https://github.com/jonathan-vella/microhack-agentic-infraops"
aux_links_new_tab: true

# Edit on GitHub
gh_edit_link: true
gh_edit_link_text: "Edit this page on GitHub"
gh_edit_repository: "https://github.com/jonathan-vella/microhack-agentic-infraops"
gh_edit_source: docs
gh_edit_branch: "main"

# Footer
footer_content: "&copy; 2026 Jonathan Vella. Distributed under the <a href=\"https://github.com/jonathan-vella/microhack-agentic-infraops/blob/main/LICENSE\">MIT License</a>."

# Plugins
plugins:
  - jekyll-feed
  - jekyll-seo-tag
  - jekyll-sitemap
  - jekyll-relative-links

# Kramdown
kramdown:
  parse_block_html: false  # We use markdown="1" on specific elements instead

# Build exclusions
exclude:
  - Gemfile
  - Gemfile.lock
  - README.md
  - LICENSE
  - .gitignore
  - node_modules
  - vendor
  - exec-plans
```

### Task 3: Create `.github/workflows/pages.yml`

Build and deploy using GitHub Actions (NOT classic Pages mode):

```yaml
name: Deploy Jekyll site to GitHub Pages

on:
  push:
    branches: ["main"]
    paths:
      - "docs/**"
      - ".github/workflows/pages.yml"
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.3'
          bundler-cache: true
          working-directory: docs

      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v5

      - name: Build with Jekyll
        run: bundle exec jekyll build --baseurl "${{ steps.pages.outputs.base_path }}"
        working-directory: docs
        env:
          JEKYLL_ENV: production

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v4
        with:
          path: docs/_site

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    timeout-minutes: 5
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### Task 4: Create `docs/404.md`

```markdown
---
layout: default
title: "404 - Page Not Found"
nav_exclude: true
search_exclude: true
permalink: /404.html
---

# Page not found

Sorry, the page you're looking for doesn't exist.

**Try these instead:**

- [Home]({{ site.baseurl }}/) — Start here
- [Getting Started]({{ site.baseurl }}/getting-started/) — Setup your environment
- [Challenges]({{ site.baseurl }}/challenges/) — View all challenges
- [Guides]({{ site.baseurl }}/guides/) — Copilot and agent guides
```

### Task 5: Create `docs/.gitignore`

```
_site/
.jekyll-cache/
.jekyll-metadata
vendor/
.bundle/
.sass-cache/
```

## Completion Criteria

- [ ] `docs/Gemfile` exists with all gems specified
- [ ] `docs/_config.yml` exists with complete configuration
- [ ] `.github/workflows/pages.yml` exists with build + deploy jobs
- [ ] `docs/404.md` exists
- [ ] `docs/.gitignore` exists
- [ ] YAML is valid (no syntax errors in _config.yml or workflow)

## After Completion

Update the session tracker (`.github/exec-plans/active/site-execution.md`):
1. Check off A2 items
2. Update "Current Session Target" to A3
3. Append a session log entry
