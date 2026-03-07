# Challenge 1: Requirements Gathering

> **Duration**: 30 minutes | **Agent**: `requirements` | **Output**: `01-requirements.md`

## Objective

Use the `requirements` agent to capture comprehensive Azure infrastructure requirements for the FreshConnect platform.

## The Business Challenge

Nordic Fresh Foods needs cloud infrastructure to power their farm-to-table delivery platform.
They've given you the business context — now you must translate it into technical requirements.

**Business Context:**

- Stockholm-based, 500+ restaurant partners, 10,000 consumers
- Peak season: Summer and December (3x normal load)
- Budget: ~€500/month for MVP infrastructure
- Timeline: 3 months to launch
- Compliance: GDPR (EU data residency required)
- Team: Small (3 devs + 1 DevOps) — need managed services

## Your Challenge

Use the `requirements` agent to capture comprehensive infrastructure requirements.

**Prompt Engineering Focus:**

- How do you frame the business context for the agent?
- What information is critical vs nice-to-have?
- How much detail should you provide upfront?

**Guiding Questions:**

**SLA & Reliability:**

- What availability does the business need? (99%? 99.9%? 99.99%?)
- What's the cost difference between these tiers?
- What does "acceptable downtime" mean for a food delivery platform?
- How long can they be offline before it impacts business?
- How much data loss is acceptable? (RTO/RPO considerations)

**Authentication & Security:**

- Who are the users? (Internal staff? Restaurants? Consumers?)
- Should everyone use the same auth method?
- What about social login for consumers?
- How do you secure API access?

**Network & Compliance:**

- Does GDPR require specific Azure regions?
- Are public endpoints acceptable for MVP?
- What data must stay in EU?
- What security controls are mandatory?

**Monitoring & Operations:**

- How will the ops team know if something breaks?
- What metrics matter most for this business?
- How long should logs be retained?

**Backup & Recovery:**

- What data is critical?
- How often should backups occur?
- Who manages backup retention?

## Crafting Your Prompt

**Example approach** (not prescriptive — adapt based on what you discover):

```
I need to plan Azure infrastructure for [project name] - [brief description].

Business Context:
[What does the business do? Who are the users? What's the scale?]

Constraints:
[Budget, timeline, compliance, team skills]

Key Questions:
[What am I uncertain about? Where do I need the agent's expertise?]
```

**Iterative Approach:**

1. Start with high-level context
2. Let the agent ask clarifying questions
3. Refine your understanding through conversation
4. Don't expect perfection on first prompt

## Expected Conversation Flow

The `requirements` agent will likely ask questions like:

- "What's your target SLA?"
- "What's your RTO/RPO tolerance?"
- "What authentication methods do you need?"

**Your job**: Answer based on business needs, not just technical preferences.

**Before prompting the agent, ask yourself:**

- What would the business stakeholder say?
- What does the MVP actually require vs nice-to-have?
- Where can we simplify for launch and enhance later?

## Verification

Your requirements document should capture:

- ✅ Project overview (name, purpose, timeline, budget)
- ✅ Functional requirements (what capabilities are needed?)
- ✅ Non-functional requirements (SLA, performance, scalability)
- ✅ Compliance requirements (GDPR, data residency)
- ✅ Operational requirements (monitoring, backup, support)

## Success Criteria

| Criterion                       | Points |
| ------------------------------- | ------ |
| Document exists at correct path | 4      |
| Project context complete        | 4      |
| Functional requirements listed  | 4      |
| NFRs specified (SLA, RTO, RPO)  | 4      |
| Compliance identified           | 4      |
| **Total**                       | **20** |

## Coaching Tips

💡 **Start broad, refine through conversation** — Don't try to have all answers upfront

💡 **Business drives technical** — When uncertain, ask "What does the business need?"

💡 **Agent collaboration** — The `requirements` agent suggests defaults when you're unsure

💡 **MVP mindset** — Perfect is the enemy of shipped. What's essential for launch?

💡 **Document unknowns** — "TBD" is valid. Capture what you need to research.

## Reflection Questions

After completing this challenge:

- How did your initial prompt affect the quality of the agent's response?
- What questions caught you off-guard?
- What would you do differently next time?
- Did you frame requirements from business perspective or technical preference?

## Next Step

After requirements are approved, proceed to [Challenge 2: Architecture](challenge-2-architecture.md).

Hand off to the `architect` agent or manually invoke:

```
Review the requirements in agent-output/freshconnect/01-requirements.md
and create a comprehensive WAF assessment with cost estimates.
```
