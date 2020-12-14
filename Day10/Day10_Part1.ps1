$adapters = Get-Content -Path ".\Day10\input.txt" | ForEach-Object { [int]::Parse($_) } | Sort-Object
$jolts = 0
$j1 = 0
$j3 = 1
foreach ($adapter in $adapters) {
    "Jolts: $jolts"
    "Adapter: $adapter"
    switch ($adapter-$jolts) {
        1 { $j1++; "+1"}
        3 { $j3++; "+3"}
    }
    $jolts = $adapter
}
$j1 * $j3