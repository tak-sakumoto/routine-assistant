function Get-HashTableFromStr {
    param(
        $str,
        $delimiterPair=";",
        $delimiterKeyValue="="
    )
    # Create empty hash table
    $hashTable = @{}

    # Split by key/value pairs
    $parts = $str -split $delimiterPair

    # Process each key/value pair
    foreach ($part in $parts) {
        # Split key and value
        $keyValue = $part -split $delimiterKeyValue

        # Add key and value to hash table
        if ($keyValue.Count -eq 2) {
            $hashTable[$keyValue[0]] = $keyValue[1]
        }
        # Add only key to hash table if no value
        else {
            $hashTable[$keyValue[0]] = $null
        }
    }
    return $hashTable
}
