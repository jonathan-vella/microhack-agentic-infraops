# Challenge 4: The Curveball — High Availability & Disaster Recovery

> **Duration**: 45 minutes | **Announced at**: 12:45 | **Output**: Updated architecture + Deployed DR infrastructure + ADR

## ⚡ The Announcement

> **COACH READS AT 12:45:**
>
> _"ATTENTION ALL TEAMS! 📣_
>
> _We've just received urgent news from Nordic Fresh Foods headquarters!_
>
> _They've signed a major contract with a Danish restaurant chain — Smørrebrød Express — worth
> €500K annually. The board has convened an emergency session and approved increased infrastructure investment._
>
> _Your infrastructure must now support high availability with disaster recovery capabilities!_
>
> _You have 45 minutes to propose, plan, and **deploy** the solution!_ 🚀"

## New Business Requirements

| Requirement          | Value                | Business Impact                               |
| -------------------- | -------------------- | --------------------------------------------- |
| **RTO**              | ≤1 hour              | Maximum acceptable downtime                   |
| **RPO**              | ≤15 minutes          | Maximum acceptable data loss                  |
| **Secondary Region** | `germanywestcentral` | Coverage for broader European market          |
| **Budget Increase**  | +€200/month          | Total infrastructure budget now ~€700/month   |
| **Timeline**         | 45 minutes           | Board needs decision on architecture approach |

## Your Challenge

You must decide: **What level of HA/DR does the business need?**

### Option A: Single-Region HA

- All resources in `swedencentral`
- Zone-redundant services where available
- Faster failover, lower cost
- Risk: Regional outage affects all services

### Option B: Multi-Region DR

- Primary: `swedencentral`, Secondary: `germanywestcentral`
- Geo-replication for data
- Higher cost, longer RTO
- Risk: Complexity in failover orchestration

### Option C: Multi-Region Active-Active

- Both regions serve traffic simultaneously
- Highest availability, highest cost
- Risk: Data consistency challenges

**Your Task**: Choose an approach and design it as a **parameterized solution**.

## Required Deliverables

### 1. Architecture Decision Record (ADR) ⭐ MANDATORY

Create: `agent-output/freshconnect/04-adr-ha-dr-strategy.md`

Your ADR must document:

**Context**: Why is this decision needed?

- What changed in the business requirements?
- What are the consequences of not addressing this?

**Decision**: What approach did you choose and why?

- Single-region HA vs multi-region DR vs active-active?
- Which services need redundancy?
- What's your failover strategy?

**Consequences**: What are the trade-offs?

- Cost implications (+€200 budget: is it enough?)
- Operational complexity
- RTO/RPO achievability
- Risks and mitigation strategies

**Alternatives Considered**: What did you reject and why?

- Why not the other options?
- What would make you reconsider?

### 2. Updated Bicep (Parameterized)

Add a parameter to your `main.bicep` that enables HA/DR:

**Concept**:

```bicep
param haStrategy string = 'single-region' // 'single-region' or 'multi-region'
param primaryLocation string = 'swedencentral'
param secondaryLocation string = 'germanywestcentral'
```

**Questions to Explore**:

- How do you prompt the `bicep-code` agent to add this capability?
- Which modules need to change?
- What resources must exist in both regions?
- How do you handle data replication?

### 3. Deploy DR Infrastructure ⭐ REQUIRED

After updating your Bicep templates, deploy the DR infrastructure:

```powershell
# Preview changes first
az deployment group what-if \
  --resource-group rg-freshconnect-dev-swc \
  --template-file main.bicep \
  --parameters main.bicepparam \
  --parameters haStrategy='multi-region'

# Deploy with HA enabled
az deployment group create \
  --resource-group rg-freshconnect-dev-swc \
  --template-file main.bicep \
  --parameters main.bicepparam \
  --parameters haStrategy='multi-region'
```

**Deployment Questions**:

- What new resources appear in the What-If output?
- Are there any resources that need to be deployed to the secondary region separately?
- How do you verify that geo-replication is working?

### 4. Updated Architecture Diagram ⭐ MANDATORY

Use the `design` agent (with the `azure-diagrams` skill) to update your architecture diagram showing:

- Primary and secondary region resources
- Geo-replication connections
- Failover paths and traffic routing
- Data synchronization flows

```
Use the `design` agent to update the FreshConnect architecture diagram
to show HA/DR configuration based on agent-output/freshconnect/04-adr-ha-dr-strategy.md
```

**Save your updated diagram** — you'll need it for your Partner Showcase in Challenge 8.

### 5. Updated Cost Estimate

**Consider**:

- Does your solution fit in the +€200 budget increase?
- What are the major cost drivers for HA/DR?
- Where could you optimize if over budget?

## Success Criteria

| Criterion                           | Points |
| ----------------------------------- | ------ |
| ADR documented with clear rationale | 2      |
| HA/DR approach chosen and justified | 2      |
| Bicep parameterized for HA strategy | 2      |
| **DR infrastructure deployed**      | 2      |
| Updated architecture diagram        | 2      |
| **Total**                           | **10** |

## Time Management Tips

💡 **10 minutes**: Architecture Decision Record
💡 **15 minutes**: Prompt the `bicep-code` agent and update templates
💡 **10 minutes**: Deploy DR infrastructure
💡 **5 minutes**: Update architecture diagram
💡 **5 minutes**: Verify deployment and update cost estimate

## Coaching Approach

This challenge tests your ability to:

- Make informed decisions under time pressure
- Balance business needs with technical constraints
- Document architectural decisions clearly
- Use AI agents effectively with well-crafted prompts

**Remember**: There's no single "right answer" - the quality of your decision-making process
matters more than the specific option you choose.

> [!NOTE]
> Final scoring uses the criteria in the
> [Scoring Rubric](../facilitator/scoring-rubric.md),
> which is the single source of truth for all point values.

## Next Step

After completing your ADR and Bicep updates:

Proceed to [Challenge 5: Load Testing](challenge-5-load-testing.md) to validate your
infrastructure can handle the expected load.
