$map = Get-Content -Path C:\Users\cwagner\Documents\AdventOfCode\Day3\input.txt
[int]$maxy = $map.Count - 1
[int]$maxx = ($map[0].ToCharArray().Count) - 1
[int]$posx = 0
[int]$posy = 0
[int]$trees = 0
do {
    $posx += 3
    $posy++
    if ($posx -gt $maxx) {
        $posx -= ($maxx + 1)
    }
    $y = $map[$posy]
    $x = $y.ToCharArray()[$posx]
    if ($x -eq "#") {
        $trees++
    }
} until ($posy -eq $maxy)
$trees