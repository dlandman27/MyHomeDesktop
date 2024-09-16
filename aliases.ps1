# Git Aliases
Set-Alias -Name gti -Value git                       # Correct common typo
Set-Alias -Name gs -Value git status                 # Git status
Set-Alias -Name ga -Value git add                    # Git add
Set-Alias -Name gc -Value git commit                 # Git commit
Set-Alias -Name gp -Value git push                   # Git push
Set-Alias -Name gl -Value git log                    # Git log
Set-Alias -Name gco -Value git checkout              # Git checkout
Set-Alias -Name gd -Value git diff                   # Git diff

# Navigation Shortcuts
Set-Alias -Name docs -Value "cd C:\Users\dylan\Documents"   # Quick access to Documents folder
Set-Alias -Name desktop -Value "cd C:\Users\dylan\Desktop"  # Quick access to Desktop

# System Utilities
Set-Alias -Name cls -Value Clear-Host                  # Clear the terminal screen
Set-Alias -Name lt -Value Get-Location                 # Show current location
Set-Alias -Name ls -Value Get-ChildItem                # List files (like `ls` in Linux)
Set-Alias -Name rld -Value "$PROFILE | . $_"           # Reload PowerShell profile
Set-Alias -Name notepad -Value "notepad"               # Open Notepad quickly

# Python Virtual Environment
Set-Alias -Name make-venv -Value "python -m venv venv"      # Create virtual environment
Set-Alias -Name act -Value "venv\Scripts\Activate.ps1"      # Activate virtual environment

# Docker Shortcuts (optional)
Set-Alias -Name dps -Value "docker ps"                 # List running containers
Set-Alias -Name dstop -Value "docker stop"             # Stop a container
Set-Alias -Name drm -Value "docker rm"                 # Remove a container
Set-Alias -Name dbuild -Value "docker-compose build"   # Docker compose build
Set-Alias -Name dup -Value "docker-compose up"         # Docker compose up
Set-Alias -Name ddown -Value "docker-compose down"     # Docker compose down