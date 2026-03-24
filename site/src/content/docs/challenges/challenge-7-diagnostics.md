---
title: 'C7: Diagnostics'
description: Create a quick-reference troubleshooting card for on-call engineers responding
  to FreshConnect incidents.
sidebar:
  order: 7
  badge:
    text: 5 min
    variant: note
prev:
  link: ../challenge-6-documentation/
  label: 'C6: Documentation'
next:
  link: ../challenge-8-partner-showcase/
  label: 'C8: Partner Showcase'
---


:::note[Challenge Info]
⏱️ **5 min** · 🏆 **5 pts** · 📄 07-diagnostics-quick-card.md

:::


## The 2 AM Scenario

**INCIDENT ALERT** 🚨

```
Time: 2:17 AM Sunday
Alert: FreshConnect API response time degraded
Severity: High
P95 Latency: 8.2 seconds (threshold: 2 seconds)
On-Call: You (first day on rotation)
```

You open your laptop. Where do you start? What do you check first?

## Your Challenge (5 minutes)

Create a **quick-reference troubleshooting card** — a one-page guide for the on-call engineer.

Save as: `agent-output/freshconnect/07-diagnostics-quick-card.md`

Optional bonus depth: add `agent-output/freshconnect/07-ab-diagnostics-runbook.md` with expanded
KQL and incident workflows.

### Required Elements

Your troubleshooting card must include:

1. **Top 3 Health Checks** (first 60 seconds)
   - What to check immediately when alerted

2. **Common Symptoms → Actions** (2-3 scenarios)
   - High API latency → Check X, then Y
   - Database errors → Check A, then B
   - Storage failures → Check P, then Q

3. **Key Diagnostic Commands**
   - Azure CLI or KQL queries to run

4. **Escalation Trigger**
   - When to wake up the architect

**Format**: Keep it concise — something you could print on a single page.

## Quick Research

Ask yourself:

- **What are the 3 most likely failure modes** for FreshConnect?
- **What Azure tools** help diagnose each one?
- **What would you check first** at 2 AM?

## Success Criteria

| Criterion                         | Points |
| --------------------------------- | ------ |
| Top 3 health checks documented    | 2      |
| At least 2 symptom → action flows | 2      |
| Escalation criteria defined       | 1      |
| **Total**                         | **5**  |

## Pro Tips

💡 **Start with health checks**: "Is it up?" before "Why is it slow?"

💡 **Use decision trees**: IF this, THEN check that

💡 **Keep it scannable**: Numbered steps, not paragraphs

## Escalation

If you're unsure what the most likely failure modes are, review your deployed resources in the Azure Portal and think about which component failing would have the highest business impact. See [Troubleshooting](../../reference/troubleshooting/) for common failure patterns.

## Artifact Handoff

| Item | Value |
|---|---|
| **Input from** | Deployed infrastructure, prior artifacts (architecture, IaC templates, ADR) |
| **Your output** | `agent-output/freshconnect/07-diagnostics-quick-card.md` (required), optionally `07-ab-diagnostics-runbook.md` |
| **Next step** | [Challenge 8: Partner Showcase](challenge-8-partner-showcase/) — present your FreshConnect solution |
