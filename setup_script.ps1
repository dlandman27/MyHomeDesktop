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

    # Add the new function to reset settings
    function Reset-Settings {
        $configPath = "ps-scripts/settings.config.json"
        $settingsPath = "settings.json"

        if (Test-Path $configPath) {
            $config = Get-Content $configPath | ConvertFrom-Json
            $settings = @{}

            foreach ($category in $config.PSObject.Properties) {
                $settings[$category.Name] = @{}
                foreach ($setting in $category.Value.PSObject.Properties) {
                    $settings[$category.Name][$setting.Name] = $setting.Value."initial-value"
                }
            }

            $settings | ConvertTo-Json -Depth 4 | Set-Content $settingsPath
            Write-Host "Settings have been reset to their initial values." -ForegroundColor Green
        } else {
            Write-Host "Error: settings.config.json not found." -ForegroundColor Red
        }
    }

    # Call the Reset-Settings function
    Reset-Settings

    Write-Host "Setup complete!" -ForegroundColor Green
}

# Call the setup function
Setup-Environment