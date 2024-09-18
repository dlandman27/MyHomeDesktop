function Setup-Environment {
    # Function to check if a program is installed
    function Is-Installed {
        param (
            [string]$program
        )
        $installed = Get-Command $program -ErrorAction SilentlyContinue
        return $installed -ne $null
    }

    # Install Oh My Posh
    if (-not (Is-Installed "oh-my-posh")) {
        Write-Host "Installing Oh My Posh..." -ForegroundColor Cyan
        winget install --id JanDeDobbeleer.OhMyPosh -e --source winget
    } else {
        Write-Host "Oh My Posh is already installed." -ForegroundColor Green
    }

    # Verify installation
    Write-Host "Verifying Oh My Posh installation..." -ForegroundColor Cyan
    oh-my-posh --version

    Write-Host "Setup complete!" -ForegroundColor Green
}

# Call the setup function
Setup-Environment