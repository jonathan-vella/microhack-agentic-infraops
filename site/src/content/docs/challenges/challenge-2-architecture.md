---
title: 'C2: Architecture Assessment'
description: Use the architect agent to create a Well-Architected Framework assessment
  with service selection and cost estimates.
sidebar:
  order: 2
  badge:
    text: 30 min
    variant: note
prev:
  link: ../challenge-1-requirements/
  label: 'C1: Requirements'
next:
  link: ../challenge-3-implementation/
  label: 'C3: Implementation'
---

:::note[Challenge Info]
⏱️ **30 min** · 🏆 **25 pts** · 🤖 `03-Architect`, `04-Design` · 📄 `02-architecture-assessment.md`, `03-des-architecture-diagram.md`

:::

## Objective

- **Do now:** Turn the requirements into an Azure architecture you can justify.
- **Input:** `agent-output/freshconnect/01-requirements.md`.
- **Output:** `agent-output/freshconnect/02-architecture-assessment.md` and `agent-output/freshconnect/03-des-architecture-diagram.md`.
- **Required to move on:** Service choices, WAF trade-offs, cost view, and a diagram.
- **Decisions now:** Compute platform, data platform, network/security boundary, cost vs reliability trade-offs.
- **Next:** C3 turns this assessment and diagram into IaC and deployment work.

Your goal is not to collect every possible Azure option. Your goal is to choose a
workable MVP architecture that fits the FreshConnect constraints and can survive later
implementation and stakeholder scrutiny.

## The Business Challenge

FreshConnect now has clear requirements, but Nordic Fresh Foods still needs a design
that fits a small ops team, stays in EU regions, targets roughly 99.9% availability,
and remains defensible inside a budget of about €500 per month. Every service choice
must balance capability, cost, and operational complexity.

## Your Tasks

1. Read the C1 requirements and list the decisions that still need architecture-level
   judgment instead of more discovery.
2. Use the `03-Architect` agent to assess the workload against the Azure
   Well-Architected Framework and recommend Azure services, SKUs, and risks.
3. Choose the service set and cost posture you are prepared to defend to both a small
   engineering team and a budget-conscious stakeholder.
4. Use the `04-Design` agent to create an architecture diagram that matches the written
   assessment.
5. Save both artifacts at the required paths.

## Key Decisions

- Which hosting model gives enough reliability and scale without creating an
  operations burden the team cannot sustain?
- Which data service best matches FreshConnect's order and partner data while staying
  within budget and compliance boundaries?
- Which security controls must be first-class from day one, and which can be deferred
  without creating unacceptable risk?
- Where should you spend money for real business value, and where is the architecture
  starting to drift into over-engineering?

## Deliverables

- `agent-output/freshconnect/02-architecture-assessment.md`
- `agent-output/freshconnect/03-des-architecture-diagram.md`
- Assessment includes recommended Azure services, key SKUs, WAF reasoning, risks, and
  cost assumptions.
- Diagram shows services, relationships, data flows, security boundaries, and region
  placement.

## Success Criteria

| Focus | What good looks like | Evidence |
| --- | --- | --- |
| Service selection | The chosen Azure services fit the requirements and team capability | Each major service has a short justification tied to a requirement or trade-off |
| WAF thinking | Reliability, security, cost, performance, and operations are visible in the reasoning | The assessment explains the main trade-offs instead of listing features |
| Cost fit | The architecture is realistic for the MVP budget | Cost drivers, assumptions, or guardrails are called out explicitly |
| Architecture communication | Someone else can understand the design quickly | Diagram and written assessment tell the same story |

## Tips / Hints

<details>
<summary>Compact prompt pattern and shared references</summary>

Use a prompt structure like this:

```text
Review agent-output/freshconnect/01-requirements.md and recommend an Azure MVP
architecture for FreshConnect.

Decisions I need to make now:
- compute platform
- database choice
- security and network baseline
- cost trade-offs within ~€500/month

Return: WAF-aligned recommendations, key risks, and a diagram-ready summary.
```

Use [Hints & Tips](../../guides/hints-and-tips/#architecture-hints) for deeper service
selection prompts, [Hints & Tips](../../guides/hints-and-tips/#cost-optimization)
for cost thinking, and [Quick Reference Card](../../guides/quick-reference-card/#security-checklist)
for the shared security baseline.

</details>

## Watch Out

- Do not accept an architecture you cannot explain in business terms.
- Do not let the diagram drift away from the written assessment.
- Do not ignore cost assumptions until the end; they shape the service choices.
- Do not forget EU residency or governance requirements when comparing services.

## Artifact Handoff

| Item | Value |
| --- | --- |
| **Input from** | `agent-output/freshconnect/01-requirements.md` (Challenge 1) |
| **Your output** | `agent-output/freshconnect/02-architecture-assessment.md`, `agent-output/freshconnect/03-des-architecture-diagram.md` |
| **Next challenge uses** | C3 uses the assessment and diagram to choose IaC structure, validation steps, and deployment targets |

## Next Step

Challenge 3 turns this design into code. If your assessment is missing a service
boundary, security control, or cost assumption now, implementation will either stall or
invent its own answer later.
