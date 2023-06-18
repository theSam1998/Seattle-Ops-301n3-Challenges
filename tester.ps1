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
