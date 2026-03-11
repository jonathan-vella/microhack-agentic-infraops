# Facilitator Guide

> **For microhack coaches and facilitators only.**

## Event Overview

| Aspect      | Details                               |
| ----------- | ------------------------------------- |
| Duration    | 1 day (09:00 - 17:00)                 |
| Team Size   | 3-6 members per team                  |
| Teams       | Flexible based on cohort              |
| Format      | Challenge-based, full 7-step workflow |
| Skill Level | Azure portal familiar, new to IaC     |

## Your Role

1. **Guide, don't solve** — Help teams find answers, don't write their code
2. **Monitor progress** — Check in with each team every 15-20 minutes
3. **Unblock non-learning issues fast** — Don't let teams stall >5 minutes on environment or tooling problems
4. **Encourage experimentation** — There's no single "correct" architecture
5. **Celebrate learning** — The goal is understanding, not perfection

---

## Coaching Philosophy

**Answer questions with questions.** Your goal is to help teams develop problem-solving skills, not
to provide direct solutions.

### Coaching Phrases to Use

| Situation                    | Say This                                        |
| ---------------------------- | ----------------------------------------------- |
| Team asks how to fix error   | "What does the error message tell you?"         |
| Team asks for solution       | "What have you tried so far?"                   |
| Team stuck on agent prompt   | "How would you prompt the agent to solve this?" |
| Team unsure about decision   | "What business requirement drives this?"        |
| Team asks "Should we use X?" | "What would you try? What are the tradeoffs?"   |

### When to Provide Direct Help

Only intervene directly when:

- **Environment issues** (authentication, tool failures)
- **Time-critical blocks** (team stalled >5 minutes on setup)
- **Factual information** ("Which region supports zone redundancy?")

**Remember**: Struggle leads to learning. Let teams work through challenges with guidance, not
solutions.

---

## Facilitator Readiness Checklist

Complete this checklist before the event, on the morning of, and at wrap-up.

### Pre-Event (1–2 Days Before)

