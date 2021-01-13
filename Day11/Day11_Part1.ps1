[System.Collections.ArrayList]$SeatMapStart = Get-Content -Path ".\Day11\input.txt"
$MaxRow = $SeatMapStart.Count - 1
$MaxCol = $SeatMapStart[0].Length - 1
do {
    [System.Collections.ArrayList]$SeatMapEnd = [System.Collections.ArrayList]::new()
    $Change = 0
    $RowPos = 0
    foreach ($Row in $SeatMapStart) {
        $NewRow = [System.Text.StringBuilder]::new()
        $ColPos = 0
        foreach ($Col in $Row.ToCharArray())
        {
            $AdjacentArray = [System.Collections.ArrayList]@()
            if ($Col -ne ".") {
                if ($RowPos -ne 0) {
                    if ($ColPos -ne 0) {
                        $AdjacentArray.Add($SeatMapStart[$RowPos-1].ToCharArray()[$ColPos-1].ToString()) | Out-Null
                    }
                    if ($ColPos -ne $MaxCol) {
                        $AdjacentArray.Add($SeatMapStart[$RowPos-1].ToCharArray()[$ColPos+1].ToString()) | Out-Null
                    }
                    $AdjacentArray.Add($SeatMapStart[$RowPos-1].ToCharArray()[$ColPos].ToString()) | Out-Null
                }
                if ($RowPos -ne $MaxRow) {
                    if ($ColPos -ne 0) {
                        $AdjacentArray.Add($SeatMapStart[$RowPos+1].ToCharArray()[$ColPos-1].ToString()) | Out-Null
                    }
                    if ($ColPos -ne $MaxCol) {
                        $AdjacentArray.Add($SeatMapStart[$RowPos+1].ToCharArray()[$ColPos+1].ToString()) | Out-Null
                    }
                    $AdjacentArray.Add($SeatMapStart[$RowPos+1].ToCharArray()[$ColPos].ToString()) | Out-Null
                }
                if ($ColPos -ne 0) {
                    $AdjacentArray.Add($SeatMapStart[$RowPos].ToCharArray()[$ColPos-1].ToString()) | Out-Null
                }
                if ($ColPos -ne $MaxCol) {
                    $AdjacentArray.Add($SeatMapStart[$RowPos].ToCharArray()[$ColPos+1].ToString()) | Out-Null
                }
            }
            switch ($Col) {
                '#' { 
                    if (($AdjacentArray | Group-Object | Where-Object { $_.Name -eq "#" }).Count -ge 4) {
                        [void]$NewRow.Append("L")
                        $Change++
                    }
                    else { [void]$NewRow.Append("#") }
                }
                'L' {
                    if ($AdjacentArray.Contains("#")) { [void]$NewRow.Append("L") }
                    else {
                        [void]$NewRow.Append("#")
                        $Change++
                    }
                }
                '.' { [void]$NewRow.Append(".") }
            }
            $ColPos++
        }
        $RowPos++
        [void]$SeatMapEnd.Add($NewRow.ToString())
    }
    $SeatMapStart = $SeatMapEnd
} until ($Change -eq 0)
($SeatMapEnd.ToCharArray() | Group-Object | Where-Object { $_.Name -eq "#" }).Count