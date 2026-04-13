---
title: 'C4: DR Curveball'
description: Respond to a surprise business requirement change — add high availability
  and disaster recovery to your FreshConnect infrastructure.
sidebar:
  order: 4
  badge:
    text: 45 min
    variant: caution
prev:
  link: ../challenge-3-implementation/
  label: 'C3: Implementation'
next:
  link: ../challenge-5-load-testing/
  label: 'C5: Load Testing'
---

:::note[Challenge Info]
⏱️ **45 min** · 🏆 **10 pts** · 🤖 `03-Architect`, `04-Design`, `06b-Bicep CodeGen`/`06t-Terraform CodeGen`, `07b-Bicep Deploy`/`07t-Terraform Deploy` · 📄 `agent-output/freshconnect/04-adr-ha-dr-strategy.md`, updated IaC or paper design, updated diagram

:::

## Objective

- **Do now:** Respond to the DR curveball with an ADR, updated design, and revised delivery path.
- **Input:** C3 templates, deployment outcome, implementation plan, and architecture diagram.
- **Output:** `agent-output/freshconnect/04-adr-ha-dr-strategy.md`, updated IaC or paper design, updated architecture diagram, and revised cost view.
- **Required to move on:** Choose an HA/DR approach, parameterize the design, and document whether you deployed it or designed it on paper.
- **Decisions now:** Single-region HA vs multi-region DR vs active-active, what must replicate, how failover works, and what fits inside the extra budget.
- **Next:** C5 validates the revised platform or documents the intended test target if you stayed on paper.

This challenge tests whether your team can adapt without losing the architectural
thread. The right answer is the option you can justify and deliver credibly under time
pressure.

## The Business Challenge

Midway through the workshop, Nordic Fresh Foods signs a major Danish contract and the
board raises the budget ceiling to about €700 per month. The platform now needs a
secondary region in `germanywestcentral`, an RTO of 1 hour, and an RPO of 15 minutes.
You must recommend a resilient path fast, then show how it changes the design.

## Your Tasks

1. Decide which path you are on based on your Challenge 3 outcome, then state that path
   clearly in your ADR.
2. Write `agent-output/freshconnect/04-adr-ha-dr-strategy.md` with context, decision,
   consequences, and rejected alternatives.
3. Update your Bicep or Terraform IaC, or your written design on the paper path,
  so the HA/DR choice is parameterized and the required regional changes are explicit.
4. Update the architecture diagram and revise the cost view to show the new design.
5. Deploy the DR change if your C3 path supports it; otherwise document the paper
   exercise path cleanly.

| Challenge 3 outcome | What you do now |
| --- | --- |
| Deployment succeeded | Extend the deployed platform with the chosen HA/DR strategy and capture deployment evidence |
| Partial deployment | Extend what works, document the gaps in the ADR, and show the intended end state |
| Deployment failed | Complete a paper exercise: ADR + updated diagram + parameterized written design, without claiming deployment evidence |

## Key Decisions

- Which services truly need redundancy to meet the new RTO and RPO, and which can be
  recovered more simply?
- Is active-passive good enough for the business, or are you paying for active-active
  complexity you cannot defend?
- Which failover steps are automatic, which are manual, and how will the team know the
  difference during an incident?
- What proof will convince a stakeholder that this DR plan is credible within the new
  budget?

## Deliverables

- `agent-output/freshconnect/04-adr-ha-dr-strategy.md`
- Updated IaC with HA/DR parameters, or a written parameterized design if you are on
  the paper path.
- Updated architecture diagram showing regions, replication paths, and failover flow.
- Revised cost estimate or cost assumptions for the chosen approach.
- Deployment evidence if you actually applied the DR change.

## Success Criteria

| Focus | What good looks like | Evidence |
| --- | --- | --- |
| Decision quality | The team chooses an HA/DR path with clear business reasoning | ADR states the trigger, chosen option, trade-offs, and rejected alternatives |
| DR design clarity | The resilience design is concrete instead of hand-wavy | Parameters, regional changes, and failover behavior are explicit |
| Delivery path | The team is honest about what was deployed versus designed | Deployment evidence exists, or the paper path is documented cleanly |
| Architecture communication | Others can understand the updated design fast | Updated diagram and ADR tell the same before/after story |

## Tips / Hints

<details>
<summary>Useful reference points for the curveball</summary>

Use [Hints & Tips](../../guides/hints-and-tips/#multi-region-dr)
for DR design prompts, [Quick Reference Card](../../guides/quick-reference-card/#budget-guide)
for the post-curveball budget guardrail, and
[Quick Reference Card](../../guides/quick-reference-card/#paper-exercise-rules)
if your team is documenting the fallback path.

ADR skeleton:

```text
Context -> what changed and why it matters
Decision -> which HA/DR option you chose
Consequences -> cost, complexity, risks, operational impact
Alternatives -> what you rejected and why
```

</details>

## Watch Out

- A paper exercise can still score well, but only if you clearly separate design
  intent from actual deployment evidence.
- The paper path can still prove your C4 design thinking, but it does not replace
  missing C3 deployment evidence. Be explicit about what you designed versus what
  actually ran.
- Do not pick active-active unless you can explain consistency, failover, and cost.
- Do not update the diagram without updating the ADR, or vice versa.
- Keep the €700 ceiling visible; the extra budget is not a license to duplicate
  everything blindly.

## Artifact Handoff

| Item | Value |
| --- | --- |
| **Input from** | C3 templates, deployment outcome, implementation plan, architecture diagram |
| **Your output** | `agent-output/freshconnect/04-adr-ha-dr-strategy.md`, updated IaC or paper design, updated diagram |
| **Next challenge uses** | C5 validates the revised platform if you have an endpoint, or uses your documented target state to define the intended test plan |

## Next Step

Challenge 5 treats this DR-aware platform as the system under test. If you deployed the
change, you will validate it under load; if you stayed on paper, you will document the
test plan and expected thresholds against the design you just proposed.
