# Documentation

> [Current Version](../VERSION.md) | Central hub for all Agentic InfraOps Workshop documentation

## Quick Links

| Guide                                           | Description                                 |
| ----------------------------------------------- | ------------------------------------------- |
| [Getting Started](getting-started.md)           | Setup, dev container, quotas, first run     |
| [Workshop Prep](workshop-prep.md)               | Scenario brief and team role cards          |
| [Copilot Guide](copilot-guide.md)               | VS Code, agents, skills, and prompting tips |
| [Hints & Tips](hints-and-tips.md)               | Challenge-specific guidance                 |
| [Quick Reference Card](quick-reference-card.md) | Printable one-page cheat sheet              |
| [Troubleshooting](troubleshooting.md)           | Common issues and fixes                     |
| [Upstream Sync](upstream-sync.md)               | How upstream changes flow to this repo      |
| [Glossary](GLOSSARY.md)                         | Key terms and definitions                   |
| [Contributing](guides/contributing.md)          | Git workflow, commits, and versioning       |

## Agents and Skills

See [Copilot Guide](copilot-guide.md) for the full agent and skill reference,
including personas, steps, models, and usage tips.

## Project Structure

```text
├── .github/
│   ├── agents/             # 10 agent definitions + 3 subagents
│   ├── skills/             # 8 skill definitions
│   │   └── azure-artifacts/templates/  # 16 artifact templates
│   └── instructions/       # 15 file-type instruction files
├── agent-output/{project}/ # Agent-generated artifacts (01-07)
├── docs/                   # User-facing documentation (this folder)
├── microhack/              # 6-hour hands-on microhack materials
├── infra/bicep/            # Generated Bicep templates
├── mcp/azure-pricing-mcp/  # Azure Pricing MCP server
└── scripts/                # Validation and automation scripts
```

## Validation Commands

```bash
# Markdown lint
npm run lint:md

# Link validation (docs/ only)
npm run lint:links:docs

# Full validation suite
npm run validate:all
```
