function Get-CapturesArray {
    param (
        $regexMatches
    )
    $captures = if ($regexMatches) {
        $regexMatches | ForEach-Object {
            if ($_.Groups.Count -gt 1) {
                $_.Groups[1..($_.Groups.Count - 1)] | ForEach-Object {
                    $_.Value
                }
            } else {
                @()
            }
        }
    } else {
        @()
    }
    return $captures
}
