# Setup Oh My Posh with a specified theme

param(
    [string]$ThemeName = "pure" # Default theme is "pure"
)

$themePath = Join-Path $env:USERPROFILE "MyHomeDesktop\themes\oh-my-posh"
$themeFile = "$ThemeName.omp.json"
$fullThemePath = Join-Path $themePath $themeFile

# Check if the theme file exists
if (-not (Test-Path $fullThemePath)) {
    Write-Host "Error: Theme file '$themeFile' not found at $fullThemePath" -ForegroundColor Red
    Write-Host "Please ensure the theme file is present in the repository." -ForegroundColor Yellow
    return
}

# Prepare the Oh My Posh initialization command
# Write-Host "Initializing Oh My Posh with $ThemeName theme..." -ForegroundColor Cyan
$configLine = "oh-my-posh init pwsh --config $fullThemePath"

# Execute the Oh My Posh initialization command
Invoke-Expression ($configLine + " | Invoke-Expression")
