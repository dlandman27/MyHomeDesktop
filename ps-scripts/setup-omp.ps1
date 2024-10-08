# Setup Oh My Posh with the theme specified in settings.json

# Load settings from settings.json
$settingsPath = Join-Path $env:USERPROFILE "MyHomeDesktop\settings.json"
if (Test-Path $settingsPath) {
    $settings = Get-Content $settingsPath | ConvertFrom-Json
    $ThemeName = $settings.theme.'default-theme'
} else {
    Write-Host "Error: settings.json not found. Using default theme." -ForegroundColor Yellow
    $ThemeName = "avit" # Default theme if settings.json is not found
}

$themePath = Join-Path $env:USERPROFILE "MyHomeDesktop\themes\oh-my-posh"
$themeFile = "$ThemeName.omp.json"
$fullThemePath = Join-Path $themePath $themeFile

# Check if the theme file exists
if (-not (Test-Path $fullThemePath)) {
    Write-Host "Error: Theme file '$themeFile' not found at $fullThemePath" -ForegroundColor Red
    Write-Host "Please ensure the theme file is present in the repository." -ForegroundColor Yellow
    return
}

# Check if Oh My Posh is installed
if (-not (Get-Command "oh-my-posh" -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Oh My Posh is not installed. Please install it before running this script." -ForegroundColor Red
    return
}

# Prepare the Oh My Posh initialization command
$configLine = "oh-my-posh init pwsh --config $fullThemePath"

# Execute the Oh My Posh initialization command
Invoke-Expression ($configLine + " | Invoke-Expression")























