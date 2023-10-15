function Search-Folder {
    param (
        $folder,
        [string]$outFilePath,
        [string]$subjectRegexPattern,
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

        # Match the email by the given regular expressions
        $subjectMatches = [regex]::Matches($mail.Subject, $subjectRegexPattern)
        $bodyMatches = [regex]::Matches($mail.Body, $bodyRegexPattern)
        if ($subjectMatches -and $bodyMatches) {
            $result += @{
                "ReceivedTime" = $mail.ReceivedTime
                "Subject" = $subjectMatches
                "Body" = $bodyMatches
            }
        }
    }

    # Recursively search for mails in subfolders
    foreach ($subFolder in $folder.Folders) {
        Search-Folder -folder $subFolder -outFilePath $outFilePath -subjectRegexPattern $subjectRegexPattern -bodyRegexPattern $bodyRegexPattern -result $result
    }

    return $result
}
