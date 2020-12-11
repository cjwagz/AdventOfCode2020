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