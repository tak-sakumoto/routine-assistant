function Search-Folder {
    param (
        $folder,
        [string]$outFilePath,
        [string]$bodyRegexPattern,
        $result
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
            $result += @{
                "ReceivedTime" = $mail.ReceivedTime
                "Body" = $bodyMatches
            }
        }
    }

    # Recursively search for mails in subfolders
    foreach ($subFolder in $folder.Folders) {
        Search-Folder -folder $subFolder -outFilePath $outFilePath -bodyRegexPattern $bodyRegexPattern -result $result
    }

    return $result
}
