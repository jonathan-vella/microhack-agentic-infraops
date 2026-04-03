---
title: Troubleshooting
description: Common issues and solutions for environment setup, Azure deployments,
  and agent interactions
sidebar:
  order: 3
---

Common issues and fixes for APEX.

## Quick Diagnosis

:::tip

**Start here.** Identify your failure type, then follow the link to the relevant section.

:::

| Symptom | Likely category | Go to |
|---|---|---|
| Can't log in to Azure, subscription not found | [Azure CLI](#azure-cli) | Auth / subscription issue |
| `RequestDisallowedByPolicy` error | [Policy Errors](#policy-errors-and-governance) | Azure Policy denial |
| `QuotaExceeded`, region capacity errors | [Quota Errors](#quota-errors) | Insufficient Azure quota |
| Container won't build, extensions missing | [Dev Container](#dev-container) | Environment setup issue |
| `bicep build` fails, module errors | [Bicep](#bicep) | Template/syntax issue |
| Deployment fails (naming, auth, timeout) | [Deployment Errors](#deployment-errors) | Azure deployment issue |
| Agent not appearing, MCP errors | [Copilot Agents](#copilot-agents) | Agent / tooling issue |
| Secret leaked in output or commit | [Secrets](#secrets-and-credential-leakage) | Credential leakage |
| Lint or link check fails | [Validation](#validation-and-linting) | Linting / validation |

---

## Dev Container

### Docker won't start

**Symptoms**: Docker Desktop fails to launch or reports an error on startup.

**Fixes**:

1. **Windows**: Ensure WSL 2 is enabled (`wsl --install` or `wsl --update`). Restart Docker Desktop after enabling WSL 2.
2. **Mac**: Check that virtualization is enabled in System Settings.
3. Restart Docker Desktop. If it still fails, try resetting to factory defaults.

### Container fails to build

**Symptoms**: "Build failed" or timeout when reopening in container.

**Fixes**:

1. Ensure Docker Desktop is running and has at least 4 GB RAM allocated
2. Run `Dev Containers: Rebuild Container Without Cache` from the Command Palette
3. Check your network — the build pulls images from `mcr.microsoft.com`

### Extensions not loading

**Symptoms**: Copilot Chat or Bicep extension missing after container starts.

**Fix**: The recommended extensions are in `.vscode/extensions.json`.
Run `Extensions: Show Recommended Extensions` and install any that are missing.

## Azure CLI

### `az login` fails inside Dev Container

**Symptoms**: Browser-based login does not redirect back.

**Fix**: Use device code flow:

```bash
az login --use-device-code
```

### Subscription not found

**Symptoms**: Deployment fails with "subscription not found".

**Fixes**:

1. List available subscriptions: `az account list --output table`
2. Set the correct one: `az account set --subscription "<name-or-id>"`

## Bicep

### `bicep build` fails with module errors

**Symptoms**: "Unable to restore module" or "module not found".

**Fixes**:

1. Clear the Bicep module cache: `bicep restore <file>`
2. Ensure you have internet access (AVM modules are fetched from `mcr.microsoft.com`)
3. Check the module version exists: `bicep publish` errors often mean a typo in the version

### Lint warnings about parameter descriptions

**Symptoms**: `no-unused-params` or `missing-description` warnings.

**Fix**: Every `param` must include a `@description()` decorator. Example:

```bicep
@description('The Azure region for all resources.')
param location string = resourceGroup().location
```

## Copilot Agents

### Copilot not working

**Symptoms**: Copilot Chat is unresponsive or shows authentication errors.

**Fixes**:

1. Sign out of GitHub in VS Code and sign back in with the correct account
2. Reload VS Code (`Developer: Reload Window`)
3. Verify your Copilot subscription at [github.com/settings/copilot](https://github.com/settings/copilot)

### Agent not appearing in Chat

**Symptoms**: Custom agents (e.g., InfraOps Conductor) don't show in the agent picker.

**Fixes**:

1. Verify agents are in `.github/agents/*.agent.md`
2. Ensure `"github.copilot.chat.customAgentInSubagent.enabled": true`
3. Reload VS Code (`Developer: Reload Window`)

### Agent produces incomplete output

**Symptoms**: Agent stops mid-response or skips steps.

**Fixes**:

1. Break large requests into smaller steps
2. Provide explicit file paths when referencing artifacts
3. Use the Conductor agent for multi-step workflows — it manages context handoffs

### MCP tools not working

**Symptoms**: Azure MCP tools return errors or are not available.

**Fixes**:

1. Check `.vscode/mcp.json` is present and correct
2. Ensure you are logged in: `az login`
3. Restart the MCP server: `Developer: Reload Window`

## Validation and Linting

### `npm run lint:md` fails

**Symptoms**: markdownlint reports errors.

**Fix**: Auto-fix most issues:

```bash
npm run lint:md:fix
```

For remaining issues, check `.markdownlint-cli2.jsonc` for the rule that fired.

### `npm run lint:links` reports broken links

**Symptoms**: `markdown-link-check` finds dead links.

**Fixes**:

1. For internal links: verify the target file exists
2. For external links: check if the URL is behind authentication or geo-blocked
3. Add false positives to `.markdown-link-check.json` ignore patterns

## Secrets and Credential Leakage

### Secret appears in agent output or committed file

**Symptoms**: A connection string, access key, or password is visible in an agent-generated file or Git history.

**Fixes**:

1. **Rotate the credential immediately** — regenerate the key or password in the Azure Portal or CLI
2. Replace the secret with a placeholder (`<your-connection-string>`) in the file
3. If already committed, remove from Git history or notify your facilitator
4. Use Key Vault references or environment variables going forward

### Preventing secret leakage

- Never paste real secrets into Copilot Chat prompts
- Review all agent-generated files before committing
- Use `az keyvault secret set` to store secrets safely
- Use managed identities where possible to avoid secrets entirely

---

## Policy Errors and Governance

### `RequestDisallowedByPolicy` on deployment

**Symptoms**: Deployment fails with a policy violation error naming a specific policy.

**Diagnosis**:

1. Read the error message — it names the policy that denied the operation
2. Common microhack policies: required tags (`Environment`, `Project`), HTTPS-only, TLS 1.2, allowed locations

**Fixes by policy type**:

| Policy denial | Fix |
|---|---|
| Missing `Environment` or `Project` tag | Add `tags` block to every resource in your Bicep |
| Storage not HTTPS-only | Set `supportsHttpsTrafficOnly: true` |
| Storage TLS version | Set `minimumTlsVersion: 'TLS1_2'` |
| Storage public blob access | Set `allowBlobPublicAccess: false` |
| SQL not Azure AD-only | Set `azureADOnlyAuthentication: true` |
| App Service not HTTPS | Set `httpsOnly: true` |
| Location not allowed | Deploy to `swedencentral` or `germanywestcentral` only |

### Policies not taking effect

**Symptoms**: Deployment succeeds but you expected a policy denial, or `Get-GovernanceStatus.ps1` shows `Unknown`.

**Fixes**:

1. Azure Policies take 5–15 minutes to propagate after deployment
2. Run `Get-GovernanceStatus.ps1 -MicrohackOnly` to check activation status
3. If status is `Unknown`, wait 10 minutes and re-check
4. If still not active after 30 minutes, ask facilitator to re-run `Setup-GovernancePolicies.ps1`

:::tip

Even if policies haven't propagated yet, add the required tags and security settings to your Bicep — they are part of the success criteria.

:::

### Escalation

If you cannot resolve a policy error after checking the table above, ask your facilitator. Provide the full error message and the resource type you were deploying.

---

## Quota Errors

### `QuotaExceeded` on deployment

**Symptoms**: Deployment fails with quota or capacity error for a specific resource type or region.

**Fixes**:

1. Check current usage: `az vm list-usage -l swedencentral -o table`
2. Try a smaller SKU (e.g., S1 instead of P1v3)
3. Try the secondary region (`germanywestcentral`)
4. Delete unused resources from previous attempts
5. Ask your facilitator for help if no quota is available

---

## Deployment Errors

### `NameNotAvailable` or `StorageAccountAlreadyTaken`

**Symptoms**: Globally unique resource name is already in use.

**Fix**: Use `uniqueString(resourceGroup().id)` suffix pattern in your Bicep naming convention.

### `AuthorizationFailed` during deployment

**Symptoms**: Deployment fails with permission error.

**Fixes**:

1. Verify you're targeting the correct subscription: `az account show`
2. Re-authenticate: `az login --use-device-code`
3. Confirm you have Owner or Contributor role on the subscription

### Deployment timeout or partial failure

**Symptoms**: Some resources create successfully, others fail or time out.

**Fixes**:

1. Check the deployment status in the Azure Portal (Resource group → Deployments)
2. Look for the specific resource that failed and its error message
3. Fix the failing resource and re-deploy — already-existing resources will be skipped

---

## Microhack-Specific

### Governance policies not applying

**Symptoms**: `Setup-GovernancePolicies.ps1` runs but policies don't appear.

**Fix**: Policy assignments can take up to 30 minutes to propagate.
Check status with:

```powershell
pwsh scripts/Get-GovernanceStatus.ps1
```

### Scoring totals do not match expectations

**Symptoms**: Facilitator totals look lower than expected after reviewing a team's submission.

**Fixes**:

1. Recheck the team artifacts against the criteria in the scoring rubric
2. Confirm deployment evidence and bonus claims in Azure before awarding those points
3. Verify that the Partner Showcase score was added separately from the base score

## Leaderboard App

This section applies only if your event package includes a separately provided HackerBoard deployment.

### SWA authentication redirect loop

**Symptoms**: Browser keeps redirecting between the app and GitHub login.

**Fixes**:

1. Clear browser cookies for `*.azurestaticapps.net`
2. Verify `staticwebapp.config.json` routes are correctly configured
3. Ensure the GitHub OAuth app callback URL matches the SWA hostname

### API returns 403 Forbidden

**Symptoms**: API calls fail with `403` even after login.

**Fixes**:

1. Confirm the user has been assigned the correct role (`admin` or `member`) via SWA role invitations
2. Check `staticwebapp.config.json` — the route may require a role the user doesn't have
3. Use `/.auth/me` to inspect the current user's roles in the browser

### Missing Submissions table

**Symptoms**: Score submissions fail with a storage error referencing "Submissions".

**Fix**: The Submissions table must be created manually after infrastructure deployment:

```bash
az storage table create --name Submissions \
  --account-name "<your-storage-account>" \
  --auth-mode login
```

### Upload rejected — team mismatch

**Symptoms**: JSON upload returns "Team mismatch" error.

**Fix**: The team identifier in the uploaded score payload must match the
team the signed-in user is registered to. Verify the user's attendee profile
has the correct team assignment.
