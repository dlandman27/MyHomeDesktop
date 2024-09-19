function Write-ColorfulArt {
    param([string]$Text)
    $colors = @("Red","Yellow","Green","Cyan","Blue","Magenta")
    $lines = $Text -split "`n"
    for ($i = 0; $i -lt $lines.Length; $i++) {
        Write-Host $lines[$i] -ForegroundColor $colors[$i % $colors.Length]
    }
}

function Write-ColorfulName {
    param([string]$Name)
    $colors = @("Red","Yellow","Green","Cyan","Blue")
    for ($i = 0; $i -lt $Name.Length; $i++) {
        Write-Host $Name[$i] -ForegroundColor $colors[$i % $colors.Length] -NoNewline
    }
    Write-Host ""
}

# Custom Colorful ASCII Art
$asciiArt = @"
██████╗  ██████╗ ██╗    ██╗███████╗██████╗ ███████╗██╗  ██╗███████╗██╗     ██╗     
██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║     
██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝███████╗███████║█████╗  ██║     ██║     
██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗╚════██║██╔══██║██╔══╝  ██║     ██║     
██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║███████║██║  ██║███████╗███████╗███████╗
╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝                                                                       
"@

Clear-Host

# Load settings
$settingsFile = "$env:USERPROFILE\MyHomeDesktop\settings.json"
if (Test-Path $settingsFile) {
    $settings = Get-Content $settingsFile | ConvertFrom-Json
    $welcomeName = $settings.'bootup-display'.'welcome-name'
    $showSystemInfo = $settings.'bootup-display'.'show-system-info'
    $showInitialBanner = $settings.'bootup-display'.'show-initial-banner'
} else {
    $welcomeName = "User" # Default name if settings file doesn't exist
    $showSystemInfo = $true # Default to showing system info if settings file doesn't exist
}

if ($showInitialBanner){
    Write-ColorfulArt $asciiArt
}

Write-Host "Welcome Back " -ForegroundColor White -NoNewline
Write-ColorfulName $welcomeName

if ($showSystemInfo) {
    # System Information with colors
    $computerInfo = Get-ComputerInfo
    $diskInfo = Get-PSDrive C
    $processes = Get-Process | Measure-Object WorkingSet -Sum

    Write-Host "`nSystem Information:" -ForegroundColor Magenta
    Write-Host "══════════════════" -ForegroundColor Magenta
    Write-Host "OS:" -NoNewline -ForegroundColor Cyan; Write-Host " $($computerInfo.OsName)" -ForegroundColor White
    Write-Host "Version:" -NoNewline -ForegroundColor Cyan; Write-Host " $($computerInfo.OsVersion)" -ForegroundColor White
    Write-Host "CPU:" -NoNewline -ForegroundColor Cyan; Write-Host " $($computerInfo.CsProcessors.Name)" -ForegroundColor White
    Write-Host "RAM:" -NoNewline -ForegroundColor Cyan; Write-Host " $([math]::Round($computerInfo.CsTotalPhysicalMemory / 1GB, 2)) GB" -ForegroundColor White

    $freeSpacePercentage = ($diskInfo.Free / ($diskInfo.Used + $diskInfo.Free)) * 100
    $diskSpaceColor = if ($freeSpacePercentage -lt 20) { "Red" } elseif ($freeSpacePercentage -lt 50) { "Yellow" } else { "Green" }
    Write-Host "Disk Space (C:):" -NoNewline -ForegroundColor Cyan
    Write-Host " $([math]::Round($diskInfo.Free / 1GB, 2)) GB free of $([math]::Round($diskInfo.Used / 1GB + $diskInfo.Free / 1GB, 2)) GB" -ForegroundColor $diskSpaceColor

    Write-Host "Running Processes:" -NoNewline -ForegroundColor Cyan; Write-Host " $((Get-Process).Count)" -ForegroundColor White
    Write-Host "Memory Usage:" -NoNewline -ForegroundColor Cyan; Write-Host " $([math]::Round($processes.Sum / 1GB, 2)) GB" -ForegroundColor White
    Write-Host "══════════════════" -ForegroundColor Magenta
}