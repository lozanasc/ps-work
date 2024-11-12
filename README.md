# ps-work 🪟

A PowerShell script that helps you manage and quickly access your development projects. It allows you to:
- List all your projects from a designated directory
- Open projects in VS Code with a single command
- Automatically open project-related websites (GitHub, documentation, etc.)
- Easily change the projects directory path

![chrome-capture-2024-10-12 (2)](https://github.com/user-attachments/assets/807a5519-cee5-40b8-8b76-68cd12f3da87)

![image](https://github.com/user-attachments/assets/c3aa65f0-99fc-465b-b9ee-b50466eb901b)


## Features

- 🚀 Quick project access with simple commands
- 📂 Dynamic project directory configuration
- 💻 Automatic VS Code launch
- 🌐 Bulk-open project-related websites
- 🔧 Easy to configure and customize

## Prerequisites

- Windows with PowerShell
- Visual Studio Code (with 'code' command available in terminal)
- A directory containing your projects

## Installation

1. Clone this repository or download `ps-work.ps1`
```powershell
git clone https://github.com/lozanasc/ps-work.git
```

2. Create or edit your PowerShell profile to auto-load the script (optional but recommended):
```powershell
# Check if you have a profile
Test-Path $PROFILE

# Create a profile if it doesn't exist
if (!(Test-Path $PROFILE)) {
    New-Item -Type File -Path $PROFILE -Force
}

# Add this line to your profile (edit path according to where you saved the script)
echo ". 'C:\path\to\ps-work.ps1'" >> $PROFILE
```

3. Load the script:
```powershell
. .\ps-work.ps1
```

## Usage

### Basic Commands

```powershell
# List all projects in your projects directory
work

# Open a specific project
project projectname

# Change the projects directory path
setpath "D:\MyProjects"
```

### Setting Up Project-Related Websites

Create a `related-sites.txt` file in your project folder to automatically open related websites when launching the project. Add one URL per line:

```text
https://github.com/yourusername/yourproject
https://yourproject-docs.com
https://trello.com/yourprojectboard
```

### Example Workflow

1. Set your projects directory:
```powershell
setpath "C:\Users\username\Projects"
```

2. Check available projects:
```powershell
work
```

3. Open a project:
```powershell
project myawesome-project
```

This will:
- Open the project in VS Code
- Open all URLs listed in `related-sites.txt` (if it exists)

## Configuration

The script stores its configuration in `~/.project-config.json`. You can manually edit this file if needed:

```json
{
    "projectPath": "C:\\Users\\username\\Projects"
}
```

## Customization

You can modify the script to:
- Change the default editor from VS Code
- Add support for additional IDE's
- Modify the configuration file location
- Add more project-specific configurations

## Contributing

Feel free to submit issues and pull requests to improve the script!

## License

[MIT License](LICENSE)
