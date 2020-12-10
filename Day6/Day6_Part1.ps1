[int]$Global:yesquestions = 0
$customsform = $null
[System.IO.File]::ReadLines("Day6\input.txt") | ForEach-Object {
    if ($_ -eq "") {
        $Global:yesquestions += ($customsform.GetEnumerator() | Sort-Object | Get-Unique).Count
        $customsform = $null
    }
    else {
        $customsform += $_
    }
}
$Global:yesquestions += ($customsform.GetEnumerator() | Sort-Object | Get-Unique).Count
$Global:yesquestions