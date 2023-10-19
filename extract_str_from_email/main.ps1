# Arguments
param (
    [string]$jsonPath,
    [string]$outDirPath = ".\out",
    [string]$startTime = "",
    [string]$endTime = ""
)

# Dot sourcing
. .\search_folder.ps1

# Exit as error if no config file
if (-not $jsonPath) {
    Write-Host "Error: Required JSON config is missing."
    exit 1
}

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
$regexPatterns = $config.pattern

$dateStr = Get-Date -Format "yyyyMMddHHmmss"
$outFilePath = "$outDirPath\file_$dateStr.json"
Set-Content -Path $outFilePath -Value $null

# Recursively search for mails in folders
$result = @()
$result = Search-Folder -folder $inbox -outFilePath $outFilePath -regexPatterns $regexPatterns -result $result

# Output the result as a JSON file
$json = $result | ConvertTo-Json -Depth 10
$json | Out-File -FilePath $outFilePath
