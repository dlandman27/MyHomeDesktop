
# MyHomeDesktop: PowerShell Development Environment

This repository contains configuration files and scripts for managing your development environment across multiple Windows devices using PowerShell and Oh My Posh.

## Directory Structure:

```
MyHomeDesktop/
├── ps-scripts/
│   ├── aliases.ps1
│   ├── settings.config.json
│   ├── settings.ps1
│   ├── setup-omp.ps1
│   ├── startup-display.ps1
│   ├── functions.ps1
│   ├── procfile-template.ps1
│   └── setup-procfile.ps1
├── themes/
│   └── oh-my-posh/
│       ├── 1_shell.omp.json
│       ├── amro.omp.json
│       ├── avit.omp.json
│       └── negligible.omp.json
└── README.md
```

## PowerShell Scripts (ps-scripts/):

1. **aliases.ps1**:  
   Contains custom aliases and functions for Git, navigation, system utilities, Python virtual environments, Docker shortcuts, and more. It also includes helper functions for system information and connection details.

2. **settings.config.json**:  
   Configuration file containing default settings for the environment.
   Also includes the different options that can be edited and their types.

3. **settings.ps1**:  
   Manages the settings for the MyHomeDesktop environment, including theme selection and configuration.

4. **setup-omp.ps1**:  
   Sets up Oh My Posh with a specified theme.

5. **startup-display.ps1**:  
   Provides a colorful welcome message and displays system information when you start PowerShell.

6. **functions.ps1**:  
   Contains the Show-MhdHelp function, which displays all available custom commands.

7. **procfile-template.ps1**:  
   Template for the PowerShell profile, which loads various scripts and sets up Oh My Posh.

8. **setup-procfile.ps1**:  
   Updates the PowerShell profile with the content from the template file.

## Themes (themes/oh-my-posh/):

Contains Oh My Posh theme files: `1_shell.omp.json`, `amro.omp.json`, `avit.omp.json`, and more

## Usage:

1. Clone this repository to your local machine.
2. Set up your PowerShell profile to load the scripts:

    ```powershell
    . "$env:USERPROFILE\MyHomeDesktop\ps-scripts\aliases.ps1"
    . "$env:USERPROFILE\MyHomeDesktop\ps-scripts\settings.ps1"
    . "$env:USERPROFILE\MyHomeDesktop\ps-scripts\setup-omp.ps1"
    . "$env:USERPROFILE\MyHomeDesktop\ps-scripts\startup-display.ps1"
    ```

3. Restart your PowerShell session or reload the profile:

    ```powershell
    . $PROFILE
    ```

4. To see all available custom commands, run:

    ```powershell
    mhd-help
    ```

4. To see and update settings, run:

    ```powershell
    mhd-settings
    ```

## Custom Commands:

- **sysinfo**: Display comprehensive system information
- **connections**: Display Wi-Fi and Bluetooth connection information
- **speedtest**: Run an internet speed test
- **rst-procfile**: Reset PowerShell profile
- **select-theme**: Select and preview Oh My Posh themes
- **set-default-shell**: Set PowerShell to use default shell (no Oh My Posh)
- **mhd-settings**: Manage MyHomeDesktop settings

For a full list of commands, use the `mhd-help` command.

## Customization:

- Modify `ps-scripts/aliases.ps1` to add your own custom aliases and functions.
- Edit theme files in `themes/oh-my-posh/` to customize your Oh My Posh theme.
- Update `ps-scripts/procfile-template.ps1` to change the default PowerShell profile setup.
- Adjust settings using the `mhd-settings` command.

## Contributing:

Feel free to fork this repository and submit pull requests with your improvements or customizations!

## License:

MIT License
