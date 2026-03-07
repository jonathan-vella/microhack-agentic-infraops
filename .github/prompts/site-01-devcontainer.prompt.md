---
description: "Step 1: Create DevContainer for Jekyll development. Sets up the development environment with Ruby, Node.js, and VS Code extensions."
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

# Site Step 1: DevContainer Setup

## Mission

Create the `.devcontainer/` configuration for Jekyll local development. This enables contributors to spin up a ready-to-use Jekyll environment with a single click.

## Prerequisites

- None (this is the first step)

## Context to Load

1. Read the session tracker: `.github/exec-plans/active/site-execution.md` — verify A1 is the current step
2. Read plan Phase 1 only: `.github/prompts/plan-agenticInfraOpsMicrohack.prompt.md`

## Tasks

### Task 1: Create `.devcontainer/devcontainer.json`

Model after the brain-trek repo pattern:

```json
{
  "name": "Jekyll Dev - Agentic InfraOps MicroHack",
  "image": "mcr.microsoft.com/devcontainers/jekyll:2-bookworm",
  "features": {
    "ghcr.io/devcontainers/features/node:1": {
      "version": "lts"
    }
  },
  "forwardPorts": [4000],
  "postCreateCommand": "sh /usr/local/post-create.sh && npm install -g markdownlint-cli2",
  "customizations": {
    "vscode": {
      "extensions": [
        "DavidAnson.vscode-markdownlint",
        "yzhang.markdown-all-in-one",
        "bierner.markdown-mermaid",
        "redhat.vscode-yaml",
        "EditorConfig.EditorConfig",
        "esbenp.prettier-vscode",
        "sissel.shopify-liquid"
      ],
      "settings": {
        "editor.formatOnSave": true,
        "editor.defaultFormatter": "esbenp.prettier-vscode",
        "[markdown]": {
          "editor.defaultFormatter": "DavidAnson.vscode-markdownlint"
        }
      }
    }
  }
}
```

### Task 2: Create `.devcontainer/README.md`

Brief docs covering:
- How to open in a devcontainer (VS Code "Reopen in Container")
- How to start Jekyll: `cd docs && bundle install && bundle exec jekyll serve`
- Preview URL: `http://localhost:4000/microhack-agentic-infraops/`
- How to run markdownlint: `markdownlint-cli2 "docs/**/*.md"`

## Completion Criteria

- [ ] `.devcontainer/devcontainer.json` exists with all specified config
- [ ] `.devcontainer/README.md` exists with usage instructions
- [ ] JSON is valid (no syntax errors)

## After Completion

Update the session tracker (`.github/exec-plans/active/site-execution.md`):
1. Check off A1 items
2. Update "Current Session Target" to A2
3. Append a session log entry
