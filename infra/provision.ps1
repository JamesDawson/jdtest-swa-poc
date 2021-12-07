[CmdletBinding()]
param (
    [Parameter()]
    [string] $ResourceGroupName = "jdtest-swa-poc",

    [Parameter()]
    [string] $WebSiteName = "jdtest-swa-poc",

    [Parameter()]
    [string] $Location = "West Europe",

    [Parameter()]
    [string] $RepositoryUrl = "https://github.com/JamesDawson/jdtest-swa-poc",

    [Parameter()]
    [switch] $WhatIf
)

$ErrorActionPreference = "Stop"
$InformationPreference = "Continue"

Import-Module Endjin.CodeOps
Connect-GitHubOrg -OrgName JamesDawson

$here = Split-Path -Parent $PSCommandPath

$parameters = @{
    appLocationInRepo = "/src"
    resourceGroupName = $ResourceGroupName
    siteName = $WebSiteName
    repositoryToken = (ConvertTo-SecureString $env:GITHUB_TOKEN -AsPlainText -Force)
    repositoryUrl = $RepositoryUrl
    repoProvider = "GitHub"
}

New-AzSubscriptionDeployment -Name ("main-{0}" -f (Get-Date -Format "yyyyMMdd-HHmmss")) `
                             -TemplateFile "$here/main.bicep" `
                             -Location $Location `
                             -Verbose `
                             -WhatIf:$WhatIf `
                             @parameters
