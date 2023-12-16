function view ($table){
    if (-not $table){<#prompt for table#>}
    $table = $table.ToLower()
    if ($table -eq "Expenses") {viewExpenses}
}

function viewExpenses {

    $x = (sql 'select * from ExpensesView')
    $z = (sql 'select * from ExpensesViewAggr')
        $z.Bill = "`e[7m" + $z.Bill + "`e[0m"
        $z.Note = "`e[2m`e[3mCredit-sourced amounts are not included in sum`e[0m"
    $x = $x + $z

    foreach ($row in $x){
        $row.Deadline = (Get-date $row.Deadline -format "MMM d").toUpper()
        $y = $row.Remains
        $row.Remains = [math]::Round($y)
        if ($y -le 0){
            $row.Remains = "`e[5m" + $row.Remains
            $row.id = "`e[5m" + $row.id + "`e[0m"
            $row.Bill = "`e[5m" + $row.Bill + "`e[0m"
        }
        if ($y -le 3){$row.Remains = "`e[31m" + $row.Remains}
        $row.Remains = "" + $row.Remains + " days`e[0m"
    }

    $x | Format-Table
}