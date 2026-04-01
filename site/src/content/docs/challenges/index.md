---
title: Challenges
description: 8 challenges taking you from requirements to partner showcase
sidebar:
  order: 0
---

Eight challenges guide you through the full Infrastructure-as-Code lifecycle — from gathering requirements to presenting your solution in a partner showcase. Each challenge applies platform engineering practices, accelerated by GitHub Copilot.

:::tip

Each challenge names its **input artifact** (what you need from the previous step), **output artifact** (what you produce), and **next step**. Check the Artifact Handoff table at the bottom of each challenge page.

:::

## Challenge Overview

| # | Challenge | Duration | Points |
|---|---|---|---|
| 1 | [Requirements Capture](challenge-1-requirements/) | 30 min | 20 |
| 2 | [Architecture Design](challenge-2-architecture/) | 30 min | 25 |
| 3 | [IaC Implementation & Deploy](challenge-3-implementation/) | 45 min | 25 |
| 4 | [DR Curveball & Deploy](challenge-4-dr-curveball/) | 45 min | 10 |
| 5 | [Load Testing](challenge-5-load-testing/) | 30 min | 5 |
| 6 | [Workload Documentation](challenge-6-documentation/) | 15 min | 5 |
| 7 | [Troubleshooting & Diagnostics](challenge-7-diagnostics/) | 5 min | 5 |
| 8 | [Partner Showcase](challenge-8-partner-showcase/) | 60 min | 10 |

**Total:** 105 base points + up to 25 bonus points

## Challenge Flow

```mermaid
%%{init: {'theme':'neutral'}}%%
graph LR
    C1[C1: Requirements] --> C2[C2: Architecture]
    C2 --> C3[C3: IaC]
    C3 --> CB[⚡ CURVEBALL ⚡]
    CB --> C4[C4: DR]
    C4 --> C5[C5: Load Test]
    C5 --> C6[C6: Docs]
    C6 --> C7[C7: Diagnose]
    C7 --> C8[C8: Showcase]

    style CB fill:#ff6b6b,color:#fff
    style C8 fill:#0078d4,color:#fff
```

<details>
<summary>Text alternative: Challenge flow</summary>


C1 Requirements → C2 Architecture → C3 IaC Implementation → ⚡ CURVEBALL ⚡ → C4 DR → C5 Load Test → C6 Docs → C7 Diagnose → C8 Showcase

Challenge 4 is announced as a surprise midway through the event.


</details>

:::note

Challenge 4 is announced as a surprise midway through the event — simulating real-world requirement changes.

:::
