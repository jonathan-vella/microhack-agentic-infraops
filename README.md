# Agentic InfraOps MicroHack

> **1-Day Hackathon**: Master IaC-driven Azure infrastructure delivery using platform engineering practices — accelerated by GitHub Copilot.

## Overview

> **This repository contains workshop documentation, facilitator guides, and governance scripts.** It is NOT the repository participants work in during the event. Participants must create their own repository from the [azure-agentic-infraops-accelerator template](https://github.com/jonathan-vella/azure-agentic-infraops-accelerator).

| Repository | Purpose | Who uses it |
|---|---|---|
| **This repo** (`microhack-agentic-infraops`) | Workshop docs, facilitator guides, scoring rubric, governance scripts | Facilitators, content maintainers |
| **[Template repo](https://github.com/jonathan-vella/azure-agentic-infraops-accelerator)** (`azure-agentic-infraops-accelerator`) | Starting point for participant work — contains agents, skills, dev container, and Bicep scaffold | Participants ("Use this template" → create your own) |

Teams apply platform engineering practices using GitHub Copilot to design, plan, implement, and deploy Azure infrastructure — aligned with the [Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/).

Participants should create their own repository from the [azure-agentic-infraops-accelerator template](https://github.com/jonathan-vella/azure-agentic-infraops-accelerator) rather than cloning this repository directly. End-user guidance is published at [jonathan-vella.github.io/azure-agentic-infraops](https://jonathan-vella.github.io/azure-agentic-infraops/).

**What you'll experience:**

- Platform engineering-driven requirements gathering and architecture design
- IaC code generation (Bicep or Terraform) accelerated by GitHub Copilot
- Cost estimation using Azure Pricing MCP
- Real deployment to your Azure subscription
- A mid-event "curveball" that tests your adaptability

## Learning Objectives

1. **Apply platform engineering practices** to Infrastructure as Code
2. **Generate production-ready IaC** (Bicep or Terraform) accelerated by GitHub Copilot
3. **Apply WAF principles** (Reliability, Security, Cost, Operations, Performance)

## The Scenario: Nordic Fresh Foods

A Stockholm-based farm-to-table delivery company needs a standardised, governance-compliant Azure platform. Your team will capture requirements, design a WAF-aligned architecture, generate and deploy IaC templates, and adapt to a surprise multi-region DR requirement mid-event.

## Hackathon Day Schedule

| Time        | Block           | Duration | Activity                          |
| ----------- | --------------- | -------- | --------------------------------- |
| 09:00–10:00 | Intro           | 60 min   | Welcome, setup, workflow demo     |
| 10:00–11:00 | Challenge 1     | 60 min   | Requirements Capture              |
| 11:00–12:00 | Challenge 2     | 60 min   | Architecture Design               |
| 12:00–12:45 | Lunch           | 45 min   | Break                             |
| 12:45–13:30 | Challenge 3     | 45 min   | Bicep Implementation & Deployment |
| 13:30–14:15 | Challenge 4     | 45 min   | DR Curveball & Deployment         |
| 14:15–14:30 | Checkpoint      | 15 min   | Facilitator check-in and reset    |
| 14:30–15:00 | Challenge 5     | 30 min   | Load Testing                      |
| 15:00–15:15 | Break           | 15 min   | Rest & recharge                   |
| 15:15–15:30 | Challenge 6     | 15 min   | Documentation                     |
| 15:30–15:35 | Challenge 7     | 5 min    | Diagnostics                       |
| 15:35–15:50 | Prep            | 15 min   | Presentation Preparation          |
| 15:50–16:50 | Challenge 8     | 60 min   | Partner Showcase                  |
| 16:50–17:00 | Wrap-up         | 10 min   | Leaderboard, cleanup, close       |

## Repository Structure

```text
site/                   # Astro Starlight documentation site
facilitator/            # Facilitator guide, scoring rubric, solution reference
scripts/                # Governance PowerShell scripts
```

## Markdown Checks

This repository uses `markdownlint-cli2` for Markdown linting and `lefthook` for Git hooks.

- Run `npm install` once after cloning to install dependencies and register the `pre-commit` hook.
- Run `npm run lint:md` to lint all Markdown files in the repository.
- Run `cd site && npm install && npm run build` to build the documentation site.

## Sensitive-Content Review Checklist

Before merging changes that involve permissions, policies, costs, cleanup, or real Azure actions, apply this checklist:

- [ ] **Azure roles and permissions**: Are stated role requirements accurate? Do we still recommend the minimum viable role?
- [ ] **Subscription model**: Does the change maintain one-subscription-per-team as the only supported model?
- [ ] **Azure Policy guidance**: Are policy names, effects, and propagation timing still correct?
- [ ] **Cost and quota**: Are budget figures, SKU recommendations, and quota guidance still accurate?
- [ ] **Cleanup and post-event**: Does the change preserve the team-lead-owns-cleanup model? Are verification steps included?
- [ ] **Secret handling**: Does the change avoid embedding real secrets? Does it reinforce placeholder usage?
- [ ] **Script safety**: Do script changes preserve `-WhatIf` support and idempotent behavior?
- [ ] **Scoring accuracy**: Does the change keep scoring language consistent with the rubric (single source of truth)?
- [ ] **Terminology**: Does the change follow the [canonical vocabulary](site/src/content/docs/reference/glossary.md#naming-conventions)?

## Getting Started

1. **Create your repo from the template** — Start from [azure-agentic-infraops-accelerator](https://github.com/jonathan-vella/azure-agentic-infraops-accelerator) and create your own repository.
2. **Run the readiness gate** — Open [Getting Started](https://jonathan-vella.github.io/microhack-agentic-infraops/getting-started/setup/) and verify every blocking item passes before the event.
3. **Read** [Getting Started](https://jonathan-vella.github.io/microhack-agentic-infraops/getting-started/) for the template-based setup flow, dev container steps, and Azure quota requirements.
4. **Review** [Workshop Prep](https://jonathan-vella.github.io/microhack-agentic-infraops/getting-started/workshop-prep/) for the scenario brief and team roles.
5. **Follow** the challenges in order starting from [Challenge 1](https://jonathan-vella.github.io/microhack-agentic-infraops/challenges/challenge-1-requirements/).

## Quick Links

| Resource | Description |
| --- | --- |
| [Template Repo](https://github.com/jonathan-vella/azure-agentic-infraops-accelerator) | Create your own working repository from the template |
| [Workshop Docs](https://jonathan-vella.github.io/microhack-agentic-infraops/) | Published setup and guidance for participants |
| [Agenda](https://jonathan-vella.github.io/microhack-agentic-infraops/about/agenda/) | Full schedule with timing |
| [Copilot Guide](https://jonathan-vella.github.io/microhack-agentic-infraops/guides/copilot-guide/) | Agents, skills, and prompting tips |
| [Quick Reference Card](https://jonathan-vella.github.io/microhack-agentic-infraops/guides/quick-reference-card/) | Printable one-page cheat sheet |
| [Scoring Rubric](facilitator/scoring-rubric.md) | WAF-aligned evaluation criteria |
| [Troubleshooting](https://jonathan-vella.github.io/microhack-agentic-infraops/reference/troubleshooting/) | Common issues and fixes |

## License

This project is provided for educational and workshop use. See the repository for license details.
