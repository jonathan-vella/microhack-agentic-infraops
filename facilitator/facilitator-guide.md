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

## Pre-Event Setup

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
- Remind teams to clean up resources

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
