dir
$name = Split-Path -Path (Get-Location) -Leaf
Write-Host "Starting Launcher Generator"
Start-Process "D:\a\$name\$name\PortableApps.comLauncher\PortableApps.comLauncherGenerator.exe" -ArgumentList "D:\a\$name\$name\$name" -NoNewWindow -Wait
Write-Host "Starting Installer Generator"
Start-Process "D:\a\$name\$name\PortableApps.comInstaller\PortableApps.comInstaller.exe" -ArgumentList "D:\a\$name\$name\$name" -NoNewWindow -Wait
dir
