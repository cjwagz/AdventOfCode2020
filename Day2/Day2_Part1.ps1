$passwords = Import-Csv -Path C:\Users\cwagner\Documents\AdventOfCode\Day2\input.txt -Delimiter " " -Header "NumberRequired","LetterRequired","Password"
[int]$validpass = 0
for ($i = 0; $i -lt $passwords.Count; $i++) {
    $num = $passwords[$i].NumberRequired -split "-"
    $minimum = $num[0]
    $maximum = $num[1]
    $letter = $passwords[$i].LetterRequired -replace ":",""
    $count = ([regex]::Matches($passwords[$i].Password, "$letter")).Count
    if (($count -ge $minimum) -and ($count -le $maximum)) {
        $validpass++
    }
}
$validpass