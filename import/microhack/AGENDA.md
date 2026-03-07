# Microhack Agenda

> **Agentic InfraOps Microhack** — 6 hours (10:00 - 16:00)

---

## Team Structure

| Aspect          | Details                  |
| --------------- | ------------------------ |
| Team Size       | 3-6 members per team     |
| Number of Teams | Flexible based on cohort |

---

## Schedule Overview

| Time        | Block           | Duration | Activity                          |
| ----------- | --------------- | -------- | --------------------------------- |
| 10:00-10:30 | **Intro**       | 30 min   | Welcome, setup, team formation    |
| 10:30-11:00 | **Challenge 1** | 30 min   | Requirements Capture              |
| 11:00-11:30 | **Challenge 2** | 30 min   | Architecture Design               |
| 11:30-12:00 | 🍽️ **Lunch**    | 30 min   | Break                             |
| 12:00-12:45 | **Challenge 3** | 45 min   | Bicep Implementation & Deployment |
| 12:45-13:30 | **Challenge 4** | 45 min   | DR Curveball & Deployment         |
| 13:30-13:45 | ☕ **Break**    | 15 min   | Rest & recharge                   |
| 13:45-14:15 | **Challenge 5** | 30 min   | Load Testing                      |
| 14:15-14:30 | **Challenge 6** | 15 min   | Documentation                     |
| 14:30-14:35 | **Challenge 7** | 5 min    | Diagnostics                       |
| 14:35-14:50 | 🎯 **Prep**     | 15 min   | Presentation Preparation          |
| 14:50-15:50 | **Challenge 8** | 60 min   | Partner Showcase 🎤               |
| 15:50-16:00 | **Wrap-up**     | 10 min   | Leaderboard, cleanup, close       |

---

## Challenge Summary

| #   | Challenge                     | Duration | Points | Agent(s)                             |
| --- | ----------------------------- | -------- | ------ | ------------------------------------ |
| 1   | Requirements Capture          | 30 min   | 20     | `requirements`                       |
| 2   | Architecture Design           | 30 min   | 25     | `architect`                          |
| 3   | Bicep Implementation & Deploy | 45 min   | 25     | `bicep-plan`, `bicep-code`, `deploy` |
| 4   | DR Curveball & Deploy         | 45 min   | 10     | `bicep-plan`, `bicep-code`, `deploy` |
| 5   | Load Testing                  | 30 min   | 5      | (k6 scripts)                         |
| 6   | Documentation                 | 15 min   | 5      | `design`                             |
| 7   | Diagnostics                   | 5 min    | 5      | `diagnose`                           |
| 8   | Partner Showcase 🎤           | 60 min   | 10     | (presentation)                       |

**Total Points**: 105 base + 25 bonus

> [!NOTE]
> **Coaches**: See [facilitator-guide.md](facilitator/facilitator-guide.md) for Challenge 4 details.
> Challenge 8 focuses on professional communication and presentation skills.

---

## Detailed Timing

### Block 1: Intro (10:00 - 10:30)

| Time  | Activity             |
| ----- | -------------------- |
| 10:00 | Welcome & logistics  |
| 10:05 | Microhack overview   |
| 10:12 | 7-step workflow demo |
| 10:18 | Setup verification   |
| 10:24 | Team formation       |
| 10:27 | Scenario briefing    |

### Block 2: Challenge 1 (10:30 - 11:00)

| Time  | Activity                              |
| ----- | ------------------------------------- |
| 10:30 | Start — invoke **requirements** agent |
| 10:40 | Check-in — conversations started?     |
| 10:50 | Progress — draft requirements?        |
| 10:55 | Push — encourage approval             |
| 11:00 | Complete — move to Challenge 2        |

### Block 3: Challenge 2 (11:00 - 11:30)

| Time  | Activity                                    |
| ----- | ------------------------------------------- |
| 11:00 | Start — handoff from **requirements** agent |
| 11:10 | Check-in — WAF recommendations?             |
| 11:20 | Cost — Pricing MCP working?                 |
| 11:25 | Wrap — finalize architecture                |
| 11:30 | Lunch                                       |

### 🍽️ Lunch (11:30 - 12:00)

### Block 4: Challenge 3 (12:00 - 12:45)

| Time  | Activity                                |
| ----- | --------------------------------------- |
| 12:00 | Start — **bicep-plan** agent            |
| 12:10 | Plan — implementation plan ready?       |
| 12:20 | Code — **bicep-code** agent             |
| 12:35 | Validate — `bicep build` + `bicep lint` |
| 12:40 | Deploy — **deploy** agent               |
| 12:45 | Complete — move to Challenge 4          |

### Block 5: Challenge 4 (12:45 - 13:30)

| Time  | Activity                                   |
| ----- | ------------------------------------------ |
| 12:45 | 📣 **Challenge 4: DR Curveball Announced** |
| 12:50 | Update architecture for multi-region       |
| 13:05 | Generate updated Bicep templates           |
| 13:20 | Deploy DR infrastructure                   |
| 13:30 | Complete — take a break                    |

### ☕ Break (13:30 - 13:45)

### Block 6: Challenges 5-7 (13:45 - 14:35)

| Time  | Activity                                     |
| ----- | -------------------------------------------- |
| 13:45 | **Challenge 5: Load Testing**                |
| 13:55 | Run k6 load tests                            |
| 14:15 | **Challenge 6: Documentation**               |
| 14:25 | Generate workload docs with **design** agent |
| 14:30 | **Challenge 7: Diagnostics**                 |
| 14:35 | Prep begins                                  |

### 🎯 Presentation Prep (14:35 - 14:50)

Teams prepare their Partner Showcase presentations (4-min pitch + 2-min Q&A format).

### Block 7: Challenge 8 (14:50 - 15:50)

| Time  | Team                      |
| ----- | ------------------------- |
| 14:50 | Intro & pairings          |
| 14:52 | Team 1 presents (~14 min) |
| 15:06 | Team 2 presents (~14 min) |
| 15:20 | Team 3 presents (~14 min) |
| 15:34 | Team 4 presents (~14 min) |
| 15:48 | Closing remarks           |

### Wrap-up (15:50 - 16:00)

- Announce leaderboard
- Key learnings
- Resource cleanup reminder

---

## Quick Reference

- **Repo**: [github.com/jonathan-vella/azure-agentic-infraops-workshop](https://github.com/jonathan-vella/azure-agentic-infraops-workshop)
- **Challenges**: [microhack/challenges/](challenges/)
- **Facilitator Guide**: [microhack/facilitator/facilitator-guide.md](facilitator/facilitator-guide.md)
- **Pre-Work**: [docs/getting-started.md](../docs/getting-started.md)
