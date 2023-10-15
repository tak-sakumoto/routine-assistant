function Search-Folder {
    param (
        $folder,
        [string]$outFilePath,
        [string]$bodyRegexPattern
    )

    # Search for mails in the currently referenced folder
    foreach ($mail in $folder.Items) {
        if ($startTime.Trim().Length -ne 0 -and $mail.ReceivedTime -lt $startTime) {
            continue
        }
        if ($endTime.Trim().Length -ne 0 -and $mail.ReceivedTime -gt $endTime) {
            continue
        }

        # Match the email by the given regular expression
        $bodyMatches = [regex]::Matches($mail.Body, $bodyRegexPattern)
        if ($bodyMatches) {
            $line = $bodyMatches
            Add-Content -Path $outFilePath -Value $line
        }
    }

    # Recursively search for mails in subfolders
    foreach ($subFolder in $folder.Folders) {
        Search-Folder -folder $subFolder -outFilePath $outFilePath -bodyRegexPattern $bodyRegexPattern
    }
}
