function Select-OhMyPoshTheme {
    $themesPath = "$env:USERPROFILE\MyHomeDesktop\themes\oh-my-posh"
    $themes = Get-ChildItem -Path $themesPath -Filter "*.omp.json" | Select-Object -ExpandProperty Name
    $originalTheme = $env:POSH_THEME
    $settingsPath = "$env:USERPROFILE\MyHomeDesktop\settings.json"
    $settingsContent = Get-Content $settingsPath -Raw | ConvertFrom-Json
    $activeThemeName = $settingsContent.theme.'default-theme'

    $themeOptions = @()
    for ($i = 0; $i -lt $themes.Count; $i++) {
        $themeName = $themes[$i] -replace '\.omp\.json$', ''
        $themeDisplay = $themeName
        if ($themeName -eq $activeThemeName) {
            $themeDisplay += " (active)"
        }
        $themeOptions += $themeDisplay
    }

    while ($true) {
        Clear-Host
        Write-ColorfulArt $settingsAscii
        Write-Host "`nSelect Oh My Posh Theme" -ForegroundColor Cyan
        Write-Host "Current theme: $activeThemeName" -ForegroundColor Yellow
        Write-Host "View themes at (https://ohmyposh.dev/docs/themes)" -ForegroundColor Yellow
        Write-Host ""

        $choice = Show-Menu -MenuItems $themeOptions -Title "Available Themes" -IsMainMenu $false

        if ($choice -eq ($themeOptions.Count + 1)) {
            return $null  # User chose to go back
        }

        $selectedTheme = $themes[$choice - 1]
        $themeName = $selectedTheme -replace '\.omp\.json$', ''
        return $themeName
        
        # Reset to original theme if user doesn't confirm
        Invoke-Expression ("oh-my-posh init pwsh --config `"$originalTheme`" | Invoke-Expression")
    }
}

function mhd-settings {
    $settingsAscii = @"
 __  __ _   _ ____    ____       _   _   _                 
|  \/  | | | |  _ \  / ___|  ___| |_| |_(_)_ __   __ _ ___ 
| |\/| | |_| | | | | \___ \ / _ \ __| __| | '_ \ / _` / __|
| |  | |  _  | |_| |  ___) |  __/ |_| |_| | | | | (_| \__ \
|_|  |_|_| |_|____/  |____/ \___|\__|\__|_|_| |_|\__, |___/
                                                 |___/     
"@

    function Write-ColorfulArt {
        param([string]$Text)
        $colors = @("Red","Yellow","Green","Cyan","Blue","Magenta")
        $lines = $Text -split "`n"
        for ($i = 0; $i -lt $lines.Length; $i++) {
            Write-Host $lines[$i] -ForegroundColor $colors[$i % $colors.Length]
        }
    }

    # Load settings configuration from JSON file
    $configPath = Join-Path $PSScriptRoot "settings.config.json"
    if (Test-Path $configPath) {
        try {
            $settingsConfig = Get-Content $configPath -Raw | ConvertFrom-Json
            Write-Host "Config loaded successfully." -ForegroundColor Green
        }
        catch {
            Write-Host "Error parsing JSON file: $_" -ForegroundColor Red
            return
        }
    }
    else {
        Write-Host "Config file not found at: $configPath" -ForegroundColor Red
        return
    }

    # Load settings.json
    $settingsJsonPath = "$env:USERPROFILE\MyHomeDesktop\settings.json"
    if (Test-Path $settingsJsonPath) {
        try {
            $settingsJson = Get-Content $settingsJsonPath -Raw | ConvertFrom-Json
            Write-Host "Settings loaded successfully." -ForegroundColor Green
        }
        catch {
            Write-Host "Error parsing settings.json file: $_" -ForegroundColor Red
            return
        }
    }
    else {
        Write-Host "Settings file not found at: $settingsJsonPath" -ForegroundColor Red
        return
    }

    function Show-Menu {
        param (
            [Parameter(Mandatory=$true)]
            [array]$MenuItems,
            [string]$Title = "Menu",
            [bool]$IsMainMenu = $false,
            [int]$MaxWidth = 60
        )

        # Clear-Host
        Write-ColorfulArt $settingsAscii
        Write-Host ("`n" + "=" * $MaxWidth)
        Write-Host $Title.PadRight($MaxWidth) -ForegroundColor Cyan
        Write-Host ("=" * $MaxWidth)

        for ($i = 0; $i -lt $MenuItems.Count; $i++) {
            $menuItem = $MenuItems[$i].PadRight($MaxWidth - 6)
            Write-Host ("[{0,2}] {1}" -f ($i+1), $menuItem)
        }

        if ($IsMainMenu) {
            Write-Host ("[{0,2}] {1}" -f ($MenuItems.Count + 1), "Exit".PadRight($MaxWidth - 6))
        } else {
            Write-Host ("[{0,2}] {1}" -f ($MenuItems.Count + 1), "Back".PadRight($MaxWidth - 6))
        }

        Write-Host ("=" * $MaxWidth)

        do {
            $choice = Read-Host "`nEnter your choice"
        } while (-not ($choice -match '^\d+$' -and [int]$choice -ge 1 -and [int]$choice -le ($MenuItems.Count + 1)))

        return [int]$choice
    }

    function Update-SettingValue {
        param (
            [string]$Category,
            [string]$Setting,
            $ConfigValue,
            $ActualValue
        )

        $valueType = $ConfigValue.type
        $displayName = $ConfigValue.'display-name'
        $currentActualValue = $ActualValue

        Write-ColorfulArt $settingsAscii
        Write-Host "`nUpdating setting: $displayName" -ForegroundColor Cyan
        Write-Host "Current value: $ActualValue" -ForegroundColor Yellow
        Write-Host "Value type: $valueType" -ForegroundColor Yellow

        if ($Category -eq "theme" -and $Setting -eq "default-theme") {
            $newValue = Select-OhMyPoshTheme
            if ($null -eq $newValue) {
                Write-Host "Theme selection cancelled. No changes made." -ForegroundColor Yellow
                return $CurrentValue
            }
        } elseif ($valueType -eq "boolean") {
            do {
                $newValue = Read-Host "Enter new value (true/false)"
            } while ($newValue -notmatch '^(true|false)$')
            $newValue = [System.Convert]::ToBoolean($newValue)
        } elseif ($valueType -eq "string") {
            $newValue = Read-Host "Enter new value"
        } else {
            Write-Host "Unsupported value type. Value not changed." -ForegroundColor Red
            return $CurrentValue
        }

        if ($newValue -ne $currentActualValue) {
            $saveChanges = Read-Host "Do you want to save this change? (y/n)"
            if ($saveChanges -eq 'y') {
                # Update settings.json
                $settingsJson.$Category.$Setting = $newValue
                $settingsJson | ConvertTo-Json -Depth 10 | Set-Content $settingsJsonPath
                Write-Host "settings.json updated successfully." -ForegroundColor Green
        
                # If the setting is the default theme, update setup-omp.ps1
                if ($Category -eq "theme" -and $Setting -eq "default-theme") {
                    $setupOmpPath = "$env:USERPROFILE\MyHomeDesktop\ps-scripts\setup-omp.ps1"
                    $setupOmpContent = Get-Content $setupOmpPath -Raw
                    $updatedSetupOmpContent = $setupOmpContent -replace '(?<=\$ThemeName\s*=\s*")[^"]*', $newValue
                    Set-Content $setupOmpPath $updatedSetupOmpContent
                    Write-Host "setup-omp.ps1 updated with new default theme." -ForegroundColor Green
                }
            } else {
                Write-Host "Change not saved." -ForegroundColor Yellow
            }
        } else {
            Write-Host "No changes made." -ForegroundColor Yellow
        }

        Read-Host "`nPress Enter to continue..."
        return $CurrentValue
    }

    $mainCategories = $settingsConfig.PSObject.Properties.Name

    while ($true) {
        $mainChoice = Show-Menu -MenuItems $mainCategories -Title "MHD Settings Menu" -IsMainMenu $true
        
        # Exit Handling
        if ($mainChoice -eq ($mainCategories.Count + 1)) {
            break  # Exit the script
        }

        $selectedCategory = $mainCategories[$mainChoice - 1]
        $subItems = @($settingsConfig.$selectedCategory.PSObject.Properties.Name)

        while ($true) {
            $subChoice = Show-Menu -MenuItems $subItems -Title "Settings for $selectedCategory" -IsMainMenu $false

            # Go Back Funcionality
            if ($subChoice -eq ($subItems.Count + 1)) {
                break  # Go back to main menu
            }

            $selectedSubItem = $subItems[$subChoice - 1]
            $currentValueConfig = $settingsConfig.$selectedCategory.$selectedSubItem
            $currentValue = $settingsJson.$selectedCategory.$selectedSubItem

            Write-Host "selected category $selectedSubItem"
            Write-Host "current val $currentValueConfig"
            Write-Host "NOT CONFIG $currentValue"


            Update-SettingValue -Category $selectedCategory -Setting $selectedSubItem -ConfigValue $currentValueConfig -ActualValue $currentValue
        }
    }
}