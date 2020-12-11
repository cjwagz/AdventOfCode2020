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

$containsgold = [System.Collections.ArrayList]@()
$rulehash.Keys | ForEach-Object {
    if ($rulehash.$_.ContainsKey("shiny gold")) {
        $containsgold.Add($_) | Out-Null
    }
}

do {
    $newlookups = 0
    $newcontainsgold = [System.Collections.ArrayList]@()
    $containsgold | ForEach-Object {
        $goldcontainer = $_
        $rulehash.Keys | ForEach-Object {
            if ($rulehash.$_.ContainsKey("$goldcontainer")) {
                if ($containsgold -notcontains $_) {
                    $newcontainsgold.Add($_) | Out-Null
                    $newlookups++
                }
            }
        }
    }
    $containsgold.AddRange($newcontainsgold) | Out-Null
} until ($newlookups -eq 0)

($containsgold | Sort-Object | Get-Unique).Count