# Dot sourcing
. .\get_captures_array.ps1

function Search-Str {
    param (
        $mail,
        $regexPatterns
    )
    $result = $null
    # Match the email by the given regular expressions
    foreach ($regexPattern in $regexPatterns) {
        $subjectMatches = [regex]::Matches($mail.Subject, $regexPattern.subject)
        $subjectCaptures = Get-CapturesArray -regexMatches $subjectMatches

        $bodyMatches = [regex]::Matches($mail.Body, $regexPattern.body)
        $bodyCaptures = Get-CapturesArray -regexMatches $bodyMatches

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