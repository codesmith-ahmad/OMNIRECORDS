function view ($table){
    if (-not $table){<#prompt for table#>}
    $table = $table.ToLower()
    if ($table -eq "Expenses") {viewExpenses}
}

function viewExpenses {

    $x = (sql 'select * from ExpensesView')
    $z = (sql 'select * from ExpensesViewAggr')
        $z.Bill = "`e[7m`e[25m" + $z.Bill + "`e[0m"
        $z.Monthly = "`e[93m" + [math]::Round($z.Monthly,2) + "`$`e[0m"
        $z.Weekly = "`e[93m" + [math]::Round($z.Weekly,2) + "`$`e[0m"
        $z.Daily = "`e[93m" + [math]::Round($z.Daily,2) + "`$`e[0m"
        $z.Note = "`e[2m`e[3mCredit-sourced amounts are not included in sum`e[0m"
    $x = $x + $z

    foreach ($row in $x){
        $row.Deadline = (Get-date $row.Deadline -format "MMM d").toUpper()

        $y = $row.Remains
        $row.Remains = [math]::Round($y)
        if ($y -le 0){
            $row.Remains = "`e[5m`e[31m" + $row.Remains  # Apply blink AND red
            $row.id = "`e[5m" + $row.id + "`e[0m"        # Flash id
            $row.Bill = "`e[5m" + $row.Bill + "`e[0m"    # Flash bill name
        }
        elseif ($y -le 3){$row.Remains = "`e[31m" + $row.Remains}     # Apply red
        elseif ($y -le 5){$row.Remains = "`e[91m" + $row.Remains} # Apply bright red
        elseif ($y -le 7){$row.Remains = "`e[93m" + $row.Remains} # Apply yellow
        
        $row.Remains = "" + $row.Remains + " days`e[0m"

        if ($row.isPaid -eq $false){$row.isPaid = "`e[31mFalse`e[0m"}
        if ($row.isPaid -eq $true) {$row.isPaid = "`e[94mTrue`e[0m"}
    }

    Write-Host "`n`e[7m`e[4m`e[32mEXPENSES`e[27m`e[0m"
    $x | Format-Table

    Write-Host "`n`e[3m`e[93mTO MAKE PAYMENT: `e[4m`e[92mupdate ID`e[24m`e[93m, replace ID by Expenses.id`e[0m`n"
}