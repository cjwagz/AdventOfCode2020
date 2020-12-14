$program = Get-Content "Day8\input.txt"
$instructions = [System.Collections.ArrayList]@()
$accumulator = 0
$line = 0

do {
    $instruction = $program[$line] -split " "
    $instructions.Add($line) | Out-Null
    switch ($instruction[0]) {
        nop { $line++ }
        acc {
            switch (($instruction[1].ToCharArray())[0]) {
                - { $accumulator -= (Select-String -InputObject $instruction[1] -Pattern '[0-9]+').Matches[0].Value }
                + { $accumulator += (Select-String -InputObject $instruction[1] -Pattern '[0-9]+').Matches[0].Value }
            }
            $line++
        }
        jmp {
            switch (($instruction[1].ToCharArray())[0]) {
                - { $line -= (Select-String -InputObject $instruction[1] -Pattern '[0-9]+').Matches[0].Value }
                + { $line += (Select-String -InputObject $instruction[1] -Pattern '[0-9]+').Matches[0].Value }
            }
        }
    }
} until ($instructions -contains $line)
$accumulator