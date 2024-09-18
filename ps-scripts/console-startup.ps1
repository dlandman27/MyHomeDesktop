# Set the initial directory to your projects folder
# Set-Location "C:\Users\dylan\Projects"  # Adjust this path as needed

# Load custom aliases
# Add your custom aliases here

# Load Oh My Posh theme
$themeFile = "$env:USERPROFILE\MyHomeDesktop\themes\oh-my-posh\pure.omp.json"
if (Test-Path $themeFile) {
    oh-my-posh init pwsh --config $themeFile | Invoke-Expression
} else {
    Write-Warning "Oh My Posh theme file not found: $themeFile"
}

# Add any additional setup tasks you want here...