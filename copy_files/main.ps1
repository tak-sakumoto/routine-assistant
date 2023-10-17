# Arguments
param (
    [string]$jsonPath,
    [string]$destFolder = ".\out",
    [string]$searchFolder,
    [int]$depth = 1,    
    [string]$searchString
)

# Read the config file
if ($jsonPath) {
    $config = Get-Content -Path $jsonPath | ConvertFrom-Json
    if ($config.destFolder) {
        $destFolder = $config.destFolder
    }
    if ($config.searchFolder) {
        $searchFolder = $config.searchFolder
    }
    if ($config.depth) {
        $depth = $config.depth
    }
    if ($config.searchString) {
        $searchString = $config.searchString
    }
}

# Check required variables
$requiredVars = @($destFolder, $searchFolder, $depth, $searchString)
foreach ($var in $requiredVars) {
    if ([string]::IsNullOrEmpty($var)) {
        Write-Host "Error: Required parameters are missing."
        exit 1
    }
}

# Make a foloder to save output files
New-Item -Path $destFolder -ItemType Directory -Force
$destFolder = Convert-Path $destFolder

# Searche for files in the target folder based on the specified depth and search string
$searchFolder = Convert-Path $searchFolder
$files = Get-ChildItem -Path $searchFolder -Recurse -Depth $depth | Where-Object { $_.Name -like "*$($searchString)*" }

# Copy the found files to the destination folder
$fileCopied = @{}
foreach ($file in $files | Sort-Object CreationTime) {
    # If multiple files with the same name exist, do not copy all but the oldest file
    if ($fileCopied.ContainsKey($file.Name)) {
        Write-Warning "Multiple files with the same name exist: $($file.FullName)"
        continue
    }
    Copy-Item -Path $file.FullName -Destination $destFolder -Recurse
    $fileCopied[$file.Name] = $true
}

Write-Host "Done."
exit 0