- [ ] **Licensing confirmed**: Every participant has Copilot Pro+ or Enterprise
- [ ] **Subscriptions verified**: One dedicated Azure subscription per team, each with Owner access
- [ ] **Quotas checked**: Each subscription has sufficient quota in `swedencentral` (run `az vm list-usage -l swedencentral -o table`)
- [ ] **Policies deployed**: `Setup-GovernancePolicies.ps1` run on each subscription
- [ ] **Policy activation verified**: `Get-GovernanceStatus.ps1 -MicrohackOnly` shows Compliant/NonCompliant (not Unknown) on each subscription
- [ ] **Template repo accessible**: [azure-agentic-infraops-accelerator](https://github.com/jonathan-vella/azure-agentic-infraops-accelerator) is reachable and up to date
- [ ] **Room setup**: Projector, timer, whiteboard or shared screen for leaderboard
- [ ] **Scoring materials ready**: Scoring rubric printed or accessible, facilitator worksheet prepared
- [ ] **Network tested**: Venue Wi-Fi can reach `github.com`, `mcr.microsoft.com`, `portal.azure.com`

### Day-of Go/No-Go (09:00)

- [ ] **Docker/Codespaces working**: At least one team member per team can open the Dev Container
- [ ] **Azure CLI authenticated**: Every team can run `az account show` successfully
- [ ] **Copilot Chat operational**: Custom agents appear in the agent dropdown
- [ ] **Policies still active**: Quick spot-check with `Get-GovernanceStatus.ps1 -MicrohackOnly`
- [ ] **Timer set**: Visible timer for challenge blocks

> **Go/No-Go rule**: If any team cannot authenticate to Azure or access Copilot custom agents, resolve before starting Challenge 1. Do not proceed with a broken setup.

### Wrap-Up Checklist

- [ ] **Scores finalized**: All teams scored against rubric
- [ ] **Cleanup confirmed**: Every team's resource groups deleted (verified via `az group list`)
- [ ] **Policies removed**: `Remove-GovernancePolicies.ps1` run on every subscription
- [ ] **Feedback collected**: Participant feedback form distributed
- [ ] **Retrospective completed**: Each team shared one highlight

---

## Pre-Event Setup

### Subscription Model

> [!WARNING]
> **One Azure subscription per team is the only supported model.** Shared subscriptions are not supported. Sharing causes naming collisions, RBAC conflicts, and accidental cross-team interference. Verify that every team has a dedicated subscription before the event begins.

Each team needs **Owner** access on their subscription (required for Azure Policy deployment). If Owner is restricted, the minimum alternative is **Contributor** plus **Resource Policy Contributor**.

### Governance Policies (Optional but Recommended)

Deploy Azure Policies to create realistic governance constraints. Teams will encounter real policy errors!

```powershell
# Check current governance status
.\scripts\Get-GovernanceStatus.ps1 -SubscriptionId "<sub-id>"

# Deploy microhack policies (checks for existing before creating)
.\scripts\Setup-GovernancePolicies.ps1 -SubscriptionId "<sub-id>"

# After event: Remove policies
.\scripts\Remove-GovernancePolicies.ps1 -SubscriptionId "<sub-id>"
```

**Policies deployed:**

| Policy                  | Effect | Forces                                     |
| ----------------------- | ------ | ------------------------------------------ |
| Allowed locations       | Deny   | Only `swedencentral`, `germanywestcentral` |
| Require Environment tag | Deny   | Must tag all resources                     |
| Require Project tag     | Deny   | Must tag all resources                     |
| SQL Azure AD-only auth  | Deny   | No SQL passwords                           |
| Storage HTTPS only      | Deny   | `supportsHttpsTrafficOnly: true`           |
| Storage min TLS 1.2     | Deny   | `minimumTlsVersion: 'TLS1_2'`              |
| Storage no public blob  | Deny   | `allowBlobPublicAccess: false`             |
| App Service HTTPS       | Deny   | `httpsOnly: true`                          |

> [!WARNING]
> Policies take 5-15 minutes to become effective after deployment.
> **Deploy policies at least 30 minutes before the first team reaches Challenge 3.**
> Verify activation using the status script below before the event begins.

#### Verifying Policy Activation

After deploying policies, confirm they are active:

```powershell
# Check microhack policies are assigned and evaluating
pwsh -File scripts/Get-GovernanceStatus.ps1 -Subscription "<sub-id>" -MicrohackOnly
```

- If the `State` column shows **Compliant** or **NonCompliant**, the policy is active.
- If the `State` column shows **Unknown**, compliance data is still propagating. Wait 5–10 minutes and re-run.
- If no assignments appear, re-run `Setup-GovernancePolicies.ps1`.

> [!TIP]
> **If policies are still not active when Challenge 3 begins**: Inform teams that policy enforcement is delayed. Teams should add the required tags and security settings to their Bicep anyway — the policies will catch violations once propagation completes. Do not skip the governance requirements.

---

## Schedule

📅 **See [docs/about/agenda.md](../docs/about/agenda.md) for the full schedule overview.**

> **Event runs 09:00 - 17:00** as a 1-day hackathon with lunch from 12:00 - 12:45 and a 15-minute afternoon break at 15:00

---

## Block-by-Block Facilitator Notes

### Block 1: Intro (09:00 - 10:00)

**Facilitator Actions:**

- Welcome teams, introduce coaching approach ("We'll guide, not solve")
- Verify environment setup with each team
- Explain 8-challenge structure and showcase finale
- **Ice-Breaker (3 min)**: Each team member shares their name, role, and
  "the Azure service I'm most curious about." This builds rapport and reveals
  existing knowledge the team can leverage.

**Setup Check Script:**

```bash
az account show --query "{Subscription:name}" -o table
bicep --version
echo "✅ Ready!"
```

### Block 2: Challenge 1 - Requirements (10:00 - 11:00)

**Duration**: 60 minutes

**Coaching Tips:**

- Ask: "What questions would you ask the customer?"
- Prompt teams to quantify NFRs (SLA, RTO, RPO, peak load)
- Encourage detailed requirement capture — it drives architecture

**Common Issues:**

| Issue                | Solution                    |
| -------------------- | --------------------------- |
| Agent not responding | Reload VS Code window       |
| Vague requirements   | Ask "What SLA? What's RTO?" |

### Block 3: Challenge 2 - Architecture (11:00 - 12:00)

**Duration**: 60 minutes

**Coaching Tips:**

- Ask: "Which Well-Architected pillar does this address?"
- Encourage cost estimation using Azure Pricing MCP
- Prompt: "How would you justify this service choice to the customer?"

**Common Issues:**

No common issues — monitor Pricing MCP functionality.

### 🍽️ Lunch Break (12:00 - 12:45)

**Duration**: 45 minutes

### Block 4: Challenge 3 - Implementation & Deployment (12:45 - 13:30)

**Duration**: 45 minutes (includes Bicep plan + code + deployment + Mermaid diagram)

**Coaching Tips:**

- Ask: "What module structure would make this maintainable?"
- Prompt: "How does your naming convention ensure uniqueness?"
- Encourage Mermaid flowchart for deployment workflow visualization

**Common Issues:**

| Issue                   | Solution               |
| ----------------------- | ---------------------- |
| Key Vault name too long | ≤24 chars              |
| Storage account invalid | Lowercase+numbers only |

### Block 5: ⚡ Challenge 4 - DR Curveball & Deployment (13:30 - 14:15)

**Duration**: 45 minutes

#### Challenge 3→4 Fallback Rules

Before announcing the curveball, quickly assess each team's Challenge 3 outcome:

| Team status | Facilitator action |
|---|---|
| **Deployed successfully** | Full Challenge 4 path (design + update Bicep + deploy DR) |
| **Partial deployment** | Encourage extending what deployed; document gaps in ADR |
| **Failed deployment** | Direct to **paper exercise**: ADR + architecture diagram without deploying. No pre-built reference deployment is provided. |

> [!TIP]
> Teams on the paper-exercise path can still earn full ADR and diagram points. Adjust scoring expectations using the rubric — the paper-exercise variant is explicitly accounted for.

#### 📢 Announcement Script (13:30)

Stand up, get everyone's attention:

> _"ATTENTION ALL TEAMS! 📣_
>
> _We've just received urgent news from Nordic Fresh Foods headquarters!_
>
> _They've signed a major contract with a Danish restaurant chain — Smørrebrød Express — worth
> €500K annually. The board has mandated new business continuity requirements._
>
> _Your infrastructure must now support:_
>
> - _Multi-region disaster recovery_
> - _RTO of 1 hour or less_
> - _RPO of 15 minutes or less_
> - _Secondary region: germanywestcentral_
>
> _Budget has increased by €200/month to accommodate this._
>
> _You have 45 minutes to propose, plan, and DEPLOY the solution!_
>
> _Document your DR strategy in an ADR! GO GO GO!_ 🚀"

**Coaching Tips:**

- Ask: "What replication strategy meets your RPO?"
- Prompt: "How would you test failover?"
- Encourage ADR creation to document DR decision rationale

### Deployment Checkpoint (14:15 - 14:30)

Use this short buffer to confirm teams are ready for load testing, unblock deployment issues, and reset for the final stretch.

### Block 6: Challenge 5 - Load Testing (14:30 - 15:00)

**Duration**: 30 minutes

**Coaching Tips:**

- Ask: "What metrics validate your SLA?"
- Prompt: "How would you simulate 500 concurrent users?"
- Encourage design agent for structured report generation

### ☕ Break (15:00 - 15:15)

**Duration**: 15 minutes

### Block 7: Challenges 6-7 - Docs, Diagnose, Prep (15:15 - 15:50)

**Duration**: 35 minutes

#### Challenge 6: Documentation (15:15 - 15:30)

**Coaching Tips:**

- Ask: "What would a new team member need to know?"
- Prompt: "How does design agent ensure completeness?"
- Encourage runbook creation for operational procedures

#### Challenge 7: Diagnostics (15:30 - 15:35)

**Coaching Tips:**

- Ask: "What's your troubleshooting workflow?"
- Prompt: "How would you diagnose a performance issue?"
- Encourage diagnostic runbook with monitoring queries

**Common Issues:**

| Issue                    | Solution                         |
| ------------------------ | -------------------------------- |
| Design agent too verbose | Prompt: "Create concise runbook" |
| Missing monitoring       | Use Application Insights logs    |

---

### 🎯 Presentation Prep (15:35 - 15:50)

**Facilitator Actions:**

- Remind teams of the 4-min pitch + 2-min Q&A format
- Share the [Presentation Template](../docs/challenges/challenge-8-partner-showcase.md#what-to-present)
- Assign team pairings (see below)
- Set up presentation area (projector, timer)

### Block 8: Challenge 8 - Partner Showcase 🎤 (15:50 - 16:50)

**Duration**: 60 minutes (up to 6 teams × ~9 min + transitions)

#### Presentation Setup

Pair teams for the role-play:

| Presenting (Partner) | Challenging (Customer) |
| -------------------- | ---------------------- |
| Team 1               | Team 2                 |
| Team 2               | Team 3                 |
| Team 3               | Team 4                 |
| Team 4               | Team 5                 |
| Team 5               | Team 6                 |
| Team 6               | Team 1                 |

#### 📢 Announcement Script (15:50)

> _"Time for Challenge 8 — the Partner Showcase! 🎤_
>
> _Each team will present their FreshConnect solution. You are now the **Partner** pitching to
> Nordic Fresh Foods._
>
> _When you're not presenting, you'll play the **Customer** — asking tough but fair questions!_
>
> _Format: 4 min pitch + 2 min Q&A + 30 sec transition._
>
> _Team 1, you're up first!"_

> **Tip**: Keep presentations moving! Use a visible timer.

#### Facilitator Feedback Focus

After each presentation, briefly comment on:

| Area                | Look For                                         |
| ------------------- | ------------------------------------------------ |
| **Clarity**         | Was the solution easy to understand?             |
| **Justification**   | Were decisions well-reasoned?                    |
| **WAF Alignment**   | Reliability, security, cost, operations covered? |
| **Professionalism** | How would this land with a real customer?        |

### Wrap-up (16:50 - 17:00)

Finalize scores using [scoring-rubric.md](scoring-rubric.md), then announce the leaderboard from your facilitator worksheet or HackerBoard instance if your event package includes it.

- Share key learnings from presentations
- Announce final leaderboard
- **Run 5-minute team retrospective** (see template below)
- **Enforce cleanup**: The **team lead** is the cleanup owner. Each team lead must delete their team's resource groups and confirm deletion before leaving. Facilitators must remove governance policies from every subscription used:

  ```powershell
  pwsh -File scripts/Remove-GovernancePolicies.ps1 -Subscription "<sub-id>"
  ```

- **Verify cleanup** before closing the event:

  ```bash
  az group list --query "[?starts_with(name, 'rg-freshconnect')]" -o table
  # Expected: empty result for each subscription
  ```

- If any team has already left, the facilitator assumes cleanup responsibility for that team's subscription.

#### Team Retrospective (5 min)

Ask each team to spend 3 minutes discussing, then share one highlight with the room:

| Prompt                                 | Notes |
| -------------------------------------- | ----- |
| **What went well?**                    |       |
| **What was hardest?**                  |       |
| **One thing I'd do differently**       |       |
| **One thing I'll use in my real work** |       |

---

## If Teams Finish Early

Fast teams disengage if idle. Offer these stretch activities:

| Activity                                                            | When        |
| ------------------------------------------------------------------- | ----------- |
| Add **Private Endpoints** to SQL/Storage (bonus +5)                 | After C3/C4 |
| Enable **Zone Redundancy** on App Service (bonus +5)                | After C3/C4 |
| Add **Managed Identities** and remove connection strings (bonus +5) | After C3/C4 |
| Write a second documentation artifact (e.g., DR runbook)            | After C6    |
| Explore the `challenger` agent on their own artifacts               | Anytime     |
| Prepare extra slides for the Partner Showcase                       | After C7    |
| Help a struggling neighboring team (peer coaching)                  | Anytime     |

---

## Scoring

### Recommended Workflow

1. Review each team's artifacts and deployment evidence against [scoring-rubric.md](scoring-rubric.md).
2. Verify bonus claims in Azure where needed.
3. Add the Partner Showcase score using the rubric after each presentation.
4. Publish totals from your facilitator worksheet or HackerBoard instance if your event package includes one.

> [!TIP]
> Keep scoring rubric-first. Any optional leaderboard tooling should reflect the totals you calculate from this guide and the rubric.

### Manual Verification (Bonus Points)

| Bonus              | How to Verify                              |
| ------------------ | ------------------------------------------ |
| Zone Redundancy    | Portal → App Service Plan → Zone redundant |
| Private Endpoints  | Portal → SQL/Storage → Networking          |
| Multi-Region       | Resources in `germanywestcentral`          |
| Managed Identities | Portal → App Service → Identity            |

---

## Incident Response Runbook

Use this table when a team hits a blocking issue. Identify the failure class, take the next action, and decide whether to unblock, compress time, skip, or fall back.

### Failure Class Reference

| Failure Class | Symptoms | Immediate Action | Escalation |
|---|---|---|---|
| **Policy not active** | Deployment succeeds but should have been denied; `Get-GovernanceStatus` shows `Unknown` | Wait 10 min, re-run status script. Tell team to add tags/security settings anyway. | If still inactive after 30 min, re-run `Setup-GovernancePolicies.ps1`. |
| **Copilot access issue** | Agent picker is empty; "Copilot is not available"; custom agents missing | Verify Copilot Pro+ or Enterprise license. Check `customAgentInSubagent.enabled` setting. Reload VS Code window. | If license is wrong tier, participant cannot use custom agents. Pair with another team member who has access. |
| **Azure quota exceeded** | `QuotaExceeded` error on deployment | Check quota: `az vm list-usage -l swedencentral -o table`. Try a different SKU or region. | If no quota available, reduce scope (fewer resources) or share deployment output with team for learning. |
| **Deployment failure (naming)** | `NameNotAvailable`, `StorageAccountAlreadyTaken` | Use `uniqueString(resourceGroup().id)` suffix pattern. Check resource name constraints. | If persistent, create a fresh resource group with a different name. |
| **Deployment failure (auth)** | `AuthorizationFailed`, `AADSTS50076` | Re-run `az login --use-device-code`. Verify subscription access: `az account show`. | If subscription lacks Owner role, check if Contributor + Resource Policy Contributor suffices. |
| **Deployment failure (Bicep)** | `BCP035`, `BCP037`, template validation errors | Read the error message — it usually names the exact property. Use `bicep build` to validate before deploying. | If team is stuck >5 min, intervene directly with the specific Bicep fix. |
| **MCP tools not responding** | Azure MCP or Pricing MCP errors, tools unavailable | Check `.vscode/mcp.json`. Verify `az login` is active. Reload VS Code window. | If MCP remains broken, teams can use Azure Portal or CLI for pricing info manually. |
| **Timing compression** | Team is behind schedule by >15 min | Compress: combine remaining work, reduce scope. At >30 min behind, skip non-essential challenges (C5, C6, C7 can be abbreviated). | Ensure C1–C4 and C8 are completed — these carry the most learning value and points. |
| **Dev Container failure** | Container fails to build, image pull timeout | Check Docker Desktop is running (4 GB RAM). Run `Dev Containers: Rebuild Without Cache`. Check network. | If container cannot build, fall back to GitHub Codespaces. |

### Decision Framework

When a team is blocked, follow this order:

1. **Can you unblock in <2 minutes?** → Fix it directly (auth, reload, typo fix)
2. **Is it a learning moment?** → Guide the team to the fix (Bicep errors, naming)
3. **Is it infrastructure/tooling?** → Fix it directly, don't let teams waste time
4. **Is it >5 minutes with no progress?** → Compress scope or activate fallback path
5. **Is the team >30 minutes behind?** → Skip to the next critical challenge

---

## Common Errors

### Authentication

| Error                 | Solution                         |
| --------------------- | -------------------------------- |
| `AADSTS50076`         | Use `az login --use-device-code` |
| `AuthorizationFailed` | Check subscription access        |

### Bicep

| Error    | Solution                      |
| -------- | ----------------------------- |
| `BCP035` | Missing required parameter    |
| `BCP037` | Wrong property or API version |

### Deployment

| Error              | Solution                 |
| ------------------ | ------------------------ |
| `QuotaExceeded`    | Try different region/SKU |
| `NameNotAvailable` | Use uniqueSuffix pattern |
| Zone redundancy    | Use P1v3+ SKU            |

---

## Team Progress Tracker

| Team | C1  | C2  | C3  | C4  | C5  | C6  | C7  | C8  | Deploy | Bonus |
| ---- | --- | --- | --- | --- | --- | --- | --- | --- | ------ | ----- |
| 1    | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜     |       |
| 2    | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜     |       |
| 3    | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜     |       |
| 4    | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜     |       |
| 5    | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜     |       |
| 6    | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜  | ⬜     |       |

Legend: ⬜ Not started | 🔄 In progress | ✅ Complete

> **Note**: C8 (Partner Showcase) is facilitator-scored (0-10) via `-ShowcaseScore`.

---

## Accessibility & Inclusivity

- Ensure projectors/screens are visible from all seating positions
- Provide printed quick-reference cards for participants who prefer paper
- Offer breaks on request (beyond the scheduled ones) for accessibility needs
- When reading announcement scripts, speak slowly and clearly for non-native speakers
- Use high-contrast slides and large fonts for any projected content

---

## Contingency Planning

If challenges run long, use this priority guide for what to compress or skip:

| Priority     | Challenge | Can Compress?    | Notes                                |
| ------------ | --------- | ---------------- | ------------------------------------ |
| Must-do      | C1-C3     | No               | Core learning arc                    |
| Must-do      | C4        | Reduce to 30 min | Skip deployment if needed; keep ADR  |
| Must-do      | C8        | Reduce to 45 min | Fewer teams present, or shorten Q&A  |
| Nice-to-have | C5        | Drop to 15 min   | Run test only, skip report           |
| Nice-to-have | C6        | Drop to 10 min   | Generate one artifact instead of two |
| Skippable    | C7        | Yes              | 5 points; teams can do post-event    |

> [!TIP]
> Build a 10-minute buffer into your mental model. If C1-C3 finish on time,
> you're in good shape. If they run 15+ minutes over, compress C5-C7.

---

## Emergency Procedures

### Copilot Down

1. Announce to all teams
2. Use template files in `.github/skills/azure-artifacts/templates/`
3. Extend time if needed

### Azure Issues

1. Check [status.azure.com](https://status.azure.com)
2. Try `germanywestcentral` region
3. Focus on Bicep generation if widespread

### Team Falls Behind

1. Offer direct help
2. Let them skip Challenge 3 design artifacts
3. Remind: learning > completion

---

## Post-Event

Remind teams:

```bash
az group delete --name rg-freshconnect-dev-swc --yes --no-wait
```

Collect feedback on what worked and what didn't.
