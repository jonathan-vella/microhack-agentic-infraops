# Challenge 2: Architecture Assessment

> **Duration**: 30 minutes | **Agent**: `architect` | **Output**: `02-architecture-assessment.md`

## The Architecture Challenge

You have requirements — now translate them into an Azure architecture that's reliable,
secure, cost-effective, and Well-Architected.

**Your constraints:**

- ~€500/month budget for infrastructure
- Small ops team (managed services preferred)
- EU data residency (GDPR)
- 99.9% SLA target
- 3-month timeline to MVP

## Your Challenge

Use the `architect` agent to evaluate your requirements against Azure's Well-Architected Framework
and produce a comprehensive architecture assessment.

**Prompt Engineering Focus:**

- How do you reference previous agent work?
- What architectural decisions should YOU make vs asking the agent?
- How do you balance cost, reliability, and complexity?

**Guiding Questions:**

**Service Selection:**

- Web hosting: App Service vs Container Apps vs AKS?
- Database: SQL Database vs Cosmos DB vs PostgreSQL?
- Storage: Blob Storage tiers — Hot, Cool, Archive?
- What factors drive each decision?
- Which options align with team skills and timeline?

**Well-Architected Pillars:**

- **Reliability**: How do you achieve 99.9%? What's your failure strategy?
- **Security**: How do you handle secrets? What network boundaries exist?
- **Cost**: Where can you optimize without sacrificing requirements?
- **Performance**: Where will bottlenecks occur? How do you mitigate?
- **Operational Excellence**: How complex can your team handle?

**Cost vs Capability Trade-offs:**

- Zone redundancy: Do you need it for MVP?
- Backup retention: 7 days vs 30 days?
- Premium tiers: When is Standard sufficient?
- Managed services premium: Worth the cost reduction in ops burden?

**Compliance Alignment:**

- GDPR: Which services support EU data residency?
- Azure Policy: What governance should be enforced?
- Data classification: What data is most sensitive?

## Crafting Your Prompt

**Example approach** (adapt based on your requirements):

```
Review my requirements in [file path] and assess the architecture against
Azure Well-Architected Framework.

Key decisions I need guidance on:
[What are you uncertain about? Where do trade-offs exist?]

Business constraints to consider:
[Budget, timeline, team, compliance]

Please provide recommendations for [specific areas].
```

**Architectural Thinking:**

- Start with constraints (budget, compliance, timeline)
- Consider team capabilities — can they operate it?
- Identify critical paths — what can't fail?
- Think iteratively — what's MVP vs future enhancement?

## Expected Conversation Flow

The `architect` agent will:

- Review your requirements document
- Identify gaps or ambiguities
- Propose service options with trade-offs
- Assess against Well-Architected pillars
- Recommend specific SKUs and configurations

**Your role:**

- Make business-aligned decisions
- Ask "why" when recommendations seem over-engineered
- Challenge cost vs value
- Validate against requirements

## Verification

Your architecture assessment should capture:

- ✅ Workload overview (business context, requirements summary)
- ✅ Recommended Azure services with SKUs
- ✅ Well-Architected Framework assessment (5 pillars)
- ✅ Trade-off analysis (cost, complexity, capability)
- ✅ Risk identification and mitigation strategies
- ✅ Specific recommendations for improvement
- ✅ Cost estimate or reference to pricing considerations
- ✅ Architecture diagram generated (PNG or Mermaid)

## Success Criteria

| Criterion                                  | Points |
| ------------------------------------------ | ------ |
| Architecture assessment document created   | 5      |
| Azure services selected with justification | 5      |
| WAF assessment complete (all 5 pillars)    | 5      |
| Trade-offs documented                      | 3      |
| Cost estimate provided                     | 4      |
| Architecture diagram generated             | 3      |
| **Total**                                  | **25** |

## Coaching Tips

💡 **Challenge recommendations** — If something seems over-engineered, ask "Why do we need this?"

💡 **Cost vs value** — Premium tiers cost more. What business value do they provide?

💡 **Managed services** — With a small team, operational burden matters as much as cost

💡 **MVP mindset** — What's essential for launch vs nice-to-have later?

💡 **Compliance first** — GDPR violations are expensive. Data residency is non-negotiable.

## Reflection Questions

After completing this challenge:

- Did the `architect` agent suggest services you hadn't considered?
- How did you balance cost optimization with reliability requirements?
- What architectural decisions were hardest to make? Why?
- Did you prioritize business constraints or technical preferences?

<details>
<summary>📊 Reliability Checklist</summary>

- [ ] SLA target defined and achievable
- [ ] RTO/RPO documented
- [ ] Backup strategy defined
- [ ] Failure modes identified
- [ ] Health monitoring configured

</details>

<details>
<summary>🔒 Security Checklist</summary>

- [ ] Authentication method defined
- [ ] TLS 1.2 minimum
- [ ] Secrets in Key Vault
- [ ] Network security considered
- [ ] Managed identities preferred

</details>

<details>
<summary>💰 Cost Checklist</summary>

- [ ] Within budget
- [ ] Right-sized SKUs
- [ ] Consumption vs. provisioned evaluated
- [ ] Dev/Test vs. Production considered

</details>

## Tips

- 💡 The **architect** agent will suggest trade-offs — understand them
- 💡 Cost estimates are approximate — actual costs may vary
- 💡 Don't gold-plate the MVP — focus on essential features
- 💡 Document assumptions and constraints

> [!NOTE]
> Final scoring uses the criteria in the
> [Scoring Rubric](../facilitator/scoring-rubric.md),
> which is the single source of truth for all point values.

## Required: Architecture Diagram ⭐ MANDATORY

Before proceeding to Challenge 3, generate an architecture diagram:

```
Use the `design` agent (with the `azure-diagrams` skill) to create an architecture diagram for FreshConnect based on
agent-output/freshconnect/02-architecture-assessment.md
```

Your diagram should visualize:

- Azure services and their relationships
- Data flows between components
- Network boundaries and security zones
- Regional placement of resources

**Save your diagram** — you'll need it for your Partner Showcase in Challenge 8.

## Next Step

After architecture assessment and diagram are complete, proceed to [Challenge 3: Implementation](challenge-3-implementation.md).
