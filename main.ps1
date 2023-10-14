# Arguments
param (
    [string]$jsonPath,
    [string]$outDirPath = ".\out",
    [string]$startTime = "",
    [string]$endTime = ""
)

# Read the config file
$config = Get-Content -Path $jsonPath | ConvertFrom-Json

# Make a foloder to save output files
New-Item -Path $outDirPath -ItemType Directory -Force
$outDirPath = Convert-Path $outDirPath

# Get an Outlook object
$outlook = New-Object -ComObject Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")

# Get the inbox
$inbox = $namespace.GetDefaultFolder(6)

# Regex patterns
$bodyRegexPattern = $config.pattern.body
#$subjectRegexPattern = $config.pattern.subject

Set-Content -Path "$outDirPath\file.txt" -Value $null

foreach ($mail in $inbox.Items) {
    if ($startTime.Trim().Length -ne 0 -and $mail.ReceivedTime -lt $startTime) {
        continue
    }
    if ($endTime.Trim().Length -ne 0 -and $mail.ReceivedTime -gt $endTime) {
        continue
    }

    $bodyMatches = [regex]::Matches($mail.Body, $bodyRegexPattern)
    if ($bodyMatches) {
        $line = $bodyMatches
        Add-Content -Path "$outDirPath\file.txt" -Value $line
    }
}
