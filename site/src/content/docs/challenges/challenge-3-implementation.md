---
title: 'C3: IaC Implementation'
description: Generate infrastructure-as-code templates (Bicep or Terraform), deploy
  to Azure, and demonstrate understanding of the agent-driven deployment workflow.
sidebar:
  order: 3
  badge:
    text: 45 min
    variant: success
prev:
  link: ../challenge-2-architecture/
  label: 'C2: Architecture'
next:
  link: ../challenge-4-dr-curveball/
  label: 'C4: DR Curveball'
---


:::note[Challenge Info]
⏱️ **45 min** · 🏆 **25 pts** · 🤖 bicep-plan/bicep-code or terraform agents, deploy · 📄 IaC templates + deploy script

:::


## Choose Your IaC Language

Your team must choose **one** Infrastructure-as-Code language for this challenge:

| Option | Language | Agents | Output Directory |
|---|---|---|---|
| **A** | Bicep | `bicep-plan`, `bicep-code`, `deploy` | `infra/bicep/freshconnect/` |
| **B** | Terraform | `terraform-plan`, `terraform-code`, `deploy` | `infra/terraform/freshconnect/` |

:::tip

Choose the language your team is most comfortable with — or the one you want to learn. Both paths earn equal points. If your accelerator repo includes Terraform agents, use those. Otherwise, use Agent mode with Copilot to generate Terraform directly.

:::

## Prerequisite: Azure Policy Deployment (Recommended)

If your facilitator has deployed Azure Policies for the event, your IaC templates will need to
comply with governance constraints (required tags, HTTPS-only, TLS 1.2, etc.).
See the [Governance Scripts](../../reference/governance-scripts/) reference for details.

:::note

**Policy propagation timing**: Azure Policies take 5–15 minutes to become effective after deployment. If your deployment succeeds but you expected a policy denial, the policy may not have propagated yet. Ask your facilitator to verify with `Get-GovernanceStatus.ps1 -MicrohackOnly`. Even if policies are delayed, include the required tags and security settings in your templates — they are part of the success criteria.

:::

## The Business Challenge

Nordic Fresh Foods needs production-ready infrastructure code that:

- Can be deployed repeatedly and consistently
- Meets Azure governance and security requirements
- Is maintainable by their small DevOps team
- Follows infrastructure-as-code best practices

Your task: Generate IaC templates, **deploy them to Azure**, and **demonstrate you understand
the agent workflow** by explaining it.

## Your Challenge

### Part A: Implementation Planning (~10 min)

**Your Task**: Use the planning agent to create an implementation strategy.

- **Bicep path**: Use the `bicep-plan` agent
- **Terraform path**: Use the `terraform-plan` agent (or Agent mode)

**Guiding Questions**:

- What information does the agent need from your architecture assessment?
- How should you structure your prompt to get a phased implementation plan?
- What governance constraints might affect your deployment?

**Prompt Engineering Tip**: The agent works best when you provide context about your
architecture decisions, not just a file reference.

**Expected Output**: `agent-output/freshconnect/04-implementation-plan.md`

---

### Part B: Code Generation (~15 min)

**Your Task**: Use the code generation agent to produce Infrastructure as Code.

**Consider**:

- How do you describe what you need to the agent?
- What module structure makes sense for this workload?
- How will you handle resource naming to avoid conflicts?

#### Bicep Path

**Agent**: `bicep-code`

**The Agent Will Generate**:

```
infra/bicep/freshconnect/
├── main.bicep              # Orchestrator
├── main.bicepparam         # Parameters
├── deploy.ps1              # Deployment script
└── modules/                # Modular Bicep files
```

**Validation Steps**:

```bash
cd infra/bicep/freshconnect
bicep build main.bicep      # What does this check?
bicep lint main.bicep       # What does this validate?
```

#### Terraform Path

**Agent**: `terraform-code` (or Agent mode with Copilot)

**The Agent Will Generate**:

```
infra/terraform/freshconnect/
├── main.tf                 # Root module
├── variables.tf            # Input variables
├── outputs.tf              # Output values
├── providers.tf            # Provider configuration
├── deploy.ps1              # Deployment script
└── modules/                # Reusable modules
```

**Validation Steps**:

```bash
cd infra/terraform/freshconnect
terraform init              # Initialize providers
terraform validate          # Check configuration syntax
terraform plan              # Preview what will be created
```

**Questions to Explore**:

- What happens during validation? What errors would stop you?
- What does linting check for? Are all warnings critical?
- How do Azure Policy constraints affect your deployment?

---

### Part C: Deployment (~15 min) ⭐ REQUIRED

**Your Task**: Use the `deploy` agent to deploy your infrastructure to Azure.

#### Bicep Deployment

**Before Deploying**:

```powershell
# Preview what will be created (What-If)
az deployment group what-if \
  --resource-group rg-freshconnect-dev-swc \
  --template-file main.bicep \
  --parameters main.bicepparam
```

**Deploy Your Infrastructure**:

```powershell
az deployment group create \
  --resource-group rg-freshconnect-dev-swc \
  --template-file main.bicep \
  --parameters main.bicepparam
```

