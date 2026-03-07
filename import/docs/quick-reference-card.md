# Quick Reference Card

> **Print this page** (Ctrl+P → Save as PDF or print double-sided)

---

## Microhack Schedule (6 Hours)

| Time        | Challenge       | Duration | Points |
| ----------- | --------------- | -------- | ------ |
| 10:00-10:30 | Intro           | 30 min   | —      |
| 10:30-11:00 | **Challenge 1** | 30 min   | 20     |
| 11:00-11:30 | **Challenge 2** | 30 min   | 25     |
| 11:30-12:00 | 🍽️ Lunch        | 30 min   | —      |
| 12:00-12:45 | **Challenge 3** | 45 min   | 25     |
| 12:45-13:30 | **Challenge 4** | 45 min   | 10     |
| 13:30-13:45 | ☕ Break        | 15 min   | —      |
| 13:45-14:15 | **Challenge 5** | 30 min   | 5      |
| 14:15-14:30 | **Challenge 6** | 15 min   | 5      |
| 14:30-14:35 | **Challenge 7** | 5 min    | 5      |
| 14:35-14:50 | Prep            | 15 min   | —      |
| 14:50-15:50 | **Challenge 8** | 60 min   | 10     |
| 15:50-16:00 | Wrap-up         | 10 min   | —      |

**Total Points**: 105 base + 25 bonus

## Scoring & Leaderboard

| Method              | How                                                                                              |
| ------------------- | ------------------------------------------------------------------------------------------------ |
| **Script scoring**  | `pwsh scripts/microhack/Score-Team.ps1 -TeamName "<team>" -SkipAzureCheck -ShowcaseScore 0`      |
| **Leaderboard CLI** | `pwsh scripts/microhack/Get-Leaderboard.ps1`                                                     |
| **Web app**         | Open the HackerBoard app URL — submit scores via browser and view live standings                 |
| **Rubric**          | [Scoring Rubric](../microhack/facilitator/scoring-rubric.md) — single source of truth for points |

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
| **Requirements** | Capture requirements              | 1          |
| **Architect**    | Design architecture (WAF)         | 2          |
| **Bicep Plan**   | Create implementation plan        | 3, 4       |
| **Bicep Code**   | Generate Bicep templates          | 3, 4       |
| **Deploy**       | Deploy to Azure                   | 3, 4       |
| **Design**       | Generate documentation & diagrams | 5, 6       |
| **Diagnose**     | Troubleshooting runbooks          | 7          |

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
# Verify setup
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

# Cleanup (END OF DAY!)
az group delete -n rg-freshconnect-dev-swc --yes --no-wait
```

---

## Expected Outputs

| Challenge | Output File/Artifact                                |
| --------- | --------------------------------------------------- |
| 1         | `agent-output/{team}/01-requirements.md`            |
| 2         | `agent-output/{team}/02-architecture-assessment.md` |
| 3         | `infra/bicep/{team}/main.bicep` + modules           |
| 4         | Updated Bicep with DR + ADR document                |
| 5         | `agent-output/{team}/05-load-test-results.md`       |
| 6         | `agent-output/{team}/07-ab-*.md` (documentation)    |
| 7         | `agent-output/{team}/07-ab-*.md` (troubleshooting)  |
| 8         | Presentation (slides or markdown)                   |

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

````

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

## Help!

| Problem               | Solution                   |
| --------------------- | -------------------------- |
| Agent not responding  | Reload VS Code window      |
| Bicep won't compile   | Check `bicep build` output |
| Name too long         | Use `take()` function      |
| Zone redundancy error | Use P1v3+ SKU              |

---

**Team**: **\*\*\*\***\_**\*\*\*\*** **Score**: **\_**/130
````
