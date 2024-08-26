# Stop the "java" process if it is running
Get-Process -Name "java" -ErrorAction SilentlyContinue | Stop-Process -Force

# Define the base directory and include a wildcard to match different PyCharm versions
$baseDirectory = "C:\Program Files\JetBrains"
$searchDirectory = "$baseDirectory\PyCharm*"

# Search for uninstall.exe files within the directory and its subdirectories
$uninstallers = Get-ChildItem -Path $searchDirectory -Recurse -Filter "uninstall.exe" -File -ErrorAction SilentlyContinue

# Log the found uninstallers
Write-Host "Found the following uninstallers:"
foreach ($uninstaller in $uninstallers) {
    Write-Host $uninstaller.FullName
}

# If uninstallers are found, execute them silently
foreach ($uninstaller in $uninstallers) {
    try {
        # Start the uninstaller with the silent argument
        Start-Process -FilePath $uninstaller.FullName -ArgumentList "/silent" -NoNewWindow -Wait
    }
    catch {
        # Handle any errors silently
        Write-Error "Failed to run uninstaller: $($uninstaller.FullName). Error: $_"
    }
}

# Check if any uninstallers were found and run
if (-not $uninstallers) {
    Write-Host "No uninstallers found in $searchDirectory."
}
