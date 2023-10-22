# Arguments
param (
    [string]$jsonPath,
    [string]$destFolder = ".\out",
    [string]$searchFolder,
    [int]$depth = 1,    
    [string]$searchString
)

# Dot sourcing
. .\copy_item_without_duplicates.ps1

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

try {
    # Make a foloder to save output files
    New-Item -Path $destFolder -ItemType Directory -Force
    $destFolder = Convert-Path $destFolder -ErrorAction Stop
    
    # Searche for files in the target folder based on the specified depth and search string
    $searchFolder = Convert-Path $searchFolder -ErrorAction Stop
    $files = Get-ChildItem -Path $searchFolder -Recurse -Depth $depth | Where-Object { $_.Name -like "*$($searchString)*" }

    # Copy the found files to the destination folder
    Copy-ItemsWithoutDuplicates -destFolder $destFolder -files $files
}
catch {
    Write-Host $($_.Exception.Message)
    exit 1
}

Write-Host "Done."
exit 0
