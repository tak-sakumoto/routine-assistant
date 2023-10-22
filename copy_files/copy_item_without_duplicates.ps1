 # Copy the files to the destination folder without duplicates of names
function Copy-ItemsWithoutDuplicates {
    param (
        $destFolder,
        $files
    )
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
}