# Copilot Guide

> [Current Version](../VERSION.md) | VS Code, GitHub Copilot, agents, skills, and prompting best practices

## VS Code Essentials

Visual Studio Code is your development environment. Here are the key features:

| Feature                 | Shortcut       | What It Does                               |
| ----------------------- | -------------- | ------------------------------------------ |
| **Command Palette**     | `Ctrl+Shift+P` | Run any VS Code command by name            |
| **Integrated Terminal** | `` Ctrl+` ``   | Run Azure CLI, Bicep, k6, and Git commands |
| **Explorer**            | `Ctrl+Shift+E` | Browse files and folders                   |
| **Search**              | `Ctrl+Shift+F` | Search across all files in the workspace   |
| **Copilot Chat**        | `Ctrl+Alt+I`   | Open the AI assistant panel                |
| **Inline Chat**         | `Ctrl+I`       | Quick AI help inside a file                |

### Dev Container

This workshop runs inside a **Dev Container** — a Docker-based environment with all tools
pre-installed (Azure CLI, Bicep, k6, Node.js, Python). You don't need to install anything
on your local machine beyond Docker and VS Code.

When you open the repository, VS Code prompts you to "Reopen in Container." Accept this to
get the fully configured environment. See [Getting Started](getting-started.md#dev-container-setup) for details.

---

## GitHub Copilot Overview

GitHub Copilot is an AI coding assistant built into VS Code. This project requires a
**Copilot Pro+** or **Copilot Enterprise** license (verified during
[pre-event setup](getting-started.md#accounts)).

Copilot works in three main modes, each suited to different tasks:

### Ask Mode

**What it does**: Quick Q&A — ask questions and get answers without making changes.

**When to use**: Research, exploration, understanding concepts.

**Example prompts**:

- "What's the difference between App Service and Container Apps?"
- "Explain Azure SQL Database geo-replication"
- "What WAF pillar covers backup and recovery?"

### Edit Mode

**What it does**: Make targeted changes to specific files. You select files and Copilot
proposes edits you can accept or reject.

**When to use**: Modifying existing files, fixing issues, small focused changes.

**Example prompts**:

- "Add a Key Vault module parameter to main.bicep"
- "Fix the naming convention in this storage account resource"

### Agent Mode

**What it does**: Autonomous multi-step work. The agent can read files, run terminal
commands, create files, search the codebase, and iterate until the task is complete.

**When to use**: Complex tasks that span multiple files and require tool use. **This is
the primary mode for this microhack.**

**Example prompts**:

- "Capture requirements for a farm-to-table delivery platform using the requirements agent"
- "Generate Bicep templates for the FreshConnect architecture"
- "Deploy the infrastructure to Azure and summarize the results"

> [!TIP]
> Use **Agent mode** for most challenges. It can invoke custom agents, read templates,
> run Azure CLI commands, and generate documentation — all in a single conversation.

---

## Custom Agents

This workshop includes **8 specialized agents** that understand Azure infrastructure
patterns, best practices, and the 7-step workflow. Each agent has a focused role.

### How Agents Work

Agents are defined as markdown files in `.github/agents/`. When you select an agent from
the Chat dropdown, Copilot loads that agent's instructions — including what skills to read,
what output format to use, and what quality checks to perform.

### Selecting an Agent

1. Open Copilot Chat (`Ctrl+Alt+I`)
2. Click the **agent dropdown** at the top of the chat panel
3. Select the agent for your current challenge
4. Type your prompt

### Available Agents

| Agent                  | Persona       | Step | Purpose                                             |
| ---------------------- | ------------- | ---- | --------------------------------------------------- |
| **InfraOps Conductor** | 🎼 Maestro    | All  | Master orchestrator for the full 7-step workflow    |
| **Requirements**       | 📜 Scribe     | 1    | Capture functional and non-functional requirements  |
| **Architect**          | 🏛️ Oracle     | 2    | Design WAF-aligned architecture with cost estimates |
| **Design**             | 🎨 Artisan    | 3    | Generate architecture diagrams and documentation    |
| **Bicep Plan**         | 📐 Strategist | 4    | Create implementation plans                         |
| **Bicep Code**         | ⚒️ Forge      | 5    | Generate Bicep templates                            |
| **Deploy**             | 🚀 Envoy      | 6    | Deploy infrastructure to Azure                      |
| **Diagnose**           | 🔍 Sentinel   | —    | Troubleshooting and diagnostic runbooks             |

### Subagents

Some agents delegate specialist tasks to **subagents** — smaller, focused agents that run
inside the parent agent's workflow:

| Subagent                  | Parent     | Purpose                                        |
| ------------------------- | ---------- | ---------------------------------------------- |
| **bicep-lint-subagent**   | bicep-code | Runs `bicep build` and `bicep lint` validation |
| **bicep-review-subagent** | bicep-code | Reviews Bicep code for best practices          |
| **bicep-whatif-subagent** | deploy     | Runs `az deployment group what-if` analysis    |

You don't select subagents directly — they're invoked automatically by their parent agent.

---

## Prompting Best Practices

### Be Specific

Bad: "Create some infrastructure"

Good: "Create a hub-spoke network in swedencentral with Application Gateway,
two spoke VNets, and a shared Key Vault. Budget: €300/month."

### Reference Artifacts

Agents work best when pointed at existing context:

```text
Read 01-requirements.md and create a WAF architecture assessment
```

### One Step at a Time

Use the **InfraOps Conductor** for multi-step workflows.
For targeted work, invoke agents directly:

```text
@Requirements — Capture requirements for a static web app
@Architect — Assess the requirements in 01-requirements.md
@Bicep Plan — Create an implementation plan from 02-architecture-assessment.md
```

### Agent-Specific Tips

| Agent                        | Best Approach                                                                           |
| ---------------------------- | --------------------------------------------------------------------------------------- |
| **Requirements** (📜 Scribe) | Describe the **business problem** not the technical solution.                           |
| **Architect** (🏛️ Oracle)    | Always let it read `01-requirements.md` first. Request cost estimates explicitly.       |
| **Design** (🎨 Artisan)      | Request diagrams after architecture assessment exists.                                  |
| **Bicep Code** (⚒️ Forge)    | It prefers Azure Verified Modules (AVM). Let it read `04-implementation-plan.md` first. |
| **Deploy** (🚀 Envoy)        | Ensure `az login` is active. It runs `what-if` before deployment — review the preview.  |

### Use `#file` References

