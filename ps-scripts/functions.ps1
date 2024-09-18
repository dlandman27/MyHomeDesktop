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
    }

    Write-Host "MyHomeDesktop Custom Commands:" -ForegroundColor Magenta
    Write-Host "==============================" -ForegroundColor Magenta

    foreach ($category in $commands.Keys) {
        Write-Host "`n$category Commands:" -ForegroundColor Yellow
        $commands[$category].GetEnumerator() | ForEach-Object {
            Write-Host ("  {0,-10} {1}" -f $_.Key, $_.Value) -ForegroundColor Cyan
        }
    }
}

# Other functions can be defined here...