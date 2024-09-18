# MyHomeDesktop: PowerShell Development Environment

This repository contains configuration files and scripts for managing your development environment across multiple Windows devices using PowerShell and Docker.

## Directory Structure
```
MyHomeDesktop/
├── ps-scripts/
│ ├── aliases.ps1
│ ├── console-startup.ps1
│ ├── first-run.ps1
│ ├── functions.ps1
│ ├── procfile-template.ps1
│ ├── setup.ps1
│ ├── setup-omp.ps1
│ └── setup-procfile.ps1
├── themes/
│ └── oh-my-posh/
│ ├── 1_shell.omp.json
│ ├── amro.omp.json
│ └── avit.omp.json
└── README.md
```
## PowerShell Scripts (ps-scripts/)

### aliases.ps1
Contains custom aliases and functions for Git, navigation, system utilities, Python virtual environments, Docker shortcuts, and more.

Key features:
- Git aliases (gs, ga, gc, gp, etc.)
- Navigation shortcuts (docs, desktop, mhd)
- System utilities (cls, lt, ls, rld)
- Python virtual environment helpers
- Docker shortcuts
- Custom functions (Get-SystemInfo, Get-ConnectionInfo, etc.)

### console-startup.ps1
Sets up the initial PowerShell environment, including:
- Setting the initial directory
- Loading custom aliases
- Loading Oh My Posh theme

### first-run.ps1
Provides a colorful welcome message and displays system information when you start PowerShell.

### functions.ps1
Contains the `Show-MhdHelp` function, which displays all available custom commands.

### procfile-template.ps1
Template for the PowerShell profile, which loads various scripts and sets up Oh My Posh.

### setup.ps1
Installs necessary tools and dependencies using winget:
- Git
- Node.js
- Python

### setup-omp.ps1
Sets up Oh My Posh with a specified theme.

### setup-procfile.ps1
Updates the PowerShell profile with the content from the template file.

## Themes (themes/oh-my-posh/)

Contains Oh My Posh theme files:
- 1_shell.omp.json
- amro.omp.json
- avit.omp.json

## Usage

1. Clone this repository to your local machine.

2. Run the setup script to install necessary tools:
   ```powershell
   .\ps-scripts\setup.ps1
   ```

3. Set up your PowerShell profile:
   ```powershell
   .\ps-scripts\setup-procfile.ps1
   ```

4. Restart your PowerShell session or reload the profile:
   ```powershell
   . $PROFILE
   ```

5. To see all available custom commands, run:
   ```powershell
   mhd-help
   ```

## Custom Commands

- `sysinfo`: Display comprehensive system information
- `connections`: Display Wi-Fi and Bluetooth connection information
- `speedtest`: Run an internet speed test
- `rst-procfile`: Reset PowerShell profile
- `select-theme`: Select and preview Oh My Posh themes
- `set-default-shell`: Set PowerShell to use default shell (no Oh My Posh)

For a full list of commands, use the `mhd-help` command.

## Customization

- Modify `ps-scripts/aliases.ps1` to add your own custom aliases and functions.
- Edit theme files in `themes/oh-my-posh/` to customize your Oh My Posh theme.
- Update `ps-scripts/procfile-template.ps1` to change the default PowerShell profile setup.

## Contributing

Feel free to fork this repository and submit pull requests with your improvements or customizations.

## License

[MIT License](LICENSE)