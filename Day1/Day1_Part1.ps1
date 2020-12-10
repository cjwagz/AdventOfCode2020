$num = Get-Content -Path C:\Users\cwagner\Documents\AdventOfCode\Day1\input.txt
for ($i = 0; $i -lt $num.Count; $i++) {
    [int]$find = 2020 - $num[$i]
    if ($num -contains $find)
    {
        [int]$num_found = $num[$i]
        break
    }
}
$find * $num_found