Get-Process -Name "java" -ErrorAction SilentlyContinue | Stop-Process -Force

$searchDirectory = "C:\Program Files\JetBrains\PyCharm"

# 
$uninstallers = Get-ChildItem -Path $searchDirectory -Recurse -Filter "uninstall.exe" -File -ErrorAction SilentlyContinue

foreach ($uninstaller in $uninstallers) {
    try {
        Start-Process -FilePath $uninstaller.FullName -ArgumentList "/silent" -NoNewWindow -Wait
    }
    catch {
        # Handle any errors silently
    }
}

# Dynamic paths
$userProfile = $env:USERPROFILE
$pyCharmPaths = @(
    (Join-Path -Path $userProfile -ChildPath "AppData\Local\JetBrains\PyCharm"),
    (Join-Path -Path $userProfile -ChildPath "AppData\Roaming\JetBrains\PyCharm")
)

# Remove directories
foreach ($path in $pyCharmPaths) {
    if (Test-Path -Path $path) {
        try {
            Remove-Item -Path $path -Recurse -Force -ErrorAction Stop
        }
        catch {
            # Handle any errors silently
        }
    }
}
