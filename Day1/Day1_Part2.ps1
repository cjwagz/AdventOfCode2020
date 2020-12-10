$num = Get-Content -Path C:\Users\cwagner\Documents\AdventOfCode\Day1\input.txt
for ($i = 0; $i -lt $num.Count; $i++) {
    $one = 2020 - $num[$i]
    for ($i2 = 0; $i2 -lt $num.Count; $i2++) {
        $two = $one - $num[$i2]
        if ($num -contains $two)
        {
            [int]$final_one = $num[$i]
            [int]$final_two = $num[$i2]
            [int]$final_three = $two
            break
        }
    }
    if ($final_one)
    {
        break
    }
}
$final_one * $final_two * $final_three