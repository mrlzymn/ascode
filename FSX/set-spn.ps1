# This PowerShell script automates the process of setting Service Principal Names (SPN) and DNS records for AWS FSx Windows shares. 
# It ensures proper integration with Active Directory and enables seamless access to FSx shares using aliases.

# Declaring variables
$featureNames = @("RSAT-AD-PowerShell", "RSAT-DNS-Server") # Array of Windows features required for ADDS/DNS management.
$aliases = @("myfsxAlias.domain.com") # Array of DNS aliases for the FSx Windows share.
$FSxDnsName = "myfsxEndpoint.domain.com" # DNS name of the FSx Windows file system.

# Installing required features
foreach ($featureName in $featureNames) {
    # Check if the feature is already installed
    $installed = Get-WindowsFeature -Name $featureName | Where-Object { $_.Installed }
    if ($installed) {
        Write-Host "The feature $featureName is already installed."
    } else {
        # Install the feature
        Write-Host "Installing the feature $featureName..."
        Install-WindowsFeature -Name $featureName -IncludeAllSubFeature -IncludeManagementTools
        # Check if the installation was successful
        $installed = Get-WindowsFeature -Name $featureName | Where-Object { $_.Installed }
        if ($installed) {
            Write-Host "The feature $featureName has been successfully installed."
        } else {
            Write-Host "Failed to install the feature $featureName." -ForegroundColor Red
        }
    }
}

# Check if SPN exist 
foreach ($alias in $aliases) {
    SetSPN /Q ("HOST/" + $alias)
    SetSPN /Q ("HOST/" + $alias.Split(".")[0])
}

# Delete SPN if it exists
$FileSystemDnsName = $alias
$FileSystemHost = (Resolve-DnsName ${FileSystemDnsName} | Where Type -eq 'A')[0].Name.Split(".")[0]
$FSxAdComputer = (Get-AdComputer -Identity ${FileSystemHost})
SetSPN /D ("HOST/" + ${Alias}) ${FSxAdComputer}.Name
SetSPN /D ("HOST/" + ${Alias}.Split(".")[0]) ${FSxAdComputer}.Name

# Setting SPN for AD computer object of FSx
foreach ($alias in $aliases) {
    $FileSystemHost = (Resolve-DnsName $FSxDnsName | Where Type -eq 'A')[0].Name.Split(".")[0]
    $FSxAdComputer = (Get-AdComputer -Identity $FileSystemHost)
    SetSpn /S ("HOST/" + $Alias.Split('.')[0]) $FSxAdComputer.Name
    SetSpn /S ("HOST/" + $Alias) $FSxAdComputer.Name
}

# Checking SPN for AD computer object of FSx
foreach ($alias in $aliases) {
    $FileSystemHost = (Resolve-DnsName ${FSxDnsName} | Where Type -eq 'A')[0].Name.Split(".")[0]
    $FSxAdComputer = (Get-AdComputer -Identity ${FileSystemHost})
    SetSpn /L ${FSxAdComputer}.Name
}

# Adding alias record to DNS
foreach ($alias in $aliases) {
    $AliasHost=$alias.Split('.')[0]
    $ZoneName=((Get-WmiObject Win32_ComputerSystem).Domain)
    $DnsServerComputerName = (Resolve-DnsName $ZoneName -Type NS | Where Type -eq 'A' | Select -ExpandProperty Name) | Select -First 1
    foreach ($computer in $DnsServerComputerName)
    {
    Add-DnsServerResourceRecordCName -Name $AliasHost -ComputerName $computer -HostNameAlias $FSxDnsName -ZoneName $ZoneName
    }
}
