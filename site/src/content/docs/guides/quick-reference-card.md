---
title: Quick Reference Card
description: At-a-glance reference card for challenges, scoring, agents, and key commands
sidebar:
  order: 3
---

> **Print this page** (Ctrl+P → Save as PDF or print double-sided). Optimized for A4 paper and narrow screens.

---

## Key Actions at a Glance

1. **Before the event** → Run the [Participation Gate](../../getting-started/setup/#participation-gate)
2. **First 10 minutes** → Open Dev Container, `az login`, verify agents
3. **Each challenge** → Check inputs, produce outputs, hand off to next challenge
4. **End of day** → Team lead deletes resources and confirms cleanup

---

## Hackathon Schedule (1 Day)

| Time        | Challenge       | Duration | Points |
| ----------- | --------------- | -------- | ------ |
| 09:00-10:00 | Intro           | 60 min   | —      |
| 10:00-11:00 | **Challenge 1** | 60 min   | 20     |
| 11:00-12:00 | **Challenge 2** | 60 min   | 25     |
| 12:00-12:45 | 🍽️ Lunch        | 45 min   | —      |
| 12:45-13:30 | **Challenge 3** | 45 min   | 25     |
| 13:30-14:15 | **Challenge 4** | 45 min   | 10     |
| 14:15-14:30 | Checkpoint      | 15 min   | —      |
| 14:30-15:00 | **Challenge 5** | 30 min   | 5      |
| 15:00-15:15 | ☕ Break        | 15 min   | —      |
| 15:15-15:30 | **Challenge 6** | 15 min   | 5      |
| 15:30-15:35 | **Challenge 7** | 5 min    | 5      |
| 15:35-15:50 | Prep            | 15 min   | —      |
| 15:50-16:50 | **Challenge 8** | 60 min   | 10     |
| 16:50-17:00 | Wrap-up         | 10 min   | —      |

**Total Points**: 105 base + 25 bonus

## Scoring & Leaderboard

| Method              | How                                                                                              |
| ------------------- | ------------------------------------------------------------------------------------------------ |
| **Rubric scoring**  | All scoring is manual. Facilitators review artifacts and verify deployments against the rubric.   |
| **Leaderboard**     | Use your facilitator worksheet or HackerBoard instance if your event package includes one         |
| **Tooling**         | Optional: record rubric-based totals in HackerBoard when that tooling is available (it does not calculate scores automatically) |
| **Rubric**          | Scoring Rubric (available from facilitator) — single source of truth for points |

---

## Keyboard Shortcuts

| Shortcut       | Action                        |
| -------------- | ----------------------------- |
| `Ctrl+Alt+I`   | Open Chat view                |
| `Ctrl+Shift+I` | Switch to Agent mode          |
| `Ctrl+I`       | Inline chat (editor/terminal) |
| `Ctrl+N`       | New chat session              |
| `Ctrl+Alt+.`   | Model picker                  |
| `Tab`          | Accept suggestion             |
| `Escape`       | Dismiss suggestion            |

---

## Custom Agents

Select from the **agent dropdown** in Chat view:

| Agent            | Purpose                           | Challenges |
| ---------------- | --------------------------------- | ---------- |
| **01-Orchestrator** | Master orchestrator for the full 7-step workflow | All (optional entry point) |
| **02-Requirements** | Capture requirements              | 1          |
| **03-Architect**    | Design architecture and DR trade-offs | 2, 4   |
| **04-Design**       | Generate diagrams, reports, and docs | 2, 4, 5, 6, 7 (optional) |
| **04g-Governance**  | Discover Azure Policy constraints | 3 (before planning) |
| **05-IaC Planner**  | Create the implementation plan    | 3          |
| **06b-Bicep CodeGen** | Generate Bicep templates        | 3, 4       |
| **06t-Terraform CodeGen** | Generate Terraform templates | 3, 4       |
| **07b-Bicep Deploy** | Deploy Bicep infrastructure      | 3, 4       |
| **07t-Terraform Deploy** | Deploy Terraform infrastructure | 3, 4    |
| **08-As-Built**     | Generate post-deployment documentation | 6, 7   |
| **09-Diagnose**     | Troubleshooting runbooks          | 7          |

**How to use**: `Ctrl+Alt+I` → Click agent dropdown → Select agent → Type prompt

---

## Chat Features

| Feature             | How to Use                                 |
| ------------------- | ------------------------------------------ |
| **Context**         | `#file`, `#folder`, `#symbol`, drag & drop |
| **Codebase search** | `#codebase` in prompt                      |
| **Fetch web page**  | `#fetch url`                               |
| **Workspace**       | `@workspace` for workspace questions       |
| **Terminal**        | `@terminal` for shell help                 |
| **Slash commands**  | `/fix`, `/explain`, `/tests`, `/doc`       |

---

## Essential CLI Commands

```bash
az account show --query name -o tsv
bicep --version

# Create resource group
az group create -n rg-freshconnect-dev-swc -l swedencentral

# Validate Bicep
bicep build main.bicep
bicep lint main.bicep

# What-If deployment
az deployment group what-if -g rg-freshconnect-dev-swc -f main.bicep

# Deploy
az deployment group create -g rg-freshconnect-dev-swc -f main.bicep

# Cleanup (END OF DAY — team lead is responsible!)
az group delete -n rg-freshconnect-dev-swc --yes --no-wait
az group delete -n rg-freshconnect-dev-gwc --yes --no-wait  # if secondary region was used
# Verify cleanup:
az group list --query "[?starts_with(name, 'rg-freshconnect')]" -o table
```

Ask your facilitator to remove governance policies from the team subscription.

---

## Bonus Targets (+25 max)

| Enhancement | Points | What to prove |
| ----------- | ------ | ------------- |
| Zone Redundancy | +5 | Supported SKU with zone redundancy enabled |
| Private Endpoints | +5 | Private connectivity for the relevant services |
| Multi-Region DR | +10 | Real DR design or deployment spanning 2+ regions |
| Managed Identities | +5 | Identity-based access with no hard-coded connection strings |

---

## Expected Outputs

| Challenge | Input Artifact | Output File/Artifact | Next Action |
| --------- | -------------- | --------------------------------------------------- | ----------- |
| 1         | Scenario brief | `agent-output/freshconnect/01-requirements.md` | C2: Architecture |
| 2         | `01-requirements.md` | `agent-output/freshconnect/02-architecture-assessment.md`, `agent-output/freshconnect/03-des-architecture-diagram.md` | C3: Implementation |
| 3         | C2 assessment + diagram | `agent-output/freshconnect/04-implementation-plan.md`, `agent-output/freshconnect/03-des-deployment-workflow.md`, `agent-output/freshconnect/06-deployment-summary.md`, `infra/bicep/freshconnect/` or `infra/terraform/freshconnect/` | C4: DR Curveball |
| 4         | C3 IaC + deployment outcome | `agent-output/freshconnect/04-adr-ha-dr-strategy.md`, updated diagram, updated IaC or paper design | C5: Load Test |
| 5         | Deployed endpoint or fallback plan | `agent-output/freshconnect/05-load-test-results.md` | C6: Documentation |
| 6         | All prior artifacts | `agent-output/freshconnect/07-ab-operations-guide.md` + 1 additional doc | C7: Diagnostics |
| 7         | Platform knowledge + docs | `agent-output/freshconnect/07-diagnostics-quick-card.md` | C8: Showcase |
| 8         | All prior artifacts | Live presentation and Q&A | Wrap-up |

## Artifact Handoff Contract

Every challenge uses the same handoff rule:

- Check the required input artifact before you start.
- Save the new artifact at the expected path.
- Name assumptions and gaps clearly if you could not complete a deploy step.
- Make the next challenge easier, not harder, by leaving usable evidence behind.

## Prompt Recipe

Use this short recipe when a challenge page tells you to prompt an agent:

```text
Goal: [artifact or decision]
Context: [FreshConnect facts + prior artifact path]
Decisions now: [2-4 key trade-offs]
Return: [file name, format, and evidence required]
```

## Mermaid & ADR Conventions

- Mermaid diagrams should show the services, data flow, boundaries, and failure or
  handoff path that matters for the challenge.
- Workflow diagrams should show decisions and feedback loops, not just a straight line.
- ADRs should always cover `Context`, `Decision`, `Consequences`, and `Alternatives`.
- Keep diagrams readable enough to present in Challenge 8 without rework.

## Paper Exercise Rules

- Use the paper path only when deployment is genuinely blocked.
- Keep the same output artifact names where possible.
- Record the blocker, intended change, and expected outcome.
- Do not present design intent as deployed evidence.

---

## Pro Tips

**Challenge 3 — Mermaid Flowcharts:**

`````markdown
````mermaid
graph TD
    A[Start] --> B[Decision]
    B -->|Yes| C[Deploy]
    B -->|No| D[Refine]
\```
````
`````

**Challenge 4 — ADR Template:**

```markdown
# ADR: Multi-Region Disaster Recovery

## Context

[Why DR is needed now]

## Decision

[What approach we chose]

## Consequences

[Cost, complexity, benefits]
```

**Challenge 6 — Documentation Prompts:**

- "Generate ops runbook for [audience]"
- "Create cost breakdown with optimization tips"
- "Document DR procedures for compliance audit"

**Challenge 7 — Diagnostic Queries:**

```bash
# Quick health check
az webapp show --name <app-name> --resource-group <rg> --query state

# Application Insights query
az monitor app-insights query --app <app-id> \
  --analytics-query "requests | where timestamp > ago(1h) | summarize avg(duration)"
```

---

## Naming Conventions

| Resource    | Pattern                        | Max |
| ----------- | ------------------------------ | --- |
| Key Vault   | `kv-{project}-{env}-{suffix}`  | 24  |
| Storage     | `st{project}{env}{suffix}`     | 24  |
| SQL Server  | `sql-{project}-{env}-{suffix}` | 63  |
| App Service | `app-{project}-{env}-{region}` | 60  |

**Generate unique suffix**:

```bicep
var uniqueSuffix = uniqueString(resourceGroup().id)
```

---

## Security Checklist

- [ ] `supportsHttpsTrafficOnly: true`
- [ ] `minimumTlsVersion: 'TLS1_2'`
- [ ] `allowBlobPublicAccess: false`
- [ ] `azureADOnlyAuthentication: true`
- [ ] Managed Identity (no connection strings)

---

## Budget Guide

| Phase           | Budget     | Region               |
| --------------- | ---------- | -------------------- |
| Challenges 1-3  | €500/month | swedencentral        |
| After Curveball | €700/month | + germanywestcentral |

---

## Load Test Targets

| Metric           | Target      |
| ---------------- | ----------- |
| Concurrent Users | 500         |
| P95 Response     | ≤ 2 seconds |
| Error Rate       | ≤ 1%        |

---

## Help

| Problem               | Solution                   |
| --------------------- | -------------------------- |
| Agent not responding  | Reload VS Code window      |
| Bicep won't compile   | Check `bicep build` output |
| Name too long         | Use `take()` function      |
| Zone redundancy error | Use P1v3+ SKU              |

---

**Team**: **\*\*\*\***\_**\*\*\*\*** **Score**: **\_**/130
