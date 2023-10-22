# Dot sourcing
. .\search_str.ps1

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

        # Get email bodies and subjects matching the regular expression
        $tmp = Search-Str -mail $mail -regexPatterns $regexPatterns
        if ($tmp) {
            $result += $tmp
        }
    }

    # Recursively search for mails in subfolders
    foreach ($subFolder in $folder.Folders) {
        $result = Search-Folder -folder $subFolder -outFilePath $outFilePath -regexPatterns $regexPatterns -result $result
    }

    return $result
}
