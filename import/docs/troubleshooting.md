# Troubleshooting

> [Current Version](../VERSION.md) | Common issues and fixes for Agentic InfraOps

## Dev Container

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

## Microhack-Specific

### Governance policies not applying

**Symptoms**: `Setup-GovernancePolicies.ps1` runs but policies don't appear.

**Fix**: Policy assignments can take up to 30 minutes to propagate.
Check status with:

```powershell
pwsh scripts/microhack/Get-GovernanceStatus.ps1
```

### Scoring script returns zero

**Symptoms**: `Score-Team.ps1` gives 0 points even after deployment.

**Fixes**:

1. Ensure resources are deployed in the correct resource group
2. Check that required tags (`Environment`, `ManagedBy`, `Project`, `Owner`) are applied
3. Run the script with `-Verbose` for detailed output

## Leaderboard App

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
2. Check `staticwebapp.config.json` — the route may require a role the user doesn’t have
3. Use `/.auth/me` to inspect the current user’s roles in the browser

### Missing Submissions table

**Symptoms**: Score submissions fail with a storage error referencing “Submissions”.

**Fix**: The Submissions table must be created manually after infrastructure deployment:

```bash
az storage table create --name Submissions \
  --account-name "<your-storage-account>" \
  --auth-mode login
```

### Upload rejected — team mismatch

**Symptoms**: JSON upload returns “Team mismatch” error.

**Fix**: The `teamName` in the uploaded `score-results.json` must match the
team the signed-in user is registered to. Verify the user’s attendee profile
has the correct `teamNumber`.
