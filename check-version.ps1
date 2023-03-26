# Define repository name and API endpoint
$repoName = "Genymobile/scrcpy"
$releasesUri = "https://api.github.com/repos/$repoName/releases/latest"

# Retrieve latest tag from API endpoint
$tag = (Invoke-RestMethod -Uri $releasesUri).tag_name

# Print the tag to the console
Write-Host $tag

# Check if tag contains "alpha", "beta", or "RC"
if ($tag -match "alpha|beta|RC") {
    # If tag contains one of these strings, set SHOULD_BUILD to "no"
    Write-Host "Found alpha, beta, or RC."
    echo "SHOULD_BUILD=no" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
} else {
    # If tag does not contain one of these strings, check if it differs from the local tag
    echo "UPSTREAM_TAG=$tag" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
    $repoName2 = "thosoo/scrcpyPortable"
    $releasesUri2 = "https://api.github.com/repos/$repoName2/releases/latest"
    $local_tag = (Invoke-RestMethod -Uri $releasesUri2).tag_name
    if ($local_tag -ne $tag) {
        # If local tag is different from upstream tag, set SHOULD_BUILD to "yes"
        echo "SHOULD_BUILD=yes" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
    } else {
        # If local tag is the same as upstream tag, set SHOULD_BUILD to "no"
        Write-Host "No changes."
        echo "SHOULD_BUILD=no" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
    }
}
