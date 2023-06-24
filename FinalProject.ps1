#Author: The Night Shifters
#Script Purpose: provide a framework for integrating all functions provided by the crew to automate AD DS configuration
#Import space:
Import-Module ActiveDirectory
#Global variables: 

# MAIN
# Function to create a new user
function NewUser {

    $SamAccountName = Read-Host -Prompt 'Enter the SamAccountName'
    $UserPrincipalName = Read-Host -Prompt 'Enter the UserPrincipalName'
    $Name = Read-Host -Prompt 'Enter the Name'
    $GivenName = Read-Host -Prompt 'Enter the GivenName'
    $Surname = Read-Host -Prompt 'Enter the Surname'
    $DisplayName = Read-Host -Prompt 'Enter the DisplayName'
    $Description = Read-Host -Prompt 'Enter the Description'
    $Title = Read-Host -Prompt 'Enter the Title'
    $Department = Read-Host -Prompt 'Enter the Department'
    $Company = Read-Host -Prompt 'Enter the Company'
    $Office = Read-Host -Prompt 'Enter the Office'
    $EmailAddress = Read-Host -Prompt 'Enter the EmailAddress'
    $Password = Read-Host -Prompt 'Enter the Password' -AsSecureString

    # User parameters
    $userParams = @{
        SamAccountName = $SamAccountName
        UserPrincipalName = $UserPrincipalName
        Name = $Name
        GivenName = $GivenName
        Surname = $Surname
        DisplayName = $DisplayName
        Description = $Description
        Title = $Title
        Department = $Department
        Company = $Company
        Office = $Office
        EmailAddress = $EmailAddress
        Enabled = $True 
        AccountPassword = $Password
        PasswordNeverExpires = $True
    }
    New-ADUser @userParams
}

# Function to create a new group
function NewGroup {
    $GroupName = Read-Host -Prompt 'Enter the Group Name'
    $GroupScope = Read-Host -Prompt 'Enter the Group Scope (Global, Universal, DomainLocal)'
    
    $groupParams = @{
        Name = $GroupName
        GroupScope = $GroupScope
        PassThru = $True
    }
    New-ADGroup @groupParams
    echo "new group created!"
}

# Function to create a new OU
function NewOU {
    $OUName = Read-Host -Prompt 'Enter the OU Name'
    $ouParams = @{
    Name = $OUName
    PassThru = $True
    }
    try {
    New-ADOrganizationalUnit @ouParams
    echo "OU created!"
    } catch {
    echo "Error creating OU: $_"
    }
}

# Function to modify a user
function ModifyUser {
    $SamAccountName = Read-Host -Prompt 'Enter the SamAccountName to modify'
    $UserPrincipalName = Read-Host -Prompt 'Enter the new UserPrincipalName'
    $DisplayName = Read-Host -Prompt 'Enter the new DisplayName'
    
    $userParams = @{
        UserPrincipalName = $UserPrincipalName
        DisplayName = $DisplayName
    }
    Set-ADUser -Identity $SamAccountName @userParams
    echo "User modified!"
}

# Function to modify a group
function ModifyGroup {
    #$GroupName = Read-Host -Prompt 'Enter the Group Name to modify'
    $NewGroupName = Read-Host -Prompt 'Enter the new Group Name'
    $NewGroupScope = Read-Host -Prompt 'Enter the new Group Scope (Global, Universal, DomainLocal)'
    
    $groupParams = @{
        Name = $NewGroupName
        GroupScope = $NewGroupScope
    }
    Set-ADGroup -Identity $GroupName @groupParams
    echo "Group modified!"
}

# Function to modify an OU
function ModifyOU {
    $OUName = Read-Host -Prompt 'Enter the Distinguished Name of the OU to modify'
    $NewOUName = Read-Host -Prompt 'Enter the new OU Name'
    
    Set-ADOrganizationalUnit -Identity $OUName -Name $NewOUName
    echo "OU modified!"
}


function ModifyPassword {
    $SamAccountName = Read-Host -Prompt 'Enter the SamAccountName of the account you want to change the password for'
    $newPassword = Read-Host -Prompt 'Enter the new password' -AsSecureString
    Set-ADAccountPassword -Identity $SamAccountName -NewPassword $newPassword -Reset
    Write-Host "Password changed successfully!"
}


function AddUserToGroup {
    $UserName = Read-Host -Prompt 'Enter the SamAccountName of the user'
    $GroupName = Read-Host -Prompt 'Enter the name of the group'
    try {
    Add-ADGroupMember -Identity $GroupName -Members $UserName
    echo "User added to group!"
    } catch {
    echo "Error adding user to group: $_"
    }
}


