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

    Write-ColorfulArt $settingsAscii

    function Load-Settings {
        $settingsFile = "$env:USERPROFILE\MyHomeDesktop\settings.json"
        if (Test-Path $settingsFile) {
            $loadedSettings = Get-Content $settingsFile | ConvertFrom-Json
            $loadedSettings.PSObject.Properties | ForEach-Object {
                Set-Variable -Name $_.Name -Value $_.Value -Scope Script
            }
        }
    }

    function Save-Settings {
        $settingsFile = "$env:USERPROFILE\MyHomeDesktop\settings.json"
        $settings = @{
            Theme = $Theme
            Startup = $Startup
            Paths = $Paths
            Features = $Features
            Performance = $Performance
        }
        $settings | ConvertTo-Json | Set-Content $settingsFile
        Write-Host "Settings saved to $settingsFile" -ForegroundColor Green
    }

    # Theme Settings
    $Theme = @{
        Default = "amro"
        Path = Join-Path $env:USERPROFILE "MyHomeDesktop\themes\oh-my-posh"
    }

    # Startup Display Settings
    $Startup = @{
        ShowInfo = $true
        WelcomeName = "Dylan"
    }

    # Path Settings
    $Paths = @{
        Projects = "C:\Users\dylan\Projects"
        MyHomeDesktop = "$env:USERPROFILE\MyHomeDesktop"
    }

    # Feature Toggles
    $Features = @{
        GitIntegration = $true
        DockerCommands = $true
        PythonVirtualEnv = $true
    }

    # Performance Settings
    $Performance = @{
        FastStartup = $false
    }

    # Load settings when this function is called
    Load-Settings

    # Export settings as global variables
    Get-Variable Theme, Startup, Paths, Features, Performance | ForEach-Object {
        Set-Variable -Name "global:$($_.Name)" -Value $_.Value -Scope Global
    }

    # Display settings in color
    Write-Host "`nCurrent Settings:" -ForegroundColor Magenta
    Write-Host "═════════════════" -ForegroundColor Magenta

    Write-Host "`nTheme:" -ForegroundColor Yellow
    Write-Host "Default:" -NoNewline -ForegroundColor Cyan; Write-Host " $($Theme.Default)" -ForegroundColor White
    Write-Host "Path:" -NoNewline -ForegroundColor Cyan; Write-Host " $($Theme.Path)" -ForegroundColor White

    Write-Host "`nStartup:" -ForegroundColor Yellow
    Write-Host "Show Info:" -NoNewline -ForegroundColor Cyan; Write-Host " $($Startup.ShowInfo)" -ForegroundColor White
    Write-Host "Welcome Name:" -NoNewline -ForegroundColor Cyan; Write-Host " $($Startup.WelcomeName)" -ForegroundColor White

    Write-Host "`nPaths:" -ForegroundColor Yellow
    Write-Host "Projects:" -NoNewline -ForegroundColor Cyan; Write-Host " $($Paths.Projects)" -ForegroundColor White
    Write-Host "MyHomeDesktop:" -NoNewline -ForegroundColor Cyan; Write-Host " $($Paths.MyHomeDesktop)" -ForegroundColor White

    Write-Host "`nFeatures:" -ForegroundColor Yellow
    Write-Host "Git Integration:" -NoNewline -ForegroundColor Cyan; Write-Host " $($Features.GitIntegration)" -ForegroundColor White
    Write-Host "Docker Commands:" -NoNewline -ForegroundColor Cyan; Write-Host " $($Features.DockerCommands)" -ForegroundColor White
    Write-Host "Python Virtual Env:" -NoNewline -ForegroundColor Cyan; Write-Host " $($Features.PythonVirtualEnv)" -ForegroundColor White

    Write-Host "`nPerformance:" -ForegroundColor Yellow
    Write-Host "Fast Startup:" -NoNewline -ForegroundColor Cyan; Write-Host " $($Performance.FastStartup)" -ForegroundColor White

    Write-Host "`nSettings loaded. Use Save-Settings to save any changes." -ForegroundColor Green

    function Update-WelcomeName {
        $newName = Read-Host "Enter new welcome name"
        $Startup.WelcomeName = $newName
        Write-Host "Welcome name updated to: $newName" -ForegroundColor Green
    }

    function Show-Menu {
        Write-Host "`nMHD Settings Menu:" -ForegroundColor Yellow
        Write-Host "1. Update Welcome Name" -ForegroundColor Cyan
        Write-Host "2. Save Settings" -ForegroundColor Cyan
        Write-Host "3. Exit" -ForegroundColor Cyan
        
        $choice = Read-Host "`nEnter your choice"
        switch ($choice) {
            "1" { Update-WelcomeName; Show-Menu }
            "2" { Save-Settings; Show-Menu }
            "3" { return }
            default { Write-Host "Invalid choice. Try again." -ForegroundColor Red; Show-Menu }
        }
    }

    # Show the menu
    Show-Menu
}