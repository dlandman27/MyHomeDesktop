# Path to the template file
$templatePath = "$env:USERPROFILE\MyHomeDesktop\ps-scripts\procfile-template.ps1"

# Path to the PowerShell profile
$profilePath = $PROFILE

# Check if the template file exists
if (!(Test-Path $templatePath)) {
    Write-Error "Template file not found at $templatePath"
    exit 1
}

# Read the template content
$templateContent = Get-Content -Path $templatePath -Raw

# Update the profile with the template content
Set-Content -Path $profilePath -Value $templateContent

Write-Host "Profile updated successfully. Please restart your PowerShell session for changes to take effect."