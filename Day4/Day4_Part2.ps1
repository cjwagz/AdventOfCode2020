function Confirm-Passport ($passportblock) {
    $passportlines = $passportblock -split " "
    $byr = $false
    $iyr = $false
    $eyr = $false
    $hgt = $false
    $hcl = $false
    $ecl = $false
    $ppid = $false
    foreach ($item in $passportlines) {
        $line = $item -split ":"
        if ($line[0] -eq "byr")
        {
            if (($line[1] -ge 1920) -and ($line[1] -le 2002)) {
                $byr = $true
            }
        }
        if ($line[0] -eq "iyr")
        {
            if (($line[1] -ge 2010) -and ($line[1] -le 2020)) {
                $iyr = $true
            }
        }
        if ($line[0] -eq "eyr")
        {
            if (($line[1] -ge 2020) -and ($line[1] -le 2030)) {
                $eyr = $true
            }
        }
        if ($line[0] -eq "hgt")
        {
            if ($line[1] -like "*cm") {
                $height = $line[1] -replace '..$'
                if (($height -ge 150) -and ($height -le 193)) {
                    $hgt = $true
                }
            }
            elseif ($line[1] -like "*in") {
                $height = $line[1] -replace '..$'
                if (($height -ge 59) -and ($height -le 76)) {
                    $hgt = $true
                }
            }
        }
        if ($line[0] -eq "hcl")
        {
            if ($line[1] -match '#[0-9a-f]{6}') {
                $hcl = $true
            }
        }
        if ($line[0] -eq "ecl")
        {
            if ($line[1] -match '(amb|blu|brn|gry|grn|hzl|oth)') {
                $ecl = $true
            }
        }
        if ($line[0] -eq "pid")
        {
            if ($line[1] -match '^[0-9]{9}$') {
                $ppid = $true
            }
        }
    }

    if (
        ($byr) -and
        ($iyr) -and
        ($eyr) -and
        ($hgt) -and
        ($hcl) -and
        ($ecl) -and
        ($ppid)
        ) {
        $global:validpassports++
    }
}
$passportblock = $null
$global:validpassports = 0
[System.IO.File]::ReadLines("C:\Users\cwagner\Documents\AdventOfCode\Day4\input.txt") | ForEach-Object {
    if ($_ -eq "") {
        Confirm-Passport $passportblock
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