function RemoveUser {
    $UserName = Read-Host -Prompt 'Enter the SamAccountName of the user to remove'
    try {
    Remove-ADUser -Identity $UserName -Confirm:$false
    echo "User removed!"
    } catch {
    echo "Error removing user: $_"
    }
}


function ListUsers {
    try {
    Get-ADUser -Filter * | Format-Table SamAccountName, Name
    } catch {
    echo "Error listing users: $_"
    }
}


function ShowHelp {
    echo "1. Create a new user"
    echo "2. Create a new group"
    echo "3. Create a new OU"
    echo "4. Modify a user"
    echo "5. Modify a group"
    echo "6. Modify an OU"
    echo "7. Change a password"
    echo "8. Add user to group"
    echo "9. Remove user"
    echo "10. List users"
    echo "11. Rename a computer"
    echo "12. Populate AD users"
    echo "13. Create a new Forest"
    echo "14. set a static IP"
    echo "15. Add multiple OUs"
    echo "16. Add multiple groups"
    echo "17. Auto Configuration (FRESH INSTANCES ONLY)"
    echo "18. Exit"
}

function RenameDevice {
    $ComputerName = Read-Host -Prompt 'Enter the computer name'
    $NewName = Read-Host -Prompt 'Enter the new computer name'

    # Check if the server is a domain controller
    $IsDomainController = Get-ADDomainController -Identity $ComputerName -Server $ComputerName

    if ($IsDomainController) {
        # Warn the user that renaming a domain controller will break replication
        Write-Host "Warning: Renaming this domain controller will require a restart. Some settings and services may need to be reconfigured. Are you sure you want to continue?"

        while ($true) {
            $Continue = Read-Host -Prompt 'Enter "Y" to continue, "N" to cancel'

            if ($Continue -eq 'Y' -or $Continue -eq 'y') {
                # Rename the computer and configure it as a domain controller
                Rename-Computer -ComputerName $ComputerName -NewName $NewName -Restart
                Set-ADDomainController -Identity $NewName

                # Restart the computer to apply the changes
                Write-Host "Computer renamed and configured as a domain controller. Restart is now required"
                Restart-Computer -Wait

                return
            }
            elseif ($Continue -eq 'N' -or $Continue -eq 'n') {
                return
            }
            else {
                Write-Host "Invalid input. Please enter 'Y' or 'N'."
            }
        }
    }
    else {
        # Rename the computer
        Rename-Computer -ComputerName $ComputerName -NewName $NewName -Force -Restart
        Write-Host "Computer renamed. Restart is now required"
        Restart-Computer -Wait
    }
}


function NewBunchU {
    param(
        [Parameter(Mandatory=$true)]
        [string]$CsvFilePath
    )

    # Import user data from CSV file
    $users = Import-Csv -Path $CsvFilePath

    # Convert the plain text password to a SecureString
    $securePassword = ConvertTo-SecureString "DefaultPassword123" -AsPlainText -Force

    # Add users to Active Directory
    foreach ($user in $users) {
        $properties = @{
            'SamAccountName' = $user.samAccountName
            'Name' = $user.Name
            'OtherAttributes' = @{
                'title' = $user.Group
                'mail' = $user.Email
            }
        }

        # To create a user in the Active Directory
        New-ADUser @properties -AccountPassword $securePassword -ChangePasswordAtLogon $true -PassThru | Enable-ADAccount
    }
}


# Author: Jasmine Garcia
# Date of latest revision: 6/22/2023
# Purpose: Create a script that creates an AD Forest
# Author: Jasmine Garcia
# Date of latest revision: 6/22/2023
# Purpose: Create a script that creates an AD Forest
function NewADForest {
 param(
 [Parameter(Mandatory = $true)]
 [string]$ForestName,
 [Parameter(Mandatory = $true)]
 [string]$DomainName,
 [Parameter(Mandatory = $true)]
 [string]$DomainNetBIOSName,
 [Parameter(Mandatory = $true)]
 [string]$DSRMPassword
 )
 
 # Install Active Directory Domain Services role
 Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -Verbose
 # Promote the server to a domain controller
 Install-ADDSForest -CreateDnsDelegation:$false `
 -DatabasePath "C:\Windows\NTDS" `
 -DomainMode "Win2012" `
 -DomainName $ForestName `
 -DomainNetbiosName $DomainNetBIOSName `
 -ForestMode "Win2012" `
 -InstallDns:$true `
 -LogPath "C:\Windows\NTDS" `
 -NoRebootOnCompletion:$true `
 -SysvolPath "C:\Windows\SYSVOL" `
 -Force:$true `
 -SafeModeAdministratorPassword (ConvertTo-SecureString -String $DSRMPassword -AsPlainText -Force) `
 -Verbose
 # Restart the server to complete the promotion
 Restart-Computer -Force
}
# Example usage of the function


   
# Author: Osaremeh Abel
# Script purpose: Script that will assign the Windows server VM a static IPv4 address
function SetStaticIP {
    $AdapterName = Read-Host -Prompt 'Enter the Adapter Name'
    $IPAddress = Read-Host -Prompt 'Enter the IP Address'
    $PrefixLength = Read-Host -Prompt 'Enter the Prefix Length'
    $DefaultGateway = Read-Host -Prompt 'Enter the Default Gateway'
    $DNSServer = Read-Host -Prompt 'Enter the DNS Server'

    # Get the network adapter
    $adapter = Get-NetAdapter -Name $AdapterName

    # Remove existing IP addresses
    $adapter | Remove-NetIPAddress -Confirm:$false

    # Set the new IP address
    $adapter | New-NetIPAddress -IPAddress $IPAddress -PrefixLength $PrefixLength -DefaultGateway $DefaultGateway

    # Remove existing default gateway
    $adapter | Remove-NetRoute -DestinationPrefix 0.0.0.0/0 -Confirm:$false

    # Set the new default gateway
    $adapter | New-NetRoute -DestinationPrefix 0.0.0.0/0 -NextHop $DefaultGateway

    # Set the DNS server
    $adapter | Set-DnsClientServerAddress -ServerAddresses $DNSServer
}

