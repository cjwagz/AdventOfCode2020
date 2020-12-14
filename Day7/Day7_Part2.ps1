# 45016 < actual < 45055
$rulehash = @{}
[System.IO.File]::ReadLines("Day7\input.txt") | ForEach-Object {
    $containhash = @{}
    if ($_ -like "*,*") {
        ($_ -split " contain ")[1] -split ", " | ForEach-Object {
            $regex = Select-String -InputObject $_ -Pattern "^([0-9])\s(\w+\s\w+)"
            $containhash.Add("$($regex.Matches.Groups[2].Value)", "$($regex.Matches.Groups[1].Value)")
        }
    }
    elseif ($_ -like "*no other bags.") {
        
    }
    else {
        $regex = ($_ -split " contain ")[1] | Select-String -Pattern "^([0-9])\s(\w+\s\w+)"
        $containhash.Add("$($regex.Matches.Groups[2].Value)", "$($regex.Matches.Groups[1].Value)")
    }
    $rulehash.Add("$((Select-String -InputObject $_ -Pattern "^\w+\s\w+").Matches.Value)", $containhash)
}

$goldcontains = 0
$processhash = $rulehash.'shiny gold'.Clone()
$processlist = $rulehash.'shiny gold'.Keys
$rulehash.'shiny gold'.Values | ForEach-Object { $goldcontains += $_ }

do {
    $newprocesslist = [System.Collections.ArrayList]@()
    $newprocesshash = @{}
    foreach ($process in $processlist) {
        $multiple = $processhash.$process
        $containerlist = $rulehash.$process.Keys
        foreach ($container in $containerlist) {
            $newkey = $container
            $newvalue = [int]$rulehash.$process.$container * $multiple
            $goldcontains += $newvalue
            try {
                $newprocesshash.Add($newkey, $newvalue)
                $newprocesslist.Add($newkey) | Out-Null
            }
            catch {
                $currentnum = $newprocesshash[$newkey]
                $newnum = $currentnum + $newvalue
                $newprocesshash[$newkey] = $newnum
            }
            
        }
    }
    $processlist = $newprocesslist
    $processhash = $newprocesshash.Clone()
} while ($newprocesslist -ne "")
$goldcontains