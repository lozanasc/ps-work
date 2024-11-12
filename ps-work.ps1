# Configuration file path
$configFile = Join-Path $env:USERPROFILE ".project-config.json"

# Create or load config
if (!(Test-Path $configFile)) {
    @{ projectPath = "C:\Users\lozan\Projects" } | ConvertTo-Json | Set-Content $configFile
}

# Load config
$config = Get-Content $configFile | ConvertFrom-Json

# Function to open project
function Launch-Project {
    param([string]$projectName)
    
    $projectPath = Join-Path $config.projectPath $projectName
    if (!(Test-Path $projectPath)) {
        Write-Host "Project not found: $projectName" -ForegroundColor Red
        return
    }
    
    # Open VS Code
    Write-Host "Opening VSCode..." -ForegroundColor Yellow
    Start-Process code $projectPath
    
    # Check for sites file
    $sitesFile = Join-Path $projectPath "related-sites.txt"
    if (Test-Path $sitesFile) {
        Write-Host "Opening related websites..." -ForegroundColor Yellow
        Get-Content $sitesFile | Where-Object { $_ -match '\S' } | ForEach-Object {
            Start-Process $_
        }
    } else {
        Write-Host "No related-sites.txt found. Create one to automatically open related websites." -ForegroundColor Yellow
    }
}

# Global commands
function global:work {
    $projects = Get-ChildItem -Path $config.projectPath -Directory
    Write-Host "`nProject Path: $($config.projectPath)" -ForegroundColor Blue
    Write-Host "Available projects:" -ForegroundColor Green
    $projects | ForEach-Object { Write-Host "  - $($_.Name)" }
}

function global:project {
    param(
        [Parameter(Mandatory=$true)]
        [string]$projectName
    )
    Launch-Project $projectName
}

function global:setpath {
    param(
        [Parameter(Mandatory=$true)]
        [string]$path
    )
    
    if (!(Test-Path $path)) {
        Write-Host "Invalid path: $path" -ForegroundColor Red
        return
    }
    
    $config.projectPath = $path
    $config | ConvertTo-Json | Set-Content $configFile
    Write-Host "Updated project path to: $path" -ForegroundColor Green
}

# Show initial message
Write-Host @"
Project Launcher loaded!
Commands:
  work - List all projects
  project <name> - Open a project
  setpath <path> - Change projects directory
Current path: $($config.projectPath)
"@ -ForegroundColor Cyan
