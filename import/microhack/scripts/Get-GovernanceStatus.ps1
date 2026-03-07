<#
.SYNOPSIS
    Checks Azure Policy assignments and compliance status.
.DESCRIPTION
    Lists policy assignments on the specified subscription and reports their
    compliance state. Use -MicrohackOnly to filter to assignments created
    by Setup-GovernancePolicies.ps1 (those with the 'microhack-' prefix).
.PARAMETER Subscription
    Azure subscription name or ID to check.
.PARAMETER MicrohackOnly
    When specified, shows only microhack policy assignments instead of all.
.EXAMPLE
    .\Get-GovernanceStatus.ps1 -Subscription "my-subscription-name"
.EXAMPLE
    .\Get-GovernanceStatus.ps1 -Subscription "my-subscription-name" -MicrohackOnly
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$Subscription,

    [Parameter()]
    [switch]$MicrohackOnly
)

begin {
    $ErrorActionPreference = 'Stop'
    Set-StrictMode -Version Latest

    $AssignmentPrefix = 'microhack-'
}

process {
    Write-Verbose "Setting subscription context to '$Subscription'"
    az account set --subscription $Subscription 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        $PSCmdlet.ThrowTerminatingError(
            [System.Management.Automation.ErrorRecord]::new(
                [System.Exception]::new("Failed to set subscription context. Run 'az login' first."),
                'SubscriptionContextFailed',
                [System.Management.Automation.ErrorCategory]::AuthenticationError,
                $Subscription
            )
        )
    }

    $SubscriptionId = az account show --query id -o tsv 2>&1
    $Scope = "/subscriptions/$SubscriptionId"

    # Retrieve policy assignments
    $filter = if ($MicrohackOnly) {
        "[?starts_with(name, '$AssignmentPrefix')]"
    } else {
        '[]'
    }

    Write-Verbose "Listing policy assignments (MicrohackOnly=$MicrohackOnly)"
    $assignmentsJson = az policy assignment list --scope $Scope --query $filter -o json 2>&1
    if ($LASTEXITCODE -ne 0) {
        $PSCmdlet.ThrowTerminatingError(
            [System.Management.Automation.ErrorRecord]::new(
                [System.Exception]::new("Failed to list policy assignments: $assignmentsJson"),
                'ListAssignmentsFailed',
                [System.Management.Automation.ErrorCategory]::ReadError,
                $Scope
            )
        )
    }

    $assignments = $assignmentsJson | ConvertFrom-Json
    if ($assignments.Count -eq 0) {
        $label = if ($MicrohackOnly) { 'microhack' } else { '' }
        Write-Warning "No $label policy assignments found on subscription $SubscriptionId."
        return
    }

    # Retrieve compliance summary
    Write-Verbose 'Fetching compliance states'
    $complianceJson = az policy state summarize --subscription $SubscriptionId --scope $Scope -o json 2>&1
    $complianceLookup = @{}
    if ($LASTEXITCODE -eq 0) {
        $summary = $complianceJson | ConvertFrom-Json
        foreach ($result in $summary.policyAssignments) {
            $id = $result.policyAssignmentId
            $compliant = $result.results.resourceDetails |
                Where-Object { $_.complianceState -eq 'compliant' } |
                Select-Object -ExpandProperty count -ErrorAction SilentlyContinue
            $nonCompliant = $result.results.resourceDetails |
                Where-Object { $_.complianceState -eq 'noncompliant' } |
                Select-Object -ExpandProperty count -ErrorAction SilentlyContinue
            $complianceLookup[$id] = @{
                Compliant    = [int]($compliant ?? 0)
                NonCompliant = [int]($nonCompliant ?? 0)
            }
        }
    } else {
        Write-Warning 'Could not retrieve compliance data. Showing assignments only.'
    }

    foreach ($assignment in $assignments) {
        $compliance = $complianceLookup[$assignment.id]
        $state = if ($null -eq $compliance) {
            'Unknown'
        } elseif ($compliance.NonCompliant -gt 0) {
            'NonCompliant'
        } else {
            'Compliant'
        }

        [PSCustomObject]@{
            Name            = $assignment.name
            DisplayName     = $assignment.displayName
            EnforcementMode = $assignment.enforcementMode
            State           = $state
            Compliant       = if ($compliance) { $compliance.Compliant } else { '-' }
            NonCompliant    = if ($compliance) { $compliance.NonCompliant } else { '-' }
        }
    }
}
