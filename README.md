# Agentic InfraOps MicroHack

> **1-Day Hackathon**: Transform business requirements into deployed Azure infrastructure using AI agents and GitHub Copilot.

## Overview

Teams use GitHub Copilot custom agents to design, plan, implement, and deploy Azure infrastructure — all guided by AI and aligned with the [Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/).

Participants should create their own repository from the [azure-agentic-infraops-accelerator template](https://github.com/jonathan-vella/azure-agentic-infraops-accelerator) rather than cloning this repository directly. End-user guidance is published at [jonathan-vella.github.io/azure-agentic-infraops](https://jonathan-vella.github.io/azure-agentic-infraops/).

**What you'll experience:**

- AI-assisted requirements gathering and architecture design
- Automated Bicep code generation from natural language
- Cost estimation using Azure Pricing MCP
- Real deployment to your Azure subscription
- A mid-event "curveball" that tests your adaptability

## Learning Objectives

1. **Understand agentic workflows** for Infrastructure as Code
2. **Generate production-ready Bicep** using AI agents
3. **Apply WAF principles** (Reliability, Security, Cost, Operations, Performance)

## The Scenario: Nordic Fresh Foods

A Stockholm-based farm-to-table delivery company needs cloud infrastructure. Your team will capture requirements, design a WAF-aligned architecture, generate and deploy Bicep templates, and adapt to a surprise multi-region DR requirement mid-event.

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
docs/                   # GitHub Pages site (just-the-docs theme)
facilitator/            # Facilitator guide, scoring rubric, solution reference
scripts/                # Governance PowerShell scripts
```

## Getting Started

1. **Create your repo from the template** — Start from [azure-agentic-infraops-accelerator](https://github.com/jonathan-vella/azure-agentic-infraops-accelerator) and create your own repository.
2. **Read** [Getting Started](docs/getting-started/setup.md) for the template-based setup flow, dev container steps, and Azure quota requirements.
3. **Review** [Workshop Prep](docs/getting-started/workshop-prep.md) for the scenario brief and team roles.
4. **Follow** the challenges in order starting from [Challenge 1](docs/challenges/challenge-1-requirements.md).

## Quick Links

| Resource | Description |
| --- | --- |
| [Template Repo](https://github.com/jonathan-vella/azure-agentic-infraops-accelerator) | Create your own working repository from the template |
| [Workshop Docs](https://jonathan-vella.github.io/azure-agentic-infraops/) | Published setup and guidance for participants |
| [Agenda](docs/about/agenda.md) | Full schedule with timing |
| [Copilot Guide](docs/guides/copilot-guide.md) | Agents, skills, and prompting tips |
| [Quick Reference Card](docs/guides/quick-reference-card.md) | Printable one-page cheat sheet |
| [Scoring Rubric](facilitator/scoring-rubric.md) | WAF-aligned evaluation criteria |
| [Troubleshooting](docs/reference/troubleshooting.md) | Common issues and fixes |

## License

This project is provided for educational and workshop use. See the repository for license details.
