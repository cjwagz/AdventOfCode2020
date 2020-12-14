$numbers = Get-Content -Path ".\Day9\input.txt"
$start = 0
$end = 24
$line = 25
do {
    $valid = $false
    $arr = $numbers[$start..$end]
    $arr | ForEach-Object {
        if ($arr -contains ($numbers[$line] - $_)) {
            $Global:valid = $true
            $start++
            $end++
            $line++
        }
    }
} while ($valid)
$numbers[$line]