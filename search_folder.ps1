function Search-Folder {
    param (
        $folder,
        [string]$outFilePath,
        $regexPatterns,
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
        foreach ($regexPattern in $regexPatterns) {
            $subjectMatches = [regex]::Matches($mail.Subject, $regexPattern.subject)
            $subjectCaptures = if ($subjectMatches) { $subjectMatches | ForEach-Object { if ($_.Groups.Count -gt 1) { $_.Groups[1..($_.Groups.Count - 1)] | ForEach-Object { $_.Value } } else { @() } } } else { @() }

            $bodyMatches = [regex]::Matches($mail.Body, $regexPattern.body)
            $bodyCaptures = if ($bodyMatches) { $bodyMatches | ForEach-Object { if ($_.Groups.Count -gt 1) { $_.Groups[1..($_.Groups.Count - 1)] | ForEach-Object { $_.Value } } else { @() } } } else { @() }

            if ($subjectMatches -and $bodyMatches) {
                $result += @{
                    "ReceivedTime" = $mail.ReceivedTime
                    "Subject" = $subjectCaptures
                    "Body" = $bodyCaptures
                }
            }
        }
    }

    # Recursively search for mails in subfolders
    foreach ($subFolder in $folder.Folders) {
        $result = Search-Folder -folder $subFolder -outFilePath $outFilePath -regexPatterns $regexPatterns -result $result
    }

    return $result
}
