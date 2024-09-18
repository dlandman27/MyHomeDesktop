function Setup-Environment {
    # Install Git
    Write-Host "Installing Git..." -ForegroundColor Cyan
    winget install --id Git.Git -e --source winget

    # Install Node.js (includes npm)
    Write-Host "Installing Node.js..." -ForegroundColor Cyan
    winget install --id OpenJS.NodeJS -e --source winget

    # Install Python
    Write-Host "Installing Python..." -ForegroundColor Cyan
    winget install --id Python.Python.3 -e --source winget

    # Verify installations
    Write-Host "Verifying installations..." -ForegroundColor Cyan
    git --version
    node --version
    npm --version
    python --version

    Write-Host "Setup complete!" -ForegroundColor Green
}

# Call the setup function
Setup-Environment