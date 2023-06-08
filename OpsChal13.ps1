#Author: Sam Allan
#Date: 06/03/2023
#Script: Seattle Ops 301n3 Ops Challenge 13
#Purpose: create new users based on user input in AD DS
#Import space:
Import-Module ActiveDirectory
# original script commented out to prevent repeated additions of the same user
#$userParams = @{
#    SamAccountName = 'f.ferdinand'
#    UserPrincipalName = 'ferdi@globexpower.com'
#    Name = 'Franz Ferdinand'
#    DisplayName = 'Franz Ferdinand'
#    Description = 'TPS Reporting Lead'
#    Title = 'TPS Reporting Lead'
#    Department = 'TPS Department'
#    Company = 'GlobeX USA'
#    Office = 'Springfield, OR'
#    EmailAddress = 'ferdi@globexpower.com'
#    Enabled = $True
#    AccountPassword = (ConvertTo-SecureString -AsPlainText "YeehA34wth%$isatest" -Force) 
#    PasswordNeverExpires = $True
#}

# MAIN

# Create the new user
#New-ADUser @userParams

#END


#improved version that takes user input (trying to kill part two of the lab with this stone as well) and group creation.

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
    echo "11. Exit"
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
    '11' { return }
    default { Write-Host "Invalid choice, please try again." }
    }
   } while ($true)
   

#END