<#
.SYNOPSIS
    Removes microhack Azure Policy assignments.
.DESCRIPTION
    Deletes all policy assignments with the 'microhack-' prefix from the
    specified subscription. Use after the event to restore the subscription
    to its pre-event state.
.PARAMETER Subscription
    Azure subscription name or ID to remove policies from.
.EXAMPLE
    .\Remove-GovernancePolicies.ps1 -Subscription "my-subscription-name" -WhatIf
.EXAMPLE
    .\Remove-GovernancePolicies.ps1 -Subscription "my-subscription-name"
#>
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory)]
    [string]$Subscription
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

    Write-Verbose "Listing microhack policy assignments on scope $Scope"
    $assignmentsJson = az policy assignment list --scope $Scope --query "[?starts_with(name, '$AssignmentPrefix')]" -o json 2>&1
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
        Write-Verbose 'No microhack policy assignments found.'
        [PSCustomObject]@{
            SubscriptionId = $SubscriptionId
            Removed        = 0
            Failed         = 0
            Message        = 'No microhack policy assignments found'
        }
        return
    }

    Write-Verbose "Found $($assignments.Count) microhack policy assignment(s)"

    $removed = 0
    $failed  = 0

    foreach ($assignment in $assignments) {
        $name = $assignment.name
        $displayName = $assignment.displayName

        if ($PSCmdlet.ShouldProcess("$displayName ($name)", 'Remove policy assignment')) {
            try {
                Write-Verbose "Removing: $name"
                $result = az policy assignment delete --name $name --scope $Scope 2>&1
                if ($LASTEXITCODE -ne 0) {
                    Write-Warning "Failed to remove '$name': $result"
                    $failed++
                } else {
                    Write-Verbose "Removed: $name"
                    $removed++
                }
            } catch {
                Write-Warning "Failed to remove '$name': $_"
                $failed++
            }
        }
    }

    [PSCustomObject]@{
        Subscription   = $Subscription
        SubscriptionId = $SubscriptionId
        Removed        = $removed
        Failed         = $failed
        TotalFound     = $assignments.Count
    }
}
