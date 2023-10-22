$prefixes = @("test", "sample")

function Set-TestFiles {
    param(
        [int]$MaxFiles,
        [string]$RootPath = "./test"
    )
    for ($i = 0; $i -lt $MaxFiles; $i++) {
        foreach ($prefix in $prefixes) {
            $filePath = Join-Path -Path $RootPath -ChildPath ($prefix + "_" + $i + ".txt")
            $randomString = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count 64 | ForEach-Object {[char]$_})
            $content =`
                $filePath + "`r`n"`
                + (Get-Date).ToString("yyyy-MM-dd HH:mm:ss.fff")  + "`r`n"`
                +  $randomString + "`r`n"
            Set-Content -Path $filePath -Value $content
        }
    }
}

function Set-TestFilesAndFolders {
    param(
        [int]$MaxFiles,
        [int]$MaxDepth,
        [string]$RootPath = "./test"
    )

    for ($i = 0; $i -lt $MaxFiles; $i++) {
        foreach ($prefix in $prefixes) {
            $folderPath = Join-Path -Path $RootPath -ChildPath ($prefix + "_" + $i)
            New-Item -ItemType Directory -Force -Path $folderPath | Out-Null

            if ($MaxDepth -gt 1) {
                Set-TestFilesAndFolders -MaxFiles $MaxFiles -MaxDepth ($MaxDepth - 1) -RootPath $folderPath
            }

            Set-TestFiles -MaxFiles $MaxFiles -RootPath $folderPath
        }
    }
    Set-TestFiles -MaxFiles $MaxFiles -RootPath $RootPath
}

Set-TestFilesAndFolders -MaxFiles 3 -MaxDepth 3
