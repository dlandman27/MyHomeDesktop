# PowerShell Profile Template
$scriptsPath = "$env:USERPROFILE\MyHomeDesktop\ps-scripts"

. "$scriptsPath\functions.ps1" # Custom Functions (must come before the rest)
. "$scriptsPath\startup-display.ps1" # Shows system info and cool powershell info
. "$scriptsPath\aliases.ps1" # Setup Alias For running custom commands
. "$scriptsPath\setup-omp.ps1" -ThemeName "pure" # Update the theme with the prefix from @/themes/oh-my-posh
. "$scriptsPath\settings.ps1" -ThemeName "amro" # Update the theme with the prefix from @/themes/oh-my-posh

# Add any additional setup tasks here...
