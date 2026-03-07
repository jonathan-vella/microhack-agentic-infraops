# Challenge 6: Workload Documentation

> **Duration**: 15 minutes | **Agent**: `design` | **Output**: At least 2 documentation artifacts

## The Business Context

Your infrastructure is deployed. FreshConnect is running in production. Now the hard questions begin:

- **Operations Team**: "How do I troubleshoot when something breaks at 2 AM?"
- **Compliance Team**: "Can you document our disaster recovery procedures for the audit?"
- **New Developer** (3 months from now): "Where do I even start understanding this system?"
- **Finance Team**: "What are we actually spending money on each month?"

Professional infrastructure requires professional documentation. The infrastructure works today, but will your team
understand it tomorrow?

## Your Challenge

Use the `design` agent to generate operational documentation that answers real business questions.

### Consider These Scenarios

**Scenario 1: The On-Call Engineer**
It's 2 AM. Azure Monitor shows alerts. Database connections are timing out. The on-call engineer has never seen this
codebase before. What document would help them the most?

**Scenario 2: The Compliance Audit**
ISO 27001 auditor asks: "Show me your disaster recovery procedures." You have Bicep templates, but do you have
documented runbooks?

**Scenario 3: The Cost Review**
CFO asks: "Why did our Azure bill increase 30% last month?" Do you have architecture diagrams showing what services
cost what?

**Scenario 4: The New Team Member**
Junior developer joins the team. They need to understand the system before they can contribute. What's the "README for
operations"?

### Guiding Questions

Before you prompt the `design` agent, ask yourself:

1. **Audience**: Who will read this documentation?
   - Operations team (troubleshooting focus)?
   - Developers (architecture understanding)?
   - Management (cost and business value)?
   - Compliance (procedures and controls)?

2. **Format**: What format serves the audience best?
   - Step-by-step runbook for incident response?
   - Architecture overview with diagrams?
   - Cost breakdown with optimization recommendations?
   - Disaster recovery procedures with RTO/RPO metrics?

3. **Value**: What business question does this answer?
   - "How do I fix it?" (Operational)
   - "How does it work?" (Educational)
   - "What does it cost?" (Financial)
   - "Is it compliant?" (Regulatory)

4. **Context**: What information does the `design` agent need?
   - Project name and purpose?
   - Target audience and their expertise level?
   - Specific focus area (operations, cost, DR, architecture)?
   - Output format preference (markdown, diagrams, tables)?

### Required Deliverables

Generate **at least 2** of the following documentation artifacts:

- [ ] **Operations Runbook**: How to operate, monitor, and troubleshoot FreshConnect
- [ ] **Architecture Documentation**: System overview, component relationships, data flows
- [ ] **Cost Estimate & Optimization Guide**: Current costs, projections, optimization opportunities
- [ ] **Disaster Recovery Plan**: Backup procedures, RTO/RPO metrics, recovery steps
- [ ] **Deployment Guide**: How to deploy updates, rollback procedures, environment management
- [ ] **Security Documentation**: Security controls, compliance mapping, audit procedures

💡 **Coaching Tip**: The best documentation answers questions before they're asked. What would you want to know if you
inherited this system?

## Example Prompt Approaches (Choose Your Own Path)

### Approach A: Specific Audience Focus

```
I need operational documentation for FreshConnect, targeted at [audience].

Context:
- Deployed infrastructure in swedencentral
- Using [list key services: App Service, SQL Database, etc.]
- [Specific business requirements or constraints]

Please generate [specific document type] that helps [audience] accomplish [goal].
```

### Approach B: Compliance-Driven

```
Generate disaster recovery documentation for FreshConnect to support ISO 27001 compliance.

Requirements:
- Document RTO: 4 hours, RPO: 1 hour
- Backup procedures for SQL Database and Storage
- Recovery procedures and verification steps
- Responsibilities and escalation paths

Output as a formal DR runbook.
```

### Approach C: Cost Transparency

```
Create cost documentation for FreshConnect infrastructure.

Include:
- Current architecture with service costs
- Monthly cost projections
- Optimization recommendations
- Cost vs performance trade-offs

Audience: Engineering team and finance stakeholders
```

💡 **Remember**: You're not limited to these approaches. Craft a prompt that addresses YOUR team's most urgent
documentation needs.

## Success Criteria

| Criterion                                      | Points |
| ---------------------------------------------- | ------ |
| At least 2 documentation artifacts generated   | 2      |
| Documentation addresses specific business need | 1      |
| Appropriate format for target audience         | 1      |
| Content is actionable (not just descriptive)   | 1      |
| **Total**                                      | **5**  |

## Reflection Questions

After generating documentation:

- **Completeness**: Could someone unfamiliar with the project use this documentation to operate/understand the system?
- **Business Alignment**: Does this documentation solve a real problem your organization faces?
- **Maintenance**: How would you keep this documentation up-to-date as infrastructure evolves?
- **Gaps**: What documentation is still missing? What would you create if you had another 20 minutes?

## Time Management Tips

- **0-3 min**: Decide what documentation provides most business value for FreshConnect
- **3-7 min**: Craft a detailed prompt for the `design` agent with necessary context
- **7-13 min**: Review generated documentation, request refinements or additional sections
- **13-15 min**: Save artifacts and identify gaps for future documentation

## What You're Learning

- **Prompt Engineering**: How to provide context and constraints for documentation generation
- **Business Thinking**: Which documentation delivers the most value in different scenarios
- **Operational Maturity**: Professional infrastructure requires professional documentation
- **Agent Capabilities**: How AI agents can accelerate documentation while maintaining quality

> [!NOTE]
> Final scoring uses the criteria in the
> [Scoring Rubric](../facilitator/scoring-rubric.md),
> which is the single source of truth for all point values.

## Next Step

Move to [Challenge 7: Troubleshooting & Diagnostics](challenge-7-diagnostics.md) to create incident response runbooks.