Drag files into the chat panel or use `#file:path` to give agents explicit context.
This is especially useful when referencing artifacts from previous steps.

---

## Skills

Skills are **reusable knowledge modules** that agents read to get domain-specific context.
They're defined as `SKILL.md` files in `.github/skills/`.

### How Skills Work

When an agent starts working, it reads specific skill files to understand:

- What output format to use (H2 heading templates)
- What Azure best practices to follow
- What naming conventions to apply
- What tools are available (like the Azure Pricing MCP)

### Available Skills

| Skill                   | Purpose                                            | Used By            |
| ----------------------- | -------------------------------------------------- | ------------------ |
| **azure-defaults**      | Regions, tags, naming, security baselines          | All agents         |
| **azure-artifacts**     | Output templates (H2 structures for each artifact) | All agents         |
| **azure-diagrams**      | Python architecture diagram generation             | design             |
| **azure-adr**           | Architecture Decision Records format               | design, bicep-plan |
| **docs-writer**         | Documentation generation standards                 | design             |
| **git-commit**          | Commit message conventions                         | All agents         |
| **github-operations**   | Issues, PRs, GitHub CLI patterns                   | All agents         |
| **make-skill-template** | Template for creating new skills                   | Meta               |

### Skill Triggers

Skills auto-load based on keyword matching in your prompt:

| Keyword                               | Skill Triggered     |
| ------------------------------------- | ------------------- |
| "create diagram"                      | `azure-diagrams`    |
| "create ADR", "document decision"     | `azure-adr`         |
| "commit", "git commit"                | `git-commit`        |
| "create issue", "create PR"           | `github-operations` |
| "update docs", "check freshness"      | `docs-writer`       |
| "azure defaults", "naming convention" | `azure-defaults`    |

You can also explicitly invoke a skill:

```text
Read .github/skills/azure-diagrams/SKILL.md and generate an architecture diagram
for FreshConnect.
```

---

## Custom Instructions

Instructions are **rules that auto-load based on file type**. They ensure consistency
without you having to remember every convention.

### How Instructions Work

Each instruction file has an `applyTo` pattern in its frontmatter. When you work with
files matching that pattern, the instruction loads automatically:

```yaml
---
applyTo: "**/*.bicep"
description: "Infrastructure as Code best practices for Azure Bicep templates"
---
```

