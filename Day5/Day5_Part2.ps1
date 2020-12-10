function Limit-BoardingPass {
    param ( $range, [switch]$Upper, [switch]$Lower )
    [int]$midpoint = $range.Count / 2
    if($Upper)
    {
        $r0 = $range[$midpoint]
        $r1 = $range[$range.GetUpperBound(0)]
    }
    if($Lower)
    {
        $r0 = $range[0]
        $r1 = $range[$midpoint] - 1
    }
    return $r0..$r1
}
function Find-Seat {
    param ( $seatIDs )
    for ($i = 0; $i -lt 1000; $i++) {
        $higher = $false
        $lower = $false
        if ($i -notin $seatIDs) {
            if (($i + 1) -in $seatIDs) {
                $higher = $true
            }
            if (($i - 1) -in $seatIDs) {
                $lower = $true
            }
        }
        if ($higher -and $lower) {
            return $i
        }
    }
}
$boardingpasses = Get-Content -Path .\Day5\input.txt
$seatIDs = [System.Collections.ArrayList]@()
foreach ($item in $boardingpasses) {
    $range = 0..127
    for ($i = 0; $i -lt 7; $i++) {
        switch ($item[$i]) {
            "F" { $range = Limit-BoardingPass $range -Lower }
            "B" { $range = Limit-BoardingPass $range -Upper }
        }
    }
    $row = $range[0]

    $range = 0..7
    for ($i = 7; $i -lt 10; $i++) {
        switch ($item[$i]) {
            "L" { $range = Limit-BoardingPass $range -Lower }
            "R" { $range = Limit-BoardingPass $range -Upper }
        }
    }
    $column = $range[0]
    $seatIDs.Add(($row * 8) + $column) | Out-Null
}
Find-Seat $seatIDs