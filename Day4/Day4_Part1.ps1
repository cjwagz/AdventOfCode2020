function New-Passport ($passportblock) {
    $passportblock -split " " | ForEach-Object { ($_ -split ":")[0] }
}
function Confirm-Passport ($passportheaders) {
    if (
        ($passportheaders -contains "byr") -and
        ($passportheaders -contains "iyr") -and
        ($passportheaders -contains "eyr") -and
        ($passportheaders -contains "hgt") -and
        ($passportheaders -contains "hcl") -and
        ($passportheaders -contains "ecl") -and
        ($passportheaders -contains "pid")
        ) {
        $global:validpassports++
    }
}
$passportblock = $null
$global:validpassports = 0
[System.IO.File]::ReadLines("C:\Users\cwagner\Documents\AdventOfCode\Day4\input.txt") | ForEach-Object {
    if ($_ -eq "") {
        $passportheaders = New-Passport $passportblock
        Confirm-Passport $passportheaders
        Clear-Variable -Name passportblock
    }
    elseif ($passportblock -eq "") {
        $passportblock += $_
    }
    else {
        $passportblock += (" " + $_)
    }
}
$validpassports