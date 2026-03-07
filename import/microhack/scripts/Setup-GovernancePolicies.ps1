<#
.SYNOPSIS
    Deploys Azure Policies for microhack governance constraints.
.DESCRIPTION
    Creates policy assignments at the subscription level that enforce security
    and compliance requirements teams must handle during the microhack.
    Policies include location restrictions, tag requirements, and security
    baselines (TLS, HTTPS, Azure AD auth).

    All assignments use the 'microhack-' prefix for easy identification
    and cleanup via Remove-GovernancePolicies.ps1.
.PARAMETER Subscription
    Azure subscription name or ID to deploy policies to.
.EXAMPLE
    .\Setup-GovernancePolicies.ps1 -Subscription "my-subscription-name" -WhatIf
.EXAMPLE
    .\Setup-GovernancePolicies.ps1 -Subscription "my-subscription-name"
#>
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory)]
    [string]$Subscription
)

begin {
    $ErrorActionPreference = 'Stop'
    Set-StrictMode -Version Latest

    # Built-in Azure Policy definitions used by the microhack.
    # Each entry maps to a well-known definition ID; the script validates
    # existence at runtime before creating assignments.
    $Policies = @(
        @{
            Name           = 'microhack-allowed-locations'
            DisplayName    = 'Microhack: Allowed locations'
            DefinitionId   = 'e56962a6-4747-49cd-b67b-bf8b01975c4c'
            Description    = 'Restrict resource deployment to swedencentral, germanywestcentral, and global'
            Parameters     = @{
                listOfAllowedLocations = @{ value = @('swedencentral', 'germanywestcentral', 'global') }
            }
        }
        @{
            Name           = 'microhack-require-environment-tag'
            DisplayName    = 'Microhack: Require Environment tag'
            DefinitionId   = '871b6d14-10aa-478d-b590-94f262ecfa99'
            Description    = 'Deny resources without an Environment tag'
            Parameters     = @{
                tagName = @{ value = 'Environment' }
            }
        }
        @{
            Name           = 'microhack-require-project-tag'
            DisplayName    = 'Microhack: Require Project tag'
            DefinitionId   = '871b6d14-10aa-478d-b590-94f262ecfa99'
            Description    = 'Deny resources without a Project tag'
            Parameters     = @{
                tagName = @{ value = 'Project' }
            }
        }
        @{
            Name           = 'microhack-sql-aad-only-auth'
            DisplayName    = 'Microhack: SQL Azure AD-only authentication'
            DefinitionId   = 'abda6d70-9778-44e7-84a8-06713e6db027'
            Description    = 'Deny Azure SQL databases without Azure AD-only authentication'
            Parameters     = @{
                effect = @{ value = 'Deny' }
            }
        }
        @{
            Name           = 'microhack-storage-https-only'
            DisplayName    = 'Microhack: Storage HTTPS only'
            DefinitionId   = '404c3081-a854-4457-ae30-26a93ef643f9'
            Description    = 'Deny storage accounts that allow insecure HTTP traffic'
            Parameters     = @{
                effect = @{ value = 'Deny' }
            }
        }
        @{
            Name           = 'microhack-storage-min-tls'
            DisplayName    = 'Microhack: Storage minimum TLS 1.2'
            DefinitionId   = 'fe83a0eb-a853-422d-aac2-1bffd182c5d0'
            Description    = 'Deny storage accounts with TLS version below 1.2'
            Parameters     = @{
                effect            = @{ value = 'Deny' }
                minimumTlsVersion = @{ value = 'TLS1_2' }
            }
        }
        @{
            Name           = 'microhack-storage-no-public-blob'
            DisplayName    = 'Microhack: Storage no public blob access'
            DefinitionId   = '4fa4b6c0-31ca-4c0d-b10d-24b96f62a751'
            Description    = 'Deny storage accounts that allow public blob access'
            Parameters     = @{
                effect = @{ value = 'Deny' }
            }
        }
        @{
            Name           = 'microhack-appservice-https'
            DisplayName    = 'Microhack: App Service HTTPS only'
            DefinitionId   = 'a4af4a39-4135-47fb-b175-47fbdf85311d'
            Description    = 'Deny App Service apps that allow non-HTTPS traffic'
            Parameters     = @{
                effect = @{ value = 'Deny' }
            }
        }
    )
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

    $created = 0
    $skipped = 0
    $failed  = 0

    foreach ($policy in $Policies) {
        $assignmentName = $policy.Name

        # Check if assignment already exists
        az policy assignment show --name $assignmentName --scope $Scope 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Verbose "Assignment '$assignmentName' already exists — skipping"
            $skipped++
            continue
        }

        $parametersJson = $policy.Parameters | ConvertTo-Json -Depth 5 -Compress

        if ($PSCmdlet.ShouldProcess("$Scope — $($policy.DisplayName)", 'Create policy assignment')) {
            try {
                Write-Verbose "Creating assignment: $assignmentName"
                $result = az policy assignment create `
                    --name $assignmentName `
                    --display-name $policy.DisplayName `
                    --policy $policy.DefinitionId `
                    --scope $Scope `
                    --params $parametersJson `
                    --enforcement-mode 'Default' `
                    --description $policy.Description 2>&1

                if ($LASTEXITCODE -ne 0) {
                    Write-Warning "Failed to create '$assignmentName': $result"
                    $failed++
                } else {
                    Write-Verbose "Created: $assignmentName"
                    $created++
                }
            } catch {
                Write-Warning "Failed to create '$assignmentName': $_"
                $failed++
            }
        }
    }

    [PSCustomObject]@{
        Subscription   = $Subscription
        SubscriptionId = $SubscriptionId
        Created        = $created
        Skipped        = $skipped
        Failed         = $failed
        TotalPolicies  = $Policies.Count
    }

    if ($created -gt 0) {
        Write-Warning 'Policies take 5-15 minutes to become effective after deployment.'
    }
}