#### Terraform Deployment

**Before Deploying**:

```bash
# Preview what will be created
terraform plan -out=tfplan
```

**Deploy Your Infrastructure**:

```bash
terraform apply tfplan
```

**If Deployment Fails**:

- Read the error message carefully — what does it tell you?
- Is it a naming conflict? A policy violation? A missing parameter?
- How would you prompt the agent to fix the issue?

---

### Part D: Understanding the Workflow (~5 min) ⭐ REQUIRED

**Critical Deliverable**: Create a Mermaid flowchart that explains the agent-driven deployment workflow.

## What Happens Next: Preparing for Challenge 4

Challenge 4 (DR Curveball) builds directly on your Challenge 3 deployment. Your path through Challenge 4 depends on your deployment outcome:

| Challenge 3 Outcome | Challenge 4 Path |
|---|---|
| **Deployment succeeded** | Extend your deployed infrastructure with multi-region DR (full path) |
| **Partial deployment** (some resources created) | Extend what deployed; document what you would change for failed resources in your ADR |
| **Deployment failed** (no resources created) | Pivot to the **paper exercise**: design the DR architecture on paper (ADR + diagram) without deploying |

:::note

**If your deployment failed**: You still complete Challenge 4. Design the DR architecture as an ADR and diagram, explaining what you _would_ deploy and why. This preserves the learning objective. No pre-built reference deployment is provided.

:::

**Output from this challenge that feeds Challenge 4:**

- Your IaC templates (or design documents if deployment failed)
- `agent-output/freshconnect/04-implementation-plan.md`
- Your Mermaid deployment workflow diagram

Your flowchart must show:

1. How the agent generates templates
2. What happens during validation
3. What linting checks for
4. How the `deploy` agent attempts deployment
5. Common errors and how agents adjust
6. The feedback loop when issues are discovered

**Why This Matters**: In your Partner Showcase, you'll need to explain this workflow to
demonstrate you understand the process, not just executed commands.

**Save your flowchart** in your presentation materials - you'll need it for Challenge 8.

**Example Structure** (expand this based on your experience):

```mermaid
graph TD
    A[Agent generates IaC templates] --> B[Validation]
    B --> C{Syntax Errors?}
    C -->|Yes| D[What types of errors?]
    C -->|No| E[Linting / Plan]
    E --> F[...]

    %% Complete this based on what you observe
```

## Key Concepts to Understand

### Resource Naming Patterns

**Question**: Why do some resources fail to deploy with "name already in use" errors?

**Explore**:

- How do you generate unique names for globally-unique resources?
- What's the pattern for Key Vault names? (Hint: 24 char limit)
- What's the pattern for Storage Account names? (Hint: special rules)

### Required Tags

**Question**: Why do deployments fail with "RequestDisallowedByPolicy" errors about missing tags?

**Explore**:

- What tags are required by your subscription's Azure Policies?
- Where in your IaC should tags be defined?
- How do you pass tags to modules?

### Security Baseline

**Question**: What security settings cause policy violations if missing?

**Research**:

- Storage accounts: What HTTPS/TLS settings are required?
- SQL: What authentication mode is enforced?
- App Services: What SSL/TLS requirements exist?

## Artifact Handoff

| Item | Value |
|---|---|
| **Input from** | `agent-output/freshconnect/02-architecture-assessment.md` (Challenge 2) |
| **Your output** | IaC templates + modules, `agent-output/freshconnect/04-implementation-plan.md`, Mermaid workflow diagram |
| **Next step** | [Challenge 4: DR Curveball](../challenge-4-dr-curveball/) — extends your deployed infrastructure (or pivots to paper exercise if deployment failed) |

## Success Criteria

| Criterion                                  | Points |
| ------------------------------------------ | ------ |
| Implementation plan created                | 5      |
| IaC templates generated                    | 5      |
| Templates compile without errors           | 3      |
| **Infrastructure deployed successfully**   | 7      |
| **Workflow diagram created and explained** | 5      |
| **Total**                                  | **25** |

## Coaching Questions

When you encounter issues, ask yourself:

**Naming Conflicts**:

- Q: "My Key Vault deployment failed with 'name already exists'. What now?"
- Consider: How do globally-unique names work in Azure? What makes a good naming strategy?

**Policy Violations**:

- Q: "Why does my deployment fail with 'RequestDisallowedByPolicy'?"
- Consider: What does the error message tell you? How do you discover policy requirements?

**Agent Behavior**:

- Q: "The agent made changes I didn't expect. Why?"
- Consider: What context did you provide? What constraints does the agent know about?

**Validation vs Deployment**:

- Q: "My templates validate clean but deployment fails. Why?"
- Consider: What's the difference between syntax validation and runtime deployment?

## Next Step

After your infrastructure is deployed and you've created your workflow diagram:

⏸️ **Wait for Challenge 4** - The coach will announce a business change at 13:30 that will test your agility!

Use any extra time to:

- Verify deployed resources in Azure Portal
- Explore alternative architectures
- Practice explaining your workflow diagram
- Prepare for the DR curveball
