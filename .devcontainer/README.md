# DevContainer — Agentic InfraOps MicroHack

This devcontainer provides the complete environment for both running the MicroHack workshop and building the documentation site.

## What's Included

| Tool | Version | Purpose |
|---|---|---|
| Ruby + Jekyll | via base image | Documentation site generation |
| Node.js + npm | LTS | markdownlint-cli2 |
| Azure CLI (`az`) | Latest | Azure resource management |
| Bicep CLI | Latest | Infrastructure as Code (installed via Azure CLI feature) |
| GitHub CLI (`gh`) | Latest | Repository and PR management |
| Python 3 + pip | 3.12 | Diagram generation, MCP server |
| PowerShell (`pwsh`) | 7.x | Deployment scripts, microhack automation |
| k6 | Latest | Load testing (challenge 5) |

**VS Code extensions** — Azure Bicep, Azure CLI Tools, PowerShell, Azure Resource Groups, Markdown linting, YAML support, Mermaid preview

## Getting Started

### 1. Open in DevContainer

In VS Code: **Ctrl+Shift+P** → `Dev Containers: Reopen in Container`

### 2. Start the Jekyll Dev Server

```bash
cd docs
bundle install
bundle exec jekyll serve
```

### 3. Preview the Site

Open [http://localhost:4000/microhack-agentic-infraops/](http://localhost:4000/microhack-agentic-infraops/) in your browser (port 4000 is auto-forwarded).

## Useful Commands

| Command | Purpose |
|---|---|
| `cd docs && bundle exec jekyll serve` | Start dev server with live reload |
| `cd docs && bundle exec jekyll build` | Build site without serving |
| `markdownlint-cli2 "docs/**/*.md"` | Lint all markdown files |
| `cd docs && bundle exec htmlproofer _site/` | Check for broken links |
