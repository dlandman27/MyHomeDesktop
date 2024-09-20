# Git Aliases
Set-Alias -Name gti -Value git
function gs { git status }
function ga { git add $args }
function gc { git commit $args }
function gp { git push $args }
function gl { git log $args }
function gco { git checkout $args }
function gd { git diff $args }

# Navigation Shortcuts
function docs { Set-Location $env:USERPROFILE\Documents }
function desktop { Set-Location $env:USERPROFILE\OneDrive\Desktop }
function mhd { Set-Location $env:USERPROFILE\MyHomeDesktop }

# System Utilities
Set-Alias -Name cls -Value Clear-Host
Set-Alias -Name lt -Value Get-Location
Set-Alias -Name ls -Value Get-ChildItem
Set-Alias -Name notepad -Value "notepad"

# Python Virtual Environment
function make-venv { python -m venv $args }
function act { .\venv\Scripts\Activate.ps1 }

# Docker Shortcuts
function dps { docker ps $args }
function dstop { docker stop $args }
function drm { docker rm $args }
function dbuild { docker-compose build $args }
function dup { docker-compose up $args }
function ddown { docker-compose down $args }

# Custom Functions
function Show-MhdHelp {
    $helpAscii = @"
 __  __ _   _ ____    _   _      _       
|  \/  | | | |  _ \  | | | | ___| |_ __  
| |\/| | |_| | | | | | |_| |/ _ \ | '_ \ 
| |  | |  _  | |_| | |  _  |  __/ | |_) |
|_|  |_|_| |_|____/  |_| |_|\___|_| .__/ 
                                  |_|    
"@

    function Write-ColorfulArt {
        param([string]$Text)
        $colors = @("Red","Yellow","Green","Cyan","Blue","Magenta")
        $lines = $Text -split "`n"
        for ($i = 0; $i -lt $lines.Length; $i++) {
            Write-Host $lines[$i] -ForegroundColor $colors[$i % $colors.Length]
        }
    }

    Write-ColorfulArt $helpAscii

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
            "sysinfo" = "Display comprehensive system information"
            "connections" = "Display Wi-Fi and Bluetooth connection information"
            "speedtest" = "Run an internet speed test"
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
            "mhd-restart" = "Reset PowerShell profile"
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

function Reset-Profile {
    $response = Read-Host "Are you sure you want to reset your PowerShell profile? (Y/N)"
    if ($response -eq "Y" -or $response -eq "y") {
        Write-Host "Resetting PowerShell profile..." -ForegroundColor Yellow
        & "$env:USERPROFILE\MyHomeDesktop\ps-scripts\setup-procfile.ps1"
        Write-Host "Profile reset complete."
        . $PROFILE
    } else {
        Write-Host "Profile reset cancelled." -ForegroundColor Cyan
    }
}

function Get-SystemInfo {
    $headerColor = "Cyan"
    $categoryColor = "Yellow"
    $infoColor = "White"

    function Write-CategoryInfo($category, $info) {
        Write-Host $category -ForegroundColor $categoryColor -NoNewline
        Write-Host ": $info" -ForegroundColor $infoColor
    }

    Write-Host "System Information" -ForegroundColor $headerColor
    Write-Host "==================" -ForegroundColor $headerColor

    # OS Information
    $os = Get-CimInstance Win32_OperatingSystem
    Write-CategoryInfo "OS" "$($os.Caption) $($os.Version)"
    Write-CategoryInfo "Last Boot" $os.LastBootUpTime

    # CPU Information
    $cpu = Get-CimInstance Win32_Processor
    Write-Host "`nCPU" -ForegroundColor $headerColor
    Write-CategoryInfo "  Model" $cpu.Name
    Write-CategoryInfo "  Cores" $cpu.NumberOfCores
    Write-CategoryInfo "  Logical Processors" $cpu.NumberOfLogicalProcessors

    # Memory Information
    $memory = Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum
    $totalMemoryGB = [math]::Round($memory.Sum / 1GB, 2)
    Write-Host "`nMemory (RAM)" -ForegroundColor $headerColor
    Write-CategoryInfo "  Total" "$totalMemoryGB GB"

    # Disk Information
    Write-Host "`nDisk Information" -ForegroundColor $headerColor
    Get-CimInstance Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | ForEach-Object {
        $freeSpaceGB = [math]::Round($_.FreeSpace / 1GB, 2)
        $totalSpaceGB = [math]::Round($_.Size / 1GB, 2)
        $usedSpaceGB = $totalSpaceGB - $freeSpaceGB
        $usedPercentage = [math]::Round(($usedSpaceGB / $totalSpaceGB) * 100, 2)
        Write-CategoryInfo "  Drive $($_.DeviceID)" "$usedSpaceGB GB / $totalSpaceGB GB ($usedPercentage% used)"
    }

    # Network Information
    Write-Host "`nNetwork Adapters" -ForegroundColor $headerColor
    Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object {$_.IPAddress -ne $null} | ForEach-Object {
        Write-Host "  $($_.Description)" -ForegroundColor $categoryColor
        Write-CategoryInfo "    IP Address" $_.IPAddress[0]
        Write-CategoryInfo "    MAC Address" $_.MACAddress
    }

    # Power Information
    $battery = Get-CimInstance Win32_Battery
    if ($battery) {
        Write-Host "`nBattery" -ForegroundColor $headerColor
        $batteryStatus = switch ($battery.BatteryStatus) {
            1 {"Discharging"}; 2 {"AC Power"}; 3 {"Fully Charged"}; 4 {"Low"}; 5 {"Critical"}
            default {"Unknown"}
        }
        Write-CategoryInfo "  Status" $batteryStatus
        Write-CategoryInfo "  Charge" "$($battery.EstimatedChargeRemaining)%"
    }
}

