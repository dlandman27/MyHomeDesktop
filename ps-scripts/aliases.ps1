# Git Aliases
Set-Alias -Name gti -Value git                       # Correct common typo

function gs { git status }                           # Git status
function ga { git add $args }                        # Git add
function gc { git commit $args }                     # Git commit
function gp { git push $args }                       # Git push
function gl { git log $args }                        # Git log
function gco { git checkout $args }                  # Git checkout
function gd { git diff $args }                       # Git diff

# Navigation Shortcuts
function docs { Set-Location $env:USERPROFILE\Documents }
function desktop { Set-Location $env:USERPROFILE\OneDrive\Desktop }
function mhd { Set-Location $env:USERPROFILE\MyHomeDesktop }

# System Utilities
Set-Alias -Name cls -Value Clear-Host                  # Clear the terminal screen
Set-Alias -Name lt -Value Get-Location                 # Show current location
Set-Alias -Name ls -Value Get-ChildItem                # List files (like `ls` in Linux)
function rld { . $PROFILE }                            # Reload PowerShell profile
Set-Alias -Name notepad -Value "notepad"               # Open Notepad quickly

# Python Virtual Environment
function make-venv { python -m venv $args }            # Create virtual environment
function act { .\venv\Scripts\Activate.ps1 }           # Activate virtual environment

# Docker Shortcuts (optional)
function dps { docker ps $args }                       # List running containers
function dstop { docker stop $args }                   # Stop a container
function drm { docker rm $args }                       # Remove a container
function dbuild { docker-compose build $args }         # Docker compose build
function dup { docker-compose up $args }               # Docker compose up
function ddown { docker-compose down $args }           # Docker compose down

# Function to show all custom commands
function Show-MhdHelp {
    $commands = @{
        "Git" = @{
            "gs" = "git status"; "ga" = "git add"; "gc" = "git commit"
            "gp" = "git push"; "gl" = "git log"; "gco" = "git checkout"
            "gd" = "git diff"
        }
        "Navigation" = @{
            "docs" = "Change to Documents folder"
            "desktop" = "Change to Desktop folder"
            "mhd" = "Change to MyHomeDesktop repo"
        }
        "System" = @{
            "cls" = "Clear screen"; "lt" = "Show location"; "ls" = "List files"
            "rld" = "Reload profile"; "notepad" = "Open Notepad"
        }
        "Python" = @{
            "make-venv" = "Create virtual env"; "act" = "Activate virtual env"
        }
        "Docker" = @{
            "dps" = "docker ps"; "dstop" = "docker stop"; "drm" = "docker rm"
            "dbuild" = "docker-compose build"; "dup" = "docker-compose up"
            "ddown" = "docker-compose down"
        }
        "Custom" = @{
            "mhd-help" = "Show this help message"
            "rst-procfile" = "Reset PowerShell profile"
        }
    }

    Write-Host "MyHomeDesktop Custom Commands:" -ForegroundColor Magenta
    Write-Host "==============================" -ForegroundColor Magenta

    foreach ($category in $commands.Keys) {
        Write-Host "`n$category Commands:" -ForegroundColor Yellow
        $commands[$category].GetEnumerator() | ForEach-Object {
            Write-Host ("  {0,-15} {1}" -f $_.Key, $_.Value) -ForegroundColor Cyan
        }
    }
}

# Function to reset the PowerShell profile
function Reset-Profile {
    $response = Read-Host "Are you sure you want to reset your PowerShell profile? (Y/N)"
    if ($response -eq "Y" -or $response -eq "y") {
        Write-Host "Resetting PowerShell profile..." -ForegroundColor Yellow
        & "$env:USERPROFILE\MyHomeDesktop\ps-scripts\setup-procfile.ps1"
        Write-Host "Profile reset complete."
        . $PROFILE # Reload the PowerShell profile
        Write-Host "PowerShell profile has been reloaded." -ForegroundColor Green
    } else {
        Write-Host "Profile reset cancelled." -ForegroundColor Cyan
    }
}

# Create aliases for the custom functions
Set-Alias -Name mhd-help -Value Show-MhdHelp
Set-Alias -Name rst-procfile -Value Reset-Profile

# Show instructions for viewing custom commands
Write-Host "To see all custom commands, run:" -NoNewline -ForegroundColor Cyan
Write-Host "mhd-help" -ForegroundColor Green