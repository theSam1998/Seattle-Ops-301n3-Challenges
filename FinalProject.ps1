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
    echo "13. Exit"
}
#function [assign static ip to server] {}
#function [assign dns to server] {}
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
    # Author: Osaremeh Abel
    # Script purpose: Script that will create new users to the org
    # Define user details
    $users = @{
        "CEO" = @{
            "Name" = "Nathan Drake"
            "Group" = "Executive Leadership"
            "Department" = "Executive Office"
            "OU" = "Leadership"
            "samAccountName" = "ndrake"
            "Email" = "ndrake@VerveTech.com"
        }
        "CTO" = @{
            "Name" = "Gordon Freeman"
            "Group" = "Technology Leadership"
            "Department" = "Information Technology"
            "OU" = "Leadership"
            "samAccountName" = "gfreeman"
            "Email" = "gfreeman@VerveTech.com"
        }
        "CFO" = @{
            "Name" = "Agent 47"
            "Group" = "Finance Leadership"
            "Department" = "Finance"
            "OU" = "Leadership"
            "samAccountName" = "a47"
            "Email" = "a47@VerveTech.com"
        }
        "COO" = @{
            "Name" = "Arthur Morgan"
            "Group" = "Operations Leadership"
            "Department" = "Operations"
            "OU" = "Leadership"
            "samAccountName" = "amorgan"
            "Email" = "amorgan@VerveTech.com"
        }
        "VP of Sales" = @{
            "Name" = "Nathan Hale"
            "Group" = "Sales"
            "Department" = "Sales"
            "OU" = "Departments"
            "samAccountName" = "nhale"
            "Email" = "nhale@VerveTech.com"
        }
        "VP of Marketing" = @{
            "Name" = "Faith Connors"
            "Group" = "Marketing"
            "Department" = "Marketing"
            "OU" = "Departments"
            "samAccountName" = "fconnors"
            "Email" = "fconnors@VerveTech.com"
        }
        "HR Manager" = @{
            "Name" = "Doom Guy"
            "Group" = "Human Resources"
            "Department" = "Human Resources"
            "OU" = "Departments"
            "samAccountName" = "dguy"
            "Email" = "dguy@VerveTech.com"
        }
        "IT Manager" = @{
            "Name" = "Alex Mercer"
            "Group" = "IT Management"
            "Department" = "Information Technology"
            "OU" = "Departments"
            "samAccountName" = "amercer"
            "Email" = "amercer@VerveTech.com"
        }
    }

    # Add users to Active Directory
    foreach ($user in $users.GetEnumerator()) {
        $name = $user.Value.Name
        $group = $user.Value.Group
        $department = $user.Value.Department
        $ou = $user.Value.OU
        $samAccountName = $user.Value.samAccountName
        $email = $user.Value.Email

        $properties = @{
            'SamAccountName' = $samAccountName
            'Name' = $name
            'OtherAttributes' = @{
                'title' = $group
                'mail' = $email
            }
        }
    }
    # To a create user in the Active Directory
    New-ADUser @properties -Enabled $true -ChangePassword
}




#function [install AD DS] {}
#function [create forest] {}
#function [Add multiple OUs] {}
#function [Add multiple users] {}
#function [add multiple groups]
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
    '13' { return }
    default { Write-Host "Invalid choice, please try again." }
    }
   } while ($true)
   

#END