function Get-ConnectionInfo {
    $headerColor = "Cyan"
    $categoryColor = "Yellow"
    $infoColor = "White"
    $warningColor = "Red"

    function Write-CategoryInfo($category, $info, $color = $infoColor) {
        Write-Host $category -ForegroundColor $categoryColor -NoNewline
        Write-Host ": " -ForegroundColor $categoryColor -NoNewline
        Write-Host $info -ForegroundColor $color
    }

    Write-Host "Connection Information" -ForegroundColor $headerColor
    Write-Host "======================`n" -ForegroundColor $headerColor

    # Wi-Fi Information
    Write-Host "Wi-Fi Connections" -ForegroundColor $headerColor
    $wifiConnections = Get-NetAdapter | Where-Object { $_.Name -like "*Wi-Fi*" -and $_.Status -eq "Up" }
    
    if ($wifiConnections) {
        foreach ($wifi in $wifiConnections) {
            $profile = Get-NetConnectionProfile -InterfaceAlias $wifi.Name
            $ssid = (netsh wlan show interfaces | Select-String 'SSID' | ForEach-Object { $_.ToString().Trim() -replace 'SSID\s+:\s+', '' } | Select-Object -First 1)
            
            Write-CategoryInfo "  Interface" $wifi.Name
            Write-CategoryInfo "  Status" $wifi.Status
            Write-CategoryInfo "  SSID" $ssid
            Write-CategoryInfo "  IP Address" (Get-NetIPAddress -InterfaceAlias $wifi.Name -AddressFamily IPv4).IPAddress
            Write-CategoryInfo "  Network Category" $profile.NetworkCategory
            Write-Host ""
        }
    } else {
        Write-CategoryInfo "  Status" "No active Wi-Fi connections" $warningColor
    }

    # Bluetooth Information
    Write-Host "Bluetooth Devices" -ForegroundColor $headerColor
    $bluetoothRadios = Get-PnpDevice | Where-Object { $_.Class -eq "Bluetooth" }
    
    if ($bluetoothRadios) {
        foreach ($radio in $bluetoothRadios) {
            Write-CategoryInfo "  Radio" $radio.FriendlyName
            Write-CategoryInfo "  Status" $radio.Status
        }

        $bluetoothDevices = Get-PnpDevice | Where-Object { $_.Class -eq "Bluetooth" -and $_.Problem -eq 0 -and $_.Status -eq "OK" }
        if ($bluetoothDevices) {
            Write-Host "`n  Connected Devices:" -ForegroundColor $categoryColor
            foreach ($device in $bluetoothDevices) {
                Write-Host "    - $($device.FriendlyName)" -ForegroundColor $infoColor
            }
        } else {
            Write-CategoryInfo "  Connected Devices" "No devices connected" $warningColor
        }
    } else {
        Write-CategoryInfo "  Status" "No Bluetooth radio detected" $warningColor
    }
}

# Create aliases for the custom functions
Set-Alias -Name mhd-help -Value Show-MhdHelp
Set-Alias -Name mhd-restart -Value Reset-Profile
Set-Alias -Name sysinfo -Value Get-SystemInfo
Set-Alias -Name connections -Value Get-ConnectionInfo
Set-Alias -Name speedtest -Value Test-InternetSpeed

# Show instructions for viewing custom commands
Write-Host "To see all custom commands, run:" -NoNewline -ForegroundColor Cyan
Write-Host " mhd-help" -ForegroundColor Green