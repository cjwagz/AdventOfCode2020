$map = Get-Content -Path C:\Users\cwagner\Documents\AdventOfCode\Day3\input.txt
[int]$maxy = $map.Count - 1
[int]$maxx = ($map[0].ToCharArray().Count) - 1
[long]$result = 1
[hashtable]$slopes = @{
    1 = @{
        X=1; Y=1
    }
    2 = @{
        X=3; Y=1
    }
    3 = @{
        X=5; Y=1
    }
    4 = @{
        X=7; Y=1
    }
    5 = @{
        X=1; Y=2
    }
}
for ($i = 1; $i -lt 6; $i++) {
    [int]$posx = 0
    [int]$posy = 0
    [int]$trees = 0
    do {
        $posx += $slopes[$i].X
        $posy += $slopes[$i].Y
        if ($posx -gt $maxx) {
            $posx -= ($maxx + 1)
        }
        $y = $map[$posy]
        $x = $y.ToCharArray()[$posx]
        if ($x -eq "#") {
            $trees++
        }
    } until ($posy -eq $maxy)
    $result = $result * $trees
}
$result