function NewMultipleOUs {
    $OUList = Read-Host -Prompt 'Enter the OU Names (separated by commas)'
    $OUs = $OUList.Split(',')
    
    foreach ($OUName in $OUs) {
        $OUName = $OUName.Trim()  # Remove any leading or trailing spaces
        $ouParams = @{
            Name = $OUName
            PassThru = $True
        }
        try {
            New-ADOrganizationalUnit @ouParams
            echo "OU '$OUName' created!"
        } catch {
            echo "Error creating OU '$OUName': $_"
        }
    }
}

function NewGroupInOU {
    $GroupName = Read-Host -Prompt 'Enter the Group Name'
    $GroupScope = Read-Host -Prompt 'Enter the Group Scope (Global, Universal, DomainLocal)'
    $OUList = Read-Host -Prompt 'Enter the OUs to assign this group to (separated by commas)'
    $OUs = $OUList.Split(',')
    
    $groupParams = @{
        Name = $GroupName
        GroupScope = $GroupScope
        PassThru = $True
    }
    
    $group = New-ADGroup @groupParams
    echo "New group '$GroupName' created!"
    
    foreach ($OUName in $OUs) {
        $OUName = $OUName.Trim()  # Remove any leading or trailing spaces
        try {
            Move-ADObject -Identity $group.DistinguishedName -TargetPath ("OU=" + $OUName + ",DC=domain,DC=com")
            echo "Group '$GroupName' assigned to OU '$OUName'!"
        } catch {
            echo "Error assigning group '$GroupName' to OU '$OUName': $_"
        }
    }
}


function autoconfig {
    # Create a scheduled task to run this script at startup
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File `"$PSCommandPath`" -TaskRun"
    $trigger = New-ScheduledTaskTrigger -AtStartup
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -DontStopOnIdleEnd
    $principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount
    Register-ScheduledTask -TaskName "MyScript" -Action $action -Trigger $trigger -Settings $settings -Principal $principal

    # If the -TaskRun switch is present, this is the post-restart run
    if ($TaskRun) {
        NewBunchU
        NewMultipleOUs
        NewGroupInOU
        SetStaticIP

        # Delete the scheduled task
        Unregister-ScheduledTask -TaskName "MyScript" -Confirm:$false
    } else {
        # This is the pre-restart run
        NewADForest -ForestName "harmonitech.com" -DomainName "harmonitech" -DomainNetBIOSName "HARMONITECH" -DSRMPassword "Catatemydog89!"
        Restart-Computer -Wait
    }
}

# Menu system
do {
    ShowHelp
    $choice = Read-Host "Enter your choice"
    switch ($choice) {
    '1' { NewUser }
    '2' { NewGroup }
    '3' { NewOU }
    '4' { ModifyUser }
    '5' { ModifyGroup }
    '6' { ModifyOU }
    '7' { ModifyPassword }
    '8' { AddUserToGroup }
    '9' { RemoveUser }
    '10' { ListUsers }
    '11' { RenameDevice }
    '12' { NewBunchU }
    '13' { NewADForest -ForestName "harmonitech.com" -DomainName "harmonitech" -DomainNetBIOSName "HARMONITECH" -DSRMPassword "Catatemydog89!" }
    '14' { SetStaticIP }
    '15' { NewMultipleOUs }
    '16' { NewGroupInOU }
    '17' { autoconfig }
    '18' { return }
    default { Write-Host "Invalid choice, please try again." }
    }
   } while ($true)
   

#END