### Key Instructions in This Workshop

| Instruction                  | Applies To          | What It Does                             |
| ---------------------------- | ------------------- | ---------------------------------------- |
| `bicep-code-best-practices`  | `**/*.bicep`        | Bicep naming, modules, security patterns |
| `markdown.instructions`      | `**/*.md`           | Markdown formatting standards            |
| `cost-estimate.instructions` | Cost estimate files | Cost documentation structure             |
| `artifact-h2-reference`      | Agent output files  | Template compliance rules                |

### The Global Instruction File

The file `.github/copilot-instructions.md` contains project-wide rules that apply to
**every** Copilot interaction. It defines:

- The 7-step workflow overview
- Default region (`swedencentral`)
- Required tags (`Environment`, `ManagedBy`, `Project`, `Owner`)
- Security baselines (TLS 1.2, HTTPS-only, managed identity)
- Available agents and skills

---

## MCP Servers (Model Context Protocol)

MCP servers extend Copilot's capabilities with external data sources and APIs.

### Azure Pricing MCP

This workshop includes an **Azure Pricing MCP server** that gives agents access to
real-time Azure pricing data. When the **architect** agent generates a cost estimate,
it queries this server for accurate per-service pricing.

**What it enables**:

- Accurate monthly cost estimates in EUR
- Per-service cost breakdowns
- Cost comparison between service tiers
- Budget validation against the €500/€700 constraints

You don't need to interact with the MCP server directly — agents use it automatically
when generating cost estimates.

---

## The Complete Picture

Here's how all the pieces connect:

```text
You (prompt)
  └─→ Agent (e.g., architect)
        ├─→ Reads Skills (azure-defaults, azure-artifacts)
        ├─→ Follows Instructions (bicep-best-practices, markdown)
        ├─→ Uses MCP Server (Azure Pricing for cost estimates)
        ├─→ Reads Templates (H2 structures from azure-artifacts)
        ├─→ May invoke Subagents (bicep-lint, bicep-review)
        └─→ Generates Artifacts (agent-output/{project}/*.md)
```

### Workflow Through the Microhack

```text
Challenge 1 → Requirements  → 01-requirements.md
Challenge 2 → Architect     → 02-architecture-assessment.md + cost estimate
              Design        → architecture diagram (Python)
Challenge 3 → Bicep Plan    → 04-implementation-plan.md
              Bicep Code    → infra/bicep/{project}/*.bicep
              Deploy        → 06-deployment-summary.md
Challenge 4 → (same as 3, adapted for DR)
Challenge 5 → Design        → 05-load-test-results.md
Challenge 6 → Design        → 07-ab-*.md documentation suite
Challenge 7 → Diagnose      → troubleshooting card
Challenge 8 → (team presentation — no agent needed)
```

---

## Common Patterns

### Full Workflow

```text
@InfraOps Conductor
Build an e-commerce platform on Azure with App Service, Azure SQL,
Redis Cache, and Application Gateway. Budget: €500/month. Region: swedencentral.
```

### Diagnose an Existing Resource

```text
@Diagnose
Check the health of my App Service named "myapp-prod" in resource group "rg-prod"
```

### Generate Documentation Only

```text
@Design
Generate an architecture diagram for the infrastructure defined in
02-architecture-assessment.md
```

---

## Quick Reference

| Concept       | Location                                    | Purpose                      |
| ------------- | ------------------------------------------- | ---------------------------- |
| Agents        | `.github/agents/*.agent.md`                 | Specialized AI assistants    |
| Skills        | `.github/skills/*/SKILL.md`                 | Reusable knowledge modules   |
| Instructions  | `.github/instructions/*.instructions.md`    | Auto-loading file-type rules |
| Global config | `.github/copilot-instructions.md`           | Project-wide defaults        |
| Templates     | `.github/skills/azure-artifacts/templates/` | Output structure definitions |
| MCP servers   | `.vscode/mcp.json`                          | External data sources        |
| Agent output  | `agent-output/{project}/`                   | Generated artifacts          |

---

## See Also

- [Getting Started](getting-started.md) — Setup, dev container, quotas, and first run
- [Quick Reference Card](quick-reference-card.md) — Printable one-page reference
- [Hints & Tips](hints-and-tips.md) — Challenge-specific guidance
- [Troubleshooting](troubleshooting.md) — Common issues and agent fixes
