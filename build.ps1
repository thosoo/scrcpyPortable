Get-ChildItem

$name = (Get-Location).Path.Split('\')[-1]
$launcherGeneratorPath = Join-Path "D:\a" $name
$launcherGeneratorPath = Join-Path $launcherGeneratorPath $name
$launcherGeneratorPath = Join-Path $launcherGeneratorPath "PortableApps.comLauncher\PortableApps.comLauncherGenerator.exe"

$installerGeneratorPath = Join-Path "D:\a" $name
$installerGeneratorPath = Join-Path $installerGeneratorPath $name
$installerGeneratorPath = Join-Path $installerGeneratorPath "PortableApps.comInstaller\PortableApps.comInstaller.exe"

Write-Host "Starting Launcher Generator"
Start-Process -FilePath $launcherGeneratorPath -ArgumentList "D:\a\$name\$name\$name" -NoNewWindow -Wait

Write-Host "Starting Installer Generator"
Start-Process -FilePath $installerGeneratorPath -ArgumentList "D:\a\$name\$name\$name" -NoNewWindow -Wait

Get-ChildItem
