try {
  Import-Module PsIni
} catch {
  Install-Module -Scope CurrentUser PsIni
  Import-Module PsIni
}
$repoName = "Genymobile/scrcpy"
$releasesUri = "https://api.github.com/repos/$repoName/releases/latest"
$tag = (Invoke-WebRequest $releasesUri | ConvertFrom-Json).tag_name
$tag2 = $tag.replace('v','') #-Replace '-.*',''
Write-Host $tag2
if ($tag2 -match "alpha")
{
  Write-Host "Found alpha."
  echo "SHOULD_COMMIT=no" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
}
elseif ($tag2 -match "beta")
{
  Write-Host "Found beta."
  echo "SHOULD_COMMIT=no" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
}
elseif ($tag2 -match "RC")
{
  Write-Host "Found Release Candidate."
  echo "SHOULD_COMMIT=no" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
}
else{
    echo "UPSTREAM_TAG=$tag2" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
    $appinfo = Get-IniContent ".\scrcpyPortable\App\AppInfo\appinfo.ini"
    if ($appinfo["Version"]["DisplayVersion"] -ne -join($tag2,".0")){
        $appinfo["Version"]["PackageVersion"]=-join($tag2,".0.0")
        $appinfo["Version"]["DisplayVersion"]=-join($tag2,".0")

        $installer = Get-IniContent ".\scrcpyPortable\App\AppInfo\installer.ini"

        $asset1Pattern = "*scrcpy-win32*"
        $asset1 = (Invoke-WebRequest $releasesUri | ConvertFrom-Json).assets | Where-Object name -like $asset1Pattern
        $asset1Download = $asset1.browser_download_url.replace('%2B','+')
        $installer["DownloadFiles"]["DownloadURL"]=$asset1Download
        $installer["DownloadFiles"]["DownloadName"]=$asset1.name.replace('.zip','')
        $installer["DownloadFiles"]["DownloadFilename"]=$asset1.name

        $asset2Pattern = "*scrcpy-win64*"
        $asset2 = (Invoke-WebRequest $releasesUri | ConvertFrom-Json).assets | Where-Object name -like $asset2Pattern
        $asset2Download = $asset2.browser_download_url.replace('%2B','+')
        $installer["DownloadFiles"]["Download2URL"]=$asset2Download
        $installer["DownloadFiles"]["Download2Name"]=$asset2.name.replace('.zip','')
        $installer["DownloadFiles"]["Download2Filename"]=$asset2.name
        $installer | Out-IniFile -Force -Encoding ASCII -Pretty -FilePath ".\scrcpyPortable\App\AppInfo\installer.ini"

        $appinfo | Out-IniFile -Force -Encoding ASCII -FilePath ".\scrcpyPortable\App\AppInfo\appinfo.ini"

        Write-Host "Bumped to $tag2"
        echo "SHOULD_COMMIT=yes" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
    }
    else{
      Write-Host "No changes."
      echo "SHOULD_COMMIT=no" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
    } 
}
