# Arguments
param (
    $csvPath,
    $sleepSec=1
)

# Dot sourcing
. .\Get-HashTableFromStr.ps1

# Error if the path to the CSV file is not specified
if (-not $csvPath) {
    Write-Host "Error: CSV path is not set"
    exit 1
}

# Launch the browser
$driver = Start-SeNewEdge

# Import CSV a file
$csvData = Import-Csv -Path $csvPath

# Process CSV files one row at a time
foreach ($line in $csvData) {
    # Get command type
    $command = $line.command
    # Get command arguments
    $argTable = Get-HashTableFromStr -str $line.args

    # Process according to the type of command
    switch ($command) {
        # Navigate to a URL
        "url" {
            Enter-SeUrl -Driver $driver -Url $argTable["Url"]
        }
        # Click on an Element/Button
        "click" {
            $element = Find-SeElement -Driver $driver -Id $argTable["Id"]
            Invoke-SeClick -Element $element
        }
        Default {}
    }

    # Sleep
    Start-Sleep -Seconds $sleepSec
}

exit 0
