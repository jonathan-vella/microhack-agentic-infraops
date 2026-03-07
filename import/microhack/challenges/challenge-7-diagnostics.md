# Challenge 7: Troubleshooting & Diagnostics

> **Duration**: 5 minutes | **Agent**: `diagnose` or Azure tooling | **Output**: Quick-reference troubleshooting card

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

## Next Step

Move to [Challenge 8: Partner Showcase](challenge-8-partner-showcase.md) to present your FreshConnect solution!
