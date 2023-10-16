# Arguments
param (
    [string]$jsonPath,
    [string]$destFolder = ".\out"
)

# Read the config file
$config = Get-Content -Path $jsonPath | ConvertFrom-Json

# Make a foloder to save output files
if ($config.destFolder) {
    $destFolder = $config.destFolder
}
New-Item -Path $destFolder -ItemType Directory -Force
$destFolder = Convert-Path $destFolder

# Searche for files in the target folder based on the specified depth and search string
$searchFolder = Convert-Path $config.searchFolder
$files = Get-ChildItem -Path $searchFolder -Recurse -Depth $config.depth | Where-Object { $_.Name -like "*$($config.searchString)*" }

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
