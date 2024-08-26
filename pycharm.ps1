Get-Process -Name "java" -ErrorAction SilentlyContinue | Stop-Process -Force

$searchDirectory = "C:\Program Files\JetBrains\PyCharm*\bin\Uninstall.exe"

$uninstallers = Get-ChildItem -Path $searchDirectory -Recurse -Filter "Uninstall.exe" -File -ErrorAction SilentlyContinue

foreach ($uninstaller in $uninstallers) {
    try {
        Start-Process -FilePath $uninstaller.FullName -ArgumentList "/silent" -NoNewWindow -Wait
    }
    catch {
        # Handle any errors silently
    }
}

$pyCharmPaths = @(
    ("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\JetBrains\PyCharm*"),
    ("C:\Program Files\JetBrains\PyCharm*"),
    ("C:\Users\*\AppData\Local\JetBrains\PyCharm*"),
    ("C:\Users\*\AppData\Roaming\JetBrains\PyCharm*")
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
