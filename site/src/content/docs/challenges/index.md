---
title: Challenges
description: Orientation page for the full challenge sequence, artifact chain, and
  optional deep-dive references.
sidebar:
  order: 0
---

Eight challenges take you from problem framing to stakeholder defense. Treat this
page as the map for the whole workshop: skim the chain here, then open only the
challenge you are working on.

:::tip

The workshop is now reference-driven by design. Each challenge page tells you what
to do now, what artifact to produce, what decisions matter, and what the next
challenge needs. Use the shared guides only for optional depth or when you hit a
decision you cannot resolve quickly.

:::

## Fast Orientation

1. Start by finding your current challenge in the pipeline below.
2. Check the input artifact and required output before you open the page.
3. Use [Quick Reference Card](../guides/quick-reference-card/) for commands,
   naming, security baselines, Mermaid conventions, and handoff rules.
4. Use [Hints & Tips](../guides/hints-and-tips/) only when you need deeper prompt
   patterns, WAF prompts, governance help, DR guidance, or load-test ideas.

## Challenge Pipeline

```mermaid
%%{init: {'theme':'neutral'}}%%
graph LR
    C1[C1 Requirements] --> C2[C2 Architecture]
    C2 --> C3[C3 Implementation]
    C3 --> CB[Curveball]
    CB --> C4[C4 DR]
    C4 --> C5[C5 Load Test]
    C5 --> C6[C6 Docs]
    C6 --> C7[C7 Diagnostics]
    C7 --> C8[C8 Showcase]

    style CB fill:#d83b01,color:#fff
    style C8 fill:#0078d4,color:#fff
```

<details>
<summary>Text alternative: challenge pipeline</summary>

C1 Requirements -> C2 Architecture -> C3 Implementation -> Curveball -> C4 DR ->
C5 Load Test -> C6 Documentation -> C7 Diagnostics -> C8 Showcase

</details>

:::note

Challenge 4 is announced as a surprise midway through the event. If your Challenge 3
deployment did not complete, you still continue by documenting the DR design as a
paper exercise and carrying that design evidence into later challenges.

:::

## Challenge Chain

| Challenge | Duration | Points | Input | Output | What the next step consumes |
| --- | --- | --- | --- | --- | --- |
| [C1 Requirements](challenge-1-requirements/) | 30 min | 20 | Scenario brief | `agent-output/freshconnect/01-requirements.md` | C2 uses the agreed business, operational, and compliance requirements |
| [C2 Architecture](challenge-2-architecture/) | 30 min | 25 | `01-requirements.md` | `02-architecture-assessment.md`, `03-des-architecture-diagram.md` | C3 uses the chosen services, constraints, and architecture diagram |
| [C3 Implementation](challenge-3-implementation/) | 45 min | 25 | Architecture assessment and diagram | IaC folder, `04-implementation-plan.md`, `03-des-deployment-workflow.md`, `06-deployment-summary.md` | C4 uses your templates, deployment outcome, and explanation of how the platform is delivered |
| [C4 DR Curveball](challenge-4-dr-curveball/) | 45 min | 10 | C3 templates and deployment outcome | `04-adr-ha-dr-strategy.md`, updated diagram, updated IaC or paper design | C5 uses the revised platform or, if blocked, your documented intended target |
| [C5 Load Testing](challenge-5-load-testing/) | 30 min | 5 | Deployed endpoint or documented fallback plan | `05-load-test-results.md` | C6 uses the measured results and recommendations |
| [C6 Documentation](challenge-6-documentation/) | 15 min | 5 | All prior artifacts | `07-ab-operations-guide.md` plus at least one additional doc | C7 distills the broader docs into a one-page triage aid |
| [C7 Diagnostics](challenge-7-diagnostics/) | 5 min | 5 | Platform knowledge, docs, and architecture | `07-diagnostics-quick-card.md` | C8 uses the diagnostics card as evidence of operational maturity |
| [C8 Team Showcase](challenge-8-partner-showcase/) | 60 min | 10 | All artifacts from C1-C7 | Live presentation and Q&A | Workshop wrap-up |

**Total:** 105 base points + up to 25 bonus points

**Bonus targets:** Zone Redundancy (+5), Private Endpoints (+5), Multi-Region DR (+10), Managed Identities (+5)

## Optional Deep Guidance

| Need | Go here |
| --- | --- |
| Commands, naming rules, security baseline, budget guardrails, artifact handoff rules, Mermaid and ADR conventions | [Quick Reference Card](../guides/quick-reference-card/) |
| Prompt patterns, WAF decision prompts, security/compliance questions, governance policy pitfalls, DR thinking, load-test guidance, documentation prompts | [Hints & Tips](../guides/hints-and-tips/) |
| Broken deployment, policy denial, agent issues, or environment problems | [Troubleshooting](../reference/troubleshooting/) |

## Read This Way

Keep the challenge page as your execution surface.

- Read the fast block at the top of the challenge page first.
- Do the required tasks before opening any collapsed hint section.
- Open the shared guides only when you need extra depth, not as required reading.
- Preserve your output artifact names and paths exactly so later challenges can find them.
