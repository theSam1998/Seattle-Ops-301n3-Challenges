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
}

# Function to modify a user
#function ModifyUser {
    # [WIP]
#}

# Function to modify a group
#function ModifyGroup {
    # [WIP]
#}

# Function to modify an OU
#function ModifyOU {
    # [WIP]
#}

# Menu system
do {
    # Display the menu
    Write-Host "1. Create a new user"
    Write-Host "2. Create a new group"
    Write-Host "3. Create a new OU"
    #Write-Host "4. Modify a user"
    #Write-Host "5. Modify a group"
    #Write-Host "6. Modify an OU"
    Write-Host "7. Exit"


    $choice = Read-Host "Enter your choice"


    switch ($choice) {
        '1' { NewUser }
        '2' { NewGroup }
        '3' { NewOU }
    #    '4' { ModifyUser }
    #    '5' { ModifyGroup }
    #    '6' { ModifyOU }
        '7' { break }
        default { Write-Host "Invalid choice, please try again." }
    }
} while ($true)


#END