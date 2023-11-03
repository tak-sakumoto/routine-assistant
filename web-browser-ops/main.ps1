# Arguments
param (
    [string]$url
)

if (-not $url) {
    Write-Host "Error: URL is not set"
    exit 1
}

$driver = Start-SeNewEdge
Enter-SeUrl -Url $url -Driver $driver

exit 0
