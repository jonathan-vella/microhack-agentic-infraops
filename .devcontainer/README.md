# DevContainer — Agentic InfraOps MicroHack

This devcontainer provides the complete environment for both running the MicroHack workshop and building the documentation site.

## What's Included

| Tool | Version | Purpose |
|---|---|---|
| Python 3 + pip | 3.12 | MkDocs documentation site, MCP server |
| Node.js + npm | LTS | markdownlint-cli2 |
| Azure CLI (`az`) | Latest | Azure resource management |
| Bicep CLI | Latest | Infrastructure as Code (installed via Azure CLI feature) |
| GitHub CLI (`gh`) | Latest | Repository and PR management |
| PowerShell (`pwsh`) | 7.x | Deployment scripts, microhack automation |
| k6 | Latest | Load testing (challenge 5) |

**VS Code extensions** — Azure Bicep, Azure CLI Tools, PowerShell, Azure Resource Groups, Markdown linting, YAML support, Mermaid preview

## Getting Started

### 1. Open in DevContainer

In VS Code: **Ctrl+Shift+P** → `Dev Containers: Reopen in Container`

### 2. Start the MkDocs Dev Server

```bash
mkdocs serve
```

### 3. Preview the Site

Open [http://localhost:8000](http://localhost:8000) in your browser (port 8000 is auto-forwarded).

## Useful Commands

| Command | Purpose |
|---|---|
| `mkdocs serve` | Start dev server with live reload |
| `mkdocs build --strict` | Build site without serving |
| `markdownlint-cli2 "docs/**/*.md"` | Lint all markdown files |
