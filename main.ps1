# Arguments
param (
    [string]$jsonPath,
    [string]$outDirPath = ".\out",
    [string]$startTime = "",
    [string]$endTime = ""
)

# Dot sourcing
. .\search_folder.ps1

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

$dateStr = Get-Date -Format "yyyyMMddHHmmss"
$outFilePath = "$outDirPath\file_$dateStr.txt"
Set-Content -Path $outFilePath -Value $null

# Recursively search for mails in folders
Search-Folder -folder $inbox -outFilePath $outFilePath -bodyRegexPattern $bodyRegexPattern
