$passwords = Import-Csv -Path C:\Users\cwagner\Documents\AdventOfCode\Day2\input.txt -Delimiter " " -Header "NumberRequired","LetterRequired","Password"
[int]$validpass = 0
for ($i = 0; $i -lt $passwords.Count; $i++) {
    $num = $passwords[$i].NumberRequired -split "-"
    $pos1 = $num[0] - 1
    $pos2 = $num[1] - 1
    $letter = ($passwords[$i].LetterRequired) -replace ":",""
    $passcheck = $passwords[$i].Password.ToCharArray()
    if (($passcheck[$pos1] -eq $letter) -and ($passcheck[$pos2] -eq $letter)) {
    }
    elseif (($passcheck[$pos1] -eq $letter) -or ($passcheck[$pos2] -eq $letter)) {
        $validpass++
    }
}
$validpass