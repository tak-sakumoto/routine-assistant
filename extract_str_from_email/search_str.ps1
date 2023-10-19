function Search-Str {
    param (
        $mail,
        $regexPatterns
    )
    $result = $null
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
    return $result
}