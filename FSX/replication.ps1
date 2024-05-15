# This PowerShell script facilitates the replication of on-premises file shares to AWS FSx Windows shares. 
# It integrates with AWS Secrets Manager to retrieve credentials securely and uses Robocopy for file replication.

# Declaring variables
$shares = @("share1$", "share2", "share3") # Array of on-premises share names to replicate.
$share_path = @("sharePath1", "share_path2", "share path3") # Array of corresponding on-premises share paths.
$onprem_fs = "MYFS" # Server name of the on-premises file share server.
$fsx_share = "MYFSX" # Alias name of the AWS FSx Windows share
$rm_endpoint = "myFsxEndpoint.domain.com" #Endpoint of the FSx Windows file system.
# Retrieving credentials from AWS Secret Manager
$user = ((Get-SECSecretValue -SecretId YOUR_SECRET_ID).SecretString | ConvertFrom-Json).PSObject.Properties.Name
$password = ((Get-SECSecretValue -SecretId YOUR_SECRET_ID).SecretString | ConvertFrom-Json).PSObject.Properties.Value
$credential = New-Object System.Management.Automation.PSCredential 'domain\$user', $password

# Update logfile location according to your environment
$log_dir = "C:\robocopy_dir" 

# Update the $fullAccess, $changeAccess, and $readAccess variables according to your access control requirements.
$fullAccess = "Domain Admins"
$changeAccess = "Authenticated Users"
$readAccess = "Authenticated Users"

# Iterate share names and path
for ($i = 0; $i -lt $shares.Count; $i++) {
    $shareName = $shares[$i]
    $sharePath = $share_path[$i]
    $fsx_share_path_with_drive_letter = "D:\${onprem_fs}\${sharePath}"
    $fsx_share_path = "\\${fsx_share}\D$\${onprem_fs}\${sharePath}"
    # Check if the share path exists in FSx share. Create if it doesn't exist
    if (Test-Path "${fsx_share_path}" -PathType Container) {
        Write-Host "The folder already exists: ${fsx_share_path}"
    } 
    else {
        New-Item -Type Directory -Path "${fsx_share_path}"
        Write-Host "The folder has been created: ${fsx_share_path}"
    }
    # Check if the share exists in FSx share. Create if it doesn't exist
    Invoke-Command -ComputerName $rm_endpoint -ConfigurationName FSxRemoteAdmin -scriptblock {
        param (
        [string]$shareName,
        [string]$onprem_fs,
        [string]$sharePath,
        [string]$fullAccess,
        [string]$changeAccess,
        [string]$readAccess,
        [string]$fsx_share_path_with_drive_letter,
        [System.Management.Automation.PSCredential]$credential
        )
    
        New-FSxSmbShare -Name $shareName -Path $fsx_share_path_with_drive_letter -credential $Using:credential -FullAccess $fullAccess -ChangeAccess $changeAccess -ReadAccess  $readAccess
    } -ArgumentList $shareName, $onprem_fs, $sharePath, $fsx_share_path_with_drive_letter, $credential, $fullAccess,  $changeAccess, $readAccess
    if ($?) {
        Write-Host "The share ${shareName} is created in $fsx_share_path_with_drive_letter in FSx share \\$fsx_share\$onprem_fs"
    }
    else {
        Write-Host "The share ${shareName} is not created in $fsx_share_path_with_drive_letter in FSx share \\$fsx_share\$onprem_fs"
    }
    # Run robocopy
    if ( -not (Test-Path -Path "${log_dir}" -PathType Container)) {
        New-Item -Type Directory -Path "${log_dir}"
    }
    $source = "\\${onprem_fs}\${shareName}" 
    $destination = "\\${fsx_share}\${onprem_fs}\${sharePath}"
    $log_file = "robocopy_from_${onprem_fs}_${shareName}_to_${fsx_share}_${shareName}.txt"
    robocopy $source $destination /copy:DATSOU /secfix /e /b /ETA /R:3 /W:10 /MT:8 /LOG:${log_dir}\$log_file
# /copy – Specifies the following file properties to be copied:
# D – data
# A – attributes
# T – timestamps
# S – NTFS ACLs
# O – owner information
# U – auditing information.
# /secfix – Fixes file security on all files, even skipped ones.
# /e – Copies subdirectories, including empty ones.
# /b – Uses the backup and restore privilege in Windows to copy files even if their NTFS ACLs deny permissions to the current user.
# /MT:8 – Specifies how many threads to use for performing multithreaded copies.
}
