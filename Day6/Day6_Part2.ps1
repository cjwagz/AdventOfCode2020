function Find-GroupYes {
    param ( $customsform, $people )
    $sortedform = [string]::Join("", ($customsform.ToCharArray() | Sort-Object))
    do {
        $char = [string]$sortedform[0] * $people
        if ($sortedform -match $char) {
            $Global:yesquestions++
        }
        $sortedform = $sortedform -replace $sortedform[0], ""
    } until ($sortedform -eq "")
}
[int]$Global:yesquestions = 0
$customsform = $null
[int]$people = 0
[System.IO.File]::ReadLines("Day6\input.txt") | ForEach-Object {
    if ($_ -eq "") {
        Find-GroupYes $customsform $people
        $people = 0
        $customsform = $null
    }
    else {
        $people++
        $customsform += $_
    }
}
Find-GroupYes $customsform $people
$Global:yesquestions